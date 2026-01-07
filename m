Return-Path: <linux-btrfs+bounces-20207-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF96CFE3AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 07 Jan 2026 15:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE50E30C0F00
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jan 2026 14:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01EC32ED32;
	Wed,  7 Jan 2026 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="YbE1nkZs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339B232FA30
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Jan 2026 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795037; cv=none; b=sA5YCinMbPHmSaTf4MF+590P4Mcm4QP+NcwztwTElaevOIynKAu0YU6XwwOGVIczHNYmxeZejEHcdW0D/5J2HV8Et6pC7QshpbES75v4HGL0JQ/gKgm08ud223FGP9FKLQFVAz860barXBSwb/eV53XoTz8f/m4ZYE/g8F79gC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795037; c=relaxed/simple;
	bh=V88DlFOt850Z2zDv3QUa9CPxk/lgYvUGYJt7j8mm0UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=AF0HUx/oHd0WvjRb4f3DvTjsOqYzA+owN83p9bJ9lfRFMqztGB5tHo0oX8eiOANeSHuV2RlzcLclNKZZyG30RG9Z7ou1DNcKm5a95x09OyW7C5K+vmqxogmeUADbgzDbWt34i3ZwxznU4tFXinDMQnsNXI+p0eM1zblK0SkwqwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=YbE1nkZs; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id DA3F02F1877;
	Wed,  7 Jan 2026 14:10:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1767795018;
	bh=G9aIpf5/VEr5CBf1BCfURs+YdQ/5PW4PoVSFQnEjJVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YbE1nkZseITM7xpYhxqwEtgfEqQrNX156NsHZmz4F/RxJApfFSpM6QoYD5VTaRPdb
	 VbkJQtee4WAJc9Vb1U1ncxo2ifQ8nvTIoC9ukcprvH1d1tafJ+RJDGCpU7hzjbgmDW
	 2W3iKOJxqfGFggbUBBI8Gmeiap16MQaYfTlsSmhU=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v8 17/17] btrfs: populate fully_remapped_bgs_list on mount
Date: Wed,  7 Jan 2026 14:09:17 +0000
Message-ID: <20260107141015.25819-18-mark@harmstone.com>
In-Reply-To: <20260107141015.25819-1-mark@harmstone.com>
References: <20260107141015.25819-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a function btrfs_populate_fully_remapped_bgs_list() which gets
called on mount, which looks for fully remapped block groups
(i.e. identity_remap_count == 0) which haven't yet had their chunk
stripes and device extents removed.

This happens when a filesystem is unmounted while async discard has not
yet finished, as otherwise the data range occupied by the chunk stripes
would be permanently unusable.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
Reviewed-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c      | 79 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/block-group.h      |  2 +
 fs/btrfs/disk-io.c          |  9 +++++
 fs/btrfs/free-space-cache.c | 18 +++++++++
 fs/btrfs/relocation.c       |  4 ++
 5 files changed, 112 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 47454c22d6f4..1f5101f40b8c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4815,6 +4815,11 @@ void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 
 	if (btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
+		spin_lock(&bg->lock);
+		set_bit(BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING,
+			&bg->runtime_flags);
+		spin_unlock(&bg->lock);
+
 		btrfs_discard_queue_work(&fs_info->discard_ctl, bg);
 	} else {
 		spin_lock(&fs_info->unused_bgs_lock);
@@ -4834,3 +4839,77 @@ void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
 		spin_unlock(&fs_info->unused_bgs_lock);
 	}
 }
+
+/*
+ * Compare the block group and chunk trees, and find any fully-remapped block
+ * groups which haven't yet had their chunk stripes and device extents removed,
+ * and put them on the fully_remapped_bgs list so this gets done.
+ *
+ * This happens when a block group becomes fully remapped, i.e. its last
+ * identity mapping is removed, and the volume is unmounted before async
+ * discard has finished. It's important this gets done as until it is the
+ * chunk's stripes are dead space.
+ */
+int btrfs_populate_fully_remapped_bgs_list(struct btrfs_fs_info *fs_info)
+{
+	struct rb_node *node_bg, *node_chunk;
+
+	node_bg = rb_first_cached(&fs_info->block_group_cache_tree);
+	node_chunk = rb_first_cached(&fs_info->mapping_tree);
+
+	while (node_bg && node_chunk) {
+		struct btrfs_block_group *bg;
+		struct btrfs_chunk_map *map;
+
+		bg = rb_entry(node_bg, struct btrfs_block_group, cache_node);
+		map = rb_entry(node_chunk, struct btrfs_chunk_map, rb_node);
+
+		ASSERT(bg->start == map->start);
+
+		if (!(bg->flags & BTRFS_BLOCK_GROUP_REMAPPED))
+			goto next;
+
+		if (bg->identity_remap_count != 0)
+			goto next;
+
+		if (map->num_stripes == 0)
+			goto next;
+
+		spin_lock(&fs_info->unused_bgs_lock);
+
+		if (list_empty(&bg->bg_list)) {
+			btrfs_get_block_group(bg);
+			list_add_tail(&bg->bg_list,
+				      &fs_info->fully_remapped_bgs);
+		} else {
+			list_move_tail(&bg->bg_list,
+				       &fs_info->fully_remapped_bgs);
+		}
+
+		spin_unlock(&fs_info->unused_bgs_lock);
+
+		/*
+		 * Ideally we'd want to call btrfs_discard_queue_work() here,
+		 * but it'd do nothing as the discard worker hasn't been
+		 * started yet.
+		 *
+		 * The block group will get added to the discard list when
+		 * btrfs_handle_fully_remapped_bgs() gets called, when we
+		 * commit the first transaction.
+		 */
+		if (btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
+			spin_lock(&bg->lock);
+			set_bit(BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING,
+				&bg->runtime_flags);
+			spin_unlock(&bg->lock);
+		}
+
+next:
+		node_bg = rb_next(node_bg);
+		node_chunk = rb_next(node_chunk);
+	}
+
+	ASSERT(!node_bg && !node_chunk);
+
+	return 0;
+}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 3117cebf02f5..ccca6ee517a9 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -94,6 +94,7 @@ enum btrfs_block_group_flags {
 	 */
 	BLOCK_GROUP_FLAG_NEW,
 	BLOCK_GROUP_FLAG_FULLY_REMAPPED,
+	BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING,
 };
 
 enum btrfs_caching_type {
@@ -416,5 +417,6 @@ int btrfs_use_block_group_size_class(struct btrfs_block_group *bg,
 bool btrfs_block_group_should_use_size_class(const struct btrfs_block_group *bg);
 void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
 				  struct btrfs_trans_handle *trans);
+int btrfs_populate_fully_remapped_bgs_list(struct btrfs_fs_info *fs_info);
 
 #endif /* BTRFS_BLOCK_GROUP_H */
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ba500e3bf0d8..0491b799148f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3613,6 +3613,15 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_sysfs;
 	}
 
+	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
+		ret = btrfs_populate_fully_remapped_bgs_list(fs_info);
+		if (ret) {
+			btrfs_err(fs_info,
+			"failed to populate fully_remapped_bgs list: %d", ret);
+			goto fail_sysfs;
+		}
+	}
+
 	btrfs_zoned_reserve_data_reloc_bg(fs_info);
 	btrfs_free_zone_cache(fs_info);
 
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index e15fa8567f7c..7f7744a78de2 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3068,6 +3068,7 @@ bool btrfs_is_free_space_trimmed(struct btrfs_block_group *block_group)
 	bool ret = true;
 
 	if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
+	    !test_bit(BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING, &block_group->runtime_flags) &&
 	    block_group->identity_remap_count == 0) {
 		return true;
 	}
@@ -3849,6 +3850,23 @@ void btrfs_trim_fully_remapped_block_group(struct btrfs_block_group *bg)
 	const u64 max_discard_size = READ_ONCE(discard_ctl->max_discard_size);
 	u64 end = btrfs_block_group_end(bg);
 
+	if (!test_bit(BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING, &bg->runtime_flags)) {
+		bg->discard_cursor = end;
+
+		if (bg->used == 0) {
+			spin_lock(&fs_info->unused_bgs_lock);
+			if (!list_empty(&bg->bg_list)) {
+				list_del_init(&bg->bg_list);
+				btrfs_put_block_group(bg);
+			}
+			spin_unlock(&fs_info->unused_bgs_lock);
+
+			btrfs_mark_bg_unused(bg);
+		}
+
+		return;
+	}
+
 	bytes = end - bg->discard_cursor;
 
 	if (max_discard_size &&
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 20cf0f7fd401..c3f1b7828179 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4785,6 +4785,10 @@ int btrfs_last_identity_remap_gone(struct btrfs_chunk_map *chunk_map,
 
 	btrfs_remove_bg_from_sinfo(bg);
 
+	spin_lock(&bg->lock);
+	clear_bit(BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING, &bg->runtime_flags);
+	spin_unlock(&bg->lock);
+
 	ret = remove_chunk_stripes(trans, chunk_map, path);
 	if (unlikely(ret)) {
 		btrfs_abort_transaction(trans, ret);
-- 
2.51.2


