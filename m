Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B5C476398
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbhLOUnv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbhLOUnv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:43:51 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEDBC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:43:50 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id kl7so4574432qvb.3
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nc8GUzJ5TOIDoboT49CgI0t+FNED0KvqaLsWolxle94=;
        b=bApTJyuKyP0EdWuTqzrd1lJFG/H6ii9JzlKTYUy/64/RXqRDDNLitn7fSeOsjysE7Y
         4tYsgoE9S/I4rKkM1bW/juuhkPllvTOa8c9D3eAa+4002fp8840m2nz+rE6a3jIOOjYi
         EtuUw+P5eyn0zVMnxNmZeVNbxqKDvPLUTjrVN3nt6P0LDGFAG03TLUCXDBsCfcGkKZbn
         5UCKxFzJPNqnxbQ7QAfTP2zKytHQe5xTulcAEoIb4WngzHZq4HHfX17JqDwEu/pFBElz
         W3pQAbio9dCHPxxNcWX3I+SqQEZYojwCp71B8QBojE/WMr658ZJBOcgpL1X9mZoyPCL6
         HaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nc8GUzJ5TOIDoboT49CgI0t+FNED0KvqaLsWolxle94=;
        b=74rkwSMDtPZNP1j1B1do29XZ89MM/dYmKEoMBtN7F8ZFORRwm3eA7DPfpOXhTAau8f
         lKbfddijAxhBPqdHMaAwayLzytD3blVLv3LTgTWfnucU4PO3gf+7xJ3NvvZjqrt2FUZU
         DulJpI4qwgokiHM+StlVHqaO0n4yC1YTtl7WQCpv5vUvJ0nZy7NLVQDJiZJb4/rmNBmE
         oC3F5t+JSmAe8IBatDd8mr8QORtMZgsVvNJbh76d4WiXiofN07uOcx13StrQDVta76TI
         jHbsdn3qV13oHhETAQdTX5+ysSRn6a30riWkLSGcwCl/B/3VQiV/GuQ/3uUQXMZlinvy
         sjzA==
X-Gm-Message-State: AOAM531XUT64qJKk+V+TL82uI9xWGbnzKkl8EceukcB8eF7Yox4IZhAI
        weFozm3R/QaC6YHpm5h7XHkpO5wb18bwVg==
X-Google-Smtp-Source: ABdhPJz9wCaBpGzY/7SS9X3x/Q9cbgafLxFgt9ptxacPUWTeDVR7mAQOqSLCeO5xy9hKqYF3b7qq/A==
X-Received: by 2002:ad4:5de2:: with SMTP id jn2mr57101qvb.34.1639601029666;
        Wed, 15 Dec 2021 12:43:49 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g21sm2407581qtb.62.2021.12.15.12.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:43:49 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/9] btrfs: add a alloc_reserved_extent helper
Date:   Wed, 15 Dec 2021 15:43:38 -0500
Message-Id: <6b2f4b1d6bc5dab1627efc532875c970c4259822.1639600854.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639600854.git.josef@toxicpanda.com>
References: <cover.1639600854.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We duplicate this logic for both data and metadata, at this point we've
already done our type specific extent root operations, this is just
doing the accounting and removing the space from the free space tree.
Extract this common logic out into a helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 56 ++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3715ee1f0a08..832cbcd52fea 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4605,6 +4605,28 @@ int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans, u64 start,
 	return ret;
 }
 
+static int alloc_reserved_extent(struct btrfs_trans_handle *trans, u64 bytenr,
+				 u64 num_bytes)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	int ret;
+
+	ret = remove_from_free_space_tree(trans, bytenr, num_bytes);
+	if (ret)
+		return ret;
+
+	ret = btrfs_update_block_group(trans, bytenr, num_bytes, true);
+	if (ret) {
+		ASSERT(!ret);
+		btrfs_err(fs_info, "update block group failed for %llu %llu",
+			  bytenr, num_bytes);
+		return ret;
+	}
+
+	trace_btrfs_reserved_extent_alloc(fs_info, bytenr, num_bytes);
+	return 0;
+}
+
 static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 				      u64 parent, u64 root_objectid,
 				      u64 flags, u64 owner, u64 offset,
@@ -4665,18 +4687,7 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(path->nodes[0]);
 	btrfs_free_path(path);
 
-	ret = remove_from_free_space_tree(trans, ins->objectid, ins->offset);
-	if (ret)
-		return ret;
-
-	ret = btrfs_update_block_group(trans, ins->objectid, ins->offset, true);
-	if (ret) { /* -ENOENT, logic error */
-		btrfs_err(fs_info, "update block group failed for %llu %llu",
-			ins->objectid, ins->offset);
-		BUG();
-	}
-	trace_btrfs_reserved_extent_alloc(fs_info, ins->objectid, ins->offset);
-	return ret;
+	return alloc_reserved_extent(trans, ins->objectid, ins->offset);
 }
 
 static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
@@ -4694,7 +4705,6 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	struct btrfs_delayed_tree_ref *ref;
 	u32 size = sizeof(*extent_item) + sizeof(*iref);
-	u64 num_bytes;
 	u64 flags = extent_op->flags_to_set;
 	bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
 
@@ -4704,12 +4714,10 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	if (skinny_metadata) {
 		extent_key.offset = ref->level;
 		extent_key.type = BTRFS_METADATA_ITEM_KEY;
-		num_bytes = fs_info->nodesize;
 	} else {
 		extent_key.offset = node->num_bytes;
 		extent_key.type = BTRFS_EXTENT_ITEM_KEY;
 		size += sizeof(*block_info);
-		num_bytes = node->num_bytes;
 	}
 
 	path = btrfs_alloc_path();
@@ -4754,23 +4762,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_free_path(path);
 
-	ret = remove_from_free_space_tree(trans, extent_key.objectid,
-					  num_bytes);
-	if (ret)
-		return ret;
-
-	ret = btrfs_update_block_group(trans, extent_key.objectid,
-				       fs_info->nodesize, true);
-	if (ret) { /* -ENOENT, logic error */
-		ASSERT(!ret);
-		btrfs_err(fs_info, "update block group failed for %llu %llu",
-			extent_key.objectid, extent_key.offset);
-		return ret;
-	}
-
-	trace_btrfs_reserved_extent_alloc(fs_info, extent_key.objectid,
-					  fs_info->nodesize);
-	return ret;
+	return alloc_reserved_extent(trans, node->bytenr, fs_info->nodesize);
 }
 
 int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
-- 
2.26.3

