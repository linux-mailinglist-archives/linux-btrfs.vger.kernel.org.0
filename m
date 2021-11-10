Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B9544CA28
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhKJULN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhKJULM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:11:12 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796BBC061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:24 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id jo22so2607410qvb.13
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7RY/YOCb0W1+HHotGMczsLaAbx0QN9PK7ZoRd75QJoQ=;
        b=uHal7nGFYmljRENS5JMLjezYQobk8MMObI+wgjNi3PyXkjTVckc8ehiS7qbZyARYFE
         F+aeZ1pjPdLcUdViASJ9e2F4+7+597Hr7Vk0B+qPb6bt1phnF8TDK5LiHedJ9BOru8jC
         7zkfVfjLZoGJrv4yyCEKP7Gx46+wgzlDKd+BU3ru+qc1tjTIlRZx4+8r1zt9EPs74oS0
         H8Y/ke+VxtuY9CAh52gZdvxhTKbZ2W+0/BKhsDDKN+Kw1DaELbFM1SeaN8yuQ5i+5nhr
         BzqTKyhUO5CzFKAralp0YGDD8bO49qRl+B6gWr6T9z1p1tYEGnDvpzbQH59lwlwfDAdj
         nrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7RY/YOCb0W1+HHotGMczsLaAbx0QN9PK7ZoRd75QJoQ=;
        b=I+DYtcSMmw0+DCmXA3n1H0rBicknurLobSiqk+wPX6U+Oq7rzg0DhhM9SLvfEDpH1A
         7A+8v0XpkgGQ8Gpf3YnIvpC6mHJJPxDuuD/qOvzLieScR5HP8haAsle+q0GjjwIDt6Iz
         i2CM35PcbFwrmq7NztOaUueHCX7qEih6C+tGXHDrNiq0/ulZFM0h3IvppPeX3qWJjwtd
         dpV7DhEunCXpD49W2zYpOgJ3aCGfkm7EJIt4gfO8LQ/KjNBM4plyERM+0+7sqd9wtrWn
         C8IRkBSONwc55Y9+3wDI2N3AdGFmrXJ9Ot2c6JcwOwMX+n58ZmjJKE+xFmTc3HezeZ7d
         BJ6g==
X-Gm-Message-State: AOAM5334y2js82nbiDhMwKTMBhbKZvEsjaqgdKgIoRFB7Pofo1qxVgez
        qpRJAteDMeHt5Pke+9YYFjb7xRcS52fLZw==
X-Google-Smtp-Source: ABdhPJzyC/zuEwvGbCTf1Qz6IYNVBQdYNQNjqa17zhpVUWaRHO9Dz4HD2FTBhyvxdl3BNE7aJfWnjA==
X-Received: by 2002:a05:6214:174d:: with SMTP id dc13mr1316205qvb.7.1636574903319;
        Wed, 10 Nov 2021 12:08:23 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s13sm518646qtw.33.2021.11.10.12.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:08:22 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 10/13] btrfs-progs: common: move btrfs_fix_block_accounting to repair.c
Date:   Wed, 10 Nov 2021 15:08:01 -0500
Message-Id: <b3ff5161cd5016944e4eeb2048f5ff34de7a694b.1636574767.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636574767.git.josef@toxicpanda.com>
References: <cover.1636574767.git.josef@toxicpanda.com>
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

