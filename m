Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C443056D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 10:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbhA0JYW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 04:24:22 -0500
Received: from smtp84.iad3a.emailsrvr.com ([173.203.187.84]:48595 "EHLO
        smtp84.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232001AbhA0JWg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 04:22:36 -0500
Received: from smtp78.iad3a.emailsrvr.com (relay.iad3a.rsapps.net [172.27.255.110])
        by smtp11.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTPS id 7C35E3AD5
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 03:58:39 -0500 (EST)
X-Auth-ID: a.isaev@rqc.ru
Received: by smtp10.relay.iad3a.emailsrvr.com (Authenticated sender: a.isaev-AT-rqc.ru) with ESMTPSA id DE2A13329;
        Wed, 27 Jan 2021 03:57:56 -0500 (EST)
Subject: Re: btrfs becomes read-only
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <cf9189c0-614c-26e8-9d3e-8e18555c064f@rqc.ru>
 <CAJCQCtQFniOd53+3FFoOo4UM8CzY_vranrrHiWH86HugNvaOpw@mail.gmail.com>
From:   Alexey Isaev <a.isaev@rqc.ru>
Message-ID: <635ef4db-3854-d544-474b-4ecbdea5bc0d@rqc.ru>
Date:   Wed, 27 Jan 2021 11:57:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQFniOd53+3FFoOo4UM8CzY_vranrrHiWH86HugNvaOpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: ru
X-Classification-ID: 8f93b0a0-2d22-44ec-8506-5f82a4cdb522-1-2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

kernel version:

aleksey@host:~$ sudo uname --all
Linux host 4.15.0-132-generic #136~16.04.1-Ubuntu SMP Tue Jan 12 
18:22:20 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux

drive make/model:

Drive is external 5 bay HDD enclosure with raid-5 connected via usb-3 
(made by Orico https://www.orico.cc/us/product/detail/3622.html)
with 5 WD Red 10 Tb. We use this drive for backups.

When i try to run btrfs check i get error message:

aleksey@host:~$ sudo btrfs check --readonly /dev/sdg
Couldn't open file system

aleksey@host:~$ sudo smartctl -x /dev/sdg
smartctl 6.5 2016-01-24 r4214 [x86_64-linux-4.15.0-132-generic] (local 
build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Device Model:     JMicron H/W RAID5
Serial Number:    1IZ6AZCKMIFZYJ8A7V0W
Firmware Version: 0964
User Capacity:    40,003,191,177,216 bytes [40.0 TB]
Sector Size:      512 bytes logical/physical
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ATA/ATAPI-7 (minor revision not indicated)
Local Time is:    Wed Jan 27 08:51:02 2021 UTC
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
AAM feature is:   Unavailable
APM feature is:   Disabled
Rd look-ahead is: Disabled
Write cache is:   Enabled
ATA Security is:  Disabled, NOT FROZEN [SEC1]
Wt Cache Reorder: Unavailable

=== START OF READ SMART DATA SECTION ===
SMART Status not supported: Incomplete response, ATA output registers 
missing
SMART overall-health self-assessment test result: PASSED
Warning: This result is based on an Attribute check.

General SMART Values:
Offline data collection status:  (0x00) Offline data collection activity
                                         was never started.
                                         Auto Offline Data Collection: 
Disabled.
Total time to complete Offline
data collection:                (    0) seconds.
Offline data collection
capabilities:                    (0x00)         Offline data collection 
not supported.
SMART capabilities:            (0x0000) Automatic saving of SMART 
data                                  is not implemented.
Error logging capability:        (0x00) Error logging NOT supported.
                                         No General Purpose Logging support.

General Purpose Log Directory not supported

SMART Log Directory Version 0
Address    Access  R/W   Size  Description
0x00           SL  R/O      1  Log Directory

SMART Extended Comprehensive Error Log (GP Log 0x03) not supported

SMART Error Log not supported

SMART Extended Self-test Log (GP Log 0x07) not supported

SMART Self-test Log not supported

Selective Self-tests/Logging not supported

SCT Commands not supported

Device Statistics (GP/SMART Log 0x04) not supported

SATA Phy Event Counters (GP Log 0x11) not supported

С уважением,
Алексей Исаев,
RQC

27.01.2021 10:38, Chris Murphy пишет:
> On Wed, Jan 27, 2021 at 12:22 AM Alexey Isaev <a.isaev@rqc.ru> wrote:
>> Hello!
>>
>> BTRFS volume becomes read-only with this messages in dmesg.
>> What can i do to repair btrfs partition?
>>
>> [Jan25 08:18] BTRFS error (device sdg): parent transid verify failed on
>> 52180048330752 wanted 132477 found 132432
>> [  +0.007587] BTRFS error (device sdg): parent transid verify failed on
>> 52180048330752 wanted 132477 found 132432
>> [  +0.000132] BTRFS error (device sdg): qgroup scan failed with -5
>>
>> [Jan25 19:52] BTRFS error (device sdg): parent transid verify failed on
>> 52180048330752 wanted 132477 found 132432
>> [  +0.009783] BTRFS error (device sdg): parent transid verify failed on
>> 52180048330752 wanted 132477 found 132432
>> [  +0.000132] BTRFS: error (device sdg) in __btrfs_cow_block:1176:
>> errno=-5 IO failure
>> [  +0.000060] BTRFS info (device sdg): forced readonly
>> [  +0.000004] BTRFS info (device sdg): failed to delete reference to
>> ftrace.h, inode 2986197 parent 2989315
>> [  +0.000002] BTRFS: error (device sdg) in __btrfs_unlink_inode:4220:
>> errno=-5 IO failure
>> [  +0.006071] BTRFS error (device sdg): pending csums is 430080
> What kernel version? What drive make/model?
>
> wanted 132477 found 132432 indicates the drive has lost ~45
> transactions, that's not good and also weird. There's no crash or any
> other errors? A complete dmesg might be more revealing. And also
>
> smartctl -x /dev/sdg
> btrfs check --readonly /dev/sdg
>
> After that I suggest
> https://btrfs.wiki.kernel.org/index.php/Restore
>
> And try to get any important data out if it's not backed up. You can
> try btrfs-find-root to get a listing of roots, most recent to oldest.
> Start at the top, and plug that address in as 'btrfs restore -t' and
> see if it'll pull anything out. You likely need -i and -v options as
> well.
>
