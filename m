Return-Path: <linux-btrfs+bounces-10233-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 692F59ECF13
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 15:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446AE168397
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 14:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C41F1D5CF4;
	Wed, 11 Dec 2024 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyhThOgf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAF91D3576
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928818; cv=none; b=PN4LqFs5iIraCFhzGZFVVo13/c+eIdfE2n8wHwA/BbgnCs1kRNh3nR7BPwimDUVCAOUJEiGF7NEZ1tuNbKj3AZxaMrEf+E9BelgNWaoEzHWSVJOpRYijnoOX2r22lej0svziVBeLREN9QflyNK9U6/cf4YVXVgiQdH4ueulVqxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928818; c=relaxed/simple;
	bh=wlztWU2/5Sh2XLcOIFFf2g8YfNNaC4Gx+8q51GvVDo0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c4v3CvS/wMyRgnEaGXCvFFZK53tZHCjgJiDP+SzLqdnltVOQ0SPFKBsG8569O9JZTzsAiVUuESTyO9mAJ1InjUq3atJVz1fx69l03l3LSosbIU1ws0Juud2dsTkJjn21ai8omvdBfKo9X5XzXJpbSJJwzn1cUi7h3FL5x2PtHSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyhThOgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F5EC4CEDD
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 14:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733928817;
	bh=wlztWU2/5Sh2XLcOIFFf2g8YfNNaC4Gx+8q51GvVDo0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fyhThOgfWYSDTfslod/bMAGS0zjYgJI5k4tiqSruzR3Ub2qtU59MRgYeIo+56vBQx
	 ptZ1on9Znh+yGAkSSJ4aft+isCgcAKR4pWblBLst75vjzN1QzWYVOgChhEKGMsi9Yt
	 AizzSSpf5iFYifIw6XcGknfLdKVATcrrCNBvpC4vRjZVYO8L4/ZaNGDWLlW4gaM4yg
	 YI7cf9f9UquRwMUNtj2Mn0+jMoE5p/UR8ypcJJn9qUkqTfKjJ/Mtju0oA+yzN5aMT8
	 FwwpTzhlX4RVWj8IEdG6Vn+b8mFVx9AzETPO1VffhJOaLF5M/GD/gNjgK2xr9o/vss
	 fHsW3jZXuLPtg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 06/11] btrfs: remove the snapshot check from check_committed_ref()
Date: Wed, 11 Dec 2024 14:53:23 +0000
Message-Id: <acf98d83138ad5674f5924bb653f6b9d64754dda.1733832118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733832118.git.fdmanana@suse.com>
References: <cover.1733832118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At check_committed_ref() we have this check to see if the data extent was
created in a generation lower than or equals to the generation where the
last snapshot for the root was created, and if so we return immediately
with 1, since it's very likely the extent is shared, referenced by other
root.

The only call chain for check_committed_ref() is the following:

   can_nocow_file_extent()
      btrfs_cross_ref_exist()
         check_committed_ref()

And we already do that snapshot check at can_nocow_file_extent(), before
we call btrfs_cross_ref_exist(). This makes the check done at
check_committed_ref() redundant, so remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 46a3a4a4536b..e81f4615ccdf 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2358,14 +2358,6 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 	if (item_size != expected_size)
 		goto out;
 
-	/*
-	 * If extent created before last snapshot => it's shared unless the
-	 * snapshot has been deleted.
-	 */
-	if (btrfs_extent_generation(leaf, ei) <=
-	    btrfs_root_last_snapshot(&root->root_item))
-		goto out;
-
 	/* If this extent has SHARED_DATA_REF then it's shared */
 	type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_DATA);
 	if (type != BTRFS_EXTENT_DATA_REF_KEY)
-- 
2.45.2


