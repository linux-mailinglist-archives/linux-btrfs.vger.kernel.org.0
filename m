Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA27830D85B
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Feb 2021 12:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhBCLSh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Feb 2021 06:18:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233958AbhBCLSc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Feb 2021 06:18:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 550D264F67
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Feb 2021 11:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612351071;
        bh=0wduYG+Xvmcpt6w6eT+Eum7UefBBL3KUaDv/Ie+jm5Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LvMeNZDxr3qTsb8nQBNBSynF+Z1wyP3YVpULuobgytkNwFziUrDHVL3pY9cROtptk
         aUUPjE9RUAJ1PHRXpLeiJCFeRAibaOGFjZfLiBb3FApIIHB5Ze8S3ih4DI8SX9y8Bn
         l7Dtoj3/RW2Rf665cirfHNlhprpBS8/CWtHmaOX7L6I9HwGTTEhsUPxf/nYgkMatsr
         lLaXgSPppCQVOQ0ND3p0vIU//8pGoUBRna6TxP2DF2hf42IanfwWerdnDHfOUHDZx3
         eJ7iMZrb8wjiaHC1JgiX6RODlaqTp/3jzpKDQ1i7jLWIuRhmI8nKVJ0wGvKI/jnJXn
         5IGDOA3IHmX1g==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: avoid checking for RO block group twice during nocow writeback
Date:   Wed,  3 Feb 2021 11:17:44 +0000
Message-Id: <9d42ab56ffa6b454998453764dbb1c899d10bc40.1612350698.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612350698.git.fdmanana@suse.com>
References: <cover.1612350698.git.fdmanana@suse.com>
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
index 589030cefd90..b10fc42f9e9a 100644
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

