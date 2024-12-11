Return-Path: <linux-btrfs+bounces-10241-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BAA9ECF4F
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 16:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9BE1888E04
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 15:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BC41AAA1F;
	Wed, 11 Dec 2024 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZ19tcOZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0B324634E
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929514; cv=none; b=qdGUoQHa6OSHyMQk7n/bblb6IcpdjYGQwS9mfy8W6v0cgfRE4nRhe0TO3XNJsxtITV0KsLfja55p5dykvtJ4KFUQa9RM9EfFkoByEP2uICmc/jgjwo6LVgxM7zh8erQI8FtXR5gy1IakS3GR0wImWk6/inawv3MkvP+whamAlPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929514; c=relaxed/simple;
	bh=e5FY9cFPOz7HTCMHUO8Q9Tyjy0uK6qB42bpCRh5M0uY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i/NLJfsSWEahZs5Zg5TATbTHrg1+da+Q17AkNRvpUgtjwVhearuSk86lRfiDeZywTHbbfTS3Hc6W8nB8sGfw9++FVgfzA3D41H/GhmYBXFnlCQFUpvIrWsF1517OqQV7o6Ou+b6nLp0te5bQOaHKSOMN+xPa5Cj3n2nKv5+83DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZ19tcOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CE8C4CED4
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 15:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733929512;
	bh=e5FY9cFPOz7HTCMHUO8Q9Tyjy0uK6qB42bpCRh5M0uY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bZ19tcOZ0FUCCFXIMp3vKm5r53DxpKhRv+2B/wgLKu03ATlw9d/rh23+ylZDnF+7Z
	 /Z4V01hrsQvlgAQADLKdbfkWPWBeVhEFDnr9fRmHcA4DQSzv1jJY51kMZQACwTvNrO
	 ++OYUHMBLncRQUc6vOJaaQeXbhuKDut9GqUWtxumbHBY+1dabbS4d0Yn1nJgNzfYXC
	 FLEDLtdkxvJycr7WdMCv4CIzA7Rbc8w6GVtmO0VxYp0FvfKIMimIOhtE1qYmgWtPQQ
	 IJFSp+GRqr/bW5R2CJ9SqnMchRdhLgSglV666YqXzY29u1T4jUWv/h7VDbTYyEgVEQ
	 q3BWMwEfr7fgg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 01/11] btrfs: fix race with memory mapped writes when activating swap file
Date: Wed, 11 Dec 2024 15:04:58 +0000
Message-Id: <d9b16e6bcd3eed8e5e5fe740e1a48335fd48b636.1733929327.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733929327.git.fdmanana@suse.com>
References: <cover.1733929327.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When activating the swap file we flush all delalloc and wait for ordered
extent completion, so that we don't miss any delalloc and extents before
we check that the file's extent layout is usable for a swap file and
activate the swap file. We are called with the inode's VFS lock acquired,
so we won't race with buffered and direct IO writes, however we can still
race with memory mapped writes since they don't acquire the inode's VFS
lock. The race window is between flushing all delalloc and locking the
whole file's extent range, since memory mapped writes lock an extent range
with the length of a page.

Fix this by acquiring the inode's mmap lock before we flush delalloc.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c4997200dbb2..926d82fbdbae 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9809,6 +9809,15 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	u64 isize;
 	u64 start;
 
+	/*
+	 * Acquire the inode's mmap lock to prevent races with memory mapped
+	 * writes, as they could happen after we flush delalloc below and before
+	 * we lock the extent range further below. The inode was already locked
+	 * up in the call chain.
+	 */
+	btrfs_assert_inode_locked(BTRFS_I(inode));
+	down_write(&BTRFS_I(inode)->i_mmap_lock);
+
 	/*
 	 * If the swap file was just created, make sure delalloc is done. If the
 	 * file changes again after this, the user is doing something stupid and
@@ -9816,22 +9825,25 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	 */
 	ret = btrfs_wait_ordered_range(BTRFS_I(inode), 0, (u64)-1);
 	if (ret)
-		return ret;
+		goto out_unlock_mmap;
 
 	/*
 	 * The inode is locked, so these flags won't change after we check them.
 	 */
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_COMPRESS) {
 		btrfs_warn(fs_info, "swapfile must not be compressed");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_unlock_mmap;
 	}
 	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW)) {
 		btrfs_warn(fs_info, "swapfile must not be copy-on-write");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_unlock_mmap;
 	}
 	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
 		btrfs_warn(fs_info, "swapfile must not be checksummed");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_unlock_mmap;
 	}
 
 	/*
@@ -9846,7 +9858,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_SWAP_ACTIVATE)) {
 		btrfs_warn(fs_info,
 	   "cannot activate swapfile while exclusive operation is running");
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out_unlock_mmap;
 	}
 
 	/*
@@ -9860,7 +9873,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		btrfs_exclop_finish(fs_info);
 		btrfs_warn(fs_info,
 	   "cannot activate swapfile because snapshot creation is in progress");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_unlock_mmap;
 	}
 	/*
 	 * Snapshots can create extents which require COW even if NODATACOW is
@@ -9881,7 +9895,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		btrfs_warn(fs_info,
 		"cannot activate swapfile because subvolume %llu is being deleted",
 			btrfs_root_id(root));
-		return -EPERM;
+		ret = -EPERM;
+		goto out_unlock_mmap;
 	}
 	atomic_inc(&root->nr_swapfiles);
 	spin_unlock(&root->root_item_lock);
@@ -10036,6 +10051,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 
 	btrfs_exclop_finish(fs_info);
 
+out_unlock_mmap:
+	up_write(&BTRFS_I(inode)->i_mmap_lock);
 	if (ret)
 		return ret;
 
-- 
2.45.2


