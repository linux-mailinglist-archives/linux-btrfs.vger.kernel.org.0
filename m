Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F1D40F976
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Sep 2021 15:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbhIQNoJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Sep 2021 09:44:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55130 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240563AbhIQNoE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Sep 2021 09:44:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F07AD1FE9D;
        Fri, 17 Sep 2021 13:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631886159;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zTgx9w1PkGGQzYv6vVEPiogTRxmfP8ler/OXIErtaeM=;
        b=SU7itC6xudhVDa1fXgklC6Ol1Jyj+d9WKsxu1Skh3Vx0QB3snDCVzW/EN+JyxKrKbgDD3S
        6ny8d2aHyOyexOYRaSmXXFSVrpCRk4YISloHd0pS5+iRE0FKbXhtlksZZbf21ozhcmDVUz
        CvAPbeUAORWcHOU/xNLMC510jCEAmXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631886159;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zTgx9w1PkGGQzYv6vVEPiogTRxmfP8ler/OXIErtaeM=;
        b=xH9ctK+nmmBEm7Ijidh73guAYio+DSaVxIjqqGhXgKIHYG870wonVW9neUcPSB3tG0Btwq
        mH2upuw/xdo8RsBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E8796A3B9A;
        Fri, 17 Sep 2021 13:42:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 56B08DA781; Fri, 17 Sep 2021 15:42:30 +0200 (CEST)
Date:   Fri, 17 Sep 2021 15:42:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: Re: [PATCH] btrfs: unlock the newly allocated extent buffer in
 btrfs_alloc_tree_block()
Message-ID: <20210917134229.GT9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
References: <20210914065759.38793-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914065759.38793-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 14, 2021 at 02:57:59PM +0800, Qu Wenruo wrote:
> [BUG]
> There is a very detailed bug report that injected ENOMEM error could
> leave a tree block locked while we return to user-space:
> 
>   BTRFS info (device loop0): enabling ssd optimizations
>   FAULT_INJECTION: forcing a failure.
>   name failslab, interval 1, probability 0, space 0, times 0
>   CPU: 0 PID: 7579 Comm: syz-executor Not tainted 5.15.0-rc1 #16
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>   rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
>   Call Trace:
>    __dump_stack lib/dump_stack.c:88 [inline]
>    dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
>    fail_dump lib/fault-inject.c:52 [inline]
>    should_fail+0x13c/0x160 lib/fault-inject.c:146
>    should_failslab+0x5/0x10 mm/slab_common.c:1328
>    slab_pre_alloc_hook.constprop.99+0x4e/0xc0 mm/slab.h:494
>    slab_alloc_node mm/slub.c:3120 [inline]
>    slab_alloc mm/slub.c:3214 [inline]
>    kmem_cache_alloc+0x44/0x280 mm/slub.c:3219
>    btrfs_alloc_delayed_extent_op fs/btrfs/delayed-ref.h:299 [inline]
>    btrfs_alloc_tree_block+0x38c/0x670 fs/btrfs/extent-tree.c:4833
>    __btrfs_cow_block+0x16f/0x7d0 fs/btrfs/ctree.c:415
>    btrfs_cow_block+0x12a/0x300 fs/btrfs/ctree.c:570
>    btrfs_search_slot+0x6b0/0xee0 fs/btrfs/ctree.c:1768
>    btrfs_insert_empty_items+0x80/0xf0 fs/btrfs/ctree.c:3905
>    btrfs_new_inode+0x311/0xa60 fs/btrfs/inode.c:6530
>    btrfs_create+0x12b/0x270 fs/btrfs/inode.c:6783
>    lookup_open+0x660/0x780 fs/namei.c:3282
>    open_last_lookups fs/namei.c:3352 [inline]
>    path_openat+0x465/0xe20 fs/namei.c:3557
>    do_filp_open+0xe3/0x170 fs/namei.c:3588
>    do_sys_openat2+0x357/0x4a0 fs/open.c:1200
>    do_sys_open+0x87/0xd0 fs/open.c:1216
>    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>    do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
>    entry_SYSCALL_64_after_hwframe+0x44/0xae
>   RIP: 0033:0x46ae99
>   Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
>   89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
>   01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
>   RSP: 002b:00007f46711b9c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
>   RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
>   RDX: 0000000000000000 RSI: 00000000000000a1 RDI: 0000000020005800
>   RBP: 00007f46711b9c80 R08: 0000000000000000 R09: 0000000000000000
>   R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000017
>   R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffc129da6e0
> 
>   ================================================
>   WARNING: lock held when returning to user space!
>   5.15.0-rc1 #16 Not tainted
>   ------------------------------------------------
>   syz-executor/7579 is leaving the kernel with locks still held!
>   1 lock held by syz-executor/7579:
>    #0: ffff888104b73da8 (btrfs-tree-01/1){+.+.}-{3:3}, at:
>   __btrfs_tree_lock+0x2e/0x1a0 fs/btrfs/locking.c:112
> 
> [CAUSE]
> In btrfs_alloc_tree_block(), after btrfs_init_new_buffer(), the new
> extent buffer @buf is locked, but if later operations like adding
> delayed tree ref fails, we just free @buf without unlocking it,
> resulting above warning.
> 
> [FIX]
> Unlock @buf in out_free_buf: tag.
> 
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CACkBjsZ9O6Zr0KK1yGn=1rQi6Crh1yeCRdTSBxx9R99L4xdn-Q@mail.gmail.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
