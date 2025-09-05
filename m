Return-Path: <linux-btrfs+bounces-16629-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B922AB44C59
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 05:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653D2A4694A
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 03:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18F2537F8;
	Fri,  5 Sep 2025 03:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eyOcT58d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A601C27
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 03:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757043192; cv=none; b=bxc/ArSyos5RayT7ugvqXoRiPckV85dx+fn+T1ueHo9+iYxo/+uX6Ye82ULpGYoqBz3E63GaZVQWVdbgcKfAD1LDbEc1lk1rVXYc53bAl2O3Nh9KuVa9iJ3ZybgiRlMbz9FTwEev7+l49vIvBW12Sotw3a/UAfcOe1hPScX6NSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757043192; c=relaxed/simple;
	bh=D0kgrOGck/vPJZTvpw6MYW5AZhFLeODJxmWWrZFA6TU=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=N+AwnBAtIzGuZd1vU7zxojWqYlyf9AEtCKDzWWy9pWdKy0bPuGafrJF2fQs3qydWWnJ4cgGLTeBaD0bTQQ/w/o0HvNWq1JsV99qeLvO9Dh6yRNTyzHLo9Xh1V1VTYgevh5xIQi4g+VdEi1ilflIfrKuWoF+zQ4I1tuW8+JgFBiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eyOcT58d; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1757043186; x=1757302386;
	bh=6Xear4bzyWS4ZikgasvAb2YEAUFtpmVezp4vnXUfMkA=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=eyOcT58ddUX12HRzf4QdM+E4GLkyYjzDGCVbu/y3WVPq3BEk20am/OiK6VcaH3AKl
	 qmU+fP2vw+pWeuRFO08/sb3h3VrwrhtBJiqH2Uq+rl3OcTOBgp1SIxoyy8FqvyVl5+
	 p5wFilRYtORoQR7HRZDDg0EgIjT1JOH2roVAHxlPiHF0RwQGP/yN7eopE+C9HgCCXF
	 VbOnSIji1OSNOegSxE0HDhRZg8s86t1Nouh2DSJ1LGEtrsxMgJso8NDM+vFlNNtE9x
	 pG95OBPRNGIvw9BvKi38dI4ghlSVFz6s04x75DfKL7WgCwk5fXYtxwxYG2o/KDjaJR
	 9r70VoOzjI8Vg==
Date: Fri, 05 Sep 2025 03:33:03 +0000
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: jonas.timothy@proton.me
Subject: Btrfs RAID 1 mounting as R/O
Message-ID: <AIOTMBnTsDta9eYa_I7KA67VAQyTti6AqXpfU6gIaBiXR__2E-kX5UJxT1f_96-n1g9zcmsUAHhxdFaihRr1FHDlXIKKOO9NWGpXnq3nzaY=@proton.me>
Feedback-ID: 94251912:user:proton
X-Pm-Message-ID: db15619d7e5aee43bc84a3156be2cc6d79dcbf65
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Good evening,

I have a Btrfs RAID 1 setup with 2x12TB drives (/dev/sda1 & /dev/sdb1) that=
 keeps mounting itself into R/O

[  +0.001385] BTRFS info (device sdb1): first mount of filesystem 8641eeeb-=
ddf0-47af-8ed0-254327dcc050
[  +0.000017] BTRFS info (device sdb1): using crc32c (crc32c-x86) checksum =
algorithm
[  +0.000005] BTRFS info (device sdb1): using free-space-tree
[  +0.001662] BTRFS info (device sdc1): first mount of filesystem 3f883c84-=
7646-4b29-86b0-0fa581396405
[  +0.000031] BTRFS info (device sdc1): using crc32c (crc32c-x86) checksum =
algorithm
[  +0.000010] BTRFS info (device sdc1): using free-space-tree
[  +0.431024] BTRFS info (device sdb1): bdev /dev/sdb1 errs: wr 0, rd 0, fl=
ush 0, corrupt 122994, gen 0
[  +0.000008] BTRFS info (device sdb1): bdev /dev/sda1 errs: wr 0, rd 0, fl=
ush 0, corrupt 135630, gen 0
[  +0.407229] BTRFS info (device sdc1): bdev /dev/sdc1 errs: wr 0, rd 0, fl=
ush 0, corrupt 892, gen 0
[  +0.000006] BTRFS info (device sdc1): bdev /dev/sdd1 errs: wr 0, rd 0, fl=
ush 0, corrupt 319, gen 0
[Sep 5 00:33] BTRFS info (device sdb1): scrub: started on devid 2
[  +0.000339] BTRFS info (device sdb1): scrub: started on devid 1
[  +5.165674] BTRFS info (device sdc1): scrub: started on devid 2
[  +0.000015] BTRFS info (device sdc1): scrub: started on devid 1
[Sep 5 02:22] BTRFS error (device sdb1): parent transid verify failed on lo=
gical 54114557984768 mirror 2 wanted 1250553 found 1250557
[  +0.023579] BTRFS error (device sdb1): parent transid verify failed on lo=
gical 54114557984768 mirror 1 wanted 1250553 found 1250557
[  +0.000054] BTRFS error (device sdb1 state A): Transaction aborted (error=
 -5)
[  +0.000022] BTRFS: error (device sdb1 state A) in __btrfs_free_extent:321=
1: errno=3D-5 IO failure
[  +0.000019] BTRFS info (device sdb1 state EA): forced readonly
[  +0.000004] BTRFS error (device sdb1 state EA): failed to run delayed ref=
 for logical 53091243642880 num_bytes 102400 type 178 action 2 ref_mod 1: -=
5
[  +0.000027] BTRFS: error (device sdb1 state EA) in btrfs_run_delayed_refs=
:2160: errno=3D-5 IO failure

$ sudo smartctl -x /dev/sda
smartctl 7.4 2023-08-01 r5530 [x86_64-linux-6.14.0-29-generic] (local build=
)
Copyright (C) 2002-23, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Family:     Seagate IronWolf
Device Model:     ST12000VN0008-2YS101
Serial Number:    ZRT1FZST
LU WWN Device Id: 5 000c50 0e89fd96a
Firmware Version: SC60
User Capacity:    12,000,138,625,024 bytes [12.0 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    7200 rpm
Form Factor:      3.5 inches
Device is:        In smartctl database 7.3/5528
ATA Version is:   ACS-4 (minor revision not indicated)
SATA Version is:  SATA 3.3, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Fri Sep  5 03:30:25 2025 UTC
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
AAM feature is:   Unavailable
APM feature is:   Unavailable
Rd look-ahead is: Enabled
Write cache is:   Enabled
DSN feature is:   Disabled
ATA Security is:  Disabled, frozen [SEC2]
Write SCT (Get) Feature Control Command failed: scsi error unsupported fiel=
d in scsi command
Wt Cache Reorder: Unknown (SCT Feature Control command failed)

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82) Offline data collection activity
                                        was completed without error.
                                        Auto Offline Data Collection: Enabl=
ed.
Self-test execution status:      (   0) The previous self-test routine comp=
leted
                                        without error or no self-test has e=
ver=20
                                        been run.
Total time to complete Offline=20
data collection:                (  567) seconds.
Offline data collection
capabilities:                    (0x7b) SMART execute Offline immediate.
                                        Auto Offline data collection on/off=
 support.
                                        Suspend Offline collection upon new
                                        command.
                                        Offline surface scan supported.
                                        Self-test supported.
                                        Conveyance Self-test supported.
                                        Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                        power-saving mode.
                                        Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                        General Purpose Logging supported.
Short self-test routine=20
recommended polling time:        (   1) minutes.
Extended self-test routine
recommended polling time:        (1060) minutes.
Conveyance self-test routine
recommended polling time:        (   2) minutes.
SCT capabilities:              (0x50bd) SCT Status supported.
                                        SCT Error Recovery Control supporte=
d.
                                        SCT Feature Control supported.
                                        SCT Data Table supported.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
  1 Raw_Read_Error_Rate     POSR--   078   064   044    -    70116040
  3 Spin_Up_Time            PO----   090   090   000    -    0
  4 Start_Stop_Count        -O--CK   100   100   020    -    25
  5 Reallocated_Sector_Ct   PO--CK   100   100   010    -    0
  7 Seek_Error_Rate         POSR--   082   060   045    -    157956553
  9 Power_On_Hours          -O--CK   089   089   000    -    9812
 10 Spin_Retry_Count        PO--C-   100   100   097    -    0
 12 Power_Cycle_Count       -O--CK   100   100   020    -    25
 18 Head_Health             PO-R--   100   100   050    -    0
187 Reported_Uncorrect      -O--CK   100   100   000    -    0
188 Command_Timeout         -O--CK   100   100   000    -    0
190 Airflow_Temperature_Cel -O---K   066   064   000    -    34 (Min/Max 27=
/36)
192 Power-Off_Retract_Count -O--CK   100   100   000    -    13
193 Load_Cycle_Count        -O--CK   088   088   000    -    25230
194 Temperature_Celsius     -O---K   034   040   000    -    34 (0 20 0 0 0=
)
197 Current_Pending_Sector  -O--C-   100   100   000    -    0
198 Offline_Uncorrectable   ----C-   100   100   000    -    0
199 UDMA_CRC_Error_Count    -OSRCK   200   200   000    -    0
200 Pressure_Limit          PO---K   100   100   001    -    0
240 Head_Flying_Hours       ------   100   100   000    -    8932h+25m+21.4=
21s
241 Total_LBAs_Written      ------   100   253   000    -    148494496168
242 Total_LBAs_Read         ------   100   253   000    -    138807780706
                            ||||||_ K auto-keep
                            |||||__ C event count
                            ||||___ R error rate
                            |||____ S speed/performance
                            ||_____ O updated online
                            |______ P prefailure warning

General Purpose Log Directory Version 1
SMART           Log Directory Version 1 [multi-sector log support]
Address    Access  R/W   Size  Description
0x00       GPL,SL  R/O      1  Log Directory
0x01           SL  R/O      1  Summary SMART error log
0x02           SL  R/O      5  Comprehensive SMART error log
0x03       GPL     R/O      5  Ext. Comprehensive SMART error log
0x04       GPL     R/O    256  Device Statistics log
0x04       SL      R/O      8  Device Statistics log
0x06           SL  R/O      1  SMART self-test log
0x07       GPL     R/O      1  Extended self-test log
0x08       GPL     R/O      2  Power Conditions log
0x09           SL  R/W      1  Selective self-test log
0x0a       GPL     R/W      8  Device Statistics Notification
0x0c       GPL     R/O   2048  Pending Defects log
0x10       GPL     R/O      1  NCQ Command Error log
0x11       GPL     R/O      1  SATA Phy Event Counters log
0x13       GPL     R/O      1  SATA NCQ Send and Receive log
0x21       GPL     R/O      1  Write stream error log
0x22       GPL     R/O      1  Read stream error log
0x24       GPL     R/O    768  Current Device Internal Status Data log
0x2f       GPL     R/O      1  Set Sector Configuration
0x30       GPL,SL  R/O      9  IDENTIFY DEVICE data log
0x80-0x9f  GPL,SL  R/W     16  Host vendor specific log
0xa1       GPL,SL  VS     160  Device vendor specific log
0xa2       GPL     VS   16320  Device vendor specific log
0xa4       GPL,SL  VS     160  Device vendor specific log
0xa6       GPL     VS     192  Device vendor specific log
0xa8-0xa9  GPL,SL  VS     136  Device vendor specific log
0xab       GPL     VS       1  Device vendor specific log
0xad       GPL     VS      16  Device vendor specific log
0xb1       GPL,SL  VS     160  Device vendor specific log
0xb6       GPL     VS    1920  Device vendor specific log
0xbe-0xbf  GPL     VS   65535  Device vendor specific log
0xc1       GPL,SL  VS       8  Device vendor specific log
0xc3       GPL,SL  VS      24  Device vendor specific log
0xc6       GPL     VS    5184  Device vendor specific log
0xc7       GPL,SL  VS       8  Device vendor specific log
0xc9       GPL,SL  VS       8  Device vendor specific log
0xca       GPL,SL  VS      16  Device vendor specific log
0xcd       GPL,SL  VS       1  Device vendor specific log
0xce       GPL     VS       1  Device vendor specific log
0xcf       GPL     VS     512  Device vendor specific log
0xd1       GPL     VS     656  Device vendor specific log
0xd2       GPL     VS   10256  Device vendor specific log
0xd4       GPL     VS    2048  Device vendor specific log
0xda       GPL,SL  VS       1  Device vendor specific log
0xe0       GPL,SL  R/W      1  SCT Command/Status
0xe1       GPL,SL  R/W      1  SCT Data Transfer

SMART Extended Comprehensive Error Log Version: 1 (5 sectors)
No Errors Logged

SMART Extended Self-test Log Version: 1 (1 sectors)
No self-tests have been logged.  [To run self-tests, use: smartctl -t]

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.

SCT Status Version:                  3
SCT Version (vendor specific):       522 (0x020a)
Device State:                        Active (0)
Current Temperature:                    34 Celsius
Power Cycle Min/Max Temperature:     27/36 Celsius
Lifetime    Min/Max Temperature:     20/51 Celsius
Under/Over Temperature Limit Count:   0/4
SMART Status:                        0xc24f (PASSED)
Vendor specific:
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00

SCT Temperature History Version:     2
Temperature Sampling Period:         4 minutes
Temperature Logging Interval:        59 minutes
Min/Max recommended Temperature:     10/25 Celsius
Min/Max Temperature Limit:            5/70 Celsius
Temperature History Size (Index):    128 (119)

Index    Estimated Time   Temperature Celsius
 120    2025-08-30 21:48    31  ************
 ...    ..(  7 skipped).    ..  ************
   0    2025-08-31 05:40    31  ************
   1    2025-08-31 06:39    30  ***********
 ...    ..(  4 skipped).    ..  ***********
   6    2025-08-31 11:34    30  ***********
   7    2025-08-31 12:33    31  ************
   8    2025-08-31 13:32    31  ************
   9    2025-08-31 14:31    31  ************
  10    2025-08-31 15:30    30  ***********
  11    2025-08-31 16:29    30  ***********
  12    2025-08-31 17:28    30  ***********
  13    2025-08-31 18:27    31  ************
 ...    ..(  7 skipped).    ..  ************
  21    2025-09-01 02:19    31  ************
  22    2025-09-01 03:18    32  *************
  23    2025-09-01 04:17    32  *************
  24    2025-09-01 05:16    32  *************
  25    2025-09-01 06:15    31  ************
  26    2025-09-01 07:14    30  ***********
  27    2025-09-01 08:13    30  ***********
  28    2025-09-01 09:12     ?  -
  29    2025-09-01 10:11    29  **********
  30    2025-09-01 11:10     ?  -
  31    2025-09-01 12:09    30  ***********
  32    2025-09-01 13:08     ?  -
  33    2025-09-01 14:07    30  ***********
  34    2025-09-01 15:06    32  *************
 ...    ..(  3 skipped).    ..  *************
  38    2025-09-01 19:02    32  *************
  39    2025-09-01 20:01    33  **************
 ...    ..(  2 skipped).    ..  **************
  42    2025-09-01 22:58    33  **************
  43    2025-09-01 23:57    35  ****************
  44    2025-09-02 00:56    34  ***************
 ...    ..(  2 skipped).    ..  ***************
  47    2025-09-02 03:53    34  ***************
  48    2025-09-02 04:52    32  *************
  49    2025-09-02 05:51    32  *************
  50    2025-09-02 06:50    32  *************
  51    2025-09-02 07:49    33  **************
  52    2025-09-02 08:48    32  *************
 ...    ..(  3 skipped).    ..  *************
  56    2025-09-02 12:44    32  *************
  57    2025-09-02 13:43    31  ************
  58    2025-09-02 14:42    32  *************
 ...    ..(  8 skipped).    ..  *************
  67    2025-09-02 23:33    32  *************
  68    2025-09-03 00:32    34  ***************
  69    2025-09-03 01:31    34  ***************
  70    2025-09-03 02:30    34  ***************
  71    2025-09-03 03:29    35  ****************
  72    2025-09-03 04:28    34  ***************
  73    2025-09-03 05:27    34  ***************
  74    2025-09-03 06:26    32  *************
 ...    ..( 10 skipped).    ..  *************
  85    2025-09-03 17:15    32  *************
  86    2025-09-03 18:14    31  ************
 ...    ..( 20 skipped).    ..  ************
 107    2025-09-04 14:53    31  ************
 108    2025-09-04 15:52    32  *************
 109    2025-09-04 16:51    31  ************
 110    2025-09-04 17:50    30  ***********
 111    2025-09-04 18:49    29  **********
 112    2025-09-04 19:48    28  *********
 113    2025-09-04 20:47     ?  -
 114    2025-09-04 21:46    28  *********
 115    2025-09-04 22:45     ?  -
 116    2025-09-04 23:44    27  ********
 117    2025-09-05 00:43    35  ****************
 118    2025-09-05 01:42    36  *****************
 119    2025-09-05 02:41    35  ****************

SCT Error Recovery Control:
           Read:     70 (7.0 seconds)
          Write:     70 (7.0 seconds)

Device Statistics (GP Log 0x04)
Page  Offset Size        Value Flags Description
0x01  =3D=3D=3D=3D=3D  =3D               =3D  =3D=3D=3D  =3D=3D General Sta=
tistics (rev 1) =3D=3D
0x01  0x008  4              25  ---  Lifetime Power-On Resets
0x01  0x010  4            9812  ---  Power-on Hours
0x01  0x018  6    148493136176  ---  Logical Sectors Written
0x01  0x020  6       250427503  ---  Number of Write Commands
0x01  0x028  6    138807723416  ---  Logical Sectors Read
0x01  0x030  6       165896990  ---  Number of Read Commands
0x01  0x038  6               -  ---  Date and Time TimeStamp
0x03  =3D=3D=3D=3D=3D  =3D               =3D  =3D=3D=3D  =3D=3D Rotating Me=
dia Statistics (rev 1) =3D=3D
0x03  0x008  4            9810  ---  Spindle Motor Power-on Hours
0x03  0x010  4            8931  ---  Head Flying Hours
0x03  0x018  4           25230  ---  Head Load Events
0x03  0x020  4               0  ---  Number of Reallocated Logical Sectors
0x03  0x028  4               0  ---  Read Recovery Attempts
0x03  0x030  4               0  ---  Number of Mechanical Start Failures
0x03  0x038  4               0  ---  Number of Realloc. Candidate Logical S=
ectors
0x03  0x040  4              13  ---  Number of High Priority Unload Events
0x04  =3D=3D=3D=3D=3D  =3D               =3D  =3D=3D=3D  =3D=3D General Err=
ors Statistics (rev 1) =3D=3D
0x04  0x008  4               0  ---  Number of Reported Uncorrectable Error=
s
0x04  0x010  4               0  ---  Resets Between Cmd Acceptance and Comp=
letion
0x04  0x018  4               0  -D-  Physical Element Status Changed
0x05  =3D=3D=3D=3D=3D  =3D               =3D  =3D=3D=3D  =3D=3D Temperature=
 Statistics (rev 1) =3D=3D
0x05  0x008  1              34  ---  Current Temperature
0x05  0x010  1              31  ---  Average Short Term Temperature
0x05  0x018  1              30  ---  Average Long Term Temperature
0x05  0x020  1              36  ---  Highest Temperature
0x05  0x028  1              25  ---  Lowest Temperature
0x05  0x030  1              33  ---  Highest Average Short Term Temperature
0x05  0x038  1              27  ---  Lowest Average Short Term Temperature
0x05  0x040  1              31  ---  Highest Average Long Term Temperature
0x05  0x048  1              27  ---  Lowest Average Long Term Temperature
0x05  0x050  4               0  ---  Time in Over-Temperature
0x05  0x058  1              70  ---  Specified Maximum Operating Temperatur=
e
0x05  0x060  4               0  ---  Time in Under-Temperature
0x05  0x068  1               5  ---  Specified Minimum Operating Temperatur=
e
0x06  =3D=3D=3D=3D=3D  =3D               =3D  =3D=3D=3D  =3D=3D Transport S=
tatistics (rev 1) =3D=3D
0x06  0x008  4             294  ---  Number of Hardware Resets
0x06  0x010  4             152  ---  Number of ASR Events
0x06  0x018  4               0  ---  Number of Interface CRC Errors
0xff  =3D=3D=3D=3D=3D  =3D               =3D  =3D=3D=3D  =3D=3D Vendor Spec=
ific Statistics (rev 1) =3D=3D
0xff  0x008  7               0  ---  Vendor Specific
0xff  0x010  7               0  ---  Vendor Specific
0xff  0x018  7               0  ---  Vendor Specific
                                |||_ C monitored condition met
                                ||__ D supports DSN
                                |___ N normalized value

Pending Defects log (GP Log 0x0c)
No Defects Logged

SATA Phy Event Counters (GP Log 0x11)
ID      Size     Value  Description
0x000a  2            7  Device-to-host register FISes sent due to a COMRESE=
T
0x0001  2            0  Command failed due to ICRC error
0x0003  2            0  R_ERR response for device-to-host data FIS
0x0004  2            0  R_ERR response for host-to-device data FIS
0x0006  2            0  R_ERR response for device-to-host non-data FIS
0x0007  2            0  R_ERR response for host-to-device non-data FIS

Seagate FARM log (GP Log 0xa6) supported [try: -l farm]

$ sudo smartctl -x /dev/sdb
smartctl 7.4 2023-08-01 r5530 [x86_64-linux-6.14.0-29-generic] (local build=
)
Copyright (C) 2002-23, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Device Model:     WDC WD122KFBX-68CCHN0
Serial Number:    WD-B007HJHD
LU WWN Device Id: 5 0014ee 26c001af8
Firmware Version: 83.00A83
User Capacity:    12,000,138,625,024 bytes [12.0 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    7200 rpm
Form Factor:      3.5 inches
Device is:        Not in smartctl database 7.3/5528
ATA Version is:   ACS-4 published, ANSI INCITS 529-2018
SATA Version is:  SATA 3.2, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Fri Sep  5 03:31:26 2025 UTC
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
AAM feature is:   Unavailable
APM level is:     128 (minimum power consumption without standby)
Rd look-ahead is: Enabled
Write cache is:   Enabled
DSN feature is:   Disabled
ATA Security is:  Disabled, frozen [SEC2]
Wt Cache Reorder: Enabled

Warning! SMART Attribute Thresholds Structure error: invalid SMART checksum=
.
=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00) Offline data collection activity
                                        was never started.
                                        Auto Offline Data Collection: Disab=
led.
Self-test execution status:      (   0) The previous self-test routine comp=
leted
                                        without error or no self-test has e=
ver=20
                                        been run.
Total time to complete Offline=20
data collection:                (25724) seconds.
Offline data collection
capabilities:                    (0x71) SMART execute Offline immediate.
                                        No Auto Offline data collection sup=
port.
                                        Suspend Offline collection upon new
                                        command.
                                        No Offline surface scan supported.
                                        Self-test supported.
                                        Conveyance Self-test supported.
                                        Selective Self-test supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                        power-saving mode.
                                        Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                        General Purpose Logging supported.
Short self-test routine=20
recommended polling time:        (   2) minutes.
Extended self-test routine
recommended polling time:        ( 909) minutes.
Conveyance self-test routine
recommended polling time:        (   6) minutes.
SCT capabilities:              (0x303d) SCT Status supported.
                                        SCT Error Recovery Control supporte=
d.
                                        SCT Feature Control supported.
                                        SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
  1 Raw_Read_Error_Rate     POSR-K   200   200   051    -    0
  2 Throughput_Performance  --S--K   100   100   000    -    0
  3 Spin_Up_Time            POS--K   181   145   021    -    11925
  4 Start_Stop_Count        -O--CK   100   100   000    -    13
  5 Reallocated_Sector_Ct   PO--CK   200   200   140    -    0
  7 Seek_Error_Rate         -OSR-K   100   100   000    -    0
  8 Seek_Time_Performance   --S--K   100   100   000    -    0
  9 Power_On_Hours          -O--CK   097   097   000    -    2735
 10 Spin_Retry_Count        -O--CK   100   100   000    -    0
 11 Calibration_Retry_Count -O--CK   100   100   000    -    0
 12 Power_Cycle_Count       -O--CK   100   100   000    -    13
192 Power-Off_Retract_Count -O--CK   200   200   000    -    5
193 Load_Cycle_Count        -O--CK   200   200   000    -    48
194 Temperature_Celsius     -O---K   115   114   000    -    37
196 Reallocated_Event_Count -O--CK   200   200   000    -    0
197 Current_Pending_Sector  -O--CK   200   200   000    -    0
198 Offline_Uncorrectable   ----CK   100   100   000    -    0
199 UDMA_CRC_Error_Count    -O--CK   200   200   000    -    1
200 Multi_Zone_Error_Rate   ---R--   100   100   000    -    0
                            ||||||_ K auto-keep
                            |||||__ C event count
                            ||||___ R error rate
                            |||____ S speed/performance
                            ||_____ O updated online
                            |______ P prefailure warning

General Purpose Log Directory Version 1
SMART           Log Directory Version 1 [multi-sector log support]
Address    Access  R/W   Size  Description
0x00       GPL,SL  R/O      1  Log Directory
0x01           SL  R/O      1  Summary SMART error log
0x02           SL  R/O      5  Comprehensive SMART error log
0x03       GPL     R/O      6  Ext. Comprehensive SMART error log
0x04       GPL     R/O    256  Device Statistics log
0x04       SL      R/O    255  Device Statistics log
0x06           SL  R/O      1  SMART self-test log
0x07       GPL     R/O      1  Extended self-test log
0x08       GPL     R/O      2  Power Conditions log
0x09           SL  R/W      1  Selective self-test log
0x0a       GPL     R/W    256  Device Statistics Notification
0x0c       GPL     R/O   2048  Pending Defects log
0x0f       GPL     R/O      2  Sense Data for Successful NCQ Cmds log
0x10       GPL     R/O      1  NCQ Command Error log
0x11       GPL     R/O      1  SATA Phy Event Counters log
0x12       GPL     R/O      1  SATA NCQ Non-Data log
0x13       GPL     R/O      1  SATA NCQ Send and Receive log
0x15       GPL     R/W      1  Rebuild Assist log
0x24       GPL     R/O    322  Current Device Internal Status Data log
0x30       GPL,SL  R/O      9  IDENTIFY DEVICE data log
0x53       GPL     R/O      1  Sense Data log
0x80-0x9f  GPL,SL  R/W     16  Host vendor specific log
0xa0-0xa1  GPL,SL  VS      16  Device vendor specific log
0xa3-0xa5  GPL,SL  VS      16  Device vendor specific log
0xa7       GPL,SL  VS      16  Device vendor specific log
0xa8-0xb1  GPL,SL  VS       1  Device vendor specific log
0xb2       GPL     VS   65535  Device vendor specific log
0xb3-0xb6  GPL,SL  VS       1  Device vendor specific log
0xb9           SL  VS       1  Device vendor specific log
0xba       GPL,SL  VS      84  Device vendor specific log
0xbd       GPL,SL  VS       1  Device vendor specific log
0xc0       GPL,SL  VS       1  Device vendor specific log
0xc1       GPL     VS      93  Device vendor specific log
0xd2       GPL,SL  VS       1  Device vendor specific log
0xe0       GPL,SL  R/W      1  SCT Command/Status
0xe1       GPL,SL  R/W      1  SCT Data Transfer

SMART Extended Comprehensive Error Log Version: 1 (6 sectors)
No Errors Logged

SMART Extended Self-test Log Version: 1 (1 sectors)
No self-tests have been logged.  [To run self-tests, use: smartctl -t]

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.

SCT Status Version:                  3
SCT Version (vendor specific):       258 (0x0102)
Device State:                        Active (0)
Current Temperature:                    37 Celsius
Power Cycle Min/Max Temperature:     32/38 Celsius
Lifetime    Min/Max Temperature:     24/38 Celsius
Under/Over Temperature Limit Count:   0/0
Minimum supported ERC Time Limit:    65 (6.5 seconds)
Vendor specific:
01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

SCT Temperature History Version:     2
Temperature Sampling Period:         1 minute
Temperature Logging Interval:        1 minute
Min/Max recommended Temperature:      0/65 Celsius
Min/Max Temperature Limit:           -41/85 Celsius
Temperature History Size (Index):    478 (348)

Index    Estimated Time   Temperature Celsius
 349    2025-09-04 19:34    38  *******************
 ...    ..( 84 skipped).    ..  *******************
 434    2025-09-04 20:59    38  *******************
 435    2025-09-04 21:00    37  ******************
 ...    ..( 12 skipped).    ..  ******************
 448    2025-09-04 21:13    37  ******************
 449    2025-09-04 21:14    34  ***************
 ...    ..(192 skipped).    ..  ***************
 164    2025-09-05 00:27    34  ***************
 165    2025-09-05 00:28    35  ****************
 166    2025-09-05 00:29    34  ***************
 ...    ..( 66 skipped).    ..  ***************
 233    2025-09-05 01:36    34  ***************
 234    2025-09-05 01:37     ?  -
 235    2025-09-05 01:38    30  ***********
 ...    ..(  2 skipped).    ..  ***********
 238    2025-09-05 01:41    30  ***********
 239    2025-09-05 01:42    31  ************
 ...    ..(  3 skipped).    ..  ************
 243    2025-09-05 01:46    31  ************
 244    2025-09-05 01:47    32  *************
 ...    ..(  5 skipped).    ..  *************
 250    2025-09-05 01:53    32  *************
 251    2025-09-05 01:54    33  **************
 ...    ..(  4 skipped).    ..  **************
 256    2025-09-05 01:59    33  **************
 257    2025-09-05 02:00    34  ***************
 258    2025-09-05 02:01     ?  -
 259    2025-09-05 02:02    33  **************
 260    2025-09-05 02:03    33  **************
 261    2025-09-05 02:04    33  **************
 262    2025-09-05 02:05     ?  -
 263    2025-09-05 02:06    31  ************
 264    2025-09-05 02:07    31  ************
 265    2025-09-05 02:08    31  ************
 266    2025-09-05 02:09     ?  -
 267    2025-09-05 02:10    32  *************
 ...    ..(  4 skipped).    ..  *************
 272    2025-09-05 02:15    32  *************
 273    2025-09-05 02:16    33  **************
 ...    ..(  2 skipped).    ..  **************
 276    2025-09-05 02:19    33  **************
 277    2025-09-05 02:20    34  ***************
 ...    ..(  4 skipped).    ..  ***************
 282    2025-09-05 02:25    34  ***************
 283    2025-09-05 02:26    35  ****************
 ...    ..(  6 skipped).    ..  ****************
 290    2025-09-05 02:33    35  ****************
 291    2025-09-05 02:34    36  *****************
 ...    ..( 10 skipped).    ..  *****************
 302    2025-09-05 02:45    36  *****************
 303    2025-09-05 02:46    37  ******************
 ...    ..( 31 skipped).    ..  ******************
 335    2025-09-05 03:18    37  ******************
 336    2025-09-05 03:19    38  *******************
 ...    ..( 11 skipped).    ..  *******************
 348    2025-09-05 03:31    38  *******************

SCT Error Recovery Control:
           Read:     70 (7.0 seconds)
          Write:     70 (7.0 seconds)

Device Statistics (GP Log 0x04)
Page  Offset Size        Value Flags Description
0x01  =3D=3D=3D=3D=3D  =3D               =3D  =3D=3D=3D  =3D=3D General Sta=
tistics (rev 3) =3D=3D
0x01  0x008  4              13  -D-  Lifetime Power-On Resets
0x01  0x010  4            2735  -D-  Power-on Hours
0x01  0x018  6    133338880640  -D-  Logical Sectors Written
0x01  0x020  6       262851767  -D-  Number of Write Commands
0x01  0x028  6    167284315604  -D-  Logical Sectors Read
0x01  0x030  6       163275037  -D-  Number of Read Commands
0x01  0x038  6      1256065408  -D-  Date and Time TimeStamp
0x02  =3D=3D=3D=3D=3D  =3D               =3D  =3D=3D=3D  =3D=3D Free-Fall S=
tatistics (rev 1) =3D=3D
0x02  0x010  4               0  -D-  Overlimit Shock Events
0x03  =3D=3D=3D=3D=3D  =3D               =3D  =3D=3D=3D  =3D=3D Rotating Me=
dia Statistics (rev 1) =3D=3D
0x03  0x008  4            2722  -D-  Spindle Motor Power-on Hours
0x03  0x010  4            2671  -D-  Head Flying Hours
0x03  0x018  4              54  -D-  Head Load Events
0x03  0x020  4               0  -D-  Number of Reallocated Logical Sectors
0x03  0x028  4               8  -D-  Read Recovery Attempts
0x03  0x030  4               0  -D-  Number of Mechanical Start Failures
0x03  0x038  4               0  -D-  Number of Realloc. Candidate Logical S=
ectors
0x03  0x040  4               5  -D-  Number of High Priority Unload Events
0x04  =3D=3D=3D=3D=3D  =3D               =3D  =3D=3D=3D  =3D=3D General Err=
ors Statistics (rev 1) =3D=3D
0x04  0x008  4               0  -D-  Number of Reported Uncorrectable Error=
s
0x04  0x010  4               0  -D-  Resets Between Cmd Acceptance and Comp=
letion
0x05  =3D=3D=3D=3D=3D  =3D               =3D  =3D=3D=3D  =3D=3D Temperature=
 Statistics (rev 1) =3D=3D
0x05  0x008  1              37  ---  Current Temperature
0x05  0x010  1              34  -D-  Average Short Term Temperature
0x05  0x018  1              33  -D-  Average Long Term Temperature
0x05  0x020  1              38  -D-  Highest Temperature
0x05  0x028  1              29  -D-  Lowest Temperature
0x05  0x030  1              35  -D-  Highest Average Short Term Temperature
0x05  0x038  1              31  -D-  Lowest Average Short Term Temperature
0x05  0x040  1              33  -D-  Highest Average Long Term Temperature
0x05  0x048  1              32  -D-  Lowest Average Long Term Temperature
0x05  0x050  4               0  -D-  Time in Over-Temperature
0x05  0x058  1              65  ---  Specified Maximum Operating Temperatur=
e
0x05  0x060  4               0  -D-  Time in Under-Temperature
0x05  0x068  1               0  ---  Specified Minimum Operating Temperatur=
e
0x06  =3D=3D=3D=3D=3D  =3D               =3D  =3D=3D=3D  =3D=3D Transport S=
tatistics (rev 1) =3D=3D
0x06  0x008  4             282  -D-  Number of Hardware Resets
0x06  0x010  4             172  -D-  Number of ASR Events
0x06  0x018  4               1  -D-  Number of Interface CRC Errors
0xff  =3D=3D=3D=3D=3D  =3D               =3D  =3D=3D=3D  =3D=3D Vendor Spec=
ific Statistics (rev 1) =3D=3D
0xff  0x008  7               0  -D-  Vendor Specific
0xff  0x010  7               0  -D-  Vendor Specific
0xff  0x018  7               0  -D-  Vendor Specific
0xff  0x040  7               0  -D-  Vendor Specific
0xff  0x048  7               0  -D-  Vendor Specific
0xff  0x050  7               0  -D-  Vendor Specific
0xff  0x058  7               0  -D-  Vendor Specific
0xff  0x060  7               0  -D-  Vendor Specific
0xff  0x068  7               0  -D-  Vendor Specific
0xff  0x070  7             338  -D-  Vendor Specific
0xff  0x078  7               0  -D-  Vendor Specific
0xff  0x080  7               0  -D-  Vendor Specific
0xff  0x088  7             235  -D-  Vendor Specific
0xff  0x090  7            4838  -D-  Vendor Specific
0xff  0x098  7           11887  -D-  Vendor Specific
0xff  0x0a0  7             100  -D-  Vendor Specific
                                |||_ C monitored condition met
                                ||__ D supports DSN
                                |___ N normalized value

Pending Defects log (GP Log 0x0c)
No Defects Logged

SATA Phy Event Counters (GP Log 0x11)
ID      Size     Value  Description
0x0001  2            1  Command failed due to ICRC error
0x0002  2            0  R_ERR response for data FIS
0x0003  2            0  R_ERR response for device-to-host data FIS
0x0004  2            0  R_ERR response for host-to-device data FIS
0x0005  2            0  R_ERR response for non-data FIS
0x0006  2            0  R_ERR response for device-to-host non-data FIS
0x0007  2            0  R_ERR response for host-to-device non-data FIS
0x0008  2            0  Device-to-host non-data FIS retries
0x0009  2            8  Transition from drive PhyRdy to drive PhyNRdy
0x000a  2           11  Device-to-host register FISes sent due to a COMRESE=
T
0x000b  2            0  CRC errors within host-to-device FIS
0x000d  2            0  Non-CRC errors within host-to-device FIS
0x000f  2            0  R_ERR response for host-to-device data FIS, CRC
0x0012  2            0  R_ERR response for host-to-device non-data FIS, CRC
0x8000  4        10985  Vendor specific


Please let me know if you need any more info?


Sent with Proton Mail secure email.

