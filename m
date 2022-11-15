Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD68962A0FD
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 19:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbiKOSBs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 13:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbiKOSBL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 13:01:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0693E1157
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 10:00:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B293D33688;
        Tue, 15 Nov 2022 18:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668535250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GijL5/Y3oGaK8CJh9+F4rjmFJZqDl2bmnRrf+LTx3i4=;
        b=MFCjQgdupdyCO/of3Kn2kLZebnIN1CL0sab2wlK5DQ4GZ4HXjVNxKvcuZIHUmRk1ChhJjh
        HJhuSAbquRocLxCKh3TQu0rTY8kemdtM3IAKVn9GaCtTpg/KSh5cOT4xCuplcpVKFwU9l5
        pwWcW9M6dtCIYsI/YalWqRD9ND+H+yQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668535250;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GijL5/Y3oGaK8CJh9+F4rjmFJZqDl2bmnRrf+LTx3i4=;
        b=YEwfNA5t5QGyeFfgcbAKTs9gna35qVmFcXvsPzAOCRVAIji/bU9jQ7S/9jYObvvAZSPQ/e
        fTi0trFsi10MBFAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 635DA13A91;
        Tue, 15 Nov 2022 18:00:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oIxIENLTc2OfZAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Tue, 15 Nov 2022 18:00:50 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 06/16] btrfs: Lock extents before pages in writepages
Date:   Tue, 15 Nov 2022 12:00:24 -0600
Message-Id: <28cb7dbc0216d2a5f55efd296113f9f9576dda41.1668530684.git.rgoldwyn@suse.com>
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

writepages() locks the extents in find_lock_delalloc_range() and unlocks
using clear_bit EXTENT_LOCKED operations is cow/delalloc operations.

Call extent locking/unlocking around writepages() sequence as opposed to
while performing delayed allocation.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent_io.c |  5 -----
 fs/btrfs/inode.c     | 43 +++++++++++++++++++++++++++++++------------
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 92068e4ff9c3..42bae149f923 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -464,15 +464,10 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 		}
 	}
 
-	/* step three, lock the state bits for the whole range */
-	lock_extent(tree, delalloc_start, delalloc_end, &cached_state);
-
 	/* then test to make sure it is all still delalloc */
 	ret = test_range_bit(tree, delalloc_start, delalloc_end,
 			     EXTENT_DELALLOC, 1, cached_state);
 	if (!ret) {
-		unlock_extent(tree, delalloc_start, delalloc_end,
-			      &cached_state);
 		__unlock_for_delalloc(inode, locked_page,
 			      delalloc_start, delalloc_end);
 		cond_resched();
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4bfa51871ddc..92726831dd5d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -992,7 +992,6 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 				   struct async_extent *async_extent,
 				   u64 *alloc_hint)
 {
-	struct extent_io_tree *io_tree = &inode->io_tree;
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key ins;
@@ -1013,7 +1012,6 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 		if (!(start >= locked_page_end || end <= locked_page_start))
 			locked_page = async_chunk->locked_page;
 	}
-	lock_extent(io_tree, start, end, NULL);
 
 	/* We have fall back to uncompressed write */
 	if (!async_extent->pages)
@@ -1067,7 +1065,7 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 
 	/* Clear dirty, set writeback and unlock the pages. */
 	extent_clear_unlock_delalloc(inode, start, end,
-			NULL, EXTENT_LOCKED | EXTENT_DELALLOC,
+			NULL, EXTENT_DELALLOC,
 			PAGE_UNLOCK | PAGE_START_WRITEBACK);
 	if (btrfs_submit_compressed_write(inode, start,	/* file_offset */
 			    async_extent->ram_size,	/* num_bytes */
@@ -1095,7 +1093,7 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
 out_free:
 	extent_clear_unlock_delalloc(inode, start, end,
-				     NULL, EXTENT_LOCKED | EXTENT_DELALLOC |
+				     NULL, EXTENT_DELALLOC |
 				     EXTENT_DELALLOC_NEW |
 				     EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING,
 				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
@@ -1263,7 +1261,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			 */
 			extent_clear_unlock_delalloc(inode, start, end,
 				     locked_page,
-				     EXTENT_LOCKED | EXTENT_DELALLOC |
+				     EXTENT_DELALLOC |
 				     EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
 				     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
 				     PAGE_START_WRITEBACK | PAGE_END_WRITEBACK);
@@ -1374,7 +1372,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 		extent_clear_unlock_delalloc(inode, start, start + ram_size - 1,
 					     locked_page,
-					     EXTENT_LOCKED | EXTENT_DELALLOC,
+					     EXTENT_DELALLOC,
 					     page_ops);
 		if (num_bytes < cur_alloc_size)
 			num_bytes = 0;
@@ -1425,7 +1423,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 * We process each region below.
 	 */
 
-	clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
+	clear_bits = EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
 		EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
 	page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
 
@@ -1575,7 +1573,7 @@ static int cow_file_range_async(struct btrfs_inode *inode,
 	memalloc_nofs_restore(nofs_flag);
 
 	if (!ctx) {
-		unsigned clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC |
+		unsigned clear_bits = EXTENT_DELALLOC |
 			EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
 			EXTENT_DO_ACCOUNTING;
 		unsigned long page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK |
@@ -1955,7 +1953,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	path = btrfs_alloc_path();
 	if (!path) {
 		extent_clear_unlock_delalloc(inode, start, end, locked_page,
-					     EXTENT_LOCKED | EXTENT_DELALLOC |
+					     EXTENT_DELALLOC |
 					     EXTENT_DO_ACCOUNTING |
 					     EXTENT_DEFRAG, PAGE_UNLOCK |
 					     PAGE_START_WRITEBACK |
@@ -2169,7 +2167,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 						      nocow_args.num_bytes);
 
 		extent_clear_unlock_delalloc(inode, cur_offset, nocow_end,
-					     locked_page, EXTENT_LOCKED |
+					     locked_page,
 					     EXTENT_DELALLOC |
 					     EXTENT_CLEAR_DATA_RESV,
 					     PAGE_UNLOCK | PAGE_SET_ORDERED);
@@ -2205,7 +2203,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 	if (ret && cur_offset < end)
 		extent_clear_unlock_delalloc(inode, cur_offset, end,
-					     locked_page, EXTENT_LOCKED |
+					     locked_page,
 					     EXTENT_DELALLOC | EXTENT_DEFRAG |
 					     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
 					     PAGE_START_WRITEBACK |
@@ -8223,7 +8221,28 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 static int btrfs_writepages(struct address_space *mapping,
 			    struct writeback_control *wbc)
 {
-	return extent_writepages(mapping, wbc);
+	u64 start, end;
+	struct inode *inode = mapping->host;
+	struct extent_state *cached = NULL;
+	int ret;
+	u64 isize = round_up(i_size_read(inode), PAGE_SIZE) - 1;
+
+	if (wbc->range_cyclic) {
+		start = mapping->writeback_index << PAGE_SHIFT;
+		end = isize;
+	} else {
+		start = round_down(wbc->range_start, PAGE_SIZE);
+		end = round_up(wbc->range_end, PAGE_SIZE) - 1;
+		end = min(isize, end);
+	}
+
+	if (start >= end)
+		return 0;
+
+	lock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached);
+	ret = extent_writepages(mapping, wbc);
+	unlock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached);
+	return ret;
 }
 
 static void btrfs_readahead(struct readahead_control *rac)
-- 
2.35.3

