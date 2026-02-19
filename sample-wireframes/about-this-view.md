# Bookmarks

> Example `about-this-view.md` — place a file like this alongside your wireframes to give the AI extra context about the feature.

## Purpose

The Bookmarks feature lets users save, organize, and search web bookmarks captured from the system clipboard. It is the app's primary feature.

## Data Model

| Field       | Type      | Description                                                         |
| ----------- | --------- | ------------------------------------------------------------------- |
| `id`        | UUID      | Unique identifier                                                   |
| `title`     | string    | User-editable title (initially extracted from page)                 |
| `url`       | string    | The bookmarked URL                                                  |
| `tags`      | [string]  | User-assigned tags, lowercase, no spaces (e.g., `swift`, `ios-dev`) |
| `rating`    | int (0-5) | User rating, 0 means unrated                                        |
| `dateAdded` | date      | When the bookmark was created                                       |

## Business Rules

- **Rating system:** Stars 1-5; tapping an already-selected star resets rating to 0 (unrated).
- **Tag format:** Tags are lowercase, hyphenated (no spaces). The UI should auto-format user input.
- **Search:** Searches title, URL, tags, and notes. Results update as the user types.

## Design Constraints

- **Portrait only** — no landscape layout needed
- **On-device ML** — tag suggestions use on-device NLP; no network calls for suggestions
- **Local persistence** — all data stored locally (no sync, no cloud)
- **Minimum iOS version:** 18.0
