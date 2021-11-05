Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36414469B4
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbhKEUbn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbhKEUbm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:31:42 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E199C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:29:02 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id br39so9829968qkb.8
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GBu4Up2YwvhkYiY4yg+ZSqnyNbAG2s+mwkmhY+LJFV8=;
        b=usj6ZONSZiFzx0nYOK5hT1blJLbC6UP7B0ryc2x10I0WxgGP+qABv6F6xhVMX8MVgr
         Ore65LgkvA+60/An3gual6pCxmd4Q7Qg6LU0I1ce1/ZI/Fr0fewlA9c1Tp08C2GXJ0D+
         vofIwizYJhyCdirAQomWz4EKGG2B27DFgZWnXoSYx7C4iNfY6wTzTby0E9RY3F8gJJRu
         bpSUDRYnfc4hpmzKHz/pz1XYL7vRwgQB5LPJ37s//SZmeZOSSo/f/IlNXDORbQRa673I
         RGuotN4YxKyFr443rQY9SOUFLL8MT2LXjNqmgnp99Qei8k36SLmh52VeG64xtiWv0c0l
         Eh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GBu4Up2YwvhkYiY4yg+ZSqnyNbAG2s+mwkmhY+LJFV8=;
        b=umpFrRW0mtMkQhjn2WKO7F6K6YvrvQHfC3txnousA/gy3QkHVMMNlrhCDtm/3jCjFN
         8QNCR/Mkmm0gWlN3jBmjrjlQT4pbfMBamha2zc0HG67+eY5AvfgDAaPoh5TzUx8bwXXh
         DIkdA7GonHcHfsqa8lyRSrazEXVZTSZGS8eK1dJtkBc2JT4wVWQ+ak+CFZi2CZag5UV0
         48v60Ca3khWuJOXtplbTgHcPIieXXzqMsnEyA5WADkBUXkJSD/a5T73l7c5RqOlJFa31
         44vvko4hEsK7K8eAdyroxybRedqnIg8Vqzsqhx5TvZW7CgbTBaFHmfd/kg109oI7m9PO
         +i5Q==
X-Gm-Message-State: AOAM532pNEWjm2q0qucmB+nPCMH+dEsP7v3FdWfByyiZrIRJU/RXgszx
        TcY5Fdhw6NunxseFKyfyMx0w3Y41VNSw4Q==
X-Google-Smtp-Source: ABdhPJx5AWSCr8IhLK5QdSJigHpQpqdeKVgdD7+j4bJGTJ/V27XFm//bCHy37lymwFwZaRs8DpBZOw==
X-Received: by 2002:a05:620a:2954:: with SMTP id n20mr823839qkp.389.1636144140977;
        Fri, 05 Nov 2021 13:29:00 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u185sm5855407qkd.48.2021.11.05.13.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:29:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/20] btrfs-progs: common: move btrfs_fix_block_accounting to repair.c
Date:   Fri,  5 Nov 2021 16:28:34 -0400
Message-Id: <4b362a542b82036c83ec299e9c5ad5216d908484.1636143924.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636143924.git.josef@toxicpanda.com>
References: <cover.1636143924.git.josef@toxicpanda.com>
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
 kernel-shared/extent-tree.c | 74 ------------------------------------
 3 files changed, 76 insertions(+), 74 deletions(-)

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

