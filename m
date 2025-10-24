Return-Path: <linux-btrfs+bounces-18313-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E889C07AA5
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 20:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45B394FA48B
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 18:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3D634A3B4;
	Fri, 24 Oct 2025 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="r375UFTQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F4C348473
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329568; cv=none; b=ZJ5SqOZdWTSAHlEATUf/iP5WJdwYmOhZnMMEGq+J9eavQ52fIKnjFnjqd1MTLTwwQ26yfhl8cV7W7pbxwqZ8ZJO2PUUnyP8pmTdj0bgmYVkj5soVgSEdGraC9jjOpGhxkcz0txTlz8q0HT49glheRIZ420RzaiGwssjyDXKin6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329568; c=relaxed/simple;
	bh=F6wnbFnM7ECL3S5IImqIZ7FKypTrzl/sScILT6eR3Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=ua8ELf/9CU0ciG+WlwmntdbDsd6+AuYrj07UtbrXsxYnWevWq2FVoy+WV5H9704CWFNoGD1RmdH8SVrzfuQxzULDVH+28l+duCperpET0l/NjtdVVIID6FwQW08ehEfHy5P1/jarmAbZnHPuu1E7ksq0/2d3xlar0jeE9XvavFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=r375UFTQ; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 3CD812CFE55;
	Fri, 24 Oct 2025 19:12:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1761329551;
	bh=sdgSqm5SAkFEQ5BBHbip5xakNG1HvbCndXA6yHob+oI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=r375UFTQ8nM+I4WPODGM5g11HgJqT3yGRwZjjljyvaA8crSfHdXvR/Aj9eENFPEMI
	 U7C2TLvv5ensxBWfxbQnTkwzrzBNdx6iuQRNUafLacl6bnyXCE4e73OEYq91hnqM3X
	 j0d/9wrfXGHaCdQ4EDBPAtsaqP4o593ljJEj75OA=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v4 16/16] btrfs: add stripe removal pending flag
Date: Fri, 24 Oct 2025 19:12:17 +0100
Message-ID: <20251024181227.32228-17-mark@harmstone.com>
In-Reply-To: <20251024181227.32228-1-mark@harmstone.com>
References: <20251024181227.32228-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

If the filesystem is unmounted while the async discard of a fully remapped
block group is in progress, its unused device extents will never be freed.

To counter this, add a new flag BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING
to say that this has been interrupted. Set it in the transaction in which
the last identity remap has been removed, clear it when we remove the
device extents, and if we encounter it on mount queue that block group
up for discard.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/block-group.c          | 43 ++++++++++++++++++++++++++++++++-
 fs/btrfs/free-space-cache.c     |  7 ++++++
 fs/btrfs/relocation.c           | 18 ++++++++++++++
 include/uapi/linux/btrfs_tree.h |  1 +
 4 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 0c91553b02cf..8eb452068e1f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2526,6 +2526,24 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		inc_block_group_ro(cache, 1);
 	}
 
+	if (cache->flags & BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING) {
+		spin_lock(&info->unused_bgs_lock);
+
+		if (list_empty(&cache->bg_list)) {
+			btrfs_get_block_group(cache);
+			list_add_tail(&cache->bg_list,
+				      &info->fully_remapped_bgs);
+		} else {
+			list_move_tail(&cache->bg_list,
+				       &info->fully_remapped_bgs);
+		}
+
+		spin_unlock(&info->unused_bgs_lock);
+
+		if (btrfs_test_opt(info, DISCARD_ASYNC))
+			btrfs_discard_queue_work(&info->discard_ctl, cache);
+	}
+
 	return 0;
 error:
 	btrfs_put_block_group(cache);
@@ -4833,6 +4851,29 @@ void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
 
 	spin_unlock(&fs_info->unused_bgs_lock);
 
-	if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
+	if (btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
+		bool bg_already_dirty = true;
+
+		spin_lock(&bg->lock);
+		bg->flags |= BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING;
+		spin_unlock(&bg->lock);
+
+		spin_lock(&trans->transaction->dirty_bgs_lock);
+		if (list_empty(&bg->dirty_list)) {
+			list_add_tail(&bg->dirty_list,
+				      &trans->transaction->dirty_bgs);
+			bg_already_dirty = false;
+			btrfs_get_block_group(bg);
+		}
+		spin_unlock(&trans->transaction->dirty_bgs_lock);
+
+		/*
+		 * Modified block groups are accounted for in
+		 * the delayed_refs_rsv.
+		 */
+		if (!bg_already_dirty)
+			btrfs_inc_delayed_refs_rsv_bg_updates(trans->fs_info);
+
 		btrfs_discard_queue_work(&fs_info->discard_ctl, bg);
+	}
 }
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 5d5e3401e723..60c0df6f002c 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3068,6 +3068,7 @@ bool btrfs_is_free_space_trimmed(struct btrfs_block_group *block_group)
 	bool ret = true;
 
 	if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
+	    !(block_group->flags & BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING) &&
 	    block_group->identity_remap_count == 0) {
 		return true;
 	}
@@ -3847,6 +3848,11 @@ void btrfs_trim_fully_remapped_block_group(struct btrfs_block_group *bg)
 	struct btrfs_trans_handle *trans;
 	struct btrfs_chunk_map *map;
 
+	if (!(bg->flags & BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING)) {
+		bg->discard_cursor = end;
+		goto skip_discard;
+	}
+
 	bytes = end - bg->discard_cursor;
 
 	if (max_discard_size &&
@@ -3893,6 +3899,7 @@ void btrfs_trim_fully_remapped_block_group(struct btrfs_block_group *bg)
 
 	btrfs_free_chunk_map(map);
 
+skip_discard:
 	if (bg->used == 0) {
 		spin_lock(&fs_info->unused_bgs_lock);
 		list_move_tail(&bg->bg_list, &fs_info->unused_bgs);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ebbc619be682..e01ff0174fb1 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4740,6 +4740,7 @@ int btrfs_last_identity_remap_gone(struct btrfs_trans_handle *trans,
 				   struct btrfs_block_group *bg)
 {
 	int ret;
+	bool bg_already_dirty = true;
 	BTRFS_PATH_AUTO_FREE(path);
 
 	ret = btrfs_remove_dev_extents(trans, chunk);
@@ -4764,6 +4765,23 @@ int btrfs_last_identity_remap_gone(struct btrfs_trans_handle *trans,
 
 	btrfs_remove_bg_from_sinfo(bg);
 
+	spin_lock(&bg->lock);
+	bg->flags &= ~BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING;
+	spin_unlock(&bg->lock);
+
+	spin_lock(&trans->transaction->dirty_bgs_lock);
+	if (list_empty(&bg->dirty_list)) {
+		list_add_tail(&bg->dirty_list,
+			      &trans->transaction->dirty_bgs);
+		bg_already_dirty = false;
+		btrfs_get_block_group(bg);
+	}
+	spin_unlock(&trans->transaction->dirty_bgs_lock);
+
+	/* Modified block groups are accounted for in the delayed_refs_rsv. */
+	if (!bg_already_dirty)
+		btrfs_inc_delayed_refs_rsv_bg_updates(trans->fs_info);
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 89bcb80081a6..36a7d1a3cbe3 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -1173,6 +1173,7 @@ struct btrfs_dev_replace_item {
 #define BTRFS_BLOCK_GROUP_RAID1C4       (1ULL << 10)
 #define BTRFS_BLOCK_GROUP_REMAPPED      (1ULL << 11)
 #define BTRFS_BLOCK_GROUP_REMAP         (1ULL << 12)
+#define BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING	(1ULL << 13)
 #define BTRFS_BLOCK_GROUP_RESERVED	(BTRFS_AVAIL_ALLOC_BIT_SINGLE | \
 					 BTRFS_SPACE_INFO_GLOBAL_RSV)
 
-- 
2.49.1


