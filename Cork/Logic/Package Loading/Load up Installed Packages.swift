//
//  Load up Installed Packages.swift
//  Cork
//
//  Created by David Bureš on 11.02.2023.
//

import CorkShared
import Foundation

@MainActor
func loadUpPackages(whatToLoad: PackageType, appState: AppState) async -> Set<BrewPackage>
{
    AppConstants.logger.info("Started \(whatToLoad == .formula ? "Formula" : "Cask", privacy: .public) loading task at \(Date(), privacy: .public)")

    var contentsOfFolder: Set<BrewPackage> = .init()

    do
    {
        switch whatToLoad
        {
        case .formula:
            contentsOfFolder = try await loadPackagesFromFilesystem(targetFolder: AppConstants.brewCellarPath)
        case .cask:
            contentsOfFolder = try await loadPackagesFromFilesystem(targetFolder: AppConstants.brewCaskPath)
        }
    }
    catch let packageLoadingError as PackageLoadingError
    {
        switch packageLoadingError
        {
        case .failedWhileLoadingPackages:
            appState.showAlert(errorToShow: .couldNotLoadAnyPackages(packageLoadingError))
        case .failedWhileLoadingCertainPackage(let offendingPackage, let offendingPackageURL, let failureReason):
            appState.showAlert(errorToShow: .couldNotLoadCertainPackage(offendingPackage, offendingPackageURL, failureReason: failureReason))
        case .packageDoesNotHaveAnyVersionsInstalled(let offendingPackage):
            appState.showAlert(errorToShow: .installedPackageHasNoVersions(corruptedPackageName: offendingPackage))
        case .packageIsNotAFolder(let offendingFile, let offendingFileURL):
            appState.showAlert(errorToShow: .installedPackageIsNotAFolder(itemName: offendingFile, itemURL: offendingFileURL))
        }
    }
    catch
    {
        print("Something got completely fucked up while loading packages")
    }

    AppConstants.logger.info("Finished \(whatToLoad == .formula ? "Formula" : "Cask", privacy: .public) loading task at \(Date(), privacy: .auto)")

    return contentsOfFolder
}
