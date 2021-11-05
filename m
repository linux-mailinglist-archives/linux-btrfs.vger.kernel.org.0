Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EC94469E0
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbhKEUny (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbhKEUnw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:43:52 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DF4C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:41:12 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d21so8285501qtw.11
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ARHRe7EzU08RbrofPgn4nDVLlnjVMvpSfrA7E4kkZnQ=;
        b=CFW+qWxYyBlRtoTRWYb+ZszB2XgDFI2+g7d8YZSxgF4SMkfaXRXAtiW/JGLUhBj5J+
         gvu2AR9D1E4ITm1zhSLJ2yxqqSDsrmInkW9XmSG6y03RFZ/UTwWyy3shvdjKw6MarVIJ
         BQ7IZuia2ouoeB55buz+iFWhYhIdxhPB0MV93YqYroRKcqK6OSWU6Ht6Gq7kXqo4EqxW
         oVHi1WsGS86g4PkSZdBQie23Z80t4wyLKvSWhMlM1sGwg57P51J8vm+EEuI7LYoK6Imx
         fHnNxKxlblXPKFercpw3zSRrF5B0zOsXUfRH0L7RmFmGfFQl7M6N2o2R3Hlp0doq0pyV
         OK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ARHRe7EzU08RbrofPgn4nDVLlnjVMvpSfrA7E4kkZnQ=;
        b=doedjhH0/AWK+Yb9RBefL2ufw90qlVuxA/UXYvGY+AeQkzm6KhqFcmDJHHST8Lbzd/
         feQ6ZtriaPLSmHmGcat6Z/K4YUO42Mnf4n+zBQQuaHlVrpU/YAxluoMyv8WsSJrLgM07
         OvS21agGKMnke1l18PpRK85aLnhKgKoLS3nHwBOeICjztPgBD6Ll+5w+2rhhfTXPqFql
         TEmnsd7Ni3UglKAAU1PAt12cD5Y0O1RreqmPASCYC0xuS24b7+68+nd3iF61pYEfjUSQ
         2hYbtXwdEdTn8g/tFYNdpr/AhRmIh6c0L6MywFvHiVtXyKxwhXo2OZnX/PJo4SA2Kn9o
         YZ0g==
X-Gm-Message-State: AOAM530IuU44+CWoLl+62ERWqBQUk/OI6Fehd/zIkJ4+0OSmB7o5obC8
        85eqyy2aLpJTYGEUjO+Xm4jbpzM7Z47mng==
X-Google-Smtp-Source: ABdhPJzzFOt1knpGqye05fr8ID+CghTMN+UDgP4yel0Z0BQBmQ3wJy3Qe9i9YzsfZj8hcai0FWno5A==
X-Received: by 2002:a05:622a:607:: with SMTP id z7mr28852453qta.237.1636144871195;
        Fri, 05 Nov 2021 13:41:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e14sm672763qty.18.2021.11.05.13.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:41:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 16/22] btrfs-progs: handle the per-block group global root id
Date:   Fri,  5 Nov 2021 16:40:42 -0400
Message-Id: <73e494b6b45b77ae90b3838b991e89c14cbb45ff.1636144276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144275.git.josef@toxicpanda.com>
References: <cover.1636144275.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We will now be using block_group->chunk_objectid to point at the global
root id for this particular block group.  For now we'll assign this
based on mod'ing the offset of the block group against the number of
global root id's and handle the block_group_item updating appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h           |  2 ++
 kernel-shared/disk-io.c         | 24 ++++++++++++++++++++++--
 kernel-shared/disk-io.h         |  1 +
 kernel-shared/extent-tree.c     | 17 +++++++++++++++--
 kernel-shared/free-space-tree.c |  3 +++
 5 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index c7346fee..3914000d 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1182,6 +1182,8 @@ struct btrfs_block_group {
 	 */
 	u64 alloc_offset;
 	u64 write_offset;
+
+	u64 global_root_id;
 };
 
 struct btrfs_device;
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 4c613b52..af29a7ae 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -787,13 +787,33 @@ struct btrfs_root *btrfs_global_root(struct btrfs_fs_info *fs_info,
 	return NULL;
 }
 
+u64 btrfs_global_root_id(struct btrfs_fs_info *fs_info, u64 bytenr)
+{
+	struct btrfs_block_group *block_group;
+	u64 ret = 0;
+
+	if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		return ret;
+
+	/*
+	 * We use this because we won't have this many global roots, and -1 is
+	 * special, so we need something that'll not be found if we have any
+	 * errors from here on.
+	 */
+	ret = BTRFS_LAST_FREE_OBJECTID;
+	block_group = btrfs_lookup_first_block_group(fs_info, bytenr);
+	if (block_group)
+		ret = block_group->global_root_id;
+	return ret;
+}
+
 struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info,
 				   u64 bytenr)
 {
 	struct btrfs_key key = {
 		.objectid = BTRFS_CSUM_TREE_OBJECTID,
 		.type = BTRFS_ROOT_ITEM_KEY,
-		.offset = 0,
+		.offset = btrfs_global_root_id(fs_info, bytenr),
 	};
 
 	return btrfs_global_root(fs_info, &key);
@@ -805,7 +825,7 @@ struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info,
 	struct btrfs_key key = {
 		.objectid = BTRFS_EXTENT_TREE_OBJECTID,
 		.type = BTRFS_ROOT_ITEM_KEY,
-		.offset = 0,
+		.offset = btrfs_global_root_id(fs_info, bytenr),
 	};
 
 	return btrfs_global_root(fs_info, &key);
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index a96a9dfb..e2c2f3d9 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -221,6 +221,7 @@ struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 bytenr);
 struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_inf, u64 bytenr);
 struct btrfs_root *btrfs_global_root(struct btrfs_fs_info *fs_info,
 				     struct btrfs_key *key);
+u64 btrfs_global_root_id(struct btrfs_fs_info *fs_info, u64 bytenr);
 int btrfs_global_root_insert(struct btrfs_fs_info *fs_info,
 			     struct btrfs_root *root);
 
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index a1c061fa..b282491e 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1561,7 +1561,7 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_block_group_used(&bgi, cache->used);
 	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
 	btrfs_set_stack_block_group_chunk_objectid(&bgi,
-			BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+						   cache->global_root_id);
 	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
 	btrfs_mark_buffer_dirty(leaf);
 fail:
@@ -2658,6 +2658,7 @@ static int read_block_group_item(struct btrfs_block_group *cache,
 			   sizeof(bgi));
 	cache->used = btrfs_stack_block_group_used(&bgi);
 	cache->flags = btrfs_stack_block_group_flags(&bgi);
+	cache->global_root_id = btrfs_stack_block_group_chunk_objectid(&bgi);
 
 	return 0;
 }
@@ -2777,6 +2778,18 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 	cache->start = chunk_offset;
 	cache->length = size;
 
+	/*
+	 * If we have extent tree v2 set then set it to the next global root id
+	 * based on our offset.  Otherwise set it to
+	 * BTRFS_FIRST_CHUNK_TREE_OBJECTID so that extent tree v1 has the
+	 * appropriate setting.
+	 */
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		cache->global_root_id = div_u64(chunk_offset, SZ_1G) %
+			fs_info->num_global_roots;
+	else
+		cache->global_root_id = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
+
 	ret = btrfs_load_block_group_zone_info(fs_info, cache);
 	BUG_ON(ret);
 
@@ -2806,7 +2819,7 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 
 	btrfs_set_stack_block_group_used(&bgi, block_group->used);
 	btrfs_set_stack_block_group_chunk_objectid(&bgi,
-				BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+						   block_group->global_root_id);
 	btrfs_set_stack_block_group_flags(&bgi, block_group->flags);
 	key.objectid = block_group->start;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 896bd3a2..a82865d3 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -34,6 +34,9 @@ static struct btrfs_root *btrfs_free_space_root(struct btrfs_fs_info *fs_info,
 		.offset = 0,
 	};
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		key.offset = block_group->global_root_id;
+
 	return btrfs_global_root(fs_info, &key);
 }
 
-- 
2.26.3

