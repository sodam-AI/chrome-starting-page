Set WshShell = CreateObject("WScript.Shell")
scriptDir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)

' Use portable node if available, else system node
If CreateObject("Scripting.FileSystemObject").FileExists(scriptDir & "\node\node.exe") Then
    nodeCmd = """" & scriptDir & "\node\node.exe" & """"
Else
    nodeCmd = "node"
End If

WshShell.CurrentDirectory = scriptDir
WshShell.Run nodeCmd & " """ & scriptDir & "\server.js""", 0, False
