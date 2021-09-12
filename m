Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EF0407CF2
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Sep 2021 12:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhILKvl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Sep 2021 06:51:41 -0400
Received: from mail.linuxsystems.it ([79.7.78.67]:56303 "EHLO
        mail.linuxsystems.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhILKvk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Sep 2021 06:51:40 -0400
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Sep 2021 06:51:39 EDT
Received: by mail.linuxsystems.it (Postfix, from userid 33)
        id CB0E4210237; Sun, 12 Sep 2021 12:27:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxsystems.it;
        s=linuxsystems.it; t=1631442441;
        bh=3kq2bknD32n98YVVHlIqrGeHwoEpG4aeDSOZD1w7B28=;
        h=To:Subject:Date:From:From;
        b=jQps8WQZiaKs6l2khA71mYrw8CxEYzswmle3LZ5LAeP3qZzERcyTW15lsX1bY6/xy
         SK7J7C0MCWZ7phjFSxMKUwfN/z+gWlErCFkcxlN6zMTP+aS4UolYLkvheLS2F2pXM6
         C+TzF/aOQpen+64UUxFknkKCJgV4EVvnAHbIhwr8=
To:     linux-btrfs@vger.kernel.org
Subject: Unmountable / uncheckable Fedora 34 btrfs: failed to read block  groups: -5 open_ctree failed
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 12 Sep 2021 06:27:21 -0400
From:   =?UTF-8?Q?Niccol=C3=B2_Belli?= <darkbasic@linuxsystems.it>
Message-ID: <0303d1f618b815714fe62a6eb90f55ca@linuxsystems.it>
X-Sender: darkbasic@linuxsystems.it
User-Agent: Roundcube Webmail/1.1.5
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Unfortunately my Fedora's btrfs partition failed again. Yet no idea of 
the culprit because memtest passes and the drive is good.
The system freezed and I had to reset (magic Sysrq keys didn't work 
either), being welcomed by an unmountable fs.

This is what I get when I try to mount it:

$ sudo mount /dev/nvme0n1p6 /mnt/
mount: /mnt: wrong fs type, bad option, bad superblock on 
/dev/nvme0n1p6, missing codepage or helper program, or other error.

[  375.964495] BTRFS info (device nvme0n1p6): disk space caching is 
enabled
[  375.964499] BTRFS info (device nvme0n1p6): has skinny extents
[  375.977169] BTRFS warning (device nvme0n1p6): checksum verify failed 
on 21348679680 wanted 0xd05bf9be found 0x2874489b level 1
[  375.977179] BTRFS error (device nvme0n1p6): failed to read block 
groups: -5
[  375.978953] BTRFS error (device nvme0n1p6): open_ctree failed

Check fails to run:

$ sudo btrfs check /dev/nvme0n1p6
Opening filesystem to check...
checksum verify failed on 21348679680 wanted 0xd05bf9be found 0x2874489b
checksum verify failed on 21348679680 wanted 0xd05bf9be found 0x2874489b
Csum didn't match
ERROR: failed to read block groups: Input/output error
ERROR: cannot open file system

usebackuproot didn't help either:

$ sudo mount -o rescue=usebackuproot /dev/nvme0n1p6 /mnt/
mount: /mnt: wrong fs type, bad option, bad superblock on 
/dev/nvme0n1p6, missing codepage or helper program, or other error.

I tried btrfs rescue but it didn't lead to a mountable fs:

$ sudo btrfs rescue super-recover /dev/nvme0n1p6
All supers are valid, no need to recover

$ sudo btrfs rescue zero-log /dev/nvme0n1p6
Clearing log on /dev/nvme0n1p6, previous log_root 21344239616, level 0

$ sudo btrfs rescue chunk-recover /dev/nvme0n1p6
Scanning: DONE in dev0
Check chunks successfully with no orphans
Chunk tree recovered successfully

I did manage to recover some data with btrfs restore (no idea how much 
of it):

$ sudo btrfs restore /dev/nvme0n1p6 
/run/media/liveuser/3ea0705c-21c9-4ba9-80ee-5a511cb2a093/nvme0n1p6_restore/
Skipping snapshot snapshot
[...lots of snapper snapshots]
Skipping snapshot root

I really did want to use rescue=skipbg 
(https://lwn.net/Articles/822242/) or rescue=onlyfs 
(https://lwn.net/ml/linux-btrfs/20200701144438.7613-1-josef@toxicpanda.com/) 
but it seems that neither managed to reach upstream :(

btrfs restore really sucks compared to the previous recovery options 
because it gives you no way to list your subvolumes or to recover a 
specific snapshot.

I've also looked at 
https://en.opensuse.org/SDB:BTRFS#How_to_repair_a_broken.2Funmountable_btrfs_filesystem 
to see if I had any other options left, but it seems I will have to 
reinstall from scratch.

We truly need a better way to recovery-mount partitions, along w/ better 
tools to at least *try* fixing them.

Niccolo'
