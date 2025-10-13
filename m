Return-Path: <linux-btrfs+bounces-17704-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E47F8BD2E7A
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 14:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589363C36E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 12:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE9426CE3B;
	Mon, 13 Oct 2025 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7zGCkCP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5855D26CE2C
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760357142; cv=none; b=qMyStilgCc8FwwOxh/wGnmXBHr8V2E2gMmKLQ5xILw/2ZMeuR8aoHvfLsKHwMnl2V8Q+zmstXToyX+WpTyKBPvaeCR/RqUD9KBJGaXZlTIduSJb1xRxzffUyK6F2/v3h/uLV3no83/phjPwr0FpuouW/VmTFRZIUxZpVt3SPtQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760357142; c=relaxed/simple;
	bh=bhtGkFWvg8MEwJHuaK4rCjJ/zjNOcI5uoeRCH9trMPg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDS4PNqUqpFE0xryyn4YvRPmAN4hQKnAhTvP0DXO8PUpftd6RcCenz6dCuJePrn2wr0ILrTzYL1VetWZ5oaTlZr7Wu1GKnSRwJ1l7vAuUHOcQynjoiJn3/ASRqacd/R5E/1aas4MVH0OEDBpoVG49BUmE92vtHT9SHUydQwYA7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7zGCkCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74FBC4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 12:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760357142;
	bh=bhtGkFWvg8MEwJHuaK4rCjJ/zjNOcI5uoeRCH9trMPg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=n7zGCkCPT8EHheYRoJIKt53/v+DklI1iNc1p1Iq3YxB6XRZhmpPivyEGSk7RBswaH
	 Vko9abBO3UZnCj915upQFfXf9jhhxEpljk2II5P6rRuiUxW3kO+udXNzf5VCVqiJFD
	 xYmQzAA1L9b6BK4yGs+834K2Q4ED/+k9TRxi0Fvd9SJHyuFSIUlpemJ3Rbfwq9de/g
	 243t3Dt6KzmMetomqIMNVvC/nd2H5ORHP3aQQ6ZoyFqTbA7132pAv1Sk0mmJcE/HmP
	 WgoAwhI7bn+b5Z+ifXt7HFbwzDlj9ZD3xrjIfa+nFuayouJv41OJg+AKTygXNPvOrd
	 IOFC+4n3w1Nig==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/7] btrfs: avoid multiple i_size rounding in btrfs_truncate()
Date: Mon, 13 Oct 2025 13:05:31 +0100
Message-ID: <612de94ba1f20516b12b89e9ceb7e1defa1babae.1760356778.git.fdmanana@suse.com>
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

We have the inode locked so no one can concurrently change its i_size and
neither do we change it ourselves, so there's no point in keep rounding
it in the while loop and setting it up in the control structure. That only
causes confusion when reading the code.

So move all the i_size setup and rounding out of the loop and assert the
inode is locked.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4a4cb91b7586..096b995fe87b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7643,6 +7643,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 		.ino = btrfs_ino(inode),
 		.min_type = BTRFS_EXTENT_DATA_KEY,
 		.clear_extent_range = true,
+		.new_size = inode->vfs_inode.i_size,
 	};
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -7650,12 +7651,14 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 	int ret;
 	struct btrfs_trans_handle *trans;
 	const u64 min_size = btrfs_calc_metadata_size(fs_info, 1);
+	const u64 lock_start = round_down(inode->vfs_inode.i_size, fs_info->sectorsize);
+	const u64 i_size_up = round_up(inode->vfs_inode.i_size, fs_info->sectorsize);
+
+	/* Our inode is locked and the i_size can't be changed concurrently. */
+	btrfs_assert_inode_locked(inode);
 
 	if (!skip_writeback) {
-		ret = btrfs_wait_ordered_range(inode,
-					       round_down(inode->vfs_inode.i_size,
-							  fs_info->sectorsize),
-					       (u64)-1);
+		ret = btrfs_wait_ordered_range(inode, lock_start, (u64)-1);
 		if (ret)
 			return ret;
 	}
@@ -7719,19 +7722,14 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 
 	while (1) {
 		struct extent_state *cached_state = NULL;
-		const u64 new_size = inode->vfs_inode.i_size;
-		const u64 lock_start = round_down(new_size, fs_info->sectorsize);
 
-		control.new_size = new_size;
 		btrfs_lock_extent(&inode->io_tree, lock_start, (u64)-1, &cached_state);
 		/*
 		 * We want to drop from the next block forward in case this new
 		 * size is not block aligned since we will be keeping the last
 		 * block of the extent just the way it is.
 		 */
-		btrfs_drop_extent_map_range(inode,
-					    round_up(new_size, fs_info->sectorsize),
-					    (u64)-1, false);
+		btrfs_drop_extent_map_range(inode, i_size_up, (u64)-1, false);
 
 		ret = btrfs_truncate_inode_items(trans, root, &control);
 
-- 
2.47.2


