Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECA3224404
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jul 2020 21:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgGQTMm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jul 2020 15:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgGQTMl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jul 2020 15:12:41 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C3DC0619D2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 12:12:41 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b25so8486999qto.2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 12:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BvXIJ8QeWxfjVrC3Irmo+Yr13qeJMFlOttxCdY3q194=;
        b=fVyxOdI9RH8eKCNiDjjhCVhTUYOPmegZoF9kRHfRr9eM7A71U9ZBS0a8E9b+kvagAK
         Fsh6RyiROXIvC4CNLGTA0fn1T04DbTB69V4OTuCxkBI+qzVquM3ZcU4kOltpTeNLIhEB
         j+3kt/EWWulHg6n0bCvJ0CqvAOg1L7T3f5oZW7/VahNQC9oq7Ck5exX7ZFe2eOA3tFpE
         XiS190srxWPADfyHXm7sOenW9kNSKj+tEG2T8QIk0bBEwl8NNJ+KXHhsY/t7wUModZbj
         0/ltzfaPc1j1Jkbx92Vhn0Yz0S4EScPZM1BUqUvRv13QccHu76bTXoIoTvWoTYxs3a39
         YeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BvXIJ8QeWxfjVrC3Irmo+Yr13qeJMFlOttxCdY3q194=;
        b=REn43fvKbpo32xoNQO/PeqqqpZ+wX1si/gtE5SB6z/YIaGGC8QhCYL4Yn610u4R2Du
         QO6oe25Yu+MSY+O46RqGFxmSUi+RlsMrnx9+eo0IyUveNacg9TXK8jTwSJDMKg7ucILJ
         q0GT3oIZv5IVbFIAQ5jZPpsvKP3EzpmbzVOW2u8Xw+J8KRg3uNt8btm9f5l4v0pHcGuI
         oYgiCgwU18dQTGLEBt8GBxhtJkxzxx+fok7KOxnH7Co13khmL1AYZZpG9om/di58FZaA
         2KT2m6qzxdNu8C3kXh7OtiLGSK3rK5dMazjNVfU1/wwnu9vjprKVxpkrhaubY9pQsJRI
         3Kog==
X-Gm-Message-State: AOAM531m3+f4+7/z97kSlFBPgFHAjFcphcCefPE7TbWj3OHiRAMlo4v3
        nwFCzMTXdPkZX+hM9XZ+BwpLLeKAwXUq6Q==
X-Google-Smtp-Source: ABdhPJzv3v3X0FlOXnRKR5WLVwFQjYnvgrEldd8aG0WwSknHc4NfRMF6tZsXKHH+66qNVOjuJwf0lQ==
X-Received: by 2002:ac8:168d:: with SMTP id r13mr12101672qtj.207.1595013159935;
        Fri, 17 Jul 2020 12:12:39 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i35sm10803476qtd.96.2020.07.17.12.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 12:12:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/3] btrfs: fix lockdep splat from btrfs_dump_space_info
Date:   Fri, 17 Jul 2020 15:12:29 -0400
Message-Id: <20200717191229.2283043-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200717191229.2283043-1-josef@toxicpanda.com>
References: <20200717191229.2283043-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When running with -o enospc_debug you can get the following splat if one
of the dump_space_info's trip

======================================================
WARNING: possible circular locking dependency detected
5.8.0-rc5+ #20 Tainted: G           OE
------------------------------------------------------
dd/563090 is trying to acquire lock:
ffff9e7dbf4f1e18 (&ctl->tree_lock){+.+.}-{2:2}, at: btrfs_dump_free_space+0x2b/0xa0 [btrfs]

but task is already holding lock:
ffff9e7e2284d428 (&cache->lock){+.+.}-{2:2}, at: btrfs_dump_space_info+0xaa/0x120 [btrfs]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #3 (&cache->lock){+.+.}-{2:2}:
       _raw_spin_lock+0x25/0x30
       btrfs_add_reserved_bytes+0x3c/0x3c0 [btrfs]
       find_free_extent+0x7ef/0x13b0 [btrfs]
       btrfs_reserve_extent+0x9b/0x180 [btrfs]
       btrfs_alloc_tree_block+0xc1/0x340 [btrfs]
       alloc_tree_block_no_bg_flush+0x4a/0x60 [btrfs]
       __btrfs_cow_block+0x122/0x530 [btrfs]
       btrfs_cow_block+0x106/0x210 [btrfs]
       commit_cowonly_roots+0x55/0x300 [btrfs]
       btrfs_commit_transaction+0x4ed/0xac0 [btrfs]
       sync_filesystem+0x74/0x90
       generic_shutdown_super+0x22/0x100
       kill_anon_super+0x14/0x30
       btrfs_kill_super+0x12/0x20 [btrfs]
       deactivate_locked_super+0x36/0x70
       cleanup_mnt+0x104/0x160
       task_work_run+0x5f/0x90
       __prepare_exit_to_usermode+0x1bd/0x1c0
       do_syscall_64+0x5e/0xb0
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #2 (&space_info->lock){+.+.}-{2:2}:
       _raw_spin_lock+0x25/0x30
       btrfs_block_rsv_release+0x1a6/0x3f0 [btrfs]
       btrfs_inode_rsv_release+0x4f/0x170 [btrfs]
       btrfs_clear_delalloc_extent+0x155/0x480 [btrfs]
       clear_state_bit+0x81/0x1a0 [btrfs]
       __clear_extent_bit+0x25c/0x5d0 [btrfs]
       clear_extent_bit+0x15/0x20 [btrfs]
       btrfs_invalidatepage+0x2b7/0x3c0 [btrfs]
       truncate_cleanup_page+0x47/0xe0
       truncate_inode_pages_range+0x238/0x840
       truncate_pagecache+0x44/0x60
       btrfs_setattr+0x202/0x5e0 [btrfs]
       notify_change+0x33b/0x490
       do_truncate+0x76/0xd0
       path_openat+0x687/0xa10
       do_filp_open+0x91/0x100
       do_sys_openat2+0x215/0x2d0
       do_sys_open+0x44/0x80
       do_syscall_64+0x52/0xb0
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #1 (&tree->lock#2){+.+.}-{2:2}:
       _raw_spin_lock+0x25/0x30
       find_first_extent_bit+0x32/0x150 [btrfs]
       write_pinned_extent_entries.isra.0+0xc5/0x100 [btrfs]
       __btrfs_write_out_cache+0x172/0x480 [btrfs]
       btrfs_write_out_cache+0x7a/0xf0 [btrfs]
       btrfs_write_dirty_block_groups+0x286/0x3b0 [btrfs]
       commit_cowonly_roots+0x245/0x300 [btrfs]
       btrfs_commit_transaction+0x4ed/0xac0 [btrfs]
       close_ctree+0xf9/0x2f5 [btrfs]
       generic_shutdown_super+0x6c/0x100
       kill_anon_super+0x14/0x30
       btrfs_kill_super+0x12/0x20 [btrfs]
       deactivate_locked_super+0x36/0x70
       cleanup_mnt+0x104/0x160
       task_work_run+0x5f/0x90
       __prepare_exit_to_usermode+0x1bd/0x1c0
       do_syscall_64+0x5e/0xb0
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (&ctl->tree_lock){+.+.}-{2:2}:
       __lock_acquire+0x1240/0x2460
       lock_acquire+0xab/0x360
       _raw_spin_lock+0x25/0x30
       btrfs_dump_free_space+0x2b/0xa0 [btrfs]
       btrfs_dump_space_info+0xf4/0x120 [btrfs]
       btrfs_reserve_extent+0x176/0x180 [btrfs]
       __btrfs_prealloc_file_range+0x145/0x550 [btrfs]
       cache_save_setup+0x28d/0x3b0 [btrfs]
       btrfs_start_dirty_block_groups+0x1fc/0x4f0 [btrfs]
       btrfs_commit_transaction+0xcc/0xac0 [btrfs]
       btrfs_alloc_data_chunk_ondemand+0x162/0x4c0 [btrfs]
       btrfs_check_data_free_space+0x4c/0xa0 [btrfs]
       btrfs_buffered_write.isra.0+0x19b/0x740 [btrfs]
       btrfs_file_write_iter+0x3cf/0x610 [btrfs]
       new_sync_write+0x11e/0x1b0
       vfs_write+0x1c9/0x200
       ksys_write+0x68/0xe0
       do_syscall_64+0x52/0xb0
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

other info that might help us debug this:

Chain exists of:
  &ctl->tree_lock --> &space_info->lock --> &cache->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&cache->lock);
                               lock(&space_info->lock);
                               lock(&cache->lock);
  lock(&ctl->tree_lock);

 *** DEADLOCK ***

6 locks held by dd/563090:
 #0: ffff9e7e21d18448 (sb_writers#14){.+.+}-{0:0}, at: vfs_write+0x195/0x200
 #1: ffff9e7dd0410ed8 (&sb->s_type->i_mutex_key#19){++++}-{3:3}, at: btrfs_file_write_iter+0x86/0x610 [btrfs]
 #2: ffff9e7e21d18638 (sb_internal#2){.+.+}-{0:0}, at: start_transaction+0x40b/0x5b0 [btrfs]
 #3: ffff9e7e1f05d688 (&cur_trans->cache_write_mutex){+.+.}-{3:3}, at: btrfs_start_dirty_block_groups+0x158/0x4f0 [btrfs]
 #4: ffff9e7e2284ddb8 (&space_info->groups_sem){++++}-{3:3}, at: btrfs_dump_space_info+0x69/0x120 [btrfs]
 #5: ffff9e7e2284d428 (&cache->lock){+.+.}-{2:2}, at: btrfs_dump_space_info+0xaa/0x120 [btrfs]

stack backtrace:
CPU: 3 PID: 563090 Comm: dd Tainted: G           OE     5.8.0-rc5+ #20
Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./890FX Deluxe5, BIOS P1.40 05/03/2011
Call Trace:
 dump_stack+0x96/0xd0
 check_noncircular+0x162/0x180
 __lock_acquire+0x1240/0x2460
 ? wake_up_klogd.part.0+0x30/0x40
 lock_acquire+0xab/0x360
 ? btrfs_dump_free_space+0x2b/0xa0 [btrfs]
 _raw_spin_lock+0x25/0x30
 ? btrfs_dump_free_space+0x2b/0xa0 [btrfs]
 btrfs_dump_free_space+0x2b/0xa0 [btrfs]
 btrfs_dump_space_info+0xf4/0x120 [btrfs]
 btrfs_reserve_extent+0x176/0x180 [btrfs]
 __btrfs_prealloc_file_range+0x145/0x550 [btrfs]
 ? btrfs_qgroup_reserve_data+0x1d/0x60 [btrfs]
 cache_save_setup+0x28d/0x3b0 [btrfs]
 btrfs_start_dirty_block_groups+0x1fc/0x4f0 [btrfs]
 btrfs_commit_transaction+0xcc/0xac0 [btrfs]
 ? start_transaction+0xe0/0x5b0 [btrfs]
 btrfs_alloc_data_chunk_ondemand+0x162/0x4c0 [btrfs]
 btrfs_check_data_free_space+0x4c/0xa0 [btrfs]
 btrfs_buffered_write.isra.0+0x19b/0x740 [btrfs]
 ? ktime_get_coarse_real_ts64+0xa8/0xd0
 ? trace_hardirqs_on+0x1c/0xe0
 btrfs_file_write_iter+0x3cf/0x610 [btrfs]
 new_sync_write+0x11e/0x1b0
 vfs_write+0x1c9/0x200
 ksys_write+0x68/0xe0
 do_syscall_64+0x52/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

This is because we're holding the block_group->lock while trying to dump
the free space cache.  However we don't need this lock, we just need it
to read the values for the printk, so move the free space cache dumping
outside of the block group lock.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index c7bd3fdd7792..475968ccbd1d 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -468,8 +468,8 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 			"block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %s",
 			cache->start, cache->length, cache->used, cache->pinned,
 			cache->reserved, cache->ro ? "[readonly]" : "");
-		btrfs_dump_free_space(cache, bytes);
 		spin_unlock(&cache->lock);
+		btrfs_dump_free_space(cache, bytes);
 	}
 	if (++index < BTRFS_NR_RAID_TYPES)
 		goto again;
-- 
2.24.1

