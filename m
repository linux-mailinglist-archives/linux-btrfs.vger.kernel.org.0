Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1A11F9ED3
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jun 2020 19:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbgFORtn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 13:49:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbgFORtm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 13:49:42 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55E002080D
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jun 2020 17:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592243381;
        bh=F8h5FGYGVLB1VK9ztGf5EeZi/jnZO/T9I2q9zTtGAXU=;
        h=From:To:Subject:Date:From;
        b=JtstoVmA1+c7RM5cfWDD23yTywb5ppsquUfGzjHMAVHuOsG3eSMyr9qA2Js1Rq+jD
         aftqThQOyftqO9wxP/nSlCSsva4jgvSgupC2voKjrNhDncj/ifezZ7S0Mc7nB5ZYiR
         hMQ1nvQEApwsYR4UgbsID0GBObfDQ06LUDt468zo=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] Btrfs: fix RWF_NOWAIT writes blocking on extent locks and waiting for IO
Date:   Mon, 15 Jun 2020 18:49:39 +0100
Message-Id: <20200615174939.15004-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

A RWF_NOWAIT write is not supposed to wait on filesystem locks that can be
held for a long time or for ongoing IO to complete.

However when calling check_can_nocow(), if the inode has prealloc extents
or has the NOCOW flag set, we can block on extent (file range) locks
through the call to btrfs_lock_and_flush_ordered_range(). Such lock can
take a significant amount of time to be available. For example, a fiemap
task may be running, and iterating through the entire file range checking
all extents and doing backref walking to determine if they are shared,
or a readpage operation may be in progress.

Also at btrfs_lock_and_flush_ordered_range(), called by check_can_nocow(),
after locking the file range we wait for any existing ordered extent that
is in progress to complete. Another operation that can take a significant
amount of time and defeat the purpose of RWF_NOWAIT.

So fix this by trying to lock the file range and if it's currently locked
return -EAGAIN to user space. If we are able to lock the file range without
waiting and there is an ordered extent in the range, return -EAGAIN as
well, instead of waiting for it to complete. Finally, don't bother trying
to lock the snapshot lock of the root when attempting a RWF_NOWAIT write,
as that is only important for buffered writes.

Fixes: edf064e7c6fec3 ("btrfs: nowait aio support")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 78481d1e5e6e..e5da2508f002 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1533,7 +1533,7 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 }
 
 static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
-				    size_t *write_bytes)
+				    size_t *write_bytes, bool nowait)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_root *root = inode->root;
@@ -1541,27 +1541,43 @@ static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 	u64 num_bytes;
 	int ret;
 
-	if (!btrfs_drew_try_write_lock(&root->snapshot_lock))
+	if (!nowait && !btrfs_drew_try_write_lock(&root->snapshot_lock))
 		return -EAGAIN;
 
 	lockstart = round_down(pos, fs_info->sectorsize);
 	lockend = round_up(pos + *write_bytes,
 			   fs_info->sectorsize) - 1;
+	num_bytes = lockend - lockstart + 1;
 
-	btrfs_lock_and_flush_ordered_range(inode, lockstart,
-					   lockend, NULL);
+	if (nowait) {
+		struct btrfs_ordered_extent *ordered;
+
+		if (!try_lock_extent(&inode->io_tree, lockstart, lockend))
+			return -EAGAIN;
+
+		ordered = btrfs_lookup_ordered_range(inode, lockstart,
+						     num_bytes);
+		if (ordered) {
+			btrfs_put_ordered_extent(ordered);
+			ret = -EAGAIN;
+			goto out_unlock;
+		}
+	} else {
+		btrfs_lock_and_flush_ordered_range(inode, lockstart,
+						   lockend, NULL);
+	}
 
-	num_bytes = lockend - lockstart + 1;
 	ret = can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes,
 			NULL, NULL, NULL);
 	if (ret <= 0) {
 		ret = 0;
-		btrfs_drew_write_unlock(&root->snapshot_lock);
+		if (!nowait)
+			btrfs_drew_write_unlock(&root->snapshot_lock);
 	} else {
 		*write_bytes = min_t(size_t, *write_bytes ,
 				     num_bytes - pos + lockstart);
 	}
-
+out_unlock:
 	unlock_extent(&inode->io_tree, lockstart, lockend);
 
 	return ret;
@@ -1633,7 +1649,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 			if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
 						      BTRFS_INODE_PREALLOC)) &&
 			    check_can_nocow(BTRFS_I(inode), pos,
-					&write_bytes) > 0) {
+					    &write_bytes, false) > 0) {
 				/*
 				 * For nodata cow case, no need to reserve
 				 * data space.
@@ -1911,12 +1927,11 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		 */
 		if (!(BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
 					      BTRFS_INODE_PREALLOC)) ||
-		    check_can_nocow(BTRFS_I(inode), pos, &nocow_bytes) <= 0) {
+		    check_can_nocow(BTRFS_I(inode), pos, &nocow_bytes,
+				    true) <= 0) {
 			inode_unlock(inode);
 			return -EAGAIN;
 		}
-		/* check_can_nocow() locks the snapshot lock on success */
-		btrfs_drew_write_unlock(&root->snapshot_lock);
 		/*
 		 * There are holes in the range or parts of the range that must
 		 * be COWed (shared extents, RO block groups, etc), so just bail
-- 
2.26.2

