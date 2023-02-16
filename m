Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C30E699A28
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 17:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjBPQfA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 11:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjBPQez (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 11:34:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1C83B872
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 08:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9ORyp7JAbJ0UHO7TrZEtoMNszEpUi4xn8de6HYiwSUQ=; b=N+jjiIvGoRXaz2eBktxsEQgx2j
        Ddvnj5qVvigu5A8d7xedhOZvbJ651zjpL8IgAV+EtnlkQQl1Pc2I+O7x9X49eqpQGeRGYgN2owKZd
        6qiWuIKhmwz09qNVgWq9J5JOnMAY6mBTbMJQu7mYnJu77CKdE9r6gtV4iAYDcCQHvwk8iSQxY28AG
        kIixmjtNXQAK6LHELMmXxfl+MEGRbxQSjNK5C6EOLmELY22RPSOEUW4T5rynWCPqNnvuEPFAwuCs8
        Usnn22cQ8FuPNyYXF75soqO60prKBcZx6mST5EO0BHpDL76rvYSp4ALTDePiW4EffSYAcEn6Ex4n2
        dSQxcteg==;
Received: from [2001:4bb8:181:6771:37af:42b9:3236:81df] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pShDe-00BCyY-Ep; Thu, 16 Feb 2023 16:34:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/12] btrfs: remove the sync_io flag in struct btrfs_bio_ctrl
Date:   Thu, 16 Feb 2023 17:34:29 +0100
Message-Id: <20230216163437.2370948-5-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216163437.2370948-1-hch@lst.de>
References: <20230216163437.2370948-1-hch@lst.de>
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

The sync_io flag is equivalent to wbc->sync_mode == WB_SYNC_ALL, so
just check for that and remove the separate flag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1539ecea85812e..c27770b76ccd1b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -118,9 +118,6 @@ struct btrfs_bio_ctrl {
 	 * does the unlocking.
 	 */
 	bool extent_locked;
-
-	/* Tell the submit_bio code to use REQ_SYNC */
-	bool sync_io;
 };
 
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
@@ -1802,6 +1799,7 @@ static void end_extent_buffer_writeback(struct extent_buffer *eb)
  * Return <0 if something went wrong, no page is locked.
  */
 static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb,
+			  struct writeback_control *wbc,
 			  struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
@@ -1817,7 +1815,7 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 
 	if (test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags)) {
 		btrfs_tree_unlock(eb);
-		if (!bio_ctrl->sync_io)
+		if (wbc->sync_mode != WB_SYNC_ALL)
 			return 0;
 		if (!flush) {
 			submit_write_bio(bio_ctrl, 0);
@@ -2260,7 +2258,7 @@ static int submit_eb_subpage(struct page *page,
 		if (!eb)
 			continue;
 
-		ret = lock_extent_buffer_for_io(eb, bio_ctrl);
+		ret = lock_extent_buffer_for_io(eb, wbc, bio_ctrl);
 		if (ret == 0) {
 			free_extent_buffer(eb);
 			continue;
@@ -2359,7 +2357,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 
 	*eb_context = eb;
 
-	ret = lock_extent_buffer_for_io(eb, bio_ctrl);
+	ret = lock_extent_buffer_for_io(eb, wbc, bio_ctrl);
 	if (ret <= 0) {
 		btrfs_revert_meta_write_pointer(cache, eb);
 		if (cache)
@@ -2388,7 +2386,6 @@ int btree_write_cache_pages(struct address_space *mapping,
 	struct btrfs_bio_ctrl bio_ctrl = {
 		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
 		.extent_locked = 0,
-		.sync_io = (wbc->sync_mode == WB_SYNC_ALL),
 	};
 	struct btrfs_fs_info *fs_info = BTRFS_I(mapping->host)->root->fs_info;
 	int ret = 0;
@@ -2684,7 +2681,6 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 	struct btrfs_bio_ctrl bio_ctrl = {
 		.opf = REQ_OP_WRITE | wbc_to_write_flags(&wbc_writepages),
 		.extent_locked = 1,
-		.sync_io = 1,
 	};
 
 	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(end + 1, sectorsize));
@@ -2731,7 +2727,6 @@ int extent_writepages(struct address_space *mapping,
 	struct btrfs_bio_ctrl bio_ctrl = {
 		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
 		.extent_locked = 0,
-		.sync_io = (wbc->sync_mode == WB_SYNC_ALL),
 	};
 
 	/*
-- 
2.39.1

