Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829907255C8
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 09:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbjFGHfw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 03:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239334AbjFGHe5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 03:34:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD89126B5
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 00:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=2GmX2pIkiQX9v5FycqrXMp7dTiNuyf2f1CnN+RVln2E=; b=Ekx7U/yCOAcy0DTB/zErFoxouI
        UZ61eCiWlVNuFKAaMjvm+p+XecDkBz5LkxyDN3TjCKn1nI8R9En2gwxm5NfOA3Z7Q+7KRtgKN7j55
        vUW5L9UTI6nPJmUhbWLHMd1MOBxXzpK6aWscnerUHwmzttx5p6mAU+V/I1c43Y1LMjYZERoAzktU9
        X5yAMypN1TsSQtdfd21HI+iCH24KJzKPOWWiKHsmRV6uR1M8Z7K8Hn2GCccMBPdphlKSsPJ13anc6
        cTkdU/k9MxeL/yxfUBuUdBhVfN8bBF+EJqn5PcHpFlRzUoG3CGs78MeQ/4oG+4BAPF1wg+VBwHkY4
        AMI4FwmA==;
Received: from 089144221144.atnat0030.highway.webapn.at ([89.144.221.144] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q6nd0-004k58-2j;
        Wed, 07 Jun 2023 07:30:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: remove btrfs_writepage_endio_finish_ordered
Date:   Wed,  7 Jun 2023 09:30:44 +0200
Message-Id: <20230607073045.97261-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
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

btrfs_writepage_endio_finish_ordered is a small wrapper around
btrfs_mark_ordered_io_finished that just changs the argument passing
slightly, and adds a tracepoint.

Move the tracpoint to btrfs_mark_ordered_io_finished, which means
it now also covers the error handling in btrfs_cleanup_ordered_extent
and switch all callers to just call btrfs_mark_ordered_io_finished
directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/btrfs_inode.h  |  3 ---
 fs/btrfs/extent_io.c    | 17 ++++++++---------
 fs/btrfs/inode.c        |  9 ---------
 fs/btrfs/ordered-data.c |  4 ++++
 4 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 8abf96cfea8fae..532c10bd2c222a 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -501,9 +501,6 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 			     u64 start, u64 end, int *page_started,
 			     unsigned long *nr_written, struct writeback_control *wbc);
 int btrfs_writepage_cow_fixup(struct page *page);
-void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
-					  struct page *page, u64 start,
-					  u64 end, bool uptodate);
 int btrfs_encoded_io_compression_from_extent(struct btrfs_fs_info *fs_info,
 					     int compress_type);
 int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 36c3ae947ae8e0..af05237dc2f186 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -473,17 +473,15 @@ void end_extent_writepage(struct page *page, int err, u64 start, u64 end)
 	struct btrfs_inode *inode;
 	const bool uptodate = (err == 0);
 	int ret = 0;
+	u32 len = end + 1 - start;
 
+	ASSERT(end + 1 - start <= U32_MAX);
 	ASSERT(page && page->mapping);
 	inode = BTRFS_I(page->mapping->host);
-	btrfs_writepage_endio_finish_ordered(inode, page, start, end, uptodate);
+	btrfs_mark_ordered_io_finished(inode, page, start, len, uptodate);
 
 	if (!uptodate) {
 		const struct btrfs_fs_info *fs_info = inode->root->fs_info;
-		u32 len;
-
-		ASSERT(end + 1 - start <= U32_MAX);
-		len = end + 1 - start;
 
 		btrfs_page_clear_uptodate(fs_info, page, start, len);
 		ret = err < 0 ? err : -EIO;
@@ -1328,6 +1326,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 
 	bio_ctrl->end_io_func = end_bio_extent_writepage;
 	while (cur <= end) {
+		u32 len = end - cur + 1;
 		u64 disk_bytenr;
 		u64 em_end;
 		u64 dirty_range_start = cur;
@@ -1335,8 +1334,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		u32 iosize;
 
 		if (cur >= i_size) {
-			btrfs_writepage_endio_finish_ordered(inode, page, cur,
-							     end, true);
+			btrfs_mark_ordered_io_finished(inode, page, cur, len,
+						       true);
 			/*
 			 * This range is beyond i_size, thus we don't need to
 			 * bother writing back.
@@ -1345,7 +1344,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			 * writeback the sectors with subpage dirty bits,
 			 * causing writeback without ordered extent.
 			 */
-			btrfs_page_clear_dirty(fs_info, page, cur, end + 1 - cur);
+			btrfs_page_clear_dirty(fs_info, page, cur, len);
 			break;
 		}
 
@@ -1356,7 +1355,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			continue;
 		}
 
-		em = btrfs_get_extent(inode, NULL, 0, cur, end - cur + 1);
+		em = btrfs_get_extent(inode, NULL, 0, cur, len);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR_OR_ZERO(em);
 			goto out_error;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3ddfdcb587f4d8..3f29a6451976fa 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3384,15 +3384,6 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered)
 	return btrfs_finish_one_ordered(ordered);
 }
 
-void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
-					  struct page *page, u64 start,
-					  u64 end, bool uptodate)
-{
-	trace_btrfs_writepage_end_io_hook(inode, start, end, uptodate);
-
-	btrfs_mark_ordered_io_finished(inode, page, start, end + 1 - start, uptodate);
-}
-
 /*
  * Verify the checksum for a single sector without any extra action that depend
  * on the type of I/O.
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index a629532283bc33..109e80ed25b669 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -410,6 +410,10 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 	unsigned long flags;
 	u64 cur = file_offset;
 
+	trace_btrfs_writepage_end_io_hook(inode, file_offset,
+					  file_offset + num_bytes - 1,
+					  uptodate);
+
 	spin_lock_irqsave(&tree->lock, flags);
 	while (cur < file_offset + num_bytes) {
 		u64 entry_end;
-- 
2.39.2

