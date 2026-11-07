# ♟️ Shatranj Chess (by Group 1)

**Shatranj Chess** is a desktop chess application and custom AI engine built with object-oriented Java (JavaFX & Swing) and a standalone native Windows runtime. It supports **Player vs. Bot** (Easy, Medium, and Hard difficulty), **Player vs. Player** local pass-and-play, **Premove** queuing, customizable **Time Controls** (Bullet, Blitz, Rapid, and Classic), and multiple **Board Themes** (Neutral, Brown, and Green).

## ✨ Key Features

| Category | Features Included |
| :--- | :--- |
| **Game Modes** | **Player vs. Bot** (Play as White or Black with automatic board flip) and **Player vs. Player** local match mode |
| **Chess AI Engine** | Custom **Negamax** search with **Alpha-Beta Pruning**, **MVV-LVA Move Ordering**, and **Piece-Square Tables (PST)** for opening/middlegame and endgame evaluation |
| **Complete FIDE Rules** | Full legal move generation and validation, **Check / Checkmate / Stalemate** detection, **Kingside & Queenside Castling**, **En Passant** captures, and **Pawn Promotion** |
| **Time Controls** | **Bullet** (1 min), **Blitz** (3 min), **Rapid** (10 min), and **Classic** (30 min) live digital clocks with timeout detection |
| **Gameplay Utilities** | **Premove** toggle (`ON`/`OFF`) for instant response queuing during the bot's turn, **Undo Last Move**, **Captured Pieces** tracker, and live **Algebraic Move Notation** log |
| **Visual Themes** | **Neutral** (`#EBECF0` / `#A8ACB5`), **Brown** (`#F0D9B5` / `#B58863`), and **Green** (`#EEEED2` / `#769656`) board palettes with legal-move dots, capture rings, and dashed last-move highlights |
| **Universal Windows Support** | Runs out of the box on any Windows 10/11 PC via `Shatranj.exe` (native Windows executable), `Shatranj_Setup.exe`, or `Shatranj-Chess.jar` |

## 🚀 Installation & How to Play (Windows 10 / 11)

You can install and play **Shatranj Chess** on any Windows PC—even without Java or an IDE installed.

### Option 1: One-Command Terminal Install (PowerShell)
Open **Windows PowerShell** and run the following command to clone the repository, compile/install the native Windows executable, create your Desktop shortcut, and launch the game automatically:

```powershell
git clone https://github.com/costajoy525-pixel/Chess-SHATRANJ.git "$HOME\Desktop\Chess-SHATRANJ"
cd "$HOME\Desktop\Chess-SHATRANJ"
if (Test-Path ".\Shatranj.zip") { Expand-Archive -Path ".\Shatranj.zip" -DestinationPath "." -Force }
cmd.exe /c "Install_And_Play_Shatranj.bat"
```

### Option 2: Download & Double-Click Install (No Terminal Needed)
1. Click the green **`<> Code`** button on [GitHub](https://github.com/costajoy525-pixel/Chess-SHATRANJ) and select **Download ZIP** (or download `Shatranj.zip` from the repository).
2. Right-click the downloaded `.zip` file and click **Extract All...** to unzip all files into a folder.
3. Inside the extracted folder, choose any of the following:
   - **Double-click `Install_And_Play_Shatranj.bat`** (or **`Shatranj_Setup.exe`**) to install Shatranj Chess into `%LOCALAPPDATA%\Programs\Shatranj Chess`, create **Desktop** and **Start Menu** shortcuts with the Shatranj Knight icon, and launch the game.
   - **Double-click `Shatranj.exe`** to play immediately in portable mode.

### Option 3: Run via Java Executable JAR (Cross-Platform: Windows, macOS, Linux)
If you have **Java 17+** installed on your system, you can run the pre-packaged universal JAR directly:

```bash
java -jar Shatranj-Chess.jar
```

`Shatranj-Chess.jar` uses `org.example.Launcher` to automatically start the JavaFX interface (`org.example.Main`) when OpenJFX libraries are present, or seamlessly fall back to the built-in pure-Java desktop interface (`org.example.UniversalSwingChess`) on standard JRE installations.

## 🎮 Controls & In-Game Menu

- **Start Screen**: Click **Start Game** to begin a new match, **Continue** to resume an active match, or **Quit** to exit.
- **Making Moves**: Click any of your pieces to highlight legal destinations (dark dots for empty squares, rings for captures), then click the destination square.
- **Premove Mode**: Toggle **Premove: ON** in the top-right sidebar before making your first move to queue your next move (highlighted in purple) while the bot is thinking.
- **Hamburger Settings Drawer (`☰`)**: Click the `☰` button in the top-left corner during a game to switch:
  - **Game Mode**: *Player vs Bot* (*Easy* Depth 1, *Medium* Depth 2, *Hard* Depth 3) or *Player vs Player*
  - **Game Actions**: *New Game*, *Pause / Resume*, or *Quit to Menu*
  - **Time Control**: *Bullet* (01:00), *Blitz* (03:00), *Rapid* (10:00), or *Classic* (30:00)
  - **Theme**: *Neutral*, *Brown*, or *Green*

## 🗂️ Project Architecture

```text
Chess-SHATRANJ/
├── Shatranj.exe                     # Universal Windows standalone executable
├── Shatranj_Setup.exe               # Windows GUI installer (creates Desktop & Start Menu shortcuts)
├── Shatranj-Chess.jar               # Pre-compiled universal Java executable JAR (Java 17+)
├── Install_And_Play_Shatranj.bat    # One-click Windows native compiler, installer & launcher
├── Build_Universal_Windows_EXE.bat  # Developer script to rebuild Fat JAR & EXE from Java source
├── app/
│   ├── Shatranj.ico                 # Multi-resolution Windows application icon
│   ├── ShatranjWindowsApp.cs        # Standalone C#/.NET Windows Forms native desktop source
│   ├── Shatranj_Desktop.hta         # Zero-dependency Windows HTA desktop runtime fallback
│   └── install_shatranj.cmd         # Automated Windows shortcut & Programs folder installer
└── chess/
    ├── pom.xml                      # Maven configuration (OpenJFX 17.0.6, Shade & Launch4j plugins)
    └── src/main/
        ├── java/org/example/
        │   ├── Launcher.java            # Universal non-Application entry point
        │   ├── Main.java                # JavaFX Application entry class
        │   ├── ChessController.java     # JavaFX UI controller, clock, premove & drawer logic
        │   ├── UniversalSwingChess.java # Built-in Java Swing/Java2D universal fallback UI
        │   ├── GameSession.java         # Match state, move history, algebraic notation & timers
        │   ├── Engine.java              # AI engine interface
        │   ├── Algorithms.java          # Negamax + Alpha-Beta pruning, move ordering & PST eval
        │   ├── Board.java               # 8x8 board representation, FEN loader, make/unmake move
        │   ├── MoveGenerator.java       # Pseudo-legal & legal move generator (castling, en passant)
        │   ├── Move.java                # Move data structure & special move flags
        │   ├── Piece.java               # Piece types and colors
        │   └── TestBoard.java           # Engine tactical & Perft test suite
        └── resources/org/example/
            ├── chess.fxml               # JavaFX FXML scene layout
            └── style.css                # Dark-mode stylesheet
```

## 🛠️ Building from Source (For Developers)

If you modify the Java source files inside `chess/src/main/java/org/example/`:

1. **Using the Windows Build Script**:
   Double-click `Build_Universal_Windows_EXE.bat` (automatically detects Maven or IntelliJ's bundled Maven and rebuilds `Shatranj-Chess.jar` and `Shatranj.exe`).
2. **Using Maven CLI**:
   ```bash
   cd chess
   mvn clean package
   ```
3. **Running via Maven JavaFX Plugin**:
   ```bash
   cd chess
   mvn javafx:run
   ```

## 👥 Authors

Developed by **Group 1** (*Shatranj Chess Project*). Contributions, bug reports, and pull requests are welcome!
