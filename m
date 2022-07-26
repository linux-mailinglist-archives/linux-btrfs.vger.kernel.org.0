Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F8A581AFB
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 22:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239924AbiGZUYV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 16:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239933AbiGZUYL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 16:24:11 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC7632070
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 13:24:10 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id m7so11882372qkk.6
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 13:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CIP9N7R80Wp6cUnWtIwrTd/SUOUlx96RBN7r92v6itU=;
        b=kIrTnpvB4loTz049tFk/4+L1Y8AOADhz3iWPwnpmGj5QgGRGYWLJzGhFo5XC/6xH0c
         1cDHbVXOTczWSPQHPAh9OsBBj+BinkZGkk6JLkxM9ZMTKFVB7QYfLCwIkwFyjhaZH7AX
         XFaX/HyqartGT1U/n9imd45nsv7ievMypl30vRhK9Tm99KwdL5nON5MVPunQsiMvhjOz
         wrNsCqwH1t20I47MCtRgz84p6CeHdanRk2MvZDf5KptRyvUWjmSHTTF55hDeZX4YW1GU
         xLxWKciSw51uQHhcUdDiW5mjMgqtO9ROTZD+B1iT7E7ifBmo+5xA9+JEeaBsFXoLOdjg
         uprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CIP9N7R80Wp6cUnWtIwrTd/SUOUlx96RBN7r92v6itU=;
        b=QuNQzCfr+GLFR1k85DFzaUEb3EzK5zGsIvCYE506O4fJrzqgkNZ6m4eMDCckG1or+M
         8tbvaD3J/Y1qaBIPCOPRQ/fLMfMZVJpAymIYyHfkXFY6CHF2a1V4+IRyCmtZm4oyq/1W
         uP6ukqknJbbnvvtwK8gr179B0zIKtCXzxAYUt1nKTaWWHOG7LacVbyb++moiOlUm0fo3
         C8LNV36a/SjRUZa/pvLW6R9N8OcOnzRWgxtwV641kIP/pvG6m/U65fnpvWZBCAavwdvA
         oELobKDIpslGCBu7GvnFw3g8J66vcNeHG0GT0YHyy+dIm8LhN6krcGSiwKPDm9VEcNRb
         unTg==
X-Gm-Message-State: AJIora+pMzB5B/k1AewDiSLfuYrGtNY2rFrEHra8AMuij+rJSg8pcbg6
        sSbQJMl83kQ3u8lKf11VGHRAXPGvf0RuwQ==
X-Google-Smtp-Source: AGRyM1uisDigx2AAzCkDFezk3j7cXJS89clwDS8pvl3Kva9ZOH74IFkRpLXjpWSlFwJHztJy4iWQ4w==
X-Received: by 2002:a05:620a:269a:b0:6b5:b769:2591 with SMTP id c26-20020a05620a269a00b006b5b7692591mr13856289qkp.293.1658867048794;
        Tue, 26 Jul 2022 13:24:08 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bq20-20020a05622a1c1400b00304efba3d84sm9285369qtb.25.2022.07.26.13.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 13:24:08 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: fix lockdep splat with reloc root extent buffers
Date:   Tue, 26 Jul 2022 16:24:04 -0400
Message-Id: <820798694be768dc90c81b20ef3be1ba5107cc15.1658866962.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1658866962.git.josef@toxicpanda.com>
References: <cover.1658866962.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have been hitting the following lockdep splat with btrfs/187 recently

======================================================
WARNING: possible circular locking dependency detected
5.19.0-rc8+ #775 Not tainted
------------------------------------------------------
btrfs/752500 is trying to acquire lock:
ffff97e1875a97b8 (btrfs-treloc-02#2){+.+.}-{3:3}, at: __btrfs_tree_lock+0x24/0x110

but task is already holding lock:
ffff97e1875a9278 (btrfs-tree-01/1){+.+.}-{3:3}, at: __btrfs_tree_lock+0x24/0x110

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (btrfs-tree-01/1){+.+.}-{3:3}:
       down_write_nested+0x41/0x80
       __btrfs_tree_lock+0x24/0x110
       btrfs_init_new_buffer+0x7d/0x2c0
       btrfs_alloc_tree_block+0x120/0x3b0
       __btrfs_cow_block+0x136/0x600
       btrfs_cow_block+0x10b/0x230
       btrfs_search_slot+0x53b/0xb70
       btrfs_lookup_inode+0x2a/0xa0
       __btrfs_update_delayed_inode+0x5f/0x280
       btrfs_async_run_delayed_root+0x24c/0x290
       btrfs_work_helper+0xf2/0x3e0
       process_one_work+0x271/0x590
       worker_thread+0x52/0x3b0
       kthread+0xf0/0x120
       ret_from_fork+0x1f/0x30

-> #1 (btrfs-tree-01){++++}-{3:3}:
       down_write_nested+0x41/0x80
       __btrfs_tree_lock+0x24/0x110
       btrfs_search_slot+0x3c3/0xb70
       do_relocation+0x10c/0x6b0
       relocate_tree_blocks+0x317/0x6d0
       relocate_block_group+0x1f1/0x560
       btrfs_relocate_block_group+0x23e/0x400
       btrfs_relocate_chunk+0x4c/0x140
       btrfs_balance+0x755/0xe40
       btrfs_ioctl+0x1ea2/0x2c90
       __x64_sys_ioctl+0x88/0xc0
       do_syscall_64+0x38/0x90
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (btrfs-treloc-02#2){+.+.}-{3:3}:
       __lock_acquire+0x1122/0x1e10
       lock_acquire+0xc2/0x2d0
       down_write_nested+0x41/0x80
       __btrfs_tree_lock+0x24/0x110
       btrfs_lock_root_node+0x31/0x50
       btrfs_search_slot+0x1cb/0xb70
       replace_path+0x541/0x9f0
       merge_reloc_root+0x1d6/0x610
       merge_reloc_roots+0xe2/0x260
       relocate_block_group+0x2c8/0x560
       btrfs_relocate_block_group+0x23e/0x400
       btrfs_relocate_chunk+0x4c/0x140
       btrfs_balance+0x755/0xe40
       btrfs_ioctl+0x1ea2/0x2c90
       __x64_sys_ioctl+0x88/0xc0
       do_syscall_64+0x38/0x90
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  btrfs-treloc-02#2 --> btrfs-tree-01 --> btrfs-tree-01/1

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-tree-01/1);
                               lock(btrfs-tree-01);
                               lock(btrfs-tree-01/1);
  lock(btrfs-treloc-02#2);

 *** DEADLOCK ***

7 locks held by btrfs/752500:
 #0: ffff97e292fdf460 (sb_writers#12){.+.+}-{0:0}, at: btrfs_ioctl+0x208/0x2c90
 #1: ffff97e284c02050 (&fs_info->reclaim_bgs_lock){+.+.}-{3:3}, at: btrfs_balance+0x55f/0xe40
 #2: ffff97e284c00878 (&fs_info->cleaner_mutex){+.+.}-{3:3}, at: btrfs_relocate_block_group+0x236/0x400
 #3: ffff97e292fdf650 (sb_internal#2){.+.+}-{0:0}, at: merge_reloc_root+0xef/0x610
 #4: ffff97e284c02378 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0x1a8/0x5a0
 #5: ffff97e284c023a0 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x1a8/0x5a0
 #6: ffff97e1875a9278 (btrfs-tree-01/1){+.+.}-{3:3}, at: __btrfs_tree_lock+0x24/0x110

stack backtrace:
CPU: 1 PID: 752500 Comm: btrfs Not tainted 5.19.0-rc8+ #775
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
Call Trace:

 dump_stack_lvl+0x56/0x73
 check_noncircular+0xd6/0x100
 ? lock_is_held_type+0xe2/0x140
 __lock_acquire+0x1122/0x1e10
 lock_acquire+0xc2/0x2d0
 ? __btrfs_tree_lock+0x24/0x110
 down_write_nested+0x41/0x80
 ? __btrfs_tree_lock+0x24/0x110
 __btrfs_tree_lock+0x24/0x110
 btrfs_lock_root_node+0x31/0x50
 btrfs_search_slot+0x1cb/0xb70
 ? lock_release+0x137/0x2d0
 ? _raw_spin_unlock+0x29/0x50
 ? release_extent_buffer+0x128/0x180
 replace_path+0x541/0x9f0
 merge_reloc_root+0x1d6/0x610
 merge_reloc_roots+0xe2/0x260
 relocate_block_group+0x2c8/0x560
 btrfs_relocate_block_group+0x23e/0x400
 btrfs_relocate_chunk+0x4c/0x140
 btrfs_balance+0x755/0xe40
 btrfs_ioctl+0x1ea2/0x2c90
 ? lock_is_held_type+0xe2/0x140
 ? lock_is_held_type+0xe2/0x140
 ? __x64_sys_ioctl+0x88/0xc0
 __x64_sys_ioctl+0x88/0xc0
 do_syscall_64+0x38/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

This isn't necessarily new, it's just tricky to hit in practice.  There
are two competing things going on here.  With relocation we create a
snapshot of every fs tree with a reloc tree.  Any extent buffers that
get initialized here are initialized with the reloc root lockdep key.
However since it is a snapshot, any blocks that are currently in cache
that originally belonged to the fs tree will have the normal tree
lockdep key set.  This creates the lock dependency of

reloc tree -> normal tree

for the extent buffer locking during the first phase of the relocation
as we walk down the reloc root to relocate blocks.

However this is problematic because the final phase of the relocation is
merging the reloc root into the original fs root.  This involves
searching down to any keys that exist in the original fs root and then
swapping the relocated block and the original fs root block.  We have to
search down to the fs root first, and then go search the reloc root for
the block we need to replace.  This creates the dependency of

normal tree -> reloc tree

which is why lockdep complains.

Additionally even if we were to fix this particular mismatch with a
different nesting for the merge case, we're still slotting in a block
that has a owner of the reloc root objectid into a normal tree, so that
block will have its lockdep key set to the tree reloc root, and create a
lockdep splat later on when we wander into that block from the fs root.

Unfortunately the only solution here is to make sure we do not set the
lockdep key to the reloc tree lockdep key normally, and then reset any
blocks we wander into from the reloc root when we're doing the merged.

This solves the problem of having mixed tree reloc keys intermixed with
normal tree keys, and then allows us to make sure in the merge case we
maintain the lock order of

normal tree -> reloc tree

We handle this by setting a bit on the reloc root when we do the search
for the block we want to relocate, and any block we search into or cow
at that point gets set to the reloc tree key.  This works correctly
because we only ever cow down to the parent node, so we aren't resetting
the key for the block we're linking into the fs root.

With this patch we no longer have the lockdep splat in btrfs/187.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c       |  3 +++
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/extent-tree.c | 18 +++++++++++++++++-
 fs/btrfs/extent_io.c   | 11 ++++++++++-
 fs/btrfs/locking.c     | 13 +++++++++++++
 fs/btrfs/locking.h     |  6 ++++++
 fs/btrfs/relocation.c  |  2 ++
 7 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 6e556031a8f3..ebfa35fe1c38 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2075,6 +2075,9 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 
 		if (!p->skip_locking) {
 			level = btrfs_header_level(b);
+
+			btrfs_maybe_reset_lockdep_class(root, b);
+
 			if (level <= write_lock_level) {
 				btrfs_tree_lock(b);
 				p->locks[level] = BTRFS_WRITE_LOCK;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4db85b9dc7ed..89942284cb8e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1173,6 +1173,8 @@ enum {
 	BTRFS_ROOT_ORPHAN_CLEANUP,
 	/* This root has a drop operation that was started previously. */
 	BTRFS_ROOT_UNFINISHED_DROP,
+	/* This reloc root needs to have it's buffers lockdep class reset. */
+	BTRFS_ROOT_RESET_LOCKDEP_CLASS,
 };
 
 static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ea3ec1e761e8..ab944d1f94ef 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4867,6 +4867,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *buf;
+	u64 lockdep_owner = owner;
 
 	buf = btrfs_find_create_tree_block(fs_info, bytenr, owner, level);
 	if (IS_ERR(buf))
@@ -4885,12 +4886,27 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		return ERR_PTR(-EUCLEAN);
 	}
 
+	/*
+	 * The reloc trees are just snapshots, so we need them to appear to be
+	 * just like any other fs tree WRT lockdep.
+	 *
+	 * The exception however is in replace_path() in relocation, where we
+	 * hold the lock on the original fs root and then search for the reloc
+	 * root.  At that point we need to make sure any reloc root buffers are
+	 * set to the BTRFS_TREE_RELOC_OBJECTID lockdep class in order to make
+	 * lockdep happy.
+	 */
+	if (lockdep_owner == BTRFS_TREE_RELOC_OBJECTID &&
+	    !test_bit(BTRFS_ROOT_RESET_LOCKDEP_CLASS, &root->state))
+		lockdep_owner = BTRFS_FS_TREE_OBJECTID;
+
 	/*
 	 * This needs to stay, because we could allocate a freed block from an
 	 * old tree into a new tree, so we need to make sure this new block is
 	 * set to the appropriate level and owner.
 	 */
-	btrfs_set_buffer_lockdep_class(owner, buf, level);
+	btrfs_set_buffer_lockdep_class(lockdep_owner, buf, level);
+
 	__btrfs_tree_lock(buf, nest);
 	btrfs_clean_tree_block(buf);
 	clear_bit(EXTENT_BUFFER_STALE, &buf->bflags);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b290bd1b38b0..6e8e936a8a1e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6140,6 +6140,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	struct extent_buffer *exists = NULL;
 	struct page *p;
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
+	u64 lockdep_owner = owner_root;
 	int uptodate = 1;
 	int ret;
 
@@ -6164,7 +6165,15 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	eb = __alloc_extent_buffer(fs_info, start, len);
 	if (!eb)
 		return ERR_PTR(-ENOMEM);
-	btrfs_set_buffer_lockdep_class(owner_root, eb, level);
+
+	/*
+	 * The reloc trees are just snapshots, so we need them to appear to be
+	 * just like any other fs tree WRT lockdep.
+	 */
+	if (lockdep_owner == BTRFS_TREE_RELOC_OBJECTID)
+		lockdep_owner = BTRFS_FS_TREE_OBJECTID;
+
+	btrfs_set_buffer_lockdep_class(lockdep_owner, eb, level);
 
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++, index++) {
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index a4b671c5e678..b80f4e07f331 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -93,6 +93,14 @@ void btrfs_set_buffer_lockdep_class(u64 objectid, struct extent_buffer *eb,
 				   &ks->keys[level], ks->names[level]);
 }
 
+void btrfs_maybe_reset_lockdep_class(struct btrfs_root *root,
+				     struct extent_buffer *eb)
+{
+	if (unlikely(test_bit(BTRFS_ROOT_RESET_LOCKDEP_CLASS, &root->state)))
+		btrfs_set_buffer_lockdep_class(root->root_key.objectid,
+					       eb, btrfs_header_level(eb));
+}
+
 #endif
 
 /*
@@ -246,6 +254,9 @@ struct extent_buffer *btrfs_lock_root_node(struct btrfs_root *root)
 
 	while (1) {
 		eb = btrfs_root_node(root);
+
+		btrfs_maybe_reset_lockdep_class(root, eb);
+
 		btrfs_tree_lock(eb);
 		if (eb == root->node)
 			break;
@@ -267,6 +278,8 @@ struct extent_buffer *btrfs_read_lock_root_node(struct btrfs_root *root)
 
 	while (1) {
 		eb = btrfs_root_node(root);
+
+		btrfs_maybe_reset_lockdep_class(root, eb);
 		btrfs_tree_read_lock(eb);
 		if (eb == root->node)
 			break;
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 394264bdac3d..42f3f17baee3 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -134,11 +134,17 @@ void btrfs_drew_read_unlock(struct btrfs_drew_lock *lock);
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void btrfs_set_buffer_lockdep_class(u64 objectid,
 				    struct extent_buffer *eb, int level);
+void btrfs_maybe_reset_lockdep_class(struct btrfs_root *root,
+				     struct extent_buffer *eb);
 #else
 static inline void btrfs_set_buffer_lockdep_class(u64 objectid,
 					struct extent_buffer *eb, int level)
 {
 }
+static inline void btrfs_maybe_reset_lockdep_class(struct btrfs_root *root,
+						   struct extent_buffer *eb)
+{
+}
 #endif
 
 #endif
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index a6dc827e75af..6f8c3b23b673 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1326,7 +1326,9 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		btrfs_release_path(path);
 
 		path->lowest_level = level;
+		set_bit(BTRFS_ROOT_RESET_LOCKDEP_CLASS, &src->state);
 		ret = btrfs_search_slot(trans, src, &key, path, 0, 1);
+		clear_bit(BTRFS_ROOT_RESET_LOCKDEP_CLASS, &src->state);
 		path->lowest_level = 0;
 		if (ret) {
 			if (ret > 0)
-- 
2.26.3

