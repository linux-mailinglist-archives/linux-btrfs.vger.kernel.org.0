Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4F82D7801
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Dec 2020 15:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgLKOfx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 11 Dec 2020 09:35:53 -0500
Received: from mx4.uni-regensburg.de ([194.94.157.149]:48884 "EHLO
        mx4.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405626AbgLKOfu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Dec 2020 09:35:50 -0500
X-Greylist: delayed 554 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Dec 2020 09:35:48 EST
Received: from mx4.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 8E9C9600004F
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Dec 2020 15:25:49 +0100 (CET)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx4.uni-regensburg.de (Postfix) with ESMTP id 6CB2E600004E
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Dec 2020 15:25:49 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Fri, 11 Dec 2020 15:25:49 +0100
Message-Id: <5FD3816B020000A10003D798@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.3.0 
Date:   Fri, 11 Dec 2020 15:25:47 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <linux-btrfs@vger.kernel.org>
Subject: Unrecoverable filesystem (ERROR: child eb corrupted: parent
 bytenr=1106952192 item=75 parent level=1 child level=1)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

While configuring a VM environment in a cluster I had setup an SLES15 SP2 test VM using BtrFS. Due to some problem with libvirt (or the VirtualDomain RA) the VM was active on more than one cluster node at a time, corrupting the filesystem beyond repair it seems:
hvc0:rescue:~ # btrfs check /dev/xvda2
Opening filesystem to check...
Checking filesystem on /dev/xvda2
UUID: 1b651baa-327b-45fe-9512-e7147b24eb49
[1/7] checking root items
ERROR: child eb corrupted: parent bytenr=1107230720 item=75 parent level=1 child level=1
ERROR: failed to repair root items: Input/output error
hvc0:rescue:~ # btrfsck -b /dev/xvda2
Opening filesystem to check...
Checking filesystem on /dev/xvda2
UUID: 1b651baa-327b-45fe-9512-e7147b24eb49
[1/7] checking root items
ERROR: child eb corrupted: parent bytenr=1106952192 item=75 parent level=1 child level=1
ERROR: failed to repair root items: Input/output error
hvc0:rescue:~ # btrfsck --repair /dev/xvda2
enabling repair mode
Opening filesystem to check...
Checking filesystem on /dev/xvda2
UUID: 1b651baa-327b-45fe-9512-e7147b24eb49
[1/7] checking root items
ERROR: child eb corrupted: parent bytenr=1107230720 item=75 parent level=1 child level=1
ERROR: failed to repair root items: Input/output error

Two questions arising:
1) Can't the kernel set some "open flag" early when opening the filesystem, and refuse to open it again (the other VM) when the flag is set? That could avoid such situations I guess
2) Can't btrfs check try somewhat harder to rescue anything, or is the fs structure in a way that everything is lost?

What really puzzles me is this:
There are several snapshots and subvolumes on the BtFS device. It's hard to believe that absolutely nothing seems to be recoverable.

I have this:
hvc0:rescue:~ # btrfs inspect-internal dump-super /dev/xvda2
superblock: bytenr=65536, device=/dev/xvda2
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x659898f3 [match]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    1b651baa-327b-45fe-9512-e7147b24eb49
metadata_uuid           1b651baa-327b-45fe-9512-e7147b24eb49
label
generation              280
root                    1107214336
sys_array_size          97
chunk_root_generation   35
root_level              0
chunk_root              1048576
chunk_root_level        0
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             10727960576
bytes_used              1461825536
sectorsize              4096
nodesize                16384
leafsize (deprecated)           16384
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x163
                        ( MIXED_BACKREF |
                          DEFAULT_SUBVOL |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA )
cache_generation        280
uuid_tree_generation    40
dev_item.uuid           2abdf93e-2f2d-4eef-a1d8-9325f809ebce
dev_item.fsid           1b651baa-327b-45fe-9512-e7147b24eb49 [match]
dev_item.type           0
dev_item.total_bytes    10727960576
dev_item.bytes_used     2436890624
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0

Regards,
Ulrich Windl


