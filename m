Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9DF6A8BC5
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 23:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCBWZx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 17:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjCBWZw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 17:25:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BB428874
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 14:25:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 89C692006A;
        Thu,  2 Mar 2023 22:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677795949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cevwE62oedduoKyp7E+ilufz29r5dFRRDlg0n8a5c/w=;
        b=eDEbhO9W1gQiQuyRYnS2DBQyd1pLQEZu1vz7KLnjYmug8dcLuQEZ07ADOm1yuz04i2vbI4
        hPHpE8R+n0pVjgWaAIrX9UduOHIyYx0H8up4Flw+cjs1bwJ0b/vbhbQjssKZDtTD+3EG1/
        IiH4NEZnecxocMW3dF8qAIyGu3PUmdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677795949;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cevwE62oedduoKyp7E+ilufz29r5dFRRDlg0n8a5c/w=;
        b=aEOJ9iZoQ9s4BCscX60WoHvAeF6GUTSbY7ThNTYbLOp0unMe1VekNKkgwNM5F3hPSwTo19
        AKINjUjHgdn0WTBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4389B13349;
        Thu,  2 Mar 2023 22:25:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id E+9pCG0iAWTwSQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Thu, 02 Mar 2023 22:25:49 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 19/21] btrfs: lock extents before pages in relocation
Date:   Thu,  2 Mar 2023 16:25:04 -0600
Message-Id: <8864239884312377b62a36bfa65f1f8f66351855.1677793433.git.rgoldwyn@suse.com>
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

While relocating extents, lock the extents first. The locking is
performed before setup_relocation_extent() and unlocked after all pages
have been set as dirty.

All allocation is consolidated into one call to reserve metadata. Call
balance dirty pages outside of locks.

Q: This rearranges the sequence of calls. Not sure if this is correct.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/relocation.c | 44 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ef13a9d4e370..f15e9b1bfc45 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2911,7 +2911,6 @@ static noinline_for_stack int setup_relocation_extent_mapping(struct inode *inod
 				u64 start, u64 end, u64 block_start)
 {
 	struct extent_map *em;
-	struct extent_state *cached_state = NULL;
 	int ret = 0;
 
 	em = alloc_extent_map();
@@ -2924,9 +2923,7 @@ static noinline_for_stack int setup_relocation_extent_mapping(struct inode *inod
 	em->block_start = block_start;
 	set_bit(EXTENT_FLAG_PINNED, &em->flags);
 
-	lock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached_state);
 	ret = btrfs_replace_extent_map_range(BTRFS_I(inode), em, false);
-	unlock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached_state);
 	free_extent_map(em);
 
 	return ret;
@@ -2971,8 +2968,6 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 	ASSERT(page_index <= last_index);
 	page = find_lock_page(inode->i_mapping, page_index);
 	if (!page) {
-		page_cache_sync_readahead(inode->i_mapping, ra, NULL,
-				page_index, last_index + 1 - page_index);
 		page = find_or_create_page(inode->i_mapping, page_index, mask);
 		if (!page)
 			return -ENOMEM;
@@ -2981,11 +2976,6 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 	if (ret < 0)
 		goto release_page;
 
-	if (PageReadahead(page))
-		page_cache_async_readahead(inode->i_mapping, ra, NULL,
-				page_folio(page), page_index,
-				last_index + 1 - page_index);
-
 	if (!PageUptodate(page)) {
 		btrfs_read_folio(NULL, page_folio(page));
 		lock_page(page);
@@ -3012,16 +3002,7 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 		u64 clamped_end = min(page_end, extent_end);
 		u32 clamped_len = clamped_end + 1 - clamped_start;
 
-		/* Reserve metadata for this range */
-		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
-						      clamped_len, clamped_len,
-						      false);
-		if (ret)
-			goto release_page;
-
 		/* Mark the range delalloc and dirty for later writeback */
-		lock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end,
-			    &cached_state);
 		ret = btrfs_set_extent_delalloc(BTRFS_I(inode), clamped_start,
 						clamped_end, 0, &cached_state);
 		if (ret) {
@@ -3055,9 +3036,6 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 					boundary_start, boundary_end,
 					EXTENT_BOUNDARY);
 		}
-		unlock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end,
-			      &cached_state);
-		btrfs_delalloc_release_extents(BTRFS_I(inode), clamped_len);
 		cur += clamped_len;
 
 		/* Crossed extent end, go to next extent */
@@ -3071,7 +3049,6 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 	unlock_page(page);
 	put_page(page);
 
-	balance_dirty_pages_ratelimited(inode->i_mapping);
 	btrfs_throttle(fs_info);
 	if (btrfs_should_cancel_balance(fs_info))
 		ret = -ECANCELED;
@@ -3092,6 +3069,10 @@ static int relocate_file_extent_cluster(struct inode *inode,
 	struct file_ra_state *ra;
 	int cluster_nr = 0;
 	int ret = 0;
+	u64 start = cluster->start - offset;
+	u64 end = cluster->end - offset;
+	loff_t len = end + 1 - start;
+	struct extent_state *cached_state = NULL;
 
 	if (!cluster->nr)
 		return 0;
@@ -3106,17 +3087,30 @@ static int relocate_file_extent_cluster(struct inode *inode,
 
 	file_ra_state_init(ra, inode->i_mapping);
 
-	ret = setup_relocation_extent_mapping(inode, cluster->start - offset,
-				   cluster->end - offset, cluster->start);
+	page_cache_sync_readahead(inode->i_mapping, ra, NULL,
+			start >> PAGE_SHIFT, len >> PAGE_SHIFT);
+
+	ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len, len , false);
 	if (ret)
 		goto out;
 
+	lock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached_state);
+
+	ret = setup_relocation_extent_mapping(inode, start, end, cluster->start);
+	if (ret)
+		goto unlock;
+
 	last_index = (cluster->end - offset) >> PAGE_SHIFT;
 	for (index = (cluster->start - offset) >> PAGE_SHIFT;
 	     index <= last_index && !ret; index++)
 		ret = relocate_one_page(inode, ra, cluster, &cluster_nr, index);
 	if (ret == 0)
 		WARN_ON(cluster_nr != cluster->nr);
+unlock:
+	unlock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached_state);
+	btrfs_delalloc_release_extents(BTRFS_I(inode), len);
+
+	balance_dirty_pages_ratelimited(inode->i_mapping);
 out:
 	kfree(ra);
 	return ret;
-- 
2.39.2

