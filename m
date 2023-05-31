Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD2271768B
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 08:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjEaGFw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 02:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjEaGFv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 02:05:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13DD11D
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 23:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=lR683BTYUCplAO6tUIGajvNNI99z4p3SGaXckSW12oo=; b=uRSq2Vt1/56nIphztLzuQmY93w
        +VaqfH9OaS2IWCvtpkhU/q0BQuNauE3c8FUbtHXKbsdEzO/h2u+MNr66I/6/TZKqrU/vIhoh4TMQr
        rKCACukXbKCYDGB6cY+BCcASEMu6gOgyavsTBJQppdss2T+WYg1uGAn9lGMq8pbeUN4DwL5daKtfy
        STeMtVjpT5G/p72t6nePgx2QyZshTy2ErxS6BK5X7mEWpy6+1gadXiWQ8I2aewOjmexbY1/rSX5Nr
        jouCOJ0LkPLM2f8fbymDsNXito/LozU/2MR9TzPuh9+7ofQjOQhUrjZJvrf8S2H5+z5TG8IzPLUus
        ER4fp/gg==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4Exv-00GF8n-3A;
        Wed, 31 May 2023 06:05:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 13/16] btrfs: don't treat zoned writeback as being from an async helper thread
Date:   Wed, 31 May 2023 08:05:02 +0200
Message-Id: <20230531060505.468704-14-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531060505.468704-1-hch@lst.de>
References: <20230531060505.468704-1-hch@lst.de>
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

When extent_write_locked_range was originally added, it was only used
writing back compressed pages from an async helper thread.  But it is
now also used for writing back pages on zoned devices, where it is
called directly from the ->writepage context.  In this case we want to
to be able to pass on the writeback_control instead of creating a new
one, and more importantly want to use all the normal cgroup interaction
instead of potentially deferring writeback to another helper.

Fixes: 898793d992c2 ("btrfs: zoned: write out partially allocated region")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 20 +++++++-------------
 fs/btrfs/extent_io.h |  3 ++-
 fs/btrfs/inode.c     | 20 +++++++++++++++-----
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1da247e753b08a..f4d3c56b29009b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2210,7 +2210,8 @@ static int extent_write_cache_pages(struct address_space *mapping,
  * already been ran (aka, ordered extent inserted) and all pages are still
  * locked.
  */
-int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
+int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
+			      struct writeback_control *wbc)
 {
 	bool found_error = false;
 	int first_error = 0;
@@ -2220,22 +2221,16 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 	const u32 sectorsize = fs_info->sectorsize;
 	loff_t i_size = i_size_read(inode);
 	u64 cur = start;
-	struct writeback_control wbc_writepages = {
-		.sync_mode	= WB_SYNC_ALL,
-		.range_start	= start,
-		.range_end	= end,
-		.no_cgroup_owner = 1,
-	};
 	struct btrfs_bio_ctrl bio_ctrl = {
-		.wbc = &wbc_writepages,
-		/* We're called from an async helper function */
-		.opf = REQ_OP_WRITE | REQ_BTRFS_CGROUP_PUNT |
-			wbc_to_write_flags(&wbc_writepages),
+		.wbc = wbc,
+		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
 	};
 
+	if (wbc->no_cgroup_owner)
+		bio_ctrl.opf |= REQ_BTRFS_CGROUP_PUNT;
+
 	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(end + 1, sectorsize));
 
-	wbc_attach_fdatawrite_inode(&wbc_writepages, inode);
 	while (cur <= end) {
 		u64 cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
 		struct page *page;
@@ -2275,7 +2270,6 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 
 	submit_write_bio(&bio_ctrl, found_error ? ret : 0);
 
-	wbc_detach_inode(&wbc_writepages);
 	if (found_error)
 		return first_error;
 	return ret;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 6723bf3483d9f9..c5fae3a7d911bf 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -178,7 +178,8 @@ int try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);
 
 int btrfs_read_folio(struct file *file, struct folio *folio);
-int extent_write_locked_range(struct inode *inode, u64 start, u64 end);
+int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
+			      struct writeback_control *wbc);
 int extent_writepages(struct address_space *mapping,
 		      struct writeback_control *wbc);
 int btree_write_cache_pages(struct address_space *mapping,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ea9e880c8cee76..54b4b241b354fc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1133,6 +1133,12 @@ static int submit_uncompressed_range(struct btrfs_inode *inode,
 	unsigned long nr_written = 0;
 	int page_started = 0;
 	int ret;
+	struct writeback_control wbc = {
+		.sync_mode		= WB_SYNC_ALL,
+		.range_start		= start,
+		.range_end		= end,
+		.no_cgroup_owner	= 1,
+	};
 
 	/*
 	 * Call cow_file_range() to run the delalloc range directly, since we
@@ -1162,7 +1168,10 @@ static int submit_uncompressed_range(struct btrfs_inode *inode,
 	}
 
 	/* All pages will be unlocked, including @locked_page */
-	return extent_write_locked_range(&inode->vfs_inode, start, end);
+	wbc_attach_fdatawrite_inode(&wbc, &inode->vfs_inode);
+	ret = extent_write_locked_range(&inode->vfs_inode, start, end, &wbc);
+	wbc_detach_inode(&wbc);
+	return ret;
 }
 
 static int submit_one_async_extent(struct btrfs_inode *inode,
@@ -1815,7 +1824,8 @@ static bool run_delalloc_compressed(struct btrfs_inode *inode,
 static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
 				       struct page *locked_page, u64 start,
 				       u64 end, int *page_started,
-				       unsigned long *nr_written)
+				       unsigned long *nr_written,
+				       struct writeback_control *wbc)
 {
 	u64 done_offset = end;
 	int ret;
@@ -1847,8 +1857,8 @@ static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
 			account_page_redirty(locked_page);
 		}
 		locked_page_done = true;
-		extent_write_locked_range(&inode->vfs_inode, start, done_offset);
-
+		extent_write_locked_range(&inode->vfs_inode, start, done_offset,
+					  wbc);
 		start = done_offset + 1;
 	}
 
@@ -2422,7 +2432,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 
 	if (zoned)
 		ret = run_delalloc_zoned(inode, locked_page, start, end,
-					 page_started, nr_written);
+					 page_started, nr_written, wbc);
 	else
 		ret = cow_file_range(inode, locked_page, start, end,
 				     page_started, nr_written, 1, NULL);
-- 
2.39.2

