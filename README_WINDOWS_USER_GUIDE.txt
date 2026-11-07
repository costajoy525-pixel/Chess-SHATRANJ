========================================================================
  SHATRANJ CHESS (by Group 1) - UNIVERSAL WINDOWS EDITION
========================================================================

HOW TO PLAY OR INSTALL ON ANY WINDOWS PC (NO JAVA REQUIRED):
------------------------------------------------------------
1. Extract all files from this ZIP archive into any folder on your PC.
2. Choose either option:
   - Option A (Play Immediately / Portable):
     Double-click "Shatranj.exe".
   - Option B (Install to Windows with Desktop & Start Menu Shortcuts):
     Double-click "Shatranj_Setup.exe" and click OK.
     This installs Shatranj Chess to "%LOCALAPPDATA%\Programs\Shatranj Chess",
     creates Desktop and Start Menu shortcuts with the Shatranj icon, and
     launches the game automatically.

HOW IT WORKS ON EVERY WINDOWS DEVICE:
-------------------------------------
- "Shatranj.exe" is a native 64-bit Windows GUI executable:
  1. If a bundled JRE ("jre\bin\javaw.exe") or system Java ("javaw.exe") is
     present on the PC, it launches "Shatranj-Chess.jar" via "org.example.Launcher".
  2. If JavaFX runtime libraries are present, "Launcher" opens the JavaFX UI
     ("org.example.Main" + "ChessController").
  3. If Java is installed WITHOUT JavaFX, "Launcher" automatically falls back to
     "org.example.UniversalSwingChess" (pure-Java desktop UI powered by the exact
     same GameSession, Board, MoveGenerator, and Algorithms engine classes).
  4. If the Windows PC does NOT have Java installed at all, "Shatranj.exe"
     automatically launches "app\Shatranj_Desktop.hta" (the built-in standalone
     Windows desktop runtime), so any Windows user can install and play with
     zero external setup.

WHAT WAS FIXED IN THE JAVA / MAVEN PROJECT:
-------------------------------------------
1. Added "org.example.Launcher" (non-Application entry point) and updated
   "META-INF/MANIFEST.MF" and "pom.xml" to use "org.example.Launcher".
   In Java 11+, pointing MANIFEST.MF directly to a class that extends
   "javafx.application.Application" causes the JVM to abort at startup with:
   "Error: JavaFX runtime components are missing, and are required to run this application".
2. Added "org.example.UniversalSwingChess" so "Shatranj-Chess.jar" can also run
   on standard Java installations where OpenJFX DLLs/JARs are not installed.
3. Updated "chess/pom.xml" with explicit Windows ("<classifier>win</classifier>")
   dependencies for javafx-base, javafx-graphics, javafx-controls, and javafx-fxml,
   plus "maven-shade-plugin" and "launch4j-maven-plugin" so running
   "mvn clean package" (or "Build_Universal_Windows_EXE.bat") produces a
   self-contained Windows Fat JAR and native ".exe".
4. Fixed ".idea/misc.xml" language level to JDK_17 to match "chess/pom.xml".
