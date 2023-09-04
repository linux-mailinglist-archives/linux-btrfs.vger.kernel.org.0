Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB478791F17
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Sep 2023 23:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjIDVsG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Sep 2023 17:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIDVsF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Sep 2023 17:48:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF25180
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Sep 2023 14:48:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E01341F37C;
        Mon,  4 Sep 2023 21:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693864080;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oZu59OVYDYcOSMhduvi5buljqBX2uVj7FizUW03VPLM=;
        b=rpeHOx05MsGc55AN6nXoEgoYneaBUD+cKdUIHRloW+ZfBl6pCCqMYMoecqSpyh0C/WtNt4
        +x26lgc61x33GdVpU/RjqZ/akj918l7telrqCbXZD2PRi+IphOzK8YAW4CPUbWL+/x06R+
        ZwAypHVlwXADwTE12OQocnC7akrciW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693864080;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oZu59OVYDYcOSMhduvi5buljqBX2uVj7FizUW03VPLM=;
        b=NnuBQjKAbEs6EDbvrts2sRCNSSeny/rl9Vcrkq9gK/51Btfw20aBms68H2OAqYLZf5xQwP
        2H429aHzWzg1MVBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B741A13425;
        Mon,  4 Sep 2023 21:48:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Wo+wK5BQ9mSxeAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 04 Sep 2023 21:48:00 +0000
Date:   Mon, 4 Sep 2023 23:41:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: release path before inode lookup during the ino
 lookup ioctl
Message-ID: <20230904214121.GO14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <3433395cd3c3c880bf01392d07813d3677fd010e.1693045620.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3433395cd3c3c880bf01392d07813d3677fd010e.1693045620.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 26, 2023 at 11:28:20AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During the ino lookup ioctl we can end up calling btrfs_iget() to get an
> inode reference while we are holding on a root's btree. If btrfs_iget()
> needs to lookup the inode from the root's btree, because it's not
> currently loaded in memory, then it will need to lock another or the
> same path in the same root btree. This may result in a deadlock and
> trigger the following lockdep splat:
> 
>   WARNING: possible circular locking dependency detected
>   6.5.0-rc7-syzkaller-00004-gf7757129e3de #0 Not tainted
>   ------------------------------------------------------
>   syz-executor277/5012 is trying to acquire lock:
>   ffff88802df41710 (btrfs-tree-01){++++}-{3:3}, at: __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136
> 
>   but task is already holding lock:
>   ffff88802df418e8 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136
> 
>   which lock already depends on the new lock.
> 
>   the existing dependency chain (in reverse order) is:
> 
>   -> #1 (btrfs-tree-00){++++}-{3:3}:
>          down_read_nested+0x49/0x2f0 kernel/locking/rwsem.c:1645
>          __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136
>          btrfs_search_slot+0x13a4/0x2f80 fs/btrfs/ctree.c:2302
>          btrfs_init_root_free_objectid+0x148/0x320 fs/btrfs/disk-io.c:4955
>          btrfs_init_fs_root fs/btrfs/disk-io.c:1128 [inline]
>          btrfs_get_root_ref+0x5ae/0xae0 fs/btrfs/disk-io.c:1338
>          btrfs_get_fs_root fs/btrfs/disk-io.c:1390 [inline]
>          open_ctree+0x29c8/0x3030 fs/btrfs/disk-io.c:3494
>          btrfs_fill_super+0x1c7/0x2f0 fs/btrfs/super.c:1154
>          btrfs_mount_root+0x7e0/0x910 fs/btrfs/super.c:1519
>          legacy_get_tree+0xef/0x190 fs/fs_context.c:611
>          vfs_get_tree+0x8c/0x270 fs/super.c:1519
>          fc_mount fs/namespace.c:1112 [inline]
>          vfs_kern_mount+0xbc/0x150 fs/namespace.c:1142
>          btrfs_mount+0x39f/0xb50 fs/btrfs/super.c:1579
>          legacy_get_tree+0xef/0x190 fs/fs_context.c:611
>          vfs_get_tree+0x8c/0x270 fs/super.c:1519
>          do_new_mount+0x28f/0xae0 fs/namespace.c:3335
>          do_mount fs/namespace.c:3675 [inline]
>          __do_sys_mount fs/namespace.c:3884 [inline]
>          __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
>          do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>          do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>          entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
>   -> #0 (btrfs-tree-01){++++}-{3:3}:
>          check_prev_add kernel/locking/lockdep.c:3142 [inline]
>          check_prevs_add kernel/locking/lockdep.c:3261 [inline]
>          validate_chain kernel/locking/lockdep.c:3876 [inline]
>          __lock_acquire+0x39ff/0x7f70 kernel/locking/lockdep.c:5144
>          lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
>          down_read_nested+0x49/0x2f0 kernel/locking/rwsem.c:1645
>          __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136
>          btrfs_tree_read_lock fs/btrfs/locking.c:142 [inline]
>          btrfs_read_lock_root_node+0x292/0x3c0 fs/btrfs/locking.c:281
>          btrfs_search_slot_get_root fs/btrfs/ctree.c:1832 [inline]
>          btrfs_search_slot+0x4ff/0x2f80 fs/btrfs/ctree.c:2154
>          btrfs_lookup_inode+0xdc/0x480 fs/btrfs/inode-item.c:412
>          btrfs_read_locked_inode fs/btrfs/inode.c:3892 [inline]
>          btrfs_iget_path+0x2d9/0x1520 fs/btrfs/inode.c:5716
>          btrfs_search_path_in_tree_user fs/btrfs/ioctl.c:1961 [inline]
>          btrfs_ioctl_ino_lookup_user+0x77a/0xf50 fs/btrfs/ioctl.c:2105
>          btrfs_ioctl+0xb0b/0xd40 fs/btrfs/ioctl.c:4683
>          vfs_ioctl fs/ioctl.c:51 [inline]
>          __do_sys_ioctl fs/ioctl.c:870 [inline]
>          __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:856
>          do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>          do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>          entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
>   other info that might help us debug this:
> 
>    Possible unsafe locking scenario:
> 
>          CPU0                    CPU1
>          ----                    ----
>     rlock(btrfs-tree-00);
>                                  lock(btrfs-tree-01);
>                                  lock(btrfs-tree-00);
>     rlock(btrfs-tree-01);
> 
>    *** DEADLOCK ***
> 
>   1 lock held by syz-executor277/5012:
>    #0: ffff88802df418e8 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136
> 
>   stack backtrace:
>   CPU: 1 PID: 5012 Comm: syz-executor277 Not tainted 6.5.0-rc7-syzkaller-00004-gf7757129e3de #0
>   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
>   Call Trace:
>    <TASK>
>    __dump_stack lib/dump_stack.c:88 [inline]
>    dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>    check_noncircular+0x375/0x4a0 kernel/locking/lockdep.c:2195
>    check_prev_add kernel/locking/lockdep.c:3142 [inline]
>    check_prevs_add kernel/locking/lockdep.c:3261 [inline]
>    validate_chain kernel/locking/lockdep.c:3876 [inline]
>    __lock_acquire+0x39ff/0x7f70 kernel/locking/lockdep.c:5144
>    lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
>    down_read_nested+0x49/0x2f0 kernel/locking/rwsem.c:1645
>    __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136
>    btrfs_tree_read_lock fs/btrfs/locking.c:142 [inline]
>    btrfs_read_lock_root_node+0x292/0x3c0 fs/btrfs/locking.c:281
>    btrfs_search_slot_get_root fs/btrfs/ctree.c:1832 [inline]
>    btrfs_search_slot+0x4ff/0x2f80 fs/btrfs/ctree.c:2154
>    btrfs_lookup_inode+0xdc/0x480 fs/btrfs/inode-item.c:412
>    btrfs_read_locked_inode fs/btrfs/inode.c:3892 [inline]
>    btrfs_iget_path+0x2d9/0x1520 fs/btrfs/inode.c:5716
>    btrfs_search_path_in_tree_user fs/btrfs/ioctl.c:1961 [inline]
>    btrfs_ioctl_ino_lookup_user+0x77a/0xf50 fs/btrfs/ioctl.c:2105
>    btrfs_ioctl+0xb0b/0xd40 fs/btrfs/ioctl.c:4683
>    vfs_ioctl fs/ioctl.c:51 [inline]
>    __do_sys_ioctl fs/ioctl.c:870 [inline]
>    __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:856
>    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>    do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
>   RIP: 0033:0x7f0bec94ea39
> 
> Fix this simply by releasing the path before calling btrfs_iget() as at
> point we don't need the path anymore.
> 
> Reported-by: syzbot+bf66ad948981797d2f1d@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/00000000000045fa140603c4a969@google.com/
> Fixes: 23d0b79dfaed ("btrfs: Add unprivileged version of ino_lookup ioctl")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
