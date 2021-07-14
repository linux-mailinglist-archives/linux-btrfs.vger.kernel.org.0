Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AC93C8689
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 17:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbhGNPDR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 11:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhGNPDQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 11:03:16 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7953C06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 08:00:23 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id r25so1148050vsk.2
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 08:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P9HMRp14zPXNCwvdRKiyCox8f9c+6uCGj1UO7u/gK8w=;
        b=M9cD1H8J5R04NhPAJoJdXzYUdxQHLi3BDVl8MF19/ZRXmP6QS3lyz/RXZNY4oWgCKe
         cp6Y49wZknM7R869gpCaq/vAlORTJP3Oo7DzrADPSlvkNzVOqaeUoDvU12zMhe3AoEIf
         BFmXij5Gqho1F7f/znWB462Pgw83vAawy+mqbNfZ0dTtQgJKkBZjCX/35DiHOJhnETQT
         qmyQw03+qi32CBklMKDM/uK4w37OSGBz9OQpB7Je9kV4TcbON/hplhPEenxbhmWc6iZW
         cIFZkBWEM1P4zsmRQ1gW3v5Oe/MbEcnZ+dOmiJtFdcrKkaNwNknH9AyvebcVHAMcdUd6
         as8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P9HMRp14zPXNCwvdRKiyCox8f9c+6uCGj1UO7u/gK8w=;
        b=V38nVYLgCcwaGlM618u+D1dpq4NsI5CZjpZLeoWgGH1K0po/rCtf721/FbZ+PdtQj+
         EFVZ6/2y7nhsWCpb2wMKJMGF/ePmvqC57Vt3Dzq79psrED6ToOQaB2MpO/Kwoc2UNMCa
         jNawWD2Pi1hV0+P2ccq54tgfdHJcE13zwimpARNYECEnCLTfWvYlB9aQkPrclzROCUB+
         y+HvWPlu5zwI6HaJbjWzy0246Dj5HbAfjTmcI6gBm5ccBDHsZva5WcfGf6RhdnWM84iT
         Uthe+0Ipxz+KsOo0l4Itx/QP9gGtSO0KgLMe/pMFLSnfOC5ShoepFyQxpoiXG6RjQ7/1
         1m7A==
X-Gm-Message-State: AOAM532o5Yjbt1mYacMklqluAtPjAjseZ9oA6EACpnZpKXWUu1QdQ2xE
        uYHbJZ3IFmL4W0Dc8lW1kulCkRCeN1dmTfcm49A=
X-Google-Smtp-Source: ABdhPJwdrCbiMHVL3fBi1tVpvs/lAeFBibSMF1lTKhSRo8uP4mUvwUdb8Ebq495n1et8t/KRVBrsbvzaB7Izzb5JHJ0=
X-Received: by 2002:a05:6102:209c:: with SMTP id h28mr14388450vsr.21.1626274822640;
 Wed, 14 Jul 2021 08:00:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:1447:0:0:0:0:0 with HTTP; Wed, 14 Jul 2021 08:00:22
 -0700 (PDT)
In-Reply-To: <CAJ9tZB-O+xphuHJ-DhpjvoFFuFAJrSpoMuurx_44s040YWBtqQ@mail.gmail.com>
References: <CAJ9tZB_VHc4x3hMpjW6h_3gr5tCcdK7RpOUcAdpLuR5PVpW8EQ@mail.gmail.com>
 <110a038d-a542-dcf5-38b8-5f15ee97eb2c@tnonline.net> <2a9b53ea-fd95-5a92-34a5-3dcac304cec1@gmx.com>
 <CAJ9tZB9X=iWvUSuyE=nPJ8Chge4E_f-9o67A-d=zt4ZAnXjeCg@mail.gmail.com>
 <9e4f970a-a8c5-8b96-d0bb-d527830d0d12@suse.com> <CAJ9tZB_C+RLX0oRTKuUZv0ZxGQiWOL=1EGzM=rHD0gMhgbhGmA@mail.gmail.com>
 <c0024688-3361-7e15-21d1-c55bc16fa83e@gmx.com> <CAJ9tZB-O+xphuHJ-DhpjvoFFuFAJrSpoMuurx_44s040YWBtqQ@mail.gmail.com>
From:   Zhenyu Wu <wuzy001@gmail.com>
Date:   Wed, 14 Jul 2021 23:00:22 +0800
Message-ID: <CAJ9tZB-vAaoON-ewoEXLx6qoPS_7cZsq3Rx=pWOaN-dE1B82cw@mail.gmail.com>
Subject: Re: btrfs cannot be mounted or checked
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, Forza <forza@tnonline.net>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

smartctl exists in archlinux live USB.

```
# smartctl -x /dev/sda
smartctl 7.2 2020-12-30 r5155 [x86_64-linux-5.12.13-arch1-2] (local build)
Copyright (C) 2002-20, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Model Family:     Seagate Laptop HDD
Device Model:     ST500LT012-1DG142
Serial Number:    SBY85S8Y
LU WWN Device Id: 5 000c50 0a84e3995
Firmware Version: 0002SDM1
User Capacity:    500,107,862,016 bytes [500 GB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    5400 rpm
Form Factor:      2.5 inches
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ATA8-ACS T13/1699-D revision 4
SATA Version is:  SATA 3.0, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Wed Jul 14 14:53:11 2021 UTC
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
AAM feature is:   Unavailable
APM level is:     128 (minimum power consumption without standby)
Rd look-ahead is: Enabled
Write cache is:   Enabled
DSN feature is:   Unavailable
ATA Security is:  Disabled, frozen [SEC2]
Wt Cache Reorder: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00)	Offline data collection activity
					was never started.
					Auto Offline Data Collection: Disabled.
Self-test execution status:      (   0)	The previous self-test routine comp=
leted
					without error or no self-test has ever
					been run.
Total time to complete Offline
data collection: 		(    0) seconds.
Offline data collection
capabilities: 			 (0x73) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					No Offline surface scan supported.
					Self-test supported.
					Conveyance Self-test supported.
					Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					General Purpose Logging supported.
Short self-test routine
recommended polling time: 	 (   1) minutes.
Extended self-test routine
recommended polling time: 	 (  99) minutes.
Conveyance self-test routine
recommended polling time: 	 (   2) minutes.
SCT capabilities: 	       (0x1035)	SCT Status supported.
					SCT Feature Control supported.
					SCT Data Table supported.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
  1 Raw_Read_Error_Rate     POSR--   106   099   006    -    10870616
  3 Spin_Up_Time            PO----   099   098   000    -    0
  4 Start_Stop_Count        -O--CK   094   094   020    -    6612
  5 Reallocated_Sector_Ct   PO--CK   100   100   036    -    0
  7 Seek_Error_Rate         POSR--   073   060   030    -    60468900788
  9 Power_On_Hours          -O--CK   091   091   000    -    8240 (177 169 =
0)
 10 Spin_Retry_Count        PO--C-   100   100   097    -    0
 12 Power_Cycle_Count       -O--CK   099   099   020    -    1958
184 End-to-End_Error        -O--CK   100   100   099    -    0
187 Reported_Uncorrect      -O--CK   100   100   000    -    0
188 Command_Timeout         -O--CK   100   099   000    -    1
189 High_Fly_Writes         -O-RCK   100   100   000    -    0
190 Airflow_Temperature_Cel -O---K   068   056   045    -    32 (Min/Max 31=
/33)
191 G-Sense_Error_Rate      -O--CK   100   100   000    -    1011
192 Power-Off_Retract_Count -O--CK   100   100   000    -    3
193 Load_Cycle_Count        -O--CK   001   001   000    -    486026
194 Temperature_Celsius     -O---K   032   044   000    -    32 (0 7 0 0 0)
197 Current_Pending_Sector  -O--C-   100   100   000    -    0
198 Offline_Uncorrectable   ----C-   100   100   000    -    0
199 UDMA_CRC_Error_Count    -OSRCK   200   200   000    -    0
240 Head_Flying_Hours       ------   093   093   000    -    6674 (140 75 0=
)
241 Total_LBAs_Written      ------   100   253   000    -    48132007448
242 Total_LBAs_Read         ------   100   253   000    -    89410660754
254 Free_Fall_Sensor        -O--CK   100   100   000    -    0
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
0x06           SL  R/O      1  SMART self-test log
0x07       GPL     R/O      1  Extended self-test log
0x09           SL  R/W      1  Selective self-test log
0x10       GPL     R/O      1  NCQ Command Error log
0x11       GPL     R/O      1  SATA Phy Event Counters log
0x21       GPL     R/O      1  Write stream error log
0x22       GPL     R/O      1  Read stream error log
0x80-0x9f  GPL,SL  R/W     16  Host vendor specific log
0xa1       GPL,SL  VS      20  Device vendor specific log
0xa2       GPL     VS    2248  Device vendor specific log
0xa8       GPL,SL  VS      65  Device vendor specific log
0xa9       GPL,SL  VS       1  Device vendor specific log
0xab       GPL     VS       1  Device vendor specific log
0xb0       GPL     VS    2864  Device vendor specific log
0xbd-0xbf  GPL     VS   65535  Device vendor specific log
0xc0       GPL,SL  VS       1  Device vendor specific log
0xc1       GPL,SL  VS      10  Device vendor specific log
0xc3       GPL,SL  VS       8  Device vendor specific log
0xc4       GPL,SL  VS      18  Device vendor specific log
0xe0       GPL,SL  R/W      1  SCT Command/Status
0xe1       GPL,SL  R/W      1  SCT Data Transfer

SMART Extended Comprehensive Error Log Version: 1 (5 sectors)
No Errors Logged

SMART Extended Self-test Log Version: 1 (1 sectors)
Num  Test_Description    Status                  Remaining
LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed without error       00%      8079       =
  -
# 2  Short offline       Interrupted (host reset)      00%       663       =
  -
# 3  Extended offline    Completed without error       00%        27       =
  -
# 4  Short offline       Completed without error       00%        23       =
  -
# 5  Short offline       Completed without error       00%         0       =
  -

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
Current Temperature:                    33 Celsius
Power Cycle Min/Max Temperature:     31/33 Celsius
Lifetime    Min/Max Temperature:      7/46 Celsius
Specified Max Operating Temperature:    32 Celsius
Under/Over Temperature Limit Count:   0/0

SCT Temperature History Version:     2
Temperature Sampling Period:         1 minute
Temperature Logging Interval:        30 minutes
Min/Max recommended Temperature:     14/55 Celsius
Min/Max Temperature Limit:           10/60 Celsius
Temperature History Size (Index):    128 (42)

Index    Estimated Time   Temperature Celsius
  43    2021-07-11 23:00    41  **********************
 ...    ..( 27 skipped).    ..  **********************
  71    2021-07-12 13:00    41  **********************
  72    2021-07-12 13:30    42  ***********************
 ...    ..( 23 skipped).    ..  ***********************
  96    2021-07-13 01:30    42  ***********************
  97    2021-07-13 02:00    41  **********************
 ...    ..( 15 skipped).    ..  **********************
 113    2021-07-13 10:00    41  **********************
 114    2021-07-13 10:30    42  ***********************
 ...    ..(  5 skipped).    ..  ***********************
 120    2021-07-13 13:30    42  ***********************
 121    2021-07-13 14:00    43  ************************
 ...    ..(  3 skipped).    ..  ************************
 125    2021-07-13 16:00    43  ************************
 126    2021-07-13 16:30    42  ***********************
 127    2021-07-13 17:00    42  ***********************
   0    2021-07-13 17:30    42  ***********************
   1    2021-07-13 18:00    41  **********************
   2    2021-07-13 18:30    42  ***********************
 ...    ..( 10 skipped).    ..  ***********************
  13    2021-07-14 00:00    42  ***********************
  14    2021-07-14 00:30    41  **********************
 ...    ..(  9 skipped).    ..  **********************
  24    2021-07-14 05:30    41  **********************
  25    2021-07-14 06:00    44  *************************
 ...    ..(  2 skipped).    ..  *************************
  28    2021-07-14 07:30    44  *************************
  29    2021-07-14 08:00    37  ******************
  30    2021-07-14 08:30    39  ********************
  31    2021-07-14 09:00    42  ***********************
  32    2021-07-14 09:30    43  ************************
  33    2021-07-14 10:00    43  ************************
  34    2021-07-14 10:30    43  ************************
  35    2021-07-14 11:00    35  ****************
  36    2021-07-14 11:30    35  ****************
  37    2021-07-14 12:00    37  ******************
  38    2021-07-14 12:30    34  ***************
  39    2021-07-14 13:00     ?  -
  40    2021-07-14 13:30    31  ************
  41    2021-07-14 14:00     ?  -
  42    2021-07-14 14:30    31  ************

SCT Error Recovery Control command not supported

Device Statistics (GP/SMART Log 0x04) not supported

Pending Defects log (GP Log 0x0c) not supported

SATA Phy Event Counters (GP Log 0x11)
ID      Size     Value  Description
0x000a  2            3  Device-to-host register FISes sent due to a COMRESE=
T
0x0001  2            0  Command failed due to ICRC error
0x0003  2            0  R_ERR response for device-to-host data FIS
0x0004  2            0  R_ERR response for host-to-device data FIS
0x0006  2            0  R_ERR response for device-to-host non-data FIS
0x0007  2            0  R_ERR response for host-to-device non-data FIS
```

Thanks!

On 7/14/21, Zhenyu Wu <wuzy001@gmail.com> wrote:
> I found btrfs-5.12 in archlinux (surprisedly)
>
> When I try to mount with ro, rescue=3Dibadroots, I will get
> ```
> wrong fs type, bad option, bad superblock on
> /dev/sda2, missing codepage or helper program, or other error.
> ```
>
> dmesg will output
> ```
> [ 1087.646701] BTRFS info (device sda2): ignoring bad roots
> [ 1087.646725] BTRFS info (device sda2): disk space caching is enabled
> [ 1087.646735] BTRFS info (device sda2): has skinny extents
> [ 1087.770464] BTRFS info (device sda2): bdev /dev/sda2 errs: wr 0, rd
> 0, flush 0, corrupt 5, gen 0
> [ 1087.834263] BTRFS critical (device sda2): corrupt leaf: root=3D2
> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D1073741824, in=
valid
> block group used, have 1073754112 expect [0, 1073741824)
> [ 1087.834550] BTRFS error (device sda2): block=3D273006592 read time
> tree block corruption detected
> [ 1087.848452] BTRFS critical (device sda2): corrupt leaf: root=3D2
> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D1073741824, in=
valid
> block group used, have 1073754112 expect [0, 1073741824)
> [ 1087.848762] BTRFS error (device sda2): block=3D273006592 read time
> tree block corruption detected
> [ 1087.849006] BTRFS error (device sda2): failed to read block groups: -5
> [ 1087.851674] BTRFS error (device sda2): open_ctree failed
> ```
> does it mean my extent tree is still intact? so I need to btrfs ins
> dump-tree, btrfs-map-logical?
> thanks!
>
> On 7/14/21, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>> On 2021/7/14 =E4=B8=8B=E5=8D=885:58, Zhenyu Wu wrote:
>>> ```
>>> [  301.533172] BTRFS info (device sda2): unrecognized rescue option
>>> 'ibadroots'
>>> [  301.533209] BTRFS error (device sda2): open_ctree failed
>>> ```
>>>
>>> Does ibadroots need a newer version of btrfs? My btrfs version is
>>> 5.10.1.
>>
>> Oh, that support is added in v5.11...
>>
>> You may want to grab a liveCD from some rolling release.
>>
>> But even with v5.11, it may not help much, as that option won't help if
>> your extent tree is still intact.
>>
>> You may want to use "btrfs ins dump-tree" to locate your extent tree,
>> then corrupt the extent tree root completely (using btrfs-map-logical to
>> get the physical offset, then dd to destory the first 4 bytes of both
>> copy), then the option would properly work.
>>
>> Thanks,
>> Qu
>>>
>>> Thanks!
>>>
>>> On 7/14/21, Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>>
>>>> On 2021/7/14 =E4=B8=8B=E5=8D=884:49, Zhenyu Wu wrote:
>>>>> sorry for late:(
>>>>>
>>>>> I found <https://bbs.archlinux.org/viewtopic.php?id=3D233724> looks s=
ame
>>>>> as my situation. But in my computer (boot from live usb) `btrfs check
>>>>> --init-extent-tree` output a lot of non-ascii character (maybe becaus=
e
>>>>> ansi escape code mess the terminal)
>>>>> after several days it outputs `7/7`and `killed`. The solution looks
>>>>> failed.
>>>>>
>>>>> I'm sorry because my live usb don't have smartctl :(
>>>>>
>>>>> ```
>>>>> $ hdparm -W0 /dev/sda
>>>>> /dev/sda:
>>>>>    setting drive write-caching to 0 (off)
>>>>>    write-caching =3D  0 (off)
>>>>> ```
>>>>>
>>>>> But now the btrfs partition still cannot be mounted.
>>>>>
>>>>> when I try to mount it with `usebackuproot`, it will output the same
>>>>> error message. And dmesg will output
>>>>> ```
>>>>> [250062.064785] BTRFS warning (device sda2): 'usebackuproot' is
>>>>> deprecated, use 'rescue=3Dusebackuproot' instead
>>>>> [250062.064788] BTRFS info (device sda2): trying to use backup root a=
t
>>>>> mount time
>>>>> [250062.064789] BTRFS info (device sda2): disk space caching is
>>>>> enabled
>>>>> [250062.064790] BTRFS info (device sda2): has skinny extents
>>>>> [250062.208403] BTRFS info (device sda2): bdev /dev/sda2 errs: wr 0,
>>>>> rd 0, flush 0, corrupt 5, gen 0
>>>>> [250062.277045] BTRFS critical (device sda2): corrupt leaf: root=3D2
>>>>> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D1073741824=
, invalid
>>>>> block group used, have 1073754112 expect [0, 1073741824)
>>>>
>>>> Looks like a bad extent tree re-initialization, a bug in btrfs-progs
>>>> then.
>>>>
>>>> For now, you can try to mount with "ro,rescue=3Dibadroots" to see if i=
t
>>>> can be mounted RO, then rescue your data.
>>>>
>>>> Thanks,
>>>> Qu
>>>>> [250062.277048] BTRFS error (device sda2): block=3D273006592 read tim=
e
>>>>> tree block corruption detected
>>>>> [250062.291924] BTRFS critical (device sda2): corrupt leaf: root=3D2
>>>>> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D1073741824=
, invalid
>>>>> block group used, have 1073754112 expect [0, 1073741824)
>>>>> [250062.291927] BTRFS error (device sda2): block=3D273006592 read tim=
e
>>>>> tree block corruption detected
>>>>> [250062.291943] BTRFS error (device sda2): failed to read block
>>>>> groups:
>>>>> -5
>>>>> [250062.292897] BTRFS error (device sda2): open_ctree failed
>>>>> ```
>>>>>
>>>>> If don't usebackuproot, dmesg will output the same log except the
>>>>> first
>>>>> 2
>>>>> lines.
>>>>>
>>>>> Now btrfs check can check this partition:
>>>>>
>>>>> ```
>>>>> $ btrfs check /dev/sda2 2>&1|tee check.txt
>>>>> # see attachment
>>>>> ```
>>>>>
>>>>> Does my disk have any hope to be rescued?
>>>>> thanks!
>>>>>
>>>>> On 7/11/21, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>>>
>>>>>>
>>>>>> On 2021/7/11 =E4=B8=8B=E5=8D=887:37, Forza wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2021-07-11 10:59, Zhenyu Wu wrote:
>>>>>>>> Sorry for my disturbance.
>>>>>>>> After a dirty reboot because of a computer crash, my btrfs
>>>>>>>> partition
>>>>>>>> cannot be mounted. The same thing happened before, but now `btrfs
>>>>>>>> rescue zero-log` cannot work.
>>>>>>>> ```
>>>>>>>> $ uname -r
>>>>>>>> 5.10.27-gentoo-x86_64
>>>>>>>> $ btrfs rescue zero-log /dev/sda2
>>>>>>>> Clearing log on /dev/sda2, previous log_root 0, level 0
>>>>>>>> $ mount /dev/sda2 /mnt/gentoo
>>>>>>>> mount: /mnt/gentoo: wrong fs type, bad option, bad superblock on
>>>>>>>> /dev/sda2, missing codepage or helper program, or other error.
>>>>>>>> $ btrfs check /dev/sda2
>>>>>>>> parent transid verify failed on 34308096 wanted 962175 found 96176=
4
>>>>>>>> parent transid verify failed on 34308096 wanted 962175 found 96176=
4
>>>>>>>> parent transid verify failed on 34308096 wanted 962175 found 96176=
4
>>>>>>>> Ignoring transid failure
>>>>>>>> leaf parent key incorrect 34308096
>>>>>>>> ERROR: failed to read block groups: Operation not permitted
>>>>>>>> ERROR: cannot open file system
>>>>>>>> $ dmesg 2>&1|tee dmesg.txt
>>>>>>>> # see attachment
>>>>>>>> ```
>>>>>>>> Like `mount -o ro,usebackuproot` cannot work, too.
>>>>>>>>
>>>>>>>> Thanks for any help!
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Hi!
>>>>>>>
>>>>>>> Parent transid failed is hard to recover from, as mentioned on
>>>>>>> https://btrfs.wiki.kernel.org/index.php/FAQ#How_do_I_recover_from_a=
_.22parent_transid_verify_failed.22_error.3F
>>>>>>>
>>>>>>>
>>>>>>> I see you have "corrupt 5" sectors in dmesg. Is your disk healthy?
>>>>>>> You
>>>>>>> can check with "smartctl -x /dev/sda" to determine the health.
>>>>>>>
>>>>>>> One way of avoiding this error is to disable write-cache. Parent
>>>>>>> transid
>>>>>>> failed can happen when the disk re-orders writes in its write cache
>>>>>>> before flushing to disk. This violates barriers, but it is
>>>>>>> unfortately
>>>>>>> common. If you have a crash, SATA bus reset or other issues,
>>>>>>> unwritten
>>>>>>> content is lost. The problem here is the re-ordering. The superbloc=
k
>>>>>>> is
>>>>>>> written out before other metadata (which is now lost due to the
>>>>>>> crash).
>>>>>>
>>>>>> To be extra accurate, all filesysmtems have taken the re-order into
>>>>>> consideration.
>>>>>> Thus we have flush (or called barrier) command to force the disk to
>>>>>> write all its cache back to disk or at least non-volatile cache.
>>>>>>
>>>>>> Combined with mandatory metadata CoW, it means, no matter what the
>>>>>> disk
>>>>>> re-order or not, we should only see either the newer data after the
>>>>>> flush, or the older data before the flush.
>>>>>>
>>>>>> But unfortunately, hardware is unreliable, sometimes even lies about
>>>>>> its
>>>>>> flush command.
>>>>>> Thus it's possible some disks, especially some cheap RAID cards, ten=
d
>>>>>> to
>>>>>> just ignore such flush commands, thus leaves the data corrupted afte=
r
>>>>>> a
>>>>>> power loss.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>>>
>>>>>>> You disable write cache with "hdparm -W0 /dev/sda". It might be
>>>>>>> worth
>>>>>>> adding this to a cron-job every 5 minutes or so, as the setting is
>>>>>>> not
>>>>>>> persistent and can get reset if the disk looses power, goes to
>>>>>>> sleep,
>>>>>>> etc.
>>>>>>
>>>>
>>>>
>>
>
