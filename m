Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8124C44CA2A
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhKJULR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhKJULQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:11:16 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E43C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:28 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id t83so1287670qke.8
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iEeFLIgECukQ50eQWQ54pELZiatzv75B6zbOTbiIN2o=;
        b=BdR4zXnZmcAZ9EX0RaWcst9oCnlBByybKt2Gh6WX4Onk6XWkRflx5CD7kWbXIKsyfE
         OE18+6Qeqbof8TU7T4xN7BGAJ4B1hp6j+AuAcHRg9b1FGJAuqZdEbac/r8OZXnpmYJNr
         4DeJNiJA6Q0PyPqqkPv7OpCFM/0r3codQKOhP7T0UDuW8hT0KWvZhBDkXeXx8q2ABvf6
         Jd6rpo5ky6umRlPwvJifSMVu7CUTuJRo2rpWFxydKwvAYOxqBqyRMzg3QX9xAhmptaUh
         9/jqR/XcvPFRzqxcQOlzj/BED21pHFrBG65MLbcmSlmwxdtm8poI+YiUo+zKJZUCCeNs
         24zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iEeFLIgECukQ50eQWQ54pELZiatzv75B6zbOTbiIN2o=;
        b=JJBvb9lcvDdc6lAJYOnunnXXkd4Gai3iN5S6dlnQSMcXX6tMlqFQ4FKccvN08KdfQ9
         h7q143jxFw82n7HZTwUq87K4NJ4hyNk4NnzD2E+lvIL3eG7FF29Y5jfJ2RyLGY5+DTDi
         CKxFQVhumxzltiVm1i4p8WZkIlsrCoYKIO36PKidaqP5lu4+xhHSLVJlfh8lzJ3TmeLT
         UDS9vtLre5RbJgQ1UL5qN69PJ94fI+9I4mW4FB/M6mkpDNOg8iWAHDGSo3XPEhp1rY5s
         dLeWGyvB0RH5evDj9/q4mfuiiw0uY1jdDq176aYPa2vSyjjwWGGJZKXMMsXuWRROTQEI
         8Emg==
X-Gm-Message-State: AOAM533KMlijFe+DLaKoPUNYT7xw//qnUMyqSosbyfio3KCehTW7t/KM
        yb6rUaf4NxxUnrYcjjSgcVYAIn2GIoiqPw==
X-Google-Smtp-Source: ABdhPJzNX/wrzyRTFw4NFYllJP5kSJ/jstO8V/f3iqZEqBCrG4YuWaNxpADpT/IpUADgZfV0iQmZXA==
X-Received: by 2002:a37:8946:: with SMTP id l67mr1669132qkd.519.1636574907859;
        Wed, 10 Nov 2021 12:08:27 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l21sm361802qkk.1.2021.11.10.12.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:08:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 12/13] btrfs-progs: check: move btrfs_mark_used_tree_blocks to common
Date:   Wed, 10 Nov 2021 15:08:03 -0500
Message-Id: <52fb08890dd65e9384c08b98816b6575aab81386.1636574767.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636574767.git.josef@toxicpanda.com>
References: <cover.1636574767.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is going to be used for the extent tree v2 stuff more commonly, so
move it out so that it is accessible from everywhere that we need it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/mode-common.c | 104 -------------------------------------------
 common/repair.c     | 105 ++++++++++++++++++++++++++++++++++++++++++++
 common/repair.h     |   2 +
 3 files changed, 107 insertions(+), 104 deletions(-)

diff --git a/check/mode-common.c b/check/mode-common.c
index 5dc41e8d..56377840 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -599,110 +599,6 @@ void reset_cached_block_groups()
 	}
 }
 
-static int traverse_tree_blocks(struct extent_io_tree *tree,
-				struct extent_buffer *eb, int tree_root)
-{
-	struct btrfs_fs_info *fs_info = eb->fs_info;
-	struct extent_buffer *tmp;
-	struct btrfs_root_item *ri;
-	struct btrfs_key key;
-	u64 bytenr;
-	int level = btrfs_header_level(eb);
-	int nritems;
-	int ret;
-	int i;
-	u64 end = eb->start + eb->len;
-	bool pin = tree == &fs_info->pinned_extents;
-
-	/*
-	 * If we have pinned/excluded this block before, don't do it again.
-	 * This can not only avoid forever loop with broken filesystem
-	 * but also give us some speedups.
-	 */
-	if (test_range_bit(tree, eb->start, end - 1, EXTENT_DIRTY, 0))
-		return 0;
-
-	if (pin)
-		btrfs_pin_extent(fs_info, eb->start, eb->len);
-	else
-		set_extent_dirty(tree, eb->start, end - 1);
-
-	nritems = btrfs_header_nritems(eb);
-	for (i = 0; i < nritems; i++) {
-		if (level == 0) {
-			bool is_extent_root;
-			btrfs_item_key_to_cpu(eb, &key, i);
-			if (key.type != BTRFS_ROOT_ITEM_KEY)
-				continue;
-			/* Skip the extent root and reloc roots */
-			if (key.objectid == BTRFS_TREE_RELOC_OBJECTID ||
-			    key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID)
-				continue;
-			is_extent_root =
-				key.objectid == BTRFS_EXTENT_TREE_OBJECTID;
-			/* If pin, skip the extent root */
-			if (pin && is_extent_root)
-				continue;
-			ri = btrfs_item_ptr(eb, i, struct btrfs_root_item);
-			bytenr = btrfs_disk_root_bytenr(eb, ri);
-
-			/*
-			 * If at any point we start needing the real root we
-			 * will have to build a stump root for the root we are
-			 * in, but for now this doesn't actually use the root so
-			 * just pass in extent_root.
-			 */
-			tmp = read_tree_block(fs_info, bytenr, 0);
-			if (!extent_buffer_uptodate(tmp)) {
-				fprintf(stderr, "Error reading root block\n");
-				return -EIO;
-			}
-			ret = traverse_tree_blocks(tree, tmp, 0);
-			free_extent_buffer(tmp);
-			if (ret)
-				return ret;
-		} else {
-			u64 end;
-
-			bytenr = btrfs_node_blockptr(eb, i);
-			end = bytenr + fs_info->nodesize - 1;
-
-			/* If we aren't the tree root don't read the block */
-			if (level == 1 && !tree_root) {
-				if (pin)
-					btrfs_pin_extent(fs_info, bytenr,
-							 fs_info->nodesize);
-				else
-					set_extent_dirty(tree, bytenr, end);
-				continue;
-			}
-
-			tmp = read_tree_block(fs_info, bytenr, 0);
-			if (!extent_buffer_uptodate(tmp)) {
-				fprintf(stderr, "Error reading tree block\n");
-				return -EIO;
-			}
-			ret = traverse_tree_blocks(tree, tmp, tree_root);
-			free_extent_buffer(tmp);
-			if (ret)
-				return ret;
-		}
-	}
-
-	return 0;
-}
-
-int btrfs_mark_used_tree_blocks(struct btrfs_fs_info *fs_info,
-				struct extent_io_tree *tree)
-{
-	int ret;
-
-	ret = traverse_tree_blocks(tree, fs_info->chunk_root->node, 0);
-	if (!ret)
-		ret = traverse_tree_blocks(tree, fs_info->tree_root->node, 1);
-	return ret;
-}
-
 int pin_metadata_blocks(void)
 {
 	return btrfs_mark_used_tree_blocks(gfs_info,
diff --git a/common/repair.c b/common/repair.c
index a5ba43e2..e30fd8e8 100644
--- a/common/repair.c
+++ b/common/repair.c
@@ -18,6 +18,7 @@
 
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/transaction.h"
+#include "kernel-shared/disk-io.h"
 #include "common/extent-cache.h"
 #include "common/utils.h"
 #include "common/repair.h"
@@ -51,6 +52,110 @@ int btrfs_add_corrupt_extent_record(struct btrfs_fs_info *info,
 	return ret;
 }
 
+static int traverse_tree_blocks(struct extent_io_tree *tree,
+				struct extent_buffer *eb, int tree_root)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct extent_buffer *tmp;
+	struct btrfs_root_item *ri;
+	struct btrfs_key key;
+	u64 bytenr;
+	int level = btrfs_header_level(eb);
+	int nritems;
+	int ret;
+	int i;
+	u64 end = eb->start + eb->len;
+	bool pin = tree == &fs_info->pinned_extents;
+
+	/*
+	 * If we have pinned/excluded this block before, don't do it again.
+	 * This can not only avoid forever loop with broken filesystem
+	 * but also give us some speedups.
+	 */
+	if (test_range_bit(tree, eb->start, end - 1, EXTENT_DIRTY, 0))
+		return 0;
+
+	if (pin)
+		btrfs_pin_extent(fs_info, eb->start, eb->len);
+	else
+		set_extent_dirty(tree, eb->start, end - 1);
+
+	nritems = btrfs_header_nritems(eb);
+	for (i = 0; i < nritems; i++) {
+		if (level == 0) {
+			bool is_extent_root;
+			btrfs_item_key_to_cpu(eb, &key, i);
+			if (key.type != BTRFS_ROOT_ITEM_KEY)
+				continue;
+			/* Skip the extent root and reloc roots */
+			if (key.objectid == BTRFS_TREE_RELOC_OBJECTID ||
+			    key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID)
+				continue;
+			is_extent_root =
+				key.objectid == BTRFS_EXTENT_TREE_OBJECTID;
+			/* If pin, skip the extent root */
+			if (pin && is_extent_root)
+				continue;
+			ri = btrfs_item_ptr(eb, i, struct btrfs_root_item);
+			bytenr = btrfs_disk_root_bytenr(eb, ri);
+
+			/*
+			 * If at any point we start needing the real root we
+			 * will have to build a stump root for the root we are
+			 * in, but for now this doesn't actually use the root so
+			 * just pass in extent_root.
+			 */
+			tmp = read_tree_block(fs_info, bytenr, 0);
+			if (!extent_buffer_uptodate(tmp)) {
+				fprintf(stderr, "Error reading root block\n");
+				return -EIO;
+			}
+			ret = traverse_tree_blocks(tree, tmp, 0);
+			free_extent_buffer(tmp);
+			if (ret)
+				return ret;
+		} else {
+			u64 end;
+
+			bytenr = btrfs_node_blockptr(eb, i);
+			end = bytenr + fs_info->nodesize - 1;
+
+			/* If we aren't the tree root don't read the block */
+			if (level == 1 && !tree_root) {
+				if (pin)
+					btrfs_pin_extent(fs_info, bytenr,
+							 fs_info->nodesize);
+				else
+					set_extent_dirty(tree, bytenr, end);
+				continue;
+			}
+
+			tmp = read_tree_block(fs_info, bytenr, 0);
+			if (!extent_buffer_uptodate(tmp)) {
+				fprintf(stderr, "Error reading tree block\n");
+				return -EIO;
+			}
+			ret = traverse_tree_blocks(tree, tmp, tree_root);
+			free_extent_buffer(tmp);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+int btrfs_mark_used_tree_blocks(struct btrfs_fs_info *fs_info,
+				struct extent_io_tree *tree)
+{
+	int ret;
+
+	ret = traverse_tree_blocks(tree, fs_info->chunk_root->node, 0);
+	if (!ret)
+		ret = traverse_tree_blocks(tree, fs_info->tree_root->node, 1);
+	return ret;
+}
+
 /*
  * Fixup block accounting. The initial block accounting created by
  * make_block_groups isn't accuracy in this case.
diff --git a/common/repair.h b/common/repair.h
index 4e1fa3e7..793ebcd2 100644
--- a/common/repair.h
+++ b/common/repair.h
@@ -33,5 +33,7 @@ int btrfs_add_corrupt_extent_record(struct btrfs_fs_info *info,
 				    struct btrfs_key *first_key,
 				    u64 start, u64 len, int level);
 int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans);
+int btrfs_mark_used_tree_blocks(struct btrfs_fs_info *fs_info,
+				struct extent_io_tree *tree);
 
 #endif
-- 
2.26.3

