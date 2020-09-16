Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85C326C128
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 11:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgIPJxm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 05:53:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:54260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbgIPJxk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 05:53:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9E835AED9;
        Wed, 16 Sep 2020 09:53:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7213CDA7C7; Wed, 16 Sep 2020 11:52:26 +0200 (CEST)
Date:   Wed, 16 Sep 2020 11:52:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        syzbot+e864a35d361e1d4e29a5@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: fix overflow when copying corrupt csums
Message-ID: <20200916095226.GL1791@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        syzbot+e864a35d361e1d4e29a5@syzkaller.appspotmail.com
References: <20200915144931.24555-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915144931.24555-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 15, 2020 at 11:49:31PM +0900, Johannes Thumshirn wrote:
> Syzkaller reported a buffer overflow in btree_readpage_end_io_hook() when
> loop mounting a crafted image:
> 
> detected buffer overflow in memcpy
> ------------[ cut here ]------------
> kernel BUG at lib/string.c:1129!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 26 Comm: kworker/u4:2 Not tainted 5.9.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: btrfs-endio-meta btrfs_work_helper
> RIP: 0010:fortify_panic+0xf/0x20 lib/string.c:1129
> Code: 89 c7 48 89 74 24 08 48 89 04 24 e8 ab 39 00 fe 48 8b 74 24 08 48 8b 04 24 eb d5 48 89 fe 48 c7 c7 40 22 97 88 e8 b0 8c a9 fd <0f> 0b cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 41 57 41 56 41
> RSP: 0018:ffffc90000e27980 EFLAGS: 00010286
> RAX: 0000000000000022 RBX: ffff8880a80dca64 RCX: 0000000000000000
> RDX: ffff8880a90860c0 RSI: ffffffff815dba07 RDI: fffff520001c4f22
> RBP: ffff8880a80dca00 R08: 0000000000000022 R09: ffff8880ae7318e7
> R10: 0000000000000000 R11: 0000000000077578 R12: 00000000ffffff6e
> R13: 0000000000000008 R14: ffffc90000e27a40 R15: 1ffff920001c4f3c
> FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000557335f440d0 CR3: 000000009647d000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  memcpy include/linux/string.h:405 [inline]
>  btree_readpage_end_io_hook.cold+0x206/0x221 fs/btrfs/disk-io.c:642
>  end_bio_extent_readpage+0x4de/0x10c0 fs/btrfs/extent_io.c:2854
>  bio_endio+0x3cf/0x7f0 block/bio.c:1449
>  end_workqueue_fn+0x114/0x170 fs/btrfs/disk-io.c:1695
>  btrfs_work_helper+0x221/0xe20 fs/btrfs/async-thread.c:318
>  process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
>  worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
>  kthread+0x3b5/0x4a0 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> Modules linked in:
> ---[ end trace b68924293169feef ]---
> RIP: 0010:fortify_panic+0xf/0x20 lib/string.c:1129
> Code: 89 c7 48 89 74 24 08 48 89 04 24 e8 ab 39 00 fe 48 8b 74 24 08 48 8b 04 24 eb d5 48 89 fe 48 c7 c7 40 22 97 88 e8 b0 8c a9 fd <0f> 0b cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 41 57 41 56 41
> RSP: 0018:ffffc90000e27980 EFLAGS: 00010286
> RAX: 0000000000000022 RBX: ffff8880a80dca64 RCX: 0000000000000000
> RDX: ffff8880a90860c0 RSI: ffffffff815dba07 RDI: fffff520001c4f22
> RBP: ffff8880a80dca00 R08: 0000000000000022 R09: ffff8880ae7318e7
> R10: 0000000000000000 R11: 0000000000077578 R12: 00000000ffffff6e
> R13: 0000000000000008 R14: ffffc90000e27a40 R15: 1ffff920001c4f3c
> FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f95b7c4d008 CR3: 000000009647d000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> The overflow happens, because in btree_readpage_end_io_hook() we assume that
> we have found a 4 byte checksum instead of the real possible 32 bytes we
> have for the checksums.
> 
> With the fix applied:
> 
> BTRFS: device fsid 815caf9a-dc43-4d2a-ac54-764b8333d765 devid 1 transid 5 /dev/loop0 scanned by syz-repro (214)
> BTRFS info (device loop0): disk space caching is enabled
> BTRFS info (device loop0): has skinny extents
> BTRFS warning (device loop0): loop0 checksum verify failed on 1052672 wanted fc35c0f9 found 4b0bbc71 level 0
> BTRFS error (device loop0): failed to read chunk root
> BTRFS error (device loop0): open_ctree failed
> 
> Fixes: d5178578bcd4 ("btrfs: directly call into crypto framework for checksumming")
> Reported-by: syzbot+e864a35d361e1d4e29a5@syzkaller.appspotmail.com
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---

Added to misc-next, thanks.
