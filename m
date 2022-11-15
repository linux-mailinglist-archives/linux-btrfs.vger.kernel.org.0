Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9646962A0F9
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 19:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbiKOSBt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 13:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238294AbiKOSBM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 13:01:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834B6C03
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 10:00:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 415361F8E0;
        Tue, 15 Nov 2022 18:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668535253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vGarr4DN5B7hiz14x15U9Lw/fKq3vgsceZuvf/ubqqo=;
        b=rjU+I9AlU6au1709xR2/ePM57vUpvMQRBLSm6LBJvlSdoKg1wb5RxTqZKV8aZJYRptrBqk
        kWF4P8tzmbrGZdOG31dw3zN6hcqkX+nrYFQp3EU0IRE+bl9F7o8xSIN/y6Q/DNcH31P319
        Ejdbg9D9zg4f3p941i6Y6bt5rB4hxdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668535253;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vGarr4DN5B7hiz14x15U9Lw/fKq3vgsceZuvf/ubqqo=;
        b=0Mn9ySS1DLn6t5/ZnGjby3CDTqGmetkFAVhFJTUV4gOdDiC2quqvf8cpg0TPAGvSvucfgo
        mdtF2hjQzwfBgvCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4C8913A91;
        Tue, 15 Nov 2022 18:00:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /MYsKtTTc2OhZAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Tue, 15 Nov 2022 18:00:52 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 07/16] btrfs: Lock extents before folio for read()s
Date:   Tue, 15 Nov 2022 12:00:25 -0600
Message-Id: <5c7c77d0735c18cea82c347eef2ce2eb169681e6.1668530684.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668530684.git.rgoldwyn@suse.com>
References: <cover.1668530684.git.rgoldwyn@suse.com>
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

Perform extent locking around buffered reads as opposed to while
performing folio reads.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/compression.c |  5 -----
 fs/btrfs/extent_io.c   | 36 +-----------------------------------
 fs/btrfs/file.c        | 17 ++++++++++++++---
 3 files changed, 15 insertions(+), 43 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 30adf430241e..7f6452c4234e 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -526,11 +526,9 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 	struct extent_map *em;
 	struct address_space *mapping = inode->i_mapping;
 	struct extent_map_tree *em_tree;
-	struct extent_io_tree *tree;
 	int sectors_missed = 0;
 
 	em_tree = &BTRFS_I(inode)->extent_tree;
-	tree = &BTRFS_I(inode)->io_tree;
 
 	if (isize == 0)
 		return 0;
@@ -597,7 +595,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		}
 
 		page_end = (pg_index << PAGE_SHIFT) + PAGE_SIZE - 1;
-		lock_extent(tree, cur, page_end, NULL);
 		read_lock(&em_tree->lock);
 		em = lookup_extent_mapping(em_tree, cur, page_end + 1 - cur);
 		read_unlock(&em_tree->lock);
@@ -611,7 +608,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		    (cur + fs_info->sectorsize > extent_map_end(em)) ||
 		    (em->block_start >> 9) != cb->orig_bio->bi_iter.bi_sector) {
 			free_extent_map(em);
-			unlock_extent(tree, cur, page_end, NULL);
 			unlock_page(page);
 			put_page(page);
 			break;
@@ -631,7 +627,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		add_size = min(em->start + em->len, page_end + 1) - cur;
 		ret = bio_add_page(cb->orig_bio, page, add_size, offset_in_page(cur));
 		if (ret != add_size) {
-			unlock_extent(tree, cur, page_end, NULL);
 			unlock_page(page);
 			put_page(page);
 			break;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 42bae149f923..c5430cabad62 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -891,15 +891,6 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 		btrfs_subpage_end_reader(fs_info, page, start, len);
 }
 
-static void end_sector_io(struct page *page, u64 offset, bool uptodate)
-{
-	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
-	const u32 sectorsize = inode->root->fs_info->sectorsize;
-
-	end_page_read(page, uptodate, offset, sectorsize);
-	unlock_extent(&inode->io_tree, offset, offset + sectorsize - 1, NULL);
-}
-
 static void submit_data_read_repair(struct inode *inode,
 				    struct btrfs_bio *failed_bbio,
 				    u32 bio_offset, const struct bio_vec *bvec,
@@ -960,7 +951,7 @@ static void submit_data_read_repair(struct inode *inode,
 		 * will not be properly unlocked.
 		 */
 next:
-		end_sector_io(page, start + offset, uptodate);
+		end_page_read(page, uptodate, start + offset, sectorsize);
 	}
 }
 
@@ -1072,9 +1063,6 @@ static void endio_readpage_release_extent(struct processed_extent *processed,
 			      struct btrfs_inode *inode, u64 start, u64 end,
 			      bool uptodate)
 {
-	struct extent_state *cached = NULL;
-	struct extent_io_tree *tree;
-
 	/* The first extent, initialize @processed */
 	if (!processed->inode)
 		goto update;
@@ -1096,13 +1084,6 @@ static void endio_readpage_release_extent(struct processed_extent *processed,
 		return;
 	}
 
-	tree = &processed->inode->io_tree;
-	/*
-	 * Now we don't have range contiguous to the processed range, release
-	 * the processed range now.
-	 */
-	unlock_extent(tree, processed->start, processed->end, &cached);
-
 update:
 	/* Update processed to current range */
 	processed->inode = inode;
@@ -1743,11 +1724,9 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 	size_t pg_offset = 0;
 	size_t iosize;
 	size_t blocksize = inode->i_sb->s_blocksize;
-	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 
 	ret = set_page_extent_mapped(page);
 	if (ret < 0) {
-		unlock_extent(tree, start, end, NULL);
 		btrfs_page_set_error(fs_info, page, start, PAGE_SIZE);
 		unlock_page(page);
 		goto out;
@@ -1772,14 +1751,12 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		if (cur >= last_byte) {
 			iosize = PAGE_SIZE - pg_offset;
 			memzero_page(page, pg_offset, iosize);
-			unlock_extent(tree, cur, cur + iosize - 1, NULL);
 			end_page_read(page, true, cur, iosize);
 			break;
 		}
 		em = __get_extent_map(inode, page, pg_offset, cur,
 				      end - cur + 1, em_cached);
 		if (IS_ERR(em)) {
-			unlock_extent(tree, cur, end, NULL);
 			end_page_read(page, false, cur, end + 1 - cur);
 			ret = PTR_ERR(em);
 			break;
@@ -1849,8 +1826,6 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		/* we've found a hole, just zero and go on */
 		if (block_start == EXTENT_MAP_HOLE) {
 			memzero_page(page, pg_offset, iosize);
-
-			unlock_extent(tree, cur, cur + iosize - 1, NULL);
 			end_page_read(page, true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
@@ -1858,7 +1833,6 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		}
 		/* the get_extent function already copied into the page */
 		if (block_start == EXTENT_MAP_INLINE) {
-			unlock_extent(tree, cur, cur + iosize - 1, NULL);
 			end_page_read(page, true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
@@ -1874,7 +1848,6 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			 * We have to unlock the remaining range, or the page
 			 * will never be unlocked.
 			 */
-			unlock_extent(tree, cur, end, NULL);
 			end_page_read(page, false, cur, end + 1 - cur);
 			goto out;
 		}
@@ -1888,13 +1861,9 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 int btrfs_read_folio(struct file *file, struct folio *folio)
 {
 	struct page *page = &folio->page;
-	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
-	u64 start = page_offset(page);
-	u64 end = start + PAGE_SIZE - 1;
 	struct btrfs_bio_ctrl bio_ctrl = { 0 };
 	int ret;
 
-	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
 	ret = btrfs_do_readpage(page, NULL, &bio_ctrl, 0, NULL);
 	/*
@@ -1911,11 +1880,8 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
 					struct btrfs_bio_ctrl *bio_ctrl,
 					u64 *prev_em_start)
 {
-	struct btrfs_inode *inode = BTRFS_I(pages[0]->mapping->host);
 	int index;
 
-	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
-
 	for (index = 0; index < nr_pages; index++) {
 		btrfs_do_readpage(pages[index], em_cached, bio_ctrl,
 				  REQ_RAHEAD, prev_em_start);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 473a0743270b..9266ee6c1a61 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3806,15 +3806,26 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
 static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t ret = 0;
+	struct inode *inode = file_inode(iocb->ki_filp);
+	loff_t len = iov_iter_count(to);
+	u64 start = round_down(iocb->ki_pos, PAGE_SIZE);
+	u64 end = round_up(iocb->ki_pos + len, PAGE_SIZE) - 1;
+	struct extent_state *cached = NULL;
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = btrfs_direct_read(iocb, to);
-		if (ret < 0 || !iov_iter_count(to) ||
-		    iocb->ki_pos >= i_size_read(file_inode(iocb->ki_filp)))
+		if (ret < 0 || !len ||
+		    iocb->ki_pos >= i_size_read(inode))
 			return ret;
 	}
 
-	return filemap_read(iocb, to, ret);
+	btrfs_lock_and_flush_ordered_range(BTRFS_I(inode), start,
+			end, &cached);
+
+	ret = filemap_read(iocb, to, ret);
+
+	unlock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached);
+	return ret;
 }
 
 const struct file_operations btrfs_file_operations = {
-- 
2.35.3

