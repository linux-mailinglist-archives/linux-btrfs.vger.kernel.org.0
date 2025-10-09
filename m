Return-Path: <linux-btrfs+bounces-17587-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822B1BC8D0E
	for <lists+linux-btrfs@lfdr.de>; Thu, 09 Oct 2025 13:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11DE1A60C8C
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Oct 2025 11:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D67F2E7F0B;
	Thu,  9 Oct 2025 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="ZKq27DmB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (unknown [62.3.69.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993981F3FE2
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.3.69.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009307; cv=none; b=t+HEfapQyMGYLooBVBU9bR9Mgjph0gIlzK5WH8/I9nMLNNx2eYT0MZ53LoryYycnzI0IvWG2BUoRUi2iSdadNiwzd8ELMnVIFdcK/Bp4LOkFUFcvTmR63ECT4GVPrZDln3f70efT1gSxiBges+Q+k1ds+xSs3F//F5xe7KEfL4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009307; c=relaxed/simple;
	bh=AEOkizD88eRoAckfu12EyKZwLvIpVVfKL+szAbmtCbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=IZpVUuE3kUXLdH8s4WZass8ZOnZGejqyo2todbnHf+va6d6/0s7cuga4NGumWkA0ZPG1ugV0ioJu1lpfvRJeZtnoSRkp0ju6WdgqWP6PryImAEEgYhNozCsfXdsESZXlHtQPOPVF2ZQ+lyA3DQCHmGWTWT3432TUiHdhVuMCnc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=fail smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=ZKq27DmB; arc=none smtp.client-ip=62.3.69.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id E936F2C565E;
	Thu,  9 Oct 2025 12:28:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1760009288;
	bh=KYXr58rCdPSmKAVlWU1xyLajRIdHeGJXQDauSkPTcMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZKq27DmBb+StL+hyGizK7EO4zoFSp/dtgimOhhhwBgsA4toYUyu2ZCum3sZ8ZGPao
	 fZxjtfm/hq6hVnwWSvSkzVMNlN/JpF3ft0A9DaKcd3UlWRC8SdpvCe0/sn3JsYXSFr
	 NqXujasJ8klW5r6r2h4h23s07eqCvIdKv85UNVtE=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v3 17/17] btrfs: add stripe removal pending flag
Date: Thu,  9 Oct 2025 12:28:12 +0100
Message-ID: <20251009112814.13942-18-mark@harmstone.com>
In-Reply-To: <20251009112814.13942-1-mark@harmstone.com>
References: <20251009112814.13942-1-mark@harmstone.com>
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
 fs/btrfs/block-group.c          | 35 ++++++++++++++++++++++++++++++++-
 fs/btrfs/free-space-cache.c     |  5 +++++
 fs/btrfs/relocation.c           | 18 +++++++++++++++++
 include/uapi/linux/btrfs_tree.h |  1 +
 4 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index a7dfa6c95223..851d76ce8ec9 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2530,6 +2530,16 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		inc_block_group_ro(cache, 1);
 	}
 
+	if (cache->flags & BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING) {
+		btrfs_get_block_group(cache);
+		spin_lock(&info->unused_bgs_lock);
+		list_add_tail(&cache->bg_list, &info->fully_remapped_bgs);
+		spin_unlock(&info->unused_bgs_lock);
+
+		if (btrfs_test_opt(info, DISCARD_ASYNC))
+			btrfs_discard_queue_work(&info->discard_ctl, cache);
+	}
+
 	return 0;
 error:
 	btrfs_put_block_group(cache);
@@ -4828,6 +4838,29 @@ void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
 
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
index 56f27487b632..813b82294341 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3065,6 +3065,7 @@ bool btrfs_is_free_space_trimmed(struct btrfs_block_group *block_group)
 	bool ret = true;
 
 	if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
+	    !(block_group->flags & BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING) &&
 	    block_group->remap_bytes == 0 &&
 	    block_group->identity_remap_count == 0) {
 		return true;
@@ -3845,6 +3846,9 @@ void btrfs_trim_fully_remapped_block_group(struct btrfs_block_group *bg)
 	struct btrfs_trans_handle *trans;
 	struct btrfs_chunk_map *map;
 
+	if (!(bg->flags & BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING))
+		goto skip_discard;
+
 	while (bg->discard_cursor < end) {
 		u64 trimmed;
 
@@ -3897,6 +3901,7 @@ void btrfs_trim_fully_remapped_block_group(struct btrfs_block_group *bg)
 
 	btrfs_free_chunk_map(map);
 
+skip_discard:
 	if (bg->used == 0) {
 		spin_lock(&fs_info->unused_bgs_lock);
 		list_move_tail(&bg->bg_list, &fs_info->unused_bgs);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 7bad8d65d145..a179e4a8e960 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4733,6 +4733,7 @@ int btrfs_last_identity_remap_gone(struct btrfs_trans_handle *trans,
 				   struct btrfs_block_group *bg)
 {
 	int ret;
+	bool bg_already_dirty = true;
 	BTRFS_PATH_AUTO_FREE(path);
 
 	ret = btrfs_remove_dev_extents(trans, chunk);
@@ -4757,6 +4758,23 @@ int btrfs_last_identity_remap_gone(struct btrfs_trans_handle *trans,
 
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


