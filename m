Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4742370D6FD
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 10:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbjEWIQM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 04:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbjEWIPk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 04:15:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A9619A3
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 01:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=yGI/0eVD+ylSGWrzsKeCm1l04uog+OHByoqL4GEOgTY=; b=ywY1h4JkG7XnnUgd8bkPrQRfmA
        82lJCLl+Y2bhkah9yt9p+9Ginb5B6Cf552GdjpDpfylQcOAuQEbHIVFEDdKpOzmA+j3t0WUv4H32G
        VReNILtE6Kmj5z+Mavly1nxdvLcrnjqRSfcQW/J3T95qlcb6sEU7Kpt1vKf9oMBRAz5/yd9RXqxCD
        UNgJDSo6DiPEOip4gAu3Td5lw1ajxgAdBr11tXLeKtevTsHm44q88gYGWex/efGELHUyVFk/RPwPM
        ZvWRdIV49yM1+53maua93anU9BBn4hUV6ohIsmOQv3pFZiSHASn5P4Y1/GkHurVFcFqwuheayFAA5
        vrcOYqtQ==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1N9S-009OW5-2Y;
        Tue, 23 May 2023 08:13:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/16] btrfs: remove PAGE_SET_ERROR
Date:   Tue, 23 May 2023 10:13:15 +0200
Message-Id: <20230523081322.331337-10-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523081322.331337-1-hch@lst.de>
References: <20230523081322.331337-1-hch@lst.de>
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

Now that the btrfs writeback code has stopped using PageError, using
PAGE_SET_ERROR to just set the per-address_space error flag is confusing.
Just open code the mapping_set_error calls in the callers and remove
the PAGE_SET_ERROR flag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c |  3 ---
 fs/btrfs/extent_io.h |  1 -
 fs/btrfs/inode.c     | 11 ++++++-----
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 28610ed0fae913..8b9e4980d8189c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -268,9 +268,6 @@ static int __process_pages_contig(struct address_space *mapping,
 		ASSERT(processed_end && *processed_end == start);
 	}
 
-	if ((page_ops & PAGE_SET_ERROR) && start_index <= end_index)
-		mapping_set_error(mapping, -EIO);
-
 	folio_batch_init(&fbatch);
 	while (index <= end_index) {
 		int found_folios;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index db9148bafd02c3..4317fceeffaddb 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -39,7 +39,6 @@ enum {
 	ENUM_BIT(PAGE_START_WRITEBACK),
 	ENUM_BIT(PAGE_END_WRITEBACK),
 	ENUM_BIT(PAGE_SET_ORDERED),
-	ENUM_BIT(PAGE_SET_ERROR),
 	ENUM_BIT(PAGE_LOCK),
 };
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 35b99fde75abb1..2e6673cdb47bd3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -835,6 +835,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 {
 	struct btrfs_inode *inode = async_chunk->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct address_space *mapping = inode->vfs_inode.i_mapping;
 	u64 blocksize = fs_info->sectorsize;
 	u64 start = async_chunk->start;
 	u64 end = async_chunk->end;
@@ -949,7 +950,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 		/* Compression level is applied here and only here */
 		ret = btrfs_compress_pages(
 			compress_type | (fs_info->compress_level << 4),
-					   inode->vfs_inode.i_mapping, start,
+					   mapping, start,
 					   pages,
 					   &nr_pages,
 					   &total_in,
@@ -992,9 +993,9 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 			unsigned long clear_flags = EXTENT_DELALLOC |
 				EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
 				EXTENT_DO_ACCOUNTING;
-			unsigned long page_error_op;
 
-			page_error_op = ret < 0 ? PAGE_SET_ERROR : 0;
+			if (ret < 0)
+				mapping_set_error(mapping, -EIO);
 
 			/*
 			 * inline extent creation worked or returned error,
@@ -1011,7 +1012,6 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 						     clear_flags,
 						     PAGE_UNLOCK |
 						     PAGE_START_WRITEBACK |
-						     page_error_op |
 						     PAGE_END_WRITEBACK);
 
 			/*
@@ -1271,12 +1271,13 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
 out_free:
+	mapping_set_error(inode->vfs_inode.i_mapping, -EIO);
 	extent_clear_unlock_delalloc(inode, start, end,
 				     NULL, EXTENT_LOCKED | EXTENT_DELALLOC |
 				     EXTENT_DELALLOC_NEW |
 				     EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING,
 				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
-				     PAGE_END_WRITEBACK | PAGE_SET_ERROR);
+				     PAGE_END_WRITEBACK);
 	free_async_extent_pages(async_extent);
 	goto done;
 }
-- 
2.39.2

