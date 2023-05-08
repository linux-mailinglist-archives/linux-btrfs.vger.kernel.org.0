Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAD86FB4C1
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 18:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjEHQI7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 12:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbjEHQIu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 12:08:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B914EF1
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 09:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Q8sYcBbGjFRzEdG0MXeSCepX1viJjfoXeQdUDaw62+Y=; b=xsI9UM9O7sOsWqX7MI9pvJT8aN
        99atDk88gApT+MPvFN008UTqBNEf5GAmyuTXZ6aExtGmkHaj8tuixk5szRfQEHu/08DMmouCJBtmd
        qjx9seZm6xQfKa9j1hkv625D5E2hHdD8OBphRwdbQF6SpGciZPwnxIP3nHqzN4UWHT28I+zInMJdy
        oeVWpUbVkhLCB1F4kfrgm1mROhRJ+WnG4vT16fN9L+1nN1Nvzh8jGGUZWf//kEOAqK/bC/iRkfP1I
        k56QYmqxO52z65UCfXLk3yrHL598/WUpcA0GZaXsk2WkgRgB27eyeTjbFuUgnATnG0PTkw4Z5IuKo
        KTsQnzrA==;
Received: from [208.98.210.70] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw3Pr-000w0B-07;
        Mon, 08 May 2023 16:08:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/21] btrfs: pass an ordered_extent to btrfs_reloc_clone_csums
Date:   Mon,  8 May 2023 09:08:27 -0700
Message-Id: <20230508160843.133013-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508160843.133013-1-hch@lst.de>
References: <20230508160843.133013-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Both callers of btrfs_reloc_clone_csums allocate the ordered_extent that
btrfs_reloc_clone_csums operates on.  Switch them to use
btrfs_alloc_ordered_extent instead of btrfs_add_ordered_extent and
pass the ordered_extent to btrfs_reloc_clone_csums instead of doing an
extra lookup.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c      | 29 ++++++++++++++++++-----------
 fs/btrfs/relocation.c | 35 ++++++++++++++---------------------
 fs/btrfs/relocation.h |  2 +-
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f0372a01c12423..0bb47782267a2a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1478,6 +1478,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		min_alloc_size = fs_info->sectorsize;
 
 	while (num_bytes > 0) {
+		struct btrfs_ordered_extent *ordered;
+
 		cur_alloc_size = num_bytes;
 		ret = btrfs_reserve_extent(root, cur_alloc_size, cur_alloc_size,
 					   min_alloc_size, 0, alloc_hint,
@@ -1502,16 +1504,18 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		}
 		free_extent_map(em);
 
-		ret = btrfs_add_ordered_extent(inode, start, ram_size, ram_size,
-					       ins.objectid, cur_alloc_size, 0,
-					       1 << BTRFS_ORDERED_REGULAR,
-					       BTRFS_COMPRESS_NONE);
-		if (ret)
+		ordered = btrfs_alloc_ordered_extent(inode, start, ram_size,
+					ram_size, ins.objectid, cur_alloc_size,
+					0, 1 << BTRFS_ORDERED_REGULAR,
+					BTRFS_COMPRESS_NONE);
+		if (IS_ERR(ordered)) {
+			ret = PTR_ERR(ordered);
 			goto out_drop_extent_cache;
+		}
 
 		if (btrfs_is_data_reloc_root(root)) {
-			ret = btrfs_reloc_clone_csums(inode, start,
-						      cur_alloc_size);
+			ret = btrfs_reloc_clone_csums(ordered);
+
 			/*
 			 * Only drop cache here, and process as normal.
 			 *
@@ -1528,6 +1532,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 							    start + ram_size - 1,
 							    false);
 		}
+		btrfs_put_ordered_extent(ordered);
 
 		btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 
@@ -2138,6 +2143,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	nocow_args.writeback_path = true;
 
 	while (1) {
+		struct btrfs_ordered_extent *ordered;
 		struct btrfs_key found_key;
 		struct btrfs_file_extent_item *fi;
 		struct extent_buffer *leaf;
@@ -2303,18 +2309,19 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			free_extent_map(em);
 		}
 
-		ret = btrfs_add_ordered_extent(inode, cur_offset,
+		ordered = btrfs_alloc_ordered_extent(inode, cur_offset,
 				nocow_args.num_bytes, nocow_args.num_bytes,
 				nocow_args.disk_bytenr, nocow_args.num_bytes, 0,
 				is_prealloc ?
 					(1 << BTRFS_ORDERED_PREALLOC) :
 					(1 << BTRFS_ORDERED_NOCOW),
 				BTRFS_COMPRESS_NONE);
-		if (ret) {
+		if (IS_ERR(ordered)) {
 			if (is_prealloc) {
 				btrfs_drop_extent_map_range(inode, cur_offset,
 							    nocow_end, false);
 			}
+			ret = PTR_ERR(ordered);
 			goto error;
 		}
 
@@ -2329,8 +2336,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			 * extent_clear_unlock_delalloc() in error handler
 			 * from freeing metadata of created ordered extent.
 			 */
-			ret = btrfs_reloc_clone_csums(inode, cur_offset,
-						      nocow_args.num_bytes);
+			ret = btrfs_reloc_clone_csums(ordered);
+		btrfs_put_ordered_extent(ordered);
 
 		extent_clear_unlock_delalloc(inode, cur_offset, nocow_end,
 					     locked_page, EXTENT_LOCKED |
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 1c74cbe2fc5787..d3db300978f8b8 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4342,29 +4342,25 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
  * cloning checksum properly handles the nodatasum extents.
  * it also saves CPU time to re-calculate the checksum.
  */
-int btrfs_reloc_clone_csums(struct btrfs_inode *inode, u64 file_pos, u64 len)
+int btrfs_reloc_clone_csums(struct btrfs_ordered_extent *ordered)
 {
+	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct btrfs_root *csum_root;
-	struct btrfs_ordered_sum *sums;
-	struct btrfs_ordered_extent *ordered;
-	int ret;
-	u64 disk_bytenr;
-	u64 new_bytenr;
+	u64 disk_bytenr = ordered->file_offset + inode->index_cnt;
+	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, disk_bytenr);
 	LIST_HEAD(list);
+	int ret;
 
-	ordered = btrfs_lookup_ordered_extent(inode, file_pos);
-	BUG_ON(ordered->file_offset != file_pos || ordered->num_bytes != len);
-
-	disk_bytenr = file_pos + inode->index_cnt;
-	csum_root = btrfs_csum_root(fs_info, disk_bytenr);
 	ret = btrfs_lookup_csums_list(csum_root, disk_bytenr,
-				      disk_bytenr + len - 1, &list, 0, false);
+				      disk_bytenr + ordered->num_bytes - 1,
+				      &list, 0, false);
 	if (ret)
-		goto out;
+		return ret;
 
 	while (!list_empty(&list)) {
-		sums = list_entry(list.next, struct btrfs_ordered_sum, list);
+		struct btrfs_ordered_sum *sums =
+			list_entry(list.next, struct btrfs_ordered_sum, list);
+
 		list_del_init(&sums->list);
 
 		/*
@@ -4379,14 +4375,11 @@ int btrfs_reloc_clone_csums(struct btrfs_inode *inode, u64 file_pos, u64 len)
 		 * disk_len vs real len like with real inodes since it's all
 		 * disk length.
 		 */
-		new_bytenr = ordered->disk_bytenr + sums->bytenr - disk_bytenr;
-		sums->bytenr = new_bytenr;
-
+		sums->bytenr = ordered->disk_bytenr + sums->bytenr - disk_bytenr;
 		btrfs_add_ordered_sum(ordered, sums);
 	}
-out:
-	btrfs_put_ordered_extent(ordered);
-	return ret;
+
+	return 0;
 }
 
 int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
index 57cbac5c8ddd95..77d69f6ae967c2 100644
--- a/fs/btrfs/relocation.h
+++ b/fs/btrfs/relocation.h
@@ -8,7 +8,7 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans, struct btrfs_root *r
 int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root);
 int btrfs_recover_relocation(struct btrfs_fs_info *fs_info);
-int btrfs_reloc_clone_csums(struct btrfs_inode *inode, u64 file_pos, u64 len);
+int btrfs_reloc_clone_csums(struct btrfs_ordered_extent *ordered);
 int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root, struct extent_buffer *buf,
 			  struct extent_buffer *cow);
-- 
2.39.2

