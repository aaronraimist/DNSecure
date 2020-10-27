//
//  RuleView.swift
//  DNSecure
//
//  Created by Kenta Kubo on 10/27/20.
//

import NetworkExtension
import SwiftUI

struct RuleView {
    // TODO: Move these properties into Resolver
    @State var name: String
    @State var action: NEOnDemandRuleAction = .ignore
    @State var interfaceType: NEOnDemandRuleInterfaceType = .any
    @State var ssidMatch: [String] = []
    @State var dnsSearchDomainMatch: [String] = []
    @State var dnsServerAddressMatch: [String] = []
    @State var useProbeURL = false
    @State var probeURL = ""
}

extension RuleView: View {
    var body: some View {
        Form {
            Section {
                HStack {
                    Text("Name")
                    TextField("Name", text: self.$name)
                        .multilineTextAlignment(.trailing)
                }
                Picker("Action", selection: self.$action) {
                    ForEach(NEOnDemandRuleAction.allCases, id: \.self) {
                        Text($0.description)
                    }
                }
            }

            Section(
                header: Text("Interface Type Match"),
                footer: Text("If the current primary network interface is of this type and all of the other conditions in the rule match, then the rule matches.")
            ) {
                Picker("Interface Type", selection: self.$interfaceType) {
                    ForEach(NEOnDemandRuleInterfaceType.allCases, id: \.self) {
                        Text($0.description)
                    }
                }
            }

            if self.interfaceType == .wiFi {
                Section(
                    header: Text("SSID Match"),
                    footer: Text("If the Service Set Identifier (SSID) of the current primary connected network matches one of the strings in this array and all of the other conditions in the rule match, then the rule matches.")
                ) {
                    ForEach(self.ssidMatch, id: \.self) {
                        // TODO: Use TextField
                        Text($0)
                    }
                    // TODO: onDelete
                    // TODO: onMove
                    Button("Add SSID") {
                        self.ssidMatch.append("")
                    }
                }
            }

            Section(
                header: Text("DNS Search Domain Match"),
                footer: Text("If the current default search domain is equal to one of the strings in this array and all of the other conditions in the rule match, then the rule matches.")
            ) {
                ForEach(self.dnsSearchDomainMatch, id: \.self) {
                    // TODO: Use TextField
                    Text($0)
                }
                // TODO: onDelete
                // TODO: onMove
                Button("Add DNS Search Domain") {}
            }

            Section(
                header: Text("DNS Server Address Match"),
                footer: Text("If each of the current default DNS servers is equal to one of the strings in this array and all of the other conditions in the rule match, then the rule matches.")
            ) {
                ForEach(self.dnsServerAddressMatch, id: \.self) {
                    // TODO: Use TextField
                    Text($0) // IP address
                }
                // TODO: onDelete
                // TODO: onMove
                Button("Add DNS Server Address") {}
            }

            Section(
                header: Text("Probe URL Match"),
                footer: Text("If a request sent to this URL results in a HTTP 200 OK response and all of the other conditions in the rule match, then the rule matches.")
            ) {
                Toggle("Use Probe URL", isOn: self.$useProbeURL)
                if self.useProbeURL {
                    HStack {
                        Text("Probe URL")
                        TextField("URL", text: self.$probeURL)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
        }
        .navigationTitle(self.name)
    }
}

struct RuleView_Previews: PreviewProvider {
    static var previews: some View {
        RuleView(name: "Preview Rule")
    }
}
