//
//  Package Synchronization Error.swift
//  Cork
//
//  Created by David Bureš - P on 15.01.2025.
//

import Foundation

enum PackageSynchronizationError: LocalizedError
{
    case synchronizationReturnedNil
    
    var errorDescription: String?
    {
        switch self
        {
        case .synchronizationReturnedNil:
            return String(localized: "error.package-synchronization.returned-nil")
        }
    }
}
