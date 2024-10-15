//
//  Taps Section.swift
//  Cork
//
//  Created by David Bureš on 03.06.2023.
//

import SwiftUI
import CorkShared

struct TapsSection: View
{
    @Environment(AppState.self) var appState: AppState
    @EnvironmentObject var availableTaps: AvailableTaps

    let searchText: String

    var body: some View
    {
        Section("sidebar.section.added-taps")
        {
            if !availableTaps.addedTaps.isEmpty
            {
                ForEach(displayedTaps)
                { tap in
                    NavigationLink(value: NavigationTargetMainWindow.tap(tap))
                    {
                        Text(tap.name)
                        
                        if tap.isBeingModified
                        {
                            Spacer()
                            
                            ProgressView()
                                .frame(height: 5)
                                .scaleEffect(0.5)
                        }
                    }
                    .contextMenu
                    {
                        Button
                        {
                            Task(priority: .userInitiated)
                            {
                                AppConstants.logger.debug("Would remove \(tap.name, privacy: .public)")

                                try await removeTap(name: tap.name, availableTaps: availableTaps, appState: appState, shouldApplyUninstallSpinnerToRelevantItemInSidebar: true)
                            }
                        } label: {
                            Text("sidebar.section.added-taps.contextmenu.remove-\(tap.name)")
                        }
                    }
                }
            }
            else
            {
                ProgressView()
            }
        }
    }

    private var displayedTaps: [BrewTap]
    {
        if searchText.isEmpty || searchText.contains("#")
        {
            return availableTaps.addedTaps
        }
        else
        {
            return availableTaps.addedTaps.filter { $0.name.contains(searchText) }
        }
    }
}
