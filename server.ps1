$smtpFrom = "192.168.43.34"

$smtpTo = "brajendra.kumar@xcelserv.com"
$CPU = Get-WmiObject win32_processor | Measure-Object -property LoadPercentage -Average | Select Average
$Mem = gwmi -Class win32_operatingsystem |

Select-Object @{Name = "TotalMemory"; Expression = {“{0:N2}” -f ((($_.TotalVisibleMemorySize ))/ $_.TotalVisibleMemorySize) }}

$Mem1 = gwmi -Class win32_operatingsystem |

Select-Object @{Name = "MemoryUsage"; Expression = {“{0:N2}” -f ((($_.TotalVisibleMemorySize - $_.FreePhysicalMemory)*100)/ $_.TotalVisibleMemorySize) }}

$Mem2 = gwmi -Class win32_operatingsystem |

Select-Object @{Name = "MemoryFree"; Expression = {“{0:N2}” -f ((($_.TotalVisibleMemorySize - $_.PhysicalMemory)*100)/ $_.TotalVisibleMemorySize) }}


$Diska = Get-WmiObject -Class win32_Volume -Filter "DriveLetter = 'C:'" |

Select-object @{Name = "CTotal"; Expression = {“{0:N2}” -f (($_.Capacity)) } }

$Diskb = Get-WmiObject -Class win32_Volume -Filter "DriveLetter = 'C:'" |
Select-object @{Name = "CFree"; Expression = {“{0:N2}” -f (($_.FreeSpace)) } }

$Disk = Get-WmiObject -Class win32_Volume -Filter "DriveLetter = 'D:'" |
Select-object @{Name = "DFree"; Expression = {“{0:N2}” -f (($_.FreeSpace)) } }

$Diskc = Get-WmiObject -Class win32_Volume -Filter "DriveLetter = 'D:'" |
Select-object @{Name = "DTotal"; Expression = {“{0:N2}” -f (($_.Capacity)) } }

 

$Outputreport = "<HTML><TITLE> Current Server Health </TITLE>

<H2 style=color:Red; > Server Health </H2></font>

<Table border=1 cellpadding=5 cellspacing=0>

<TR>

<TD><B>Average CPU</B></TD>

<TD><B>Total Memory</B></TD>
<TD><B>Memory Used</B></TD>
<TD><B>Memory Free</B></TD>

<TD><B>C-Drive Total</B></TD></TD>
<TD><B>C-Memory Free</B></TD>
<TD><B>D-Memory Free</B></TD>
<TD><B>D-Drive Total</B></TD></TR>
<TR>

<TD align=center>$($CPU.Average)%</TD>

<TD align=center>$($MEM.TotalMemory)%</TD>
<TD align=center>$($MEM1.MemoryUsage)%</TD>
<TD align=center>$($MEM2.MemoryFree)%</TD>

<TD align=center>$($Diska."CTotal")% </TD>
<TD align=center>$($Diskb."CFree")% Free</TD>
<TD align=center>$($Disk."DFree")%Free</TD>
<TD align=center>$($Diskc."DTotal")% </TD</TR>

</Table></BODY></HTML>"
$Outputreport | out-file $OutputFile

 


