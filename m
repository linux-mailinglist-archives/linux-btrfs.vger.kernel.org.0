Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7AE51124B
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 09:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358726AbiD0HWo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 03:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358690AbiD0HWk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 03:22:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7638D60A99
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 00:19:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3053F1F380
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651043969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zk9LUL0BtO7yOXfiQ/FsKwqKHic3i/2uReJDIN+BNx8=;
        b=auS0fsPek5YHA+wmqrXypHFQKozl487llMWX8QarE5gEFV7zxHPJ6UtFLog1G3xD0+Hq0I
        KcY3gy8mnXmqiQkMhZQ1JYMlABO1Fh45Y6731LdStozph94XxrFP2EaIiqtCK4NuCrBM/m
        GG7h2X5tSnXOOP0fXFLF42XyZJz09Xw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74F7513A39
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yCs/DoDuaGIbJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC v2 11/12] btrfs: remove io_failure_record infrastructure completely
Date:   Wed, 27 Apr 2022 15:18:57 +0800
Message-Id: <b1a7ef8c8f039f2e38a7d149bfb7edf7ba9a444f.1651043618.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <cover.1651043617.git.wqu@suse.com>
References: <cover.1651043617.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since our read repair are always handled by btrfs_read_repair_ctrl,
which only has the lifespan inside endio function.

This means we no longer needs to record which range and its mirror
number for failure.

Now if we failed to read some data page, we have already tried every
mirrors we have, thus no need to record the failed range.

Thus this patch can remove the whole io_failure_record structure and its
related functions.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-io-tree.h |  14 ---
 fs/btrfs/extent_io.c      | 179 --------------------------------------
 fs/btrfs/extent_io.h      |  19 ----
 fs/btrfs/inode.c          |  19 +---
 4 files changed, 4 insertions(+), 227 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index c3eb52dbe61c..d46c064e5dad 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -250,18 +250,4 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 			       u64 *end, u64 max_bytes,
 			       struct extent_state **cached_state);
 
-/* This should be reworked in the future and put elsewhere. */
-struct io_failure_record *get_state_failrec(struct extent_io_tree *tree, u64 start);
-int set_state_failrec(struct extent_io_tree *tree, u64 start,
-		      struct io_failure_record *failrec);
-void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start,
-		u64 end);
-int free_io_failure(struct extent_io_tree *failure_tree,
-		    struct extent_io_tree *io_tree,
-		    struct io_failure_record *rec);
-int clean_io_failure(struct btrfs_fs_info *fs_info,
-		     struct extent_io_tree *failure_tree,
-		     struct extent_io_tree *io_tree, u64 start,
-		     struct page *page, u64 ino, unsigned int pg_offset);
-
 #endif /* BTRFS_EXTENT_IO_TREE_H */
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6f2faa77523d..92cd0c0851cd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2168,66 +2168,6 @@ u64 count_range_bits(struct extent_io_tree *tree,
 	return total_bytes;
 }
 
-/*
- * set the private field for a given byte offset in the tree.  If there isn't
- * an extent_state there already, this does nothing.
- */
-int set_state_failrec(struct extent_io_tree *tree, u64 start,
-		      struct io_failure_record *failrec)
-{
-	struct rb_node *node;
-	struct extent_state *state;
-	int ret = 0;
-
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
-}
-
-struct io_failure_record *get_state_failrec(struct extent_io_tree *tree, u64 start)
-{
-	struct rb_node *node;
-	struct extent_state *state;
-	struct io_failure_record *failrec;
-
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
-	return failrec;
-}
-
 /*
  * searches a range in the state tree for a given mask.
  * If 'filled' == 1, this returns 1 only if every extent in the tree
@@ -2284,30 +2224,6 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	return bitset;
 }
 
-int free_io_failure(struct extent_io_tree *failure_tree,
-		    struct extent_io_tree *io_tree,
-		    struct io_failure_record *rec)
-{
-	int ret;
-	int err = 0;
-
-	set_state_failrec(failure_tree, rec->start, NULL);
-	ret = clear_extent_bits(failure_tree, rec->start,
-				rec->start + rec->len - 1,
-				EXTENT_LOCKED | EXTENT_DIRTY);
-	if (ret)
-		err = ret;
-
-	ret = clear_extent_bits(io_tree, rec->start,
-				rec->start + rec->len - 1,
-				EXTENT_DAMAGED);
-	if (ret && !err)
-		err = ret;
-
-	kfree(rec);
-	return err;
-}
-
 /*
  * this bypasses the standard btrfs submit functions deliberately, as
  * the standard behavior is to write all copies in a raid setup. here we only
@@ -2422,93 +2338,6 @@ int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num)
 	return ret;
 }
 
-/*
- * each time an IO finishes, we do a fast check in the IO failure tree
- * to see if we need to process or clean up an io_failure_record
- */
-int clean_io_failure(struct btrfs_fs_info *fs_info,
-		     struct extent_io_tree *failure_tree,
-		     struct extent_io_tree *io_tree, u64 start,
-		     struct page *page, u64 ino, unsigned int pg_offset)
-{
-	u64 private;
-	struct io_failure_record *failrec;
-	struct extent_state *state;
-	int num_copies;
-	int ret;
-
-	private = 0;
-	ret = count_range_bits(failure_tree, &private, (u64)-1, 1,
-			       EXTENT_DIRTY, 0);
-	if (!ret)
-		return 0;
-
-	failrec = get_state_failrec(failure_tree, start);
-	if (IS_ERR(failrec))
-		return 0;
-
-	BUG_ON(!failrec->this_mirror);
-
-	if (sb_rdonly(fs_info->sb))
-		goto out;
-
-	spin_lock(&io_tree->lock);
-	state = find_first_extent_bit_state(io_tree,
-					    failrec->start,
-					    EXTENT_LOCKED);
-	spin_unlock(&io_tree->lock);
-
-	if (state && state->start <= failrec->start &&
-	    state->end >= failrec->start + failrec->len - 1) {
-		num_copies = btrfs_num_copies(fs_info, failrec->logical,
-					      failrec->len);
-		if (num_copies > 1)  {
-			repair_io_failure(fs_info, ino, start, failrec->len,
-					  failrec->logical, page, pg_offset,
-					  failrec->failed_mirror);
-		}
-	}
-
-out:
-	free_io_failure(failure_tree, io_tree, failrec);
-
-	return 0;
-}
-
-/*
- * Can be called when
- * - hold extent lock
- * - under ordered extent
- * - the inode is freeing
- */
-void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start, u64 end)
-{
-	struct extent_io_tree *failure_tree = &inode->io_failure_tree;
-	struct io_failure_record *failrec;
-	struct extent_state *state, *next;
-
-	if (RB_EMPTY_ROOT(&failure_tree->state))
-		return;
-
-	spin_lock(&failure_tree->lock);
-	state = find_first_extent_bit_state(failure_tree, start, EXTENT_DIRTY);
-	while (state) {
-		if (state->start > end)
-			break;
-
-		ASSERT(state->end <= end);
-
-		next = next_state(state);
-
-		failrec = state->failrec;
-		free_extent_state(state);
-		kfree(failrec);
-
-		state = next;
-	}
-	spin_unlock(&failure_tree->lock);
-}
-
 static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
@@ -3225,7 +3054,6 @@ static void end_bio_extent_readpage(struct bio *bio)
 	struct btrfs_read_repair_ctrl ctrl = { 0 };
 	struct bio_vec *bvec;
 	struct btrfs_bio *bbio = btrfs_bio(bio);
-	struct extent_io_tree *tree, *failure_tree;
 	struct processed_extent processed = { 0 };
 	/*
 	 * The offset to the beginning of a bio, since one bio can never be
@@ -3252,8 +3080,6 @@ static void end_bio_extent_readpage(struct bio *bio)
 			"end_bio_extent_readpage: bi_sector=%llu, err=%d, mirror=%u",
 			bio->bi_iter.bi_sector, bio->bi_status,
 			bbio->mirror_num);
-		tree = &BTRFS_I(inode)->io_tree;
-		failure_tree = &BTRFS_I(inode)->io_failure_tree;
 
 		/*
 		 * We always issue full-sector reads, but if some block in a
@@ -3288,11 +3114,6 @@ static void end_bio_extent_readpage(struct bio *bio)
 			}
 			if (ret)
 				uptodate = false;
-			else
-				clean_io_failure(BTRFS_I(inode)->root->fs_info,
-						 failure_tree, tree, start,
-						 page,
-						 btrfs_ino(BTRFS_I(inode)), 0);
 		}
 
 		if (likely(uptodate))
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 5e76df4a832b..77f4acd6ec30 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -70,7 +70,6 @@ struct btrfs_root;
 struct btrfs_inode;
 struct btrfs_io_bio;
 struct btrfs_fs_info;
-struct io_failure_record;
 struct extent_io_tree;
 
 typedef void (submit_bio_hook_t)(struct inode *inode, struct bio *bio,
@@ -335,24 +334,6 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
 void end_extent_writepage(struct page *page, int err, u64 start, u64 end);
 int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num);
 
-/*
- * When IO fails, either with EIO or csum verification fails, we
- * try other mirrors that might have a good copy of the data.  This
- * io_failure_record is used to record state as we go through all the
- * mirrors.  If another mirror has good data, the sector is set up to date
- * and things continue.  If a good mirror can't be found, the original
- * bio end_io callback is called to indicate things have failed.
- */
-struct io_failure_record {
-	struct page *page;
-	u64 start;
-	u64 len;
-	u64 logical;
-	unsigned long bio_flags;
-	int this_mirror;
-	int failed_mirror;
-};
-
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 bool find_lock_delalloc_range(struct inode *inode,
 			     struct page *locked_page, u64 *start,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b7cd11e403ab..99408618af1c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3115,8 +3115,6 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 					ordered_extent->disk_num_bytes);
 	}
 
-	btrfs_free_io_failure_record(inode, start, end);
-
 	if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags)) {
 		truncated = true;
 		logical_len = ordered_extent->truncated_len;
@@ -5335,8 +5333,6 @@ void btrfs_evict_inode(struct inode *inode)
 	if (is_bad_inode(inode))
 		goto no_delete;
 
-	btrfs_free_io_failure_record(BTRFS_I(inode), 0, (u64)-1);
-
 	if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
 		goto no_delete;
 
@@ -7816,8 +7812,6 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 	struct inode *inode = dip->inode;
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 	const u32 sectorsize = fs_info->sectorsize;
-	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
-	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 	struct btrfs_read_repair_ctrl ctrl = { 0 };
 	struct bio_vec bvec;
@@ -7835,15 +7829,10 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 			u64 start = bbio->file_offset + bio_offset;
 
 			ASSERT(pgoff < PAGE_SIZE);
-			if (uptodate &&
-			    (!csum || !check_data_csum(inode, bbio,
-						       bio_offset, bvec.bv_page,
-						       pgoff, start))) {
-				clean_io_failure(fs_info, failure_tree, io_tree,
-						 start, bvec.bv_page,
-						 btrfs_ino(BTRFS_I(inode)),
-						 pgoff);
-			} else {
+			/* Either we hit a read failure, or the csum mismatch */
+			if (!uptodate || (csum && check_data_csum(inode, bbio,
+							bio_offset, bvec.bv_page,
+							pgoff, start))) {
 				ret = btrfs_read_repair_add_sector(inode, &ctrl,
 						&bbio->bio, bio_offset, start,
 						true);
-- 
2.36.0

