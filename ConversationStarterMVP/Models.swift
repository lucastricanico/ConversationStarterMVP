//
//  Models.swift
//  ConversationStarterMVP
//
//  Created by Lucas Lopez on 2/7/26.
//

import Foundation

enum PracticeLanguage: String, CaseIterable, Identifiable {
    case french = "French"
    case spanish = "Spanish"

    var id: String { rawValue }
}

enum Scenario: String, CaseIterable, Identifiable {
    case orderingFood = "Ordering food"
    case meetingSomeone = "Meeting someone new"
    case askingDirections = "Asking for directions"

    var id: String { rawValue }
}

struct PromptGenerator {
    static func prompts(for language: PracticeLanguage, scenario: Scenario) -> [String] {
        switch (language, scenario) {
        case (.french, .orderingFood):
            return [
                "You’re at a café in Paris. Order a coffee and ask if they have oat milk.",
                "You’re at a bakery in Paris. Ask what they recommend and order a croissant.",
                "You’re at a small café. Ask for the menu and request the bill at the end."
            ]
        case (.french, .meetingSomeone):
            return [
                "You’re meeting a new classmate in Lyon. Introduce yourself and ask what they study.",
                "You’re at a student event. Say hello and ask where they’re from.",
                "You just met someone at a party. Ask how long they’ve lived here."
            ]
        case (.french, .askingDirections):
            return [
                "You’re lost near the Louvre. Ask for directions to the nearest metro station.",
                "You’re trying to get to a museum. Ask which line to take and where to get off.",
                "You’re on the street. Ask how far it is to walk and which way to go."
            ]

        case (.spanish, .orderingFood):
            return [
                "You’re at a restaurant in Madrid. Order lunch and ask if the dish is spicy.",
                "You’re at a café. Order a drink and ask if they have non-dairy milk.",
                "You’re ordering takeout. Ask what comes with the meal and how long it will take."
            ]
        case (.spanish, .meetingSomeone):
            return [
                "You’re meeting someone new in Uruguay. Say hello and ask what they like to do on weekends.",
                "You’re meeting a friend’s friend. Introduce yourself and ask what they do.",
                "You’re at a campus event. Ask what they’re studying and why they chose it."
            ]
        case (.spanish, .askingDirections):
            return [
                "You’re trying to find the museum. Ask which bus to take and where to get off.",
                "You’re in a new neighborhood. Ask for the nearest subway station.",
                "You’re looking for a specific street. Ask if you’re going the right way."
            ]
        }
    }
}

