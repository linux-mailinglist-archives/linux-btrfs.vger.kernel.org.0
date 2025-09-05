Return-Path: <linux-btrfs+bounces-16639-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFB9B455DA
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 13:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C232D1B24F8F
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 11:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B050343D69;
	Fri,  5 Sep 2025 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="G2EaIM2v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (unknown [62.3.69.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF09734A32C
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.3.69.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070670; cv=none; b=A+A0X0RMp4/eFg3+RB0gf2uZr73SjpDjuEVNl5kqlIPsRdVKi4iYhI0dUM8wn28xn/KjIOu3WsAnskFE4xcdRySfZ0MLtJU93XsLEZvSA7u8OuTRBh0rcda7QGyQ4QHi6ahC8HfiCpH2mZvVklkblVQ0rtdBCZa6qVULFou80Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070670; c=relaxed/simple;
	bh=S2YUEsBa0RPxsi82vi+Q+VxCwZDH13iLnLP5bphi6Fw=;
	h=Message-ID:Date:Mime-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=clqzJgqOCO2rEdZd/zgrCUirnLnG8d6JqKGZI0vtje2JaHvXbkOKenLl22rZRBmkVI0U87UFnAea8yKsUHjnHI+jyHdBIuYDzvk6mXekXDkjsBF44Fso2zurPadBRFxi3zA7PGbh3pga7bXsTWISOtNiP6q+Mkb1saaUa6lRWnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=fail smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=G2EaIM2v; arc=none smtp.client-ip=62.3.69.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 4A8492B2BBB;
	Fri,  5 Sep 2025 12:10:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1757070649;
	bh=FhC5Hz8VFuE/e0R9cFOO1UXBhMVsURMkH+Um70FVHP4=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=G2EaIM2v9aTvs65GsccDWRf/uLnzY9kZ7aqjFCNjghIPMfztnkFjMxEBFx0ewbhv5
	 AOlPW97RKlm82GR/br3+IAKU90FSOQZLdMXBKTyenM7Y7PBo0jfy+OOOQU6J/pFDtf
	 jHsh+/NKIGS4xY6vZ1n9pPILdK7HkUhxfNlP37zo=
Message-ID: <ceac63e5-90f8-4c3e-a71b-8c0a19bd5083@harmstone.com>
Date: Fri, 5 Sep 2025 12:10:49 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: Btrfs RAID 1 mounting as R/O
To: jonas.timothy@proton.me,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <AIOTMBnTsDta9eYa_I7KA67VAQyTti6AqXpfU6gIaBiXR__2E-kX5UJxT1f_96-n1g9zcmsUAHhxdFaihRr1FHDlXIKKOO9NWGpXnq3nzaY=@proton.me>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <AIOTMBnTsDta9eYa_I7KA67VAQyTti6AqXpfU6gIaBiXR__2E-kX5UJxT1f_96-n1g9zcmsUAHhxdFaihRr1FHDlXIKKOO9NWGpXnq3nzaY=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

If all four of your disks have corruption, that implies you have a faulty
SATA controller. You need a new motherboard.

The SMART tests won't pick this up as they run on the devices themselves.

On 05/09/2025 4.33 am, jonas.timothy@proton.me wrote:
> Good evening,
> 
> I have a Btrfs RAID 1 setup with 2x12TB drives (/dev/sda1 & /dev/sdb1) that keeps mounting itself into R/O
> 
> [  +0.001385] BTRFS info (device sdb1): first mount of filesystem 8641eeeb-ddf0-47af-8ed0-254327dcc050
> [  +0.000017] BTRFS info (device sdb1): using crc32c (crc32c-x86) checksum algorithm
> [  +0.000005] BTRFS info (device sdb1): using free-space-tree
> [  +0.001662] BTRFS info (device sdc1): first mount of filesystem 3f883c84-7646-4b29-86b0-0fa581396405
> [  +0.000031] BTRFS info (device sdc1): using crc32c (crc32c-x86) checksum algorithm
> [  +0.000010] BTRFS info (device sdc1): using free-space-tree
> [  +0.431024] BTRFS info (device sdb1): bdev /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 122994, gen 0
> [  +0.000008] BTRFS info (device sdb1): bdev /dev/sda1 errs: wr 0, rd 0, flush 0, corrupt 135630, gen 0
> [  +0.407229] BTRFS info (device sdc1): bdev /dev/sdc1 errs: wr 0, rd 0, flush 0, corrupt 892, gen 0
> [  +0.000006] BTRFS info (device sdc1): bdev /dev/sdd1 errs: wr 0, rd 0, flush 0, corrupt 319, gen 0
> [Sep 5 00:33] BTRFS info (device sdb1): scrub: started on devid 2
> [  +0.000339] BTRFS info (device sdb1): scrub: started on devid 1
> [  +5.165674] BTRFS info (device sdc1): scrub: started on devid 2
> [  +0.000015] BTRFS info (device sdc1): scrub: started on devid 1
> [Sep 5 02:22] BTRFS error (device sdb1): parent transid verify failed on logical 54114557984768 mirror 2 wanted 1250553 found 1250557
> [  +0.023579] BTRFS error (device sdb1): parent transid verify failed on logical 54114557984768 mirror 1 wanted 1250553 found 1250557
> [  +0.000054] BTRFS error (device sdb1 state A): Transaction aborted (error -5)
> [  +0.000022] BTRFS: error (device sdb1 state A) in __btrfs_free_extent:3211: errno=-5 IO failure
> [  +0.000019] BTRFS info (device sdb1 state EA): forced readonly
> [  +0.000004] BTRFS error (device sdb1 state EA): failed to run delayed ref for logical 53091243642880 num_bytes 102400 type 178 action 2 ref_mod 1: -5
> [  +0.000027] BTRFS: error (device sdb1 state EA) in btrfs_run_delayed_refs:2160: errno=-5 IO failure
> 
> $ sudo smartctl -x /dev/sda
> smartctl 7.4 2023-08-01 r5530 [x86_64-linux-6.14.0-29-generic] (local build)
> Copyright (C) 2002-23, Bruce Allen, Christian Franke, www.smartmontools.org
> 
> === START OF INFORMATION SECTION ===
> Model Family:     Seagate IronWolf
> Device Model:     ST12000VN0008-2YS101
> Serial Number:    ZRT1FZST
> LU WWN Device Id: 5 000c50 0e89fd96a
> Firmware Version: SC60
> User Capacity:    12,000,138,625,024 bytes [12.0 TB]
> Sector Sizes:     512 bytes logical, 4096 bytes physical
> Rotation Rate:    7200 rpm
> Form Factor:      3.5 inches
> Device is:        In smartctl database 7.3/5528
> ATA Version is:   ACS-4 (minor revision not indicated)
> SATA Version is:  SATA 3.3, 6.0 Gb/s (current: 6.0 Gb/s)
> Local Time is:    Fri Sep  5 03:30:25 2025 UTC
> SMART support is: Available - device has SMART capability.
> SMART support is: Enabled
> AAM feature is:   Unavailable
> APM feature is:   Unavailable
> Rd look-ahead is: Enabled
> Write cache is:   Enabled
> DSN feature is:   Disabled
> ATA Security is:  Disabled, frozen [SEC2]
> Write SCT (Get) Feature Control Command failed: scsi error unsupported field in scsi command
> Wt Cache Reorder: Unknown (SCT Feature Control command failed)
> 
> === START OF READ SMART DATA SECTION ===
> SMART overall-health self-assessment test result: PASSED
> 
> General SMART Values:
> Offline data collection status:  (0x82) Offline data collection activity
>                                          was completed without error.
>                                          Auto Offline Data Collection: Enabled.
> Self-test execution status:      (   0) The previous self-test routine completed
>                                          without error or no self-test has ever
>                                          been run.
> Total time to complete Offline
> data collection:                (  567) seconds.
> Offline data collection
> capabilities:                    (0x7b) SMART execute Offline immediate.
>                                          Auto Offline data collection on/off support.
>                                          Suspend Offline collection upon new
>                                          command.
>                                          Offline surface scan supported.
>                                          Self-test supported.
>                                          Conveyance Self-test supported.
>                                          Selective Self-test supported.
> SMART capabilities:            (0x0003) Saves SMART data before entering
>                                          power-saving mode.
>                                          Supports SMART auto save timer.
> Error logging capability:        (0x01) Error logging supported.
>                                          General Purpose Logging supported.
> Short self-test routine
> recommended polling time:        (   1) minutes.
> Extended self-test routine
> recommended polling time:        (1060) minutes.
> Conveyance self-test routine
> recommended polling time:        (   2) minutes.
> SCT capabilities:              (0x50bd) SCT Status supported.
>                                          SCT Error Recovery Control supported.
>                                          SCT Feature Control supported.
>                                          SCT Data Table supported.
> 
> SMART Attributes Data Structure revision number: 10
> Vendor Specific SMART Attributes with Thresholds:
> ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
>    1 Raw_Read_Error_Rate     POSR--   078   064   044    -    70116040
>    3 Spin_Up_Time            PO----   090   090   000    -    0
>    4 Start_Stop_Count        -O--CK   100   100   020    -    25
>    5 Reallocated_Sector_Ct   PO--CK   100   100   010    -    0
>    7 Seek_Error_Rate         POSR--   082   060   045    -    157956553
>    9 Power_On_Hours          -O--CK   089   089   000    -    9812
>   10 Spin_Retry_Count        PO--C-   100   100   097    -    0
>   12 Power_Cycle_Count       -O--CK   100   100   020    -    25
>   18 Head_Health             PO-R--   100   100   050    -    0
> 187 Reported_Uncorrect      -O--CK   100   100   000    -    0
> 188 Command_Timeout         -O--CK   100   100   000    -    0
> 190 Airflow_Temperature_Cel -O---K   066   064   000    -    34 (Min/Max 27/36)
> 192 Power-Off_Retract_Count -O--CK   100   100   000    -    13
> 193 Load_Cycle_Count        -O--CK   088   088   000    -    25230
> 194 Temperature_Celsius     -O---K   034   040   000    -    34 (0 20 0 0 0)
> 197 Current_Pending_Sector  -O--C-   100   100   000    -    0
> 198 Offline_Uncorrectable   ----C-   100   100   000    -    0
> 199 UDMA_CRC_Error_Count    -OSRCK   200   200   000    -    0
> 200 Pressure_Limit          PO---K   100   100   001    -    0
> 240 Head_Flying_Hours       ------   100   100   000    -    8932h+25m+21.421s
> 241 Total_LBAs_Written      ------   100   253   000    -    148494496168
> 242 Total_LBAs_Read         ------   100   253   000    -    138807780706
>                              ||||||_ K auto-keep
>                              |||||__ C event count
>                              ||||___ R error rate
>                              |||____ S speed/performance
>                              ||_____ O updated online
>                              |______ P prefailure warning
> 
> General Purpose Log Directory Version 1
> SMART           Log Directory Version 1 [multi-sector log support]
> Address    Access  R/W   Size  Description
> 0x00       GPL,SL  R/O      1  Log Directory
> 0x01           SL  R/O      1  Summary SMART error log
> 0x02           SL  R/O      5  Comprehensive SMART error log
> 0x03       GPL     R/O      5  Ext. Comprehensive SMART error log
> 0x04       GPL     R/O    256  Device Statistics log
> 0x04       SL      R/O      8  Device Statistics log
> 0x06           SL  R/O      1  SMART self-test log
> 0x07       GPL     R/O      1  Extended self-test log
> 0x08       GPL     R/O      2  Power Conditions log
> 0x09           SL  R/W      1  Selective self-test log
> 0x0a       GPL     R/W      8  Device Statistics Notification
> 0x0c       GPL     R/O   2048  Pending Defects log
> 0x10       GPL     R/O      1  NCQ Command Error log
> 0x11       GPL     R/O      1  SATA Phy Event Counters log
> 0x13       GPL     R/O      1  SATA NCQ Send and Receive log
> 0x21       GPL     R/O      1  Write stream error log
> 0x22       GPL     R/O      1  Read stream error log
> 0x24       GPL     R/O    768  Current Device Internal Status Data log
> 0x2f       GPL     R/O      1  Set Sector Configuration
> 0x30       GPL,SL  R/O      9  IDENTIFY DEVICE data log
> 0x80-0x9f  GPL,SL  R/W     16  Host vendor specific log
> 0xa1       GPL,SL  VS     160  Device vendor specific log
> 0xa2       GPL     VS   16320  Device vendor specific log
> 0xa4       GPL,SL  VS     160  Device vendor specific log
> 0xa6       GPL     VS     192  Device vendor specific log
> 0xa8-0xa9  GPL,SL  VS     136  Device vendor specific log
> 0xab       GPL     VS       1  Device vendor specific log
> 0xad       GPL     VS      16  Device vendor specific log
> 0xb1       GPL,SL  VS     160  Device vendor specific log
> 0xb6       GPL     VS    1920  Device vendor specific log
> 0xbe-0xbf  GPL     VS   65535  Device vendor specific log
> 0xc1       GPL,SL  VS       8  Device vendor specific log
> 0xc3       GPL,SL  VS      24  Device vendor specific log
> 0xc6       GPL     VS    5184  Device vendor specific log
> 0xc7       GPL,SL  VS       8  Device vendor specific log
> 0xc9       GPL,SL  VS       8  Device vendor specific log
> 0xca       GPL,SL  VS      16  Device vendor specific log
> 0xcd       GPL,SL  VS       1  Device vendor specific log
> 0xce       GPL     VS       1  Device vendor specific log
> 0xcf       GPL     VS     512  Device vendor specific log
> 0xd1       GPL     VS     656  Device vendor specific log
> 0xd2       GPL     VS   10256  Device vendor specific log
> 0xd4       GPL     VS    2048  Device vendor specific log
> 0xda       GPL,SL  VS       1  Device vendor specific log
> 0xe0       GPL,SL  R/W      1  SCT Command/Status
> 0xe1       GPL,SL  R/W      1  SCT Data Transfer
> 
> SMART Extended Comprehensive Error Log Version: 1 (5 sectors)
> No Errors Logged
> 
> SMART Extended Self-test Log Version: 1 (1 sectors)
> No self-tests have been logged.  [To run self-tests, use: smartctl -t]
> 
> SMART Selective self-test log data structure revision number 1
>   SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
>      1        0        0  Not_testing
>      2        0        0  Not_testing
>      3        0        0  Not_testing
>      4        0        0  Not_testing
>      5        0        0  Not_testing
> Selective self-test flags (0x0):
>    After scanning selected spans, do NOT read-scan remainder of disk.
> If Selective self-test is pending on power-up, resume after 0 minute delay.
> 
> SCT Status Version:                  3
> SCT Version (vendor specific):       522 (0x020a)
> Device State:                        Active (0)
> Current Temperature:                    34 Celsius
> Power Cycle Min/Max Temperature:     27/36 Celsius
> Lifetime    Min/Max Temperature:     20/51 Celsius
> Under/Over Temperature Limit Count:   0/4
> SMART Status:                        0xc24f (PASSED)
> Vendor specific:
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00
> 
> SCT Temperature History Version:     2
> Temperature Sampling Period:         4 minutes
> Temperature Logging Interval:        59 minutes
> Min/Max recommended Temperature:     10/25 Celsius
> Min/Max Temperature Limit:            5/70 Celsius
> Temperature History Size (Index):    128 (119)
> 
> Index    Estimated Time   Temperature Celsius
>   120    2025-08-30 21:48    31  ************
>   ...    ..(  7 skipped).    ..  ************
>     0    2025-08-31 05:40    31  ************
>     1    2025-08-31 06:39    30  ***********
>   ...    ..(  4 skipped).    ..  ***********
>     6    2025-08-31 11:34    30  ***********
>     7    2025-08-31 12:33    31  ************
>     8    2025-08-31 13:32    31  ************
>     9    2025-08-31 14:31    31  ************
>    10    2025-08-31 15:30    30  ***********
>    11    2025-08-31 16:29    30  ***********
>    12    2025-08-31 17:28    30  ***********
>    13    2025-08-31 18:27    31  ************
>   ...    ..(  7 skipped).    ..  ************
>    21    2025-09-01 02:19    31  ************
>    22    2025-09-01 03:18    32  *************
>    23    2025-09-01 04:17    32  *************
>    24    2025-09-01 05:16    32  *************
>    25    2025-09-01 06:15    31  ************
>    26    2025-09-01 07:14    30  ***********
>    27    2025-09-01 08:13    30  ***********
>    28    2025-09-01 09:12     ?  -
>    29    2025-09-01 10:11    29  **********
>    30    2025-09-01 11:10     ?  -
>    31    2025-09-01 12:09    30  ***********
>    32    2025-09-01 13:08     ?  -
>    33    2025-09-01 14:07    30  ***********
>    34    2025-09-01 15:06    32  *************
>   ...    ..(  3 skipped).    ..  *************
>    38    2025-09-01 19:02    32  *************
>    39    2025-09-01 20:01    33  **************
>   ...    ..(  2 skipped).    ..  **************
>    42    2025-09-01 22:58    33  **************
>    43    2025-09-01 23:57    35  ****************
>    44    2025-09-02 00:56    34  ***************
>   ...    ..(  2 skipped).    ..  ***************
>    47    2025-09-02 03:53    34  ***************
>    48    2025-09-02 04:52    32  *************
>    49    2025-09-02 05:51    32  *************
>    50    2025-09-02 06:50    32  *************
>    51    2025-09-02 07:49    33  **************
>    52    2025-09-02 08:48    32  *************
>   ...    ..(  3 skipped).    ..  *************
>    56    2025-09-02 12:44    32  *************
>    57    2025-09-02 13:43    31  ************
>    58    2025-09-02 14:42    32  *************
>   ...    ..(  8 skipped).    ..  *************
>    67    2025-09-02 23:33    32  *************
>    68    2025-09-03 00:32    34  ***************
>    69    2025-09-03 01:31    34  ***************
>    70    2025-09-03 02:30    34  ***************
>    71    2025-09-03 03:29    35  ****************
>    72    2025-09-03 04:28    34  ***************
>    73    2025-09-03 05:27    34  ***************
>    74    2025-09-03 06:26    32  *************
>   ...    ..( 10 skipped).    ..  *************
>    85    2025-09-03 17:15    32  *************
>    86    2025-09-03 18:14    31  ************
>   ...    ..( 20 skipped).    ..  ************
>   107    2025-09-04 14:53    31  ************
>   108    2025-09-04 15:52    32  *************
>   109    2025-09-04 16:51    31  ************
>   110    2025-09-04 17:50    30  ***********
>   111    2025-09-04 18:49    29  **********
>   112    2025-09-04 19:48    28  *********
>   113    2025-09-04 20:47     ?  -
>   114    2025-09-04 21:46    28  *********
>   115    2025-09-04 22:45     ?  -
>   116    2025-09-04 23:44    27  ********
>   117    2025-09-05 00:43    35  ****************
>   118    2025-09-05 01:42    36  *****************
>   119    2025-09-05 02:41    35  ****************
> 
> SCT Error Recovery Control:
>             Read:     70 (7.0 seconds)
>            Write:     70 (7.0 seconds)
> 
> Device Statistics (GP Log 0x04)
> Page  Offset Size        Value Flags Description
> 0x01  =====  =               =  ===  == General Statistics (rev 1) ==
> 0x01  0x008  4              25  ---  Lifetime Power-On Resets
> 0x01  0x010  4            9812  ---  Power-on Hours
> 0x01  0x018  6    148493136176  ---  Logical Sectors Written
> 0x01  0x020  6       250427503  ---  Number of Write Commands
> 0x01  0x028  6    138807723416  ---  Logical Sectors Read
> 0x01  0x030  6       165896990  ---  Number of Read Commands
> 0x01  0x038  6               -  ---  Date and Time TimeStamp
> 0x03  =====  =               =  ===  == Rotating Media Statistics (rev 1) ==
> 0x03  0x008  4            9810  ---  Spindle Motor Power-on Hours
> 0x03  0x010  4            8931  ---  Head Flying Hours
> 0x03  0x018  4           25230  ---  Head Load Events
> 0x03  0x020  4               0  ---  Number of Reallocated Logical Sectors
> 0x03  0x028  4               0  ---  Read Recovery Attempts
> 0x03  0x030  4               0  ---  Number of Mechanical Start Failures
> 0x03  0x038  4               0  ---  Number of Realloc. Candidate Logical Sectors
> 0x03  0x040  4              13  ---  Number of High Priority Unload Events
> 0x04  =====  =               =  ===  == General Errors Statistics (rev 1) ==
> 0x04  0x008  4               0  ---  Number of Reported Uncorrectable Errors
> 0x04  0x010  4               0  ---  Resets Between Cmd Acceptance and Completion
> 0x04  0x018  4               0  -D-  Physical Element Status Changed
> 0x05  =====  =               =  ===  == Temperature Statistics (rev 1) ==
> 0x05  0x008  1              34  ---  Current Temperature
> 0x05  0x010  1              31  ---  Average Short Term Temperature
> 0x05  0x018  1              30  ---  Average Long Term Temperature
> 0x05  0x020  1              36  ---  Highest Temperature
> 0x05  0x028  1              25  ---  Lowest Temperature
> 0x05  0x030  1              33  ---  Highest Average Short Term Temperature
> 0x05  0x038  1              27  ---  Lowest Average Short Term Temperature
> 0x05  0x040  1              31  ---  Highest Average Long Term Temperature
> 0x05  0x048  1              27  ---  Lowest Average Long Term Temperature
> 0x05  0x050  4               0  ---  Time in Over-Temperature
> 0x05  0x058  1              70  ---  Specified Maximum Operating Temperature
> 0x05  0x060  4               0  ---  Time in Under-Temperature
> 0x05  0x068  1               5  ---  Specified Minimum Operating Temperature
> 0x06  =====  =               =  ===  == Transport Statistics (rev 1) ==
> 0x06  0x008  4             294  ---  Number of Hardware Resets
> 0x06  0x010  4             152  ---  Number of ASR Events
> 0x06  0x018  4               0  ---  Number of Interface CRC Errors
> 0xff  =====  =               =  ===  == Vendor Specific Statistics (rev 1) ==
> 0xff  0x008  7               0  ---  Vendor Specific
> 0xff  0x010  7               0  ---  Vendor Specific
> 0xff  0x018  7               0  ---  Vendor Specific
>                                  |||_ C monitored condition met
>                                  ||__ D supports DSN
>                                  |___ N normalized value
> 
> Pending Defects log (GP Log 0x0c)
> No Defects Logged
> 
> SATA Phy Event Counters (GP Log 0x11)
> ID      Size     Value  Description
> 0x000a  2            7  Device-to-host register FISes sent due to a COMRESET
> 0x0001  2            0  Command failed due to ICRC error
> 0x0003  2            0  R_ERR response for device-to-host data FIS
> 0x0004  2            0  R_ERR response for host-to-device data FIS
> 0x0006  2            0  R_ERR response for device-to-host non-data FIS
> 0x0007  2            0  R_ERR response for host-to-device non-data FIS
> 
> Seagate FARM log (GP Log 0xa6) supported [try: -l farm]
> 
> $ sudo smartctl -x /dev/sdb
> smartctl 7.4 2023-08-01 r5530 [x86_64-linux-6.14.0-29-generic] (local build)
> Copyright (C) 2002-23, Bruce Allen, Christian Franke, www.smartmontools.org
> 
> === START OF INFORMATION SECTION ===
> Device Model:     WDC WD122KFBX-68CCHN0
> Serial Number:    WD-B007HJHD
> LU WWN Device Id: 5 0014ee 26c001af8
> Firmware Version: 83.00A83
> User Capacity:    12,000,138,625,024 bytes [12.0 TB]
> Sector Sizes:     512 bytes logical, 4096 bytes physical
> Rotation Rate:    7200 rpm
> Form Factor:      3.5 inches
> Device is:        Not in smartctl database 7.3/5528
> ATA Version is:   ACS-4 published, ANSI INCITS 529-2018
> SATA Version is:  SATA 3.2, 6.0 Gb/s (current: 6.0 Gb/s)
> Local Time is:    Fri Sep  5 03:31:26 2025 UTC
> SMART support is: Available - device has SMART capability.
> SMART support is: Enabled
> AAM feature is:   Unavailable
> APM level is:     128 (minimum power consumption without standby)
> Rd look-ahead is: Enabled
> Write cache is:   Enabled
> DSN feature is:   Disabled
> ATA Security is:  Disabled, frozen [SEC2]
> Wt Cache Reorder: Enabled
> 
> Warning! SMART Attribute Thresholds Structure error: invalid SMART checksum.
> === START OF READ SMART DATA SECTION ===
> SMART overall-health self-assessment test result: PASSED
> 
> General SMART Values:
> Offline data collection status:  (0x00) Offline data collection activity
>                                          was never started.
>                                          Auto Offline Data Collection: Disabled.
> Self-test execution status:      (   0) The previous self-test routine completed
>                                          without error or no self-test has ever
>                                          been run.
> Total time to complete Offline
> data collection:                (25724) seconds.
> Offline data collection
> capabilities:                    (0x71) SMART execute Offline immediate.
>                                          No Auto Offline data collection support.
>                                          Suspend Offline collection upon new
>                                          command.
>                                          No Offline surface scan supported.
>                                          Self-test supported.
>                                          Conveyance Self-test supported.
>                                          Selective Self-test supported.
> SMART capabilities:            (0x0003) Saves SMART data before entering
>                                          power-saving mode.
>                                          Supports SMART auto save timer.
> Error logging capability:        (0x01) Error logging supported.
>                                          General Purpose Logging supported.
> Short self-test routine
> recommended polling time:        (   2) minutes.
> Extended self-test routine
> recommended polling time:        ( 909) minutes.
> Conveyance self-test routine
> recommended polling time:        (   6) minutes.
> SCT capabilities:              (0x303d) SCT Status supported.
>                                          SCT Error Recovery Control supported.
>                                          SCT Feature Control supported.
>                                          SCT Data Table supported.
> 
> SMART Attributes Data Structure revision number: 16
> Vendor Specific SMART Attributes with Thresholds:
> ID# ATTRIBUTE_NAME          FLAGS    VALUE WORST THRESH FAIL RAW_VALUE
>    1 Raw_Read_Error_Rate     POSR-K   200   200   051    -    0
>    2 Throughput_Performance  --S--K   100   100   000    -    0
>    3 Spin_Up_Time            POS--K   181   145   021    -    11925
>    4 Start_Stop_Count        -O--CK   100   100   000    -    13
>    5 Reallocated_Sector_Ct   PO--CK   200   200   140    -    0
>    7 Seek_Error_Rate         -OSR-K   100   100   000    -    0
>    8 Seek_Time_Performance   --S--K   100   100   000    -    0
>    9 Power_On_Hours          -O--CK   097   097   000    -    2735
>   10 Spin_Retry_Count        -O--CK   100   100   000    -    0
>   11 Calibration_Retry_Count -O--CK   100   100   000    -    0
>   12 Power_Cycle_Count       -O--CK   100   100   000    -    13
> 192 Power-Off_Retract_Count -O--CK   200   200   000    -    5
> 193 Load_Cycle_Count        -O--CK   200   200   000    -    48
> 194 Temperature_Celsius     -O---K   115   114   000    -    37
> 196 Reallocated_Event_Count -O--CK   200   200   000    -    0
> 197 Current_Pending_Sector  -O--CK   200   200   000    -    0
> 198 Offline_Uncorrectable   ----CK   100   100   000    -    0
> 199 UDMA_CRC_Error_Count    -O--CK   200   200   000    -    1
> 200 Multi_Zone_Error_Rate   ---R--   100   100   000    -    0
>                              ||||||_ K auto-keep
>                              |||||__ C event count
>                              ||||___ R error rate
>                              |||____ S speed/performance
>                              ||_____ O updated online
>                              |______ P prefailure warning
> 
> General Purpose Log Directory Version 1
> SMART           Log Directory Version 1 [multi-sector log support]
> Address    Access  R/W   Size  Description
> 0x00       GPL,SL  R/O      1  Log Directory
> 0x01           SL  R/O      1  Summary SMART error log
> 0x02           SL  R/O      5  Comprehensive SMART error log
> 0x03       GPL     R/O      6  Ext. Comprehensive SMART error log
> 0x04       GPL     R/O    256  Device Statistics log
> 0x04       SL      R/O    255  Device Statistics log
> 0x06           SL  R/O      1  SMART self-test log
> 0x07       GPL     R/O      1  Extended self-test log
> 0x08       GPL     R/O      2  Power Conditions log
> 0x09           SL  R/W      1  Selective self-test log
> 0x0a       GPL     R/W    256  Device Statistics Notification
> 0x0c       GPL     R/O   2048  Pending Defects log
> 0x0f       GPL     R/O      2  Sense Data for Successful NCQ Cmds log
> 0x10       GPL     R/O      1  NCQ Command Error log
> 0x11       GPL     R/O      1  SATA Phy Event Counters log
> 0x12       GPL     R/O      1  SATA NCQ Non-Data log
> 0x13       GPL     R/O      1  SATA NCQ Send and Receive log
> 0x15       GPL     R/W      1  Rebuild Assist log
> 0x24       GPL     R/O    322  Current Device Internal Status Data log
> 0x30       GPL,SL  R/O      9  IDENTIFY DEVICE data log
> 0x53       GPL     R/O      1  Sense Data log
> 0x80-0x9f  GPL,SL  R/W     16  Host vendor specific log
> 0xa0-0xa1  GPL,SL  VS      16  Device vendor specific log
> 0xa3-0xa5  GPL,SL  VS      16  Device vendor specific log
> 0xa7       GPL,SL  VS      16  Device vendor specific log
> 0xa8-0xb1  GPL,SL  VS       1  Device vendor specific log
> 0xb2       GPL     VS   65535  Device vendor specific log
> 0xb3-0xb6  GPL,SL  VS       1  Device vendor specific log
> 0xb9           SL  VS       1  Device vendor specific log
> 0xba       GPL,SL  VS      84  Device vendor specific log
> 0xbd       GPL,SL  VS       1  Device vendor specific log
> 0xc0       GPL,SL  VS       1  Device vendor specific log
> 0xc1       GPL     VS      93  Device vendor specific log
> 0xd2       GPL,SL  VS       1  Device vendor specific log
> 0xe0       GPL,SL  R/W      1  SCT Command/Status
> 0xe1       GPL,SL  R/W      1  SCT Data Transfer
> 
> SMART Extended Comprehensive Error Log Version: 1 (6 sectors)
> No Errors Logged
> 
> SMART Extended Self-test Log Version: 1 (1 sectors)
> No self-tests have been logged.  [To run self-tests, use: smartctl -t]
> 
> SMART Selective self-test log data structure revision number 1
>   SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
>      1        0        0  Not_testing
>      2        0        0  Not_testing
>      3        0        0  Not_testing
>      4        0        0  Not_testing
>      5        0        0  Not_testing
> Selective self-test flags (0x0):
>    After scanning selected spans, do NOT read-scan remainder of disk.
> If Selective self-test is pending on power-up, resume after 0 minute delay.
> 
> SCT Status Version:                  3
> SCT Version (vendor specific):       258 (0x0102)
> Device State:                        Active (0)
> Current Temperature:                    37 Celsius
> Power Cycle Min/Max Temperature:     32/38 Celsius
> Lifetime    Min/Max Temperature:     24/38 Celsius
> Under/Over Temperature Limit Count:   0/0
> Minimum supported ERC Time Limit:    65 (6.5 seconds)
> Vendor specific:
> 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> SCT Temperature History Version:     2
> Temperature Sampling Period:         1 minute
> Temperature Logging Interval:        1 minute
> Min/Max recommended Temperature:      0/65 Celsius
> Min/Max Temperature Limit:           -41/85 Celsius
> Temperature History Size (Index):    478 (348)
> 
> Index    Estimated Time   Temperature Celsius
>   349    2025-09-04 19:34    38  *******************
>   ...    ..( 84 skipped).    ..  *******************
>   434    2025-09-04 20:59    38  *******************
>   435    2025-09-04 21:00    37  ******************
>   ...    ..( 12 skipped).    ..  ******************
>   448    2025-09-04 21:13    37  ******************
>   449    2025-09-04 21:14    34  ***************
>   ...    ..(192 skipped).    ..  ***************
>   164    2025-09-05 00:27    34  ***************
>   165    2025-09-05 00:28    35  ****************
>   166    2025-09-05 00:29    34  ***************
>   ...    ..( 66 skipped).    ..  ***************
>   233    2025-09-05 01:36    34  ***************
>   234    2025-09-05 01:37     ?  -
>   235    2025-09-05 01:38    30  ***********
>   ...    ..(  2 skipped).    ..  ***********
>   238    2025-09-05 01:41    30  ***********
>   239    2025-09-05 01:42    31  ************
>   ...    ..(  3 skipped).    ..  ************
>   243    2025-09-05 01:46    31  ************
>   244    2025-09-05 01:47    32  *************
>   ...    ..(  5 skipped).    ..  *************
>   250    2025-09-05 01:53    32  *************
>   251    2025-09-05 01:54    33  **************
>   ...    ..(  4 skipped).    ..  **************
>   256    2025-09-05 01:59    33  **************
>   257    2025-09-05 02:00    34  ***************
>   258    2025-09-05 02:01     ?  -
>   259    2025-09-05 02:02    33  **************
>   260    2025-09-05 02:03    33  **************
>   261    2025-09-05 02:04    33  **************
>   262    2025-09-05 02:05     ?  -
>   263    2025-09-05 02:06    31  ************
>   264    2025-09-05 02:07    31  ************
>   265    2025-09-05 02:08    31  ************
>   266    2025-09-05 02:09     ?  -
>   267    2025-09-05 02:10    32  *************
>   ...    ..(  4 skipped).    ..  *************
>   272    2025-09-05 02:15    32  *************
>   273    2025-09-05 02:16    33  **************
>   ...    ..(  2 skipped).    ..  **************
>   276    2025-09-05 02:19    33  **************
>   277    2025-09-05 02:20    34  ***************
>   ...    ..(  4 skipped).    ..  ***************
>   282    2025-09-05 02:25    34  ***************
>   283    2025-09-05 02:26    35  ****************
>   ...    ..(  6 skipped).    ..  ****************
>   290    2025-09-05 02:33    35  ****************
>   291    2025-09-05 02:34    36  *****************
>   ...    ..( 10 skipped).    ..  *****************
>   302    2025-09-05 02:45    36  *****************
>   303    2025-09-05 02:46    37  ******************
>   ...    ..( 31 skipped).    ..  ******************
>   335    2025-09-05 03:18    37  ******************
>   336    2025-09-05 03:19    38  *******************
>   ...    ..( 11 skipped).    ..  *******************
>   348    2025-09-05 03:31    38  *******************
> 
> SCT Error Recovery Control:
>             Read:     70 (7.0 seconds)
>            Write:     70 (7.0 seconds)
> 
> Device Statistics (GP Log 0x04)
> Page  Offset Size        Value Flags Description
> 0x01  =====  =               =  ===  == General Statistics (rev 3) ==
> 0x01  0x008  4              13  -D-  Lifetime Power-On Resets
> 0x01  0x010  4            2735  -D-  Power-on Hours
> 0x01  0x018  6    133338880640  -D-  Logical Sectors Written
> 0x01  0x020  6       262851767  -D-  Number of Write Commands
> 0x01  0x028  6    167284315604  -D-  Logical Sectors Read
> 0x01  0x030  6       163275037  -D-  Number of Read Commands
> 0x01  0x038  6      1256065408  -D-  Date and Time TimeStamp
> 0x02  =====  =               =  ===  == Free-Fall Statistics (rev 1) ==
> 0x02  0x010  4               0  -D-  Overlimit Shock Events
> 0x03  =====  =               =  ===  == Rotating Media Statistics (rev 1) ==
> 0x03  0x008  4            2722  -D-  Spindle Motor Power-on Hours
> 0x03  0x010  4            2671  -D-  Head Flying Hours
> 0x03  0x018  4              54  -D-  Head Load Events
> 0x03  0x020  4               0  -D-  Number of Reallocated Logical Sectors
> 0x03  0x028  4               8  -D-  Read Recovery Attempts
> 0x03  0x030  4               0  -D-  Number of Mechanical Start Failures
> 0x03  0x038  4               0  -D-  Number of Realloc. Candidate Logical Sectors
> 0x03  0x040  4               5  -D-  Number of High Priority Unload Events
> 0x04  =====  =               =  ===  == General Errors Statistics (rev 1) ==
> 0x04  0x008  4               0  -D-  Number of Reported Uncorrectable Errors
> 0x04  0x010  4               0  -D-  Resets Between Cmd Acceptance and Completion
> 0x05  =====  =               =  ===  == Temperature Statistics (rev 1) ==
> 0x05  0x008  1              37  ---  Current Temperature
> 0x05  0x010  1              34  -D-  Average Short Term Temperature
> 0x05  0x018  1              33  -D-  Average Long Term Temperature
> 0x05  0x020  1              38  -D-  Highest Temperature
> 0x05  0x028  1              29  -D-  Lowest Temperature
> 0x05  0x030  1              35  -D-  Highest Average Short Term Temperature
> 0x05  0x038  1              31  -D-  Lowest Average Short Term Temperature
> 0x05  0x040  1              33  -D-  Highest Average Long Term Temperature
> 0x05  0x048  1              32  -D-  Lowest Average Long Term Temperature
> 0x05  0x050  4               0  -D-  Time in Over-Temperature
> 0x05  0x058  1              65  ---  Specified Maximum Operating Temperature
> 0x05  0x060  4               0  -D-  Time in Under-Temperature
> 0x05  0x068  1               0  ---  Specified Minimum Operating Temperature
> 0x06  =====  =               =  ===  == Transport Statistics (rev 1) ==
> 0x06  0x008  4             282  -D-  Number of Hardware Resets
> 0x06  0x010  4             172  -D-  Number of ASR Events
> 0x06  0x018  4               1  -D-  Number of Interface CRC Errors
> 0xff  =====  =               =  ===  == Vendor Specific Statistics (rev 1) ==
> 0xff  0x008  7               0  -D-  Vendor Specific
> 0xff  0x010  7               0  -D-  Vendor Specific
> 0xff  0x018  7               0  -D-  Vendor Specific
> 0xff  0x040  7               0  -D-  Vendor Specific
> 0xff  0x048  7               0  -D-  Vendor Specific
> 0xff  0x050  7               0  -D-  Vendor Specific
> 0xff  0x058  7               0  -D-  Vendor Specific
> 0xff  0x060  7               0  -D-  Vendor Specific
> 0xff  0x068  7               0  -D-  Vendor Specific
> 0xff  0x070  7             338  -D-  Vendor Specific
> 0xff  0x078  7               0  -D-  Vendor Specific
> 0xff  0x080  7               0  -D-  Vendor Specific
> 0xff  0x088  7             235  -D-  Vendor Specific
> 0xff  0x090  7            4838  -D-  Vendor Specific
> 0xff  0x098  7           11887  -D-  Vendor Specific
> 0xff  0x0a0  7             100  -D-  Vendor Specific
>                                  |||_ C monitored condition met
>                                  ||__ D supports DSN
>                                  |___ N normalized value
> 
> Pending Defects log (GP Log 0x0c)
> No Defects Logged
> 
> SATA Phy Event Counters (GP Log 0x11)
> ID      Size     Value  Description
> 0x0001  2            1  Command failed due to ICRC error
> 0x0002  2            0  R_ERR response for data FIS
> 0x0003  2            0  R_ERR response for device-to-host data FIS
> 0x0004  2            0  R_ERR response for host-to-device data FIS
> 0x0005  2            0  R_ERR response for non-data FIS
> 0x0006  2            0  R_ERR response for device-to-host non-data FIS
> 0x0007  2            0  R_ERR response for host-to-device non-data FIS
> 0x0008  2            0  Device-to-host non-data FIS retries
> 0x0009  2            8  Transition from drive PhyRdy to drive PhyNRdy
> 0x000a  2           11  Device-to-host register FISes sent due to a COMRESET
> 0x000b  2            0  CRC errors within host-to-device FIS
> 0x000d  2            0  Non-CRC errors within host-to-device FIS
> 0x000f  2            0  R_ERR response for host-to-device data FIS, CRC
> 0x0012  2            0  R_ERR response for host-to-device non-data FIS, CRC
> 0x8000  4        10985  Vendor specific
> 
> 
> Please let me know if you need any more info?
> 
> 
> Sent with Proton Mail secure email.
> 


