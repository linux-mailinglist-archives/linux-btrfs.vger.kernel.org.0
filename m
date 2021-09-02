Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156B93FEE3C
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 14:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344895AbhIBNAs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 09:00:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60238 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344884AbhIBNAp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 09:00:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2240422606;
        Thu,  2 Sep 2021 12:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630587586;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3vEZUUkOsWxiwdLwL8LlYLucmF0xVMiC5QDhln34SMw=;
        b=1gwM3771nMlU9X46ovS1HCdd6Aa1AZoOWQItaD+dHul0Ib4YVUHJv+TVeljgwASmr5f+m3
        WzWPLhy/dub87hzfNsE7SOHb0TBOFs9vQVCWoc/78S8qB99XXXIIbO/XqUtTpqE0Utj89w
        gQgNwcmsBn6U9mHpawbR1S61Jb+Y3J4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630587586;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3vEZUUkOsWxiwdLwL8LlYLucmF0xVMiC5QDhln34SMw=;
        b=LnyDkYBXcgDlznYWfaRuR1oXkk7vTVyOYLgywOh3jIZZepGqC14fSobjjDb3wWjGsy/v1I
        BrHSx1fAN4qu7CBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1070FA3BA3;
        Thu,  2 Sep 2021 12:59:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 04006DA72B; Thu,  2 Sep 2021 14:59:44 +0200 (CEST)
Date:   Thu, 2 Sep 2021 14:59:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 7/7] btrfs: do not take the device_list_mutex in
 clone_fs_devices
Message-ID: <20210902125944.GS3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1627419595.git.josef@toxicpanda.com>
 <c3eb810f0b0505757dd2733531c9338c99b8444a.1627419595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3eb810f0b0505757dd2733531c9338c99b8444a.1627419595.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 27, 2021 at 05:01:19PM -0400, Josef Bacik wrote:
> I got the following lockdep splat while testing seed devices
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.14.0-rc2+ #409 Not tainted
> ------------------------------------------------------
> mount/34004 is trying to acquire lock:
> ffff9eaac48188e0 (&fs_devs->device_list_mutex){+.+.}-{3:3}, at: clone_fs_devices+0x4d/0x170
> 
> but task is already holding lock:
> ffff9eaac766d438 (btrfs-chunk-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x24/0x100
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #2 (btrfs-chunk-00){++++}-{3:3}:
>        down_read_nested+0x46/0x60
>        __btrfs_tree_read_lock+0x24/0x100
>        btrfs_read_lock_root_node+0x31/0x40
>        btrfs_search_slot+0x480/0x930
>        btrfs_update_device+0x63/0x180
>        btrfs_chunk_alloc_add_chunk_item+0xdc/0x3a0
>        btrfs_chunk_alloc+0x281/0x540
>        find_free_extent+0x10ca/0x1790
>        btrfs_reserve_extent+0xbf/0x1d0
>        btrfs_alloc_tree_block+0xb1/0x320
>        __btrfs_cow_block+0x136/0x5f0
>        btrfs_cow_block+0x107/0x210
>        btrfs_search_slot+0x56a/0x930
>        btrfs_truncate_inode_items+0x187/0xef0
>        btrfs_truncate_free_space_cache+0x11c/0x210
>        delete_block_group_cache+0x6f/0xb0
>        btrfs_relocate_block_group+0xf8/0x350
>        btrfs_relocate_chunk+0x38/0x120
>        btrfs_balance+0x79b/0xf00
>        btrfs_ioctl_balance+0x327/0x400
>        __x64_sys_ioctl+0x80/0xb0
>        do_syscall_64+0x38/0x90
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #1 (&fs_info->chunk_mutex){+.+.}-{3:3}:
>        __mutex_lock+0x7d/0x750
>        btrfs_init_new_device+0x6d6/0x1540
>        btrfs_ioctl+0x1b12/0x2d30
>        __x64_sys_ioctl+0x80/0xb0
>        do_syscall_64+0x38/0x90
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #0 (&fs_devs->device_list_mutex){+.+.}-{3:3}:
>        __lock_acquire+0x10ea/0x1d90
>        lock_acquire+0xb5/0x2b0
>        __mutex_lock+0x7d/0x750
>        clone_fs_devices+0x4d/0x170
>        btrfs_read_chunk_tree+0x32f/0x800
>        open_ctree+0xae3/0x16f0
>        btrfs_mount_root.cold+0x12/0xea
>        legacy_get_tree+0x2d/0x50
>        vfs_get_tree+0x25/0xc0
>        vfs_kern_mount.part.0+0x71/0xb0
>        btrfs_mount+0x10d/0x380
>        legacy_get_tree+0x2d/0x50
>        vfs_get_tree+0x25/0xc0
>        path_mount+0x433/0xb60
>        __x64_sys_mount+0xe3/0x120
>        do_syscall_64+0x38/0x90
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   &fs_devs->device_list_mutex --> &fs_info->chunk_mutex --> btrfs-chunk-00
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(btrfs-chunk-00);
>                                lock(&fs_info->chunk_mutex);
>                                lock(btrfs-chunk-00);
>   lock(&fs_devs->device_list_mutex);
> 
>  *** DEADLOCK ***
> 
> 3 locks held by mount/34004:
>  #0: ffff9eaad75c00e0 (&type->s_umount_key#47/1){+.+.}-{3:3}, at: alloc_super+0xd5/0x3b0
>  #1: ffffffffbd2dcf08 (uuid_mutex){+.+.}-{3:3}, at: btrfs_read_chunk_tree+0x59/0x800
>  #2: ffff9eaac766d438 (btrfs-chunk-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x24/0x100
> 
> stack backtrace:
> CPU: 0 PID: 34004 Comm: mount Not tainted 5.14.0-rc2+ #409
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
> Call Trace:
>  dump_stack_lvl+0x57/0x72
>  check_noncircular+0xcf/0xf0
>  __lock_acquire+0x10ea/0x1d90
>  lock_acquire+0xb5/0x2b0
>  ? clone_fs_devices+0x4d/0x170
>  ? lock_is_held_type+0xa5/0x120
>  __mutex_lock+0x7d/0x750
>  ? clone_fs_devices+0x4d/0x170
>  ? clone_fs_devices+0x4d/0x170
>  ? lockdep_init_map_type+0x47/0x220
>  ? debug_mutex_init+0x33/0x40
>  clone_fs_devices+0x4d/0x170
>  ? lock_is_held_type+0xa5/0x120
>  btrfs_read_chunk_tree+0x32f/0x800
>  ? find_held_lock+0x2b/0x80
>  open_ctree+0xae3/0x16f0
>  btrfs_mount_root.cold+0x12/0xea
>  ? rcu_read_lock_sched_held+0x3f/0x80
>  ? kfree+0x1f6/0x410
>  legacy_get_tree+0x2d/0x50
>  vfs_get_tree+0x25/0xc0
>  vfs_kern_mount.part.0+0x71/0xb0
>  btrfs_mount+0x10d/0x380
>  ? kfree+0x1f6/0x410
>  legacy_get_tree+0x2d/0x50
>  vfs_get_tree+0x25/0xc0
>  path_mount+0x433/0xb60
>  __x64_sys_mount+0xe3/0x120
>  do_syscall_64+0x38/0x90
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f6cbcd9788e
> 
> It is because we take the ->device_list_mutex in this path while holding
> onto the tree locks in the chunk root.  However we do not need the lock
> here, because we're already holding onto the uuid_mutex, and in fact
> have removed all other uses of the ->device_list_mutex in this path
> because of this.  Remove the ->device_list_mutex locking here, add an
> assert for the uuid_mutex and the problem is fixed.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

I'll pick Anand's version, it adds one more lock annotation and has a
bit more verbose explanation.
