//
//  ContentView.swift
//  ConversationStarterMVP
//
//  Created by Lucas Lopez on 2/7/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ConversationViewModel()
    @FocusState private var isInputFocused: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {

                    header

                    selectionSection

                    promptCard

                    responseSection

                    submitSection

                    feedbackSection

                    Spacer(minLength: 24)
                }
                .padding()
            }
            .navigationTitle("Conversation Starter")
            .onTapGesture { isInputFocused = false }
            .onAppear { vm.updatePrompt() }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Practice real conversations")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Pick a language + scenario, then respond like you would in real life.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }

    private var selectionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Choose")
                .font(.headline)

            VStack(spacing: 12) {
                Menu {
                    Button("Select language") {
                        vm.selectedLanguage = nil
                        vm.updatePrompt()
                    }
                    Divider()
                    ForEach(PracticeLanguage.allCases) { lang in
                        Button(lang.rawValue) {
                            vm.selectedLanguage = lang
                            vm.updatePrompt()
                        }
                    }
                } label: {
                    selectionRow(title: "Language", value: vm.selectedLanguage?.rawValue ?? "Select")
                }

                Menu {
                    Button("Select scenario") {
                        vm.selectedScenario = nil
                        vm.updatePrompt()
                    }
                    Divider()
                    ForEach(Scenario.allCases) { scen in
                        Button(scen.rawValue) {
                            vm.selectedScenario = scen
                            vm.updatePrompt()
                        }
                    }
                } label: {
                    selectionRow(title: "Scenario", value: vm.selectedScenario?.rawValue ?? "Select")
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
        }
    }

    private func selectionRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
            Image(systemName: "chevron.down")
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }

    private var promptCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Prompt")
                    .font(.headline)

                Spacer()

                Button("Try another") {
                    vm.nextPrompt()
                }
                .disabled(!vm.canGeneratePrompt || vm.promptOptions.count <= 1)
            }

            Group {
                if !vm.canGeneratePrompt {
                    Text("Select a language and scenario to generate a prompt.")
                        .foregroundColor(.secondary)
                } else if vm.prompt.isEmpty {
                    Text("No prompt available.")
                        .foregroundColor(.secondary)
                } else {
                    Text(vm.prompt)
                        .font(.body)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
        }
    }

    private var responseSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Your response")
                .font(.headline)

            ZStack(alignment: .topLeading) {
                TextEditor(text: $vm.responseText)
                    .frame(minHeight: 120)
                    .focused($isInputFocused)
                    .padding(8)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .disabled(!vm.canGeneratePrompt)

                if vm.responseText.isEmpty {
                    Text(vm.canGeneratePrompt ? "Type what you would say…" : "Select a prompt first…")
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .allowsHitTesting(false)
                }
            }

            Text("\(vm.responseText.count) characters")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }

    private var submitSection: some View {
        Button {
            isInputFocused = false
            Task { await vm.submit() }
        } label: {
            HStack {
                Spacer()
                Text(vm.isLoading ? "Submitting…" : "Submit")
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding()
        }
        .disabled(!vm.canSubmit)
        .background(vm.canSubmit ? Color.blue.opacity(0.85) : Color.gray.opacity(0.3))
        .foregroundColor(.white)
        .cornerRadius(12)
    }

    private var feedbackSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            if vm.isLoading {
                HStack(spacing: 10) {
                    ProgressView()
                    Text("Checking your response…")
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
            }

            if let error = vm.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.red.opacity(0.08))
                    .cornerRadius(12)
            }

            if let feedback = vm.feedback {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Feedback")
                        .font(.headline)

                    Text(feedback)
                        .font(.body)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.green.opacity(0.10))
                .cornerRadius(12)
            }
        }
    }
}
