Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567516FF912
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 May 2023 19:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbjEKR7B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 May 2023 13:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239124AbjEKR6p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 May 2023 13:58:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA7A93F1
        for <linux-btrfs@vger.kernel.org>; Thu, 11 May 2023 10:58:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2894120012;
        Thu, 11 May 2023 17:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683827895;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RnMY42o50MImRZ3NQr31RfysQHTZK6HwZuG6PT4KSyg=;
        b=Csm4o6vrFQVN2zn+zjtnckefW4PNtX1EsEmQeQyg8y0T1XKDdplp3kBNCPzA7IxFZXlUmf
        ZoTU1emJJFskILc1s7Z98b0X6iaZhPbggwPSDQFGO21C08YVHPKlDU9pJ2ckPPYJrxaTBg
        I0b0uYvW2355oJupux5nnCCgxTDA7GI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683827895;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RnMY42o50MImRZ3NQr31RfysQHTZK6HwZuG6PT4KSyg=;
        b=NLLkNXLwLpydpSBsuMSqw1le3fqBC84ijHlP1nLwdvQex49wLOEm1cC2k7apN/EZXns6ba
        f0DxmEKQF0F0+9AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F35AC138FA;
        Thu, 11 May 2023 17:58:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C4mwOrYsXWSYNwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 11 May 2023 17:58:14 +0000
Date:   Thu, 11 May 2023 19:52:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: use nofs when cleaning up aborted transactions
Message-ID: <20230511175214.GZ32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d92da03aa76633c6631b367f1e8ad6055d5756de.1683823518.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d92da03aa76633c6631b367f1e8ad6055d5756de.1683823518.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 11, 2023 at 12:45:59PM -0400, Josef Bacik wrote:
> Our CI system caught a lockdep splat
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.3.0-rc7+ #1167 Not tainted
> ------------------------------------------------------
> kswapd0/46 is trying to acquire lock:
> ffff8c6543abd650 (sb_internal#2){++++}-{0:0}, at: btrfs_commit_inode_delayed_inode+0x5f/0x120
> 
> but task is already holding lock:
> ffffffffabe61b40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x4aa/0x7a0
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (fs_reclaim){+.+.}-{0:0}:
>        fs_reclaim_acquire+0xa5/0xe0
>        kmem_cache_alloc+0x31/0x2c0
>        alloc_extent_state+0x1d/0xd0
>        __clear_extent_bit+0x2e0/0x4f0
>        try_release_extent_mapping+0x216/0x280
>        btrfs_release_folio+0x2e/0x90
>        invalidate_inode_pages2_range+0x397/0x470
>        btrfs_cleanup_dirty_bgs+0x9e/0x210
>        btrfs_cleanup_one_transaction+0x22/0x760
>        btrfs_commit_transaction+0x3b7/0x13a0
>        create_subvol+0x59b/0x970
>        btrfs_mksubvol+0x435/0x4f0
>        __btrfs_ioctl_snap_create+0x11e/0x1b0
>        btrfs_ioctl_snap_create_v2+0xbf/0x140
>        btrfs_ioctl+0xa45/0x28f0
>        __x64_sys_ioctl+0x88/0xc0
>        do_syscall_64+0x38/0x90
>        entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> -> #0 (sb_internal#2){++++}-{0:0}:
>        __lock_acquire+0x1435/0x21a0
>        lock_acquire+0xc2/0x2b0
>        start_transaction+0x401/0x730
>        btrfs_commit_inode_delayed_inode+0x5f/0x120
>        btrfs_evict_inode+0x292/0x3d0
>        evict+0xcc/0x1d0
>        inode_lru_isolate+0x14d/0x1e0
>        __list_lru_walk_one+0xbe/0x1c0
>        list_lru_walk_one+0x58/0x80
>        prune_icache_sb+0x39/0x60
>        super_cache_scan+0x161/0x1f0
>        do_shrink_slab+0x163/0x340
>        shrink_slab+0x1d3/0x290
>        shrink_node+0x300/0x720
>        balance_pgdat+0x35c/0x7a0
>        kswapd+0x205/0x410
>        kthread+0xf0/0x120
>        ret_from_fork+0x29/0x50
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(fs_reclaim);
>                                lock(sb_internal#2);
>                                lock(fs_reclaim);
>   lock(sb_internal#2);
> 
>  *** DEADLOCK ***
> 
> 3 locks held by kswapd0/46:
>  #0: ffffffffabe61b40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x4aa/0x7a0
>  #1: ffffffffabe50270 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0x113/0x290
>  #2: ffff8c6543abd0e0 (&type->s_umount_key#44){++++}-{3:3}, at: super_cache_scan+0x38/0x1f0
> 
> stack backtrace:
> CPU: 0 PID: 46 Comm: kswapd0 Not tainted 6.3.0-rc7+ #1167
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x58/0x90
>  check_noncircular+0xd6/0x100
>  ? save_trace+0x3f/0x310
>  ? add_lock_to_list+0x97/0x120
>  __lock_acquire+0x1435/0x21a0
>  lock_acquire+0xc2/0x2b0
>  ? btrfs_commit_inode_delayed_inode+0x5f/0x120
>  start_transaction+0x401/0x730
>  ? btrfs_commit_inode_delayed_inode+0x5f/0x120
>  btrfs_commit_inode_delayed_inode+0x5f/0x120
>  btrfs_evict_inode+0x292/0x3d0
>  ? lock_release+0x134/0x270
>  ? __pfx_wake_bit_function+0x10/0x10
>  evict+0xcc/0x1d0
>  inode_lru_isolate+0x14d/0x1e0
>  __list_lru_walk_one+0xbe/0x1c0
>  ? __pfx_inode_lru_isolate+0x10/0x10
>  ? __pfx_inode_lru_isolate+0x10/0x10
>  list_lru_walk_one+0x58/0x80
>  prune_icache_sb+0x39/0x60
>  super_cache_scan+0x161/0x1f0
>  do_shrink_slab+0x163/0x340
>  shrink_slab+0x1d3/0x290
>  shrink_node+0x300/0x720
>  balance_pgdat+0x35c/0x7a0
>  kswapd+0x205/0x410
>  ? __pfx_autoremove_wake_function+0x10/0x10
>  ? __pfx_kswapd+0x10/0x10
>  kthread+0xf0/0x120
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x29/0x50
>  </TASK>
> 
> This happens because when we abort the transaction in the transaction
> commit path we call invalidate_inode_pages2_range on our block group
> cache inodes (if we have space cache v1) and any delalloc inodes we may
> have.  The plain invalidate_inode_pages2_range() call passes through
> GFP_KERNEL, which makes sense in most cases, but not here.  Wrap these
> two invalidate calles with memalloc_nofs_save/memalloc_nofs_restore to
> make sure we don't end up with the fs reclaim dependency under the
> transaction dependency.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
