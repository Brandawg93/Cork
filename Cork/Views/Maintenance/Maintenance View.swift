//
//  Maintenance View.swift
//  Cork
//
//  Created by David Bureš on 13.02.2023.
//

import SwiftUI

enum MaintenanceSteps: Hashable
{
    case ready, maintenanceRunning, finished
}

struct MaintenanceView: View
{
    class MaintenanceNavigationManager: ObservableObject
    {
        @Published var navigationPath: NavigationPath = .init()

        func navigate(to screen: MaintenanceSteps)
        {
            self.navigationPath.append(screen)
        }
    }

    @EnvironmentObject var brewData: BrewDataStorage
    @EnvironmentObject var appState: AppState

    @StateObject var navigationManager: MaintenanceNavigationManager = .init()

    @State var shouldPurgeCache: Bool = true
    @State var shouldDeleteDownloads: Bool = true
    @State var shouldUninstallOrphans: Bool = true
    @State var shouldPerformHealthCheck: Bool = false

    @State var numberOfOrphansRemoved: Int = 0

    @State var packagesHoldingBackCachePurge: [String] = .init()

    @State var brewHealthCheckFoundNoProblems: Bool = false

    @State var maintenanceFoundNoProblems: Bool = true

    @State var reclaimedSpaceAfterCachePurge: Int = 0

    @State var forcedOptions: Bool? = false

    var body: some View
    {
        NavigationStack(path: $navigationManager.navigationPath)
        {
            MaintenanceReadyView(
                shouldUninstallOrphans: $shouldUninstallOrphans,
                shouldPurgeCache: $shouldPurgeCache,
                shouldDeleteDownloads: $shouldDeleteDownloads,
                shouldPerformHealthCheck: $shouldPerformHealthCheck,
                isShowingControlButtons: true,
                forcedOptions: forcedOptions!
            )
            .navigationDestination(for: MaintenanceSteps.self)
            { step in
                switch step
                {
                case .maintenanceRunning:
                    MaintenanceRunningView(
                        shouldUninstallOrphans: shouldUninstallOrphans,
                        shouldPurgeCache: shouldPurgeCache,
                        shouldDeleteDownloads: shouldDeleteDownloads,
                        shouldPerformHealthCheck: shouldPerformHealthCheck,
                        numberOfOrphansRemoved: $numberOfOrphansRemoved,
                        packagesHoldingBackCachePurge: $packagesHoldingBackCachePurge,
                        reclaimedSpaceAfterCachePurge: $reclaimedSpaceAfterCachePurge,
                        brewHealthCheckFoundNoProblems: $brewHealthCheckFoundNoProblems
                    )
                    .toolbar(.hidden, for: .windowToolbar)
                case .finished:
                    MaintenanceFinishedView(
                        shouldUninstallOrphans: shouldUninstallOrphans,
                        shouldPurgeCache: shouldPurgeCache,
                        shouldDeleteDownloads: shouldDeleteDownloads,
                        shouldPerformHealthCheck: shouldPerformHealthCheck,
                        packagesHoldingBackCachePurge: packagesHoldingBackCachePurge,
                        numberOfOrphansRemoved: numberOfOrphansRemoved,
                        reclaimedSpaceAfterCachePurge: reclaimedSpaceAfterCachePurge,
                        brewHealthCheckFoundNoProblems: brewHealthCheckFoundNoProblems,
                        maintenanceFoundNoProblems: $maintenanceFoundNoProblems
                    )
                    .toolbar(.hidden, for: .windowToolbar)
                default:
                    MaintenanceReadyView(
                        shouldUninstallOrphans: $shouldUninstallOrphans,
                        shouldPurgeCache: $shouldPurgeCache,
                        shouldDeleteDownloads: $shouldDeleteDownloads,
                        shouldPerformHealthCheck: $shouldPerformHealthCheck,
                        isShowingControlButtons: true,
                        forcedOptions: forcedOptions!
                    )
                }
            }
        }
        .environmentObject(navigationManager)
    }
}
