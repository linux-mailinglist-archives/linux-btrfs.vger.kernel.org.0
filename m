Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07281C3F82
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 20:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbfJASLZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 14:11:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:37276 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727345AbfJASLZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Oct 2019 14:11:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84D8FAE6D;
        Tue,  1 Oct 2019 18:11:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2A233DA88C; Tue,  1 Oct 2019 20:11:41 +0200 (CEST)
Date:   Tue, 1 Oct 2019 20:11:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Zdenek Sojka <zsojka@seznam.cz>
Subject: Re: [PATCH] btrfs: nofs inode allocations
Message-ID: <20191001181141.GG2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Zdenek Sojka <zsojka@seznam.cz>
References: <20190909141204.24557-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909141204.24557-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 09, 2019 at 10:12:04AM -0400, Josef Bacik wrote:
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
> 
> Reported-by: Zdenek Sojka <zsojka@seznam.cz>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to 5.4 queue, with the type fixed and updated subject.
