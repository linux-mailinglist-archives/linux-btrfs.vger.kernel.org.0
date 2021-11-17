Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57C7454E65
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240664AbhKQUXL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240653AbhKQUXG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:06 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90646C061570
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:07 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id p4so3896053qkm.7
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5bYjNSJeFPNMOWrUYgw2GmfA6HDuESrxPqPiv0fJ0og=;
        b=uFdkXbFz1RbRav2HyOoSaZAKlfhfiTy0krGOe5dUzac6FtIKBwhtPwb8I3C6BFSuGU
         uoYGhF4KetzqcOaPdkKX17iIm7ALZxVF33VxeKJAcFUC1f5m78jYC0HDDzYWy5fxEf0h
         +2Hmj/pwa6bnbu/j0HbjCSTqkKpPibfRlZkZu5LRXbD6YvMFOwer8jp4Q66iwBPV4gUv
         2QX1sx/0IQSgxMsx4kJyqWFeNN2xD9u8q1YtRlq/XTpFUsiR+8nSfFbDaESS/sVPo/uZ
         Q/wxZ5jg5MjfROhLsgnMGY4r561XkiIRMWnOFi6o8+ZXZWnJ3yfThi8WpKXnhb/6j+Hv
         2Jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5bYjNSJeFPNMOWrUYgw2GmfA6HDuESrxPqPiv0fJ0og=;
        b=7yxoFUuiitrpkImOQFc3frKxmgTo6PlcFaxt7TqYWmq+pXD+gxhaCYWjku/3n4btsE
         icbdsfR2obbBVsckhVNLpicI3amWmiHldT6iUJ/K4CRB+hXKS5O9Ch5LsDBbcN2WqZR9
         qa3/RSVsfDAI9JOJMAfuQBX0vlXk1Zg9CGaRugqFZvNsy6PF61PEmtReBD4Mk6rj0Uzm
         vXy+uYZFOvMboVrEbqIgm/uI57OvUmR77CNbPW+0ZqbMNafxpvADazTJTwU7Tp4JaKwe
         sxcfkkNW50fteNuzsKsbzK9Eg9cSt5vDC3eSP0pAuvdY81hcoJFgL4mKmYyJD9fgtIk7
         HqVA==
X-Gm-Message-State: AOAM533y2vUqkPz/l0cPEjmuQi6km1a8awhk43AK5WDyxx9OM6nu37pv
        B5urV5mxGbMELghgVNrKmWgSOC0r95DFIQ==
X-Google-Smtp-Source: ABdhPJxpQ13e9iTT+YyCXpjns+THfydPplxrniRATZpqdzLrmjppcUlQQ40SSgzsV3EfhapOQPOz6w==
X-Received: by 2002:a05:620a:17aa:: with SMTP id ay42mr15868451qkb.481.1637180406485;
        Wed, 17 Nov 2021 12:20:06 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:06 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 06/17] btrfs: clean up cow_file_range_inline()
Date:   Wed, 17 Nov 2021 12:19:16 -0800
Message-Id: <6ee20a1022fe350038b2b0ee1c464285959512b8.1637179348.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 0c5b9832f975..a5cae0c6d992 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -233,12 +233,13 @@ static int btrfs_init_inode_security(struct btrfs_trans_handle *trans,
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
@@ -246,7 +247,6 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_file_extent_item *ei;
 	int ret;
 	size_t cur_size = size;
-	unsigned long offset;
 
 	ASSERT((compressed_size > 0 && compressed_pages) ||
 	       (compressed_size == 0 && !compressed_pages));
@@ -258,8 +258,8 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 		struct btrfs_key key;
 		size_t datasize;
 
-		key.objectid = btrfs_ino(BTRFS_I(inode));
-		key.offset = start;
+		key.objectid = btrfs_ino(inode);
+		key.offset = 0;
 		key.type = BTRFS_EXTENT_DATA_KEY;
 
 		datasize = btrfs_file_extent_calc_inline_size(cur_size);
@@ -297,12 +297,10 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
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
@@ -313,8 +311,8 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	 * We align size to sectorsize for inline extents just for simplicity
 	 * sake.
 	 */
-	size = ALIGN(size, root->fs_info->sectorsize);
-	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), start, size);
+	ret = btrfs_inode_set_file_extent_range(inode, 0,
+					ALIGN(size, root->fs_info->sectorsize));
 	if (ret)
 		goto fail;
 
@@ -327,7 +325,8 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	 * before we unlock the pages.  Otherwise we
 	 * could end up racing with unlink.
 	 */
-	BTRFS_I(inode)->disk_i_size = inode->i_size;
+	inode->disk_i_size = i_size_read(&inode->vfs_inode);
+
 fail:
 	return ret;
 }
@@ -338,8 +337,8 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
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
@@ -347,26 +346,21 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
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
@@ -380,30 +374,21 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
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
@@ -412,7 +397,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
 		goto out;
 	}
 
-	btrfs_update_inode_bytes(inode, inline_len, drop_args.bytes_found);
+	btrfs_update_inode_bytes(inode, size, drop_args.bytes_found);
 	ret = btrfs_update_inode(trans, root, inode);
 	if (ret && ret != -ENOSPC) {
 		btrfs_abort_transaction(trans, ret);
@@ -734,12 +719,12 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
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
@@ -1154,8 +1139,11 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
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
2.34.0

