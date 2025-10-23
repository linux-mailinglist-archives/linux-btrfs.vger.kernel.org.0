Return-Path: <linux-btrfs+bounces-18204-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C75C024B0
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8D505408BE
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8442D291C07;
	Thu, 23 Oct 2025 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+qYYlGm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B1828C840
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235221; cv=none; b=UdsQ4xvA/YJRCCptWG7EE38Uul7kbXFWhsrJ92rkrdrtBSCsfKjzBm/F5AgZzmFV343L1RTfoF7wmSZd9zpZ+An8Jczc5HbfbhJeZRHm0uWdlM30oTHgnQinrdWb7fdLhrzGt8nnPOXh9OoYE+b8QuOBuMqCrVrP49f8OKKz0wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235221; c=relaxed/simple;
	bh=uvsMek4JOLQdDVdY8CMdmKgQVTxaXDl+5m2myP9+jAU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgSJM2WlBrHBVooS8YYgDhKW6J6B+4nhPkjxMAMiHa3RRE2ycw5QApT7DH00F7PtLRp3U3fgNInafcmhpjZRUgDLrB54FOZ0odqLnV+uKIKSkgba+K9s6C1FfozO5+Mksa0YfUwsLlDR5nN7D9hiUoII9XIWFVqrUjn4MwMZo78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+qYYlGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC49C4CEE7
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235221;
	bh=uvsMek4JOLQdDVdY8CMdmKgQVTxaXDl+5m2myP9+jAU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=h+qYYlGmtAeffBGsP1OybNXE8t1pn0qI2MtZVTHIKc95czcWmh3Jz4QrZjoOoaEI0
	 Zq0rCP5rIdTtg4ZMBjB4GcF3fV4YQAETrTrGvWvSOzYDW44g/jScHoc2ykn4F1tk+J
	 xOFb23FVm906zpOT/8DPDiPEQyjdr0P9X7pbGWD8jHpnTobUCWWLgmQOmp815jTZYX
	 VZAqFZkfkdpbJhC3ASmH2mCwErLtzErxSeGMvXN7k9NZJCviP70YdckVZltye7WJ9a
	 fA6umA7UxL9Tyn51VMlXMqb+8ljWxunEWyWBR8Z90qBzPE+9MzXyo4xGdU7Vgb0RjT
	 i1pqObHa5AQNQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 17/28] btrfs: reduce block group critical section in btrfs_add_reserved_bytes()
Date: Thu, 23 Oct 2025 16:59:50 +0100
Message-ID: <291e761b336d66a19c1ed1395922a13b0507eb73.1761234581.git.fdmanana@suse.com>
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

We are doing some things inside the block group's critical section that
are relevant only to the space_info: updating the space_info counters
bytes_reserved and bytes_may_use as well as trying to grant tickets
(calling btrfs_try_granting_tickets()), and this later can take some
time. So move all those updates to outside the block group's critical
section and still inside the space_info's critical section. Like this
we keep the block group's critical section only for block group updates
and can help reduce contention on a block group's lock.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 856bda9c99d9..b964eacc1610 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3813,22 +3813,26 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
 	spin_lock(&cache->lock);
 	if (cache->ro) {
 		ret = -EAGAIN;
-		goto out;
+		goto out_error;
 	}
 
 	if (btrfs_block_group_should_use_size_class(cache)) {
 		size_class = btrfs_calc_block_group_size_class(num_bytes);
 		ret = btrfs_use_block_group_size_class(cache, size_class, force_wrong_size_class);
 		if (ret)
-			goto out;
+			goto out_error;
 	}
+
 	cache->reserved += num_bytes;
-	space_info->bytes_reserved += num_bytes;
+	if (delalloc)
+		cache->delalloc_bytes += num_bytes;
+
 	trace_btrfs_space_reservation(cache->fs_info, "space_info",
 				      space_info->flags, num_bytes, 1);
+	spin_unlock(&cache->lock);
+
+	space_info->bytes_reserved += num_bytes;
 	btrfs_space_info_update_bytes_may_use(space_info, -ram_bytes);
-	if (delalloc)
-		cache->delalloc_bytes += num_bytes;
 
 	/*
 	 * Compression can use less space than we reserved, so wake tickets if
@@ -3836,7 +3840,11 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
 	 */
 	if (num_bytes < ram_bytes)
 		btrfs_try_granting_tickets(space_info);
-out:
+	spin_unlock(&space_info->lock);
+
+	return 0;
+
+out_error:
 	spin_unlock(&cache->lock);
 	spin_unlock(&space_info->lock);
 	return ret;
-- 
2.47.2


