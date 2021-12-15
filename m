Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3374E476276
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhLOUAR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbhLOUAQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:00:16 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6FDC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:16 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id d2so21168294qki.12
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nS+tqew8QWOc9LBM0MXg9F9F2D7TlV1JSdFrftR6fAk=;
        b=aZrJ/nyNTk+B2Ymqm10Q/yz28iME0DfstUxdbCH4jziE3unKo0AL1fE5S8/u4agcf7
         9TNZVAxWyMMlCpRUJnkIOLq8m5dM5PMfvWvCUrC9LluoQA6reaBdzeMnZT7IkHi48STb
         XGt43o6FujKrbqrreMrZsNLeX1R4Eow+KOCh85VLuRATLPwDMN43bP7di/1TJJ3Ac47V
         LtHwpj8UYCm0gV4F8igcXccyTelCbLb2HnkCKx3YvTXhpPlHPaddUx71Naeql8vJ3pgo
         T0uTinN1DSmiGxQDRqDavqANE3m0k9t5W0wi18jZM6Pn2NGdtTRBRJog9HBAm8z2sERX
         iEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nS+tqew8QWOc9LBM0MXg9F9F2D7TlV1JSdFrftR6fAk=;
        b=g6geGA4yw8g9hBYmuIJKvxT/ETeP6KWjGjxq/ihOsg0L7CPUAEJjuZ33/rnZJFO/BA
         wPlMNLFS8ziAjqcwoKeRyUHWZzaaF4piKE8CPFqmDXtN+UooQ+Y+8uHLY/SmXRyrbXPD
         gXkNxqCgmyZQPDKNaE+0AlsrM9pNtruHlGp+mTsMUCPi/8EKTvRHmSXFV+JZffeSZRA4
         IFtP1qw4FlGDsOVg5MWvZOlmM+yzI2i/4SVrDOJ6iJpSzvbLu5wC2KxrvDIV8qiYqqf0
         JQ7LkR5VKMSeeusoLBgyzXYcWJqg/xGfHFBEOJzyiP0/ErqRTwRJv476tQkgNfoMwGNb
         Y2eA==
X-Gm-Message-State: AOAM531Ito/mubL7etFj+MT0An4VCQvaK93ygYhjUnaIQt8aCVb9FMrr
        AaHSA/zBG6MLbVPhK22ZnLorQrwDfugDLw==
X-Google-Smtp-Source: ABdhPJy8bmA5+Ik1Jy58kxMLD54l07nG77Veei+eVmAvx4zyNft+35L213ivHx2Qx8CI32FufIpfPA==
X-Received: by 2002:a05:620a:4589:: with SMTP id bp9mr10028552qkb.515.1639598415111;
        Wed, 15 Dec 2021 12:00:15 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t18sm2220070qtw.64.2021.12.15.12.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:00:14 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 16/22] btrfs-progs: handle the per-block group global root id
Date:   Wed, 15 Dec 2021 14:59:42 -0500
Message-Id: <827f0e6abff89e2a8813c668a8095fa073f5e433.1639598278.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598278.git.josef@toxicpanda.com>
References: <cover.1639598278.git.josef@toxicpanda.com>
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
 kernel-shared/extent-tree.c     | 24 ++++++++++++++++++++++--
 kernel-shared/free-space-tree.c |  3 +++
 5 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 9530db8b..82a4a2eb 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1188,6 +1188,8 @@ struct btrfs_block_group {
 	 */
 	u64 alloc_offset;
 	u64 write_offset;
+
+	u64 global_root_id;
 };
 
 struct btrfs_device;
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 3283120c..38118e1d 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -798,13 +798,33 @@ struct btrfs_root *btrfs_global_root(struct btrfs_fs_info *fs_info,
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
@@ -816,7 +836,7 @@ struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info,
 	struct btrfs_key key = {
 		.objectid = BTRFS_EXTENT_TREE_OBJECTID,
 		.type = BTRFS_ROOT_ITEM_KEY,
-		.offset = 0,
+		.offset = btrfs_global_root_id(fs_info, bytenr),
 	};
 
 	return btrfs_global_root(fs_info, &key);
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index cb1ba4e2..4f58cad1 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -218,6 +218,7 @@ struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 bytenr);
 struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_inf, u64 bytenr);
 struct btrfs_root *btrfs_global_root(struct btrfs_fs_info *fs_info,
 				     struct btrfs_key *key);
+u64 btrfs_global_root_id(struct btrfs_fs_info *fs_info, u64 bytenr);
 int btrfs_global_root_insert(struct btrfs_fs_info *fs_info,
 			     struct btrfs_root *root);
 
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index a1c061fa..1469f5c3 100644
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
@@ -2765,6 +2766,24 @@ error:
 	return ret;
 }
 
+/*
+ * For extent tree v2 we use the block_group_item->chunk_offset to point at our
+ * global root id.  For v1 it's always set to BTRFS_FIRST_CHUNK_TREE_OBJECTID.
+ */
+static u64 calculate_global_root_id(struct btrfs_fs_info *fs_info, u64 offset)
+{
+	u64 div = SZ_1G;
+
+	if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		return BTRFS_FIRST_CHUNK_TREE_OBJECTID;
+
+	/* If we have a smaller fs index based on 128m. */
+	if (btrfs_super_total_bytes(fs_info->super_copy) <= (SZ_1G * 10ULL))
+		div = SZ_128M;
+
+	return (div_u64(offset, div) % fs_info->num_global_roots);
+}
+
 struct btrfs_block_group *
 btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 		      u64 chunk_offset, u64 size)
@@ -2776,6 +2795,7 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 	BUG_ON(!cache);
 	cache->start = chunk_offset;
 	cache->length = size;
+	cache->global_root_id = calculate_global_root_id(fs_info, chunk_offset);
 
 	ret = btrfs_load_block_group_zone_info(fs_info, cache);
 	BUG_ON(ret);
@@ -2806,7 +2826,7 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 
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

