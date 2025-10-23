Return-Path: <linux-btrfs+bounces-18206-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7A2C02492
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64091AA255E
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6580F296BC3;
	Thu, 23 Oct 2025 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AINCAu0x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5389296BAF
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235223; cv=none; b=sZHWOfHY9/7fREVWYeX4C/ymSsoGS7SnKzutJhN683Gl8/7+yByjVzyZSUDqQ9/3Iy8bbwl+lboXivyvrsdaTcEBxy9063/B5u4zxbajFnIE9Dw/vK2spYJ8BaEUNc7u7oTy6lN5Sxh/3L58EKx+NDakWN7fzXbJrqR2j/M/4Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235223; c=relaxed/simple;
	bh=V9Up+Z2VWZDQjzj//DRsRgfh0KP691kPZW+MRtCELqY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDVnbetKEXQ1MfY1pdI/h//DF1VAMWJtcOQH/kAcWMdQtLxHxz3RC1JA3lhBiOGqde8/YUR0xZtZsSCLYrzJVIxt4+p5Sn0Yjpuw0TTVMSPSHLBl4ICB7ynqBYBjBcxd1XsSxTgSt7Q1RNbmcHYk8OZzLNlvmziEnwGv29979FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AINCAu0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E10EC4CEE7
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235223;
	bh=V9Up+Z2VWZDQjzj//DRsRgfh0KP691kPZW+MRtCELqY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AINCAu0xr7COz4vaC2VWcWYORRuPHDOE99+p4cb5tF1GKPqEtQIq6chzHqwowgaWN
	 ArC0Ntn/sVDAY1rcHmWwxkhoHeB2rajAYpphD4vIl936Afoey7RadiDC/dYuQ5/5Rt
	 6X6TtLV8bxTgZ1SQUHBLaTwZEXcJnybuJZsLiFthwNayrJ6hwJ2RJwSZmdbogPQcKr
	 rq5BbYi1eYCFA12fD4wPSXpcKQiVl2GtjaSrDizjOxqD5eM2jcr9iNLTb9tWdE0D/c
	 8ncJJPYiH+8zIYr/WI1K15IAp0oGnDW4h3WNWM50K86y3yskxcT5Zl9LoIPmEs7N5F
	 ty4MzayaSRymg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 19/28] btrfs: reduce block group critical section in pin_down_extent()
Date: Thu, 23 Oct 2025 16:59:52 +0100
Message-ID: <6ad94bc6f4671e932d76188ce9aeb7026b22b27f.1761234581.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1761234580.git.fdmanana@suse.com>
References: <cover.1761234580.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to update the bytes_reserved and bytes_may_use fields of
the space_info while holding the block group's spinlock. We are only
making the critical section longer than necessary. So move the space_info
updates outside of the block group's critical section.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ae2c3dc9957e..70b77fe21b9f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2594,15 +2594,15 @@ static int pin_down_extent(struct btrfs_trans_handle *trans,
 			   struct btrfs_block_group *cache,
 			   u64 bytenr, u64 num_bytes, int reserved)
 {
+	const u64 reserved_bytes = (reserved ? num_bytes : 0);
+
 	spin_lock(&cache->space_info->lock);
 	spin_lock(&cache->lock);
 	cache->pinned += num_bytes;
-	btrfs_space_info_update_bytes_pinned(cache->space_info, num_bytes);
-	if (reserved) {
-		cache->reserved -= num_bytes;
-		cache->space_info->bytes_reserved -= num_bytes;
-	}
+	cache->reserved -= reserved_bytes;
 	spin_unlock(&cache->lock);
+	cache->space_info->bytes_reserved -= reserved_bytes;
+	btrfs_space_info_update_bytes_pinned(cache->space_info, num_bytes);
 	spin_unlock(&cache->space_info->lock);
 
 	btrfs_set_extent_bit(&trans->transaction->pinned_extents, bytenr,
-- 
2.47.2


