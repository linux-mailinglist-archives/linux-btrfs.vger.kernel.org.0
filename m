Return-Path: <linux-btrfs+bounces-2502-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A4485A2A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 12:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1733FB20DA5
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 11:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2149D2D05F;
	Mon, 19 Feb 2024 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWkuIyFD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED3F2D04B
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343977; cv=none; b=NJQiBw3GIMaWqd1v4wXrmrHs0G3DVSWn6gxA328i5qF1q9hG5rSfDkMmoUpCbH956isDTyXdm6V2h+/F/ps+2ZHbTuD6UNNTZvRH+dfLYzieVfv81Vo0JlAjc8pRM42dbDiTfpAHE4jYXLY/sVyjEXWUQ+5W2/Gtzun/ywK2HoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343977; c=relaxed/simple;
	bh=Koc7uwLBUIxkp4NjDrOkrM13dOKjKdOJ689HwILR4qM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YE32EmQF/Rk3Bbcw6NQAfmmdzUZTViy5yUFlHIcFPnFdxhdIHUNRooITRO+Xvyrh/pS3soQ+rTfLxkdit63JxQud49eBI3AlHe8ZZ6fxF+zxKZGbWuJbo/P++qBPSmJCBJzsFflp0i3tNK9z/eEPHyn+WTr75htSqYwVH8IFcF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWkuIyFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356A9C43394
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 11:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708343976;
	bh=Koc7uwLBUIxkp4NjDrOkrM13dOKjKdOJ689HwILR4qM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dWkuIyFDNpJTjDhM7qtkpdGU4Cq5zZaWPWXN1U49TTWqoYdRbQ6qlDVtJI6U1qgf5
	 XD6ClP4e9/5RyhV+1nOb0VHZwSMUPwHozG0vNAw7cUZg1QNVJ+Q9CqB67cqEZlVopL
	 hbiiWfer1tMghEAwf+KU58MVU3Qdl6Z4e+QhXTFNJh0/1EysFUWQKHRVl+bFvEdkeA
	 p7lpze+P5RqowzWkjCNQKYAmf5vLZG4IV/VpR9RSWmcDLKwHku/Ll3+w6py7taRr3E
	 OhhFt7iOpDZOqO3azAOchwBo21J0qbXkTIaXk7iLxjXIhTb7xkjj1dYMfYCISlzFFu
	 COqe/HU7x9nuQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: send: avoid duplicated search for last extent when sending hole
Date: Mon, 19 Feb 2024 11:59:31 +0000
Message-Id: <ab523d24c8c469b957c820efca7efd4dd466ac77.1708260967.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1708260967.git.fdmanana@suse.com>
References: <cover.1708260967.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

During an incremental send, before determining if we need to send a hole
(write operations full of zeroes) we will search for the last extent's
end offset if we are at the first slot of a leaf and the last processed
extent's end offset is smaller then the current extent's start offset.
However we are repeating this search in case we had the last extent's end
offset undefined (set to the (u64)-1 value) when we entered
maybe_send_hole(), wasting time.

So avoid this duplicated search by combining the two conditions that
trigger a search for the last extent's end offset into a single if
statement.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index dc18d5624ec7..a5da096c64fe 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6476,21 +6476,18 @@ static int maybe_send_hole(struct send_ctx *sctx, struct btrfs_path *path,
 	if (sctx->cur_ino != key->objectid || !need_send_hole(sctx))
 		return 0;
 
-	if (sctx->cur_inode_last_extent == (u64)-1) {
-		ret = get_last_extent(sctx, key->offset - 1);
-		if (ret)
-			return ret;
-	}
-
-	if (path->slots[0] == 0 &&
-	    sctx->cur_inode_last_extent < key->offset) {
-		/*
-		 * We might have skipped entire leafs that contained only
-		 * file extent items for our current inode. These leafs have
-		 * a generation number smaller (older) than the one in the
-		 * current leaf and the leaf our last extent came from, and
-		 * are located between these 2 leafs.
-		 */
+	/*
+	 * Get last extent's end offset (exclusive) if we haven't determined it
+	 * yet (we're processing the first file extent item that is new), or if
+	 * we're at the first slot of a leaf and the last extent's end is less
+	 * than the current extent's offset, because we might have skipped
+	 * entire leaves that contained only file extent items for our current
+	 * inode. These leaves have a generation number smaller (older) than the
+	 * one in the current leaf and the leaf our last extent came from, and
+	 * are located between these 2 leaves.
+	 */
+	if ((sctx->cur_inode_last_extent == (u64)-1) ||
+	    (path->slots[0] == 0 && sctx->cur_inode_last_extent < key->offset)) {
 		ret = get_last_extent(sctx, key->offset - 1);
 		if (ret)
 			return ret;
-- 
2.40.1


