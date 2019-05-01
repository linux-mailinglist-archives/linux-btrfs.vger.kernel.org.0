Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45BE610885
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 May 2019 15:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfEANys convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 1 May 2019 09:54:48 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.98]:35023 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfEANyr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 May 2019 09:54:47 -0400
Received: from [94.217.144.7] (helo=[192.168.177.20])
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <hendrik@friedels.name>)
        id 1hLph4-00082K-V1
        for linux-btrfs@vger.kernel.org; Wed, 01 May 2019 15:54:43 +0200
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Rough (re)start with btrfs
Date:   Wed, 01 May 2019 13:54:39 +0000
Message-Id: <em6b2fc230-16e7-495d-85b9-e88a08b7bcd3@ryzen>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/7.2.34062.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: aGVuZHJpa0BmcmllZGVscy5uYW1l
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

as discussed in the other thread, I am migrating to BTRFS (again).
Unfortunately, I had a bit of a rough start
[Mo Apr 29 20:44:47 2019] INFO: task btrfs-transacti:10227 blocked for 
more than 120 seconds.
[...]
This repeated several times while moving data over. Full log of one 
instance below.

I am using btrfs-progs v4.20.2 and debian stretch with 
4.19.0-0.bpo.2-amd64 (I think, this is the latest Kernel available in 
stretch. Please correct if I am wrong.

I understand that this was a 'timeout'. Is this caused by hardware?

In the SMART logs indeed, I see that errors happened (Full log below)
84 51 20 df 27 81 40  Error: ICRC, ABRT 32 sectors at LBA = 0x008127df = 
8464351
But this happened after 44h. I am now at 82h, so that was long before 
the error -infact during my 'burn-in test'.

Is this a case for an RMA of the drive?

Greetings,
Hendrik












[Mo Apr 29 20:44:47 2019] INFO: task btrfs-transacti:10227 blocked for 
more than 120 seconds.
[Mo Apr 29 20:44:47 2019]       Not tainted 4.19.0-0.bpo.2-amd64 #1 
Debian 4.19.16-1~bpo9+1
[Mo Apr 29 20:44:47 2019] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Mo Apr 29 20:44:47 2019] btrfs-transacti D    0 10227      2 0x80000000
[Mo Apr 29 20:44:47 2019] Call Trace:
[Mo Apr 29 20:44:47 2019]  ? __schedule+0x3f5/0x880
[Mo Apr 29 20:44:47 2019]  schedule+0x32/0x80
[Mo Apr 29 20:44:47 2019]  wait_for_commit+0x41/0x80 [btrfs]
[Mo Apr 29 20:44:47 2019]  ? remove_wait_queue+0x60/0x60
[Mo Apr 29 20:44:47 2019]  btrfs_commit_transaction+0x10b/0x8a0 [btrfs]
[Mo Apr 29 20:44:47 2019]  ? start_transaction+0x8f/0x3e0 [btrfs]
[Mo Apr 29 20:44:47 2019]  transaction_kthread+0x157/0x180 [btrfs]
[Mo Apr 29 20:44:47 2019]  kthread+0xf8/0x130
[Mo Apr 29 20:44:47 2019]  ? btrfs_cleanup_transaction+0x500/0x500 
[btrfs]
[Mo Apr 29 20:44:47 2019]  ? kthread_create_worker_on_cpu+0x70/0x70
[Mo Apr 29 20:44:47 2019]  ret_from_fork+0x35/0x40
[Mo Apr 29 20:44:47 2019] INFO: task kworker/u4:8:10576 blocked for more 
than 120 seconds.
[Mo Apr 29 20:44:47 2019]       Not tainted 4.19.0-0.bpo.2-amd64 #1 
Debian 4.19.16-1~bpo9+1
[Mo Apr 29 20:44:47 2019] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Mo Apr 29 20:44:47 2019] kworker/u4:8    D    0 10576      2 0x80000000
[Mo Apr 29 20:44:47 2019] Workqueue: events_unbound 
btrfs_async_reclaim_metadata_space [btrfs]
[Mo Apr 29 20:44:47 2019] Call Trace:
[Mo Apr 29 20:44:47 2019]  ? __schedule+0x3f5/0x880
[Mo Apr 29 20:44:47 2019]  schedule+0x32/0x80
[Mo Apr 29 20:44:47 2019]  wait_current_trans+0xb9/0xf0 [btrfs]
[Mo Apr 29 20:44:47 2019]  ? remove_wait_queue+0x60/0x60
[Mo Apr 29 20:44:47 2019]  start_transaction+0x201/0x3e0 [btrfs]
[Mo Apr 29 20:44:47 2019]  flush_space+0x14d/0x5e0 [btrfs]
[Mo Apr 29 20:44:47 2019]  ? __switch_to_asm+0x40/0x70
[Mo Apr 29 20:44:47 2019]  ? __switch_to_asm+0x34/0x70
[Mo Apr 29 20:44:47 2019]  ? __switch_to_asm+0x40/0x70
[Mo Apr 29 20:44:47 2019]  ? __switch_to_asm+0x34/0x70
[Mo Apr 29 20:44:47 2019]  ? __switch_to_asm+0x34/0x70
[Mo Apr 29 20:44:47 2019]  ? __switch_to_asm+0x34/0x70
[Mo Apr 29 20:44:47 2019]  ? __switch_to_asm+0x40/0x70
[Mo Apr 29 20:44:47 2019]  ? __switch_to_asm+0x34/0x70
[Mo Apr 29 20:44:47 2019]  ? __switch_to_asm+0x40/0x70
[Mo Apr 29 20:44:47 2019]  ? get_alloc_profile+0x72/0x180 [btrfs]
[Mo Apr 29 20:44:47 2019]  ? can_overcommit.part.63+0x55/0xe0 [btrfs]
[Mo Apr 29 20:44:47 2019]  btrfs_async_reclaim_metadata_space+0xfb/0x4c0 
[btrfs]
[Mo Apr 29 20:44:47 2019]  process_one_work+0x191/0x370
[Mo Apr 29 20:44:47 2019]  worker_thread+0x4f/0x3b0
[Mo Apr 29 20:44:47 2019]  kthread+0xf8/0x130
[Mo Apr 29 20:44:47 2019]  ? rescuer_thread+0x340/0x340
[Mo Apr 29 20:44:47 2019]  ? kthread_create_worker_on_cpu+0x70/0x70
[Mo Apr 29 20:44:47 2019]  ret_from_fork+0x35/0x40





SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      
UPDATED  WHEN_FAILED RAW_VALUE
   1 Raw_Read_Error_Rate     0x000b   100   100   016    Pre-fail  Always 
       -       0
   2 Throughput_Performance  0x0004   128   128   054    Old_age   
Offline      -       116
   3 Spin_Up_Time            0x0007   198   198   024    Pre-fail  Always 
       -       349 (Average 317)
   4 Start_Stop_Count        0x0012   100   100   000    Old_age   Always 
       -       26
   5 Reallocated_Sector_Ct   0x0033   100   100   005    Pre-fail  Always 
       -       0
   7 Seek_Error_Rate         0x000a   100   100   067    Old_age   Always 
       -       0
   8 Seek_Time_Performance   0x0004   128   128   020    Old_age   
Offline      -       18
   9 Power_On_Hours          0x0012   100   100   000    Old_age   Always 
       -       82
  10 Spin_Retry_Count        0x0012   100   100   060    Old_age   Always 
       -       0
  12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always 
       -       26
  22 Helium_Level            0x0023   100   100   025    Pre-fail  Always 
       -       100
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always 
       -       27
193 Load_Cycle_Count        0x0012   100   100   000    Old_age   Always 
       -       27
194 Temperature_Celsius     0x0002   250   250   000    Old_age   Always 
       -       26 (Min/Max 24/55)
196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always 
       -       0
197 Current_Pending_Sector  0x0022   100   100   000    Old_age   Always 
       -       0
198 Offline_Uncorrectable   0x0008   100   100   000    Old_age   
Offline      -       0
199 UDMA_CRC_Error_Count    0x000a   200   200   000    Old_age   Always 
       -       2

SMART Error Log Version: 1
ATA Error Count: 2
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

Error 2 occurred at disk power-on lifetime: 44 hours (1 days + 20 hours)
   When the command that caused the error occurred, the device was doing 
SMART Offline or Self-test.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   84 51 20 df 27 81 40  Error: ICRC, ABRT 32 sectors at LBA = 0x008127df 
= 8464351

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   35 03 20 df 27 81 40 00      00:00:54.041  WRITE DMA EXT
   35 03 01 ff 27 81 40 00      00:00:54.040  WRITE DMA EXT
   25 03 20 02 00 00 40 00      00:00:54.040  READ DMA EXT
   25 03 20 02 00 00 40 00      00:00:54.040  READ DMA EXT
   25 03 01 af 2a 81 40 00      00:00:54.011  READ DMA EXT

Error 1 occurred at disk power-on lifetime: 44 hours (1 days + 20 hours)
   When the command that caused the error occurred, the device was doing 
SMART Offline or Self-test.

   After command completion occurred, registers were:
   ER ST SC SN CL CH DH
   -- -- -- -- -- -- --
   84 51 00 00 00 00 00

   Commands leading to the command that caused the error were:
   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
   -- -- -- -- -- -- -- --  ----------------  --------------------
   47 00 01 00 00 00 a0 08      00:00:37.434  READ LOG DMA EXT
   47 00 01 13 00 00 a0 08      00:00:37.433  READ LOG DMA EXT
   47 00 01 00 00 00 a0 08      00:00:37.432  READ LOG DMA EXT
   ef 10 02 00 00 00 a0 08      00:00:37.430  SET FEATURES [Enable SATA 
feature]
   27 00 00 00 00 00 e0 08      00:00:37.427  READ NATIVE MAX ADDRESS EXT 
[OBS-ACS-3]

SMART Self-test log structure revision number 1
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
If Selective self-test is pending on power-up, resume after 0 minute 
delay.

