Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CA1573448
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 12:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbiGMKae (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 06:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbiGMKab (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 06:30:31 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEECDFC989
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 03:30:30 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id F18B6800E3;
        Wed, 13 Jul 2022 06:30:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1657708230; bh=hJwjrkM7sbjKkmMCEskDCEA0B2CaXAXdjO53qmeWx+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BMsuvbdFlV44QW7ajkwWsFmKO+bE/Bj0GBMNZJ5gadknSTZsie/PUWuBQf5RGMhXj
         5+8oNRcw02loucz5tRbTq63slmDc8uygX/MNaWkao49B5TW5wDvBz7ywqVaKMEXPbO
         2L+jTgnQjgk+fVv3xSksHdjgeogjZU0MZTBkroI+Vd9H/hMtN1PuxnrdPH2Qne0bMc
         Eh/Y1ptavT78z4ufcEoV2oZRqsiC57QF6rwa7IWYK3kZmDu+pDwzoVGA2dtCCzUsGQ
         ECQcl9cd30ZCBl2wRdHbLLLFSbWPkNh0DuYRwv5ApVd9TrTNT1ZMFKtzguyEzj9D+X
         QNkRtHS2u9lkA==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Omar Sandoval <osandov@fb.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [RFC ONLY 01/23] btrfs: change btrfs_insert_file_extent() to btrfs_insert_hole_extent()
Date:   Wed, 13 Jul 2022 06:29:34 -0400
Message-Id: <f73654d9652778dfcbdd0e8176a8fa782130687b.1657707686.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1657707686.git.sweettea-kernel@dorminy.me>
References: <cover.1657707686.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

btrfs_insert_file_extent() is only ever used to insert holes, so rename
it and remove the redundant parameters.

Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/ctree.h     |  9 +++------
 fs/btrfs/file-item.c | 21 +++++++++------------
 fs/btrfs/file.c      |  4 ++--
 fs/btrfs/inode.c     |  4 ++--
 fs/btrfs/tree-log.c  | 13 +++++--------
 5 files changed, 21 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0ae7f6530da1..4c351b96115b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3260,12 +3260,9 @@ int btrfs_find_orphan_item(struct btrfs_root *root, u64 offset);
 int btrfs_del_csums(struct btrfs_trans_handle *trans,
 		    struct btrfs_root *root, u64 bytenr, u64 len);
 blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst);
-int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
-			     struct btrfs_root *root,
-			     u64 objectid, u64 pos,
-			     u64 disk_offset, u64 disk_num_bytes,
-			     u64 num_bytes, u64 offset, u64 ram_bytes,
-			     u8 compression, u8 encryption, u16 other_encoding);
+int btrfs_insert_hole_extent(struct btrfs_trans_handle *trans,
+			     struct btrfs_root *root, u64 objectid, u64 pos,
+			     u64 num_bytes);
 int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
 			     struct btrfs_path *path, u64 objectid,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index c828f971a346..29999686d234 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -129,12 +129,9 @@ static inline u32 max_ordered_sum_bytes(struct btrfs_fs_info *fs_info,
 	return ncsums * fs_info->sectorsize;
 }
 
-int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
+int btrfs_insert_hole_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
-			     u64 objectid, u64 pos,
-			     u64 disk_offset, u64 disk_num_bytes,
-			     u64 num_bytes, u64 offset, u64 ram_bytes,
-			     u8 compression, u8 encryption, u16 other_encoding)
+			     u64 objectid, u64 pos, u64 num_bytes)
 {
 	int ret = 0;
 	struct btrfs_file_extent_item *item;
@@ -157,16 +154,16 @@ int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
 	leaf = path->nodes[0];
 	item = btrfs_item_ptr(leaf, path->slots[0],
 			      struct btrfs_file_extent_item);
-	btrfs_set_file_extent_disk_bytenr(leaf, item, disk_offset);
-	btrfs_set_file_extent_disk_num_bytes(leaf, item, disk_num_bytes);
-	btrfs_set_file_extent_offset(leaf, item, offset);
+	btrfs_set_file_extent_disk_bytenr(leaf, item, 0);
+	btrfs_set_file_extent_disk_num_bytes(leaf, item, 0);
+	btrfs_set_file_extent_offset(leaf, item, 0);
 	btrfs_set_file_extent_num_bytes(leaf, item, num_bytes);
-	btrfs_set_file_extent_ram_bytes(leaf, item, ram_bytes);
+	btrfs_set_file_extent_ram_bytes(leaf, item, num_bytes);
 	btrfs_set_file_extent_generation(leaf, item, trans->transid);
 	btrfs_set_file_extent_type(leaf, item, BTRFS_FILE_EXTENT_REG);
-	btrfs_set_file_extent_compression(leaf, item, compression);
-	btrfs_set_file_extent_encryption(leaf, item, encryption);
-	btrfs_set_file_extent_other_encoding(leaf, item, other_encoding);
+	btrfs_set_file_extent_compression(leaf, item, 0);
+	btrfs_set_file_extent_encryption(leaf, item, 0);
+	btrfs_set_file_extent_other_encoding(leaf, item, 0);
 
 	btrfs_mark_buffer_dirty(leaf);
 out:
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 1876072dee9d..d0172cb54d9f 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2549,8 +2549,8 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 	}
 	btrfs_release_path(path);
 
-	ret = btrfs_insert_file_extent(trans, root, btrfs_ino(inode),
-			offset, 0, 0, end - offset, 0, end - offset, 0, 0, 0);
+	ret = btrfs_insert_hole_extent(trans, root, btrfs_ino(inode), offset,
+				       end - offset);
 	if (ret)
 		return ret;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c4e1d1491c6c..2a9e6675c77e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5027,8 +5027,8 @@ static int maybe_insert_hole(struct btrfs_root *root, struct btrfs_inode *inode,
 		return ret;
 	}
 
-	ret = btrfs_insert_file_extent(trans, root, btrfs_ino(inode),
-			offset, 0, 0, len, 0, len, 0, 0, 0);
+	ret = btrfs_insert_hole_extent(trans, root, btrfs_ino(inode), offset,
+				       len);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 	} else {
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index d898ba13285f..fa923a9e79c4 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5219,10 +5219,9 @@ static int btrfs_log_holes(struct btrfs_trans_handle *trans,
 			 * leafs from the log root.
 			 */
 			btrfs_release_path(path);
-			ret = btrfs_insert_file_extent(trans, root->log_root,
-						       ino, prev_extent_end, 0,
-						       0, hole_len, 0, hole_len,
-						       0, 0, 0);
+			ret = btrfs_insert_hole_extent(trans, root->log_root,
+						       ino, prev_extent_end,
+						       hole_len);
 			if (ret < 0)
 				return ret;
 
@@ -5251,10 +5250,8 @@ static int btrfs_log_holes(struct btrfs_trans_handle *trans,
 
 		btrfs_release_path(path);
 		hole_len = ALIGN(i_size - prev_extent_end, fs_info->sectorsize);
-		ret = btrfs_insert_file_extent(trans, root->log_root,
-					       ino, prev_extent_end, 0, 0,
-					       hole_len, 0, hole_len,
-					       0, 0, 0);
+		ret = btrfs_insert_hole_extent(trans, root->log_root, ino,
+					       prev_extent_end, hole_len);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.35.1

