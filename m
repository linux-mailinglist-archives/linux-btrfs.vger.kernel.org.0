Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0002A5508D2
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 08:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbiFSGHR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 02:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiFSGHP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 02:07:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60978EE30
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Jun 2022 23:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=xY42SuIVs7WWYlvFxhGyxJEWc85aTix7pQ/ye6Ab2og=; b=EGgrQmJ/FlVrx/8ZbwdwgY4QUC
        N1ggTxpsEI86hYyraO9adL4uosfKSYfMLeCr8UiC08Jx7wwkk4vCYrUWesNIdrskI2POvosYWs8Mw
        vtvahiRRWpOWl3vzdDca3LkemNn6pD7cEEYepEzR0Ehkpfp/mkO/7czgsAoUW/DhbEKlkVJQeHJUk
        Kec5IO+oW27v7oMQ8OhCtIyzq9VoU2mWFEbfzdYy/LH05Mwl88aSOoMANgqC/FRdgCI3uXtQWYcBm
        Lf/6EHLWu8wnKDl2AlS5Of+Mfv1NTpE4VZW0ysyv7tBt83xG1crkNe2lWyHU71ZWBYZwlJ0BLCbtA
        RZXqXwow==;
Received: from [2001:4bb8:189:7251:513c:d533:c6f1:1e56] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2o5T-00DJvJ-F5; Sun, 19 Jun 2022 06:07:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove the finish_func argument to btrfs_mark_ordered_io_finished
Date:   Sun, 19 Jun 2022 08:07:05 +0200
Message-Id: <20220619060705.1850530-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

finish_func is always set to finish_ordered_fn, so remove it and also
the now pointless and somewhat confusingly named
__endio_write_update_ordered wrapper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c        | 40 ++++++++++------------------------------
 fs/btrfs/ordered-data.c | 17 +++++++++++------
 fs/btrfs/ordered-data.h |  5 +++--
 3 files changed, 24 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4d5bafbde086b..acbec8b11a7af 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -114,7 +114,6 @@ struct kmem_cache *btrfs_free_space_bitmap_cachep;
 
 static int btrfs_setsize(struct inode *inode, struct iattr *attr);
 static int btrfs_truncate(struct inode *inode, bool skip_writeback);
-static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent);
 static noinline int cow_file_range(struct btrfs_inode *inode,
 				   struct page *locked_page,
 				   u64 start, u64 end, int *page_started,
@@ -125,10 +124,6 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 ram_bytes, int compress_type,
 				       int type);
 
-static void __endio_write_update_ordered(struct btrfs_inode *inode,
-					 const u64 offset, const u64 bytes,
-					 const bool uptodate);
-
 /*
  * btrfs_inode_lock - lock inode i_rwsem based on arguments passed
  *
@@ -223,7 +218,7 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 
 		/*
 		 * Here we just clear all Ordered bits for every page in the
-		 * range, then __endio_write_update_ordered() will handle
+		 * range, then btrfs_mark_ordered_io_finished() will handle
 		 * the ordered extent accounting for the range.
 		 */
 		btrfs_page_clamp_clear_ordered(inode->root->fs_info, page,
@@ -244,7 +239,8 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 		offset = page_offset(locked_page) + PAGE_SIZE;
 	}
 
-	return __endio_write_update_ordered(inode, offset, bytes, false);
+	return btrfs_mark_ordered_io_finished(inode, NULL, offset, bytes,
+					      false);
 }
 
 static int btrfs_dirty_inode(struct inode *inode);
@@ -3082,7 +3078,7 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
  * an ordered extent if the range of bytes in the file it covers are
  * fully written.
  */
-static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
+int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 {
 	struct btrfs_inode *inode = BTRFS_I(ordered_extent->inode);
 	struct btrfs_root *root = inode->root;
@@ -3289,13 +3285,6 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	return ret;
 }
 
-static void finish_ordered_fn(struct btrfs_work *work)
-{
-	struct btrfs_ordered_extent *ordered_extent;
-	ordered_extent = container_of(work, struct btrfs_ordered_extent, work);
-	btrfs_finish_ordered_io(ordered_extent);
-}
-
 void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 					  struct page *page, u64 start,
 					  u64 end, bool uptodate)
@@ -3303,7 +3292,7 @@ void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 	trace_btrfs_writepage_end_io_hook(inode, start, end, uptodate);
 
 	btrfs_mark_ordered_io_finished(inode, page, start, end + 1 - start,
-				       finish_ordered_fn, uptodate);
+				       uptodate);
 }
 
 /*
@@ -7803,8 +7792,8 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		pos += submitted;
 		length -= submitted;
 		if (write)
-			__endio_write_update_ordered(BTRFS_I(inode), pos,
-					length, false);
+			btrfs_mark_ordered_io_finished(BTRFS_I(inode), NULL,
+					pos, length, false);
 		else
 			unlock_extent(&BTRFS_I(inode)->io_tree, pos,
 				      pos + length - 1);
@@ -7826,10 +7815,9 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 		return;
 
 	if (btrfs_op(&dip->bio) == BTRFS_MAP_WRITE) {
-		__endio_write_update_ordered(BTRFS_I(dip->inode),
-					     dip->file_offset,
-					     dip->bytes,
-					     !dip->bio.bi_status);
+		btrfs_mark_ordered_io_finished(BTRFS_I(dip->inode), NULL,
+					       dip->file_offset, dip->bytes,
+					       !dip->bio.bi_status);
 	} else {
 		unlock_extent(&BTRFS_I(dip->inode)->io_tree,
 			      dip->file_offset,
@@ -7876,14 +7864,6 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 	return err;
 }
 
-static void __endio_write_update_ordered(struct btrfs_inode *inode,
-					 const u64 offset, const u64 bytes,
-					 const bool uptodate)
-{
-	btrfs_mark_ordered_io_finished(inode, NULL, offset, bytes,
-				       finish_ordered_fn, uptodate);
-}
-
 static blk_status_t btrfs_submit_bio_start_direct_io(struct inode *inode,
 						     struct bio *bio,
 						     u64 dio_file_offset)
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 41b3bc44c92b2..8da054710a3c1 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -272,6 +272,13 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 	spin_unlock_irq(&tree->lock);
 }
 
+static void finish_ordered_fn(struct btrfs_work *work)
+{
+	struct btrfs_ordered_extent *ordered_extent;
+	ordered_extent = container_of(work, struct btrfs_ordered_extent, work);
+	btrfs_finish_ordered_io(ordered_extent);
+}
+
 /*
  * Mark all ordered extents io inside the specified range finished.
  *
@@ -281,16 +288,13 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
  *		 Can be NULL for direct IO and compressed write.
  *		 For these cases, callers are ensured they won't execute the
  *		 endio function twice.
- * @finish_func: The function to be executed when all the IO of an ordered
- *		 extent are finished.
  *
  * This function is called for endio, thus the range must have ordered
  * extent(s) covering it.
  */
 void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
-				struct page *page, u64 file_offset,
-				u64 num_bytes, btrfs_func_t finish_func,
-				bool uptodate)
+				    struct page *page, u64 file_offset,
+				    u64 num_bytes, bool uptodate)
 {
 	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
@@ -403,7 +407,8 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 			refcount_inc(&entry->refs);
 			trace_btrfs_ordered_extent_mark_finished(inode, entry);
 			spin_unlock_irqrestore(&tree->lock, flags);
-			btrfs_init_work(&entry->work, finish_func, NULL, NULL);
+			btrfs_init_work(&entry->work, finish_ordered_fn, NULL,
+					NULL);
 			btrfs_queue_work(wq, &entry->work);
 			spin_lock_irqsave(&tree->lock, flags);
 		}
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index ecad67a2c7457..87792f85e2c4a 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -180,13 +180,14 @@ btrfs_ordered_inode_tree_init(struct btrfs_ordered_inode_tree *t)
 	t->last = NULL;
 }
 
+int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent);
+
 void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry);
 void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 				struct btrfs_ordered_extent *entry);
 void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 				struct page *page, u64 file_offset,
-				u64 num_bytes, btrfs_func_t finish_func,
-				bool uptodate);
+				u64 num_bytes, bool uptodate);
 bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 				    struct btrfs_ordered_extent **cached,
 				    u64 file_offset, u64 io_size);
-- 
2.30.2

