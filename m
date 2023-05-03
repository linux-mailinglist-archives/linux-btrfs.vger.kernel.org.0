Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D046C6F5B0D
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 17:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjECPZl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 11:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjECPZk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 11:25:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F82755AD
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9P/Z+uJr5/deq3PJMXBeStnMHhR8VG8ewU6hQgQ39AM=; b=tMmfoVHI8yUFZg1XTgT1mc+XAi
        b5ObxW0YORllfYCFwLeMvV06DLUPJ0umEKeCSH8W4Z5q0hPPOseJwWek0TMzVW5JNyLwiFGpTv9GI
        Tyt6n5TRQU1PRZIgvQxn901Se2cy1WRpT10u1LI4kcGop69dgj2ZoasxE6nmK5auosWjT8Pc4XHbN
        XwvtXbHkAoBQcAzxOrKtwU4coOZrQCI4fKDQlycfyQnqUCUZZWIUjNlQkmePr8Mow1dQf3jHZAgh7
        d/GbI28H7t8d5unq/Spccvv1KGwbHaKXDGozh4Nkp0++fv40sO/2qmA5uPRfSCzsw/JnGN1He6oPS
        kLutu9Pg==;
Received: from [2001:4bb8:181:617f:7279:c4cd:ae56:e444] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puEML-004xrV-1H;
        Wed, 03 May 2023 15:25:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 20/21] btrfs: use per-buffer locking for extent_buffer reading
Date:   Wed,  3 May 2023 17:24:40 +0200
Message-Id: <20230503152441.1141019-21-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230503152441.1141019-1-hch@lst.de>
References: <20230503152441.1141019-1-hch@lst.de>
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

Instead of locking and unlocking every page or the extent, just add a
new EXTENT_BUFFER_READING bit that mirrors EXTENT_BUFFER_WRITEBACK
for synchronizing threads trying to read an extent_buffer and to wait
for I/O completion.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 153 +++++++++++--------------------------------
 fs/btrfs/extent_io.h |   1 +
 2 files changed, 39 insertions(+), 115 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7556323e650cd4..4088acf259c4c8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4045,6 +4045,7 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
 static void extent_buffer_read_end_io(struct btrfs_bio *bbio)
 {
 	struct extent_buffer *eb = bbio->private;
+	struct btrfs_fs_info *fs_info = eb->fs_info;
 	bool uptodate = !bbio->bio.bi_status;
 	struct bvec_iter_all iter_all;
 	struct bio_vec *bvec;
@@ -4064,26 +4065,49 @@ static void extent_buffer_read_end_io(struct btrfs_bio *bbio)
 	}
 
 	bio_for_each_segment_all(bvec, &bbio->bio, iter_all) {
-		end_page_read(bvec->bv_page, uptodate, eb->start + bio_offset,
-			      bvec->bv_len);
-		bio_offset += bvec->bv_len;
-	}
+		u64 start = eb->start + bio_offset;
+		struct page *page = bvec->bv_page;
+		u32 len = bvec->bv_len;
 
-	if (eb->fs_info->nodesize < PAGE_SIZE) {
-		unlock_extent(&bbio->inode->io_tree, eb->start,
-			      eb->start + bio_offset - 1, NULL);
+		if (uptodate)
+			btrfs_page_set_uptodate(fs_info, page, start, len);
+		else
+			btrfs_page_clear_uptodate(fs_info, page, start, len);
+
+		bio_offset += len;
 	}
+
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
@@ -4104,117 +4128,16 @@ static void __read_extent_buffer_pages(struct extent_buffer *eb, int mirror_num,
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
-
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

