Return-Path: <linux-btrfs+bounces-5107-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CDB8C9AAB
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 11:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BB58B2239F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 09:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CFF5026E;
	Mon, 20 May 2024 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JemBtINd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08464F613
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198420; cv=none; b=acS15WGf5q4IdayOM14knbQlK5MqpPpV8TlGdsUlfEhPkhQ3GMaU/sANfjgIqJkRsZViZKs0yw8RWf0E8Tnok/wfStxGdyyidcZydz3LbaXI+xtgdOzq6ZsSospD7lW6ujXCrCtIWokQt+VUV+ovWJF7J83CIJTNhN0LI3iinho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198420; c=relaxed/simple;
	bh=Ft41DLjo3+OiLDJJGsgNZAHQ2nZ5oal832ZYNCcohsg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nJTLu2SB8XZxHfByLt55vY5aZq/ibSCdtK1CGZ9tLU0G3fkl1MK2j9bW57jsi6J49CMsSqjhKKr5jkkIhqSC4iqRKIN9DeGmB8Gi0D967ddgEEYx4vimBqTmpoNFzIyKZXcPu3xamq1c2Zib4PsB84+aTzoGOq2Exi5qoC7kGa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JemBtINd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB9CC2BD10
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 09:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716198420;
	bh=Ft41DLjo3+OiLDJJGsgNZAHQ2nZ5oal832ZYNCcohsg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JemBtINdOH/PvTHgJolTRDbcdtx8YhchKSiztoTsfZKi3PxCHca+wxKfwBar0Lhbj
	 nuXz3dORSu6RI3iP2Gee8YrOXD5AJ13DLBTHUOz1KnSzriHk8uw9lReeapCtdrhAFd
	 /vZLy2BDsG/MF8j704RiXNkbsP0M2ojOHzzulBjru30dXU8v9rOutVPzCKZiuCp9CP
	 g5VYtNOZSgI194znrkhS+gKZYXPiiYpt4S9oZXfcUgZXyGZGE1yK+zs5XB53c/Wv9b
	 ZoIex08h4Lmi4crOM7m97Xv3n4nSms6wxrIM0Z/PJ7ldaTvyHK6CdoeFN/0GxSXwQw
	 G4Eb05dyXJAbQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 6/6] btrfs: use a btrfs_inode local variable at btrfs_sync_file()
Date: Mon, 20 May 2024 10:46:51 +0100
Message-Id: <f912934363ac86bdb6a631babf7a729e465f5fb6.1716053516.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716053516.git.fdmanana@suse.com>
References: <cover.1716053516.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of using a VFS inode local pointer and then doing many BTRFS_I()
calls inside btrfs_sync_file(), use a btrfs_inode pointer instead. This
makes everything a bit easier to read and less confusing, allowing to
make some statements shorter.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 21a48d326b99..af58a1b33498 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1794,9 +1794,9 @@ static inline bool skip_inode_logging(const struct btrfs_log_ctx *ctx)
 int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	struct dentry *dentry = file_dentry(file);
-	struct inode *inode = d_inode(dentry);
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_inode *inode = BTRFS_I(d_inode(dentry));
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_log_ctx ctx;
 	int ret = 0, err;
@@ -1805,7 +1805,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 	trace_btrfs_sync_file(file, datasync);
 
-	btrfs_init_log_ctx(&ctx, BTRFS_I(inode));
+	btrfs_init_log_ctx(&ctx, inode);
 
 	/*
 	 * Always set the range to a full range, otherwise we can get into
@@ -1825,11 +1825,11 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * multi-task, and make the performance up.  See
 	 * btrfs_wait_ordered_range for an explanation of the ASYNC check.
 	 */
-	ret = start_ordered_ops(BTRFS_I(inode), start, end);
+	ret = start_ordered_ops(inode, start, end);
 	if (ret)
 		goto out;
 
-	btrfs_inode_lock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
+	btrfs_inode_lock(inode, BTRFS_ILOCK_MMAP);
 
 	atomic_inc(&root->log_batch);
 
@@ -1851,9 +1851,9 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * So trigger writeback for any eventual new dirty pages and then we
 	 * wait for all ordered extents to complete below.
 	 */
-	ret = start_ordered_ops(BTRFS_I(inode), start, end);
+	ret = start_ordered_ops(inode, start, end);
 	if (ret) {
-		btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
+		btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 		goto out;
 	}
 
@@ -1865,8 +1865,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * running delalloc the full sync flag may be set if we need to drop
 	 * extra extent map ranges due to temporary memory allocation failures.
 	 */
-	full_sync = test_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
-			     &BTRFS_I(inode)->runtime_flags);
+	full_sync = test_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags);
 
 	/*
 	 * We have to do this here to avoid the priority inversion of waiting on
@@ -1884,17 +1883,16 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * to wait for the IO to stabilize the logical address.
 	 */
 	if (full_sync || btrfs_is_zoned(fs_info)) {
-		ret = btrfs_wait_ordered_range(BTRFS_I(inode), start, len);
-		clear_bit(BTRFS_INODE_COW_WRITE_ERROR, &BTRFS_I(inode)->runtime_flags);
+		ret = btrfs_wait_ordered_range(inode, start, len);
+		clear_bit(BTRFS_INODE_COW_WRITE_ERROR, &inode->runtime_flags);
 	} else {
 		/*
 		 * Get our ordered extents as soon as possible to avoid doing
 		 * checksum lookups in the csum tree, and use instead the
 		 * checksums attached to the ordered extents.
 		 */
-		btrfs_get_ordered_extents_for_logging(BTRFS_I(inode),
-						      &ctx.ordered_extents);
-		ret = filemap_fdatawait_range(inode->i_mapping, start, end);
+		btrfs_get_ordered_extents_for_logging(inode, &ctx.ordered_extents);
+		ret = filemap_fdatawait_range(inode->vfs_inode.i_mapping, start, end);
 		if (ret)
 			goto out_release_extents;
 
@@ -1908,8 +1906,8 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		 * unwritten locations are dropped and we don't log them.
 		 */
 		if (test_and_clear_bit(BTRFS_INODE_COW_WRITE_ERROR,
-				       &BTRFS_I(inode)->runtime_flags))
-			ret = btrfs_wait_ordered_range(BTRFS_I(inode), start, len);
+				       &inode->runtime_flags))
+			ret = btrfs_wait_ordered_range(inode, start, len);
 	}
 
 	if (ret)
@@ -1923,8 +1921,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		 * modified so clear this flag in case it was set for whatever
 		 * reason, it's no longer relevant.
 		 */
-		clear_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
-			  &BTRFS_I(inode)->runtime_flags);
+		clear_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags);
 		/*
 		 * An ordered extent might have started before and completed
 		 * already with io errors, in which case the inode was not
@@ -1932,7 +1929,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		 * for any errors that might have happened since we last
 		 * checked called fsync.
 		 */
-		ret = filemap_check_wb_err(inode->i_mapping, file->f_wb_err);
+		ret = filemap_check_wb_err(inode->vfs_inode.i_mapping, file->f_wb_err);
 		goto out_release_extents;
 	}
 
@@ -1982,7 +1979,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * file again, but that will end up using the synchronization
 	 * inside btrfs_sync_log to keep things safe.
 	 */
-	btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
+	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 
 	if (ret == BTRFS_NO_LOG_SYNC) {
 		ret = btrfs_end_transaction(trans);
@@ -2014,7 +2011,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		ret = btrfs_end_transaction(trans);
 		if (ret)
 			goto out;
-		ret = btrfs_wait_ordered_range(BTRFS_I(inode), start, len);
+		ret = btrfs_wait_ordered_range(inode, start, len);
 		if (ret)
 			goto out;
 
@@ -2051,7 +2048,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 out_release_extents:
 	btrfs_release_log_ctx_extents(&ctx);
-	btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_MMAP);
+	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 	goto out;
 }
 
-- 
2.43.0


