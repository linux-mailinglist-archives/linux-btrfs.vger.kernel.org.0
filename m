Return-Path: <linux-btrfs+bounces-12725-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F29A77EF2
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 17:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB7C07A3ED6
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 15:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BE820B819;
	Tue,  1 Apr 2025 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZ0S3XCU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E91E20AF9A
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521401; cv=none; b=mb84Q45nLgpWN13+/rAF9VNjPH1j9+K2DgO7is5gRvI0Tm9Hbsb/Rp8ENAaK8VQDIyo7VX0VUQBnGKGza1rLQd8k0tcBnp/4TLoAqXdJk5V8WimFeShMqWSaFk774i25uD7uwsDSX89+cnaI/nKjcOltJMNGqWAo1Tk7XSb91hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521401; c=relaxed/simple;
	bh=yvZKDBlzp1G5+LwhBSkslc8fSzVM2lgfFuUGMCeIzuY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ETyWV++tXMm4iAOhMzwA+YoFnr+s7sNXnGGg/6qqt7AYEBPuhh/Cep3BD6c6Yo5aUvJV5PurWuiOjuvt2MCWhUa22meRf7JGhhj7x9q3gln5axS3kbr8hxSgVRQWBCnUHzEK8NBMjgC+qNx/W/GKLwu5LmgrlbSa6us8btDQl5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZ0S3XCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CC4C4CEE5
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 15:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743521400;
	bh=yvZKDBlzp1G5+LwhBSkslc8fSzVM2lgfFuUGMCeIzuY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eZ0S3XCUKuP50BRyVFHMt29ostgoED2ii7u+gkq2dZATXoY9hNSyfUG24wmyYDLZt
	 fIGruaUNrWewJKzfI0mLiOhkkX8yUtmvinh5BaL7bb4b8PjIq0G6Fg41ReDCGqN94W
	 5gljzAotVFHckPNq9PkAxj08xHzWxi563UU6mgR4aLLJodLU266dCXdR9E7SDJuvKI
	 rvCV9Ov80Qgb/SsYRV083HKfC/ETqaH4S/8LyQ69g4Wv1xqGgjSjvODnrcheEJsusb
	 5O/M0GXmmPbgrpn0W7LtavJeGm2r8pSXfCgNI66swg07csyf73AHdwsHhcgyrZEUYV
	 BlVwuicMIctZQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/4] btrfs: use clear_extent_bits() instead of clear_extent_bit() where possible
Date: Tue,  1 Apr 2025 16:29:53 +0100
Message-Id: <20bbc920db163134d7dea30023532f1f9e97e4c7.1743521098.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743521098.git.fdmanana@suse.com>
References: <cover.1743521098.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Several places are using clear_extent_bit() and passing a NULL value for
the 'cached' argument, which is pointless as they can use instead
clear_extent_bits().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c             |  3 +--
 fs/btrfs/reflink.c           |  5 ++---
 fs/btrfs/tests/inode-tests.c | 24 ++++++++++++------------
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 95d29b9282ba..836dca07a06f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1753,8 +1753,7 @@ static int fallback_to_cow(struct btrfs_inode *inode,
 		spin_unlock(&sinfo->lock);
 
 		if (count > 0)
-			clear_extent_bit(io_tree, start, end, EXTENT_NORESERVE,
-					 NULL);
+			clear_extent_bits(io_tree, start, end, EXTENT_NORESERVE);
 	}
 	unlock_extent(io_tree, start, end, &cached_state);
 
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 15c296cb4dac..09e40a2fdcf0 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -95,9 +95,8 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 	if (ret < 0)
 		goto out_unlock;
 
-	clear_extent_bit(&inode->io_tree, file_offset, range_end,
-			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
-			 NULL);
+	clear_extent_bits(&inode->io_tree, file_offset, range_end,
+			  EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG);
 	ret = btrfs_set_extent_delalloc(inode, file_offset, range_end, 0, NULL);
 	if (ret)
 		goto out_unlock;
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index 8142a84129b6..09ba6e279d24 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -949,10 +949,10 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	}
 
 	/* [BTRFS_MAX_EXTENT_SIZE/2][sectorsize HOLE][the rest] */
-	ret = clear_extent_bit(&BTRFS_I(inode)->io_tree,
-			       BTRFS_MAX_EXTENT_SIZE >> 1,
-			       (BTRFS_MAX_EXTENT_SIZE >> 1) + sectorsize - 1,
-			       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW, NULL);
+	ret = clear_extent_bits(&BTRFS_I(inode)->io_tree,
+				BTRFS_MAX_EXTENT_SIZE >> 1,
+				(BTRFS_MAX_EXTENT_SIZE >> 1) + sectorsize - 1,
+				EXTENT_DELALLOC | EXTENT_DELALLOC_NEW);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1016,10 +1016,10 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	}
 
 	/* [BTRFS_MAX_EXTENT_SIZE+4k][4K HOLE][BTRFS_MAX_EXTENT_SIZE+4k] */
-	ret = clear_extent_bit(&BTRFS_I(inode)->io_tree,
-			       BTRFS_MAX_EXTENT_SIZE + sectorsize,
-			       BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1,
-			       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW, NULL);
+	ret = clear_extent_bits(&BTRFS_I(inode)->io_tree,
+				BTRFS_MAX_EXTENT_SIZE + sectorsize,
+				BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1,
+				EXTENT_DELALLOC | EXTENT_DELALLOC_NEW);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1050,8 +1050,8 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	}
 
 	/* Empty */
-	ret = clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
-			       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW, NULL);
+	ret = clear_extent_bits(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
+				EXTENT_DELALLOC | EXTENT_DELALLOC_NEW);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1065,8 +1065,8 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	ret = 0;
 out:
 	if (ret)
-		clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
-				 EXTENT_DELALLOC | EXTENT_DELALLOC_NEW, NULL);
+		clear_extent_bits(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
+				  EXTENT_DELALLOC | EXTENT_DELALLOC_NEW);
 	iput(inode);
 	btrfs_free_dummy_root(root);
 	btrfs_free_dummy_fs_info(fs_info);
-- 
2.45.2


