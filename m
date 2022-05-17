Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0B352A551
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 16:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349377AbiEQOvz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 10:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349330AbiEQOvi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 10:51:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A4318E20
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 07:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=iNzB+Lw2bX5LGINzTAHcj9qKV3+1tRpD+UkBFDe1nLY=; b=PZuA1t5eX8BOy7MQGsQGmOC9Rm
        /taXYxGUGw/8K/x1q3MhaG8QIdIVLtJo6O/JmqYLh23Sb6usPuo2DnWFUSBo85v6WFiUUCFuvp46K
        DNJvKz/lUbPyV3ij9toL8EbMdZS0WxWOzRppoNvoRGg/uXdjmF22Dg338QzX78LwNof5O1viUyVNu
        qyseKYRumdNBavZC4qhQ5t9+zPBEFHKGC/qAt9UUnMYJAA6mjj8lSQD3KsJ/1E2JLO6sqXfsQWIsj
        /u9Mh6dvIu6cDl6+GXENl0DFFuy4HmuFIF4qoORhzUWl1+OugSSbq3iH/+jlOOas1e3NK3r4weJ61
        kF0kxVRQ==;
Received: from [89.144.222.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqyXs-00EXL2-Kc; Tue, 17 May 2022 14:51:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 15/15] btrfs: remove io_failure_record infrastructure completely
Date:   Tue, 17 May 2022 16:50:39 +0200
Message-Id: <20220517145039.3202184-16-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517145039.3202184-1-hch@lst.de>
References: <20220517145039.3202184-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

Since our read repair are always handled by btrfs_read_repair_ctrl,
which only has the lifespan inside endio function.

This means we no longer needs to record which range and its mirror
number for failure.

Now if we failed to read some data page, we have already tried every
mirrors we have, thus no need to record the failed range.

Thus this patch can remove the whole io_failure_record structure and its
related functions.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/btrfs_inode.h       |   5 -
 fs/btrfs/extent-io-tree.h    |  15 --
 fs/btrfs/extent_io.c         | 365 -----------------------------------
 fs/btrfs/extent_io.h         |  24 ---
 fs/btrfs/inode.c             |   7 -
 include/trace/events/btrfs.h |   1 -
 6 files changed, 417 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 33811e896623f..3eeba0eb9f16b 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -91,11 +91,6 @@ struct btrfs_inode {
 	/* the io_tree does range state (DIRTY, LOCKED etc) */
 	struct extent_io_tree io_tree;
 
-	/* special utility tree used to record which mirrors have already been
-	 * tried when checksums fail for a given block
-	 */
-	struct extent_io_tree io_failure_tree;
-
 	/*
 	 * Keep track of where the inode has extent items mapped in order to
 	 * make sure the i_size adjustments are accurate
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index c3eb52dbe61cc..8ab9b6cd53ed4 100644
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
@@ -250,18 +249,4 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
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
index 093e3ac28fe21..b115ba7a4902b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2177,66 +2177,6 @@ u64 count_range_bits(struct extent_io_tree *tree,
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
@@ -2293,30 +2233,6 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
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
@@ -2432,287 +2348,6 @@ int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num)
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
-			btrfs_repair_io_failure(fs_info, ino, start,
-					failrec->len, failrec->logical,
-					page, pg_offset, failrec->failed_mirror);
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
-static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode,
-							     u64 start)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct io_failure_record *failrec;
-	struct extent_map *em;
-	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
-	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
-	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
-	const u32 sectorsize = fs_info->sectorsize;
-	int ret;
-	u64 logical;
-
-	failrec = get_state_failrec(failure_tree, start);
-	if (!IS_ERR(failrec)) {
-		btrfs_debug(fs_info,
-	"Get IO Failure Record: (found) logical=%llu, start=%llu, len=%llu",
-			failrec->logical, failrec->start, failrec->len);
-		/*
-		 * when data can be on disk more than twice, add to failrec here
-		 * (e.g. with a list for failed_mirror) to make
-		 * clean_io_failure() clean all those errors at once.
-		 */
-
-		return failrec;
-	}
-
-	failrec = kzalloc(sizeof(*failrec), GFP_NOFS);
-	if (!failrec)
-		return ERR_PTR(-ENOMEM);
-
-	failrec->start = start;
-	failrec->len = sectorsize;
-	failrec->this_mirror = 0;
-	failrec->compress_type = BTRFS_COMPRESS_NONE;
-
-	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, start, failrec->len);
-	if (!em) {
-		read_unlock(&em_tree->lock);
-		kfree(failrec);
-		return ERR_PTR(-EIO);
-	}
-
-	if (em->start > start || em->start + em->len <= start) {
-		free_extent_map(em);
-		em = NULL;
-	}
-	read_unlock(&em_tree->lock);
-	if (!em) {
-		kfree(failrec);
-		return ERR_PTR(-EIO);
-	}
-
-	logical = start - em->start;
-	logical = em->block_start + logical;
-	if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
-		logical = em->block_start;
-		failrec->compress_type = em->compress_type;
-	}
-
-	btrfs_debug(fs_info,
-		    "Get IO Failure Record: (new) logical=%llu, start=%llu, len=%llu",
-		    logical, start, failrec->len);
-
-	failrec->logical = logical;
-	free_extent_map(em);
-
-	/* Set the bits in the private failure tree */
-	ret = set_extent_bits(failure_tree, start, start + sectorsize - 1,
-			      EXTENT_LOCKED | EXTENT_DIRTY);
-	if (ret >= 0) {
-		ret = set_state_failrec(failure_tree, start, failrec);
-		/* Set the bits in the inode's tree */
-		ret = set_extent_bits(tree, start, start + sectorsize - 1,
-				      EXTENT_DAMAGED);
-	} else if (ret < 0) {
-		kfree(failrec);
-		return ERR_PTR(ret);
-	}
-
-	return failrec;
-}
-
-static bool btrfs_check_repairable(struct inode *inode,
-				   struct io_failure_record *failrec,
-				   int failed_mirror)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	int num_copies;
-
-	num_copies = btrfs_num_copies(fs_info, failrec->logical, failrec->len);
-	if (num_copies == 1) {
-		/*
-		 * we only have a single copy of the data, so don't bother with
-		 * all the retry and error correction code that follows. no
-		 * matter what the error is, it is very likely to persist.
-		 */
-		btrfs_debug(fs_info,
-			"Check Repairable: cannot repair, num_copies=%d, next_mirror %d, failed_mirror %d",
-			num_copies, failrec->this_mirror, failed_mirror);
-		return false;
-	}
-
-	/* The failure record should only contain one sector */
-	ASSERT(failrec->len == fs_info->sectorsize);
-
-	/*
-	 * There are two premises:
-	 * a) deliver good data to the caller
-	 * b) correct the bad sectors on disk
-	 *
-	 * Since we're only doing repair for one sector, we only need to get
-	 * a good copy of the failed sector and if we succeed, we have setup
-	 * everything for btrfs_repair_io_failure() to do the rest for us.
-	 */
-	ASSERT(failed_mirror);
-	failrec->failed_mirror = failed_mirror;
-	failrec->this_mirror++;
-	if (failrec->this_mirror == failed_mirror)
-		failrec->this_mirror++;
-
-	if (failrec->this_mirror > num_copies) {
-		btrfs_debug(fs_info,
-			"Check Repairable: (fail) num_copies=%d, next_mirror %d, failed_mirror %d",
-			num_copies, failrec->this_mirror, failed_mirror);
-		return false;
-	}
-
-	return true;
-}
-
-int btrfs_repair_one_sector(struct inode *inode,
-			    struct bio *failed_bio, u32 bio_offset,
-			    struct page *page, unsigned int pgoff,
-			    u64 start, int failed_mirror,
-			    submit_bio_hook_t *submit_bio_hook)
-{
-	struct io_failure_record *failrec;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
-	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
-	struct btrfs_bio *failed_bbio = btrfs_bio(failed_bio);
-	const int icsum = bio_offset >> fs_info->sectorsize_bits;
-	struct bio *repair_bio;
-	struct btrfs_bio *repair_bbio;
-
-	btrfs_debug(fs_info,
-		   "repair read error: read error at %llu", start);
-
-	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
-
-	failrec = btrfs_get_io_failure_record(inode, start);
-	if (IS_ERR(failrec))
-		return PTR_ERR(failrec);
-
-
-	if (!btrfs_check_repairable(inode, failrec, failed_mirror)) {
-		free_io_failure(failure_tree, tree, failrec);
-		return -EIO;
-	}
-
-	repair_bio = btrfs_bio_alloc(1);
-	repair_bbio = btrfs_bio(repair_bio);
-	repair_bbio->file_offset = start;
-	repair_bio->bi_opf = REQ_OP_READ;
-	repair_bio->bi_end_io = failed_bio->bi_end_io;
-	repair_bio->bi_iter.bi_sector = failrec->logical >> 9;
-	repair_bio->bi_private = failed_bio->bi_private;
-
-	if (failed_bbio->csum) {
-		const u32 csum_size = fs_info->csum_size;
-
-		repair_bbio->csum = repair_bbio->csum_inline;
-		memcpy(repair_bbio->csum,
-		       failed_bbio->csum + csum_size * icsum, csum_size);
-	}
-
-	bio_add_page(repair_bio, page, failrec->len, pgoff);
-	repair_bbio->iter = repair_bio->bi_iter;
-
-	btrfs_debug(btrfs_sb(inode->i_sb),
-		    "repair read error: submitting new read to mirror %d",
-		    failrec->this_mirror);
-
-	/*
-	 * At this point we have a bio, so any errors from submit_bio_hook()
-	 * will be handled by the endio on the repair_bio, so we can't return an
-	 * error here.
-	 */
-	submit_bio_hook(inode, repair_bio, failrec->this_mirror, failrec->compress_type);
-	return BLK_STS_OK;
-}
-
 static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 6cdcea1551a66..e46fe23f6aff4 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -61,7 +61,6 @@ struct btrfs_root;
 struct btrfs_inode;
 struct btrfs_io_bio;
 struct btrfs_fs_info;
-struct io_failure_record;
 struct extent_io_tree;
 
 typedef void (submit_bio_hook_t)(struct inode *inode, struct bio *bio,
@@ -253,29 +252,6 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
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
-	enum btrfs_compression_type compress_type;
-	int this_mirror;
-	int failed_mirror;
-};
-
-int btrfs_repair_one_sector(struct inode *inode,
-			    struct bio *failed_bio, u32 bio_offset,
-			    struct page *page, unsigned int pgoff,
-			    u64 start, int failed_mirror,
-			    submit_bio_hook_t *submit_bio_hook);
 int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 			    u64 length, u64 logical, struct page *page,
 			    unsigned int pg_offset, int mirror_num);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 51cca8f343b72..37c1af902a84b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3143,8 +3143,6 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 					ordered_extent->disk_num_bytes);
 	}
 
-	btrfs_free_io_failure_record(inode, start, end);
-
 	if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags)) {
 		truncated = true;
 		logical_len = ordered_extent->truncated_len;
@@ -5353,8 +5351,6 @@ void btrfs_evict_inode(struct inode *inode)
 	if (is_bad_inode(inode))
 		goto no_delete;
 
-	btrfs_free_io_failure_record(BTRFS_I(inode), 0, (u64)-1);
-
 	if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
 		goto no_delete;
 
@@ -8838,12 +8834,9 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	inode = &ei->vfs_inode;
 	extent_map_tree_init(&ei->extent_tree);
 	extent_io_tree_init(fs_info, &ei->io_tree, IO_TREE_INODE_IO, inode);
-	extent_io_tree_init(fs_info, &ei->io_failure_tree,
-			    IO_TREE_INODE_IO_FAILURE, inode);
 	extent_io_tree_init(fs_info, &ei->file_extent_tree,
 			    IO_TREE_INODE_FILE_EXTENT, inode);
 	ei->io_tree.track_uptodate = true;
-	ei->io_failure_tree.track_uptodate = true;
 	atomic_set(&ei->sync_writers, 0);
 	mutex_init(&ei->log_mutex);
 	btrfs_ordered_inode_tree_init(&ei->ordered_tree);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 290f07eb050af..764e9643c123c 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -82,7 +82,6 @@ struct btrfs_space_info;
 	EM( IO_TREE_FS_EXCLUDED_EXTENTS,  "EXCLUDED_EXTENTS")	    \
 	EM( IO_TREE_BTREE_INODE_IO,	  "BTREE_INODE_IO")	    \
 	EM( IO_TREE_INODE_IO,		  "INODE_IO")		    \
-	EM( IO_TREE_INODE_IO_FAILURE,	  "INODE_IO_FAILURE")	    \
 	EM( IO_TREE_RELOC_BLOCKS,	  "RELOC_BLOCKS")	    \
 	EM( IO_TREE_TRANS_DIRTY_PAGES,	  "TRANS_DIRTY_PAGES")      \
 	EM( IO_TREE_ROOT_DIRTY_LOG_PAGES, "ROOT_DIRTY_LOG_PAGES")   \
-- 
2.30.2

