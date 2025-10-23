Return-Path: <linux-btrfs+bounces-18207-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C702C02495
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A9A3A7C35
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5179D296BAF;
	Thu, 23 Oct 2025 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+gGSA13"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9537E296BC4
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235224; cv=none; b=M9XkefM90gvOQ8oiVuiJ+IdhdRGDrTwkZGPZ/924q/XRHrx0ZptHcoPC/xgMPRHv5b1gHMBGiY3SszExzKB6vqrgEodrMVsnEGzo5+1yGzDLDgJqljSkWGPpuRKHzy5WlGhsWirT94IUoQMGgr3ZsvDhI3C4rcJVvp08yLQbWjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235224; c=relaxed/simple;
	bh=AfmBZ+Kz2gFP7iVyoLiTADh2PrvgxbFNn/2mAhWgnrs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1ESUnRvjLjZ7fCtDECgBKv0ZdiejeUFsycQmKRhqyMNuMnsyAxHoq1rxVlYjjfqAraiOks325X1yTS+842B9EuJUwKtcZHKNHL2Tvpyxm39AWScV1FfNNPGK98qrmjl3AyjX9gGfBylK9sEN6wFobFRZo31X/ez+mZVx/PSqwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+gGSA13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28F3C4CEE7
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235224;
	bh=AfmBZ+Kz2gFP7iVyoLiTADh2PrvgxbFNn/2mAhWgnrs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=E+gGSA131ZyiPjkklCK8r6SZn4iH8md/Jwr3RGpULxGUGnTNQWoc8GUnIrEwjL9Ko
	 UuPFPPQ8SUs0HzkvWEqB6O5mEvmTkdXYlGvXspquw94rJVhTkyHIwMW4bngkk9NOmS
	 cUM4MPNpLEThvzQpzQhhHIFsMiSqM4N560aQqnES7MDpCs8SEvDZ8PcZo5V/WA5Fsb
	 Vugda1s8eHaQ6Ki791R6WbY/7PJDHEQxi5hbJtZ2NHrIgGChvnivUO1SnSIbhhjg2i
	 u+cYUPQNV1Ac6O8RYX+fWjkp/NaQdzdgho72AQ/i16+CMzQAh1QY9NzlsKazvrVoam
	 s+s3WW6/Bw+Lg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 20/28] btrfs: use local variable for space_info in pin_down_extent()
Date: Thu, 23 Oct 2025 16:59:53 +0100
Message-ID: <6efcd503fa1fd7929f60ccd98a1986906bb79fdc.1761234581.git.fdmanana@suse.com>
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

Instead of derefercing the block group multiple times to access its
space_info, use a local variable to shorten the code horizontal wise and
make it easier to read. Also, while at it, also rename the block group
argument from 'cache' to 'bg', as the cache name is confusing and it's
from the old days where the block group structure was named as
'btrfs_block_group_cache'.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 70b77fe21b9f..4be20949f0ba 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2591,19 +2591,20 @@ static u64 first_logical_byte(struct btrfs_fs_info *fs_info)
 }
 
 static int pin_down_extent(struct btrfs_trans_handle *trans,
-			   struct btrfs_block_group *cache,
+			   struct btrfs_block_group *bg,
 			   u64 bytenr, u64 num_bytes, int reserved)
 {
+	struct btrfs_space_info *space_info = bg->space_info;
 	const u64 reserved_bytes = (reserved ? num_bytes : 0);
 
-	spin_lock(&cache->space_info->lock);
-	spin_lock(&cache->lock);
-	cache->pinned += num_bytes;
-	cache->reserved -= reserved_bytes;
-	spin_unlock(&cache->lock);
-	cache->space_info->bytes_reserved -= reserved_bytes;
-	btrfs_space_info_update_bytes_pinned(cache->space_info, num_bytes);
-	spin_unlock(&cache->space_info->lock);
+	spin_lock(&space_info->lock);
+	spin_lock(&bg->lock);
+	bg->pinned += num_bytes;
+	bg->reserved -= reserved_bytes;
+	spin_unlock(&bg->lock);
+	space_info->bytes_reserved -= reserved_bytes;
+	btrfs_space_info_update_bytes_pinned(space_info, num_bytes);
+	spin_unlock(&space_info->lock);
 
 	btrfs_set_extent_bit(&trans->transaction->pinned_extents, bytenr,
 			     bytenr + num_bytes - 1, EXTENT_DIRTY, NULL);
-- 
2.47.2


