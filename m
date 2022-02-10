Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F984B15F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343732AbiBJTKg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:10:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343720AbiBJTKf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:35 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB9010BA
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:36 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id l19so6140869pfu.2
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xt3rAE30yMLKYSibbekxlucGm1OKnp1pcr2vGpv56tM=;
        b=YpCELcdqNEFNgMhOBif/zmSz3hhpMXH3Oon7VznmQziTxhOIT8ctd8Ykwfll0Ofl7n
         jwysEk8zzw8t5jrVYibsxBKw4gHhxeb4ZAzpX6rDNyJgg1lTFSPBSfemm6PHZPwdl3dd
         Qj3byuUa4tCH+2RclXUEjou07i6QPr8ThQYV866IQHOJUdw1fO5Fteu5AE0rS8pY3EH6
         hzS/MnNNpyXG1HaQdCflj8UYmc3m2UxpBXgb4KDoVGfZ4hdhKasVnuitJKdbUyKleaxB
         iXpDTnrmbR5YvEE20yEhlY8xhskEuhQrPWH6H3NzZK3sm/U6oDGPWi+OK6waZ5k83dI5
         fI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xt3rAE30yMLKYSibbekxlucGm1OKnp1pcr2vGpv56tM=;
        b=7Og35QR8gBalCtXgOh7wxYWa6mk8j6qnPQTf8YouJk91pUN8o08L+bi3lNIKfJQiE+
         CZAsX38iIdhpMStdUjHC0rKaGFn6LAON7B+ucX06VgFjfK89uTByCu6YankTSftjLoIE
         hNu9LF0+Be7pmRI7Mej5YXnPPEeTtRM1S/CfI2WbtB/95I87GtDpZaNItF+iBadKU6rN
         6J3UIwXP+XTgdD3BAGYK8jdhJWkLP8IrlM6sxMWJJw8vj96UgruKcdX0KR1+mg7RD5HD
         LO4fOLEE30w2rkcJMj9PGA1FANK+v6Gj8lKGZchqmPjlFvX4jJaO7ghZgwJyEOdWZsIO
         2Xqw==
X-Gm-Message-State: AOAM530NZL+KaFar8s6f/cJdqXvkdGrAUg2ydrztHP/C2JLuGivMRcki
        sAsApQ5jbLk/dRRhtPiX3UT/6RbEpsMrJg==
X-Google-Smtp-Source: ABdhPJydyURTB5Kg/l/XLdih9bUMIVBiiViU58DpYkAxIDvvJwpyEwzeKOHEJwcbIwnZgXW1osJauA==
X-Received: by 2002:aa7:88c6:: with SMTP id k6mr8815676pff.68.1644520235694;
        Thu, 10 Feb 2022 11:10:35 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id n5sm8315898pgt.22.2022.02.10.11.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:10:35 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v13 06/17] btrfs: clean up cow_file_range_inline()
Date:   Thu, 10 Feb 2022 11:09:56 -0800
Message-Id: <f879a06a2619d606b19c389088c0b1c5bbf70d65.1644519257.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644519257.git.osandov@fb.com>
References: <cover.1644519257.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The start parameter to cow_file_range_inline() (and
insert_inline_extent()) is always 0, so get rid of it and simplify the
logic in those two functions. Pass btrfs_inode to insert_inline_extent()
and remove the redundant root parameter. Also document the requirements
for creating an inline extent. No functional change.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 88 +++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 50 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5acdbde17574..bd6588c7f8eb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -239,12 +239,13 @@ static int btrfs_init_inode_security(struct btrfs_trans_handle *trans,
  * no overlapping inline items exist in the btree
  */
 static int insert_inline_extent(struct btrfs_trans_handle *trans,
-				struct btrfs_path *path, bool extent_inserted,
-				struct btrfs_root *root, struct inode *inode,
-				u64 start, size_t size, size_t compressed_size,
+				struct btrfs_path *path,
+				struct btrfs_inode *inode, bool extent_inserted,
+				size_t size, size_t compressed_size,
 				int compress_type,
 				struct page **compressed_pages)
 {
+	struct btrfs_root *root = inode->root;
 	struct extent_buffer *leaf;
 	struct page *page = NULL;
 	char *kaddr;
@@ -252,7 +253,6 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_file_extent_item *ei;
 	int ret;
 	size_t cur_size = size;
-	unsigned long offset;
 
 	ASSERT((compressed_size > 0 && compressed_pages) ||
 	       (compressed_size == 0 && !compressed_pages));
@@ -264,8 +264,8 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 		struct btrfs_key key;
 		size_t datasize;
 
-		key.objectid = btrfs_ino(BTRFS_I(inode));
-		key.offset = start;
+		key.objectid = btrfs_ino(inode);
+		key.offset = 0;
 		key.type = BTRFS_EXTENT_DATA_KEY;
 
 		datasize = btrfs_file_extent_calc_inline_size(cur_size);
@@ -303,12 +303,10 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 		btrfs_set_file_extent_compression(leaf, ei,
 						  compress_type);
 	} else {
-		page = find_get_page(inode->i_mapping,
-				     start >> PAGE_SHIFT);
+		page = find_get_page(inode->vfs_inode.i_mapping, 0);
 		btrfs_set_file_extent_compression(leaf, ei, 0);
 		kaddr = kmap_atomic(page);
-		offset = offset_in_page(start);
-		write_extent_buffer(leaf, kaddr + offset, ptr, size);
+		write_extent_buffer(leaf, kaddr, ptr, size);
 		kunmap_atomic(kaddr);
 		put_page(page);
 	}
@@ -319,8 +317,8 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	 * We align size to sectorsize for inline extents just for simplicity
 	 * sake.
 	 */
-	size = ALIGN(size, root->fs_info->sectorsize);
-	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), start, size);
+	ret = btrfs_inode_set_file_extent_range(inode, 0,
+					ALIGN(size, root->fs_info->sectorsize));
 	if (ret)
 		goto fail;
 
@@ -333,7 +331,8 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	 * before we unlock the pages.  Otherwise we
 	 * could end up racing with unlink.
 	 */
-	BTRFS_I(inode)->disk_i_size = inode->i_size;
+	inode->disk_i_size = i_size_read(&inode->vfs_inode);
+
 fail:
 	return ret;
 }
@@ -344,8 +343,8 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
  * does the checks required to make sure the data is small enough
  * to fit as an inline extent.
  */
-static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
-					  u64 end, size_t compressed_size,
+static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
+					  size_t compressed_size,
 					  int compress_type,
 					  struct page **compressed_pages)
 {
@@ -353,26 +352,21 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *trans;
-	u64 isize = i_size_read(&inode->vfs_inode);
-	u64 actual_end = min(end + 1, isize);
-	u64 inline_len = actual_end - start;
-	u64 aligned_end = ALIGN(end, fs_info->sectorsize);
-	u64 data_len = inline_len;
+	u64 data_len = compressed_size ? compressed_size : size;
 	int ret;
 	struct btrfs_path *path;
 
-	if (compressed_size)
-		data_len = compressed_size;
-
-	if (start > 0 ||
-	    actual_end > fs_info->sectorsize ||
+	/*
+	 * We can create an inline extent if it ends at or beyond the current
+	 * i_size, is no larger than a sector (decompressed), and the (possibly
+	 * compressed) data fits in a leaf and the configured maximum inline
+	 * size.
+	 */
+	if (size < i_size_read(&inode->vfs_inode) ||
+	    size > fs_info->sectorsize ||
 	    data_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info) ||
-	    (!compressed_size &&
-	    (actual_end & (fs_info->sectorsize - 1)) == 0) ||
-	    end + 1 < isize ||
-	    data_len > fs_info->max_inline) {
+	    data_len > fs_info->max_inline)
 		return 1;
-	}
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -386,30 +380,21 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
 	trans->block_rsv = &inode->block_rsv;
 
 	drop_args.path = path;
-	drop_args.start = start;
-	drop_args.end = aligned_end;
+	drop_args.start = 0;
+	drop_args.end = fs_info->sectorsize;
 	drop_args.drop_cache = true;
 	drop_args.replace_extent = true;
-
-	if (compressed_size && compressed_pages)
-		drop_args.extent_item_size = btrfs_file_extent_calc_inline_size(
-		   compressed_size);
-	else
-		drop_args.extent_item_size = btrfs_file_extent_calc_inline_size(
-		    inline_len);
-
+	drop_args.extent_item_size = btrfs_file_extent_calc_inline_size(data_len);
 	ret = btrfs_drop_extents(trans, root, inode, &drop_args);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
-	if (isize > actual_end)
-		inline_len = min_t(u64, isize, actual_end);
-	ret = insert_inline_extent(trans, path, drop_args.extent_inserted,
-				   root, &inode->vfs_inode, start,
-				   inline_len, compressed_size,
-				   compress_type, compressed_pages);
+	ret = insert_inline_extent(trans, path, inode,
+				   drop_args.extent_inserted, size,
+				   compressed_size, compress_type,
+				   compressed_pages);
 	if (ret && ret != -ENOSPC) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -418,7 +403,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
 		goto out;
 	}
 
-	btrfs_update_inode_bytes(inode, inline_len, drop_args.bytes_found);
+	btrfs_update_inode_bytes(inode, size, drop_args.bytes_found);
 	ret = btrfs_update_inode(trans, root, inode);
 	if (ret && ret != -ENOSPC) {
 		btrfs_abort_transaction(trans, ret);
@@ -739,12 +724,12 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 			/* we didn't compress the entire range, try
 			 * to make an uncompressed inline extent.
 			 */
-			ret = cow_file_range_inline(BTRFS_I(inode), start, end,
+			ret = cow_file_range_inline(BTRFS_I(inode), actual_end,
 						    0, BTRFS_COMPRESS_NONE,
 						    NULL);
 		} else {
 			/* try making a compressed inline extent */
-			ret = cow_file_range_inline(BTRFS_I(inode), start, end,
+			ret = cow_file_range_inline(BTRFS_I(inode), actual_end,
 						    total_compressed,
 						    compress_type, pages);
 		}
@@ -1159,8 +1144,11 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 * So here we skip inline extent creation completely.
 	 */
 	if (start == 0 && fs_info->sectorsize == PAGE_SIZE) {
+		u64 actual_end = min_t(u64, i_size_read(&inode->vfs_inode),
+				       end + 1);
+
 		/* lets try to make an inline extent */
-		ret = cow_file_range_inline(inode, start, end, 0,
+		ret = cow_file_range_inline(inode, actual_end, 0,
 					    BTRFS_COMPRESS_NONE, NULL);
 		if (ret == 0) {
 			/*
-- 
2.35.1

