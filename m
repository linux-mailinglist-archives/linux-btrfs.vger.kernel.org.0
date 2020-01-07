Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63BB2132FAB
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 20:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgAGTmr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 14:42:47 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43411 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbgAGTmq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jan 2020 14:42:46 -0500
Received: by mail-qv1-f67.google.com with SMTP id p2so370274qvo.10
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jan 2020 11:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=t4kKdnd9NuIjnJO3bt3E6qBFsV9EhYZstDi/vaGPtkU=;
        b=x+HJukZOQWBOWX8IJnzhMeIZ5tCF4I8GqXLpwQUHM12XTDgXWt/aoXho4LcVi98sXX
         G2YKgUZ0YlzxtEwCq/166mXM+Kz2T4YCPSHd8ciCBTpX+59ybspui5eQZXVPdPfNL66f
         avF65/V6G21vZnQi2eo4xfFn7Vk3lMOF8raFbTTCVDQhYx76ZnQRQRgSw/2/VBMTs6RV
         i9WLP9Vh4EzI/SO01D8gUQ0N88JZnFWZeRuLk/Mc7s6nXd8YpAmuDUM7sRYnhEQZN1bG
         RxmRvq2Fn729aQ+NK8K/Af3kSKr38ObDr5yYof4vnrEWfe1/FWB5RF0PTtjRpFeCSmJK
         gSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t4kKdnd9NuIjnJO3bt3E6qBFsV9EhYZstDi/vaGPtkU=;
        b=G4TfgDnm1vqPez1QWHImAzeDkUNquxR6IiMv6LjFCKEscWf51+OD8iFzWdHAizoijF
         rFNE3Md9KSgoPrS9/nbsWTugn19HEtNHAlxVqr92aiLiWpgqDBMLrvs/rjunAA9QwMcx
         G5MEu/M4sp7ZGrGlixz3t+z5qZMBFBDr01Uwpu1ITXPHEyjlVdJkQm8YUH0j7jWfzaSq
         +tMoZMEtoLnqky5KwTi11RtZbMRSbx1eqKb6TshOJAf9oyzQA7V24p99QfUcXbNviHr2
         Xp5DTfyuElwOO5Y6Da/6du24RcRo0gU7wD/R5B6pOoGToai6yk6vasNiSlvqEK7y8i7H
         WDTQ==
X-Gm-Message-State: APjAAAUqE+eiWeMTHMbb9KJWJAa/Y/k20QRC5IDEVJ+4t5GZ6io5IMwo
        sdsZvkX6LLgsQDcZp9raUL2vaS+BaH0tRw==
X-Google-Smtp-Source: APXvYqxdUSgMKUccuJ1b60DbG3GePyDyAEXzv/m5Zf+3ukaraEvAT3bvj5DAAXjSMckZXoDkFAjp+g==
X-Received: by 2002:ad4:55e8:: with SMTP id bu8mr990408qvb.61.1578426165203;
        Tue, 07 Jan 2020 11:42:45 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j185sm286626qkc.96.2020.01.07.11.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:42:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/5] btrfs: use the file extent tree infrastructure
Date:   Tue,  7 Jan 2020 14:42:35 -0500
Message-Id: <20200107194237.145694-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200107194237.145694-1-josef@toxicpanda.com>
References: <20200107194237.145694-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We want to use this everywhere we modify the file extent items
permanently.  These include

1) Inserting new file extents for writes and prealloc extents.
2) Truncating inode items.
3) btrfs_cont_expand().
4) Insert inline extents.
5) Insert new extents from log replay.
6) Insert a new extent for clone, as it could be past isize.

We do not however call the clear helper for hole punching because it
simply swaps out an existing file extent for a hole, so there's
effectively no change as far as the i_size is concerned.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-inode.c |  4 +++
 fs/btrfs/file.c          |  6 ++++
 fs/btrfs/inode.c         | 59 +++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/tree-log.c      |  5 ++++
 4 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index d3e15e1d4a91..8b4dcf4f6b3e 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1762,6 +1762,7 @@ int btrfs_fill_inode(struct inode *inode, u32 *rdev)
 {
 	struct btrfs_delayed_node *delayed_node;
 	struct btrfs_inode_item *inode_item;
+	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 
 	delayed_node = btrfs_get_delayed_node(BTRFS_I(inode));
 	if (!delayed_node)
@@ -1779,6 +1780,9 @@ int btrfs_fill_inode(struct inode *inode, u32 *rdev)
 	i_uid_write(inode, btrfs_stack_inode_uid(inode_item));
 	i_gid_write(inode, btrfs_stack_inode_gid(inode_item));
 	btrfs_i_size_write(BTRFS_I(inode), btrfs_stack_inode_size(inode_item));
+	btrfs_inode_set_file_extent_range(BTRFS_I(inode), 0,
+					  round_up(i_size_read(inode),
+						   fs_info->sectorsize));
 	inode->i_mode = btrfs_stack_inode_mode(inode_item);
 	set_nlink(inode, btrfs_stack_inode_nlink(inode_item));
 	inode_set_bytes(inode, btrfs_stack_inode_nbytes(inode_item));
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 4fadb892af24..f1c880c06ca2 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2486,6 +2486,12 @@ static int btrfs_insert_clone_extent(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_release_path(path);
 
+	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode),
+						clone_info->file_offset,
+						clone_len);
+	if (ret)
+		return ret;
+
 	/* If it's a hole, nothing more needs to be done. */
 	if (clone_info->disk_offset == 0)
 		return 0;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ab8b972863b1..5d34007aa7ec 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -243,6 +243,15 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_release_path(path);
 
+	/*
+	 * We align size to sectorsize for inline extents just for simplicity
+	 * sake.
+	 */
+	size = ALIGN(size, root->fs_info->sectorsize);
+	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), start, size);
+	if (ret)
+		goto fail;
+
 	/*
 	 * we're an inline extent, so nobody can
 	 * extend the file past i_size without locking
@@ -2377,6 +2386,11 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	ins.offset = disk_num_bytes;
 	ins.type = BTRFS_EXTENT_ITEM_KEY;
 
+	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), file_pos,
+						ram_bytes);
+	if (ret)
+		goto out;
+
 	/*
 	 * Release the reserved range from inode dirty range map, as it is
 	 * already moved into delayed_ref_head
@@ -4753,6 +4767,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	}
 
 	while (1) {
+		u64 clear_start = 0, clear_len = 0;
+
 		fi = NULL;
 		leaf = path->nodes[0];
 		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
@@ -4803,6 +4819,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 
 		if (extent_type != BTRFS_FILE_EXTENT_INLINE) {
 			u64 num_dec;
+
+			clear_start = found_key.offset;
 			extent_start = btrfs_file_extent_disk_bytenr(leaf, fi);
 			if (!del_item) {
 				u64 orig_num_bytes =
@@ -4810,6 +4828,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 				extent_num_bytes = ALIGN(new_size -
 						found_key.offset,
 						fs_info->sectorsize);
+				clear_start = ALIGN(new_size,
+						    fs_info->sectorsize);
 				btrfs_set_file_extent_num_bytes(leaf, fi,
 							 extent_num_bytes);
 				num_dec = (orig_num_bytes -
@@ -4835,6 +4855,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 						inode_sub_bytes(inode, num_dec);
 				}
 			}
+			clear_len = num_dec;
 		} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 			/*
 			 * we can't truncate inline items that have had
@@ -4856,12 +4877,34 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 				 */
 				ret = NEED_TRUNCATE_BLOCK;
 				break;
+			} else {
+				/*
+				 * Inline extents are special, we just treat
+				 * them as a full sector worth in the file
+				 * extent tree just for simplicity sake.
+				 */
+				clear_len = fs_info->sectorsize;
 			}
 
 			if (test_bit(BTRFS_ROOT_REF_COWS, &root->state))
 				inode_sub_bytes(inode, item_end + 1 - new_size);
 		}
 delete:
+		/*
+		 * We use btrfs_truncate_inode_items() to clean up log trees for
+		 * multiple fsyncs, and in this case we don't want to clear the
+		 * file extent range because it's just the log.
+		 */
+		if (root == BTRFS_I(inode)->root) {
+			ret = btrfs_inode_clear_file_extent_range(BTRFS_I(inode),
+								  clear_start,
+								  clear_len);
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
+				break;
+			}
+		}
+
 		if (del_item)
 			last_size = found_key.offset;
 		else
@@ -5183,14 +5226,22 @@ int btrfs_cont_expand(struct inode *inode, loff_t oldsize, loff_t size)
 		}
 		last_byte = min(extent_map_end(em), block_end);
 		last_byte = ALIGN(last_byte, fs_info->sectorsize);
+		hole_size = last_byte - cur_offset;
+
 		if (!test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
 			struct extent_map *hole_em;
-			hole_size = last_byte - cur_offset;
 
 			err = maybe_insert_hole(root, inode, cur_offset,
 						hole_size);
 			if (err)
 				break;
+
+			err = btrfs_inode_set_file_extent_range(BTRFS_I(inode),
+								cur_offset,
+								hole_size);
+			if (err)
+				break;
+
 			btrfs_drop_extent_cache(BTRFS_I(inode), cur_offset,
 						cur_offset + hole_size - 1, 0);
 			hole_em = alloc_extent_map();
@@ -5223,6 +5274,12 @@ int btrfs_cont_expand(struct inode *inode, loff_t oldsize, loff_t size)
 							hole_size - 1, 0);
 			}
 			free_extent_map(hole_em);
+		} else {
+			err = btrfs_inode_set_file_extent_range(BTRFS_I(inode),
+								cur_offset,
+								hole_size);
+			if (err)
+				break;
 		}
 next:
 		free_extent_map(em);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 19364940f9a1..ad25974ff936 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -829,6 +829,11 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 			goto out;
 	}
 
+	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), start,
+						extent_end - start);
+	if (ret)
+		goto out;
+
 	inode_add_bytes(inode, nbytes);
 update_inode:
 	ret = btrfs_update_inode(trans, root, inode);
-- 
2.23.0

