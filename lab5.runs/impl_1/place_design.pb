
Q
Command: %s
53*	vivadotcl2 
place_design2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-349h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
place_design2default:defaultZ4-22h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
U

Starting %s Task
103*constraints2
Placer2default:defaultZ18-103h px� 
}
BMultithreading enabled for place_design using a maximum of %s CPUs12*	placeflow2
22default:defaultZ30-611h px� 
v

Phase %s%s
101*constraints2
1 2default:default2)
Placer Initialization2default:defaultZ18-101h px� 
�

Phase %s%s
101*constraints2
1.1 2default:default29
%Placer Initialization Netlist Sorting2default:defaultZ18-101h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0202default:default2
1532.6762default:default2
0.0002default:defaultZ17-268h px� 
[
FPhase 1.1 Placer Initialization Netlist Sorting | Checksum: 1226e861c
*commonh px� 
�

%s
*constraints2s
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.030 . Memory (MB): peak = 1532.676 ; gain = 0.0002default:defaulth px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0192default:default2
1532.6762default:default2
0.0002default:defaultZ17-268h px� 
�

Phase %s%s
101*constraints2
1.2 2default:default2F
2IO Placement/ Clock Placement/ Build Placer Device2default:defaultZ18-101h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
�
�A LUT '%s' is driving clock pin of %s registers. This could lead to large hold time violations. First few involved registers are:
%s524*place29
%io_manager_inst/BHT_reg_0_127_0_0_i_12default:default2
1282default:default2�
�	chip_inst/cpu/branch_prediction_unit/BHT_reg_768_895_0_0/DP.LOW {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BHT_reg_768_895_0_0/SP.HIGH {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BHT_reg_768_895_0_0/SP.LOW {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BHT_reg_0_127_0_0/DP.HIGH {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BHT_reg_0_127_0_0/SP.HIGH {RAMD64E}
2default:defaultZ30-568h px� 
�
�A LUT '%s' is driving clock pin of %s registers. This could lead to large hold time violations. First few involved registers are:
%s524*place29
%io_manager_inst/BHT_reg_0_127_1_1_i_12default:default2
1282default:default2�
�	chip_inst/cpu/branch_prediction_unit/BHT_reg_3328_3455_1_1/DP.HIGH {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BHT_reg_3328_3455_1_1/DP.LOW {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BHT_reg_2432_2559_1_1/DP.LOW {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BHT_reg_2432_2559_1_1/DP.HIGH {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BHT_reg_2432_2559_1_1/SP.HIGH {RAMD64E}
2default:defaultZ30-568h px� 
�
�A LUT '%s' is driving clock pin of %s registers. This could lead to large hold time violations. First few involved registers are:
%s524*place29
%io_manager_inst/BTB_reg_0_63_9_11_i_12default:default2
2562default:default2�
�	chip_inst/cpu/branch_prediction_unit/BTB_reg_3904_3967_9_11/RAMD {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BTB_reg_3904_3967_9_11/RAMB {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BTB_reg_3904_3967_9_11/RAMA {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BTB_reg_3904_3967_9_11/RAMC {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BTB_reg_1856_1919_9_11/RAMD {RAMD64E}
2default:defaultZ30-568h px� 
�
�A LUT '%s' is driving clock pin of %s registers. This could lead to large hold time violations. First few involved registers are:
%s524*place2:
&io_manager_inst/BTB_reg_0_63_12_14_i_12default:default2
2562default:default2�
�	chip_inst/cpu/branch_prediction_unit/BTB_reg_512_575_12_14/RAMB {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BTB_reg_512_575_12_14/RAMA {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BTB_reg_512_575_12_14/RAMD {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BTB_reg_512_575_12_14/RAMC {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BTB_reg_1920_1983_12_14/RAMC {RAMD64E}
2default:defaultZ30-568h px� 
�
�A LUT '%s' is driving clock pin of %s registers. This could lead to large hold time violations. First few involved registers are:
%s524*place2:
&io_manager_inst/BTB_reg_0_63_21_23_i_12default:default2
2562default:default2�
�	chip_inst/cpu/branch_prediction_unit/BTB_reg_4032_4095_21_23/RAMA {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BTB_reg_4032_4095_21_23/RAMC {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BTB_reg_4032_4095_21_23/RAMB {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BTB_reg_4032_4095_21_23/RAMD {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BTB_reg_1856_1919_21_23/RAMD {RAMD64E}
2default:defaultZ30-568h px� 
�
�A LUT '%s' is driving clock pin of %s registers. This could lead to large hold time violations. First few involved registers are:
%s524*place28
$io_manager_inst/BTB_reg_0_63_3_5_i_12default:default2
2562default:default2�
�	chip_inst/cpu/branch_prediction_unit/BTB_reg_3904_3967_3_5/RAMC {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BTB_reg_3904_3967_3_5/RAMB {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BTB_reg_3904_3967_3_5/RAMD {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BTB_reg_3904_3967_3_5/RAMA {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BTB_reg_1856_1919_3_5/RAMD {RAMD64E}
2default:defaultZ30-568h px� 
�
�A LUT '%s' is driving clock pin of %s registers. This could lead to large hold time violations. First few involved registers are:
%s524*place28
$io_manager_inst/BTB_reg_0_63_6_8_i_12default:default2
2562default:default2�
�	chip_inst/cpu/branch_prediction_unit/BTB_reg_1856_1919_6_8/RAMD {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BTB_reg_1856_1919_6_8/RAMC {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BTB_reg_1856_1919_6_8/RAMB {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BTB_reg_1856_1919_6_8/RAMA {RAMD64E}
	chip_inst/cpu/branch_prediction_unit/BTB_reg_1920_1983_6_8/RAMC {RAMD64E}
2default:defaultZ30-568h px� 
g
RPhase 1.2 IO Placement/ Clock Placement/ Build Placer Device | Checksum: 7d6807b1
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:05 ; elapsed = 00:00:08 . Memory (MB): peak = 1532.676 ; gain = 0.0002default:defaulth px� 
}

Phase %s%s
101*constraints2
1.3 2default:default2.
Build Placer Netlist Model2default:defaultZ18-101h px� 
O
:Phase 1.3 Build Placer Netlist Model | Checksum: b6f3b333
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:06 ; elapsed = 00:00:11 . Memory (MB): peak = 1532.676 ; gain = 0.0002default:defaulth px� 
z

Phase %s%s
101*constraints2
1.4 2default:default2+
Constrain Clocks/Macros2default:defaultZ18-101h px� 
L
7Phase 1.4 Constrain Clocks/Macros | Checksum: b6f3b333
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:06 ; elapsed = 00:00:11 . Memory (MB): peak = 1532.676 ; gain = 0.0002default:defaulth px� 
H
3Phase 1 Placer Initialization | Checksum: b6f3b333
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:06 ; elapsed = 00:00:11 . Memory (MB): peak = 1532.676 ; gain = 0.0002default:defaulth px� 
q

Phase %s%s
101*constraints2
2 2default:default2$
Global Placement2default:defaultZ18-101h px� 
D
/Phase 2 Global Placement | Checksum: 1cd2ec0af
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:09 ; elapsed = 00:00:15 . Memory (MB): peak = 1532.676 ; gain = 0.0002default:defaulth px� 
q

Phase %s%s
101*constraints2
3 2default:default2$
Detail Placement2default:defaultZ18-101h px� 
}

Phase %s%s
101*constraints2
3.1 2default:default2.
Commit Multi Column Macros2default:defaultZ18-101h px� 
P
;Phase 3.1 Commit Multi Column Macros | Checksum: 1cd2ec0af
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:09 ; elapsed = 00:00:15 . Memory (MB): peak = 1532.676 ; gain = 0.0002default:defaulth px� 


Phase %s%s
101*constraints2
3.2 2default:default20
Commit Most Macros & LUTRAMs2default:defaultZ18-101h px� 
R
=Phase 3.2 Commit Most Macros & LUTRAMs | Checksum: 14ba5dd43
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:10 ; elapsed = 00:00:16 . Memory (MB): peak = 1532.676 ; gain = 0.0002default:defaulth px� 
y

Phase %s%s
101*constraints2
3.3 2default:default2*
Area Swap Optimization2default:defaultZ18-101h px� 
L
7Phase 3.3 Area Swap Optimization | Checksum: 191f87e3c
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:10 ; elapsed = 00:00:16 . Memory (MB): peak = 1532.676 ; gain = 0.0002default:defaulth px� 
�

Phase %s%s
101*constraints2
3.4 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px� 
T
?Phase 3.4 Pipeline Register Optimization | Checksum: 17fd8c04e
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:10 ; elapsed = 00:00:16 . Memory (MB): peak = 1532.676 ; gain = 0.0002default:defaulth px� 


Phase %s%s
101*constraints2
3.5 2default:default20
Small Shape Detail Placement2default:defaultZ18-101h px� 
R
=Phase 3.5 Small Shape Detail Placement | Checksum: 1c4a148d1
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:12 ; elapsed = 00:00:18 . Memory (MB): peak = 1532.676 ; gain = 0.0002default:defaulth px� 
u

Phase %s%s
101*constraints2
3.6 2default:default2&
Re-assign LUT pins2default:defaultZ18-101h px� 
G
2Phase 3.6 Re-assign LUT pins | Checksum: ea7382de
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:12 ; elapsed = 00:00:18 . Memory (MB): peak = 1532.676 ; gain = 0.0002default:defaulth px� 
�

Phase %s%s
101*constraints2
3.7 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px� 
S
>Phase 3.7 Pipeline Register Optimization | Checksum: ea7382de
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:12 ; elapsed = 00:00:18 . Memory (MB): peak = 1532.676 ; gain = 0.0002default:defaulth px� 
C
.Phase 3 Detail Placement | Checksum: ea7382de
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:12 ; elapsed = 00:00:19 . Memory (MB): peak = 1532.676 ; gain = 0.0002default:defaulth px� 
�

Phase %s%s
101*constraints2
4 2default:default2<
(Post Placement Optimization and Clean-Up2default:defaultZ18-101h px� 
{

Phase %s%s
101*constraints2
4.1 2default:default2,
Post Commit Optimization2default:defaultZ18-101h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
�

Phase %s%s
101*constraints2
4.1.1 2default:default2/
Post Placement Optimization2default:defaultZ18-101h px� 
V
APost Placement Optimization Initialization | Checksum: 109342bb7
*commonh px� 
u

Phase %s%s
101*constraints2
4.1.1.1 2default:default2"
BUFG Insertion2default:defaultZ18-101h px� 
�
EMultithreading enabled for phys_opt_design using a maximum of %s CPUs380*physynth2
22default:defaultZ32-721h px� 
�
PProcessed net %s, BUFG insertion was skipped due to placement/routing conflicts.32*	placeflow2'
io_manager_inst/rst2default:defaultZ46-33h px� 
�
�BUFG insertion identified %s candidate nets, %s success, %s skipped for placement/routing, %s skipped for timing, %s skipped for netlist change reason.30*	placeflow2
12default:default2
02default:default2
12default:default2
02default:default2
02default:defaultZ46-31h px� 
H
3Phase 4.1.1.1 BUFG Insertion | Checksum: 109342bb7
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:14 ; elapsed = 00:00:21 . Memory (MB): peak = 1532.676 ; gain = 0.0002default:defaulth px� 
�
hPost Placement Timing Summary WNS=%s. For the most accurate timing information please run report_timing.610*place2
6.9682default:defaultZ30-746h px� 
S
>Phase 4.1.1 Post Placement Optimization | Checksum: 12fd70dd6
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:14 ; elapsed = 00:00:21 . Memory (MB): peak = 1532.676 ; gain = 0.0002default:defaulth px� 
N
9Phase 4.1 Post Commit Optimization | Checksum: 12fd70dd6
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:14 ; elapsed = 00:00:21 . Memory (MB): peak = 1532.676 ; gain = 0.0002default:defaulth px� 
y

Phase %s%s
101*constraints2
4.2 2default:default2*
Post Placement Cleanup2default:defaultZ18-101h px� 
L
7Phase 4.2 Post Placement Cleanup | Checksum: 12fd70dd6
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:14 ; elapsed = 00:00:21 . Memory (MB): peak = 1532.676 ; gain = 0.0002default:defaulth px� 
s

Phase %s%s
101*constraints2
4.3 2default:default2$
Placer Reporting2default:defaultZ18-101h px� 
F
1Phase 4.3 Placer Reporting | Checksum: 12fd70dd6
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:14 ; elapsed = 00:00:21 . Memory (MB): peak = 1532.676 ; gain = 0.0002default:defaulth px� 
z

Phase %s%s
101*constraints2
4.4 2default:default2+
Final Placement Cleanup2default:defaultZ18-101h px� 
L
7Phase 4.4 Final Placement Cleanup | Checksum: 94ba24ee
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:14 ; elapsed = 00:00:21 . Memory (MB): peak = 1532.676 ; gain = 0.0002default:defaulth px� 
[
FPhase 4 Post Placement Optimization and Clean-Up | Checksum: 94ba24ee
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:14 ; elapsed = 00:00:21 . Memory (MB): peak = 1532.676 ; gain = 0.0002default:defaulth px� 
=
(Ending Placer Task | Checksum: 315dcbc1
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:14 ; elapsed = 00:00:21 . Memory (MB): peak = 1532.676 ; gain = 0.0002default:defaulth px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
532default:default2
72default:default2
02default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
place_design2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
place_design: 2default:default2
00:00:152default:default2
00:00:222default:default2
1532.6762default:default2
0.0002default:defaultZ17-268h px� 
H
&Writing timing data to binary archive.266*timingZ38-480h px� 
D
Writing placer database...
1603*designutilsZ20-1893h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2)
Write XDEF Complete: 2default:default2
00:00:012default:default2 
00:00:00.7362default:default2
1532.6762default:default2
0.0002default:defaultZ17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2V
BF:/Vivado labs/sys3_lab1_myversion/lab5.runs/impl_1/Top_placed.dcp2default:defaultZ17-1381h px� 
^
%s4*runtcl2B
.Executing : report_io -file Top_io_placed.rpt
2default:defaulth px� 
�
kreport_io: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.052 . Memory (MB): peak = 1532.676 ; gain = 0.000
*commonh px� 
�
%s4*runtcl2r
^Executing : report_utilization -file Top_utilization_placed.rpt -pb Top_utilization_placed.pb
2default:defaulth px� 
�
treport_utilization: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.106 . Memory (MB): peak = 1532.676 ; gain = 0.000
*commonh px� 
{
%s4*runtcl2_
KExecuting : report_control_sets -verbose -file Top_control_sets_placed.rpt
2default:defaulth px� 
�
ureport_control_sets: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.062 . Memory (MB): peak = 1532.676 ; gain = 0.000
*commonh px� 


End Record