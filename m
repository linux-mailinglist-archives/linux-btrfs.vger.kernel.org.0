Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493ED5AB954
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiIBURD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiIBUQ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:16:56 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F947EF9C4
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:16:45 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id j1so2259764qvv.8
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=Qj9XNd/lL0rhcPZvexHUZiZr8vyjsyftMtSceQl3r6o=;
        b=hzKViVxNnnYh1laCeXS8rwi9GklzVl7VU9EU27zcpZYofuW8Fa04XVsAvHzo2Ie/ul
         x8a+dKAVdETbDTg2F7+1CwrLmZItwsxudBukUfQw/uIQELV9q/eE2ZpyUB2vqtLl/wFz
         BD/zR6K8lu0wrVd036ZoKkw5TiViSkpLlzRJk5lpYb23JtEFfOYt3KHTrtiGFFjCLWvo
         vO+c2/Ra19GYRrCKc2olTo0iwgn7Fqg9rEE0OY5I+t77cjw70NTGDXSYtzgnTVnpgUbL
         rL69F/q1eN7//9EYQ0pDNBE4FExi6+127OK5qDDWe2F4mGfhZyxsmAJSpkGyeEknBsQI
         /m+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Qj9XNd/lL0rhcPZvexHUZiZr8vyjsyftMtSceQl3r6o=;
        b=YvKNmmUnpI/iQlhEfe9EkxdmMDEjdgbsyzKLzOxLVKpMJgEJzVdnJ3gqPkzJeJFwZy
         PB14y5IevcQAxhdc3+HJS1SamGbrsymnWFc4+USnkvTjno91h7CDQjjtsUa6dqkFngAP
         Vg1F/MDfPbcd7jNjCAjLOn4HjcfkEJ/kEBellXdAtH+9vRCBvxpqKvq0fBVtdrGWuyAK
         CGf+vHwENg5Cw2yN2puPVErefgKJfb45duINWYpeVXT77Rm066uektvnh1hFnEhudnyz
         ZQmnvCyext4uXKLu9vfqwGHuaQlAVB925uJSQO/hbmRdLWkzbU9zzHcT9rod3LYz7jVX
         ZlyQ==
X-Gm-Message-State: ACgBeo34n2vXPaVsEn//oFawmUwb557CKAefMeM3U5X3UpKP9LXsHh4b
        DmrpDaEkEDx3eUzQL/BpCpGtxEkgaF4IPw==
X-Google-Smtp-Source: AA6agR5VwSpJ2ETrFYamC1FEqfTLNvjqutGqs0CvBYz8/6GoW4a3Sl5q24Inn+4fZcL6XmYzHRQnug==
X-Received: by 2002:a0c:916c:0:b0:499:22d5:be5d with SMTP id q99-20020a0c916c000000b0049922d5be5dmr11768307qvq.55.1662149804136;
        Fri, 02 Sep 2022 13:16:44 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a0b5400b006b929a56a2bsm2019057qkg.3.2022.09.02.13.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:16:43 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/31] btrfs: stop using extent_io_tree for io_failure_record's
Date:   Fri,  2 Sep 2022 16:16:08 -0400
Message-Id: <3470bcd6166aaeda443174064d0e172953513fcd.1662149276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662149276.git.josef@toxicpanda.com>
References: <cover.1662149276.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We still have this oddity of stashing the io_failure_record in the
extent state for the io_failure_tree, which is leftover from when we
used to stuff private pointers in extent_io_trees.

However this doesn't make a lot of sense for the io failure records, we
can simply use a normal rb_tree for this.  This will allow us to further
simplify the extent_io_tree code by removing the io_failure_rec pointer
from the extent state.

Convert the io_failure_tree to an rb tree + spinlock in the inode, and
then use our rb tree simple helpers to insert and find failed records.
This greatly cleans up this code and makes it easier to separate out the
extent_io_tree code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/btrfs_inode.h       |   3 +-
 fs/btrfs/extent-io-tree.h    |   3 -
 fs/btrfs/extent_io.c         | 164 +++++++++++------------------------
 fs/btrfs/extent_io.h         |   5 +-
 fs/btrfs/inode.c             |   5 +-
 fs/btrfs/misc.h              |  35 ++++++++
 include/trace/events/btrfs.h |   1 -
 7 files changed, 96 insertions(+), 120 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index b160b8e124e0..108af52ba870 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -94,7 +94,8 @@ struct btrfs_inode {
 	/* special utility tree used to record which mirrors have already been
 	 * tried when checksums fail for a given block
 	 */
-	struct extent_io_tree io_failure_tree;
+	struct rb_root io_failure_tree;
+	spinlock_t io_failure_lock;
 
 	/*
 	 * Keep track of where the inode has extent items mapped in order to
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 5584968643eb..ee2ba4b6e4a1 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -56,7 +56,6 @@ enum {
 	IO_TREE_FS_EXCLUDED_EXTENTS,
 	IO_TREE_BTREE_INODE_IO,
 	IO_TREE_INODE_IO,
-	IO_TREE_INODE_IO_FAILURE,
 	IO_TREE_RELOC_BLOCKS,
 	IO_TREE_TRANS_DIRTY_PAGES,
 	IO_TREE_ROOT_DIRTY_LOG_PAGES,
@@ -89,8 +88,6 @@ struct extent_state {
 	refcount_t refs;
 	u32 state;
 
-	struct io_failure_record *failrec;
-
 #ifdef CONFIG_BTRFS_DEBUG
 	struct list_head leak_list;
 #endif
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index be14c15cfafa..c15a6433d43c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -326,7 +326,6 @@ static struct extent_state *alloc_extent_state(gfp_t mask)
 	if (!state)
 		return state;
 	state->state = 0;
-	state->failrec = NULL;
 	RB_CLEAR_NODE(&state->rb_node);
 	btrfs_leak_debug_add(&leak_lock, &state->leak_list, &states);
 	refcount_set(&state->refs, 1);
@@ -2159,64 +2158,30 @@ u64 count_range_bits(struct extent_io_tree *tree,
 	return total_bytes;
 }
 
-/*
- * set the private field for a given byte offset in the tree.  If there isn't
- * an extent_state there already, this does nothing.
- */
-static int set_state_failrec(struct extent_io_tree *tree, u64 start,
-			     struct io_failure_record *failrec)
+static int insert_failrec(struct btrfs_inode *inode,
+			  struct io_failure_record *failrec)
 {
-	struct rb_node *node;
-	struct extent_state *state;
-	int ret = 0;
+	struct rb_node *exist;
 
-	spin_lock(&tree->lock);
-	/*
-	 * this search will find all the extents that end after
-	 * our range starts.
-	 */
-	node = tree_search(tree, start);
-	if (!node) {
-		ret = -ENOENT;
-		goto out;
-	}
-	state = rb_entry(node, struct extent_state, rb_node);
-	if (state->start != start) {
-		ret = -ENOENT;
-		goto out;
-	}
-	state->failrec = failrec;
-out:
-	spin_unlock(&tree->lock);
-	return ret;
+	spin_lock(&inode->io_failure_lock);
+	exist = rb_simple_insert(&inode->io_failure_tree, failrec->bytenr,
+				 &failrec->rb_node);
+	spin_unlock(&inode->io_failure_lock);
+
+	return (exist == NULL) ? 0 : -EEXIST;
 }
 
-static struct io_failure_record *get_state_failrec(struct extent_io_tree *tree,
-						   u64 start)
+static struct io_failure_record *get_failrec(struct btrfs_inode *inode,
+					     u64 start)
 {
 	struct rb_node *node;
-	struct extent_state *state;
-	struct io_failure_record *failrec;
+	struct io_failure_record *failrec = ERR_PTR(-ENOENT);
 
-	spin_lock(&tree->lock);
-	/*
-	 * this search will find all the extents that end after
-	 * our range starts.
-	 */
-	node = tree_search(tree, start);
-	if (!node) {
-		failrec = ERR_PTR(-ENOENT);
-		goto out;
-	}
-	state = rb_entry(node, struct extent_state, rb_node);
-	if (state->start != start) {
-		failrec = ERR_PTR(-ENOENT);
-		goto out;
-	}
-
-	failrec = state->failrec;
-out:
-	spin_unlock(&tree->lock);
+	spin_lock(&inode->io_failure_lock);
+	node = rb_simple_search(&inode->io_failure_tree, start);
+	if (node)
+		failrec = rb_entry(node, struct io_failure_record, rb_node);
+	spin_unlock(&inode->io_failure_lock);
 	return failrec;
 }
 
@@ -2276,28 +2241,20 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	return bitset;
 }
 
-static int free_io_failure(struct extent_io_tree *failure_tree,
-			   struct extent_io_tree *io_tree,
+static int free_io_failure(struct btrfs_inode *inode,
 			   struct io_failure_record *rec)
 {
 	int ret;
-	int err = 0;
 
-	set_state_failrec(failure_tree, rec->start, NULL);
-	ret = clear_extent_bits(failure_tree, rec->start,
-				rec->start + rec->len - 1,
-				EXTENT_LOCKED | EXTENT_DIRTY);
-	if (ret)
-		err = ret;
+	spin_lock(&inode->io_failure_lock);
+	rb_erase(&rec->rb_node, &inode->io_failure_tree);
+	spin_unlock(&inode->io_failure_lock);
 
-	ret = clear_extent_bits(io_tree, rec->start,
-				rec->start + rec->len - 1,
+	ret = clear_extent_bits(&inode->io_tree, rec->bytenr,
+				rec->bytenr + rec->len - 1,
 				EXTENT_DAMAGED);
-	if (ret && !err)
-		err = ret;
-
 	kfree(rec);
-	return err;
+	return ret;
 }
 
 /*
@@ -2436,22 +2393,13 @@ int btrfs_clean_io_failure(struct btrfs_inode *inode, u64 start,
 			   struct page *page, unsigned int pg_offset)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct extent_io_tree *failure_tree = &inode->io_failure_tree;
 	struct extent_io_tree *io_tree = &inode->io_tree;
 	u64 ino = btrfs_ino(inode);
-	u64 private;
 	struct io_failure_record *failrec;
 	struct extent_state *state;
 	int mirror;
-	int ret;
-
-	private = 0;
-	ret = count_range_bits(failure_tree, &private, (u64)-1, 1,
-			       EXTENT_DIRTY, 0);
-	if (!ret)
-		return 0;
 
-	failrec = get_state_failrec(failure_tree, start);
+	failrec = get_failrec(inode, start);
 	if (IS_ERR(failrec))
 		return 0;
 
@@ -2462,12 +2410,12 @@ int btrfs_clean_io_failure(struct btrfs_inode *inode, u64 start,
 
 	spin_lock(&io_tree->lock);
 	state = find_first_extent_bit_state(io_tree,
-					    failrec->start,
+					    failrec->bytenr,
 					    EXTENT_LOCKED);
 	spin_unlock(&io_tree->lock);
 
-	if (!state || state->start > failrec->start ||
-	    state->end < failrec->start + failrec->len - 1)
+	if (!state || state->start > failrec->bytenr ||
+	    state->end < failrec->bytenr + failrec->len - 1)
 		goto out;
 
 	mirror = failrec->this_mirror;
@@ -2478,7 +2426,7 @@ int btrfs_clean_io_failure(struct btrfs_inode *inode, u64 start,
 	} while (mirror != failrec->failed_mirror);
 
 out:
-	free_io_failure(failure_tree, io_tree, failrec);
+	free_io_failure(inode, failrec);
 	return 0;
 }
 
@@ -2490,30 +2438,26 @@ int btrfs_clean_io_failure(struct btrfs_inode *inode, u64 start,
  */
 void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start, u64 end)
 {
-	struct extent_io_tree *failure_tree = &inode->io_failure_tree;
 	struct io_failure_record *failrec;
-	struct extent_state *state, *next;
+	struct rb_node *n, *next;
 
-	if (RB_EMPTY_ROOT(&failure_tree->state))
+	if (RB_EMPTY_ROOT(&inode->io_failure_tree))
 		return;
 
-	spin_lock(&failure_tree->lock);
-	state = find_first_extent_bit_state(failure_tree, start, EXTENT_DIRTY);
-	while (state) {
-		if (state->start > end)
+	spin_lock(&inode->io_failure_lock);
+	n = rb_simple_search_first(&inode->io_failure_tree, start);
+	while (n) {
+		failrec = rb_entry(n, struct io_failure_record, rb_node);
+		if (failrec->bytenr > end)
 			break;
 
-		ASSERT(state->end <= end);
-
-		next = next_state(state);
-
-		failrec = state->failrec;
-		free_extent_state(state);
+		next = rb_next(n);
+		rb_erase(&failrec->rb_node, &inode->io_failure_tree);
 		kfree(failrec);
 
-		state = next;
+		n = next;
 	}
-	spin_unlock(&failure_tree->lock);
+	spin_unlock(&inode->io_failure_lock);
 }
 
 static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode,
@@ -2523,16 +2467,15 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u64 start = bbio->file_offset + bio_offset;
 	struct io_failure_record *failrec;
-	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	const u32 sectorsize = fs_info->sectorsize;
 	int ret;
 
-	failrec = get_state_failrec(failure_tree, start);
+	failrec = get_failrec(BTRFS_I(inode), start);
 	if (!IS_ERR(failrec)) {
 		btrfs_debug(fs_info,
 	"Get IO Failure Record: (found) logical=%llu, start=%llu, len=%llu",
-			failrec->logical, failrec->start, failrec->len);
+			failrec->logical, failrec->bytenr, failrec->len);
 		/*
 		 * when data can be on disk more than twice, add to failrec here
 		 * (e.g. with a list for failed_mirror) to make
@@ -2547,7 +2490,8 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	if (!failrec)
 		return ERR_PTR(-ENOMEM);
 
-	failrec->start = start;
+	RB_CLEAR_NODE(&failrec->rb_node);
+	failrec->bytenr = start;
 	failrec->len = sectorsize;
 	failrec->failed_mirror = bbio->mirror_num;
 	failrec->this_mirror = bbio->mirror_num;
@@ -2572,17 +2516,17 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	}
 
 	/* Set the bits in the private failure tree */
-	ret = set_extent_bits(failure_tree, start, start + sectorsize - 1,
-			      EXTENT_LOCKED | EXTENT_DIRTY);
-	if (ret >= 0) {
-		ret = set_state_failrec(failure_tree, start, failrec);
-		/* Set the bits in the inode's tree */
-		ret = set_extent_bits(tree, start, start + sectorsize - 1,
-				      EXTENT_DAMAGED);
-	} else if (ret < 0) {
+	ret = insert_failrec(BTRFS_I(inode), failrec);
+	if (ret) {
 		kfree(failrec);
 		return ERR_PTR(ret);
 	}
+	ret = set_extent_bits(tree, start, start + sectorsize - 1,
+			      EXTENT_DAMAGED);
+	if (ret) {
+		free_io_failure(BTRFS_I(inode), failrec);
+		return ERR_PTR(ret);
+	}
 
 	return failrec;
 }
@@ -2594,8 +2538,6 @@ int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
 	u64 start = failed_bbio->file_offset + bio_offset;
 	struct io_failure_record *failrec;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
-	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
 	struct bio *failed_bio = &failed_bbio->bio;
 	const int icsum = bio_offset >> fs_info->sectorsize_bits;
 	struct bio *repair_bio;
@@ -2624,7 +2566,7 @@ int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
 		btrfs_debug(fs_info,
 			"failed to repair num_copies %d this_mirror %d failed_mirror %d",
 			failrec->num_copies, failrec->this_mirror, failrec->failed_mirror);
-		free_io_failure(failure_tree, tree, failrec);
+		free_io_failure(BTRFS_I(inode), failrec);
 		return -EIO;
 	}
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 69a86ae6fd50..879f8a60cd6f 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -254,8 +254,11 @@ int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num);
  * bio end_io callback is called to indicate things have failed.
  */
 struct io_failure_record {
+	struct {
+		struct rb_node rb_node;
+		u64 bytenr;
+	}; /* Use rb_simple_node for search/insert */
 	struct page *page;
-	u64 start;
 	u64 len;
 	u64 logical;
 	int this_mirror;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a1b9e2a455d9..7bdf89756be4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8899,6 +8899,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	ei->last_log_commit = 0;
 
 	spin_lock_init(&ei->lock);
+	spin_lock_init(&ei->io_failure_lock);
 	ei->outstanding_extents = 0;
 	if (sb->s_magic != BTRFS_TEST_MAGIC)
 		btrfs_init_metadata_block_rsv(fs_info, &ei->block_rsv,
@@ -8915,12 +8916,10 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	inode = &ei->vfs_inode;
 	extent_map_tree_init(&ei->extent_tree);
 	extent_io_tree_init(fs_info, &ei->io_tree, IO_TREE_INODE_IO, inode);
-	extent_io_tree_init(fs_info, &ei->io_failure_tree,
-			    IO_TREE_INODE_IO_FAILURE, inode);
 	extent_io_tree_init(fs_info, &ei->file_extent_tree,
 			    IO_TREE_INODE_FILE_EXTENT, inode);
+	ei->io_failure_tree = RB_ROOT;
 	ei->io_tree.track_uptodate = true;
-	ei->io_failure_tree.track_uptodate = true;
 	atomic_set(&ei->sync_writers, 0);
 	mutex_init(&ei->log_mutex);
 	btrfs_ordered_inode_tree_init(&ei->ordered_tree);
diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 340f995652f2..4ffd603d19cb 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -88,6 +88,41 @@ static inline struct rb_node *rb_simple_search(struct rb_root *root, u64 bytenr)
 	return NULL;
 }
 
+/**
+ * Search @root from an entry that starts or comes after @bytenr.
+ *
+ * @root:	the root to search.
+ * @bytenr:	bytenr to search from.
+ *
+ * Return the rb_node that start at or after @bytenr.  If there is no entry at
+ * or after @bytner return NULL.
+ */
+static inline struct rb_node *rb_simple_search_first(struct rb_root *root,
+						     u64 bytenr)
+{
+	struct rb_node *node = root->rb_node, *ret = NULL;
+	struct rb_simple_node *entry, *ret_entry = NULL;
+
+	while (node) {
+		entry = rb_entry(node, struct rb_simple_node, rb_node);
+
+		if (bytenr < entry->bytenr) {
+			if (!ret || entry->bytenr < ret_entry->bytenr) {
+				ret = node;
+				ret_entry = entry;
+			}
+
+			node = node->rb_left;
+		} else if (bytenr > entry->bytenr) {
+			node = node->rb_right;
+		} else {
+			return node;
+		}
+	}
+
+	return ret;
+}
+
 static inline struct rb_node *rb_simple_insert(struct rb_root *root, u64 bytenr,
 					       struct rb_node *node)
 {
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 73df80d462dc..4db905311d67 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -84,7 +84,6 @@ struct raid56_bio_trace_info;
 	EM( IO_TREE_FS_EXCLUDED_EXTENTS,  "EXCLUDED_EXTENTS")	    \
 	EM( IO_TREE_BTREE_INODE_IO,	  "BTREE_INODE_IO")	    \
 	EM( IO_TREE_INODE_IO,		  "INODE_IO")		    \
-	EM( IO_TREE_INODE_IO_FAILURE,	  "INODE_IO_FAILURE")	    \
 	EM( IO_TREE_RELOC_BLOCKS,	  "RELOC_BLOCKS")	    \
 	EM( IO_TREE_TRANS_DIRTY_PAGES,	  "TRANS_DIRTY_PAGES")      \
 	EM( IO_TREE_ROOT_DIRTY_LOG_PAGES, "ROOT_DIRTY_LOG_PAGES")   \
-- 
2.26.3

