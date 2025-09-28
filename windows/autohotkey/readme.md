# How to Enable the scripts
Compile the .ahk scripts using AutoHotKey Dash. Compile "Remappings.ahk" using v2 and "Desktops.ahk" using v1.
Create a task in task scheduler for each script with the following properties:
- General: Run only when user is logged on
- Triggers: Trigger at log on, at log on of any user
- Actions: Start a program, linked to the exe files
