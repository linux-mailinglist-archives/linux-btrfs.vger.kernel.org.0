Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773D26A8BB9
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 23:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCBWZ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 17:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCBWZ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 17:25:26 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8869A1ACFC
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 14:25:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D91820062;
        Thu,  2 Mar 2023 22:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677795924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p0RGUSL/ph+qwRg7N13i6ERvtlAGmelBlgTHClEN7T4=;
        b=Ri5KMfAnUE+3yCYSnt9jKxb3TcgCFhxoqa6SnYckzEKpB+taocSTDtlevX41Occ5p7RBzk
        w7i/qGZA8i+BHZSqeZEB5nsn3nkZQiEjyxwEQL8SQMqJEZPeY+9+HdlQDaGHS8U3hL3ltn
        Q/GGTZH/2OCjIa6H5RTfMyj+TdeCxzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677795924;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p0RGUSL/ph+qwRg7N13i6ERvtlAGmelBlgTHClEN7T4=;
        b=F2baNaoLHFRjcOVBYuot+afEOY6FQGRA3TVOSfHJv/lktcibaY4SKw/DHJanC4mhx6PMoM
        ngbE02ddYJq1nACQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD4DC13349;
        Thu,  2 Mar 2023 22:25:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SeloLlMiAWS4SQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Thu, 02 Mar 2023 22:25:23 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 09/21] btrfs: lock extents before folio for read()s
Date:   Thu,  2 Mar 2023 16:24:54 -0600
Message-Id: <1cc00df10c78699412b5eed753fa61aa3181d0b6.1677793433.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677793433.git.rgoldwyn@suse.com>
References: <cover.1677793433.git.rgoldwyn@suse.com>
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

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Lock the extents before folio by locking them using readahead_begin().
Unlock the extents after the readahead is complete.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/compression.c |  5 -----
 fs/btrfs/extent_io.c   | 25 -------------------------
 fs/btrfs/inode.c       | 17 +++++++++++++++++
 3 files changed, 17 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index f42f31f22d13..b0dd01e31078 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -381,11 +381,9 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 	struct extent_map *em;
 	struct address_space *mapping = inode->i_mapping;
 	struct extent_map_tree *em_tree;
-	struct extent_io_tree *tree;
 	int sectors_missed = 0;
 
 	em_tree = &BTRFS_I(inode)->extent_tree;
-	tree = &BTRFS_I(inode)->io_tree;
 
 	if (isize == 0)
 		return 0;
@@ -452,7 +450,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		}
 
 		page_end = (pg_index << PAGE_SHIFT) + PAGE_SIZE - 1;
-		lock_extent(tree, cur, page_end, NULL);
 		read_lock(&em_tree->lock);
 		em = lookup_extent_mapping(em_tree, cur, page_end + 1 - cur);
 		read_unlock(&em_tree->lock);
@@ -466,7 +463,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		    (cur + fs_info->sectorsize > extent_map_end(em)) ||
 		    (em->block_start >> 9) != cb->orig_bio->bi_iter.bi_sector) {
 			free_extent_map(em);
-			unlock_extent(tree, cur, page_end, NULL);
 			unlock_page(page);
 			put_page(page);
 			break;
@@ -486,7 +482,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		add_size = min(em->start + em->len, page_end + 1) - cur;
 		ret = bio_add_page(cb->orig_bio, page, add_size, offset_in_page(cur));
 		if (ret != add_size) {
-			unlock_extent(tree, cur, page_end, NULL);
 			unlock_page(page);
 			put_page(page);
 			break;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ed054c2f38d8..e44329a84caf 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -644,9 +644,6 @@ static void endio_readpage_release_extent(struct processed_extent *processed,
 			      struct btrfs_inode *inode, u64 start, u64 end,
 			      bool uptodate)
 {
-	struct extent_state *cached = NULL;
-	struct extent_io_tree *tree;
-
 	/* The first extent, initialize @processed */
 	if (!processed->inode)
 		goto update;
@@ -668,13 +665,6 @@ static void endio_readpage_release_extent(struct processed_extent *processed,
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
@@ -1209,11 +1199,9 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
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
@@ -1238,14 +1226,12 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
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
@@ -1315,8 +1301,6 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		/* we've found a hole, just zero and go on */
 		if (block_start == EXTENT_MAP_HOLE) {
 			memzero_page(page, pg_offset, iosize);
-
-			unlock_extent(tree, cur, cur + iosize - 1, NULL);
 			end_page_read(page, true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
@@ -1324,7 +1308,6 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		}
 		/* the get_extent function already copied into the page */
 		if (block_start == EXTENT_MAP_INLINE) {
-			unlock_extent(tree, cur, cur + iosize - 1, NULL);
 			end_page_read(page, true, cur, iosize);
 			cur = cur + iosize;
 			pg_offset += iosize;
@@ -1340,7 +1323,6 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 			 * We have to unlock the remaining range, or the page
 			 * will never be unlocked.
 			 */
-			unlock_extent(tree, cur, end, NULL);
 			end_page_read(page, false, cur, end + 1 - cur);
 			goto out;
 		}
@@ -1354,13 +1336,9 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
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
@@ -1377,11 +1355,8 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
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
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2816629fafe4..53bd9a64e803 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7848,9 +7848,25 @@ static int btrfs_writepages(struct address_space *mapping,
 	return extent_writepages(mapping, wbc);
 }
 
+static void btrfs_readahead_begin(struct readahead_control *rac)
+{
+	struct inode *inode = rac->mapping->host;
+	int sectorsize = btrfs_sb(inode->i_sb)->sectorsize;
+	u64 start = round_down(readahead_pos(rac), sectorsize);
+	u64 end = round_up(start + readahead_length(rac), sectorsize) - 1;
+
+	lock_extent(&BTRFS_I(inode)->io_tree, start, end, NULL);
+}
+
 static void btrfs_readahead(struct readahead_control *rac)
 {
+	struct inode *inode = rac->mapping->host;
+	int sectorsize = btrfs_sb(inode->i_sb)->sectorsize;
+	u64 start = round_down(readahead_pos(rac), sectorsize);
+	u64 end = round_up(start + readahead_length(rac), sectorsize) - 1;
+
 	extent_readahead(rac);
+	unlock_extent(&BTRFS_I(inode)->io_tree, start, end, NULL);
 }
 
 /*
@@ -10930,6 +10946,7 @@ static const struct file_operations btrfs_dir_file_operations = {
 static const struct address_space_operations btrfs_aops = {
 	.read_folio	= btrfs_read_folio,
 	.writepages	= btrfs_writepages,
+	.readahead_begin = btrfs_readahead_begin,
 	.readahead	= btrfs_readahead,
 	.direct_IO	= noop_direct_IO,
 	.invalidate_folio = btrfs_invalidate_folio,
-- 
2.39.2

