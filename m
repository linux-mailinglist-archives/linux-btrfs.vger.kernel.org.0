Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEEE64C030
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 19:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbfFSRrl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 13:47:41 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46174 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730259AbfFSRrl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 13:47:41 -0400
Received: by mail-qk1-f194.google.com with SMTP id x18so44075qkn.13
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 10:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=LHEmIhMyTmBwbSF/MOFZrCOS4VbMp1GVn6oelWGt5u4=;
        b=sZje/pmHcrqRjPyz5UHaWjMRslDBIIu/OV+2V6keEUecIwXsKLfooO7wKrulzDms5Z
         Vo535OX2d3O1q7+dKBB9HD+ujAE7EcrBowkkBROCiQZr/6oXLd4wO3/1Jl3BrTMDTl/J
         zhOeI7cDsjCUfjUwronCSRQ6KAut4lx3zfp5sSLt90XEWO2NdVQqjb7empO2DNEwNs+V
         QZGOh2KQGWwSciYJgOdG5tp5CogJSl3m9bFD2+ydpqfj8768MA9aIXPyd9guwlSOxo4X
         Rk66jUGPW05+U0fKOkrYvGyoTE9A7hFlLvGk6bFrj7kc66xfK4/Qe8gvgykkUwMviInu
         vmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=LHEmIhMyTmBwbSF/MOFZrCOS4VbMp1GVn6oelWGt5u4=;
        b=jbu4QiCh/0iWngj0jxqcPHdiEUc/EJXmR+e8fZ7q/uj+oF0YEY8AapTmSMWEbupAqi
         Zp93+z9dOO5totjTZ/8Tx5rJ7qxJTFfBuO3omEVb48guReCZvJOYOV4UbKfhhc1pJ7bJ
         tIBOqzsE28qoQn53X6WpbJ2RS/JbrKq8vPxFrKmCca9xhVRxW3YOFrBp8i9U95+QMwQA
         41CHcuOjJMuog20YVZqnLfUOsdSaSQO/XgyN2r1NFqEgfuw7G2nCp0oIsMFg22Gm6reg
         vx686u7XZsdF6JgWgSxeJbh3cHpNUlfzwhzyvxJFVhFS3FST7WJ8EsyPcr1pYYhyNeiu
         +jcg==
X-Gm-Message-State: APjAAAVL1YG0xmldS3xVMN+IRoGbiakOC7p0VUe0Q8+7v8/RPAM6PrSs
        NmhRXO+9KMAxLaTyGhxvjGLmMP9txUfELg==
X-Google-Smtp-Source: APXvYqx2ywA9cu5PV9GsG3eUihrQx6fak7AiX2GcBYGOOSgFkWOO2MWTpH3+eOynGYFV0bdDtix7IQ==
X-Received: by 2002:a05:620a:12ef:: with SMTP id f15mr56869684qkl.340.1560966459343;
        Wed, 19 Jun 2019 10:47:39 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 6sm9533659qkk.69.2019.06.19.10.47.38
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 10:47:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs: migrate the global_block_rsv helpers to block-rsv.c
Date:   Wed, 19 Jun 2019 13:47:23 -0400
Message-Id: <20190619174724.1675-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190619174724.1675-1-josef@toxicpanda.com>
References: <20190619174724.1675-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These helpers belong in block-rsv.c

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.c   | 90 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/block-rsv.h   |  3 ++
 fs/btrfs/extent-tree.c | 99 +++-----------------------------------------------
 3 files changed, 98 insertions(+), 94 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index aa6cea5785fd..bdc798d2ee5a 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -255,3 +255,93 @@ int btrfs_cond_migrate_bytes(struct btrfs_fs_info *fs_info,
 	btrfs_block_rsv_add_bytes(dest, num_bytes, true);
 	return 0;
 }
+
+void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
+	struct btrfs_space_info *sinfo = block_rsv->space_info;
+	u64 num_bytes;
+
+	/*
+	 * The global block rsv is based on the size of the extent tree, the
+	 * checksum tree and the root tree.  If the fs is empty we want to set
+	 * it to a minimal amount for safety.
+	 */
+	num_bytes = btrfs_root_used(&fs_info->extent_root->root_item) +
+		btrfs_root_used(&fs_info->csum_root->root_item) +
+		btrfs_root_used(&fs_info->tree_root->root_item);
+	num_bytes = max_t(u64, num_bytes, SZ_16M);
+
+	spin_lock(&sinfo->lock);
+	spin_lock(&block_rsv->lock);
+
+	block_rsv->size = min_t(u64, num_bytes, SZ_512M);
+
+	if (block_rsv->reserved < block_rsv->size) {
+		num_bytes = btrfs_space_info_used(sinfo, true);
+		if (sinfo->total_bytes > num_bytes) {
+			num_bytes = sinfo->total_bytes - num_bytes;
+			num_bytes = min(num_bytes,
+					block_rsv->size - block_rsv->reserved);
+			block_rsv->reserved += num_bytes;
+			btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
+							      num_bytes);
+			trace_btrfs_space_reservation(fs_info, "space_info",
+						      sinfo->flags, num_bytes,
+						      1);
+		}
+	} else if (block_rsv->reserved > block_rsv->size) {
+		num_bytes = block_rsv->reserved - block_rsv->size;
+		btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
+						      -num_bytes);
+		trace_btrfs_space_reservation(fs_info, "space_info",
+				      sinfo->flags, num_bytes, 0);
+		block_rsv->reserved = block_rsv->size;
+	}
+
+	if (block_rsv->reserved == block_rsv->size)
+		block_rsv->full = 1;
+	else
+		block_rsv->full = 0;
+
+	spin_unlock(&block_rsv->lock);
+	spin_unlock(&sinfo->lock);
+}
+
+void btrfs_init_global_block_rsv(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_space_info *space_info;
+
+	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
+	fs_info->chunk_block_rsv.space_info = space_info;
+
+	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
+	fs_info->global_block_rsv.space_info = space_info;
+	fs_info->trans_block_rsv.space_info = space_info;
+	fs_info->empty_block_rsv.space_info = space_info;
+	fs_info->delayed_block_rsv.space_info = space_info;
+	fs_info->delayed_refs_rsv.space_info = space_info;
+
+	fs_info->extent_root->block_rsv = &fs_info->delayed_refs_rsv;
+	fs_info->csum_root->block_rsv = &fs_info->delayed_refs_rsv;
+	fs_info->dev_root->block_rsv = &fs_info->global_block_rsv;
+	fs_info->tree_root->block_rsv = &fs_info->global_block_rsv;
+	if (fs_info->quota_root)
+		fs_info->quota_root->block_rsv = &fs_info->global_block_rsv;
+	fs_info->chunk_root->block_rsv = &fs_info->chunk_block_rsv;
+
+	btrfs_update_global_block_rsv(fs_info);
+}
+
+void btrfs_release_global_block_rsv(struct btrfs_fs_info *fs_info)
+{
+	btrfs_block_rsv_release(fs_info, &fs_info->global_block_rsv, (u64)-1);
+	WARN_ON(fs_info->trans_block_rsv.size > 0);
+	WARN_ON(fs_info->trans_block_rsv.reserved > 0);
+	WARN_ON(fs_info->chunk_block_rsv.size > 0);
+	WARN_ON(fs_info->chunk_block_rsv.reserved > 0);
+	WARN_ON(fs_info->delayed_block_rsv.size > 0);
+	WARN_ON(fs_info->delayed_block_rsv.reserved > 0);
+	WARN_ON(fs_info->delayed_refs_rsv.reserved > 0);
+	WARN_ON(fs_info->delayed_refs_rsv.size > 0);
+}
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index dcea4bdb3817..8f302d1ac5e2 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -80,6 +80,9 @@ void btrfs_block_rsv_add_bytes(struct btrfs_block_rsv *block_rsv,
 u64 __btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
 			      struct btrfs_block_rsv *block_rsv,
 			      u64 num_bytes, u64 *qgroup_to_release);
+void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info);
+void btrfs_init_global_block_rsv(struct btrfs_fs_info *fs_info);
+void btrfs_release_global_block_rsv(struct btrfs_fs_info *fs_info);
 
 static inline void btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
 					   struct btrfs_block_rsv *block_rsv,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 23bce6b89c6e..5884b06dd15d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4511,95 +4511,6 @@ void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr)
 					      0, released, 0);
 }
 
-static void update_global_block_rsv(struct btrfs_fs_info *fs_info)
-{
-	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
-	struct btrfs_space_info *sinfo = block_rsv->space_info;
-	u64 num_bytes;
-
-	/*
-	 * The global block rsv is based on the size of the extent tree, the
-	 * checksum tree and the root tree.  If the fs is empty we want to set
-	 * it to a minimal amount for safety.
-	 */
-	num_bytes = btrfs_root_used(&fs_info->extent_root->root_item) +
-		btrfs_root_used(&fs_info->csum_root->root_item) +
-		btrfs_root_used(&fs_info->tree_root->root_item);
-	num_bytes = max_t(u64, num_bytes, SZ_16M);
-
-	spin_lock(&sinfo->lock);
-	spin_lock(&block_rsv->lock);
-
-	block_rsv->size = min_t(u64, num_bytes, SZ_512M);
-
-	if (block_rsv->reserved < block_rsv->size) {
-		num_bytes = btrfs_space_info_used(sinfo, true);
-		if (sinfo->total_bytes > num_bytes) {
-			num_bytes = sinfo->total_bytes - num_bytes;
-			num_bytes = min(num_bytes,
-					block_rsv->size - block_rsv->reserved);
-			block_rsv->reserved += num_bytes;
-			btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
-							      num_bytes);
-			trace_btrfs_space_reservation(fs_info, "space_info",
-						      sinfo->flags, num_bytes,
-						      1);
-		}
-	} else if (block_rsv->reserved > block_rsv->size) {
-		num_bytes = block_rsv->reserved - block_rsv->size;
-		btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
-						      -num_bytes);
-		trace_btrfs_space_reservation(fs_info, "space_info",
-				      sinfo->flags, num_bytes, 0);
-		block_rsv->reserved = block_rsv->size;
-	}
-
-	if (block_rsv->reserved == block_rsv->size)
-		block_rsv->full = 1;
-	else
-		block_rsv->full = 0;
-
-	spin_unlock(&block_rsv->lock);
-	spin_unlock(&sinfo->lock);
-}
-
-static void init_global_block_rsv(struct btrfs_fs_info *fs_info)
-{
-	struct btrfs_space_info *space_info;
-
-	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
-	fs_info->chunk_block_rsv.space_info = space_info;
-
-	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
-	fs_info->global_block_rsv.space_info = space_info;
-	fs_info->trans_block_rsv.space_info = space_info;
-	fs_info->empty_block_rsv.space_info = space_info;
-	fs_info->delayed_block_rsv.space_info = space_info;
-	fs_info->delayed_refs_rsv.space_info = space_info;
-
-	fs_info->extent_root->block_rsv = &fs_info->delayed_refs_rsv;
-	fs_info->csum_root->block_rsv = &fs_info->delayed_refs_rsv;
-	fs_info->dev_root->block_rsv = &fs_info->global_block_rsv;
-	fs_info->tree_root->block_rsv = &fs_info->global_block_rsv;
-	if (fs_info->quota_root)
-		fs_info->quota_root->block_rsv = &fs_info->global_block_rsv;
-	fs_info->chunk_root->block_rsv = &fs_info->chunk_block_rsv;
-
-	update_global_block_rsv(fs_info);
-}
-
-static void release_global_block_rsv(struct btrfs_fs_info *fs_info)
-{
-	btrfs_block_rsv_release(fs_info, &fs_info->global_block_rsv, (u64)-1);
-	WARN_ON(fs_info->trans_block_rsv.size > 0);
-	WARN_ON(fs_info->trans_block_rsv.reserved > 0);
-	WARN_ON(fs_info->chunk_block_rsv.size > 0);
-	WARN_ON(fs_info->chunk_block_rsv.reserved > 0);
-	WARN_ON(fs_info->delayed_block_rsv.size > 0);
-	WARN_ON(fs_info->delayed_block_rsv.reserved > 0);
-	WARN_ON(fs_info->delayed_refs_rsv.reserved > 0);
-	WARN_ON(fs_info->delayed_refs_rsv.size > 0);
-}
 
 /*
  * btrfs_update_delayed_refs_rsv - adjust the size of the delayed refs rsv
@@ -5365,7 +5276,7 @@ void btrfs_prepare_extent_commit(struct btrfs_fs_info *fs_info)
 
 	up_write(&fs_info->commit_root_sem);
 
-	update_global_block_rsv(fs_info);
+	btrfs_update_global_block_rsv(fs_info);
 }
 
 /*
@@ -7150,7 +7061,7 @@ use_block_rsv(struct btrfs_trans_handle *trans,
 
 	if (block_rsv->type == BTRFS_BLOCK_RSV_GLOBAL && !global_updated) {
 		global_updated = true;
-		update_global_block_rsv(fs_info);
+		btrfs_update_global_block_rsv(fs_info);
 		goto again;
 	}
 
@@ -8772,7 +8683,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 	 */
 	synchronize_rcu();
 
-	release_global_block_rsv(info);
+	btrfs_release_global_block_rsv(info);
 
 	while (!list_empty(&info->space_info)) {
 		int i;
@@ -9125,7 +9036,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	}
 
 	btrfs_add_raid_kobjects(info);
-	init_global_block_rsv(info);
+	btrfs_init_global_block_rsv(info);
 	ret = check_chunk_block_group_mappings(info);
 error:
 	btrfs_free_path(path);
@@ -9239,7 +9150,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	trace_btrfs_add_block_group(fs_info, cache, 1);
 	btrfs_update_space_info(fs_info, cache->flags, size, bytes_used,
 				cache->bytes_super, &cache->space_info);
-	update_global_block_rsv(fs_info);
+	btrfs_update_global_block_rsv(fs_info);
 
 	link_block_group(cache);
 
-- 
2.14.3

