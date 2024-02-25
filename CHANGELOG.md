# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.0] - 2024-02.25
### Added
- A button to open the Steam Devkit Management Tool without leaving the Godot Editor.

### Changed
- Internal signal handling has been improved.
- Scene references has been improved.

## [1.1.1] - 2024-02-08
### Fixed
- A bug that caused the plugin to mark your project as modified upon opening without you making any changes. This bug was fixed by [jefvel in PR #1](https://github.com/tuc0w/godot-steam-devkit-notifier/pull/1).

## [1.1.0] - 2024-01-28
### Added
- Auto notify filter for linux platform to avoid sending notifications to the Steam Devkit Management Tool when exporting to another platform.

### Changed
- The internal logic of the plugin has been changed to use signals for communication between the dock component and the export part.

## [1.0.0] - 2024-01-27 (initial release)

### Added

- Auto notify feature to automatically notify the Steam Devkit Management Tool to upload the game when you export the game.
