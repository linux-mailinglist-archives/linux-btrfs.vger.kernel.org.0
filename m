Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22026B1F68
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 10:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjCIJII (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 04:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjCIJHu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 04:07:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69E82B9D1
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 01:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gQStZBbISOTtPYBsHwjE2x3MNt44ZySSssoRf4jTegU=; b=v4fOKsbQLZA8DKgLlarlY455I3
        ufpRYGy8Yu2f2psvGSWLz/oXDPcY6Qh0qBDtaLzyCjCxi0vHVscZIr03NMUNR+/OWUb6XqOPvfeZS
        5RdqZDF0ap12XW2IQ+m6Va6yC2D0yJZdC/AWV7+w+CJmo2WOb1L25D8O684waAUuHYx9ml5xgzEgV
        Z2M1oij7CG6iywoF9VhGwqx2eJpp1AGnvucMApZTrxd6uReZR+nX859lax/MYNPaTQpCsnb2hnPHi
        5gKjsIrsOhMv/CVZ+dd8aagCA2vIhqaSzumvhm9WRwEH2n17rRqmxIrRG+Z/wxn3qFt5VYImwkPGz
        ilGhz4pg==;
Received: from [2001:4bb8:190:782d:bc9d:fa49:9fec:5662] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paCF0-008i8k-Kq; Thu, 09 Mar 2023 09:07:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 19/20] btrfs: use per-buffer locking for extent_buffer reading
Date:   Thu,  9 Mar 2023 10:05:25 +0100
Message-Id: <20230309090526.332550-20-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309090526.332550-1-hch@lst.de>
References: <20230309090526.332550-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of locking and unlocking every page or the extent, just add a
new EXTENT_BUFFER_READING bit that mirrors EXTENT_BUFFER_WRITEBACK
for synchronizing threads trying to read an extent_buffer and to wait
for I/O completion.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 151 +++++++++++--------------------------------
 fs/btrfs/extent_io.h |   1 +
 2 files changed, 38 insertions(+), 114 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 73ea618282d466..e0e0d1bdb43f1a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4051,6 +4051,7 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
 static void extent_buffer_read_end_io(struct btrfs_bio *bbio)
 {
 	struct extent_buffer *eb = bbio->private;
+	struct btrfs_fs_info *fs_info = eb->fs_info;
 	bool uptodate = !bbio->bio.bi_status;
 	struct bvec_iter_all iter_all;
 	struct bio_vec *bvec;
@@ -4070,26 +4071,49 @@ static void extent_buffer_read_end_io(struct btrfs_bio *bbio)
 	}
 
 	bio_for_each_segment_all(bvec, &bbio->bio, iter_all) {
-		end_page_read(bvec->bv_page, uptodate, eb->start + bio_offset,
-			      bvec->bv_len);
+		u64 start = eb->start + bio_offset;
+		struct page *page = bvec->bv_page;
+		u32 len = bvec->bv_len;
+
+		if (uptodate)
+			btrfs_page_set_uptodate(fs_info, page, start, len);
+		else
+			btrfs_page_clear_uptodate(fs_info, page, start, len);
+
 		bio_offset += bvec->bv_len;
 	}
 
-	if (eb->fs_info->nodesize < PAGE_SIZE) {
-		unlock_extent(&bbio->inode->io_tree, eb->start,
-			      eb->start + bio_offset - 1, NULL);
-	}
+	clear_bit(EXTENT_BUFFER_READING, &eb->bflags);
+	smp_mb__after_atomic();
+	wake_up_bit(&eb->bflags, EXTENT_BUFFER_READING);
 	free_extent_buffer(eb);
 
 	bio_put(&bbio->bio);
 }
 
-static void __read_extent_buffer_pages(struct extent_buffer *eb, int mirror_num,
-				       struct btrfs_tree_parent_check *check)
+int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
+			     struct btrfs_tree_parent_check *check)
 {
 	int num_pages = num_extent_pages(eb), i;
 	struct btrfs_bio *bbio;
 
+	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
+		return 0;
+
+	/*
+	 * We could have had EXTENT_BUFFER_UPTODATE cleared by the write
+	 * operation, which could potentially still be in flight.  In this case
+	 * we simply want to return an error.
+	 */
+	if (unlikely(test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)))
+		return -EIO;
+
+	/*
+	 * Someone else is already reading the buffer, just wait for it.
+	 */
+	if (test_and_set_bit(EXTENT_BUFFER_READING, &eb->bflags))
+		goto done;
+
 	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
 	eb->read_mirror = 0;
 	check_buffer_tree_ref(eb);
@@ -4110,117 +4134,16 @@ static void __read_extent_buffer_pages(struct extent_buffer *eb, int mirror_num,
 			__bio_add_page(&bbio->bio, eb->pages[i], PAGE_SIZE, 0);
 	}
 	btrfs_submit_bio(bbio, mirror_num);
-}
-
-static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
-				      int mirror_num,
-				      struct btrfs_tree_parent_check *check)
-{
-	struct btrfs_fs_info *fs_info = eb->fs_info;
-	struct extent_io_tree *io_tree;
-	struct page *page = eb->pages[0];
-	struct extent_state *cached_state = NULL;
-	int ret;
 
-	ASSERT(!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags));
-	ASSERT(PagePrivate(page));
-	ASSERT(check);
-	io_tree = &BTRFS_I(fs_info->btree_inode)->io_tree;
-
-	if (wait == WAIT_NONE) {
-		if (!try_lock_extent(io_tree, eb->start, eb->start + eb->len - 1,
-				     &cached_state))
-			return -EAGAIN;
-	} else {
-		ret = lock_extent(io_tree, eb->start, eb->start + eb->len - 1,
-				  &cached_state);
-		if (ret < 0)
-			return ret;
-	}
-
-	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags)) {
-		unlock_extent(io_tree, eb->start, eb->start + eb->len - 1,
-			      &cached_state);
-		return 0;
-	}
-
-	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
-
-	__read_extent_buffer_pages(eb, mirror_num, check);
-	if (wait != WAIT_COMPLETE) {
-		free_extent_state(cached_state);
-		return 0;
-	}
-
-	wait_extent_bit(io_tree, eb->start, eb->start + eb->len - 1,
-			EXTENT_LOCKED, &cached_state);
-	if (!test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
-		return -EIO;
-	return 0;
-}
-
-int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
-			     struct btrfs_tree_parent_check *check)
-{
-	int i;
-	struct page *page;
-	int locked_pages = 0;
-	int num_pages;
-
-	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
-		return 0;
-
-	/*
-	 * We could have had EXTENT_BUFFER_UPTODATE cleared by the write
-	 * operation, which could potentially still be in flight.  In this case
-	 * we simply want to return an error.
-	 */
-	if (unlikely(test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)))
-		return -EIO;
-
-	if (eb->fs_info->nodesize < PAGE_SIZE)
-		return read_extent_buffer_subpage(eb, wait, mirror_num, check);
-
-	num_pages = num_extent_pages(eb);
-	for (i = 0; i < num_pages; i++) {
-		page = eb->pages[i];
-		if (wait == WAIT_NONE) {
-			/*
-			 * WAIT_NONE is only utilized by readahead. If we can't
-			 * acquire the lock atomically it means either the eb
-			 * is being read out or under modification.
-			 * Either way the eb will be or has been cached,
-			 * readahead can exit safely.
-			 */
-			if (!trylock_page(page))
-				goto unlock_exit;
-		} else {
-			lock_page(page);
-		}
-		locked_pages++;
-	}
-
-	__read_extent_buffer_pages(eb, mirror_num, check);
-
-	if (wait != WAIT_COMPLETE)
-		return 0;
-
-	for (i = 0; i < num_pages; i++) {
-		page = eb->pages[i];
-		wait_on_page_locked(page);
-		if (!PageUptodate(page))
+done:
+	if (wait == WAIT_COMPLETE) {
+		wait_on_bit_io(&eb->bflags, EXTENT_BUFFER_READING,
+			       TASK_UNINTERRUPTIBLE);
+		if (!test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
 			return -EIO;
 	}
 
 	return 0;
-
-unlock_exit:
-	while (locked_pages > 0) {
-		locked_pages--;
-		page = eb->pages[locked_pages];
-		unlock_page(page);
-	}
-	return 0;
 }
 
 static bool report_eb_range(const struct extent_buffer *eb, unsigned long start,
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 12854a2b48f060..44f63ab18b1888 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -29,6 +29,7 @@ enum {
 	/* write IO error */
 	EXTENT_BUFFER_WRITE_ERR,
 	EXTENT_BUFFER_NO_CHECK,
+	EXTENT_BUFFER_READING,
 };
 
 /* these are flags for __process_pages_contig */
-- 
2.39.2

