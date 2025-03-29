//
//  Tap - Finished.swift
//  Cork
//
//  Created by David Bureš on 05.12.2023.
//

import SwiftUI
import CorkShared

struct AddTapFinishedView: View
{
    @EnvironmentObject var availableTaps: TapTracker

    let requestedTap: String

    var body: some View
    {
        ComplexWithIcon(systemName: "checkmark.seal")
        {
            DisappearableSheet
            {
                HeadlineWithSubheadline(
                    headline: "add-tap.complete-\(requestedTap)",
                    subheadline: "add-tap.complete.description",
                    alignment: .leading
                )
                .fixedSize(horizontal: true, vertical: true)
                .onAppear
                {
                    withAnimation
                    {
                        availableTaps.addedTaps.prepend(BrewTap(name: requestedTap))
                    }

                    /// Remove that one element of the array that's empty for some reason
                    availableTaps.addedTaps.removeAll(where: { $0.name == "" })

                    AppConstants.shared.logger.info("Available taps: \(availableTaps.addedTaps, privacy: .public)")
                }
                .task
                { // Force-load the packages from the new tap
                    AppConstants.shared.logger.info("Will update packages")
                    await shell(AppConstants.shared.brewExecutablePath, ["update"])
                }
            }
        }
    }
}
