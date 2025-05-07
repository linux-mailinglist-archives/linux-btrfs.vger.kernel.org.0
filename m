Return-Path: <linux-btrfs+bounces-13801-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5FBAAE7BC
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 19:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F263AA6C9
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 17:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE56328C5BE;
	Wed,  7 May 2025 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuGa87De"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1992928C84F
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638605; cv=none; b=mHD2/Ci9BuItvPg9hnnQZWkVfA0Du7kBQ72Ig+VSLIuXknJaK4S267cOkfZ9TNTXn4hObtc+RoKjbhZcatbscEbV5know3qurxkSp9yGDj1N5iBxmbT/UHr7ePw2cKxuaOWLlvNeJDO8O07Wyt0Gd1t4k3n9kdEKLuc7Bu/Is2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638605; c=relaxed/simple;
	bh=5IzRHjYE3w+N++IXRSI/s3rXeF8vNYJErdG1Sr/Bt/Q=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h9mk1gcD+Fdn+gwse2I8N+GThYyIbg4Fp1FaPaNzjguthgzAf8BkwCGdg+eYQbp+9eI7pPlHXE2anU+7JKk6pYJete9rbJq/nM34eeTtzNGf59NV9S3NeRbB4Zzz0f/2F7iNL5g7YffeRSAZCvbpy3VAe9IWxCJ297H8lUoF068=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuGa87De; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB19C4CEE2
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 17:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746638604;
	bh=5IzRHjYE3w+N++IXRSI/s3rXeF8vNYJErdG1Sr/Bt/Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KuGa87DeUWHl6U68dIEDIkvjrZVeFkHOhCJwTQEKQD5FsHCeGQWJHlbOh/VSQV7OU
	 DaEqdU1s+V6k5j4XUaPcRZ5eqHN3FThFR3o/f7qD1m0jq2Wm1sF3sEfPvSLNm6Zskd
	 ZfcmXfuOq99SxwJOv/Z3wlUlDRmjoQ8+BBnu5a/ox2h/KqffkUB1ysHJQNRgeAKyAl
	 nO/lodP8nG4Kpo44fdqbroH27zYcRocHfoVob/J0vmocALSFAFMUTXvWJljuLZ5ZIo
	 Bp1yopPftTn10votoZJIpalP0t852mhPjks8Mb7t39Iaf2N7x2dYkE+p2wPt5gtlO0
	 Cc5RlVHDquB1Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs: fold error checks when allocating ordered extent and update comments
Date: Wed,  7 May 2025 18:23:15 +0100
Message-Id: <0d85a63e06a92f413b0566a037fade89c78a363e.1746638347.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746638347.git.fdmanana@suse.com>
References: <cover.1746638347.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of having an error check and return on each branch of the if
statement, move the error check to happen after that if branch, reducing
source code and object code sizes.

Before this change:

   $ size fs/btrfs/btrfs.ko
      text	   data	    bss	    dec	    hex	filename
   1840174	 163742	  16136	2020052	 1ed2d4	fs/btrfs/btrfs.ko

After this change:

   $ size fs/btrfs/btrfs.ko
      text	   data	    bss	    dec	    hex	filename
   1840138	 163742	  16136	2020016	 1ed2b0	fs/btrfs/btrfs.ko

While at it and moving the comments, update the comments to be more clear
about how qgroup reserved space is released and the intricacies of how
it's managed for COW writes.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ordered-data.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index a6c5fc78bc4f..477366eac164 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -156,20 +156,22 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	const bool is_nocow = (flags &
 	       ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC)));
 
-	if (is_nocow) {
-		/* For nocow write, we can release the qgroup rsv right now */
+	/*
+	 * For a nocow write we can free the qgroup reserve right now. For a cow
+	 * one we transfer the reserved space from the inode's iotree into the
+	 * ordered extent by calling btrfs_qgroup_release_data() and tracking
+	 * the qgroup reserved amount in the ordered extent, so that later after
+	 * completing the ordered extent, when running the data delayed ref it
+	 * creates, we free the reserved data with btrfs_qgroup_free_refroot().
+	 */
+	if (is_nocow)
 		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes, &qgroup_rsv);
-		if (ret < 0)
-			return ERR_PTR(ret);
-	} else {
-		/*
-		 * The ordered extent has reserved qgroup space, release now
-		 * and pass the reserved number for qgroup_record to free.
-		 */
+	else
 		ret = btrfs_qgroup_release_data(inode, file_offset, num_bytes, &qgroup_rsv);
-		if (ret < 0)
-			return ERR_PTR(ret);
-	}
+
+	if (ret < 0)
+		return ERR_PTR(ret);
+
 	entry = kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS);
 	if (!entry) {
 		entry = ERR_PTR(-ENOMEM);
-- 
2.47.2


