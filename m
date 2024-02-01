Return-Path: <linux-btrfs+bounces-2021-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E357845A72
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 15:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E261C247F7
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 14:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED2D5D497;
	Thu,  1 Feb 2024 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBDeace2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54FA2B9AC
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798540; cv=none; b=MZlQBlTR0vy8HjXCSuetbZk0KPA2tOd5SEJIiA7uQN01uXhok1oU3aD3vVR/ErRJ4r1BsyD2Ygtk3GivStrUBvVsiq1yatOudADCq9dtrA9PAKvKGak0n3FNl7zeUxoyt2RV/EtVJJdEF0hCJw9CpawthOHV9npUbeiMXWof2c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798540; c=relaxed/simple;
	bh=ileIL9YIexF2ElKJ3yqkFVkA/yiZ5aLFCFd6vVbv0rU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=uyBpJs8HFakJqeKoCgf/N6nvqFyIKyOKeRt0t20S7NNEettPzuhBGUMlyOLP6TIXXzStFiKs/3M/VsJmZnVOK5K3e02RdhoR+iLwBl3aHJISgMWfSe3Fa5wSy2aNOJqOMEbJAjsIml9NASy8uyu0/YNMV74qbgPZoPE2ADmgkfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBDeace2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94A8C433C7
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 14:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706798540;
	bh=ileIL9YIexF2ElKJ3yqkFVkA/yiZ5aLFCFd6vVbv0rU=;
	h=From:To:Subject:Date:From;
	b=bBDeace2DoTYIILJAeh1WklDyK/+YDAms9ULkfTwNjyL3i122VkM+uxyPB8XsLtW6
	 A/0v8o5DM81xNQJwXPbi50d7nji6KBmt1/PufHf4OS6o4bkSFAajjvj6FaTV2Nk7tA
	 FWNnQ/FOYEDt/zexW3Yzh/LKB1A9j3eLiigewNCORWF8+iUYgnDKtjNY0ONefbMVFM
	 rUeVkxo4wMM8onT99TjzQ9Ob6j1LVvf2b777TwtzFKhVh6BoCoY19xzuCdQUwaegbN
	 M8dU2Yehj0SChkK8xLzc4IzFn+/OkC9oYyVP/fjYyx0SXh3pQn7IFTcZHvIjyF0xc9
	 g/+u/aBUTODjA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: don't reserve space for checksums when writing to nocow files
Date: Thu,  1 Feb 2024 14:42:16 +0000
Message-Id: <9024eabd5bd2419cb4ca94f276a1c54a3b2c18cc.1706798197.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently when doing a write to a file we always reserve metadata space
for inserting data checksums. However we don't need to do it if we have
a nodatacow file (-o nodatacow mount option or chattr +C) or if checksums
are disabled (-o nodatasum mount option), as in that case we are only
adding unncessary pressure to metadata reservations.

For example on x86_64, with the default node size of 16K, a 4K buffered
write into a nodatacow file is reserving 655360 bytes of metadata space,
as it's accounting for checksums. After this change, which stops reserving
space for checksums if we have a nodatacow file or checksums are disabled,
we only need to reserve 393216 bytes of metadata.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delalloc-space.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 4a60a679d7b4..b3527efd0b4b 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -243,7 +243,6 @@ static void btrfs_calculate_inode_block_rsv_size(struct btrfs_fs_info *fs_info,
 	struct btrfs_block_rsv *block_rsv = &inode->block_rsv;
 	u64 reserve_size = 0;
 	u64 qgroup_rsv_size = 0;
-	u64 csum_leaves;
 	unsigned outstanding_extents;
 
 	lockdep_assert_held(&inode->lock);
@@ -258,10 +257,12 @@ static void btrfs_calculate_inode_block_rsv_size(struct btrfs_fs_info *fs_info,
 						outstanding_extents);
 		reserve_size += btrfs_calc_metadata_size(fs_info, 1);
 	}
-	csum_leaves = btrfs_csum_bytes_to_leaves(fs_info,
-						 inode->csum_bytes);
-	reserve_size += btrfs_calc_insert_metadata_size(fs_info,
-							csum_leaves);
+	if (!(inode->flags & BTRFS_INODE_NODATASUM)) {
+		u64 csum_leaves;
+
+		csum_leaves = btrfs_csum_bytes_to_leaves(fs_info, inode->csum_bytes);
+		reserve_size += btrfs_calc_insert_metadata_size(fs_info, csum_leaves);
+	}
 	/*
 	 * For qgroup rsv, the calculation is very simple:
 	 * account one nodesize for each outstanding extent
@@ -276,14 +277,20 @@ static void btrfs_calculate_inode_block_rsv_size(struct btrfs_fs_info *fs_info,
 	spin_unlock(&block_rsv->lock);
 }
 
-static void calc_inode_reservations(struct btrfs_fs_info *fs_info,
+static void calc_inode_reservations(struct btrfs_inode *inode,
 				    u64 num_bytes, u64 disk_num_bytes,
 				    u64 *meta_reserve, u64 *qgroup_reserve)
 {
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	u64 nr_extents = count_max_extents(fs_info, num_bytes);
-	u64 csum_leaves = btrfs_csum_bytes_to_leaves(fs_info, disk_num_bytes);
+	u64 csum_leaves;
 	u64 inode_update = btrfs_calc_metadata_size(fs_info, 1);
 
+	if (inode->flags & BTRFS_INODE_NODATASUM)
+		csum_leaves = 0;
+	else
+		csum_leaves = btrfs_csum_bytes_to_leaves(fs_info, disk_num_bytes);
+
 	*meta_reserve = btrfs_calc_insert_metadata_size(fs_info,
 						nr_extents + csum_leaves);
 
@@ -335,7 +342,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
 	 * everything out and try again, which is bad.  This way we just
 	 * over-reserve slightly, and clean up the mess when we are done.
 	 */
-	calc_inode_reservations(fs_info, num_bytes, disk_num_bytes,
+	calc_inode_reservations(inode, num_bytes, disk_num_bytes,
 				&meta_reserve, &qgroup_reserve);
 	ret = btrfs_qgroup_reserve_meta_prealloc(root, qgroup_reserve, true,
 						 noflush);
@@ -357,7 +364,8 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
 	nr_extents = count_max_extents(fs_info, num_bytes);
 	spin_lock(&inode->lock);
 	btrfs_mod_outstanding_extents(inode, nr_extents);
-	inode->csum_bytes += disk_num_bytes;
+	if (!(inode->flags & BTRFS_INODE_NODATASUM))
+		inode->csum_bytes += disk_num_bytes;
 	btrfs_calculate_inode_block_rsv_size(fs_info, inode);
 	spin_unlock(&inode->lock);
 
@@ -391,7 +399,8 @@ void btrfs_delalloc_release_metadata(struct btrfs_inode *inode, u64 num_bytes,
 
 	num_bytes = ALIGN(num_bytes, fs_info->sectorsize);
 	spin_lock(&inode->lock);
-	inode->csum_bytes -= num_bytes;
+	if (!(inode->flags & BTRFS_INODE_NODATASUM))
+		inode->csum_bytes -= num_bytes;
 	btrfs_calculate_inode_block_rsv_size(fs_info, inode);
 	spin_unlock(&inode->lock);
 
-- 
2.40.1


