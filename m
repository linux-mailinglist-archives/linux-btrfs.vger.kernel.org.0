Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389B3449C71
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237400AbhKHT3v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237388AbhKHT3u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:29:50 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82E1C061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 11:27:05 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id bi29so16560466qkb.5
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 11:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FyFDtelHSHZT/aJD08xmOxdEwrRFKkS7RVfyFpKpacY=;
        b=nVqUz8G+h5qaJoAki4jIhBV6vxpysM4qAjarmI8Nj8qU47dIQ0itleKnuTV3oP6+Cm
         zFpsox0i0bXCdrwE4VeNDkdKMOe/zNkPRvWItLQukVQxSjQRyYUIRfqRsQADgvoqQ1Z4
         DEOdI1HheeBk1MrlQ9srEXibsHN5j8KdCsjjJgy1yG5vf8UOH1UEvnYbtQLwXzBc8z2G
         +Z+y2qyAyyqwMhH72yXdLoYP2SEErJpr3OyqmktdmKTlhoQSyVWgmUnKkyM/EEKEatdd
         ggySVC94k8j6o+vojU2FN7f4LjopMjYDb10XJ8rzZ7DYbhOIlucUYkwe46TXZ4at4dVu
         7d5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FyFDtelHSHZT/aJD08xmOxdEwrRFKkS7RVfyFpKpacY=;
        b=pHpdWKHaYuqdIkxN05pBfqSUBh69URuxKidZ9oEHXkrtXDK0op3the5kiLUMAwmoWI
         pZfzJaKohrnC5l5zrn6WC22zZ+/oGXsGEpl97QwZ702pbAYidfnkyqsHbLfeIXBl2eFd
         6Xf9xFNMjibIDroBd8ZOEngkHM/HUptQCV3+qkt8706qKA2P6EYGesVTAwfmI/qkaein
         W03etUcceOcbcUfE+3YKfNNUsRJHJXOdMHNOonWv3rdChl1Lg/jyTNh7D/lEcrFxpGRZ
         GYoiFmms93jy5AvfoGjo0X+U3Wd5Qj0Csld97mp3wbXIWF42oCqmbf+yDvPe0d5w9sgy
         w/+Q==
X-Gm-Message-State: AOAM533XsTiiZCCxcov3BX+TkZ2vHaXybKJl5QuXOvPcLh1pyc2LyKLl
        /uLiaekFiFA9tk3Ln8gFo9zfdOhDlNrfPQ==
X-Google-Smtp-Source: ABdhPJyqftm2AGWGGKJ9HvQJMPCOcccscMZSj6yH1cVNWaZuS0JW0ZMtgDNxh7/qjbp5ZC17GnI2fg==
X-Received: by 2002:a05:620a:2807:: with SMTP id f7mr1257385qkp.424.1636399624665;
        Mon, 08 Nov 2021 11:27:04 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bs34sm10329929qkb.97.2021.11.08.11.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:27:04 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 11/20] btrfs-progs: check: move btrfs_mark_used_tree_blocks to common
Date:   Mon,  8 Nov 2021 14:26:39 -0500
Message-Id: <caaf53eb8f4845adfce858c2b8c771e42744c326.1636399481.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636399481.git.josef@toxicpanda.com>
References: <cover.1636399481.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is going to be used for the extent tree v2 stuff more commonly, so
move it out so that it is accessible from everywhere that we need it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/mode-common.c | 102 -------------------------------------------
 common/repair.c     | 103 ++++++++++++++++++++++++++++++++++++++++++++
 common/repair.h     |   2 +
 3 files changed, 105 insertions(+), 102 deletions(-)

diff --git a/check/mode-common.c b/check/mode-common.c
index 3106902d..56377840 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -599,108 +599,6 @@ void reset_cached_block_groups()
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
index a5ba43e2..7ddecc42 100644
--- a/common/repair.c
+++ b/common/repair.c
@@ -18,6 +18,7 @@
 
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/transaction.h"
+#include "kernel-shared/disk-io.h"
 #include "common/extent-cache.h"
 #include "common/utils.h"
 #include "common/repair.h"
@@ -51,6 +52,108 @@ int btrfs_add_corrupt_extent_record(struct btrfs_fs_info *info,
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

