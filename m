Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0189218B8DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 15:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgCSOLk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 10:11:40 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34999 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbgCSOLj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 10:11:39 -0400
Received: by mail-qk1-f196.google.com with SMTP id d8so3165372qka.2
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 07:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XHbFvnh8ZUn64GICiz2SThOF+nfz+37LyzvSR7oXKdo=;
        b=tkRWXVkCLC2Rv0FYAKJajJD0LdOoSGizbAlYOfwk+bF7Ok8lUudR6SGO5FnkxRLi/7
         NEA3Jq/r2H6nEKg1TnL2d2rOKXBVdSLDZ+AnuRTpAXcB8Jsr+E/IdADaw85zNC18I7i/
         4YEG4BwGssHP56X9DCpO0UIiVIz9aa+RxkFW09B4HqqvHhGD/FnXOQ5p0TJcnaWs+YuZ
         Ky0Wsv7OzNwjGyWtiLQ0GVCCjcEo0IfZ6Bq8C0o3qx580lB49oPDPVvHbyah74+qLJTc
         h2BeNGmKYUBZ0nwwoFfeX04/w8NPXxm2pZOhqygWaELogDyy0htdCUUYGWlsDVDtATY+
         NpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XHbFvnh8ZUn64GICiz2SThOF+nfz+37LyzvSR7oXKdo=;
        b=Ff0IJjq9TwLPljnDYi5sMC4LgpQZhdgcMKpcbNnsy5oG519gigYw0v/29g+uSvX3WG
         kIqR1vbxks7gg6kPhwOv5/+NDdTFRNTh8JoLX+AFY7NB03aA+Qv65T7HDRBnxODGw5lJ
         CIztkq6OMRfvYQiI+clvabDU6mZ8Q4L3oY2LHDB/8gjXj2IZU4IMvALNM1EvqDrdbVPy
         dZQbuJhx+VjB5V0B3QK2W8QFCOZGPTpNJH4/KDLrDiI6pKjLthk96mBeJwa1aFt/INi1
         LhQGk5bHBwJ/gki5gm3hlHoNxrXa97AKCOIJuOkW0b4RoU94Y8H5sbaojXoMB2DOlxki
         Xuug==
X-Gm-Message-State: ANhLgQ1ZaaphiJvgLgTqUyT8vBJeWq3//YX48btbjkCzgQGgbAzg02+z
        HIiInThqmHGRfCg0qz0RhoJM/p3FL8A=
X-Google-Smtp-Source: ADFU+vs1/nkjlHyr9gMt7QGYMcxF4aQ8cTSJoDyAhIG8LSQSrn0rxMoQ6HH24nF6xBQcSbaLRfQJ5w==
X-Received: by 2002:a05:620a:1236:: with SMTP id v22mr3154317qkj.101.1584627097212;
        Thu, 19 Mar 2020 07:11:37 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h143sm1566913qke.58.2020.03.19.07.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 07:11:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: use nofs allocations for running delayed items
Date:   Thu, 19 Mar 2020 10:11:32 -0400
Message-Id: <20200319141132.3127-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Zygo reported the following lockdep splat while testing the balance
patches

======================================================
WARNING: possible circular locking dependency detected
5.6.0-c6f0579d496a+ #53 Not tainted
------------------------------------------------------
kswapd0/1133 is trying to acquire lock:
ffff888092f622c0 (&delayed_node->mutex){+.+.}, at: __btrfs_release_delayed_node+0x7c/0x5b0

but task is already holding lock:
ffffffff8fc5f860 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x5/0x30

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}:
       fs_reclaim_acquire.part.91+0x29/0x30
       fs_reclaim_acquire+0x19/0x20
       kmem_cache_alloc_trace+0x32/0x740
       add_block_entry+0x45/0x260
       btrfs_ref_tree_mod+0x6e2/0x8b0
       btrfs_alloc_tree_block+0x789/0x880
       alloc_tree_block_no_bg_flush+0xc6/0xf0
       __btrfs_cow_block+0x270/0x940
       btrfs_cow_block+0x1ba/0x3a0
       btrfs_search_slot+0x999/0x1030
       btrfs_insert_empty_items+0x81/0xe0
       btrfs_insert_delayed_items+0x128/0x7d0
       __btrfs_run_delayed_items+0xf4/0x2a0
       btrfs_run_delayed_items+0x13/0x20
       btrfs_commit_transaction+0x5cc/0x1390
       insert_balance_item.isra.39+0x6b2/0x6e0
       btrfs_balance+0x72d/0x18d0
       btrfs_ioctl_balance+0x3de/0x4c0
       btrfs_ioctl+0x30ab/0x44a0
       ksys_ioctl+0xa1/0xe0
       __x64_sys_ioctl+0x43/0x50
       do_syscall_64+0x77/0x2c0
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&delayed_node->mutex){+.+.}:
       __lock_acquire+0x197e/0x2550
       lock_acquire+0x103/0x220
       __mutex_lock+0x13d/0xce0
       mutex_lock_nested+0x1b/0x20
       __btrfs_release_delayed_node+0x7c/0x5b0
       btrfs_remove_delayed_node+0x49/0x50
       btrfs_evict_inode+0x6fc/0x900
       evict+0x19a/0x2c0
       dispose_list+0xa0/0xe0
       prune_icache_sb+0xbd/0xf0
       super_cache_scan+0x1b5/0x250
       do_shrink_slab+0x1f6/0x530
       shrink_slab+0x32e/0x410
       shrink_node+0x2a5/0xba0
       balance_pgdat+0x4bd/0x8a0
       kswapd+0x35a/0x800
       kthread+0x1e9/0x210
       ret_from_fork+0x3a/0x50

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&delayed_node->mutex);
                               lock(fs_reclaim);
  lock(&delayed_node->mutex);

 *** DEADLOCK ***

3 locks held by kswapd0/1133:
 #0: ffffffff8fc5f860 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x5/0x30
 #1: ffffffff8fc380d8 (shrinker_rwsem){++++}, at: shrink_slab+0x1e8/0x410
 #2: ffff8881e0e6c0e8 (&type->s_umount_key#42){++++}, at: trylock_super+0x1b/0x70

stack backtrace:
CPU: 2 PID: 1133 Comm: kswapd0 Not tainted 5.6.0-c6f0579d496a+ #53
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
Call Trace:
 dump_stack+0xc1/0x11a
 print_circular_bug.isra.38.cold.57+0x145/0x14a
 check_noncircular+0x2a9/0x2f0
 ? print_circular_bug.isra.38+0x130/0x130
 ? stack_trace_consume_entry+0x90/0x90
 ? save_trace+0x3cc/0x420
 __lock_acquire+0x197e/0x2550
 ? btrfs_inode_clear_file_extent_range+0x9b/0xb0
 ? register_lock_class+0x960/0x960
 lock_acquire+0x103/0x220
 ? __btrfs_release_delayed_node+0x7c/0x5b0
 __mutex_lock+0x13d/0xce0
 ? __btrfs_release_delayed_node+0x7c/0x5b0
 ? __asan_loadN+0xf/0x20
 ? pvclock_clocksource_read+0xeb/0x190
 ? __btrfs_release_delayed_node+0x7c/0x5b0
 ? mutex_lock_io_nested+0xc20/0xc20
 ? __kasan_check_read+0x11/0x20
 ? check_chain_key+0x1e6/0x2e0
 mutex_lock_nested+0x1b/0x20
 ? mutex_lock_nested+0x1b/0x20
 __btrfs_release_delayed_node+0x7c/0x5b0
 btrfs_remove_delayed_node+0x49/0x50
 btrfs_evict_inode+0x6fc/0x900
 ? btrfs_setattr+0x840/0x840
 ? do_raw_spin_unlock+0xa8/0x140
 evict+0x19a/0x2c0
 dispose_list+0xa0/0xe0
 prune_icache_sb+0xbd/0xf0
 ? invalidate_inodes+0x310/0x310
 super_cache_scan+0x1b5/0x250
 do_shrink_slab+0x1f6/0x530
 shrink_slab+0x32e/0x410
 ? do_shrink_slab+0x530/0x530
 ? do_shrink_slab+0x530/0x530
 ? __kasan_check_read+0x11/0x20
 ? mem_cgroup_protected+0x13d/0x260
 shrink_node+0x2a5/0xba0
 balance_pgdat+0x4bd/0x8a0
 ? mem_cgroup_shrink_node+0x490/0x490
 ? _raw_spin_unlock_irq+0x27/0x40
 ? finish_task_switch+0xce/0x390
 ? rcu_read_lock_bh_held+0xb0/0xb0
 kswapd+0x35a/0x800
 ? _raw_spin_unlock_irqrestore+0x4c/0x60
 ? balance_pgdat+0x8a0/0x8a0
 ? finish_wait+0x110/0x110
 ? __kasan_check_read+0x11/0x20
 ? __kthread_parkme+0xc6/0xe0
 ? balance_pgdat+0x8a0/0x8a0
 kthread+0x1e9/0x210
 ? kthread_create_worker_on_cpu+0xc0/0xc0
 ret_from_fork+0x3a/0x50

This is because we hold that delayed node's mutex while doing tree
operations.  Fix this by just wrapping the searches in nofs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-inode.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index ee70584ddc45..14de5b72e57a 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -6,6 +6,7 @@
 
 #include <linux/slab.h>
 #include <linux/iversion.h>
+#include <linux/sched/mm.h>
 #include "misc.h"
 #include "delayed-inode.h"
 #include "disk-io.h"
@@ -805,11 +806,14 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
 				     struct btrfs_delayed_item *delayed_item)
 {
 	struct extent_buffer *leaf;
+	unsigned int nofs_flag;
 	char *ptr;
 	int ret;
 
+	nofs_flag = memalloc_nofs_save();
 	ret = btrfs_insert_empty_item(trans, root, path, &delayed_item->key,
 				      delayed_item->data_len);
+	memalloc_nofs_restore(nofs_flag);
 	if (ret < 0 && ret != -EEXIST)
 		return ret;
 
@@ -937,6 +941,7 @@ static int btrfs_delete_delayed_items(struct btrfs_trans_handle *trans,
 				      struct btrfs_delayed_node *node)
 {
 	struct btrfs_delayed_item *curr, *prev;
+	unsigned int nofs_flag;
 	int ret = 0;
 
 do_again:
@@ -945,7 +950,9 @@ static int btrfs_delete_delayed_items(struct btrfs_trans_handle *trans,
 	if (!curr)
 		goto delete_fail;
 
+	nofs_flag = memalloc_nofs_save();
 	ret = btrfs_search_slot(trans, root, &curr->key, path, -1, 1);
+	memalloc_nofs_restore(nofs_flag);
 	if (ret < 0)
 		goto delete_fail;
 	else if (ret > 0) {
@@ -1012,6 +1019,7 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	struct btrfs_inode_item *inode_item;
 	struct extent_buffer *leaf;
+	unsigned int nofs_flag;
 	int mod;
 	int ret;
 
@@ -1024,7 +1032,9 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
 	else
 		mod = 1;
 
+	nofs_flag = memalloc_nofs_save();
 	ret = btrfs_lookup_inode(trans, root, path, &key, mod);
+	memalloc_nofs_restore(nofs_flag);
 	if (ret > 0) {
 		btrfs_release_path(path);
 		return -ENOENT;
@@ -1075,7 +1085,10 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
 
 	key.type = BTRFS_INODE_EXTREF_KEY;
 	key.offset = -1;
+
+	nofs_flag = memalloc_nofs_save();
 	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
+	memalloc_nofs_restore(nofs_flag);
 	if (ret < 0)
 		goto err_out;
 	ASSERT(ret);
-- 
2.24.1

