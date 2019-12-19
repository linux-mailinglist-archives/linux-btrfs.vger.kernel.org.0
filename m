Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4AF126E6D
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2019 21:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfLSUHx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 19 Dec 2019 15:07:53 -0500
Received: from nwxsbs11.networkx.de ([217.91.82.83]:64760 "EHLO
        nwxsbs11.networkx.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfLSUHw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Dec 2019 15:07:52 -0500
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Dec 2019 15:07:52 EST
Received: from NWXSBS11.networkx.de ([fe80::4091:24d0:23e7:9e44]) by
 NWXSBS11.networkx.de ([fe80::4091:24d0:23e7:9e44%14]) with mapi id
 14.03.0468.000; Thu, 19 Dec 2019 21:00:12 +0100
From:   Ralf Zerres <Ralf.Zerres@networkx.de>
To:     "'linux-btrfs@vger.kernel.org'" <linux-btrfs@vger.kernel.org>
Subject: How to heel this btrfs fi corruption?
Thread-Topic: How to heel this btrfs fi corruption?
Thread-Index: AdW2puxRpbYJ6wGOS3W1/yTrAS6zvA==
Date:   Thu, 19 Dec 2019 20:00:12 +0000
Message-ID: <C439384E8BF26546BDDE396FFA246D1001921619EB@NWXSBS11.networkx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.10.16]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear list,

at customer site i can't mount a given btrfs device in rw mode.
this is production data and i do have a backup and managed to mount the filesystem in ro mode. I did copy out relevant stuff.
Having said this, if btrfs --repair can't heal the situation, i could reformat the filesystem and start all over.
But i would prefere to save the time and take the heeling as a proof of "production ready" status of btrfs-progs.

Here are the details:

kernel: 5.2.2 (Ubuntu 18.04.3)
btrfs-progs: 5.2.1
HBA: DELL Perc
# storcli /c0/v0
# 0/0   RAID5 Optl  RW     Yes     RWBD  -   OFF 7.274 TB SSD-Data
#btrfs fi show /dev/sdX
#Label: 'Data-Ssd'  uuid: <my uuid>
#        Total devices 1 FS bytes used 7.12TiB
#        devid    1 size 7.27TiB used 7.27TiB path /dev/<mydev>

What happend:
Customer filled up the filesystem (lots of snapshots in a couple of subvolumes).
System was working with kernel 4.15 and btrfs-progs 4.15. I updated kernel and btrfs-progs with the assumption
more mainlined/actual tools could do a better job. Since they have seen lots of fixups.

1) As a first step, i did run

# btrfs check --mode lowmem --progress /dev/<mydev> 

got extend mismatches and wrong extend CRC's

2) As a second step i did try to mount in recovery mode

# mount -t btrfs -o defaults, recovery, skip_balance /dev/<mydev> /mnt

I included skip_balance, since there might be an unfinished balance run. But this didn't work out.

3) As a third step, got it mounted with ro mode

# mount -t  btrfs -o ro /dev/<mydev> /mnt

And filed data received via usage:

# btrfs fi usage /mnt
# Overall:
#    Device size:                   7.27TiB
#    Device allocated:              7.27TiB
#    Device unallocated:            1.00MiB
#    Device missing:                  0.00B
#    Used:                          7.13TiB
#    Free (estimated):            134.13GiB      (min: 134.13GiB)
#    Data ratio:                       1.00
#    Metadata ratio:                   2.00
#    Global reserve:              512.00MiB      (used: 0.00B)
#
# Data,single: Size:7.23TiB, Used:7.10TiB
#   /dev/<mydev>        7.23TiB
#
# Metadata,DUP: Size:21.50GiB, Used:14.31GiB
#   /dev/<mydev>       43.00GiB
#
# System,DUP: Size:8.00MiB, Used:864.00KiB
#   /dev/<mydev>       16.00MiB

# Unallocated:
#   /dev/<mydev>        1.00MiB

Obviously, totally filled up.
At that time i copied out all relevant data - you never know ... Finished!

Then tried to unmout, but that got to nowhere. Leads to a reboot .


4) As a forth step, i tried to repair it

# btrfs check --mode lowmem --progress --repair /dev/<mydev>
# enabling repair mode
# WARNING: low-memory mode repair support is only partial
# Opening filesystem to check...
# Checking filesystem on /dev/<mydev>
# UUID: <my UUID>
# [1/7] checking root items                      (0:00:33 elapsed, 20853512 items checked)
# Fixed 0 roots.
# ERROR: extent[1988733435904, 134217728] referencer count mismatch (root: 261, owner: 286, offset: 5905580032) wanted: # 28, have: 34
# ERROR: fail to allocate new chunk No space left on device
# Try to exclude all metadata blcoks and extents, it may be slow
# Delete backref in extent [1988733435904 134217728]07:16 elapsed, 40435 items checked)
# ERROR: extent[1988733435904, 134217728] referencer count mismatch (root: 261, owner: 286, offset: 5905580032) wanted: 27, have: 34
# Delete backref in extent [1988733435904 134217728]
# ERROR: extent[1988733435904, 134217728] referencer count mismatch (root: 261, owner: 286, offset: 5905580032) wanted: 26, have: 34
# ERROR: commit_root already set when starting transaction
# ERROR: fail to start transaction: Invalid argument
# ERROR: extent[2017321811968, 134217728] referencer count mismatch (root: 261, owner: 287, offset: 2281701376) wanted: 3215, have: 3319
# ERROR: commit_root already set when starting transaction
# ERROR: fail to start transaction Invalid argument

This ends with a core-dump.

Last not least my question:

I'm not experienced enough to solve this issue myself and need your help. 
Is it worth the time and effort to solve this issue? Developers might be interested while having a real live testbed?
Do you need any further info that will help to solve the issue?


Best regards
Ralf





