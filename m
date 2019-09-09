Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFD2ADADC
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2019 16:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405248AbfIIOMH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 10:12:07 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34012 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405245AbfIIOMH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Sep 2019 10:12:07 -0400
Received: by mail-qk1-f195.google.com with SMTP id q203so13194152qke.1
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Sep 2019 07:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ceJ2hkUqwvWEFecLnRSqs0KI2OP/HyhAxk+Skzca7uc=;
        b=qVOFVopFLrl8L3uz1fdcE6WSo25dsmr8lT7fCoOJm3fiVu7BV+ya1HjIMJ4dKBx9fE
         3uctlaUJhpxdH2ToKnW/7g6TQiWQ8O8Nql8s9DztPnroaunivOzXzT5dcATsu7PSor2i
         GZxYq/KXtxQpLyHgjJbdBbKZDw1s2W2zK6AORmobGCvECzBlTdv/oXcX0sPy4bIuzVaD
         9HVEbih0G5vfaJEI7lzpRFfhtA9U1MJ8anNG2yDEHyN3cEN/RMbgwDsbw7zoFuQOk10N
         WRQlPuWOkfACo3iOczniSU/aglvxn3fXpGeY9VXgjX7sB1r74WVOxCjdXMU0UVJH8mYS
         HNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ceJ2hkUqwvWEFecLnRSqs0KI2OP/HyhAxk+Skzca7uc=;
        b=ChWEaCiQRaz5h4HO/g7n00Jd7rklx9c+/a7OGjUUe8oOs/BZDJYwACLhhzQKWBiJH7
         3Vd3krOxRvQVx9b7jAHm3UzLemvt/fnDfa1TeUkrbftAO5+Ad3oNExyTJx8zm54FmqIu
         dpMTtT3m1It6idXu6y/yaWYgmoFvXb/UZySYTU/pYNPSZNRcgWjDXg9pNYkX5JQb1J3Y
         pCCHBtVHnU+vZQqdQ1lhJaEcejLNP28H6qy1nufHXe3Xy7Y7zGKtbbhVH8m5IH4Jcm8+
         Zvi9F9yiyrGltfvU6e1cqlgk4x3CoKbodn+3++08VwFM5QSYf3XACWKq/sW4mtFuTk6k
         ONpw==
X-Gm-Message-State: APjAAAUDA82/NHPUljDoLiMHcb8m7ec5QG0xYrp+03iM/v+ZuWHFHpkw
        NoinROYk6dmYc5QW5YlhXacssA==
X-Google-Smtp-Source: APXvYqzHq0l4ZiIyPARdAMPU7TBQfoy7E3iHpZkQBgNVl5AuufTw4tF/EOh7CgpUsTjXCbVjSGXe4w==
X-Received: by 2002:a37:4c14:: with SMTP id z20mr13441927qka.296.1568038326167;
        Mon, 09 Sep 2019 07:12:06 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z5sm6575814qki.55.2019.09.09.07.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:12:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Cc:     Zdenek Sojka <zsojka@seznam.cz>
Subject: [PATCH] btrfs: nofs inode allocations
Date:   Mon,  9 Sep 2019 10:12:04 -0400
Message-Id: <20190909141204.24557-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A user reported a lockdep splat

 ======================================================
 WARNING: possible circular locking dependency detected
 5.2.11-gentoo #2 Not tainted
 ------------------------------------------------------
 kswapd0/711 is trying to acquire lock:
 000000007777a663 (sb_internal){.+.+}, at: start_transaction+0x3a8/0x500

but task is already holding lock:
 000000000ba86300 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x0/0x30

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}:
 kmem_cache_alloc+0x1f/0x1c0
 btrfs_alloc_inode+0x1f/0x260
 alloc_inode+0x16/0xa0
 new_inode+0xe/0xb0
 btrfs_new_inode+0x70/0x610
 btrfs_symlink+0xd0/0x420
 vfs_symlink+0x9c/0x100
 do_symlinkat+0x66/0xe0
 do_syscall_64+0x55/0x1c0
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (sb_internal){.+.+}:
 __sb_start_write+0xf6/0x150
 start_transaction+0x3a8/0x500
 btrfs_commit_inode_delayed_inode+0x59/0x110
 btrfs_evict_inode+0x19e/0x4c0
 evict+0xbc/0x1f0
 inode_lru_isolate+0x113/0x190
 __list_lru_walk_one.isra.4+0x5c/0x100
 list_lru_walk_one+0x32/0x50
 prune_icache_sb+0x36/0x80
 super_cache_scan+0x14a/0x1d0
 do_shrink_slab+0x131/0x320
 shrink_node+0xf7/0x380
 balance_pgdat+0x2d5/0x640
 kswapd+0x2ba/0x5e0
 kthread+0x147/0x160
 ret_from_fork+0x24/0x30

other info that might help us debug this:

 Possible unsafe locking scenario:

 CPU0 CPU1
 ---- ----
 lock(fs_reclaim);
 lock(sb_internal);
 lock(fs_reclaim);
 lock(sb_internal);
*** DEADLOCK ***

 3 locks held by kswapd0/711:
 #0: 000000000ba86300 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x0/0x30
 #1: 000000004a5100f8 (shrinker_rwsem){++++}, at: shrink_node+0x9a/0x380
 #2: 00000000f956fa46 (&type->s_umount_key#30){++++}, at: super_cache_scan+0x35/0x1d0

stack backtrace:
 CPU: 7 PID: 711 Comm: kswapd0 Not tainted 5.2.11-gentoo #2
 Hardware name: Dell Inc. Precision Tower 3620/0MWYPT, BIOS 2.4.2 09/29/2017
 Call Trace:
 dump_stack+0x85/0xc7
 print_circular_bug.cold.40+0x1d9/0x235
 __lock_acquire+0x18b1/0x1f00
 lock_acquire+0xa6/0x170
 ? start_transaction+0x3a8/0x500
 __sb_start_write+0xf6/0x150
 ? start_transaction+0x3a8/0x500
 start_transaction+0x3a8/0x500
 btrfs_commit_inode_delayed_inode+0x59/0x110
 btrfs_evict_inode+0x19e/0x4c0
 ? var_wake_function+0x20/0x20
 evict+0xbc/0x1f0
 inode_lru_isolate+0x113/0x190
 ? discard_new_inode+0xc0/0xc0
 __list_lru_walk_one.isra.4+0x5c/0x100
 ? discard_new_inode+0xc0/0xc0
 list_lru_walk_one+0x32/0x50
 prune_icache_sb+0x36/0x80
 super_cache_scan+0x14a/0x1d0
 do_shrink_slab+0x131/0x320
 shrink_node+0xf7/0x380
 balance_pgdat+0x2d5/0x640
 kswapd+0x2ba/0x5e0
 ? __wake_up_common_lock+0x90/0x90
 kthread+0x147/0x160
 ? balance_pgdat+0x640/0x640
 ? __kthread_create_on_node+0x160/0x160
 ret_from_fork+0x24/0x30

This is because btrfs_new_inode() calls new_inode() under the
transaction.  We could probably move the new_inode() outside of this but
for now just wrap it in memalloc_nofs_save().

Reported-by: Zdenek Sojka <zsojka@seznam.cz>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index aece5dd0e7a8..bf40d1085e4e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6291,13 +6291,16 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	u32 sizes[2];
 	int nitems = name ? 2 : 1;
 	unsigned long ptr;
+	unsigned long nofs_flag;
 	int ret;
 
 	path = btrfs_alloc_path();
 	if (!path)
 		return ERR_PTR(-ENOMEM);
 
+	nofs_flag = memalloc_nofs_save();
 	inode = new_inode(fs_info->sb);
+	memalloc_nofs_restore(nofs_flag);
 	if (!inode) {
 		btrfs_free_path(path);
 		return ERR_PTR(-ENOMEM);
-- 
2.21.0

