Return-Path: <linux-btrfs+bounces-17703-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E8CBD2E77
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 14:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C61A3C36CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 12:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4405A26F28C;
	Mon, 13 Oct 2025 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpPykV79"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EB826CE10
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760357141; cv=none; b=dKLJxHbrYwlAOJ11Cu3dHC3F7lX0pINS3XeIX2GbP+o0DgyVAsFYrkHrNl79aJAODAzi2X4FTWekD4FvTAHFYV/OW2oQXuwHB2bN8uHXRxmia1qJQliX8AfEFurSwA2MbXE4kTRp2dH3R6EaJ1dIIIU9Q6hmtIVDkhLp3SM3zy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760357141; c=relaxed/simple;
	bh=gYfrbSQ2YvF3hxHeprdwMBXeQ/KaUM687xa9UDo37bI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bewbeS6/pYs5wvGMDz/nGnb6djSKGG8hrpUUaAsPZnLpE770XxtLj6G/98TfN0k/vHZXWJ9ODAfMlZ1yD32Btya5TAI2Bd38uoukkMQUeoHQY4wDUI2vgFXkyo8ht7yJK75/BuTn/DYdMbuzt4dhfFZIt0Sh3GKporQND5agaJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpPykV79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86B7C4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 12:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760357141;
	bh=gYfrbSQ2YvF3hxHeprdwMBXeQ/KaUM687xa9UDo37bI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bpPykV79y1hWKuHPDtwiuMg5EAGVy4GIqxUFFXv+TmhNwFHh7Ap3y1RgMR6FtO8qa
	 EkUsBj1Ft4Uv70SSSD3xfoWo14GlBCZB0Txf0K+TWQ6OFo3hhzBR/Kdnj0ps3ITbjb
	 U/YR1pvW77VMv6gQcF5zfH2A9bD6x6VZ2fChV+KEpy2JfF4piAVhHeSQSoG+TyP6ES
	 askHzosBicWHR5hbfKXDoUpts2GGne7pCaE61R9fZmRQLsGvh2buX1OqzKUf92pA3q
	 1/MlPmFcCSwbtMFmiVYbVV3sh8GnjQc80hTMr0Q6v5XRGKNIU5wL/3Lbk5FV521kDh
	 b6mxYg5cqK5WA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/7] btrfs: consistently round up or down i_size in btrfs_truncate()
Date: Mon, 13 Oct 2025 13:05:30 +0100
Message-ID: <04e60398648115da47d20f9741c1a3668a18092a.1760356778.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1760356778.git.fdmanana@suse.com>
References: <cover.1760356778.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We're using different ways to round down the i_size by sector size, one
with a bitwise and with a negated mask and another with ALIGN_DOWN(), and
using ALIGN() to round up.

Replace these uses with the round_down() and round_up() macros which have
have names that make it clear the direction of the rounding (unlike the
ALIGN() macro) and getting rid of the bitwise and, negated mask and local
variable for the mask.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ac2fd589697d..4a4cb91b7586 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7649,12 +7649,12 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 	struct btrfs_block_rsv rsv;
 	int ret;
 	struct btrfs_trans_handle *trans;
-	u64 mask = fs_info->sectorsize - 1;
 	const u64 min_size = btrfs_calc_metadata_size(fs_info, 1);
 
 	if (!skip_writeback) {
 		ret = btrfs_wait_ordered_range(inode,
-					       inode->vfs_inode.i_size & (~mask),
+					       round_down(inode->vfs_inode.i_size,
+							  fs_info->sectorsize),
 					       (u64)-1);
 		if (ret)
 			return ret;
@@ -7720,7 +7720,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 	while (1) {
 		struct extent_state *cached_state = NULL;
 		const u64 new_size = inode->vfs_inode.i_size;
-		const u64 lock_start = ALIGN_DOWN(new_size, fs_info->sectorsize);
+		const u64 lock_start = round_down(new_size, fs_info->sectorsize);
 
 		control.new_size = new_size;
 		btrfs_lock_extent(&inode->io_tree, lock_start, (u64)-1, &cached_state);
@@ -7730,7 +7730,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 		 * block of the extent just the way it is.
 		 */
 		btrfs_drop_extent_map_range(inode,
-					    ALIGN(new_size, fs_info->sectorsize),
+					    round_up(new_size, fs_info->sectorsize),
 					    (u64)-1, false);
 
 		ret = btrfs_truncate_inode_items(trans, root, &control);
-- 
2.47.2


