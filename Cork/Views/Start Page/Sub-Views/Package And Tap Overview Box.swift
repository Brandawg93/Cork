//
//  Package And Tap Status Box.swift
//  Cork
//
//  Created by David Bureš on 05.04.2023.
//

import SwiftUI
import CorkShared

struct PackageAndTapOverviewBox: View
{
    @AppStorage("displayOnlyIntentionallyInstalledPackagesByDefault") var displayOnlyIntentionallyInstalledPackagesByDefault: Bool = true

    @EnvironmentObject var brewData: BrewDataStorage
    @EnvironmentObject var availableTaps: TapTracker

    var body: some View
    {
        VStack(alignment: .leading)
        {
            GroupBoxHeadlineGroup(
                image: "terminal",
                title: LocalizedStringKey("start-page.installed-formulae.count-\(displayOnlyIntentionallyInstalledPackagesByDefault ? brewData.successfullyLoadedFormulae.filter(\.installedIntentionally).count : brewData.installedFormulae.count)"),
                mainText: "start-page.installed-formulae.description",
                animateNumberChanges: true
            )
            .contextMenu
            {
                Button
                {
                    AppConstants.shared.brewCellarPath.revealInFinder(.openTargetItself)
                } label: {
                    Text("action.reveal-in-finder")
                }
            }

            Divider()

            GroupBoxHeadlineGroup(
                image: "macwindow",
                title: LocalizedStringKey("start-page.installed-casks.count-\(brewData.installedCasks.count)"),
                mainText: "start-page.installed-casks.description",
                animateNumberChanges: true
            )
            .contextMenu
            {
                Button
                {
                    AppConstants.shared.brewCaskPath.revealInFinder(.openTargetItself)
                } label: {
                    Text("action.reveal-in-finder")
                }
            }

            Divider()

            GroupBoxHeadlineGroup(
                image: "spigot",
                title: LocalizedStringKey("start-page.added-taps.count-\(availableTaps.addedTaps.count)"),
                mainText: "start-page.added-taps.description",
                animateNumberChanges: true
            )
            .contextMenu
            {
                Button
                {
                    AppConstants.shared.tapPath.revealInFinder(.openTargetItself)
                } label: {
                    Text("action.reveal-in-finder")
                }
            }
        }
    }
}
