Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3AB0196866
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Mar 2020 19:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgC1S06 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Mar 2020 14:26:58 -0400
Received: from 4brad.ctyme.com ([184.105.182.90]:46640 "EHLO 4brad.ctyme.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbgC1S06 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Mar 2020 14:26:58 -0400
Received: from [192.168.123.14] (c-76-102-119-11.hsd1.ca.comcast.net [76.102.119.11])
        by 4brad.ctyme.com (Postfix) with ESMTPSA id BF7336340A37
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Mar 2020 14:26:57 -0400 (EDT)
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   Brad Templeton <4brad@templetons.com>
Subject: btrfs-transacti hangs system for several seconds every few minutes
Organization: http://www.templetons.com/brad
Message-ID: <7c0a1398-322f-400a-abe4-dfea98fd46e1@templetons.com>
Date:   Sat, 28 Mar 2020 11:26:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a decent sized 3 disk Raid 1 that I have had on btrfs for many
years. Over time, a serious problem has emerged, in that from time to
time all I/O will pause, freezing any programs attempting to use the
btrfs filesystem.   Performance has degraded over the years as well, so
that just browsing around in directories with 300 or so files often
takes many seconds just to autocomplete a filename or do an ls.

But the big problem is that during periods of active but not heavy use,
every few minutes the i/o system will hang for periods of 1 to 10
seconds.   During these hangs, btrfs-transacti is doing very heavy I/O.
  Programs waiting on I/O block -- the most frustrating is typing in vi
and having the echo stop.  It's getting close to unusable and may be
time to leave btrfs after many years for a different FS.

During these incidents iotop will look like this:

Total DISK READ :     499.57 K/s | Total DISK WRITE :    1639.00 K/s
Actual DISK READ:     492.73 K/s | Actual DISK WRITE:       0.00 B/s
  TID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN      IO    COMMAND
  882 be/4 root      499.57 K/s 1604.78 K/s  0.00 % 98.60 %
[btrfs-transacti]
21829 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.23 %
[kworker/u32:1-btrfs-endio-meta]
14662 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.17 %
[kworker/u32:0-btrfs-endio-meta]
22184 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.11 %
[kworker/u32:3-events_freezable_power_]
13063 be/4 root        0.00 B/s    0.00 B/s  0.00 %  0.06 %
[kworker/u32:6-events_freezable_power_]
  486 be/3 root        0.00 B/s    6.84 K/s  0.00 %  0.00 % systemd-journald
22213 be/4 brad        0.00 B/s    6.84 K/s  0.00 %  0.00 % chrome
--no-startup-window [ThreadPoolForeg]

A way to reliably generate it, I have found, is to quickly skim through
my large video collection  (looking for videos) I would be hitting
"next" every second or so -- lots of read, but very little write.
After doing about 40 seconds of this, it is sure to hang.

I am running kernel 5.3.0 on Ubuntu 18.04.4, but have seen this problem
gong back into much older kernels.

My array looks like this:

/dev/sda, ID: 2
   Device size:             3.64TiB
   Device slack:              0.00B
   Data,RAID1:              1.79TiB
   Metadata,RAID1:          8.00GiB
   Unallocated:             1.84TiB

/dev/sdg, ID: 1
   Device size:             9.10TiB
   Device slack:              0.00B
   Data,RAID1:              7.21TiB
   Metadata,RAID1:         14.00GiB
   System,RAID1:           32.00MiB
   Unallocated:             1.87TiB

/dev/sdh, ID: 3
   Device size:             7.28TiB
   Device slack:          344.00KiB
   Data,RAID1:              5.43TiB
   Metadata,RAID1:          8.00GiB
   System,RAID1:           32.00MiB
   Unallocated:             1.84TiB

/dev/sdg on /home type btrfs
(rw,relatime,space_cache,subvolid=256,subvol=/home)

I have 16gb of ram with 16gb of swap on a flash drive, the swap is in use

KiB Mem : 16393944 total,   398800 free, 13538088 used,  2457056 buff/cache
KiB Swap: 16777212 total,  6804352 free,  9972860 used.  2045812 avail Mem


What other information would be useful in attempting to diagnose or fix
this?   I like a number of things about BTFS.  One of them that I don't
want to give up is the ability to do RAID with different sized disks,
which seems like the only way it should work.  Switching to ZFS or mdadm
again would involve disk upgrades and a very large amount of time
copying this much data, but I'll have to do it if I can't diagnose this.


