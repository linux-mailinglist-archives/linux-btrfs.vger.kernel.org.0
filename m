Return-Path: <linux-btrfs+bounces-4193-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D858A31C5
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 17:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70EBA1F22B1E
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 15:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3FD1487CD;
	Fri, 12 Apr 2024 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5nI3+jp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B91F148301
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934208; cv=none; b=MzzGHr3JgNGDKiUC1tyfWyjKZn5FVWuAZrAovH5txa5R0POiuKT8qJufhkicbpZm3zCTzP55/sKJSaTxvb01P4iWd+Um25qTywh0uqWZdMAkee/3VDINewmQkd93yAvJrKLRmoy4Be6Y0w8c2Bwg9jd2db9tRo1hdMm9jb9q6xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934208; c=relaxed/simple;
	bh=/nzaOUhmq7/6PUwsnScjWmwj23J7xSX9eYlSBzu66Fg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OOJzDS9+aQ37XL78iBc0BvKycdfeQ1Xx02kr1uxK2Fk8817vC9fcuG9fu4Fnk4/gyb1vxNYy9uiLA/rZcHZsOXoLnxe03ImoylmZRrGPUon/qCt4UlnF9atTT0GLpPaSh876PUisbUMrycvhU0AKBO08L+pXEvGgGBS4LnldBwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5nI3+jp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC3FC2BBFC
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 15:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712934208;
	bh=/nzaOUhmq7/6PUwsnScjWmwj23J7xSX9eYlSBzu66Fg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=n5nI3+jppxJ47hoxI6f7WtHCc7PgLHpM/ZX8ZNVVyG1EpJA1/bWvWI1lUqKRJDWsx
	 k4lhg0ucoeilfFU4T9WJJWCyuPpYhadtAytKWVRPBE3LtjsXu70ucLW2pK/3wP/b7P
	 +KH28ADiqUE0tMwwHutSbYrvCTJYCMd6D+M8r2cwhUoarHKFx6L+72xCNryfFSYf+A
	 Be1fj1cVNSBD5JyXmSOvFYNMG6S09tFxzJzEqS8F9HNe4OB0Ut1xg0lAls8W5e/1L7
	 +uzw/6x3zp4Km4S/cTTMH5lEVawcfSnAapWoLS73O6gr3V7gvl+3MeyjJUMUxumB0R
	 Ow8rjXEQSiMcA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs: remove use of a temporary list at btrfs_lookup_csums_list()
Date: Fri, 12 Apr 2024 16:03:17 +0100
Message-Id: <5ba3b6e48c1e7433b1e38ae315713d7b31813730.1712933005.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712933003.git.fdmanana@suse.com>
References: <cover.1712933003.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to use a temporary list to add the checksums, we can just
add them to input list and then on error delete and free any checksums
that were added. So simplify and remove the temporary list.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file-item.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 0712a0aa2dd0..c2799325706f 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -470,7 +470,6 @@ int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
 	struct extent_buffer *leaf;
 	struct btrfs_ordered_sum *sums;
 	struct btrfs_csum_item *item;
-	LIST_HEAD(tmplist);
 	int ret;
 
 	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
@@ -572,18 +571,17 @@ int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
 					   bytes_to_csum_size(fs_info, size));
 
 			start += size;
-			list_add_tail(&sums->list, &tmplist);
+			list_add_tail(&sums->list, list);
 		}
 		path->slots[0]++;
 	}
 	ret = 0;
 fail:
-	while (ret < 0 && !list_empty(&tmplist)) {
-		sums = list_entry(tmplist.next, struct btrfs_ordered_sum, list);
+	while (ret < 0 && !list_empty(list)) {
+		sums = list_entry(list->next, struct btrfs_ordered_sum, list);
 		list_del(&sums->list);
 		kfree(sums);
 	}
-	list_splice_tail(&tmplist, list);
 
 	btrfs_free_path(path);
 	return ret;
-- 
2.43.0


