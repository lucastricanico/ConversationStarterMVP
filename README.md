# Conversation Starter MVP

- An iOS MVP designed to help users practice real-world language conversations. 
- Users select a language and scenario, receive a contextual prompt, submit a response, and get immediate rule-based feedback.

---

## Features

- Select a language (French or Spanish)
- Select a real-world scenario (ordering food, meeting someone new, asking directions)
- Dynamically generated conversation prompts
- "Try another prompt" rotation for repeated practice
- Text input for user responses
- Lightweight, rule-based feedback encouraging better conversational habits
- Clear handling of UI states:
  - Empty state (no selections)
  - Loading state (submission in progress)
  - Error state (missing input)
  - Success state (feedback displayed)

---

## Demo

**Screen Recording:** - Tap on Video if it doesn't load

[![Watch the demo](https://i.imgur.com/tD1IQss.gif)](https://i.imgur.com/tD1IQss.mp4) 

---

## How to Run the Project

1. Clone the repository 

3. Open `ConversationStarterMVP.xcodeproj` in Xcode.

4. Select an iPhone simulator.

5. Press **Run**.

---

## Technical Approach

### Architecture
The app uses a simple **MVVM pattern**:

**ViewModel responsibilities:**
- Owns all UI state (selections, prompt, loading, error, feedback)
- Generates prompts
- Validates input
- Produces rule-based feedback

This keeps the UI predictable and the code easy to extend without unnecessary complexity.

---


## Product Decisions

### Single-Screen Experience
- I chose a one-screen layout to reduce friction and keep the interaction fast and intuitive
- Important for a practice tool meant to encourage repetition.

---

### Prompt Rotation
- Users can generate alternate prompts within the same scenario.
- This improves replayability and better reflects real-world conversation variability.

---

### Lightweight Feedback
- Instead of implementing complex language evaluation, I used simple conversational heuristics such as:

- Response length  
- Politeness markers  
- Presence of follow-up questions  

This satisfies the MVP requirement while still guiding users toward more natural dialogue.

---

### State-Driven UI
- Inputs are disabled until a prompt exists, preventing invalid flows and improving usability.

---

## What I’d Improve With More Time

If expanded beyond MVP scope, I would prioritize:

- AI-powered feedback for grammar and tone
- Suggested example responses
- Conversation history and progress tracking
- Voice input for speaking practice
- Expanded prompt library with adaptive difficulty
- Accessibility improvements (VoiceOver, Dynamic Type)
- Localization support

---

## One Decision I’m Proud Of

I intentionally built the app as a state-driven MVP with a focused ViewModel that owns all interaction logic. This keeps the codebase readable, prevents UI inconsistencies, and makes future expansion straightforward.

---

## Author

**Lucas Lopez**
