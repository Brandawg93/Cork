//
//  Outdated Packages.swift
//  Cork
//
//  Created by David Bureš on 06.10.2023.
//

import SwiftUI

struct OutdatedPackagesBox: View
{
    @Environment(AppState.self) var appState: AppState
    @EnvironmentObject var outdatedPackageTracker: OutdatedPackageTracker

    @Binding var isOutdatedPackageDropdownExpanded: Bool

    let errorOutReason: String?

    var body: some View
    {
        if let errorOutReason
        {
            LoadingOfOutdatedPackagesFailedListBox(errorOutReason: errorOutReason)
        }
        else
        {
            if appState.isCheckingForPackageUpdates
            {
                OutdatedPackageLoaderBox()
            }
            else if outdatedPackageTracker.displayableOutdatedPackages.isEmpty
            {
                NoUpdatesAvailableBox()
            }
            else
            {
                OutdatedPackageListBox(isDropdownExpanded: $isOutdatedPackageDropdownExpanded)
            }
        }
    }
}
