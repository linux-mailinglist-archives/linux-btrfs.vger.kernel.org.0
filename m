Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D823F3F05
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Aug 2021 13:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbhHVLP1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 22 Aug 2021 07:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbhHVLP0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Aug 2021 07:15:26 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225FFC061575
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Aug 2021 04:14:46 -0700 (PDT)
Received: from ananda.localnet (unknown [IPv6:2001:a62:1a4b:c500:dae2:aa83:6ba6:8ba9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id DFAA62A822E
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Aug 2021 13:14:42 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org
Subject: It's broke, Jim. BTRFS mounted read only after corruption errors on Samsung 980 Pro
Date:   Sun, 22 Aug 2021 13:14:39 +0200
Message-ID: <9070016.RUGz74dYir@ananda>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin2 smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

This might be a sequel of:

Corruption errors on Samsung 980 Pro

https://lore.kernel.org/linux-btrfs/2729231.WZja5ltl65@ananda/

As the checksum errors I had gone away after clearing the v2 space cache,
I thought I can continue using this BTRFS filesystem. Maybe I was wrong
about that.

However it could also be something new, as I had a laptop battery power
outage. For some reason the laptop did not suspend or hibernate probably
and ate up all battery power. I think I set Plasma desktop to hibernate
before at 5% of battery left, but maybe hibernation did not work. I will set
it to properly shutdown the machine instead as that might be more reliable.


Same hardware: ThinkPad T14 AMD Gen 1 with AMD Ryzen 7 PRO 4750U and
32 GiB of RAM, Samsung 980 Pro 2 TB drive, kernel 5.14-rc4. Distribution is
Devuan ceres. BTRFS tools version is 5.10.1-2. However I can and I will update
to 5.13-1 from Debian experimental, please let me know whether you like
me to rerun the BTRFS check below.

BTRFS with ZSTD compression and xxhash checksums on top of dm-crypt
with discards enabled.

On copying a bunch of files from another laptop via rsync to this one I got:

ananda kernel: [10593.681336] BTRFS error (device dm-3): incorrect extent count for 250203865088; counted 1339, expe
ananda kernel: [10593.681352] BTRFS: error (device dm-3) in convert_free_space_to_extents:452: errno=-5 IO failure
ananda kernel: [10593.681357] BTRFS info (device dm-3): forced readonly
ananda kernel: [10593.681361] BTRFS: error (device dm-3) in add_to_free_space_tree:1037: errno=-5 IO failure
ananda kernel: [10593.681365] BTRFS: error (device dm-3) in __btrfs_free_extent:3195: errno=-5 IO failure
ananda kernel: [10593.681369] BTRFS: error (device dm-3) in btrfs_run_delayed_refs:2150: errno=-5 IO failure

I think I rebooted and tried again, same result. Then I un-mounted the
filesystem and tried to mount it again, I got:

BTRFS info (device dm-3): use zstd compression, level 3
BTRFS info (device dm-3): using free space tree
BTRFS info (device dm-3): has skinny extents
BTRFS info (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
BTRFS info (device dm-3): enabling ssd optimizations
BTRFS info (device dm-3): start tree-log replay
BTRFS error (device dm-3): incorrect extent count for 250203865088; counted 1339, expected 1337
BTRFS: error (device dm-3) in convert_free_space_to_extents:452: errno=-5 IO failure
BTRFS: error (device dm-3) in add_to_free_space_tree:1037: errno=-5 IO failure
BTRFS: error (device dm-3) in __btrfs_free_extent:3195: errno=-5 IO failure
BTRFS: error (device dm-3) in btrfs_run_delayed_refs:2150: errno=-5 IO failure
BTRFS: error (device dm-3) in btrfs_replay_log:2415: errno=-5 IO failure (Failed to recover log tree)
BTRFS error (device dm-3): incorrect extent count for 250203865088; counted 1343, expected 1341
BTRFS error (device dm-3): open_ctree failed

Thus I used:

btrfs rescue zero-log /dev/nvme/home

This worked.

I copied over all files to a new LV with BTRFS, this time
I thought I remove some non standard settings. I went with the standard
crc32c checksums instead of xxhash which I formatted the defective BTRFS
with. Rsync reported from files from Akonadi PostgreSQL database as
vanished, I had errors in the log about them. Also another files had
I/O errrors:

linux/.git/objects/pack/pack-cb70e9315626d28754bab943baa468dde6e773d8.pack

I replaced broken or missing files, were just 10 files or so, from backup.
So I have a working /home filesystem again.

I also went back to kernel 5.13.9 in order to exclude any BTRFS bugs in rc
candidate kernel.

I still have the old defect BTRFS filesystem, I renamed its LV to
"homedefect".

BTRFS reported corruption errors above. I thought these were checksum
errors. But:

% mount /dev/nvme/homedefect /mnt/tmp
% btrfs scrub status /mnt/tmp
UUID:             […]
Scrub started:    Sun Aug 22 12:50:18 2021
Status:           finished
Duration:         0:01:56
Total to scrub:   183.95GiB
Rate:             1.58GiB/s
Error summary:    no errors found

BTRFS check reports:

% btrfs check /dev/nvme/homedefect 
Opening filesystem to check...
Checking filesystem on /dev/nvme/homedefect
UUID: […]
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space tree
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
root 1054 inode 156198 errors 200, dir isize wrong
root 1054 inode 2082825 errors 1000, some csum missing
root 1054 inode 6474658 errors 1, no inode item
        unresolved ref dir 156198 index 5145 namelen 11 name global.stat filetype 1 errors 5, no dir item, no inode ref
root 1054 inode 6474661 errors 1, no inode item
        unresolved ref dir 156198 index 5146 namelen 10 name global.tmp filetype 1 errors 5, no dir item, no inode ref
        unresolved ref dir 156198 index 5151 namelen 11 name global.stat filetype 1 errors 5, no dir item, no inode ref
root 1054 inode 6474662 errors 1, no inode item
        unresolved ref dir 156198 index 5148 namelen 13 name db_16401.stat filetype 1 errors 5, no dir item, no inode ref
root 1054 inode 6474663 errors 1, no inode item
        unresolved ref dir 156198 index 5150 namelen 9 name db_0.stat filetype 1 errors 5, no dir item, no inode ref
root 1054 inode 6474664 errors 1, no inode item
        unresolved ref dir 156198 index 5152 namelen 10 name global.tmp filetype 1 errors 5, no dir item, no inode ref
        unresolved ref dir 156198 index 5157 namelen 11 name global.stat filetype 1 errors 5, no dir item, no inode ref
root 1054 inode 6474665 errors 1, no inode item
        unresolved ref dir 156198 index 5154 namelen 13 name db_16401.stat filetype 1 errors 5, no dir item, no inode ref
root 1054 inode 6474666 errors 1, no inode item
        unresolved ref dir 156198 index 5156 namelen 9 name db_0.stat filetype 1 errors 5, no dir item, no inode ref
root 1054 inode 6474667 errors 1, no inode item
        unresolved ref dir 156198 index 5158 namelen 10 name global.tmp filetype 1 errors 5, no dir item, no inode ref

[… those are Akonadi PostgreSQL database files …]

ERROR: errors found in fs roots
found 197513216000 bytes used, error(s) found
total csum bytes: 380971416
total tree bytes: 2439495680
total fs tree bytes: 1756971008
total extent tree bytes: 237273088
btree space waste bytes: 299415459
file data blocks allocated: 237875302400
 referenced 221107453952


Can you do anything with it?

I will be keeping the defect filesystem for a while, so if you want me to
try anything with it, let me know. I can also try to run some diagnostic
commands. I do have a working /home and I have the luxury that I can
keep the broken one around for a while, so I can run some experiments
on it, in case it helps you to determine on how this happened and how
to prevent it. Of course, I also accept if you say that the circumstances
of this make it difficult to find the root cause. I'd like to find it, but I
also found:

Unfortunately also from time to time there are kernel crashes after
resuming from hibernation. Overall I am not yet satisfied with the
stability of Linux on this machine.

Once I even had what appeared to be an endless loop with ps aux –
it repeated the same process list over and over and over again.

Whether there is a relation between all of this, I don't know.

I did a memory test with Lenovo's own UEFI based diagnostic tool and
this did not reveal anything. memtest86+ does not appear to start on this
machine. I did not yet test memtest86 without the plus yet.

Best,
-- 
Martin


