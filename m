Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD8E1196EF5
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Mar 2020 19:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgC2RkA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Mar 2020 13:40:00 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40968 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgC2RkA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Mar 2020 13:40:00 -0400
Received: by mail-qt1-f194.google.com with SMTP id i3so13157609qtv.8
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Mar 2020 10:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=B+FOZjOxhk6FJAXJvnJt8viyEZyIDfMZC32DYZSGTEM=;
        b=iffZx9N6Pc/Liqoy1bNngHFA6p1K+e0p0dvN7BmTAuUbZ0IVzfqp0ogm/dgkcYVK8F
         as482vDfVhMiFlOBwlnqodJpensdQxWX2H7d6y5jFN0Zsaz2MQ1y538RHQ/z9UdO5T1n
         ikdw5bAbAgKu2coqOHwJGbgB2482CUClV3ZPFbwP62uc0Pq0VbqFEc3W36xrV5Q/4r2t
         ZM5IEgSm7QkN87vyOo0dnkQhTI8ADZMaDCvqoN7qGnkI3cQAUst1/jFgppmYwGjH2mDJ
         vpY0SB8EYlHp8uf59NMUx15+fC1s1Sv5dn+ao6KoU8unh+8/pg+HXBZaK69OJKePz8i1
         vt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=B+FOZjOxhk6FJAXJvnJt8viyEZyIDfMZC32DYZSGTEM=;
        b=QC5O2dbfptNOmVIHFGr7yMLdh3m3DSGuOxZ9jyAJF3glc53uXjaXWO+NXKC6g3sxkn
         z85XaF+auX5FLRRfPEyA563L6xgf3weqwgdEOnodo1ytt71Bh/Jt5hex8Je5enVdt43d
         tkfjnqZzLq7w0Jn/XSxPQSsc8q8W9Z95BsP79hu4P+6J9GccSHLettkR98dfvppyk6uC
         pmilq1pjBJS/5gCadbZ9wT5/qF+Lmx05GpHdlkBJORlkJABxsgs+kbTr4TmaM6r+NlMn
         mQJMjROHPbmLoZVFJCr3sx7s58SxyjZyJqU5vjH2Fp0uYLIYaRaCxe4Ich6Emis0vDDD
         V67w==
X-Gm-Message-State: ANhLgQ1V3yMXEwuqVu/GpzLaYchxruSE5Y1bgyNi6AeSn1otLZetFzex
        egAqiR/rGaTzcHw3Yq2wwrX+NxRN
X-Google-Smtp-Source: ADFU+vsdRCSBcc/xuQS835++ZQHQMefRB4owJm6sreF6lxpvM13/j2rjBnORMBzKm6DaL4etvSB6vQ==
X-Received: by 2002:ac8:4e8a:: with SMTP id 10mr8452920qtp.244.1585503599294;
        Sun, 29 Mar 2020 10:39:59 -0700 (PDT)
Received: from ?IPv6:2604:6000:1014:c7c6:edde:350d:ed67:f9ae? ([2604:6000:1014:c7c6:edde:350d:ed67:f9ae])
        by smtp.gmail.com with ESMTPSA id f13sm9173964qte.53.2020.03.29.10.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 10:39:58 -0700 (PDT)
Message-ID: <c2f9a2d8f99d2f07f00ba12f871f31fe85d88427.camel@gmail.com>
Subject: Re: BUG_ON in btrfs check & fs/btrfs/extent-tree.c:3071
From:   Cebtenzzre <cebtenzzre@gmail.com>
To:     Matt Corallo <linux@bluematt.me>, linux-btrfs@vger.kernel.org
Date:   Sun, 29 Mar 2020 13:39:57 -0400
In-Reply-To: <57f3f3bb-b3cb-df2d-9ce6-7b546200c009@bluematt.me>
References: <57f3f3bb-b3cb-df2d-9ce6-7b546200c009@bluematt.me>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 2020-01-24 at 18:57 +0000, Matt Corallo wrote:
> In a 10 disk spinning-rust array on top of dm-crypt thats pretty old
> (was built year ago, most recently running on 4.20 with no issues for
> quite some time), I had a drive fail. Let btrfs device remove $(devid)
> run for some time, spewing errors to dmesg cause the backing device is
> gone but btrfs still hands dm the I/Os. After about a day of this, I
> got
> in a new drive, and had to reshuffle some things to install it, so the
> machine got shut down during the device remove, upgrading to 5.4 in
> the
> process.

I am in a similar situation, except without device mapper, with
seemingly healthy disks that mount without -o degraded, and on kernel
5.5.13 (with btrfs-progs v5.4).

> Boot it back up on 5.4, mount -odegraded, balance -mdevid=$(missing),
> let it run for a while, then I get a series of corrupt leafs, ala:
> 
> [ 6754.454755] BTRFS critical (device dm-6): corrupt leaf:
> block=55800649400320 slot=149 extent bytenr=41634764488704
> len=1007496932043095647 invalid extent data ref hash, item has
> 0x0dfb591f2ab97e5e key has 0x0dfb591f2ab97e5f

I ran btrfs scrub and saw a similar error several times in dmesg:

[ 3518.440710] BTRFS critical (device sdh): corrupt leaf: block=4648795504640 slot=186 extent bytenr=437043331072 len=1007496933515149455 invalid extent data ref hash, item has 0x0dfb591f8277408e key has 0x0dfb591f8277408f
[ 3518.440712] BTRFS error (device sdh): block=4648795504640 read time tree block corruption detected

As far as I can tell, there is only one corrupt block.

> (note only the low bit in the key is different, this is true for all
> the
> similar issues, with  different block, but the same bytenr for several
> attempts)

This is the same in my case. I probably screwed up a btrfs device remove
some time ago.

> All of the dumping of the blocks that show up show only as extent data
> backref root FS_TREE, so unmount and btrfs check -p --clear-space-
> cache
> v1...oops:
> 
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/bigraid1_crypt
> UUID: bde0d0ab-31e6-47b8-8d7f-eef17af4f37e
> Failed to find [22566682869760, 168, 16384]
> btrfs unable to find ref byte nr 22566682869760 parent 0 root 2  owner
> 0
> offset 0
> transaction.c:195: btrfs_commit_transaction: BUG_ON `ret` triggered,
> value -5
> btrfs(+0x45718)[0x117ad5718]
> btrfs(btrfs_commit_transaction+0x13c)[0x117ad5c58]
> btrfs(btrfs_clear_free_space_cache+0x144)[0x117ac8fd0]
> btrfs(+0x59564)[0x117ae9564]
> btrfs(cmd_check+0x6c8)[0x117af5690]
> btrfs(main+0xc0)[0x117aa4660]
> /lib/powerpc64le-linux-gnu/libc.so.6(+0x28328)[0x3fff86e97328]
> /lib/powerpc64le-linux-
> gnu/libc.so.6(__libc_start_main+0xd4)[0x3fff86e97524]
> Aborted

Seeing this is why I chose not to attempt a btrfs check. I guess much of
the kernel code is upset by tree checker errors in a way that can cause
even more harm to the filesystem?

> now if I mount it tries to replay the transaction and gets the same
> from
> the kernel:
> 
> [70990.689101] ------------[ cut here ]------------

[long traces snipped]

> [70990.689928] ---[ end trace 336665b21c6bbe65 ]---
> [70990.689931] BTRFS: error (device dm-7) in __btrfs_free_extent:3077:
> errno=-2 No such entry
> [70990.689951] BTRFS info (device dm-7): forced readonly
> [70990.689953] BTRFS: error (device dm-7) in
> btrfs_run_delayed_refs:2188: errno=-2 No such entry
> [70990.689965] BTRFS warning (device dm-7): Skipping commit of aborted
> transaction.
> [70990.689967] BTRFS: error (device dm-7) in cleanup_transaction:1828:
> errno=-2 No such entry
> [70990.778203] BTRFS info (device dm-7): balance: resume
> -dusage=90,devid=9,vrange=0..41634339225599
> [70990.816444] BTRFS info (device dm-7): balance: ended with status: 0

On my filesystem, trying to truncate the affected files (found using
btrfs insp dump-tree -b 4648795504640) results in the tree checker
errors mentioned before, plus this afterwards:

[  +0.000008] BTRFS: error
(device sdh) in __btrfs_free_extent:3100: errno=-5 IO failure
[  +0.000002] BTRFS info (device sdh): forced readonly
[  +0.000002] BTRFS: error (device sdh) in btrfs_run_delayed_refs:2209: errno=-5 IO failure
[  +0.000265] BTRFS warning (device sdh): failed setting block group ro: -30
[  +0.000002] BTRFS warning (device sdh): failed setting block group ro: -30

I'm glad that btrfs is able to detect and report errors like this, but
it seems like the only thing btrfs can recover from safely without
wiping the entire filesystem and starting over is file data corruption.
I don't really want to spend days rebuilding this filesystem.
-- 
Cebtenzzre <cebtenzzre@gmail.com>

