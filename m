Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707C430D85C
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Feb 2021 12:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhBCLSj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Feb 2021 06:18:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234021AbhBCLSg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Feb 2021 06:18:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF4D664F6A
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Feb 2021 11:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612351074;
        bh=yq8wnwlglHlDuix1iQoTRsp8q8A7iSJniFO1ZuPkI9w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=k/QkkHweLypvNkjvt9QUSKrU2Qwok++I1JKvq/+Tu5AeLa0RbxnySlqxh6Dcdx3RD
         XG0K+W17qA4BAn6QPGPkSv4Zwdvl0ImAnaUZJLwccz9NlfAmzu7T5C8ukz+Tco1zzW
         s1fKD5+LAzlIX9yZrYv1m2i46Cit1mokL5BYOQwzZfMJhzXPINENwphlHOA8UUB86d
         08K9dyEn+LsTROS3w5ReU6Bg7snWX+NtI7RGNaQ8vtVjb8D7PmudIMSNV88abmBUnE
         I9pmTxDum2dS7b5Z06/R4YOHijhQx3dhr7vPTnvsq7JBpEh9fS6VSxN1LhkLNmrBhQ
         xFmA9ReLunK9A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: fix race between swap file activation and snapshot creation
Date:   Wed,  3 Feb 2021 11:17:47 +0000
Message-Id: <84a80739d04185bc50a4f911d2284d3b9f80cf4a.1612350698.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612350698.git.fdmanana@suse.com>
References: <cover.1612350698.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When creating a snapshot we check if the current number of swap files, in
the root, is non-zero, and if it is, we error out and warn that we can not
create the snapshot because there are active swap files.

However this is racy because when a task started activation of a swap
file, another task might have started already snapshot creation and might
have seen the counter for the number of swap files as zero. This means
that after the swap file is activated we may end up with a snapshot of the
same root successfully created, and therefore when the first write to the
swap file happens it has to fall back into COW mode, which should never
happen for active swap files.

Basically what can happen is:

1) Task A starts snapshot creation and enters ioctl.c:create_snapshot().
   There it sees that root->nr_swapfiles has a value of 0 so it continues;

2) Task B enters btrfs_swap_activate(). It is not aware that another task
   started snapshot creation but it did not finish yet. It increments
   root->nr_swapfiles from 0 to 1;

3) Task B checks that the file meets all requirements to be an active
   swap file - it has NOCOW set, there are no snapshots for the inode's
   root at the moment, no file holes, no reflinked extents, etc;

4) Task B returns success and now the file is an active swap file;

5) Task A commits the transaction to create the snapshot and finishes.
   The swap file's extents are now shared between the original root and
   the snapshot;

6) A write into an extent of the swap file is attempted - there is a
   snapshot of the file's root, so we fall back to COW mode and therefore
   the physical location of the extent changes on disk.

So fix this by taking the snapshot lock during swap file activation before
locking the extent range, as that is the order in which we lock these
during buffered writes.

Fixes: ed46ff3d42378 ("Btrfs: support swap files")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 464c289c402d..ca89f3166dd7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10093,7 +10093,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 			       sector_t *span)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
+	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct extent_state *cached_state = NULL;
 	struct extent_map *em = NULL;
@@ -10144,13 +10145,27 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	   "cannot activate swapfile while exclusive operation is running");
 		return -EBUSY;
 	}
+
+	/*
+	 * Prevent snapshot creation while we are activating the swap file.
+	 * We do not want to race with snapshot creation. If snapshot creation
+	 * already started before we bumped nr_swapfiles from 0 to 1 and
+	 * completes before the first write into the swap file after it is
+	 * activated, than that write would fallback to COW.
+	 */
+	if (!btrfs_drew_try_write_lock(&root->snapshot_lock)) {
+		btrfs_exclop_finish(fs_info);
+		btrfs_warn(fs_info,
+	   "cannot activate swapfile because snapshot creation is in progress");
+		return -EINVAL;
+	}
 	/*
 	 * Snapshots can create extents which require COW even if NODATACOW is
 	 * set. We use this counter to prevent snapshots. We must increment it
 	 * before walking the extents because we don't want a concurrent
 	 * snapshot to run after we've already checked the extents.
 	 */
-	atomic_inc(&BTRFS_I(inode)->root->nr_swapfiles);
+	atomic_inc(&root->nr_swapfiles);
 
 	isize = ALIGN_DOWN(inode->i_size, fs_info->sectorsize);
 
@@ -10296,6 +10311,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	if (ret)
 		btrfs_swap_deactivate(file);
 
+	btrfs_drew_write_unlock(&root->snapshot_lock);
+
 	btrfs_exclop_finish(fs_info);
 
 	if (ret)
-- 
2.28.0

