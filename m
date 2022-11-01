Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0586152F6
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiKAUNZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiKAUNV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:13:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2ACAA
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:13:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 02DA4336C4;
        Tue,  1 Nov 2022 20:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TvpmW/GhmL/YUNEHnZHABrlNrne904gmmdy5rnA81RI=;
        b=UYy7u/R//tEPBstUtyQnyDlbJu0ylI2LN/QkmtTzbJsF/VlQYxCzZPs0eyDo60E3lPNPpv
        JGkmn/WkPTlFr2Bn7NIewudgInlqENdr7trZbRMpdNpHNVhKkxdZYRWGMgToJdTQoA/ufh
        EQ5Pbo/73Rt3di/BOx3J0TaUzKmRyEo=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F0AC22C141;
        Tue,  1 Nov 2022 20:13:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4D4DADA79D; Tue,  1 Nov 2022 21:13:02 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 38/40] btrfs: use btrfs_inode inside compress_file_range
Date:   Tue,  1 Nov 2022 21:13:02 +0100
Message-Id: <141300382cb824060affc80b9a7d454dc942d9d1.1667331829.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667331828.git.dsterba@suse.com>
References: <cover.1667331828.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function is mostly using internal interfaces so we should use the
btrfs_inode.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ad5038dec0db..c55ffb856ae7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -648,8 +648,8 @@ static inline void inode_should_defrag(struct btrfs_inode *inode,
  */
 static noinline int compress_file_range(struct async_chunk *async_chunk)
 {
-	struct inode *inode = &async_chunk->inode->vfs_inode;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_inode *inode = async_chunk->inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	u64 blocksize = fs_info->sectorsize;
 	u64 start = async_chunk->start;
 	u64 end = async_chunk->end;
@@ -666,8 +666,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 	int compressed_extents = 0;
 	int redirty = 0;
 
-	inode_should_defrag(BTRFS_I(inode), start, end, end - start + 1,
-			SZ_16K);
+	inode_should_defrag(inode, start, end, end - start + 1, SZ_16K);
 
 	/*
 	 * We need to save i_size before now because it could change in between
@@ -679,7 +678,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 	 * does that for us.
 	 */
 	barrier();
-	i_size = i_size_read(inode);
+	i_size = i_size_read(&inode->vfs_inode);
 	barrier();
 	actual_end = min_t(u64, i_size, end + 1);
 again:
@@ -708,7 +707,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 	 * isn't an inline extent, since it doesn't save disk space at all.
 	 */
 	if (total_compressed <= blocksize &&
-	   (start > 0 || end + 1 < BTRFS_I(inode)->disk_i_size))
+	   (start > 0 || end + 1 < inode->disk_i_size))
 		goto cleanup_and_bail_uncompressed;
 
 	/*
@@ -732,7 +731,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 	 * inode has not been flagged as nocompress.  This flag can
 	 * change at any time if we discover bad compression ratios.
 	 */
-	if (inode_need_compress(BTRFS_I(inode), start, end)) {
+	if (inode_need_compress(inode, start, end)) {
 		WARN_ON(pages);
 		pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
 		if (!pages) {
@@ -741,10 +740,10 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 			goto cont;
 		}
 
-		if (BTRFS_I(inode)->defrag_compress)
-			compress_type = BTRFS_I(inode)->defrag_compress;
-		else if (BTRFS_I(inode)->prop_compress)
-			compress_type = BTRFS_I(inode)->prop_compress;
+		if (inode->defrag_compress)
+			compress_type = inode->defrag_compress;
+		else if (inode->prop_compress)
+			compress_type = inode->prop_compress;
 
 		/*
 		 * we need to call clear_page_dirty_for_io on each
@@ -759,14 +758,14 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 		 * has moved, the end is the original one.
 		 */
 		if (!redirty) {
-			extent_range_clear_dirty_for_io(inode, start, end);
+			extent_range_clear_dirty_for_io(&inode->vfs_inode, start, end);
 			redirty = 1;
 		}
 
 		/* Compression level is applied here and only here */
 		ret = btrfs_compress_pages(
 			compress_type | (fs_info->compress_level << 4),
-					   inode->i_mapping, start,
+					   inode->vfs_inode.i_mapping, start,
 					   pages,
 					   &nr_pages,
 					   &total_in,
@@ -795,12 +794,12 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 			/* we didn't compress the entire range, try
 			 * to make an uncompressed inline extent.
 			 */
-			ret = cow_file_range_inline(BTRFS_I(inode), actual_end,
+			ret = cow_file_range_inline(inode, actual_end,
 						    0, BTRFS_COMPRESS_NONE,
 						    NULL, false);
 		} else {
 			/* try making a compressed inline extent */
-			ret = cow_file_range_inline(BTRFS_I(inode), actual_end,
+			ret = cow_file_range_inline(inode, actual_end,
 						    total_compressed,
 						    compress_type, pages,
 						    false);
@@ -823,7 +822,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 			 * our outstanding extent for clearing delalloc for this
 			 * range.
 			 */
-			extent_clear_unlock_delalloc(BTRFS_I(inode), start, end,
+			extent_clear_unlock_delalloc(inode, start, end,
 						     NULL,
 						     clear_flags,
 						     PAGE_UNLOCK |
@@ -898,8 +897,8 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 
 		/* flag the file so we don't compress in the future */
 		if (!btrfs_test_opt(fs_info, FORCE_COMPRESS) &&
-		    !(BTRFS_I(inode)->prop_compress)) {
-			BTRFS_I(inode)->flags |= BTRFS_INODE_NOCOMPRESS;
+		    !(inode->prop_compress)) {
+			inode->flags |= BTRFS_INODE_NOCOMPRESS;
 		}
 	}
 cleanup_and_bail_uncompressed:
@@ -917,7 +916,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 	}
 
 	if (redirty)
-		extent_range_redirty_for_io(inode, start, end);
+		extent_range_redirty_for_io(&inode->vfs_inode, start, end);
 	add_async_extent(async_chunk, start, end - start + 1, 0, NULL, 0,
 			 BTRFS_COMPRESS_NONE);
 	compressed_extents++;
-- 
2.37.3

