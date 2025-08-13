Return-Path: <linux-btrfs+bounces-16050-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC8CB24C2C
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 16:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067493BEC10
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 14:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410BF2E1C79;
	Wed, 13 Aug 2025 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="53KMYqNm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741A82EAB7E
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Aug 2025 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095724; cv=none; b=bI+vNjDiNjDw7yHCuWmP4XKtHpjQauDQscjyHqCwOCLq6K2vQ+EJnZLEUSEVMDWgq/D7GlTTbDguCy/cYPALy67El5eK8fSc2OP6+cs4yonn+UC4eAw9e3drPo16L1wBPVYEbtM3s2lJCwFP3PLu/QHuBBXPO8zsgwSI8XoA5zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095724; c=relaxed/simple;
	bh=+DSWtY+YrFQc/YIx/PKjCwrNNBQcd8oGB5fuH8h1vYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=RXh9+TMEGCuNQTa4zxoXsoQx9VQuI8XpNUNvQbftMbxN9qAwYDd4biLjVPRR+RNvsHWOAix1d1M80cYUWCMH6eHAAt8jizxqD8qH2GE00wJuQq4hh9Fohnx0ULqldTAic0x2oXbSv+ELFOUMab/OWMNBGinLUiCbDKRZj9RWLKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=53KMYqNm; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 3288A2A7593;
	Wed, 13 Aug 2025 15:35:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1755095713;
	bh=cvJkdMiyJzzDjTUqZPV5zxbGAUFDopKkxbKCNR3NNME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=53KMYqNmCRChdfD/+XMP8PmftXrbfxXFBDDM4DhTY1C5mWsL+tH/7F/Gw7JBldYwk
	 YRRwqW65W84i4tTmN4UBnxkRWhcZlorOoGyyBmm/JNZySpZXCYHx7t2gZRXWwXV5mm
	 Z64UqBF7s42Ltlc2vaNep2mOJ1+XXxAEwFAVVbyg=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v2 04/16] btrfs: remove remapped block groups from the free-space tree
Date: Wed, 13 Aug 2025 15:34:46 +0100
Message-ID: <20250813143509.31073-5-mark@harmstone.com>
In-Reply-To: <20250813143509.31073-1-mark@harmstone.com>
References: <20250813143509.31073-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

No new allocations can be done from block groups that have the REMAPPED flag
set, so there's no value in their having entries in the free-space tree.

Prevent a search through the free-space tree being scheduled for such a
block group, and prevent discard being run for a fully-remapped block
group.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/block-group.c | 21 ++++++++++++++++-----
 fs/btrfs/discard.c     |  9 +++++++++
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9bf282d2453c..4d76d457da9b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -933,6 +933,13 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, bool wait)
 	if (btrfs_is_zoned(fs_info))
 		return 0;
 
+	/*
+	 * No allocations can be done from remapped block groups, so they have
+	 * no entries in the free-space tree.
+	 */
+	if (cache->flags & BTRFS_BLOCK_GROUP_REMAPPED)
+		return 0;
+
 	caching_ctl = kzalloc(sizeof(*caching_ctl), GFP_NOFS);
 	if (!caching_ctl)
 		return -ENOMEM;
@@ -1248,9 +1255,11 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	 * another task to attempt to create another block group with the same
 	 * item key (and failing with -EEXIST and a transaction abort).
 	 */
-	ret = btrfs_remove_block_group_free_space(trans, block_group);
-	if (ret)
-		goto out;
+	if (!(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)) {
+		ret = btrfs_remove_block_group_free_space(trans, block_group);
+		if (ret)
+			goto out;
+	}
 
 	ret = remove_block_group_item(trans, path, block_group);
 	if (ret < 0)
@@ -2465,10 +2474,12 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	if (btrfs_chunk_writeable(info, cache->start)) {
 		if (cache->used == 0) {
 			ASSERT(list_empty(&cache->bg_list));
-			if (btrfs_test_opt(info, DISCARD_ASYNC))
+			if (btrfs_test_opt(info, DISCARD_ASYNC) &&
+			    !(cache->flags & BTRFS_BLOCK_GROUP_REMAPPED)) {
 				btrfs_discard_queue_work(&info->discard_ctl, cache);
-			else
+			} else {
 				btrfs_mark_bg_unused(cache);
+			}
 		}
 	} else {
 		inc_block_group_ro(cache, 1);
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 89fe85778115..1015a4d37fb2 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -698,6 +698,15 @@ void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info)
 	/* We enabled async discard, so punt all to the queue */
 	list_for_each_entry_safe(block_group, next, &fs_info->unused_bgs,
 				 bg_list) {
+		/* Fully remapped BGs have nothing to discard */
+		spin_lock(&block_group->lock);
+		if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
+		    !btrfs_is_block_group_used(block_group)) {
+			spin_unlock(&block_group->lock);
+			continue;
+		}
+		spin_unlock(&block_group->lock);
+
 		list_del_init(&block_group->bg_list);
 		btrfs_discard_queue_work(&fs_info->discard_ctl, block_group);
 		/*
-- 
2.49.1


