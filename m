Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B399123ECE
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 06:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfLRFTM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 00:19:12 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:44918 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfLRFTL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 00:19:11 -0500
Received: by mail-pl1-f178.google.com with SMTP id az3so424039plb.11
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 21:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ziERBtOWPyPQMCfA+NWJlsksZcQBo9OK7vmILGPs8Bc=;
        b=nBfjRkHwQDxMjvZGI/L2p02c46lRRt2XEPKtvl7xNEQZpxKr3FWAJgwAJ0RSebr4PW
         3k/GrblBEkLD87zlrhh8NS7WmE0V1grVo6DGB9bYX01tJex3fzuaCqcDCo3krvIFP7WB
         HZP7Wx6CpJCFjuRIVAgW9cXKOYZjPOzUIqR3D9Xecp5Sblx9SftZW08vlx1JFVRcc8im
         yZMeIHnGp/120BIjl1iW7k8p6I29DRnlXKlh9Hen0rrrbmHnCaClzwmmW61GsAHtmw/Y
         VxrnOBZm7CrFU1GPzLtJ3sVk38Zzt/gsr8iAZ7ResFnneDQKAEs2iE4FOzBR2VOkaWkh
         uBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ziERBtOWPyPQMCfA+NWJlsksZcQBo9OK7vmILGPs8Bc=;
        b=W7WfJNRb/lYxd536Xtv+py326TbcDmrYVMN3y3BHOdyDS5Y/xhaPJMK0YsurRI/AsE
         wlLHsFTUZeqWPHwhb3OSW89Jq2FCbRpPcYwPqi1LrX3ixnWrRMbRCFWaFPiL717lkiq+
         ZLe3zZZNAbjytte5Sn1UfxTzPptJlwFRY2REyRMmwDM7FOYrkR9UyAds5Ioa3wBZXq13
         BUTjd+mfhza2V8Q73Qmj8dP9Bm1QhUre6ltxB5vr2ftiBoI3VlW9LkJBZrMWo5OnqmTr
         7hH7OA7amfZyaXKJ2c0n90pYelQC5Y+xRTHmWo9YpwAxxLU5LYCOFTxyp2NUcRVB9u+n
         A5Eg==
X-Gm-Message-State: APjAAAVpqutpLc8bmlbaMcop1KEJ/0yTdQzA5HjknBCjg7/DyqjTdjs1
        iJ7XJo2xFKd14l2hYrnWGJfkWuTyue8=
X-Google-Smtp-Source: APXvYqx+t7Y/GMsKCPyfXWKrrrJOw5o5TdMQHSxpHTjtmqHSt5cC+AdusQtWSmgy2r2+5xFFaoUoMw==
X-Received: by 2002:a17:902:820f:: with SMTP id x15mr638620pln.125.1576646350358;
        Tue, 17 Dec 2019 21:19:10 -0800 (PST)
Received: from p.lan (81.249.92.34.bc.googleusercontent.com. [34.92.249.81])
        by smtp.gmail.com with ESMTPSA id e2sm1014781pfh.84.2019.12.17.21.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 21:19:09 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH V2 08/10] btrfs-progs: pass @trans to functions touch dirty block groups
Date:   Wed, 18 Dec 2019 13:18:47 +0800
Message-Id: <20191218051849.2587-9-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191218051849.2587-1-Damenly_Su@gmx.com>
References: <20191218051849.2587-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

We are going to touch dirty_bgs in trans directly, so every call chain
should pass paramemter @trans to end functions.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c                |  6 +++---
 check/mode-lowmem.c         |  6 +++---
 cmds/rescue-chunk-recover.c |  6 +++---
 ctree.h                     |  4 ++--
 extent-tree.c               | 18 +++++++++---------
 image/main.c                |  5 +++--
 6 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/check/main.c b/check/main.c
index 08dc9e66d013..7d797750e6d6 100644
--- a/check/main.c
+++ b/check/main.c
@@ -6651,8 +6651,8 @@ static int delete_extent_records(struct btrfs_trans_handle *trans,
 			u64 bytes = (found_key.type == BTRFS_EXTENT_ITEM_KEY) ?
 				found_key.offset : fs_info->nodesize;
 
-			ret = btrfs_update_block_group(fs_info->extent_root,
-						       bytenr, bytes, 0, 0);
+			ret = btrfs_update_block_group(trans, bytenr, bytes,
+						       0, 0);
 			if (ret)
 				break;
 		}
@@ -6730,7 +6730,7 @@ static int record_extent(struct btrfs_trans_handle *trans,
 		}
 
 		btrfs_mark_buffer_dirty(leaf);
-		ret = btrfs_update_block_group(extent_root, rec->start,
+		ret = btrfs_update_block_group(trans, rec->start,
 					       rec->max_size, 1, 0);
 		if (ret)
 			goto fail;
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index f53a0c39e86e..74c60368ca01 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -735,7 +735,7 @@ static int repair_tree_block_ref(struct btrfs_root *root,
 		}
 		btrfs_mark_buffer_dirty(eb);
 		printf("Added an extent item [%llu %u]\n", bytenr, node_size);
-		btrfs_update_block_group(extent_root, bytenr, node_size, 1, 0);
+		btrfs_update_block_group(trans, bytenr, node_size, 1, 0);
 
 		nrefs->refs[level] = 0;
 		nrefs->full_backref[level] =
@@ -3292,8 +3292,8 @@ static int repair_extent_data_item(struct btrfs_root *root,
 		btrfs_set_extent_flags(eb, ei, BTRFS_EXTENT_FLAG_DATA);
 
 		btrfs_mark_buffer_dirty(eb);
-		ret = btrfs_update_block_group(extent_root, disk_bytenr,
-					       num_bytes, 1, 0);
+		ret = btrfs_update_block_group(trans, disk_bytenr, num_bytes,
+					       1, 0);
 		btrfs_release_path(&path);
 	}
 
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index 171b4d07ecf9..461b66c6e13b 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1084,7 +1084,7 @@ err:
 	return ret;
 }
 
-static int block_group_free_all_extent(struct btrfs_root *root,
+static int block_group_free_all_extent(struct btrfs_trans_handle *trans,
 				       struct block_group_record *bg)
 {
 	struct btrfs_block_group_cache *cache;
@@ -1092,7 +1092,7 @@ static int block_group_free_all_extent(struct btrfs_root *root,
 	u64 start;
 	u64 end;
 
-	info = root->fs_info;
+	info = trans->fs_info;
 	cache = btrfs_lookup_block_group(info, bg->objectid);
 	if (!cache)
 		return -ENOENT;
@@ -1124,7 +1124,7 @@ static int remove_chunk_extent_item(struct btrfs_trans_handle *trans,
 		if (ret)
 			return ret;
 
-		ret = block_group_free_all_extent(root, chunk->bg_rec);
+		ret = block_group_free_all_extent(trans, chunk->bg_rec);
 		if (ret)
 			return ret;
 	}
diff --git a/ctree.h b/ctree.h
index 61ce53c46302..53882d04ac03 100644
--- a/ctree.h
+++ b/ctree.h
@@ -2568,8 +2568,8 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans,
 			   u64 type, u64 chunk_offset, u64 size);
 int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 			    struct btrfs_fs_info *fs_info);
-int btrfs_update_block_group(struct btrfs_root *root, u64 bytenr, u64 num,
-			     int alloc, int mark_free);
+int btrfs_update_block_group(struct btrfs_trans_handle *trans, u64 bytenr,
+			     u64 num, int alloc, int mark_free);
 int btrfs_record_file_extent(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root, u64 objectid,
 			      struct btrfs_inode_item *inode,
diff --git a/extent-tree.c b/extent-tree.c
index 615d823ec4de..f50d1c8b0a77 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -1872,9 +1872,10 @@ static int do_chunk_alloc(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-static int update_block_group(struct btrfs_fs_info *info, u64 bytenr,
+static int update_block_group(struct btrfs_trans_handle *trans, u64 bytenr,
 			      u64 num_bytes, int alloc, int mark_free)
 {
+	struct btrfs_fs_info *info = trans->fs_info;
 	struct btrfs_block_group_cache *cache;
 	u64 total = num_bytes;
 	u64 old_val;
@@ -2237,8 +2238,7 @@ static int __free_extent(struct btrfs_trans_handle *trans,
 			goto fail;
 		}
 
-		update_block_group(trans->fs_info, bytenr, num_bytes, 0,
-				   mark_free);
+		update_block_group(trans, bytenr, num_bytes, 0, mark_free);
 	}
 fail:
 	btrfs_free_path(path);
@@ -2570,7 +2570,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
-	ret = update_block_group(fs_info, ins.objectid, fs_info->nodesize, 1,
+	ret = update_block_group(trans, ins.objectid, fs_info->nodesize, 1,
 				 0);
 	if (sinfo) {
 		if (fs_info->nodesize > sinfo->bytes_reserved) {
@@ -3026,11 +3026,11 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-int btrfs_update_block_group(struct btrfs_root *root,
+int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 			     u64 bytenr, u64 num_bytes, int alloc,
 			     int mark_free)
 {
-	return update_block_group(root->fs_info, bytenr, num_bytes,
+	return update_block_group(trans, bytenr, num_bytes,
 				  alloc, mark_free);
 }
 
@@ -3444,12 +3444,12 @@ int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans)
 		btrfs_item_key_to_cpu(leaf, &key, slot);
 		if (key.type == BTRFS_EXTENT_ITEM_KEY) {
 			bytes_used += key.offset;
-			ret = btrfs_update_block_group(root,
+			ret = btrfs_update_block_group(trans,
 				  key.objectid, key.offset, 1, 0);
 			BUG_ON(ret);
 		} else if (key.type == BTRFS_METADATA_ITEM_KEY) {
 			bytes_used += fs_info->nodesize;
-			ret = btrfs_update_block_group(root,
+			ret = btrfs_update_block_group(trans,
 				  key.objectid, fs_info->nodesize, 1, 0);
 			if (ret)
 				goto out;
@@ -3604,7 +3604,7 @@ static int __btrfs_record_file_extent(struct btrfs_trans_handle *trans,
 					       BTRFS_EXTENT_FLAG_DATA);
 			btrfs_mark_buffer_dirty(leaf);
 
-			ret = btrfs_update_block_group(root, disk_bytenr,
+			ret = btrfs_update_block_group(trans, disk_bytenr,
 						       num_bytes, 1, 0);
 			if (ret)
 				goto fail;
diff --git a/image/main.c b/image/main.c
index bddb49720f0a..f88ffb16bafe 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2338,8 +2338,9 @@ again:
 	return 0;
 }
 
-static void fixup_block_groups(struct btrfs_fs_info *fs_info)
+static void fixup_block_groups(struct btrfs_trans_handle *trans)
 {
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_block_group_cache *bg;
 	struct btrfs_mapping_tree *map_tree = &fs_info->mapping_tree;
 	struct cache_extent *ce;
@@ -2499,7 +2500,7 @@ static int fixup_chunks_and_devices(struct btrfs_fs_info *fs_info,
 		return PTR_ERR(trans);
 	}
 
-	fixup_block_groups(fs_info);
+	fixup_block_groups(trans);
 	ret = fixup_dev_extents(trans);
 	if (ret < 0)
 		goto error;
-- 
2.21.0 (Apple Git-122.2)

