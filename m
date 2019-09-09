Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE9EADB2B
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2019 16:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfIIO2P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 10:28:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:36786 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726774AbfIIO2P (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Sep 2019 10:28:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0C71B653;
        Mon,  9 Sep 2019 14:28:12 +0000 (UTC)
Subject: Re: [PATCH] btrfs: nofs inode allocations
To:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Cc:     Zdenek Sojka <zsojka@seznam.cz>
References: <20190909141204.24557-1-josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a4f375b2-b610-ed0b-4dcf-147da15065ef@suse.com>
Date:   Mon, 9 Sep 2019 17:28:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190909141204.24557-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.09.19 г. 17:12 ч., Josef Bacik wrote:
> A user reported a lockdep splat
> 
>  ======================================================
>  WARNING: possible circular locking dependency detected
>  5.2.11-gentoo #2 Not tainted
>  ------------------------------------------------------
>  kswapd0/711 is trying to acquire lock:
>  000000007777a663 (sb_internal){.+.+}, at: start_transaction+0x3a8/0x500
> 
> but task is already holding lock:
>  000000000ba86300 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x0/0x30
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (fs_reclaim){+.+.}:
>  kmem_cache_alloc+0x1f/0x1c0
>  btrfs_alloc_inode+0x1f/0x260
>  alloc_inode+0x16/0xa0
>  new_inode+0xe/0xb0
>  btrfs_new_inode+0x70/0x610
>  btrfs_symlink+0xd0/0x420
>  vfs_symlink+0x9c/0x100
>  do_symlinkat+0x66/0xe0
>  do_syscall_64+0x55/0x1c0
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> -> #0 (sb_internal){.+.+}:
>  __sb_start_write+0xf6/0x150
>  start_transaction+0x3a8/0x500
>  btrfs_commit_inode_delayed_inode+0x59/0x110
>  btrfs_evict_inode+0x19e/0x4c0
>  evict+0xbc/0x1f0
>  inode_lru_isolate+0x113/0x190
>  __list_lru_walk_one.isra.4+0x5c/0x100
>  list_lru_walk_one+0x32/0x50
>  prune_icache_sb+0x36/0x80
>  super_cache_scan+0x14a/0x1d0
>  do_shrink_slab+0x131/0x320
>  shrink_node+0xf7/0x380
>  balance_pgdat+0x2d5/0x640
>  kswapd+0x2ba/0x5e0
>  kthread+0x147/0x160
>  ret_from_fork+0x24/0x30
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>  CPU0 CPU1
>  ---- ----
>  lock(fs_reclaim);
>  lock(sb_internal);
>  lock(fs_reclaim);
>  lock(sb_internal);
> *** DEADLOCK ***
> 
>  3 locks held by kswapd0/711:
>  #0: 000000000ba86300 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x0/0x30
>  #1: 000000004a5100f8 (shrinker_rwsem){++++}, at: shrink_node+0x9a/0x380
>  #2: 00000000f956fa46 (&type->s_umount_key#30){++++}, at: super_cache_scan+0x35/0x1d0
> 
> stack backtrace:
>  CPU: 7 PID: 711 Comm: kswapd0 Not tainted 5.2.11-gentoo #2
>  Hardware name: Dell Inc. Precision Tower 3620/0MWYPT, BIOS 2.4.2 09/29/2017
>  Call Trace:
>  dump_stack+0x85/0xc7
>  print_circular_bug.cold.40+0x1d9/0x235
>  __lock_acquire+0x18b1/0x1f00
>  lock_acquire+0xa6/0x170
>  ? start_transaction+0x3a8/0x500
>  __sb_start_write+0xf6/0x150
>  ? start_transaction+0x3a8/0x500
>  start_transaction+0x3a8/0x500
>  btrfs_commit_inode_delayed_inode+0x59/0x110
>  btrfs_evict_inode+0x19e/0x4c0
>  ? var_wake_function+0x20/0x20
>  evict+0xbc/0x1f0
>  inode_lru_isolate+0x113/0x190
>  ? discard_new_inode+0xc0/0xc0
>  __list_lru_walk_one.isra.4+0x5c/0x100
>  ? discard_new_inode+0xc0/0xc0
>  list_lru_walk_one+0x32/0x50
>  prune_icache_sb+0x36/0x80
>  super_cache_scan+0x14a/0x1d0
>  do_shrink_slab+0x131/0x320
>  shrink_node+0xf7/0x380
>  balance_pgdat+0x2d5/0x640
>  kswapd+0x2ba/0x5e0
>  ? __wake_up_common_lock+0x90/0x90
>  kthread+0x147/0x160
>  ? balance_pgdat+0x640/0x640
>  ? __kthread_create_on_node+0x160/0x160
>  ret_from_fork+0x24/0x30
> 
> This is because btrfs_new_inode() calls new_inode() under the
> transaction.  We could probably move the new_inode() outside of this but
> for now just wrap it in memalloc_nofs_save().

If I'm understanding correctly what happens here is that symlinking
wants to instantiate a new inode
(new_inode->btrfs_alloc_inode->kmem_cache_alloc with GFP_KERNEL) but it
triggers background reclaim, hence goes to sleep, while holding a
transaction. At the same time background reclaim joins the same
transaction which is now blocked by the symlinking thread, hence it's
prone to deadlock ?
