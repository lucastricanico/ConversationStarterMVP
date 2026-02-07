//
//  ConversationViewModel.swift
//  ConversationStarterMVP
//
//  Created by Lucas Lopez on 2/7/26.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class ConversationViewModel: ObservableObject {
    @Published var selectedLanguage: PracticeLanguage? = nil
    @Published var selectedScenario: Scenario? = nil

    @Published private(set) var promptOptions: [String] = []
    @Published private(set) var promptIndex: Int = 0
    @Published var prompt: String = ""

    @Published var responseText: String = ""

    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var feedback: String? = nil

    var canGeneratePrompt: Bool {
        selectedLanguage != nil && selectedScenario != nil
    }

    var canSubmit: Bool {
        canGeneratePrompt &&
        !responseText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !isLoading
    }

    func updatePrompt() {
        errorMessage = nil
        feedback = nil

        guard let lang = selectedLanguage, let scen = selectedScenario else {
            promptOptions = []
            promptIndex = 0
            prompt = ""
            return
        }

        promptOptions = PromptGenerator.prompts(for: lang, scenario: scen)
        promptIndex = 0
        prompt = promptOptions.first ?? ""
    }

    func nextPrompt() {
        guard !promptOptions.isEmpty else { return }
        feedback = nil
        errorMessage = nil

        promptIndex = (promptIndex + 1) % promptOptions.count
        prompt = promptOptions[promptIndex]
    }

    func submit() async {
        errorMessage = nil
        feedback = nil

        guard canGeneratePrompt else {
            errorMessage = "Select a language and scenario to get a prompt."
            return
        }

        let trimmed = responseText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            errorMessage = "Type a response before submitting."
            return
        }

        isLoading = true
        defer { isLoading = false }

        // Fake “processing”
        try? await Task.sleep(nanoseconds: 650_000_000)

        feedback = makeLightweightFeedback(for: trimmed)
    }

    private func makeLightweightFeedback(for text: String) -> String {
        let lower = text.lowercased()
        var notes: [String] = []

        if text.count < 25 {
            notes.append("Try adding one more sentence for clarity.")
        } else {
            notes.append("Good length — nice job expressing a complete thought.")
        }

        if lower.contains("please") || lower.contains("por favor") || lower.contains("s'il vous plaît") || lower.contains("s’il vous plaît") {
            notes.append("Nice politeness! That’s very natural in real conversation.")
        }

        if !text.contains("?") {
            notes.append("Consider adding a follow-up question to keep the conversation going.")
        }

        // Format as bullets
        return "• " + notes.joined(separator: "\n• ")
    }
}
