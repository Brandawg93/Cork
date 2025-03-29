//
//  Cached Download Deletion Error.swift
//  Cork
//
//  Created by David Bureš - P on 20.01.2025.
//

import Foundation

enum CachedDownloadDeletionError: LocalizedError
{
    case couldNotReadContentsOfCachedFormulaeDownloadsFolder(associatedError: String)

    case couldNotReadContentsOfCachedCasksDownloadsFolder(associatedError: String)

    case couldNotReadContentsOfCachedDownloadsFolder(associatedError: String)

    var errorDescription: String?
    {
        switch self
        {
        case .couldNotReadContentsOfCachedFormulaeDownloadsFolder:
            return String(localized: "error.cache-deletion.could-not-read-contents-of-cached-formulae-downloads-folder")
        case .couldNotReadContentsOfCachedCasksDownloadsFolder:
            return String(localized: "error.cache-deletion.could-not-read-contents-of-cached-casks-downloads-folder")
        case .couldNotReadContentsOfCachedDownloadsFolder:
            return String(localized: "error.cache-deletion.could-not-read-contents-of-cached-downloads-folder")
        }
    }
}
