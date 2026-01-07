Return-Path: <linux-btrfs+bounces-20200-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A59CFE35C
	for <lists+linux-btrfs@lfdr.de>; Wed, 07 Jan 2026 15:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C145230856B6
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jan 2026 14:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0863314B7;
	Wed,  7 Jan 2026 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="WuNwxBAp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8955332ED2E
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Jan 2026 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795033; cv=none; b=fZ/My+aWP2lfB/RolHqwpRwC1WEp18t+hmQq5TOS4Czl9pqH/DRVMUg24G43j0ULWcF/py5QtVZ9kUz/vbPxifBB/NC988V5ayPK2vjcZmhnqGpQmqcP8dQaVY3TDjPU3m52TQA0SK/t/kgFet+JZRJi3bK5VtcU4u+HROxh7q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795033; c=relaxed/simple;
	bh=lw2xQeaBAsRHy1XLxIPxlc55pkkaY7EkpToZG143ka4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=HgHwBIYoBYMQJHYWuaAIF6Mk4fjrS0PHvH80YayzZ6TJttBaYT13i7JNs+9nocqEPPzk858keaaFPnsolCBVc9fG+8LHTNDHh/limefaG6mi36tFcRvJAYRZoYrcloEwf+0DOpG3emzmnJFeTAS9i2NySf7ZtNHSLG6fpyEMyo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=WuNwxBAp; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 555F72F186C;
	Wed,  7 Jan 2026 14:10:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1767795018;
	bh=ciLWA4atye6XpnjQgePHeLLzrl4aYVJPlRkv2FUUdKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WuNwxBAp4tWa+B6uEdPqSC7SR5jbp1Sg1OoL5a9Rf32Y2Hk6f+39GBTVmHTp12sUP
	 yyOUnTJuUl4GCA5idsIii20myxjbCNK55OoPdnfViLeT5ttF97Y/pSlNhozbmLHEw+
	 iFSDO+f23yiS0MuTUrtYTQcZM/jY7wzoxK9vyJa8=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v8 06/17] btrfs: rename struct btrfs_block_group field commit_used to last_used
Date: Wed,  7 Jan 2026 14:09:06 +0000
Message-ID: <20260107141015.25819-7-mark@harmstone.com>
In-Reply-To: <20260107141015.25819-1-mark@harmstone.com>
References: <20260107141015.25819-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the field commit_used in struct btrfs_block_group to last_used,
for clarity and consistency with the similar fields we're about to add.
It's not obvious that commit_flags means "flags as of the last commit"
rather than "flags related to a commit".

Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/block-group.c | 24 ++++++++++++------------
 fs/btrfs/block-group.h |  4 ++--
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 39e2db630bce..822c5306a7a4 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2388,7 +2388,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 
 	cache->length = key->offset;
 	cache->used = btrfs_stack_block_group_used(bgi);
-	cache->commit_used = cache->used;
+	cache->last_used = cache->used;
 	cache->flags = btrfs_stack_block_group_flags(bgi);
 	cache->global_root_id = btrfs_stack_block_group_chunk_objectid(bgi);
 	cache->space_info = btrfs_find_space_info(info, cache->flags);
@@ -2667,7 +2667,7 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 	struct btrfs_block_group_item bgi;
 	struct btrfs_root *root = btrfs_block_group_root(fs_info);
 	struct btrfs_key key;
-	u64 old_commit_used;
+	u64 old_last_used;
 	int ret;
 
 	spin_lock(&block_group->lock);
@@ -2675,8 +2675,8 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_block_group_chunk_objectid(&bgi,
 						   block_group->global_root_id);
 	btrfs_set_stack_block_group_flags(&bgi, block_group->flags);
-	old_commit_used = block_group->commit_used;
-	block_group->commit_used = block_group->used;
+	old_last_used = block_group->last_used;
+	block_group->last_used = block_group->used;
 	key.objectid = block_group->start;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	key.offset = block_group->length;
@@ -2685,7 +2685,7 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
 	ret = btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
 	if (ret < 0) {
 		spin_lock(&block_group->lock);
-		block_group->commit_used = old_commit_used;
+		block_group->last_used = old_last_used;
 		spin_unlock(&block_group->lock);
 	}
 
@@ -3139,7 +3139,7 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	struct btrfs_block_group_item bgi;
 	struct btrfs_key key;
-	u64 old_commit_used;
+	u64 old_last_used;
 	u64 used;
 
 	/*
@@ -3149,14 +3149,14 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 	 * may be changed.
 	 */
 	spin_lock(&cache->lock);
-	old_commit_used = cache->commit_used;
+	old_last_used = cache->last_used;
 	used = cache->used;
 	/* No change in used bytes, can safely skip it. */
-	if (cache->commit_used == used) {
+	if (cache->last_used == used) {
 		spin_unlock(&cache->lock);
 		return 0;
 	}
-	cache->commit_used = used;
+	cache->last_used = used;
 	spin_unlock(&cache->lock);
 
 	key.objectid = cache->start;
@@ -3180,17 +3180,17 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 fail:
 	btrfs_release_path(path);
 	/*
-	 * We didn't update the block group item, need to revert commit_used
+	 * We didn't update the block group item, need to revert last_used
 	 * unless the block group item didn't exist yet - this is to prevent a
 	 * race with a concurrent insertion of the block group item, with
 	 * insert_block_group_item(), that happened just after we attempted to
-	 * update. In that case we would reset commit_used to 0 just after the
+	 * update. In that case we would reset last_used to 0 just after the
 	 * insertion set it to a value greater than 0 - if the block group later
 	 * becomes with 0 used bytes, we would incorrectly skip its update.
 	 */
 	if (ret < 0 && ret != -ENOENT) {
 		spin_lock(&cache->lock);
-		cache->commit_used = old_commit_used;
+		cache->last_used = old_last_used;
 		spin_unlock(&cache->lock);
 	}
 	return ret;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 5f933455118c..01401e9959c1 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -132,10 +132,10 @@ struct btrfs_block_group {
 
 	/*
 	 * The last committed used bytes of this block group, if the above @used
-	 * is still the same as @commit_used, we don't need to update block
+	 * is still the same as @last_used, we don't need to update block
 	 * group item of this block group.
 	 */
-	u64 commit_used;
+	u64 last_used;
 	/*
 	 * If the free space extent count exceeds this number, convert the block
 	 * group to bitmaps.
-- 
2.51.2


