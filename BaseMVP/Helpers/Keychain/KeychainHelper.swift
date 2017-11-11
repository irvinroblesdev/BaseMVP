//
//  KeychainHelper.swift
//  BaseMVP
//
//  Created by Irvin Robles on 10/17/17.
//  Copyright © 2017 Irvin Robles. All rights reserved.
//

import Foundation

enum KeychainError: Error {
  case InvalidInput                      // If the value cannot be encoded as NSData
  case OperationUnimplemented         // -4 | errSecUnimplemented
  case InvalidParam                     // -50 | errSecParam
  case MemoryAllocationFailure         // -108 | errSecAllocate
  case TrustResultsUnavailable         // -25291 | errSecNotAvailable
  case AuthFailed                       // -25293 | errSecAuthFailed
  case DuplicateItem                   // -25299 | errSecDuplicateItem
  case ItemNotFound                    // -25300 | errSecItemNotFound
  case ServerInteractionNotAllowed    // -25308 | errSecInteractionNotAllowed
  case DecodeError                      // - 26275 | errSecDecode
  case Unknown(Int)                    // Another error code not defined
}

class OKKeychainHelper {
  public static func queryData(itemKey: String) throws -> AnyObject? {
    let queryLoad: [String: AnyObject] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: itemKey as AnyObject,
      kSecReturnData as String: kCFBooleanTrue,
      kSecMatchLimit as String: kSecMatchLimitOne
    ]
    var result: AnyObject?
    let resultCodeLoad = withUnsafeMutablePointer(to: &result) {
      SecItemCopyMatching(queryLoad as CFDictionary, UnsafeMutablePointer($0))
    }
    
    if let err = mapResultCode(result: resultCodeLoad) {
      throw err
    }
    
    guard let resultVal = result as? NSData, let keyValue = NSString(data: resultVal as Data, encoding: String.Encoding.utf8.rawValue) as? String else {
      print("KeychainManager: Error parsing keychain result: \(resultCodeLoad)")
      return nil
    }
    return keyValue as AnyObject
  }
  
  public static func updateData(itemKey:String, itemValue:String) throws {
    guard let valueData = itemValue.data(using: String.Encoding.utf8) else {
      throw KeychainError.InvalidInput
    }
    
    let updateQuery: [String: AnyObject] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: itemKey as AnyObject
    ]
    
    let updateAttributes : [String:AnyObject] = [
      kSecValueData as String: valueData as AnyObject
    ]
    
    if SecItemCopyMatching(updateQuery as CFDictionary, nil) == noErr {
      let updateResultCode = SecItemUpdate(updateQuery as CFDictionary, updateAttributes as CFDictionary)
      if let err = mapResultCode(result: updateResultCode) {
        throw err
      } else {
        print("KeychainManager: Successfully updated data")
      }
    }
  }
  
  public static func deleteData(itemKey:String) throws {
    let queryDelete: [String: AnyObject] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: itemKey as AnyObject
    ]
    
    let resultCodeDelete = SecItemDelete(queryDelete as CFDictionary)
    
    if let err = mapResultCode(result: resultCodeDelete) {
      throw err
    } else {
      print("KeychainManager: Successfully deleted data")
    }
  }
  
  public static func addData(itemKey:String, itemValue:String) throws {
    guard let valueData = itemValue.data(using: String.Encoding.utf8) else {
      throw KeychainError.InvalidInput
    }
    
    let queryAdd: [String: AnyObject] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: itemKey as AnyObject,
      kSecValueData as String: valueData as AnyObject,
      kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
    ]
    let resultCode:OSStatus = SecItemAdd(queryAdd as CFDictionary, nil)
    
    if let err = mapResultCode(result: resultCode) {
      throw err
    } else {
      print("KeychainManager: Item added successfully")
    }
  }

  class func mapResultCode(result: OSStatus) -> KeychainError? {
    switch result {
    case 0:
      return nil
    case -4:
      return .OperationUnimplemented
    case -50:
      return .InvalidParam
    case -108:
      return .MemoryAllocationFailure
    case -25291:
      return .TrustResultsUnavailable
    case -25293:
      return .AuthFailed
    case -25299:
      return .DuplicateItem
    case -25300:
      return .ItemNotFound
    case -25308:
      return .ServerInteractionNotAllowed
    case -26275:
      return .DecodeError
    default:
      return .Unknown(result.hashValue)
    }
  }
}
