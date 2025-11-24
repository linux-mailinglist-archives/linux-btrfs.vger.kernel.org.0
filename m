Return-Path: <linux-btrfs+bounces-19304-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75174C822B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 19:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC8BE4E666D
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 18:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2872D3A96;
	Mon, 24 Nov 2025 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="dbw7yyVq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4573D2D3A89
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 18:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764010415; cv=none; b=S2OgeU3p5hg1OUZpckUT/kvZeQRLW6kKp282zm/3T73cJyp5ZI/7bgWT9e7sy5szCzWlCMEeq5zyNIy3P5LOteeQkYy2YNBmI8D+CIiOR6mhx4/BkWKFTbMes+AQ1GoncC3zzjpMSge0JFhxbOc3O9EYY3yVE6nRLRrO81nr8nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764010415; c=relaxed/simple;
	bh=4BkWwgn/iSsyIGfZdIeaTU/ESh7mzU7kcFx37SnUAtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=fm9MtzV5kXfOkNkbTU4ELxwDn2qloaab+yVLQWskTHyiaslPXvYD8pla9CZ9KdN3AzHEAXrCHt76+lCaKdu32URhOs2W9Xfbtfg1Ka/2xjYEyTYxOaZRSH09Uc/SOiWiHbR8ypaQs0V8gk+5wC+Bt2gbKET38oeU4eC3+2LzQh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=dbw7yyVq; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 032EF2DEC5C;
	Mon, 24 Nov 2025 18:53:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1764010411;
	bh=70wmNIw2WlCR3Zx8SPB0mEGz30WtEBCd57UMjK728Sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dbw7yyVqEJHXTYx2rxO/O6fx2YlTIUd0gUywmBaLIGAiU8oIAhJQmdBHn8O8+Gr2z
	 sOcRJgjJSBHaSmGO61QfPHHdXXTID9RmDA2cmg72CuxBh4MrbeRx5qgl03C8suWoMb
	 SyJHpOF8S7pcQ5EZr8QxadY5k9bUiYeA1rnUO4cE=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v7 04/16] btrfs: remove remapped block groups from the free-space tree
Date: Mon, 24 Nov 2025 18:52:56 +0000
Message-ID: <20251124185335.16556-5-mark@harmstone.com>
In-Reply-To: <20251124185335.16556-1-mark@harmstone.com>
References: <20251124185335.16556-1-mark@harmstone.com>
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
index 6e6939d2e902..53c6bbad7df0 100644
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
@@ -1247,10 +1254,16 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
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
2.51.0


