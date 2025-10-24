Return-Path: <linux-btrfs+bounces-18301-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA878C07A83
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 20:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208601C256F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 18:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9DB346E70;
	Fri, 24 Oct 2025 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="e8B8HozR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87666346E71
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329562; cv=none; b=UqlZGLEjLd8YHeH1wxOGmS3cvHrO6r+CzjU1NOgLiqIKiWXrM0B4h6xT759eJ64KFqDKUWlDpssrQ6cAU6LvqdhPsbTpQWok4Ze7A37c5SGaVf6o8ishlniFEz9tSkT+IpyC7KdBLRQHg6dtKcpbhwWFn4yjstfO39Hd1Ja7cLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329562; c=relaxed/simple;
	bh=GLV+pjAIBmAA2pzG7eSQZvUaKtzRSfgsSJDaaMSR0BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=W3tvF3xYVCEfSqn8HYd6FgjVETBTHYlSKl48/c4PjRXVv4j/ukqGXNAUnfSfVTCrOGXSuxsxhgkbWOFEL7obtqpVbrp7zSzD3OeIIcr3a0D99XxjIPCpWbmZ1QLP3nbpHZ/dt6rgZPCWuideM4EuKoASeicoTT0EQDBWDlnhumw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=e8B8HozR; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 739172CFE49;
	Fri, 24 Oct 2025 19:12:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1761329550;
	bh=DEIekIyTc9mRneRJFnBvEUUw8eLfa0E8fC0rvYNCcFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e8B8HozRj9hljqVvseD1M51WV7SC7xHqR7DJOaWhrfSbXzrVCDKbN1K3ttBSkWfE3
	 HBYyLAKMuQUBHjKNW691PIfxcu+m5NaF/WuqzIuGIDEXaeMRIzzbU8QfCHmuV8J1kE
	 zqYPwVNKdlaksxaD5K+5/f1XFh965dgUt0dKQc3k=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v4 04/16] btrfs: remove remapped block groups from the free-space tree
Date: Fri, 24 Oct 2025 19:12:05 +0100
Message-ID: <20251024181227.32228-5-mark@harmstone.com>
In-Reply-To: <20251024181227.32228-1-mark@harmstone.com>
References: <20251024181227.32228-1-mark@harmstone.com>
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
---
 fs/btrfs/block-group.c      | 15 ++++++++++++---
 fs/btrfs/free-space-cache.c |  3 +++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index ec1e4fc0cd51..b5f2ec8d013f 100644
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
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index ab873bd67192..ec9a97d75d10 100644
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
2.49.1


