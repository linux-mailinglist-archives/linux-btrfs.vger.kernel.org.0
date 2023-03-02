Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FD46A8BBC
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 23:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCBWZf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 17:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCBWZd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 17:25:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8D82A6C3
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 14:25:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B97AD20062;
        Thu,  2 Mar 2023 22:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677795931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YvzgEnrzteNMMF0btcimIn2o+B4PrnaqXo6BnEcB3Rg=;
        b=KKoVKjg6zr8fwGTAWGMB6V4q+rrXfuyC0kkSf7AEBKKWx4OtbJRNOLAQjo4uYdEhBPZugk
        j3A34DGZESTOtejfyh2zKKshOYkILEZEWWR4Xw0Qm4nhpt+UttyN/2hdWk8uXWjF2dkg3W
        D6C93r2t3h0W7PgRHPvj8s9Wjmk00mY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677795931;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YvzgEnrzteNMMF0btcimIn2o+B4PrnaqXo6BnEcB3Rg=;
        b=ZtpGSM+i8R8hlSa5pPdN53ydXIiIjhmrpuMCsvljXx34vT0w24ULjGJQ68aClWO51j5lqj
        zQOk1NxmwWxdcDCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70B5F13349;
        Thu,  2 Mar 2023 22:25:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5gOjD1siAWTCSQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Thu, 02 Mar 2023 22:25:31 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 12/21] btrfs: lock extents before pages - defrag
Date:   Thu,  2 Mar 2023 16:24:57 -0600
Message-Id: <94356619bfac67197c4ccf371aee000f3a771f84.1677793433.git.rgoldwyn@suse.com>
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

lock and flush the range before performing defrag.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/defrag.c | 48 ++++++++++-------------------------------------
 1 file changed, 10 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 8065341d831a..dff53458bf52 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -721,9 +721,6 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode, pgoff_t i
 {
 	struct address_space *mapping = inode->vfs_inode.i_mapping;
 	gfp_t mask = btrfs_alloc_write_mask(mapping);
-	u64 page_start = (u64)index << PAGE_SHIFT;
-	u64 page_end = page_start + PAGE_SIZE - 1;
-	struct extent_state *cached_state = NULL;
 	struct page *page;
 	int ret;
 
@@ -753,32 +750,6 @@ static struct page *defrag_prepare_one_page(struct btrfs_inode *inode, pgoff_t i
 		return ERR_PTR(ret);
 	}
 
-	/* Wait for any existing ordered extent in the range */
-	while (1) {
-		struct btrfs_ordered_extent *ordered;
-
-		lock_extent(&inode->io_tree, page_start, page_end, &cached_state);
-		ordered = btrfs_lookup_ordered_range(inode, page_start, PAGE_SIZE);
-		unlock_extent(&inode->io_tree, page_start, page_end,
-			      &cached_state);
-		if (!ordered)
-			break;
-
-		unlock_page(page);
-		btrfs_start_ordered_extent(ordered);
-		btrfs_put_ordered_extent(ordered);
-		lock_page(page);
-		/*
-		 * We unlocked the page above, so we need check if it was
-		 * released or not.
-		 */
-		if (page->mapping != mapping || !PagePrivate(page)) {
-			unlock_page(page);
-			put_page(page);
-			goto again;
-		}
-	}
-
 	/*
 	 * Now the page range has no ordered extent any more.  Read the page to
 	 * make it uptodate.
@@ -1076,6 +1047,11 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 	if (!pages)
 		return -ENOMEM;
 
+	/* Lock the pages range */
+	btrfs_lock_and_flush_ordered_range(inode, start_index << PAGE_SHIFT,
+		    (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
+		    &cached_state);
+
 	/* Prepare all pages */
 	for (i = 0; i < nr_pages; i++) {
 		pages[i] = defrag_prepare_one_page(inode, start_index + i);
@@ -1088,10 +1064,6 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 	for (i = 0; i < nr_pages; i++)
 		wait_on_page_writeback(pages[i]);
 
-	/* Lock the pages range */
-	lock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
-		    (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
-		    &cached_state);
 	/*
 	 * Now we have a consistent view about the extent map, re-check
 	 * which range really needs to be defragged.
@@ -1103,7 +1075,7 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 				     newer_than, do_compress, true,
 				     &target_list, last_scanned_ret);
 	if (ret < 0)
-		goto unlock_extent;
+		goto free_pages;
 
 	list_for_each_entry(entry, &target_list, list) {
 		ret = defrag_one_locked_target(inode, entry, pages, nr_pages,
@@ -1116,10 +1088,6 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 		list_del_init(&entry->list);
 		kfree(entry);
 	}
-unlock_extent:
-	unlock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
-		      (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
-		      &cached_state);
 free_pages:
 	for (i = 0; i < nr_pages; i++) {
 		if (pages[i]) {
@@ -1128,6 +1096,10 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 		}
 	}
 	kfree(pages);
+
+	unlock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
+		      (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
+		      &cached_state);
 	return ret;
 }
 
-- 
2.39.2

