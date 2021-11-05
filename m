Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AE34469B7
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbhKEUbq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbhKEUbp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:31:45 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA55C061208
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:29:05 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id az8so9855884qkb.2
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AeGaew/7bqXabc14uImNpcOrMVeZQ34696/bJfWqizM=;
        b=fUTo2LtVj78nF3cp6zaBLaNZfE898Hwr72EI4Oxl5NhW7yYyVEIIW9crcMQ4UL0sBf
         Kw4ytzyEOGr3hAjWvCGF+McvaKu5HzAd8jbJFNyAmPRrkBCcAD0oh80kjyIKhQ0DiwNI
         Z0QfDnfnGCIgTmWdtb89d6PENv9YZVcQAlzTQrchu/7/Mlw+OSlenZdxEoCEpDCq22v9
         JxOSH6bN8GZit2fvEQD9CD9ePfBIvri1VzyOJusxW5I57jcr1FnLXdKPOJg4wMRcewFD
         6Bh1+Td8Aoie53TYSJbHDis960Pew1PyqWMROFv/Zj+VSuG7lSdPMldrRVd5TMGLzrgO
         9gwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AeGaew/7bqXabc14uImNpcOrMVeZQ34696/bJfWqizM=;
        b=Sn6MlaGJhIpoz8JbQb4LsQpheAQaLeNI4C+nYyc7XtRuwZVdrL7g7oWU4PycmmODGG
         +vHj2aF2DQyMUjHVTt45LcIwuNFtu9UshWJBxQau0hNC1U7b5luR9jF3Ey4MpQOmuKT3
         V6a4VOhb67bEeWy0m3uashNeu43d9dkpEkmgli8LuVQmEtb+bmO9MRniLgJXz6CsfatZ
         bixusrY2VcuohbOO2BkHoWLJrt8NTQx33WDqd/aV+MW9yGpFxn6uo4ZdAw02yQT65a+W
         goTc+p1AO3m71PRB9S3FZqs/GHuqDJ5jh3QP92STJl71jcoz5WahjYl06x9LH0yHxjdV
         7Ngg==
X-Gm-Message-State: AOAM531bWCGYS/tEnatcUpQy25NgZ4Bapwk2DQg9jBDi2zpcESwgCuXV
        Kc7+1b5CxT5ZTHN3MPMsEGjIT4F/B7kVnA==
X-Google-Smtp-Source: ABdhPJx4M56zX2jY+JTipktfjyxcwY+AKy8z1QuMrdrP4vQXRYpeCZdMSDlzAQGojoTofsXYgWtLTQ==
X-Received: by 2002:a05:620a:1990:: with SMTP id bm16mr37532977qkb.159.1636144143975;
        Fri, 05 Nov 2021 13:29:03 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u8sm6463850qkp.21.2021.11.05.13.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:29:03 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/20] btrfs-progs: check: move btrfs_mark_used_tree_blocks to common
Date:   Fri,  5 Nov 2021 16:28:36 -0400
Message-Id: <df67538393e5d71fc33ddebbd479f7ad450ec30d.1636143924.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636143924.git.josef@toxicpanda.com>
References: <cover.1636143924.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is going to be used for the extent tree v2 stuff more commonly, so
move it out so that it is accessible from everywhere that we need it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/mode-common.c | 105 -------------------------------------------
 common/repair.c     | 106 ++++++++++++++++++++++++++++++++++++++++++++
 common/repair.h     |   2 +
 3 files changed, 108 insertions(+), 105 deletions(-)

diff --git a/check/mode-common.c b/check/mode-common.c
index a4a09714..56377840 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -599,111 +599,6 @@ void reset_cached_block_groups()
 	}
 }
 
-static int traverse_tree_blocks(struct btrfs_fs_info *fs_info,
-				struct extent_io_tree *tree,
-				struct extent_buffer *eb, int tree_root)
-{
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
-			ret = traverse_tree_blocks(fs_info, tree, tmp, 0);
-			free_extent_buffer(tmp);
-			if (ret)
-				return ret;
-		} else {
-			bytenr = btrfs_node_blockptr(eb, i);
-
-			/* If we aren't the tree root don't read the block */
-			if (level == 1 && !tree_root) {
-				if (pin)
-					btrfs_pin_extent(fs_info, bytenr,
-							 fs_info->nodesize);
-				else
-					set_extent_dirty(tree, bytenr,
-							 fs_info->nodesize);
-				continue;
-			}
-
-			tmp = read_tree_block(fs_info, bytenr, 0);
-			if (!extent_buffer_uptodate(tmp)) {
-				fprintf(stderr, "Error reading tree block\n");
-				return -EIO;
-			}
-			ret = traverse_tree_blocks(fs_info, tree, tmp,
-						   tree_root);
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
-	ret = traverse_tree_blocks(fs_info, tree,
-				   fs_info->chunk_root->node, 0);
-	if (!ret)
-		ret = traverse_tree_blocks(fs_info, tree,
-					   fs_info->tree_root->node, 1);
-	return ret;
-}
-
 int pin_metadata_blocks(void)
 {
 	return btrfs_mark_used_tree_blocks(gfs_info,
diff --git a/common/repair.c b/common/repair.c
index a5ba43e2..79519140 100644
--- a/common/repair.c
+++ b/common/repair.c
@@ -18,6 +18,7 @@
 
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/transaction.h"
+#include "kernel-shared/disk-io.h"
 #include "common/extent-cache.h"
 #include "common/utils.h"
 #include "common/repair.h"
@@ -51,6 +52,111 @@ int btrfs_add_corrupt_extent_record(struct btrfs_fs_info *info,
 	return ret;
 }
 
+static int traverse_tree_blocks(struct btrfs_fs_info *fs_info,
+				struct extent_io_tree *tree,
+				struct extent_buffer *eb, int tree_root)
+{
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
+			ret = traverse_tree_blocks(fs_info, tree, tmp, 0);
+			free_extent_buffer(tmp);
+			if (ret)
+				return ret;
+		} else {
+			bytenr = btrfs_node_blockptr(eb, i);
+
+			/* If we aren't the tree root don't read the block */
+			if (level == 1 && !tree_root) {
+				if (pin)
+					btrfs_pin_extent(fs_info, bytenr,
+							 fs_info->nodesize);
+				else
+					set_extent_dirty(tree, bytenr,
+							 fs_info->nodesize);
+				continue;
+			}
+
+			tmp = read_tree_block(fs_info, bytenr, 0);
+			if (!extent_buffer_uptodate(tmp)) {
+				fprintf(stderr, "Error reading tree block\n");
+				return -EIO;
+			}
+			ret = traverse_tree_blocks(fs_info, tree, tmp,
+						   tree_root);
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
+	ret = traverse_tree_blocks(fs_info, tree,
+				   fs_info->chunk_root->node, 0);
+	if (!ret)
+		ret = traverse_tree_blocks(fs_info, tree,
+					   fs_info->tree_root->node, 1);
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

