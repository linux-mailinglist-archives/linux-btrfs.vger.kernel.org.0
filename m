Return-Path: <linux-btrfs+bounces-17726-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFA5BD58A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 19:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4E934E8721
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 17:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487743093BD;
	Mon, 13 Oct 2025 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUTyfucH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6FB3093AE
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377103; cv=none; b=THwwpjNzt41lz1LoOhFFk46lAYbUjp0OF96a/SAGKshVtBpa1GIz/y+l4gfi2f5m+DqPBSpzFT/LgPfFC4dnpkH1d+ZHzUyQodMiIOSiCbRjd9PmDZoMTBElaYsn9uWMMqkJdkgCovgTmWKhutyHL67zkjNfthhtjSmcku+1cBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377103; c=relaxed/simple;
	bh=3V3wnfYhtpVkVIvzVKndUHNE7C7qI/3y4w1zAUqSM3U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+VKreev03sCjt5lif3+3vs4mh3jJYPjgRckAs/ztFp6NWQRt95eAA+o1RBQ0N0o+Pqr19/SKLDhIwtcZ8zyp2f4//FHsH1cEhml5JV11L/69n/n4P0MjJ/+UF6BYlDQX8AzYx4IlrvaOe4KzwIJv60shHKaaijMDPYHX7eJ5Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUTyfucH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF83C4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377103;
	bh=3V3wnfYhtpVkVIvzVKndUHNE7C7qI/3y4w1zAUqSM3U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hUTyfucHzsENrlAyeaA+GgeFMzc6o0xFJ2ieJANxVFGeB52Xsg6NBnk3aVJwx2PN+
	 PddT5xHkMjBH0/QmfmlwPeSD5kku8k/OI2vpM7FWqiKr4WjYvGrF037CKURBxZMfmb
	 Q6OI2KtfvW32PgdfrfiQxkOgG5owoiPXJwU+/FpWVnG4ReHLkS3EoGaH7ytSTp2ioT
	 W44KVXI5YW7X2G+C5oDSBGnqSLNE1oiKcuu97FW/a/2sSjIGr1bs8bkj2YJbnF1LFf
	 eVyHVkysGa48H99ZTtIyQLVe4LQsvYDH2WDd+jf++HF99OU56saqwhjblTF75mf755
	 B/AhGWiC2d/1Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 09/16] btrfs: remove fs_info argument from btrfs_calc_reclaim_metadata_size()
Date: Mon, 13 Oct 2025 18:38:04 +0100
Message-ID: <ab5fa8e3dfd880af5305687a9493368a7397e7d7.1760376569.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1760376569.git.fdmanana@suse.com>
References: <cover.1760376569.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We don't need it since we can grab fs_info from the given space_info.
So remove the fs_info argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 4c144b3a4a4c..0f619a588eb3 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -897,8 +897,7 @@ static void flush_space(struct btrfs_space_info *space_info, u64 num_bytes,
 	return;
 }
 
-static u64 btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
-					    const struct btrfs_space_info *space_info)
+static u64 btrfs_calc_reclaim_metadata_size(const struct btrfs_space_info *space_info)
 {
 	u64 used;
 	u64 avail;
@@ -1138,7 +1137,7 @@ static void do_async_reclaim_metadata_space(struct btrfs_space_info *space_info)
 		final_state = COMMIT_TRANS;
 
 	spin_lock(&space_info->lock);
-	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info);
+	to_reclaim = btrfs_calc_reclaim_metadata_size(space_info);
 	if (!to_reclaim) {
 		space_info->flush = false;
 		spin_unlock(&space_info->lock);
@@ -1156,8 +1155,7 @@ static void do_async_reclaim_metadata_space(struct btrfs_space_info *space_info)
 			spin_unlock(&space_info->lock);
 			return;
 		}
-		to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info,
-							      space_info);
+		to_reclaim = btrfs_calc_reclaim_metadata_size(space_info);
 		if (last_tickets_id == space_info->tickets_id) {
 			flush_state++;
 		} else {
@@ -1493,7 +1491,7 @@ static void priority_reclaim_metadata_space(struct btrfs_space_info *space_info,
 	int flush_state = 0;
 
 	spin_lock(&space_info->lock);
-	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info);
+	to_reclaim = btrfs_calc_reclaim_metadata_size(space_info);
 	/*
 	 * This is the priority reclaim path, so to_reclaim could be >0 still
 	 * because we may have only satisfied the priority tickets and still
-- 
2.47.2


