//
//  Installation Terminated Unexpectedly.swift
//  Cork
//
//  Created by David Bureš on 27.06.2024.
//

import SwiftUI

struct InstallationTerminatedUnexpectedlyView: View
{
    let terminalOutputOfTheInstallation: [RealTimeTerminalLine]

    @State private var usableLiveTerminalOutput: [RealTimeTerminalLine] = .init()

    var body: some View
    {
        ComplexWithIcon(systemName: "xmark.seal")
        {
            VStack(alignment: .leading, spacing: 10)
            {
                HeadlineWithSubheadline(
                    headline: "add-package.install.installation-terminated.title",
                    subheadline: "add-package.install.installation-terminated.subheadline",
                    alignment: .leading
                )
                
                if usableLiveTerminalOutput.isEmpty
                {
                    OutlinedPillText(text: "add-package.install.installation-terminated.no-terminal-output-provided", color: .secondary)                        
                }
                else
                {
                    DisclosureGroup
                    {
                        List
                        {
                            ForEach(usableLiveTerminalOutput)
                            { outputLine in
                                Text(outputLine.line)
                            }
                        }
                        .frame(height: 100, alignment: .leading)
                    } label: {
                        Text("action.show-terminal-output")
                    }
                }
            }
        }
        .fixedSize()
        .onAppear
        {
            /// We have to assign `terminaloutputOfTheInstallation` to this private var so it doesn't get purged with the passed original
            usableLiveTerminalOutput = terminalOutputOfTheInstallation
        }
    }
}
