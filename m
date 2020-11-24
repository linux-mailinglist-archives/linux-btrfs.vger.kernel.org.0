Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839252C232E
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Nov 2020 11:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbgKXKoL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Nov 2020 05:44:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:33764 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgKXKoJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Nov 2020 05:44:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606214647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=AsSlktW9wRz220abwa0WtKCgaVKd6WK8aP5IkxPF0Lw=;
        b=AUngGFwloISQh1OxftdKGfC3+dYScP2P/77eV8K3XMfEKkpRAHdxhchAhinhBLZabHleoK
        Bj/Xr0+yHEAo1DlxdprejJu90WK8BnrC725vcj3dat+vUykr5I7jJkAUYoOJ6OLDwU+d0m
        rYcP5w1eAr00ZKK/vBRqz50k95HSiGw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A0632AC2E;
        Tue, 24 Nov 2020 10:44:07 +0000 (UTC)
Subject: Re: [PATCH v2 02/42] btrfs: fix lockdep splat in
 btrfs_recover_relocation
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1605284383.git.josef@toxicpanda.com>
 <44c756daa28122f0f51f52d154c1232a09e66872.1605284383.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <46a41950-6bf0-3b89-ca7c-121c14f95825@suse.com>
Date:   Tue, 24 Nov 2020 12:44:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <44c756daa28122f0f51f52d154c1232a09e66872.1605284383.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.11.20 г. 18:22 ч., Josef Bacik wrote:
> While testing the error paths of relocation I hit the following lockdep
> splat
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.10.0-rc2-btrfs-next-71 #1 Not tainted
> ------------------------------------------------------
> find/324157 is trying to acquire lock:
> ffff8ebc48d293a0 (btrfs-tree-01#2/3){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
> 
> but task is already holding lock:
> ffff8eb9932c5088 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (btrfs-tree-00){++++}-{3:3}:
>        lock_acquire+0xd8/0x490
>        down_write_nested+0x44/0x120
>        __btrfs_tree_lock+0x27/0x120 [btrfs]
>        btrfs_search_slot+0x2a3/0xc50 [btrfs]
>        btrfs_insert_empty_items+0x58/0xa0 [btrfs]
>        insert_with_overflow+0x44/0x110 [btrfs]
>        btrfs_insert_xattr_item+0xb8/0x1d0 [btrfs]
>        btrfs_setxattr+0xd6/0x4c0 [btrfs]
>        btrfs_setxattr_trans+0x68/0x100 [btrfs]
>        __vfs_setxattr+0x66/0x80
>        __vfs_setxattr_noperm+0x70/0x200
>        vfs_setxattr+0x6b/0x120
>        setxattr+0x125/0x240
>        path_setxattr+0xba/0xd0
>        __x64_sys_setxattr+0x27/0x30
>        do_syscall_64+0x33/0x80
>        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> -> #0 (btrfs-tree-01#2/3){++++}-{3:3}:
>        check_prev_add+0x91/0xc60
>        __lock_acquire+0x1689/0x3130
>        lock_acquire+0xd8/0x490
>        down_read_nested+0x45/0x220
>        __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
>        btrfs_next_old_leaf+0x27d/0x580 [btrfs]
>        btrfs_real_readdir+0x1e3/0x4b0 [btrfs]
>        iterate_dir+0x170/0x1c0
>        __x64_sys_getdents64+0x83/0x140
>        do_syscall_64+0x33/0x80
>        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(btrfs-tree-00);
>                                lock(btrfs-tree-01#2/3);
>                                lock(btrfs-tree-00);
>   lock(btrfs-tree-01#2/3);
> 
>  *** DEADLOCK ***
> 
> 5 locks held by find/324157:
>  #0: ffff8ebc502c6e00 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x4d/0x60
>  #1: ffff8eb97f689980 (&type->i_mutex_dir_key#10){++++}-{3:3}, at: iterate_dir+0x52/0x1c0
>  #2: ffff8ebaec00ca58 (btrfs-tree-02#2){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
>  #3: ffff8eb98f986f78 (btrfs-tree-01#2){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
>  #4: ffff8eb9932c5088 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
> 
> stack backtrace:
> CPU: 2 PID: 324157 Comm: find Not tainted 5.10.0-rc2-btrfs-next-71 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  dump_stack+0x8d/0xb5
>  check_noncircular+0xff/0x110
>  ? mark_lock.part.0+0x468/0xe90
>  check_prev_add+0x91/0xc60
>  __lock_acquire+0x1689/0x3130
>  ? kvm_clock_read+0x14/0x30
>  ? kvm_sched_clock_read+0x5/0x10
>  lock_acquire+0xd8/0x490
>  ? __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
>  down_read_nested+0x45/0x220
>  ? __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
>  __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
>  btrfs_next_old_leaf+0x27d/0x580 [btrfs]
>  btrfs_real_readdir+0x1e3/0x4b0 [btrfs]
>  iterate_dir+0x170/0x1c0
>  __x64_sys_getdents64+0x83/0x140
>  ? filldir+0x1d0/0x1d0
>  do_syscall_64+0x33/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> This is thankfully straightforward to fix, simply release the path
> before we setup the reloc_ctl.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

So you are changing btrfs_recover_balance yet nowhere in the stack
traces provided does this functino persist, instead the problem seems to
be due to the way btrfs_real_readdir does its locking. I'm confused.

> ---
>  fs/btrfs/volumes.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index bb1aa96e1233..ece8bb62fcc1 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4283,6 +4283,8 @@ int btrfs_recover_balance(struct btrfs_fs_info *fs_info)
>  		btrfs_warn(fs_info,
>  	"balance: cannot set exclusive op status, resume manually");
>  
> +	btrfs_release_path(path);
> +
>  	mutex_lock(&fs_info->balance_mutex);
>  	BUG_ON(fs_info->balance_ctl);
>  	spin_lock(&fs_info->balance_lock);
> 
