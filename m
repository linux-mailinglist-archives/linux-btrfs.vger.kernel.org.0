Return-Path: <linux-btrfs+bounces-10995-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91C8A151FA
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2025 15:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42673A4D03
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2025 14:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD4315B0EF;
	Fri, 17 Jan 2025 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="RrujaDmg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4875158851
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2025 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737124785; cv=none; b=sRjpAuKD2r+UZH7MYgBsA08Tgkb8cGwLV9g8dGXg2Jz9LCitHwJyGMgIfFjtSkFMer7VV7XuZkKm2G84jRI9KsieywhRh69kKcMvHVxoReWUBHl26ah996vDv+xHvCtDG/qmczzApsOS5bKxaUc90/bMyTCXE8RuWT7MwRCHPqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737124785; c=relaxed/simple;
	bh=51gUouye4bxwUO9pG/yTvhpAKnnmBvYFprvPQ2p/ghs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTW7MDXHGD3Sf4K90madHkOSipeFY/hm/wpxwgJrxAvlC6O3zMs5VjMRgupcDw+Fm0EYzkXXB8Ws31Lu7UiZ1yFLhTv0dOX7WKgGrtPWJvWfZxn8dx6gNZFzdI8NpEfSbce2olY2qEGTNLkQaQv/GfvOpxkyLSHg7oq//+FeNzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=RrujaDmg; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1737124772;
	bh=GYoDrBNlnGB2is/3PjTCRZ/Q3tZDx+neU+nUb/6vhXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=RrujaDmgLmb3fTgdU30Lp2Y0kpK5Tdaty1gY233sxi4zu8bFurn4Y5I3/RMp027sp
	 kCmuzp7vxzR4XX77PjOnNo95oFHUMA6lF77vI6BtOdB5Kwt59YawJfD2V2vHOPE6Wh
	 DKa41moJmmk8g+QQtz7UFNOvOI4tPRdhiDMMpr8Y=
X-QQ-mid: bizesmtpip2t1737124768t97fy58
X-QQ-Originating-IP: s7W7P3w15dkox5rbrxeL/OQOvOlM/khDAlbVJGfM7Gs=
Received: from [IPV6:2408:8214:5911:e450:e964: ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 17 Jan 2025 22:39:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4019357109963109228
Message-ID: <27DE2B3D274B13F2+405657e4-cd87-4cd2-8f7b-1d2bf0e117fd@bupt.moe>
Date: Fri, 17 Jan 2025 22:39:26 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] zoned device can't properly start full balance
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc: Naohiro Aota <Naohiro.Aota@wdc.com>
References: <FC80D8E2329D01B2+8728a519-d248-4c20-95ad-91750de9fc88@bupt.moe>
 <e13a009b-f221-4c1a-824b-cbdf3fd3f82d@wdc.com>
Content-Language: en-US
From: Yuwei Han <hrx@bupt.moe>
In-Reply-To: <e13a009b-f221-4c1a-824b-cbdf3fd3f82d@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MX+1SEN3H+wAzinKTe3KKF9YCd4GX35vok3q76fVK6beWyal6Eif8C1y
	xJtZns2gjYwu51ckrtrx7WcprbMjASouVs0o3Wa2Sz/MpLztyLACFuFS7CTvNDAb3SPGEXp
	yuiNjaF5Mw7SNMHjt7svEH6OvkyR1w4H3wjw3MexbvX9kMCryYwkPb4b1bMXZ7lkeCNW9pD
	VoYtuHZHTHXzmlgsXqTCmwHuD6KhzACEfZ77xqolYMfo3x5l09OpXc9DCNHPU34QvNMg+ix
	v7r/CnzzLB1OL6bKVhhVtHc6eGfrrZCKbf7ao9aiUVr5J4wAtyFSGG+8uEaazscjda1DtYz
	2AZlrLuLA5aLLa+JAfbAAOVPc2OoUhoIq/pb7xMgZf90kEtPwVRuNQs2aupc2/34v2jfwri
	z5zhmLefTCoP4/UDzTB2HYWzt2s3BLdkMrrtNO8B3T/XaTJZSyzUie2f6kNoRSXxsHkiv//
	jt+vOxLsHvOKP5suM/LU/p3S8YHBVWe8XAnSyrl9Zr+/yTisaPTBBrqNFh35EWpJiZ4xsD3
	86PhWEWv0H5xNsBcsueoCDKB/hKxynGSkJj4Imcq+9oBzlVPle8bmwiKDgwaGCH1Fgcq+Q+
	KE20hdm82TrFO5OtSFZlblopOSX1YX0hRsj1rIO9NvR43oHoy8ar1vxIgOvENxNlRK9A9jJ
	RmH1tbssgxPwzWHof2ZWNjSGl2TNOipu3Zo9SjlI7hpr4roWecJ31zoSBuQWvEEPJnpJR8x
	+sJFFpfgW3bI8cJZbgPOecVN+vTy0aFrHJa49b76q21ShDiE02o63vwNKJLJYIp8jDgW/2J
	WMh8HYDwuREeIBoTiXMc5JtAiRS4k8pqFLQY10UrCYW0g1RB9KeYIYVT8em+BxrImb1trtw
	M0qxFSqxhWKw5rCLrGBvdYetI3kWJEr7LMHw8Hvu2+yZWqLkiMDfpzVP8Ijt1Y7hTdXdlxP
	dFMrkJsDG1XSH2A==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

在 2025/1/17 14:44, Johannes Thumshirn 写道:
> On 17.01.25 03:00, Yuwei Han wrote:
>> [2261102.607764] BTRFS info (device sdb): relocating block group
>> 47851841257472 flags data
>> [2261103.503665] BTRFS error (device sdb): bdev /dev/sdb errs: wr 529,
>> rd 0, flush 0, corrupt 0, gen 0
>> [2261104.311094] BTRFS info (device sdb): balance: ended with status: -5
>>
>> uname -a:Linux aosc3a6 6.11.10-aosc-main #1 SMP PREEMPT_DYNAMIC Sun Dec
>> 1 11:26:32 UTC 2024 loongarch64 GNU/Linux
>>
>> Any suggestions?
> 
> The 529 write errors look very suspicious to me. Now we have to find out
> if it's btrfs, the drive or something in between.
> 
> Can you send me the output of 'btrfs device stats /dev/sdb' and
> 'smartctl -a /dev/sdb' as well as the full dmesg?
smartctl -a /dev/sdb
smartctl 7.3 2022-02-28 r5338 [loongarch64-linux-6.12.9-aosc-main] 
(local build)
Copyright (C) 2002-22, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Device Model:     HSH721414ALN6M0
Serial Number:    VFG51LKD
LU WWN Device Id: 5 000cca 274c24bdb
Firmware Version: T108
User Capacity:    14,000,519,643,136 bytes [14.0 TB]
Sector Size:      4096 bytes logical/physical
Rotation Rate:    7200 rpm
Form Factor:      3.5 inches
Device is:        Not in smartctl database 7.3/5319
ATA Version is:   ACS-2, ATA8-ACS T13/1699-D revision 4
SATA Version is:  SATA 3.2, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Fri Jan 17 21:39:57 2025 CST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82)	Offline data collection activity
					was completed without error.
					Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)	The previous self-test routine 
completed
					without error or no self-test has ever
					been run.
Total time to complete Offline
data collection: 		(  101) seconds.
Offline data collection
capabilities: 			 (0x5b) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					Offline surface scan supported.
					Self-test supported.
					No Conveyance Self-test supported.
					Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					General Purpose Logging supported.
Short self-test routine
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 (1686) minutes.
SCT capabilities: 	       (0x003d)	SCT Status supported.
					SCT Error Recovery Control supported.
					SCT Feature Control supported.
					SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE 
UPDATED  WHEN_FAILED RAW_VALUE
   1 Raw_Read_Error_Rate     0x000b   100   100   016    Pre-fail 
Always       -       0
   2 Throughput_Performance  0x0005   129   129   054    Pre-fail 
Offline      -       124
   3 Spin_Up_Time            0x0007   253   100   024    Pre-fail 
Always       -       184 (Average 240)
   4 Start_Stop_Count        0x0012   100   100   000    Old_age 
Always       -       138
   5 Reallocated_Sector_Ct   0x0033   100   100   005    Pre-fail 
Always       -       0
   7 Seek_Error_Rate         0x000b   100   100   067    Pre-fail 
Always       -       0
   8 Seek_Time_Performance   0x0005   140   136   020    Pre-fail 
Offline      -       15
   9 Power_On_Hours          0x0012   097   097   000    Old_age 
Always       -       21130
  10 Spin_Retry_Count        0x0013   100   100   060    Pre-fail 
Always       -       0
  12 Power_Cycle_Count       0x0032   100   100   000    Old_age 
Always       -       138
  22 Unknown_Attribute       0x0023   100   100   025    Pre-fail 
Always       -       100
192 Power-Off_Retract_Count 0x0032   097   097   000    Old_age   Always 
       -       3790
193 Load_Cycle_Count        0x0012   097   097   000    Old_age   Always 
       -       3790
194 Temperature_Celsius     0x0002   214   115   000    Old_age   Always 
       -       28 (Min/Max 16/53)
196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always 
       -       0
197 Current_Pending_Sector  0x0022   100   100   000    Old_age   Always 
       -       0
198 Offline_Uncorrectable   0x0008   100   100   000    Old_age 
Offline      -       0
199 UDMA_CRC_Error_Count    0x000a   200   200   000    Old_age   Always 
       -       0

SMART Error Log Version: 1
No Errors Logged

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
If Selective self-test is pending on power-up, resume after 0 minute delay.

btrfs device stats /dev/sdb
[/dev/sdb].write_io_errs    529
[/dev/sdb].read_io_errs     0
[/dev/sdb].flush_io_errs    0
[/dev/sdb].corruption_errs  0
[/dev/sdb].generation_errs  0

the device is a zoned device with subpage enabled.

lots of write io errors is due to I have tried balance before and didn't 
noticed this error.
my OS is updated, so the new uname is Linux aosc3a6 6.12.9-aosc-main #1 
SMP PREEMPT_DYNAMIC Thu Jan 16 08:48:09 UTC 2025 loongarch64 GNU/Linux, 
then I tried balance again, but it continued to report error.

> 
> Thanks,
> 	Johannes


