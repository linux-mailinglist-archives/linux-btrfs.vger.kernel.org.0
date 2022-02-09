Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130484AEE50
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Feb 2022 10:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiBIJlp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Feb 2022 04:41:45 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239742AbiBIJeV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Feb 2022 04:34:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2ACE05BA5C
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 01:34:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 415631F39B
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 09:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644398616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PWbyCCJfGfxC+hRbO3t5C0hrqBaMhBiVAvYB9JANf+k=;
        b=S3z3Z8UVQijyv44zKRukIsY87fDs0rLYMFOWFYSGY6AeeR5ROht7AITqyqe7pvM8XuEDSt
        ziz3jAdYhQTaSzTEeKKsAaG+ZD2l3fmvzI5eArFSo/KXa+fdXw9KL5LDYmsPZiVhH1DELa
        EyRd4i2h1c5sMn6hgLk7SVSJr3KOF30=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9249F13522
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 09:23:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MG0eFxeIA2I7QAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Feb 2022 09:23:35 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 3/3] btrfs: make autodefrag to defrag small writes without rescanning the whole file
Date:   Wed,  9 Feb 2022 17:23:14 +0800
Message-Id: <fc9f897e0859cccf90c33a7a609dc0a2e96ce3c1.1644398069.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <cover.1644398069.git.wqu@suse.com>
References: <cover.1644398069.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Previously autodefrag works by scanning the whole file with a minimal
generation threshold.

Although we have various optimization to skip ranges which don't meet
the generation requirement, it can still waste some time on scanning the
whole file, especially if the inode got an almost full overwrite.

To optimize the autodefrag even further, here we use
inode_defrag::targets extent io tree to do accurate defrag targets
search.

Now we re-use EXTENT_DIRTY flag to mark the small writes, and only
defrag those ranges.

This rework brings the following behavior change:

- Only small write ranges will be defragged
  Previously if there are new writes after the small writes, but it's
  not reaching the extent size threshold, it will be defragged.

  This is because we have a gap between autodefrag extent size threshold
  and inode_should_defrag() extent size threshold.
  (uncompressed 64K / compressed 16K vs 256K)

  Now we won't need to bother the gap, and can only defrag the small
  writes.

- Enlarged critical section for fs_info::defrag_inodes_lock
  The critical section will include extent io tree update, thus
  it will be larger, and fs_info::defrag_inodes_lock will be upgraded
  to mutex to handle the possible sleep.

  This would slightly increase the overhead for autodefrag, but I don't
  have a benchmark for it.

- Extra memory usage for autodefrag
  Now we need to keep an extent io tree for each target inode.

- No inode re-queue if there are large sectors to defrag
  Previously if we have defragged 1024 sectors, we will re-queue the
  inode, and mostly pick another inode to defrag in next run.

  Now we will defrag the inode until we finished it.
  The context switch will be triggered by the cond_resche() in
  btrfs_defrag_file() thus it won't hold CPU for too long.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h   |   4 +-
 fs/btrfs/disk-io.c |   2 +-
 fs/btrfs/file.c    | 209 ++++++++++++++++++++++++---------------------
 fs/btrfs/inode.c   |   2 +-
 4 files changed, 116 insertions(+), 101 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a5cf845cbe88..9228e8d39516 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -897,7 +897,7 @@ struct btrfs_fs_info {
 	struct btrfs_free_cluster meta_alloc_cluster;
 
 	/* auto defrag inodes go here */
-	spinlock_t defrag_inodes_lock;
+	struct mutex defrag_inodes_lock;
 	struct rb_root defrag_inodes;
 	atomic_t defrag_running;
 
@@ -3356,7 +3356,7 @@ void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
 /* file.c */
 int __init btrfs_auto_defrag_init(void);
 void __cold btrfs_auto_defrag_exit(void);
-int btrfs_add_inode_defrag(struct btrfs_inode *inode);
+int btrfs_add_inode_defrag(struct btrfs_inode *inode, u64 start, u64 len);
 int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info);
 void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info);
 int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b6a81c39d5f4..87782d1120e7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3126,7 +3126,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	spin_lock_init(&fs_info->trans_lock);
 	spin_lock_init(&fs_info->fs_roots_radix_lock);
 	spin_lock_init(&fs_info->delayed_iput_lock);
-	spin_lock_init(&fs_info->defrag_inodes_lock);
 	spin_lock_init(&fs_info->super_lock);
 	spin_lock_init(&fs_info->buffer_lock);
 	spin_lock_init(&fs_info->unused_bgs_lock);
@@ -3140,6 +3139,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	mutex_init(&fs_info->reloc_mutex);
 	mutex_init(&fs_info->delalloc_root_mutex);
 	mutex_init(&fs_info->zoned_meta_io_lock);
+	mutex_init(&fs_info->defrag_inodes_lock);
 	seqlock_init(&fs_info->profiles_lock);
 
 	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 2d49336b0321..da6e29a6f387 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -34,7 +34,7 @@
 static struct kmem_cache *btrfs_inode_defrag_cachep;
 
 /* Reuse DIRTY flag for autodefrag */
-#define EXTENT_FLAG_AUTODEFRAG	EXTENT_FLAG_DIRTY
+#define EXTENT_FLAG_AUTODEFRAG	EXTENT_DIRTY
 
 /*
  * when auto defrag is enabled we
@@ -119,7 +119,6 @@ static int __btrfs_add_inode_defrag(struct btrfs_inode *inode,
 			return -EEXIST;
 		}
 	}
-	set_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags);
 	rb_link_node(&defrag->rb_node, parent, p);
 	rb_insert_color(&defrag->rb_node, &fs_info->defrag_inodes);
 	return 0;
@@ -136,81 +135,80 @@ static inline int __need_auto_defrag(struct btrfs_fs_info *fs_info)
 	return 1;
 }
 
+static struct inode_defrag *find_inode_defrag(struct btrfs_fs_info *fs_info,
+					      u64 root, u64 ino)
+{
+
+	struct inode_defrag *entry = NULL;
+	struct inode_defrag tmp;
+	struct rb_node *p;
+	struct rb_node *parent = NULL;
+	int ret;
+
+	tmp.ino = ino;
+	tmp.root = root;
+
+	p = fs_info->defrag_inodes.rb_node;
+	while (p) {
+		parent = p;
+		entry = rb_entry(parent, struct inode_defrag, rb_node);
+
+		ret = __compare_inode_defrag(&tmp, entry);
+		if (ret < 0)
+			p = parent->rb_left;
+		else if (ret > 0)
+			p = parent->rb_right;
+		else
+			return entry;
+	}
+	return NULL;
+}
+
 /*
  * insert a defrag record for this inode if auto defrag is
  * enabled
  */
-int btrfs_add_inode_defrag(struct btrfs_inode *inode)
+int btrfs_add_inode_defrag(struct btrfs_inode *inode, u64 start, u64 len)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct inode_defrag *defrag;
+	struct inode_defrag *prealloc;
+	struct inode_defrag *found;
+	bool release = true;
 	int ret;
 
 	if (!__need_auto_defrag(fs_info))
 		return 0;
 
-	if (test_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags))
-		return 0;
-
-	defrag = kmem_cache_zalloc(btrfs_inode_defrag_cachep, GFP_NOFS);
-	if (!defrag)
+	prealloc = kmem_cache_zalloc(btrfs_inode_defrag_cachep, GFP_NOFS);
+	if (!prealloc)
 		return -ENOMEM;
 
-	defrag->ino = btrfs_ino(inode);
-	defrag->transid = inode->root->last_trans;
-	defrag->root = root->root_key.objectid;
-	extent_io_tree_init(fs_info, &defrag->targets, IO_TREE_AUTODEFRAG, NULL);
-
-	spin_lock(&fs_info->defrag_inodes_lock);
-	if (!test_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags)) {
-		/*
-		 * If we set IN_DEFRAG flag and evict the inode from memory,
-		 * and then re-read this inode, this new inode doesn't have
-		 * IN_DEFRAG flag. At the case, we may find the existed defrag.
-		 */
-		ret = __btrfs_add_inode_defrag(inode, defrag);
-		if (ret) {
-			extent_io_tree_release(&defrag->targets);
-			kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
-		}
-	} else {
-		extent_io_tree_release(&defrag->targets);
-		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
+	set_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags);
+	prealloc->ino = btrfs_ino(inode);
+	prealloc->transid = inode->root->last_trans;
+	prealloc->root = root->root_key.objectid;
+	extent_io_tree_init(fs_info, &prealloc->targets, IO_TREE_AUTODEFRAG, NULL);
+
+	mutex_lock(&fs_info->defrag_inodes_lock);
+	found = find_inode_defrag(fs_info, prealloc->root, prealloc->ino);
+	if (!found) {
+		ret = __btrfs_add_inode_defrag(inode, prealloc);
+		/* Since we didn't find one previously, the insert must success */
+		ASSERT(!ret);
+		found = prealloc;
+		release = false;
+	}
+	set_extent_bits(&found->targets, start, start + len - 1,
+			EXTENT_FLAG_AUTODEFRAG);
+	mutex_unlock(&fs_info->defrag_inodes_lock);
+	if (release) {
+		extent_io_tree_release(&prealloc->targets);
+		kmem_cache_free(btrfs_inode_defrag_cachep, prealloc);
 	}
-	spin_unlock(&fs_info->defrag_inodes_lock);
 	return 0;
 }
 
-/*
- * Requeue the defrag object. If there is a defrag object that points to
- * the same inode in the tree, we will merge them together (by
- * __btrfs_add_inode_defrag()) and free the one that we want to requeue.
- */
-static void btrfs_requeue_inode_defrag(struct btrfs_inode *inode,
-				       struct inode_defrag *defrag)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	int ret;
-
-	if (!__need_auto_defrag(fs_info))
-		goto out;
-
-	/*
-	 * Here we don't check the IN_DEFRAG flag, because we need merge
-	 * them together.
-	 */
-	spin_lock(&fs_info->defrag_inodes_lock);
-	ret = __btrfs_add_inode_defrag(inode, defrag);
-	spin_unlock(&fs_info->defrag_inodes_lock);
-	if (ret)
-		goto out;
-	return;
-out:
-	extent_io_tree_release(&defrag->targets);
-	kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
-}
-
 /*
  * pick the defragable inode that we want, if it doesn't exist, we will get
  * the next one.
@@ -227,7 +225,7 @@ btrfs_pick_defrag_inode(struct btrfs_fs_info *fs_info, u64 root, u64 ino)
 	tmp.ino = ino;
 	tmp.root = root;
 
-	spin_lock(&fs_info->defrag_inodes_lock);
+	mutex_lock(&fs_info->defrag_inodes_lock);
 	p = fs_info->defrag_inodes.rb_node;
 	while (p) {
 		parent = p;
@@ -252,7 +250,7 @@ btrfs_pick_defrag_inode(struct btrfs_fs_info *fs_info, u64 root, u64 ino)
 out:
 	if (entry)
 		rb_erase(parent, &fs_info->defrag_inodes);
-	spin_unlock(&fs_info->defrag_inodes_lock);
+	mutex_unlock(&fs_info->defrag_inodes_lock);
 	return entry;
 }
 
@@ -261,7 +259,7 @@ void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info)
 	struct inode_defrag *defrag;
 	struct rb_node *node;
 
-	spin_lock(&fs_info->defrag_inodes_lock);
+	mutex_lock(&fs_info->defrag_inodes_lock);
 	node = rb_first(&fs_info->defrag_inodes);
 	while (node) {
 		rb_erase(node, &fs_info->defrag_inodes);
@@ -269,21 +267,59 @@ void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info)
 		extent_io_tree_release(&defrag->targets);
 		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
 
-		cond_resched_lock(&fs_info->defrag_inodes_lock);
-
 		node = rb_first(&fs_info->defrag_inodes);
 	}
-	spin_unlock(&fs_info->defrag_inodes_lock);
+	mutex_unlock(&fs_info->defrag_inodes_lock);
 }
 
 #define BTRFS_DEFRAG_BATCH	1024
+static int defrag_one_range(struct btrfs_inode *inode, u64 start, u64 len,
+			    u64 newer_than)
+{
+	const struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	u64 cur = start;
+	int ret = 0;
+
+	while (cur < start + len) {
+		struct btrfs_defrag_ctrl ctrl = { 0 };
+
+		ctrl.start = cur;
+		ctrl.len = start + len - cur;
+		ctrl.newer_than = newer_than;
+		ctrl.extent_thresh = SZ_256K;
+		ctrl.max_sectors_to_defrag = BTRFS_DEFRAG_BATCH;
+
+		sb_start_write(fs_info->sb);
+		ret = btrfs_defrag_file(&inode->vfs_inode, NULL, &ctrl);
+		sb_end_write(fs_info->sb);
+
+		/* The range is beyond isize, we can safely exit */
+		if (ret == -EINVAL) {
+			ret = 0;
+			break;
+		}
+		if (ret < 0)
+			break;
+
+		/*
+		 * Even we didn't defrag anything, the last_scanned should have
+		 * been increased.
+		 */
+		ASSERT(ctrl.last_scanned > cur);
+		cur = ctrl.last_scanned;
+	}
+	return ret;
+}
 
 static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 				    struct inode_defrag *defrag)
 {
 	struct btrfs_root *inode_root;
 	struct inode *inode;
-	struct btrfs_defrag_ctrl ctrl = {};
+	struct extent_state *cached = NULL;
+	u64 cur = 0;
+	u64 found_start;
+	u64 found_end;
 	int ret;
 
 	/* get the inode */
@@ -300,40 +336,19 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 		goto cleanup;
 	}
 
-	/* do a chunk of defrag */
-	clear_bit(BTRFS_INODE_IN_DEFRAG, &BTRFS_I(inode)->runtime_flags);
-	ctrl.len = (u64)-1;
-	ctrl.start = defrag->last_offset;
-	ctrl.newer_than = defrag->transid;
-	ctrl.max_sectors_to_defrag = BTRFS_DEFRAG_BATCH;
-
-	sb_start_write(fs_info->sb);
-	ret = btrfs_defrag_file(inode, NULL, &ctrl);
-	sb_end_write(fs_info->sb);
-	/*
-	 * if we filled the whole defrag batch, there
-	 * must be more work to do.  Queue this defrag
-	 * again
-	 */
-	if (ctrl.sectors_defragged == BTRFS_DEFRAG_BATCH) {
-		defrag->last_offset = ctrl.last_scanned;
-		btrfs_requeue_inode_defrag(BTRFS_I(inode), defrag);
-	} else if (defrag->last_offset && !defrag->cycled) {
-		/*
-		 * we didn't fill our defrag batch, but
-		 * we didn't start at zero.  Make sure we loop
-		 * around to the start of the file.
-		 */
-		defrag->last_offset = 0;
-		defrag->cycled = 1;
-		btrfs_requeue_inode_defrag(BTRFS_I(inode), defrag);
-	} else {
-		extent_io_tree_release(&defrag->targets);
-		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
+	while (!find_first_extent_bit(&defrag->targets,
+				cur, &found_start, &found_end,
+				EXTENT_FLAG_AUTODEFRAG, &cached)) {
+		clear_extent_bit(&defrag->targets, found_start,
+				 found_end, EXTENT_FLAG_AUTODEFRAG, 0, 0, &cached);
+		ret = defrag_one_range(BTRFS_I(inode), found_start,
+				found_end + 1 - found_start, defrag->transid);
+		if (ret < 0)
+			break;
+		cur = found_end + 1;
 	}
 
 	iput(inode);
-	return 0;
 cleanup:
 	extent_io_tree_release(&defrag->targets);
 	kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2049f3ea992d..622e017500bc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -570,7 +570,7 @@ static inline void inode_should_defrag(struct btrfs_inode *inode,
 	/* If this is a small write inside eof, kick off a defrag */
 	if (num_bytes < small_write &&
 	    (start > 0 || end + 1 < inode->disk_i_size))
-		btrfs_add_inode_defrag(inode);
+		btrfs_add_inode_defrag(inode, start, num_bytes);
 }
 
 /*
-- 
2.35.0

