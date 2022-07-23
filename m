Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FA157F1DF
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jul 2022 00:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiGWWZh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jul 2022 18:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGWWZg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jul 2022 18:25:36 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FE4635A;
        Sat, 23 Jul 2022 15:25:35 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 52C2F8126C;
        Sat, 23 Jul 2022 18:25:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658615133; bh=b8FBeJXUGntg/2vTzkYxvVc2szA7CIqhc0Cj2zBULu8=;
        h=From:To:Cc:Subject:Date:From;
        b=hQDVjOMHR6/iYziBAnnlqq8Ms/HM4XjjEI0j7VSX+4CDE85JmTGBsNe+aZMPthNE8
         XBDhBo02HvYQFrK3nQHWoP6nGPmmjW0MvuUrO0799Bq60q6mQiRQk7rZz6zh+Ch5vR
         jxBLu3iTHmyL0J5FEmKGXZKRCD+QAB47H32LL0NVFS+7eaBCjmwa/Fi+U7UAKC/yQv
         +hu0HWSdBSRWPE9pU2ukiNmzyjpwuaRS/eykMtKhNhXkPfTRcn0LdQvSmbCXTzU1hY
         lDmihvYwN+AgNNFtFZljU4+kfyL8bPUHj9rVEX1phTKRgCHRwmb20KNmYEPdFlkZWZ
         ugLjSCCHJdfsA==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Cc:     Omar Sandoval <osandov@osandov.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH] btrfs: change btrfs_insert_file_extent() to btrfs_insert_hole_extent()
Date:   Sat, 23 Jul 2022 18:25:29 -0400
Message-Id: <41e212570f521d9c0838b5ab8e66da0f942c7f46.1658615058.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@osandov.com>

btrfs_insert_file_extent() is only ever used to insert holes, so rename
it and remove the redundant parameters.

Signed-off-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/ctree.h     |  9 +++------
 fs/btrfs/file-item.c | 21 +++++++++------------
 fs/btrfs/file.c      |  4 ++--
 fs/btrfs/inode.c     |  4 ++--
 fs/btrfs/tree-log.c  | 13 +++++--------
 5 files changed, 21 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4db85b9dc7ed..3482eea0f1b8 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3258,12 +3258,9 @@ int btrfs_find_orphan_item(struct btrfs_root *root, u64 offset);
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
index 687fb372093f..d199275adfa4 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2520,8 +2520,8 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 	}
 	btrfs_release_path(path);
 
-	ret = btrfs_insert_file_extent(trans, root, btrfs_ino(inode),
-			offset, 0, 0, end - offset, 0, end - offset, 0, 0, 0);
+	ret = btrfs_insert_hole_extent(trans, root, btrfs_ino(inode), offset,
+				       end - offset);
 	if (ret)
 		return ret;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ecc5fa3343fc..f2c83ef8d4aa 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5022,8 +5022,8 @@ static int maybe_insert_hole(struct btrfs_root *root, struct btrfs_inode *inode,
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
index dcf75a8daa20..f99fd0a08902 100644
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

