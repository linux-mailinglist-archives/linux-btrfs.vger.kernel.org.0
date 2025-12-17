Return-Path: <linux-btrfs+bounces-19834-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 233DFCC7D16
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 14:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A0833020CEA
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 13:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3D6274B42;
	Wed, 17 Dec 2025 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqjFAw6G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2115C251791
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765977853; cv=none; b=I0Q9PfjAy5BLerFnwm6WVN0FcTByYo8tMeaXIe3s7kHzrwg7KwE4nsQ6aOBpDgGIw2IPFkb+OmgVOF3DDaWNm35DPT0g77KKo2JKQ4tg2wSgFgWUh3eUI2CKK0SvcEU9zbfM/7atswjA9C+fjbhxgFtNgNReanUGP41dgIsOluw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765977853; c=relaxed/simple;
	bh=piPX9J+uFHI78p1JaWjUWD9Jv2KX0Xjy6hQd0Gt1O40=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WfZSaEAMJTOQphU7RCixtAiC2FhaHloeZNffdwrNtNa66oEWUJ3GQhek4oJUe1PGGKtvXYDaV+w21ncRnb08qu0tiJKCzZb8FupUuY0UWNwFQBKzpdAYFnon9p0sVB3ydh7C5D420WDhkSC/B1IHwpt/L44ULApKZdOxszvc18I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqjFAw6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DD4C113D0
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 13:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765977851;
	bh=piPX9J+uFHI78p1JaWjUWD9Jv2KX0Xjy6hQd0Gt1O40=;
	h=From:To:Subject:Date:From;
	b=VqjFAw6GbmBrbcTU+VxVIvdUzMbnqOT7u/m3NaNdAGeBcs2oR3CaWPNis5jIMid1o
	 k7r26IHgrOsLiE2hfJzzBEWMWlrM5MH86LZc88/I+KgQnr7OBK+0ppsX8r0cWA6csD
	 60mb8XXqIOOG+oCPTQO2St3UvDtH3ZSMyNPfKnff1UrENEUH03bmX2h0B6aGWbIhzg
	 +dAcOIysG6ZerDlTWpn7/UZ72RnRWtKTMk2jkPLPy7USk+X5LbnYUSwzJkg7kNPX37
	 K66/9Z9gNvZCZyRMbGUQG5pYDIcUN249hsc+S7B3GEOsdAdh6C6113PWr+toWgsjKM
	 2bSK6bhQYWLdQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: move unlikely checks around btrfs_is_shutdown() into the helper
Date: Wed, 17 Dec 2025 13:24:08 +0000
Message-ID: <1a529e03fbbcf4fbb31192fe7be56e0f4650044d.1765977782.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of surrounding every caller of btrfs_is_shutdown() with unlikely,
move the unlikely into the helper itself, like we do in other places in
btrfs and is common in the kernel outside btrfs too. Also make the fs_info
argument of btrfs_is_shutdown() const.

On a x86_84 box using gcc 14.2.0-19 from Debian, this resulted in a slight
reduction of the module's text size.

Before:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1939044	 172568	  15592	2127204	 207564	fs/btrfs/btrfs.ko

After:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1938876	 172568	  15592	2127036	 2074bc	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c    | 12 ++++++------
 fs/btrfs/fs.h      |  4 ++--
 fs/btrfs/inode.c   |  6 +++---
 fs/btrfs/ioctl.c   |  2 +-
 fs/btrfs/reflink.c |  2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 69edf5f44bda..5d47cff5af42 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1437,7 +1437,7 @@ ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	struct btrfs_inode *inode = BTRFS_I(file_inode(file));
 	ssize_t num_written, num_sync;
 
-	if (unlikely(btrfs_is_shutdown(inode->root->fs_info)))
+	if (btrfs_is_shutdown(inode->root->fs_info))
 		return -EIO;
 	/*
 	 * If the fs flips readonly due to some impossible error, although we
@@ -2042,7 +2042,7 @@ static int btrfs_file_mmap_prepare(struct vm_area_desc *desc)
 	struct file *filp = desc->file;
 	struct address_space *mapping = filp->f_mapping;
 
-	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(file_inode(filp)))))
+	if (btrfs_is_shutdown(inode_to_fs_info(file_inode(filp))))
 		return -EIO;
 	if (!mapping->a_ops->read_folio)
 		return -ENOEXEC;
@@ -3113,7 +3113,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 	int blocksize = BTRFS_I(inode)->root->fs_info->sectorsize;
 	int ret;
 
-	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(inode))))
+	if (btrfs_is_shutdown(inode_to_fs_info(inode)))
 		return -EIO;
 
 	/* Do not allow fallocate in ZONED mode */
@@ -3807,7 +3807,7 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
 {
 	int ret;
 
-	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(inode))))
+	if (btrfs_is_shutdown(inode_to_fs_info(inode)))
 		return -EIO;
 
 	filp->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
@@ -3822,7 +3822,7 @@ static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t ret = 0;
 
-	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(file_inode(iocb->ki_filp)))))
+	if (btrfs_is_shutdown(inode_to_fs_info(file_inode(iocb->ki_filp))))
 		return -EIO;
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
@@ -3839,7 +3839,7 @@ static ssize_t btrfs_file_splice_read(struct file *in, loff_t *ppos,
 				      struct pipe_inode_info *pipe,
 				      size_t len, unsigned int flags)
 {
-	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(file_inode(in)))))
+	if (btrfs_is_shutdown(inode_to_fs_info(file_inode(in))))
 		return -EIO;
 
 	return filemap_splice_read(in, ppos, pipe, len, flags);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index dcb08bec98c4..0dc851b9c51b 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -1146,9 +1146,9 @@ static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
 	(unlikely(test_bit(BTRFS_FS_STATE_LOG_CLEANUP_ERROR,		\
 			   &(fs_info)->fs_state)))
 
-static inline bool btrfs_is_shutdown(struct btrfs_fs_info *fs_info)
+static inline bool btrfs_is_shutdown(const struct btrfs_fs_info *fs_info)
 {
-	return test_bit(BTRFS_FS_STATE_EMERGENCY_SHUTDOWN, &fs_info->fs_state);
+	return unlikely(test_bit(BTRFS_FS_STATE_EMERGENCY_SHUTDOWN, &fs_info->fs_state));
 }
 
 static inline void btrfs_force_shutdown(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bd6241ce6a78..8a6f49a4a6db 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -901,7 +901,7 @@ static void compress_file_range(struct btrfs_work *work)
 	int compress_type = fs_info->compress_type;
 	int compress_level = fs_info->compress_level;
 
-	if (unlikely(btrfs_is_shutdown(fs_info)))
+	if (btrfs_is_shutdown(fs_info))
 		goto cleanup_and_bail_uncompressed;
 
 	inode_should_defrag(inode, start, end, end - start + 1, SZ_16K);
@@ -1319,7 +1319,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	unsigned long page_ops;
 	int ret = 0;
 
-	if (unlikely(btrfs_is_shutdown(fs_info))) {
+	if (btrfs_is_shutdown(fs_info)) {
 		ret = -EIO;
 		goto out_unlock;
 	}
@@ -2072,7 +2072,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	 */
 	ASSERT(!btrfs_is_zoned(fs_info) || btrfs_is_data_reloc_root(root));
 
-	if (unlikely(btrfs_is_shutdown(fs_info))) {
+	if (btrfs_is_shutdown(fs_info)) {
 		ret = -EIO;
 		goto error;
 	}
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index acb484546b1d..d9e7dd317670 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5000,7 +5000,7 @@ static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issu
 
 int btrfs_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
-	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(file_inode(cmd->file)))))
+	if (btrfs_is_shutdown(inode_to_fs_info(file_inode(cmd->file))))
 		return -EIO;
 
 	switch (cmd->cmd_op) {
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index b5fe95baf92e..e746980567da 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -870,7 +870,7 @@ loff_t btrfs_remap_file_range(struct file *src_file, loff_t off,
 	bool same_inode = dst_inode == src_inode;
 	int ret;
 
-	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(file_inode(src_file)))))
+	if (btrfs_is_shutdown(inode_to_fs_info(file_inode(src_file))))
 		return -EIO;
 
 	if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
-- 
2.47.2


