Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF73311613
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 23:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhBEWuU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Feb 2021 17:50:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232100AbhBEM4X (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Feb 2021 07:56:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D71F64F38
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Feb 2021 12:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612529742;
        bh=2jn66wO2lNEB/9xh2zlah9mTVnSx6WjA47uIAe5aWhI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iTRJBxM3q8xcuh7VfovAmb43lw5sQQ8nf6YP09LltAT+kLG8XRi/F88Y+Ol5CIKs6
         g1wq0Mcpy7Z7Yn6QqN4IBHvcPBNrkOiMeq8Awm6tWKBwbM4iNc26pJhkLtRUcyEAZF
         7kklfZ3pOwK0ldULklz5tfYd4LofTxYgXXJxXQi5zsoyw5mKNbqh/aQyi5L+B96WF/
         MbQBUFyZFiCsXCGiYPXh1Q30W9WKPFxeNpIXYAfn/gDI3oYKsSX7TbF/yhL3Ut21DN
         5r37oPfMe4zBzDj8qiWY8QyG99Y8PLvzYgXEGMRItSJaGhoh2qfkGBlKF0/5/dPdRf
         WlsZcyv+kRSJw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs: avoid checking for RO block group twice during nocow writeback
Date:   Fri,  5 Feb 2021 12:55:36 +0000
Message-Id: <39ee54263f0ccc622359774e974073f2318c66e2.1612529182.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612529182.git.fdmanana@suse.com>
References: <cover.1612529182.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During the nocow writeback path, we currently iterate the rbtree of block
groups twice: once for checking if the target block group is RO with the
call to btrfs_extent_readonly()), and once again for getting a nocow
reference on the block group with a call to btrfs_inc_nocow_writers().

Since btrfs_inc_nocow_writers() already returns false when the target
block group is RO, remove the call to btrfs_extent_readonly(). Not only
we avoid searching the blocks group rbtree twice, it also helps reduce
contention on the lock that protects it (specially since it is a spin
lock and not a read-write lock). That may make a noticeable difference
on very large filesystems, with thousands of allocated block groups.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 04cd95899ac8..76a0151ef05a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1657,9 +1657,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			 */
 			btrfs_release_path(path);
 
-			/* If extent is RO, we must COW it */
-			if (btrfs_extent_readonly(fs_info, disk_bytenr))
-				goto out_check;
 			ret = btrfs_cross_ref_exist(root, ino,
 						    found_key.offset -
 						    extent_offset, disk_bytenr, false);
@@ -1706,6 +1703,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 				WARN_ON_ONCE(freespace_inode);
 				goto out_check;
 			}
+			/* If the extent's block group is RO, we must COW. */
 			if (!btrfs_inc_nocow_writers(fs_info, disk_bytenr))
 				goto out_check;
 			nocow = true;
-- 
2.28.0

