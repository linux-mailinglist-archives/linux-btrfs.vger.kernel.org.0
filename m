Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6259912AF78
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Dec 2019 23:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfLZW60 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Dec 2019 17:58:26 -0500
Received: from naboo.endor.pl ([91.194.229.149]:41219 "EHLO naboo.endor.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfLZW60 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Dec 2019 17:58:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id C65531A10BA;
        Thu, 26 Dec 2019 23:58:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.149])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id d2V8BOEn8hd6; Thu, 26 Dec 2019 23:58:23 +0100 (CET)
Received: from [192.168.1.16] (aaee101.neoplus.adsl.tpnet.pl [83.4.108.101])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id 7F6AB1A0F94;
        Thu, 26 Dec 2019 23:58:23 +0100 (CET)
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Remi Gauvin <remi@georgianit.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
 <0354c266-5d50-51b1-a768-93a78e0ddd51@gmx.com>
 <09ec71c0-e3c2-8bb5-acaf-0317e7204ca9@dubiel.pl>
 <6058c4c4-fcb3-c7cd-6517-10b5908b34da@georgianit.com>
 <602a4895-f2f7-f024-c312-d880f12e1360@dubiel.pl>
 <CAJCQCtQEpXvgbs+Y0+A4cLZUft3oqp+sLW8xVPfxt2aqYhMj_g@mail.gmail.com>
From:   Leszek Dubiel <leszek@dubiel.pl>
Message-ID: <2c135c87-d01b-53f1-9f76-a5653918a4e7@dubiel.pl>
Date:   Thu, 26 Dec 2019 23:58:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQEpXvgbs+Y0+A4cLZUft3oqp+sLW8xVPfxt2aqYhMj_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl-PL
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


 > Weird. This is not expected. I see a discrete read error with LBA
 > reported for the device, and yet Btfs shows no attempt to correct it
 > (using raid1 metadata) nor does it report the path to file that's
 > affected by this lost sector. I'm expecting to see one of those two
 > outcomes, given the profiles being used.

Yes. This is strange that I see no errors from btrfs.
Maybe that ata erorrs were during smart self tests of /dev/sda...

I put some logs below.




 > Dec 23 00:08:20 wawel kernel: [23201.188424] INFO: task btrfs:2546
 > blocked for more than 120 seconds.
 >
 > Multiples of these, but no coinciding read errors or SATA link resets.
 > This suggests bad sectors in deep recover. And that would explain why
 > the copies are so slow. It's not a Btrfs problem per se. It's that
 > you've decided to have only one copy of data, self healing of data
 > isn't possible. The file system itself is fine, but slow because the
 > affected drive is slow to recover these bad sectors.
 >
 > Again, dropping the SCT ERC for the drives would result in a faster
 > error recovery when encountering bad sectors. It also increases the
 > chance of data loss (not metadata loss since it's raid1)

Deep recovery theory could be correct, because two days ago
there were  16 "Current_Pending_Sector" and 2 "uncorrectable sectors"
and smart self tests failed.

Today there are zoro pending sectors and self tests passed okey.




root@wawel:~# smartctl -a /dev/sda
smartctl 6.6 2017-11-05 r4594 [x86_64-linux-4.19.0-6-amd64] (local build)
Copyright (C) 2002-17, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Device Model:     WDC WD6003FZBX-00K5WB0
Serial Number:    V8GJ99HR
LU WWN Device Id: 5 000cca 098c768df
Firmware Version: 01.01A01
User Capacity:    6 001 175 126 016 bytes [6,00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    7200 rpm
Form Factor:      3.5 inches
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ACS-2, ATA8-ACS T13/1699-D revision 4
SATA Version is:  SATA 3.2, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Thu Dec 26 23:56:39 2019 CET
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82)    Offline data collection activity
                     was completed without error.
                     Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)    The previous self-test 
routine completed
                     without error or no self-test has ever
                     been run.
Total time to complete Offline
data collection:         (   87) seconds.
Offline data collection
capabilities:              (0x5b) SMART execute Offline immediate.
                     Auto Offline data collection on/off support.
                     Suspend Offline collection upon new
                     command.
                     Offline surface scan supported.
                     Self-test supported.
                     No Conveyance Self-test supported.
                     Selective Self-test supported.
SMART capabilities:            (0x0003)    Saves SMART data before entering
                     power-saving mode.
                     Supports SMART auto save timer.
Error logging capability:        (0x01)    Error logging supported.
                     General Purpose Logging supported.
Short self-test routine
recommended polling time:      (   2) minutes.
Extended self-test routine
recommended polling time:      ( 688) minutes.
SCT capabilities:            (0x0035)    SCT Status supported.
                     SCT Feature Control supported.
                     SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      
UPDATED  WHEN_FAILED RAW_VALUE
   1 Raw_Read_Error_Rate     0x000b   100   100   016 Pre-fail  
Always       -       0
   2 Throughput_Performance  0x0004   130   130   054 Old_age   
Offline      -       100
   3 Spin_Up_Time            0x0007   100   100   024 Pre-fail  
Always       -       0
   4 Start_Stop_Count        0x0012   100   100   000 Old_age   
Always       -       7
   5 Reallocated_Sector_Ct   0x0033   100   100   005 Pre-fail  
Always       -       0
   7 Seek_Error_Rate         0x000a   100   100   067 Old_age   
Always       -       0
   8 Seek_Time_Performance   0x0004   128   128   020 Old_age   
Offline      -       18
   9 Power_On_Hours          0x0012   100   100   000 Old_age   
Always       -       3676
  10 Spin_Retry_Count        0x0012   100   100   060 Old_age   
Always       -       0
  12 Power_Cycle_Count       0x0032   100   100   000 Old_age   
Always       -       7
192 Power-Off_Retract_Count 0x0032   100   100   000 Old_age   
Always       -       154
193 Load_Cycle_Count        0x0012   100   100   000 Old_age   
Always       -       154
194 Temperature_Celsius     0x0002   183   183   000 Old_age   
Always       -       30 (Min/Max 21/38)
196 Reallocated_Event_Count 0x0032   100   100   000 Old_age   
Always       -       0
197 Current_Pending_Sector  0x0022   100   100   000 Old_age   
Always       -       0
198 Offline_Uncorrectable   0x0008   100   100   000 Old_age   
Offline      -       2
199 UDMA_CRC_Error_Count    0x000a   200   200   000 Old_age   
Always       -       0

SMART Error Log Version: 1
ATA Error Count: 1
     CR = Command Register [HEX]
     FR = Features Register [HEX]
     SC = Sector Count Register [HEX]
     SN = Sector Number Register [HEX]
     CL = Cylinder Low Register [HEX]
     CH = Cylinder High Register [HEX]
     DH = Device/Head Register [HEX]
     DC = Device Command Register [HEX]
     ER = Error register [HEX]
     ST = Status register [HEX]
Powered_Up_Time is measured from power on, and printed as
DDd+hh:mm:SS.sss where DD=days, hh=hours, mm=minutes,
SS=sec, and sss=millisec. It "wraps" after 49.710 days.

Error 1 occurred at disk power-on lifetime: 3576 hours (149 days + 0 hours)
   When the command that caused the error occurred, the device was 
active or idle.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   40 43 00 00 00 00 00  Error: UNC at LBA = 0x00000000 = 0

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time Command/Feature_Name
   -- -- -- -- -- -- -- --  ---------------- --------------------
   60 00 38 00 00 98 40 08   1d+04:19:05.582  READ FPDMA QUEUED
   60 00 40 00 0a 98 40 08   1d+04:19:03.035  READ FPDMA QUEUED
   60 30 30 d0 ff 97 40 08   1d+04:19:03.035  READ FPDMA QUEUED
   60 00 28 d0 f5 97 40 08   1d+04:19:03.035  READ FPDMA QUEUED
   60 d0 20 00 f0 97 40 08   1d+04:19:03.035  READ FPDMA QUEUED

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining 
LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed without error 00%      3675         -
# 2  Extended offline    Completed without error 00%      3668         -
# 3  Short offline       Completed without error 00%      3651         -
# 4  Extended offline    Completed without error 00%      3644         -
# 5  Short offline       Completed without error 00%      3627         -
# 6  Extended offline    Completed without error 00%      3622         -
# 7  Extended offline    Completed without error 00%      3604         -
# 8  Short offline       Completed without error 00%      3579         -
# 9  Extended offline    Completed: read failure 90%      3575         -
#10  Short offline       Completed without error 00%      3574         -
#11  Extended offline    Completed: read failure 90%      3574         -
#12  Extended offline    Completed: read failure 90%      3560         -
#13  Extended offline    Completed: read failure 50%      3559         -
4 of 4 failed self-tests are outdated by newer successful extended 
offline self-test # 2

SMART Selective self-test log data structure revision number 1
  SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
     1        0        0  Not_testing
     2        0        0  Not_testing
     3        0        0  Not_testing
     4        0        0  Not_testing
     5        0        0  Not_testing
Selective self-test flags (0x0):
   After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.











 >


