Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FB7717931
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 09:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbjEaH40 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 03:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbjEaH4H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 03:56:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0EE1BFA
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 00:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vIsO4K8Rmf4FPsMkn7EasRUHqhhjO4C1y24hdoEqgqE=; b=1Zyi2jV4jsavGqEB2+YZELHDMx
        kxml2/xy8bK0pZ0Wd1iGl+Lam8evKEi+7EMC11MQmIeRx6PERopppmSbe55WHC7JPMlDeSgIq+l6Y
        aeVq4cG0GbwL4n5lZjmYC60b54My2AfLSAccq+zK6engi3JU2W4nHVLcTMiRxyf9sFBWTSJTu9djM
        +4OBm/ffZeGcKRoXKnYRUgt3Jco87oyBB8ooMqL3JTW3ry+9+atuJ/TGCDOlrKZgaIBwuEfIlHcEq
        vz1LN6AS2MDmln473WKJElx2gCOixSvt2ROERxHMucR/zXYDRPoKP8khtNKy8QPf0ZN8x70ouDLBb
        7Tubk8fw==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4GfN-00GWvg-1F;
        Wed, 31 May 2023 07:54:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 11/17] btrfs: factor out a can_finish_ordered_extent helper
Date:   Wed, 31 May 2023 09:54:04 +0200
Message-Id: <20230531075410.480499-12-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531075410.480499-1-hch@lst.de>
References: <20230531075410.480499-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Factor out a helper from btrfs_mark_ordered_io_finished that does the
actual per-ordered_extent work to check if we want to schedule an I/O
completion.  This new helper will later be used complete an
ordered_extent without first doing a lookup.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ordered-data.c | 103 ++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 3aee77f40f01eb..c8cd8a0fde0e11 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -303,6 +303,63 @@ static void finish_ordered_fn(struct btrfs_work *work)
 	btrfs_finish_ordered_io(ordered_extent);
 }
 
+static bool can_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
+				      struct page *page, u64 file_offset,
+				      u64 len, bool uptodate)
+{
+	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+
+	lockdep_assert_held(&inode->ordered_tree.lock);
+
+	if (page) {
+		ASSERT(page->mapping);
+		ASSERT(page_offset(page) <= file_offset);
+		ASSERT(file_offset + len <= page_offset(page) + PAGE_SIZE);
+
+		/*
+		 * Ordered (Private2) bit indicates whether we still
+		 * have pending io unfinished for the ordered extent.
+		 *
+		 * If there's no such bit, we need to skip to next range.
+		 */
+		if (!btrfs_page_test_ordered(fs_info, page, file_offset, len))
+			return false;
+		btrfs_page_clear_ordered(fs_info, page, file_offset, len);
+	}
+
+	/* Now we're fine to update the accounting */
+	if (WARN_ON_ONCE(len > ordered->bytes_left)) {
+		btrfs_crit(fs_info,
+"bad ordered extent accounting, root=%llu ino=%llu OE offset=%llu OE len=%llu to_dec=%llu left=%llu",
+			   inode->root->root_key.objectid,
+			   btrfs_ino(inode),
+			   ordered->file_offset,
+			   ordered->num_bytes,
+			   len,
+			   ordered->bytes_left);
+			   ordered->bytes_left = 0;
+	} else {
+		ordered->bytes_left -= len;
+	}
+
+	if (!uptodate)
+		set_bit(BTRFS_ORDERED_IOERR, &ordered->flags);
+
+	if (ordered->bytes_left)
+		return false;
+
+	/*
+	 * All the IO of the ordered extent is finished, we need to queue
+	 * the finish_func to be executed.
+	 */
+	set_bit(BTRFS_ORDERED_IO_DONE, &ordered->flags);
+	cond_wake_up(&ordered->wait);
+	refcount_inc(&ordered->refs);
+	trace_btrfs_ordered_extent_mark_finished(inode, ordered);
+	return true;
+}
+
 /*
  * Mark all ordered extents io inside the specified range finished.
  *
@@ -333,10 +390,6 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 	else
 		wq = fs_info->endio_write_workers;
 
-	if (page)
-		ASSERT(page->mapping && page_offset(page) <= file_offset &&
-		       file_offset + num_bytes <= page_offset(page) + PAGE_SIZE);
-
 	spin_lock_irqsave(&tree->lock, flags);
 	while (cur < file_offset + num_bytes) {
 		u64 entry_end;
@@ -389,47 +442,7 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 		ASSERT(end + 1 - cur < U32_MAX);
 		len = end + 1 - cur;
 
-		if (page) {
-			/*
-			 * Ordered (Private2) bit indicates whether we still
-			 * have pending io unfinished for the ordered extent.
-			 *
-			 * If there's no such bit, we need to skip to next range.
-			 */
-			if (!btrfs_page_test_ordered(fs_info, page, cur, len)) {
-				cur += len;
-				continue;
-			}
-			btrfs_page_clear_ordered(fs_info, page, cur, len);
-		}
-
-		/* Now we're fine to update the accounting */
-		if (unlikely(len > entry->bytes_left)) {
-			WARN_ON(1);
-			btrfs_crit(fs_info,
-"bad ordered extent accounting, root=%llu ino=%llu OE offset=%llu OE len=%llu to_dec=%u left=%llu",
-				   inode->root->root_key.objectid,
-				   btrfs_ino(inode),
-				   entry->file_offset,
-				   entry->num_bytes,
-				   len, entry->bytes_left);
-			entry->bytes_left = 0;
-		} else {
-			entry->bytes_left -= len;
-		}
-
-		if (!uptodate)
-			set_bit(BTRFS_ORDERED_IOERR, &entry->flags);
-
-		/*
-		 * All the IO of the ordered extent is finished, we need to queue
-		 * the finish_func to be executed.
-		 */
-		if (entry->bytes_left == 0) {
-			set_bit(BTRFS_ORDERED_IO_DONE, &entry->flags);
-			cond_wake_up(&entry->wait);
-			refcount_inc(&entry->refs);
-			trace_btrfs_ordered_extent_mark_finished(inode, entry);
+		if (can_finish_ordered_extent(entry, page, cur, len, uptodate)) {
 			spin_unlock_irqrestore(&tree->lock, flags);
 			btrfs_init_work(&entry->work, finish_ordered_fn, NULL, NULL);
 			btrfs_queue_work(wq, &entry->work);
-- 
2.39.2

