//
//  Package Loading Error.swift
//  Cork
//
//  Created by David Bureš on 10.11.2024.
//

import Foundation

enum PackageLoadingError: LocalizedError
{
    /// When attempting to get the list of raw URLs from the folder containing the packages, the function for loading packages returned nil, therefore, an error occured
    case couldNotReadContentsOfParentFolder(failureReason: String)
    case failedWhileLoadingPackages(failureReason: String?)
    case failedWhileLoadingCertainPackage(String, URL, failureReason: String, associatedError: Error?)
    case packageDoesNotHaveAnyVersionsInstalled(String)
    case packageIsNotAFolder(String, URL)

    var errorDescription: String?
    {
        switch self
        {
        case .couldNotReadContentsOfParentFolder(let failureReason):
            return String(localized: "error.package-loading.could-not-read-contents-of-parent-folder.\(failureReason)")
        case .failedWhileLoadingPackages(let failureReason):
            if let failureReason
            {
                return String(localized: "error.package-loading.could-not-load-packages.\(failureReason)")
            }
            else
            {
                return String(localized: "error.package-loading.could-not-load-packages")
            }
        case .failedWhileLoadingCertainPackage(let string, let uRL, let failureReason, let associatedError):
            return String(localized: "error.package-loading.could-not-load-\(string)-at-\(uRL.absoluteString)-because-\(failureReason)", comment: "Couldn't load package (package name) at (package URL) because (failure reason)")
        case .packageDoesNotHaveAnyVersionsInstalled(let string):
            return String(localized: "error.package-loading.\(string)-does-not-have-any-versions-installed")
        case .packageIsNotAFolder(let string, _):
            return String(localized: "error.package-loading.\(string)-not-a-folder", comment: "Package folder in this context means a folder that encloses package versions. Every package has its own folder, and this error occurs when the provided URL does not point to a folder that encloses package versions")
        }
    }
}
