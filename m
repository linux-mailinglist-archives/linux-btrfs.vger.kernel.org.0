Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E046A45CB
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 16:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjB0PRR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 10:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjB0PRO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 10:17:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00399227A0
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 07:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1sGa2xZrJRM6fD8FbtmJI3pvcLAkd+S4XhDBn/NVAYc=; b=hk9UzEGFQsu1/yF0fDO49QePSW
        rnP94wEVWgXlGVWyJki8GJ35PNEMSzOya67R/pHyEi33AgQFXGFaRsxa/KaZeA8+OzxXrbwtcDb8d
        0G9DREEHZ0ZIAVACrWvzAFBfrOUUB/gpxQiBjUA/sV/dXT/qY05iWAWWd/qc112aZ/QG57gOg93NC
        ww/gA8gPhnubkb7vwEf5DOG8I9JkpnLIzvx0bJfbFA/drCgs6ZPkWu4mZrPej7s0p4mmOTcv5w1pn
        Ub8L46eVYFdaDwiWB2MXhhuRU4mzIHHrCFVDhfdZEQEpTEOi5Vf52z3tMJqorKZBrlGtAKfjikMLE
        TlBLWOiw==;
Received: from [136.36.117.140] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWfFS-00AAsn-BG; Mon, 27 Feb 2023 15:17:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 04/12] btrfs: remove the sync_io flag in struct btrfs_bio_ctrl
Date:   Mon, 27 Feb 2023 08:16:56 -0700
Message-Id: <20230227151704.1224688-5-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230227151704.1224688-1-hch@lst.de>
References: <20230227151704.1224688-1-hch@lst.de>
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2fb23e939b9975..432fd231935acc 100644
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

