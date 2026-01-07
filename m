Return-Path: <linux-btrfs+bounces-20192-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9314CFE393
	for <lists+linux-btrfs@lfdr.de>; Wed, 07 Jan 2026 15:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D875330390E1
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jan 2026 14:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0FD3164D0;
	Wed,  7 Jan 2026 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="2ny6NvSq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34C032B996
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Jan 2026 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795029; cv=none; b=DS5fN3gMRW0TkiO9OHDgDHFoAHF09azdXVUY5ZrxLsVju61oQubjmdLuq74IV3DeML3lijuhmZHPKAJS1ifQCln6LJLd09xGHzjsCbUInRgce9hA6CkJ+xJ0Z83xDH4FXFCfy8MW8Q5bk80yCGnTMlmPVAEyyULRItHdiimOOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795029; c=relaxed/simple;
	bh=l6Lrz0C5t9PmtZ/K9V5vjUReDBNLZ03YHa3UNfc+VeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=NSCFveScQNZVwxkhFGJYeZK1BpjAMuAte8ixQ6iauXGHnLkfbNIm8SQpDufsmLESKOAe8nsT4CDb1VHN9o0g6T6tGB48ExRxmr9xsH3VOpnkIm6nFTJKGHOc0rXSz7mbWDEumPY5fafRyO6jLikX9qHSe0JoZ4rg8T+LWvn0g2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=2ny6NvSq; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 3DC2A2F186A;
	Wed,  7 Jan 2026 14:10:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1767795018;
	bh=7JK8LNy1CgJOXSBPBG4u01CIGZLeejnbWVPPj08fFXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=2ny6NvSqrEJ9o40Yt3cHWA/kLXa5x76rjSD9u48/gn6CzQTAt8rngkfRdTjQcEs1U
	 I71OQNe+L6ayChgOlfYlxyWtOYdUornLp4t1Qcl2qtmQJz521zfJyR7UQr8Rtr5H3i
	 ZuOkrOCQAff8ssVtU+LWDUx5ClbSL/vZF6x+XCu0=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v8 04/17] btrfs: remove remapped block groups from the free-space tree
Date: Wed,  7 Jan 2026 14:09:04 +0000
Message-ID: <20260107141015.25819-5-mark@harmstone.com>
In-Reply-To: <20260107141015.25819-1-mark@harmstone.com>
References: <20260107141015.25819-1-mark@harmstone.com>
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
block group, and prevent any additions to the in-memory free-space tree.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
Reviewed-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c      | 19 ++++++++++++++++---
 fs/btrfs/free-space-cache.c |  3 +++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e417aba4c4c7..39e2db630bce 100644
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
@@ -1246,10 +1253,16 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	 * deletes the block group item from the extent tree, allowing for
 	 * another task to attempt to create another block group with the same
 	 * item key (and failing with -EEXIST and a transaction abort).
+	 *
+	 * If the REMAPPED flag has been set the block group's free space
+	 * has already been removed, so we can skip the call to
+	 * btrfs_remove_block_group_free_space().
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
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f0f72850fab2..8d4db3d57cf7 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2756,6 +2756,9 @@ int btrfs_add_free_space(struct btrfs_block_group *block_group,
 {
 	enum btrfs_trim_state trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 
+	if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)
+		return 0;
+
 	if (btrfs_is_zoned(block_group->fs_info))
 		return __btrfs_add_free_space_zoned(block_group, bytenr, size,
 						    true);
-- 
2.51.2


