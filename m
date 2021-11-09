Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C63E44B020
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 16:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbhKIPPH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 10:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbhKIPPG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Nov 2021 10:15:06 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA81FC061764
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Nov 2021 07:12:20 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id jo22so4603845qvb.13
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Nov 2021 07:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4juFIttpwO0TPoOesJWPhDRSO0sSx4Qp7Ma8pYxnltU=;
        b=pJJOWRjVns+0e+bVVg79Y4o7xyir5WJkBhmUJo6c2uRde7i3w+C/7KduWRyJTYM7KA
         /lqG+3M9iZ+ZGLB9Czt47lVu6cVW3ikceXj/WvKg2D4I8zPUd2uFpBnF1b3hcrG8eP15
         JtG7XCfI1W2A45c2/Gb0OH2CHri+qeqVOTTkxQGeWatMJqHej839U0wmauX4bky1UpiW
         npOFA65szSAoIh+WIJbSSz+AakPhZbUX6SohPg0Z4sMQcH4AxT4+o+g42jfodx8LQ5Tp
         WawEsHz/vwPefBhDNY7Ch3B17ewx8E1YOZ7XnAOk5AmE7EvIowj+wEbRRIGSY7vkQEgB
         5Kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4juFIttpwO0TPoOesJWPhDRSO0sSx4Qp7Ma8pYxnltU=;
        b=DS0hTNimrwWAHYVzOXJdZktmZX9txpbMgrhujfXDtBKk9MrO+vgnFzQ1Yv0nTaT8U6
         4FvvxcN9x+2vtoYg627SE/Ga/V682J7CaBYqNGJ5fP4SrA1yAZlsxFpKWqhSZhTMkNIR
         mAzpxaNV4pYA7kDtKbjS+9rNudOm0gkzOYcF6Gx+DGuIffgdKhayx1nbTV5P8CmDWHp9
         sK5aqWxsD6WMZifVXS5gHWYHmILuO4eZMpovKfaIMdsFniIrWoO5g2fR0FyRPqBfjxQv
         fpy2JVQrFYwIfSDNJGYYuTixxl14H0EE8YvZ/Ffapag5QgUnTwyiw0OHvpNc1pKUqnXa
         KKLw==
X-Gm-Message-State: AOAM530cuDn3O8C6ToTjj0j7tA/z83yGjEdH/83vzE3gAtvRkptQTRux
        c2FQH6PVQrw+QMlIp6qkcShmVR+k0REb8A==
X-Google-Smtp-Source: ABdhPJyYAw918p9BoZBWsCf4yftV1aawKZV6yt+gAct2Cm1I4KAPkURWhafuaFnfdcv1ZxLS5AMHAg==
X-Received: by 2002:ad4:4e49:: with SMTP id eb9mr7857786qvb.22.1636470739698;
        Tue, 09 Nov 2021 07:12:19 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w9sm11852324qko.19.2021.11.09.07.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 07:12:19 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 7/7] btrfs: change root to fs_info for btrfs_reserve_metadata_bytes
Date:   Tue,  9 Nov 2021 10:12:07 -0500
Message-Id: <be424bc42b157f13ac255678e1762082de699ee5.1636470628.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636470628.git.josef@toxicpanda.com>
References: <cover.1636470628.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We used to need the root for btrfs_reserve_metadata_bytes to check the
orphan cleanup state, but we no longer need that, we simply need the
fs_info.  Change btrfs_reserve_metadata_bytes() to use the fs_info, and
change both btrfs_block_rsv_refill() and btrfs_block_rsv_add() to do the
same as they simply call btrfs_reserve_metadata_bytes() and then
manipulate the block_rsv that is being used.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c    |  2 +-
 fs/btrfs/block-rsv.c      | 12 +++++++-----
 fs/btrfs/block-rsv.h      |  4 ++--
 fs/btrfs/delalloc-space.c |  2 +-
 fs/btrfs/delayed-inode.c  |  2 +-
 fs/btrfs/delayed-ref.c    |  4 ++--
 fs/btrfs/inode.c          |  4 ++--
 fs/btrfs/props.c          |  5 +++--
 fs/btrfs/relocation.c     | 17 +++++++++--------
 fs/btrfs/root-tree.c      |  2 +-
 fs/btrfs/space-info.c     |  3 +--
 fs/btrfs/space-info.h     |  2 +-
 fs/btrfs/transaction.c    |  4 ++--
 13 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 6ab864655090..d56fc1b8bb99 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3790,7 +3790,7 @@ static void reserve_chunk_space(struct btrfs_trans_handle *trans,
 	}
 
 	if (!ret) {
-		ret = btrfs_block_rsv_add(fs_info->chunk_root,
+		ret = btrfs_block_rsv_add(fs_info,
 					  &fs_info->chunk_block_rsv,
 					  bytes, BTRFS_RESERVE_NO_FLUSH);
 		if (!ret)
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 04a6226e0388..ac6fbe75cace 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -208,7 +208,7 @@ void btrfs_free_block_rsv(struct btrfs_fs_info *fs_info,
 	kfree(rsv);
 }
 
-int btrfs_block_rsv_add(struct btrfs_root *root,
+int btrfs_block_rsv_add(struct btrfs_fs_info *fs_info,
 			struct btrfs_block_rsv *block_rsv, u64 num_bytes,
 			enum btrfs_reserve_flush_enum flush)
 {
@@ -217,7 +217,8 @@ int btrfs_block_rsv_add(struct btrfs_root *root,
 	if (num_bytes == 0)
 		return 0;
 
-	ret = btrfs_reserve_metadata_bytes(root, block_rsv, num_bytes, flush);
+	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, num_bytes,
+					   flush);
 	if (!ret)
 		btrfs_block_rsv_add_bytes(block_rsv, num_bytes, true);
 
@@ -241,7 +242,7 @@ int btrfs_block_rsv_check(struct btrfs_block_rsv *block_rsv, int min_factor)
 	return ret;
 }
 
-int btrfs_block_rsv_refill(struct btrfs_root *root,
+int btrfs_block_rsv_refill(struct btrfs_fs_info *fs_info,
 			   struct btrfs_block_rsv *block_rsv, u64 min_reserved,
 			   enum btrfs_reserve_flush_enum flush)
 {
@@ -262,7 +263,8 @@ int btrfs_block_rsv_refill(struct btrfs_root *root,
 	if (!ret)
 		return 0;
 
-	ret = btrfs_reserve_metadata_bytes(root, block_rsv, num_bytes, flush);
+	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, num_bytes,
+					   flush);
 	if (!ret) {
 		btrfs_block_rsv_add_bytes(block_rsv, num_bytes, false);
 		return 0;
@@ -523,7 +525,7 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
 				block_rsv->type, ret);
 	}
 try_reserve:
-	ret = btrfs_reserve_metadata_bytes(root, block_rsv, blocksize,
+	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, blocksize,
 					   BTRFS_RESERVE_NO_FLUSH);
 	if (!ret)
 		return block_rsv;
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index 0b6ae5302837..07d61c2c5d28 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -57,11 +57,11 @@ void btrfs_init_metadata_block_rsv(struct btrfs_fs_info *fs_info,
 				   unsigned short type);
 void btrfs_free_block_rsv(struct btrfs_fs_info *fs_info,
 			  struct btrfs_block_rsv *rsv);
-int btrfs_block_rsv_add(struct btrfs_root *root,
+int btrfs_block_rsv_add(struct btrfs_fs_info *fs_info,
 			struct btrfs_block_rsv *block_rsv, u64 num_bytes,
 			enum btrfs_reserve_flush_enum flush);
 int btrfs_block_rsv_check(struct btrfs_block_rsv *block_rsv, int min_factor);
-int btrfs_block_rsv_refill(struct btrfs_root *root,
+int btrfs_block_rsv_refill(struct btrfs_fs_info *fs_info,
 			   struct btrfs_block_rsv *block_rsv, u64 min_reserved,
 			   enum btrfs_reserve_flush_enum flush);
 int btrfs_block_rsv_migrate(struct btrfs_block_rsv *src_rsv,
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 2059d1504149..bca438c7c972 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -331,7 +331,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	ret = btrfs_qgroup_reserve_meta_prealloc(root, qgroup_reserve, true);
 	if (ret)
 		return ret;
-	ret = btrfs_reserve_metadata_bytes(root, block_rsv, meta_reserve, flush);
+	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, meta_reserve, flush);
 	if (ret) {
 		btrfs_qgroup_free_meta_prealloc(root, qgroup_reserve);
 		return ret;
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index e164766dcc38..6f134f2c5e68 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -629,7 +629,7 @@ static int btrfs_delayed_inode_reserve_metadata(
 					  BTRFS_QGROUP_RSV_META_PREALLOC, true);
 		if (ret < 0)
 			return ret;
-		ret = btrfs_block_rsv_add(root, dst_rsv, num_bytes,
+		ret = btrfs_block_rsv_add(fs_info, dst_rsv, num_bytes,
 					  BTRFS_RESERVE_NO_FLUSH);
 		/* NO_FLUSH could only fail with -ENOSPC */
 		ASSERT(ret == 0 || ret == -ENOSPC);
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index cca7e85e32dd..80950a409395 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -191,8 +191,8 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 	if (!num_bytes)
 		return 0;
 
-	ret = btrfs_reserve_metadata_bytes(fs_info->extent_root, block_rsv,
-					   num_bytes, flush);
+	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, num_bytes,
+					   flush);
 	if (ret)
 		return ret;
 	btrfs_block_rsv_add_bytes(block_rsv, num_bytes, 0);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ac0b55ca3e78..041fcb752a90 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5537,10 +5537,10 @@ static struct btrfs_trans_handle *evict_refill_and_join(struct btrfs_root *root,
 	 * if we fail to make this reservation we can re-try without the
 	 * delayed_refs_extra so we can make some forward progress.
 	 */
-	ret = btrfs_block_rsv_refill(root, rsv, rsv->size + delayed_refs_extra,
+	ret = btrfs_block_rsv_refill(fs_info, rsv, rsv->size + delayed_refs_extra,
 				     BTRFS_RESERVE_FLUSH_EVICT);
 	if (ret) {
-		ret = btrfs_block_rsv_refill(root, rsv, rsv->size,
+		ret = btrfs_block_rsv_refill(fs_info, rsv, rsv->size,
 					     BTRFS_RESERVE_FLUSH_EVICT);
 		if (ret) {
 			btrfs_warn(fs_info,
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index a978676aa627..1a6d2d5b4b33 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -377,8 +377,9 @@ static int inherit_props(struct btrfs_trans_handle *trans,
 		 */
 		if (need_reserve) {
 			num_bytes = btrfs_calc_insert_metadata_size(fs_info, 1);
-			ret = btrfs_block_rsv_add(root, trans->block_rsv,
-					num_bytes, BTRFS_RESERVE_NO_FLUSH);
+			ret = btrfs_block_rsv_add(fs_info, trans->block_rsv,
+						  num_bytes,
+						  BTRFS_RESERVE_NO_FLUSH);
 			if (ret)
 				return ret;
 		}
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ee0a0efc7efd..a455a1ead0d6 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1736,7 +1736,8 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 	memset(&next_key, 0, sizeof(next_key));
 
 	while (1) {
-		ret = btrfs_block_rsv_refill(root, rc->block_rsv, min_reserved,
+		ret = btrfs_block_rsv_refill(fs_info, rc->block_rsv,
+					     min_reserved,
 					     BTRFS_RESERVE_FLUSH_LIMIT);
 		if (ret)
 			goto out;
@@ -1855,7 +1856,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 again:
 	if (!err) {
 		num_bytes = rc->merging_rsv_size;
-		ret = btrfs_block_rsv_add(root, rc->block_rsv, num_bytes,
+		ret = btrfs_block_rsv_add(fs_info, rc->block_rsv, num_bytes,
 					  BTRFS_RESERVE_FLUSH_ALL);
 		if (ret)
 			err = ret;
@@ -2323,8 +2324,8 @@ static int reserve_metadata_space(struct btrfs_trans_handle *trans,
 	 * If we get an enospc just kick back -EAGAIN so we know to drop the
 	 * transaction and try to refill when we can flush all the things.
 	 */
-	ret = btrfs_block_rsv_refill(root, rc->block_rsv, num_bytes,
-				BTRFS_RESERVE_FLUSH_LIMIT);
+	ret = btrfs_block_rsv_refill(fs_info, rc->block_rsv, num_bytes,
+				     BTRFS_RESERVE_FLUSH_LIMIT);
 	if (ret) {
 		tmp = fs_info->nodesize * RELOCATION_RESERVED_NODES;
 		while (tmp <= rc->reserved_bytes)
@@ -3550,7 +3551,7 @@ int prepare_to_relocate(struct reloc_control *rc)
 	rc->reserved_bytes = 0;
 	rc->block_rsv->size = rc->extent_root->fs_info->nodesize *
 			      RELOCATION_RESERVED_NODES;
-	ret = btrfs_block_rsv_refill(rc->extent_root,
+	ret = btrfs_block_rsv_refill(rc->extent_root->fs_info,
 				     rc->block_rsv, rc->block_rsv->size,
 				     BTRFS_RESERVE_FLUSH_ALL);
 	if (ret)
@@ -3598,9 +3599,9 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 
 	while (1) {
 		rc->reserved_bytes = 0;
-		ret = btrfs_block_rsv_refill(rc->extent_root,
-					rc->block_rsv, rc->block_rsv->size,
-					BTRFS_RESERVE_FLUSH_ALL);
+		ret = btrfs_block_rsv_refill(fs_info, rc->block_rsv,
+					     rc->block_rsv->size,
+					     BTRFS_RESERVE_FLUSH_ALL);
 		if (ret) {
 			err = ret;
 			break;
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 458aa74a37ce..f7ff7c71c9ce 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -503,7 +503,7 @@ int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 	num_bytes = btrfs_calc_insert_metadata_size(fs_info, items);
 	rsv->space_info = btrfs_find_space_info(fs_info,
 					    BTRFS_BLOCK_GROUP_METADATA);
-	ret = btrfs_block_rsv_add(root, rsv, num_bytes,
+	ret = btrfs_block_rsv_add(fs_info, rsv, num_bytes,
 				  BTRFS_RESERVE_FLUSH_ALL);
 
 	if (ret == -ENOSPC && use_global_rsv)
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 6b65baec33d4..dbf8bfb8fcb3 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1595,12 +1595,11 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
  * regain reservations will be made and this will fail if there is not enough
  * space already.
  */
-int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
+int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 				 struct btrfs_block_rsv *block_rsv,
 				 u64 orig_bytes,
 				 enum btrfs_reserve_flush_enum flush)
 {
-	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret;
 
 	ret = __reserve_bytes(fs_info, block_rsv->space_info, orig_bytes, flush);
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index cb5056472e79..d841fed73492 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -123,7 +123,7 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
 void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 			   struct btrfs_space_info *info, u64 bytes,
 			   int dump_block_groups);
-int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
+int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 				 struct btrfs_block_rsv *block_rsv,
 				 u64 orig_bytes,
 				 enum btrfs_reserve_flush_enum flush);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 1c3a1189c0bd..b958e0fdfe10 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -628,7 +628,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 			reloc_reserved = true;
 		}
 
-		ret = btrfs_block_rsv_add(root, rsv, num_bytes, flush);
+		ret = btrfs_block_rsv_add(fs_info, rsv, num_bytes, flush);
 		if (ret)
 			goto reserve_fail;
 		if (delayed_refs_bytes) {
@@ -1578,7 +1578,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	btrfs_reloc_pre_snapshot(pending, &to_reserve);
 
 	if (to_reserve > 0) {
-		pending->error = btrfs_block_rsv_add(root,
+		pending->error = btrfs_block_rsv_add(fs_info,
 						     &pending->block_rsv,
 						     to_reserve,
 						     BTRFS_RESERVE_NO_FLUSH);
-- 
2.26.3

