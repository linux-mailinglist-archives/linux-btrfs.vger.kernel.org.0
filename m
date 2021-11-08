Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C62E449C6F
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237387AbhKHT3s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbhKHT3r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:29:47 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276E3C061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 11:27:03 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id m17so451428qvx.8
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 11:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7RY/YOCb0W1+HHotGMczsLaAbx0QN9PK7ZoRd75QJoQ=;
        b=3H6Ynsimepjgg3uzkoCQqBXk5j/IsIUdlUEBk/+1F6UGpevvsIQFimgojytfOYq+VX
         Sj9gKa4+of3H+UB408WoOan4EuHs+AXm8W+O3rj+xxA1DlyUKyPz9LPtrUHpplz2VSrW
         a4Yl9eo8JHu2D7TeONtBSH4IllSs3A9AOM9WcWotkPQcO8ZKT7yDIlcXYk3pf/A+jicH
         nZLOKR80aiAYyeMnD6sc/79kO6frUYOVSTE+wNI5gcOPBsZZehKq25EXzady/UGXVCgv
         9NTiyGjkcC1T3gdEhROjdag+qBaepstsSQlmNPIC8DfIo+YLGGl6d44oUbqnJdaL9Udp
         fBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7RY/YOCb0W1+HHotGMczsLaAbx0QN9PK7ZoRd75QJoQ=;
        b=K/BTGVnnZTTE+S+5+Pyr548AwnfFb8vjqd0ldmQnZ5IUbqJS71kKUK2HO6yAlf6Boc
         Rpf2AO8gm5zPJ8vImlaSVYwSg4d5Oall9OQ8eHt4TXABkXp9gBJYYhjafKyhDL11VA+F
         0D+lF/i1IQYcv1KtUlOYzRPFliPzqMJRD89hmgkrpfdYIbIjKpq4rdx39AZiwquc0LdG
         TfOaDnRiUVCA+mZY2AKCm1ubrAEVYERnS0nA0rJ2C3zExSivhI+YFYAhZbmR3Y/CeDbZ
         GudTtnwD9I+RjlbeaRTmLZ2s0/I1KiIqKh7wma63VwRlMH6oLoTTr+yTsIKL9pIzLI+6
         xn6g==
X-Gm-Message-State: AOAM531GzoTa2PS8EpgrTcGZOEv8gzg5Na2mlBGrFKTkiaeYXXWR2vT1
        FRTZ0emAxlW+wjfbi9ltcqL1faTNOQUgXQ==
X-Google-Smtp-Source: ABdhPJyVuXlb8FyiirOsggVRY1L/QKi8MV92P2slLF9UEYeFpq3nZISFlTcTeZK0aMTAUx53R5HSvQ==
X-Received: by 2002:a05:6214:1c4a:: with SMTP id if10mr1384601qvb.13.1636399621988;
        Mon, 08 Nov 2021 11:27:01 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n13sm7305515qkh.34.2021.11.08.11.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:27:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 09/20] btrfs-progs: common: move btrfs_fix_block_accounting to repair.c
Date:   Mon,  8 Nov 2021 14:26:37 -0500
Message-Id: <5d918c6810c90a90a3b78478da8413d48c234239.1636399481.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636399481.git.josef@toxicpanda.com>
References: <cover.1636399481.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have this helper sitting in extent-tree.c, but it's a repair
function.  I'm going to need to make changes to this for extent-tree-v2
and would rather this live outside of the code we need to share with the
kernel.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/repair.c             | 75 +++++++++++++++++++++++++++++++++++++
 common/repair.h             |  1 +
 convert/main.c              |  1 +
 kernel-shared/extent-tree.c | 74 ------------------------------------
 4 files changed, 77 insertions(+), 74 deletions(-)

diff --git a/common/repair.c b/common/repair.c
index 6eed7cec..a5ba43e2 100644
--- a/common/repair.c
+++ b/common/repair.c
@@ -17,6 +17,7 @@
  */
 
 #include "kernel-shared/ctree.h"
+#include "kernel-shared/transaction.h"
 #include "common/extent-cache.h"
 #include "common/utils.h"
 #include "common/repair.h"
@@ -50,3 +51,77 @@ int btrfs_add_corrupt_extent_record(struct btrfs_fs_info *info,
 	return ret;
 }
 
+/*
+ * Fixup block accounting. The initial block accounting created by
+ * make_block_groups isn't accuracy in this case.
+ */
+int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans)
+{
+	int ret = 0;
+	int slot;
+	u64 start = 0;
+	u64 bytes_used = 0;
+	struct btrfs_path path;
+	struct btrfs_key key;
+	struct extent_buffer *leaf;
+	struct btrfs_block_group *cache;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *root = fs_info->extent_root;
+
+	ret = btrfs_run_delayed_refs(trans, -1);
+	if (ret)
+		return ret;
+
+	while(1) {
+		cache = btrfs_lookup_first_block_group(fs_info, start);
+		if (!cache)
+			break;
+
+		start = cache->start + cache->length;
+		cache->used = 0;
+		cache->space_info->bytes_used = 0;
+		if (list_empty(&cache->dirty_list))
+			list_add_tail(&cache->dirty_list, &trans->dirty_bgs);
+	}
+
+	btrfs_init_path(&path);
+	key.offset = 0;
+	key.objectid = 0;
+	key.type = BTRFS_EXTENT_ITEM_KEY;
+	ret = btrfs_search_slot(trans, root->fs_info->extent_root,
+				&key, &path, 0, 0);
+	if (ret < 0)
+		return ret;
+	while(1) {
+		leaf = path.nodes[0];
+		slot = path.slots[0];
+		if (slot >= btrfs_header_nritems(leaf)) {
+			ret = btrfs_next_leaf(root, &path);
+			if (ret < 0)
+				return ret;
+			if (ret > 0)
+				break;
+			leaf = path.nodes[0];
+			slot = path.slots[0];
+		}
+		btrfs_item_key_to_cpu(leaf, &key, slot);
+		if (key.type == BTRFS_EXTENT_ITEM_KEY) {
+			bytes_used += key.offset;
+			ret = btrfs_update_block_group(trans,
+				  key.objectid, key.offset, 1, 0);
+			BUG_ON(ret);
+		} else if (key.type == BTRFS_METADATA_ITEM_KEY) {
+			bytes_used += fs_info->nodesize;
+			ret = btrfs_update_block_group(trans,
+				  key.objectid, fs_info->nodesize, 1, 0);
+			if (ret)
+				goto out;
+		}
+		path.slots[0]++;
+	}
+	btrfs_set_super_bytes_used(root->fs_info->super_copy, bytes_used);
+	ret = 0;
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
diff --git a/common/repair.h b/common/repair.h
index d1794610..4e1fa3e7 100644
--- a/common/repair.h
+++ b/common/repair.h
@@ -32,5 +32,6 @@ struct btrfs_corrupt_block {
 int btrfs_add_corrupt_extent_record(struct btrfs_fs_info *info,
 				    struct btrfs_key *first_key,
 				    u64 start, u64 len, int level);
+int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans);
 
 #endif
diff --git a/convert/main.c b/convert/main.c
index 7f33d4e1..d480f166 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -109,6 +109,7 @@
 #include "common/device-scan.h"
 #include "common/box.h"
 #include "common/open-utils.h"
+#include "common/repair.h"
 
 extern const struct btrfs_convert_operations ext2_convert_ops;
 extern const struct btrfs_convert_operations reiserfs_convert_ops;
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index a918e5aa..402904d1 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -3247,80 +3247,6 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-/*
- * Fixup block accounting. The initial block accounting created by
- * make_block_groups isn't accuracy in this case.
- */
-int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans)
-{
-	int ret = 0;
-	int slot;
-	u64 start = 0;
-	u64 bytes_used = 0;
-	struct btrfs_path path;
-	struct btrfs_key key;
-	struct extent_buffer *leaf;
-	struct btrfs_block_group *cache;
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *root = fs_info->extent_root;
-
-	ret = btrfs_run_delayed_refs(trans, -1);
-	if (ret)
-		return ret;
-
-	while(1) {
-		cache = btrfs_lookup_first_block_group(fs_info, start);
-		if (!cache)
-			break;
-
-		start = cache->start + cache->length;
-		cache->used = 0;
-		cache->space_info->bytes_used = 0;
-		if (list_empty(&cache->dirty_list))
-			list_add_tail(&cache->dirty_list, &trans->dirty_bgs);
-	}
-
-	btrfs_init_path(&path);
-	key.offset = 0;
-	key.objectid = 0;
-	key.type = BTRFS_EXTENT_ITEM_KEY;
-	ret = btrfs_search_slot(trans, root->fs_info->extent_root,
-				&key, &path, 0, 0);
-	if (ret < 0)
-		return ret;
-	while(1) {
-		leaf = path.nodes[0];
-		slot = path.slots[0];
-		if (slot >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(root, &path);
-			if (ret < 0)
-				return ret;
-			if (ret > 0)
-				break;
-			leaf = path.nodes[0];
-			slot = path.slots[0];
-		}
-		btrfs_item_key_to_cpu(leaf, &key, slot);
-		if (key.type == BTRFS_EXTENT_ITEM_KEY) {
-			bytes_used += key.offset;
-			ret = btrfs_update_block_group(trans,
-				  key.objectid, key.offset, 1, 0);
-			BUG_ON(ret);
-		} else if (key.type == BTRFS_METADATA_ITEM_KEY) {
-			bytes_used += fs_info->nodesize;
-			ret = btrfs_update_block_group(trans,
-				  key.objectid, fs_info->nodesize, 1, 0);
-			if (ret)
-				goto out;
-		}
-		path.slots[0]++;
-	}
-	btrfs_set_super_bytes_used(root->fs_info->super_copy, bytes_used);
-	ret = 0;
-out:
-	btrfs_release_path(&path);
-	return ret;
-}
 
 static void __get_extent_size(struct btrfs_root *root, struct btrfs_path *path,
 			      u64 *start, u64 *len)
-- 
2.26.3

