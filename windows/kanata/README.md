# How to run Kanata

- Download the files and place them in the "C:\Users\{username}\Documents\Kanata" folder
- To run the Kanata Tray application run the following command with the required configs specified (Also configured in the Shortcut file):
  C:\Users\Sunit\Documents\Kanata\kanata_gui.exe -c "C:\Users\Sunit\Documents\Kanata\Normal Mode.kbd" -c "C:\Users\Sunit\Documents\Kanata\Game Mode.kbd"
- Switch between configs using Kanata tray icon

# How to autorun Kanata on log in
- Open Task Scheduler
- Click on "Create Task"
- Specify the following configurations for the task:
  - General tab:
    - Name: Kanata
    - Enable "Run only when user is logged in"
    - Enabled "Run with highest privileges"
    - Configure for: Windows 10
  - Triggers tab:
    - Create New trigger
    - Begin the Task: At log on
    - Specific user: {Your user}
    - Delay task for: 2 seconds (Increase if tray icon doesn't appear)
  - Actions tab:
    - Create New action
    - Action: Start a program
    - Program/script: C:\Users\Sunit\Documents\Kanata\kanata_gui.exe
    - Add arguments: -c "C:\Users\Sunit\Documents\Kanata\Normal Mode.kbd" -c "C:\Users\Sunit\Documents\Kanata\Game Mode.kbd" (Modify as needed)

**Note: replace {username} in the file paths**
