Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E126113AD5
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 05:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbfLEE3y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 23:29:54 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:40673 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfLEE3y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 23:29:54 -0500
Received: by mail-lj1-f175.google.com with SMTP id s22so1877405ljs.7
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2019 20:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aqN/reM2FdnsWrwmKgOP0wEi0Ji2L+JRUBIFXRT3UXQ=;
        b=D1cbf8yQkg+0kvTrcNrUlj2l/S2BsQxB45uDBI3HdYKykGxAMcLfuvJQlN6N5z6mLJ
         HfqJTtsNUO1ul3VcKAEPI8N2LxplEhPSkXi7Dxtqmj2dJk0O1s0Q3ESKS6lejnuhifwj
         F6BYKPBalV5hI5kX12lrIBMSVGbFVLYRN1ayDzi73dUdqI6ZGTnJanJOPiQMTT9OfD46
         Sc0moL+Ho45W97LEn2/Ip5u3+80wAZ2gB3MbfdE1yvtVxXl4SdsherIuBwxgPpXqYoJT
         g8caj/cgXpRCTpAR8pj2cvvVGI5/Jc5jCfMhqwrFJjrnG/rcOxZpc/nf/Pv98nTQwOX4
         SWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aqN/reM2FdnsWrwmKgOP0wEi0Ji2L+JRUBIFXRT3UXQ=;
        b=gt+SBioQOZnWIgr2EhZcQCD4N75tU8XDSt8b63azq9RFObbJ88aer3Xk5ipoImAq6c
         657xjGt4N5JtiBlLl5RpG/MLPdiSy1Sn+GJ2/pG/mkW+ns9dg8k/XawoRS5nvkTX2uuK
         /2wOHBPM33OMBMC0L8U1vt/9Tyi9v03mfItbBTOzvjBOiVR5HADXIXcKaVLwfW69kLXe
         tuZXEVd8d5PkaHuyk0hDtDBcdw7ljkvE6jZ9mNcX9qo6uviliVuSpfHClkbRHxPcVzF7
         LFSdRbwlkUr2YPJ5vSFjG4svtBMYxMcc/M/Sc71l9tf69hHOBLX4lnFnG+jkVUiL5VOj
         zs/w==
X-Gm-Message-State: APjAAAXK4mFBWb9CFYcvllKq0uAaeZsm39Fbkyg9ltu1MgV+9NLH0JxY
        YkL1ZvSElZF62/xHl+rtNs9fBJzsUEY=
X-Google-Smtp-Source: APXvYqwy1rOZuI3SgXy7Qt4hyDAEijWK6PTTLbmnT7ODHFwyjhp86BpOviMyNu2K30rfvswQrwjOFQ==
X-Received: by 2002:a2e:9f4c:: with SMTP id v12mr3558973ljk.167.1575520190856;
        Wed, 04 Dec 2019 20:29:50 -0800 (PST)
Received: from p.lan (95.246.92.34.bc.googleusercontent.com. [34.92.246.95])
        by smtp.gmail.com with ESMTPSA id c23sm4170865ljj.78.2019.12.04.20.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 20:29:50 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 08/10] btrfs-progs: pass @trans to functions touch dirty block groups
Date:   Thu,  5 Dec 2019 12:29:19 +0800
Message-Id: <20191205042921.25316-9-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191205042921.25316-1-Damenly_Su@gmx.com>
References: <20191205042921.25316-1-Damenly_Su@gmx.com>
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
index 981622e37ab7..f012fd5bf6b6 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -1877,9 +1877,10 @@ static int do_chunk_alloc(struct btrfs_trans_handle *trans,
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
@@ -2242,8 +2243,7 @@ static int __free_extent(struct btrfs_trans_handle *trans,
 			goto fail;
 		}
 
-		update_block_group(trans->fs_info, bytenr, num_bytes, 0,
-				   mark_free);
+		update_block_group(trans, bytenr, num_bytes, 0, mark_free);
 	}
 fail:
 	btrfs_free_path(path);
@@ -2575,7 +2575,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
-	ret = update_block_group(fs_info, ins.objectid, fs_info->nodesize, 1,
+	ret = update_block_group(trans, ins.objectid, fs_info->nodesize, 1,
 				 0);
 	if (sinfo) {
 		if (fs_info->nodesize > sinfo->bytes_reserved) {
@@ -3031,11 +3031,11 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
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
 
@@ -3449,12 +3449,12 @@ int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans)
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
@@ -3609,7 +3609,7 @@ static int __btrfs_record_file_extent(struct btrfs_trans_handle *trans,
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
2.21.0 (Apple Git-122)

