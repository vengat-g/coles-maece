# Coles Mobile App Engineering Coding Excercise

|Item|Description|
| --- | --- |
|iOS App | Swift, SwiftUI   |
|Unit Tests | Swift Tests |
|UI Test | XCTest |
|IDE | Xcode 27 - beta, macOS Golden Gate 27.0||
|AI Tools | Claude Code - [ App, Xcode ]|  |

---

##  Requirements:
### Functional
1. Consume the json from the given file. See [recipesSample.json](Resources/recipesSample.json).
2. Follow Design Guidelines for the app layout. See [design-ref](Resources/design-ref.png).
3. Handle error where appropriate
4. Orientation - Portrait / Landscape
5. Unit Test: At-least one of the below alogrithm: [See Algorithm](#algorithm)
  * Starting with `Group recipes by serving size`
6. Accessibility - Picking `Text Size` & `Voice Over` first.

#### Nice to Haves:
1. UI-Test
2. Accessibility - All | Text, Voice Over, Contrast

#### Algorithm:

Implement one of the following, with accompanying unit tests:
1.	Sort recipes by total time (prep + cooking)
2.	Group recipes by serving size
3.	Filter recipes by a maximum cooking time
4.	Parse and normalise time strings (e.g. "2h 20m" → minutes)

### Non Functional Requirements:
Derived from assumptions or best practices:
1. Cold start `< 1 s` | Simple at first, revist for LIVE APIs
2. Device Types - iOS (assumed) | Clarify - iPad, Mac App ?
3. Min Target OS - `iOS 17 & above` | Matching the curent Coles app min version
4. Layout - Should be strict 2 column ? 
  1. Assumption: Match the best responsive layout (inferred), could be more than 2 based on the size
5. Caching strategies - May be simpler at first with in-memory or URL caching for media & data  | Consistency - Eventual or strong? May be eventual

#### Revisit for scale:
1. Scroll for large sets of data
2. Network layer


