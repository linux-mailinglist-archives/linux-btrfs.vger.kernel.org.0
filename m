Return-Path: <linux-btrfs+bounces-6725-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB1793D673
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 17:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52378281C79
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 15:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DDC17BB2B;
	Fri, 26 Jul 2024 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRLYLK02"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC9F101F7
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722009349; cv=none; b=i1xJV4eLuG+lr7M3hcZD2+ScSmyiM718YX5kMG4btU8eOqsyNCdmRl0NucLWYbxpH2Wnw01d5Puwb+/sIy5QP1uInPeqdAG+1mJbl14Qan0b9lip55JYTfZLhf7K23xoUPG/2Vc6mRRC/H0UFBg3aQ6jBLSKL5ijphL9sGd+llE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722009349; c=relaxed/simple;
	bh=Zh4kynFqW9LQpUWIWfn08m47y0VjyM7wggasVwQ1y/k=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=RMjl1NvJgMLdxU+b5pTvUVsLTTdbs7sbQoro7JPqoosp3eI6B+0hd5tn/qr6gQ67qi2XosewR7kbV4HF7BvY58+6LxzpXkgr1mH12cvcaKAYr8ADLnEQTITCogWdlmBOch1LFCGdHFSyxPVj5l+pDIq54CnCfkVTMvgZKn8mRNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRLYLK02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B318C32782
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 15:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722009348;
	bh=Zh4kynFqW9LQpUWIWfn08m47y0VjyM7wggasVwQ1y/k=;
	h=From:To:Subject:Date:From;
	b=nRLYLK02ndmQfjZxWhAqsJsGbw5jJtZof3LatgRx9B3qajDWeYLQtSZR6wd6GzzD6
	 CnFCTh8FRKDGM+jNJr39yJy1kVWUyJHkmCaR2mKeOqEGJwdG0Ru2/PMumIeIxUcVlQ
	 UtlA+OEzdtbgblerC/lK6Asc0qgmZdqQp7qfeMbevBlGJZht11NXFjjOBM0/HJ1Y8Q
	 tRbADnVYq4vYlO+tN2CkdfPuVviKrAN3jVYFz2v5H9uyiTofFjHG5Zsb+GWXTXpVCc
	 kaASxgAZNQw8yWs3DjmG5C6M6fPfWkwFNu9s+bdgKF/1xcrcmayXws8SIFmXGxYpSs
	 Xopp/8wzkXARw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix corruption after buffer fault in during direct IO append write
Date: Fri, 26 Jul 2024 16:55:40 +0100
Message-Id: <a7cdb10155e5e823ce82edfc8eed99d1b0ef4eeb.1722005943.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

During an append (O_APPEND write flag) direct IO write if the input buffer
was not previously faulted in, we can corrupt the file in a way that the
final size is unexpected and it includes an unexpected hole.

The problem happens like this:

1) We have an empty file, with size 0, for example;

2) We do an O_APPEND direct IO with a length of 4096 bytes and the input
   buffer is not currently faulted in;

3) We enter btrfs_direct_write(), lock the inode and call
   generic_write_checks(), which calls generic_write_checks_count(), and
   that function sets the iocb position to 0 with the following code:

	if (iocb->ki_flags & IOCB_APPEND)
		iocb->ki_pos = i_size_read(inode);

4) We call btrfs_dio_write() and enter into iomap, which will end up
   calling btrfs_dio_iomap_begin() and that calls
   btrfs_get_blocks_direct_write(), where we update the i_size of the
   inode to 4096 bytes;

5) After btrfs_dio_iomap_begin() returns, iomap will attempt to access
   the page of the write input buffer (at iomap_dio_bio_iter(), with a
   call to bio_iov_iter_get_pages()) and fail with -EFAULT, which gets
   returned to btrfs at btrfs_direct_write() via btrfs_dio_write();

6) At btrfs_direct_write() we get the -EFAULT error, unlock the inode,
   fault in the write buffer and then goto to the label 'relock';

7) We lock again the inode, do all the necessary checks again and call
   again generic_write_checks(), which calls generic_write_checks_count()
   again, and there we set the iocb's position to 4K, which is the current
   i_size of the inode, with the following code pointed above:

        if (iocb->ki_flags & IOCB_APPEND)
                iocb->ki_pos = i_size_read(inode);

8) Then we go again to btrfs_dio_write() and enter iomap and the write
   succeeds, but it wrote to the file range [4K, 8K[, leaving a hole in
   the [0, 4K[ range and an i_size of 8K, which goes against the
   expections of having the data written to the range [0, 4K[ and get an
   i_size of 4K.

Fix this by not unlocking the inode before faulting in the input buffer,
in case we get -EFAULT or an incomplete write, and not jumping to the
'relock' label after faulting in the buffer - instead jump to a location
immediately before calling iomap, skipping all the write checks and
relocking. This solves this problem and it's fine even in case the input
buffer is memory mapped to the same file range, since only holding the
range locked in the inode's io tree can cause a deadlock, it's safe to
keep the inode lock (VFS lock), as was fixed and described in commit
51bd9563b678 ("btrfs: fix deadlock due to page faults during direct IO
reads and writes").

A sample reproducer provided by a reporter is the following:

   $ cat test.c
   #ifndef _GNU_SOURCE
   #define _GNU_SOURCE
   #endif

   #include <fcntl.h>
   #include <stdio.h>
   #include <sys/mman.h>
   #include <sys/stat.h>
   #include <unistd.h>

   int main(int argc, char *argv[])
   {
       if (argc < 2) {
           fprintf(stderr, "Usage: %s <test file>\n", argv[0]);
           return 1;
       }

       int fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT |
                     O_APPEND, 0644);
       if (fd < 0) {
           perror("creating test file");
           return 1;
       }

       char *buf = mmap(NULL, 4096, PROT_READ,
                        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
       ssize_t ret = write(fd, buf, 4096);
       if (ret < 0) {
           perror("pwritev2");
           return 1;
       }

       struct stat stbuf;
       ret = fstat(fd, &stbuf);
       if (ret < 0) {
           perror("stat");
           return 1;
       }

       printf("size: %llu\n", (unsigned long long)stbuf.st_size);
       return stbuf.st_size == 4096 ? 0 : 1;
   }

A test case for fstests will be sent soon.

Reported-by: Hanna Czenczek <hreitz@redhat.com>
Link: https://lore.kernel.org/linux-btrfs/0b841d46-12fe-4e64-9abb-871d8d0de271@redhat.com/
Fixes: 8184620ae212 ("btrfs: fix lost file sync on direct IO write with nowait and dsync iocb")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

Note: this applies only to Linus' tree because direct IO code was moved
      into a new new file and other minor changes in btrfs_sync_file()
      (inode variable is now a struct btrfs_inode pointer and no longer
      a vfs inode).

      For a patch version that applies at least to kernel 6.10:

      https://gist.githubusercontent.com/fdmanana/c835e21c708941e84ec3dbabd091a0da/raw/27551e26d54ffc399af49e6ffbbca5f58d300797/append-dio-fix-6.10.patch

 fs/btrfs/ctree.h     |  1 +
 fs/btrfs/direct-io.c | 38 ++++++++++++++++++++++++++++----------
 fs/btrfs/file.c      | 12 ++++++++++--
 3 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c8568b1a61c4..75fa563e4cac 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -459,6 +459,7 @@ struct btrfs_file_private {
 	void *filldir_buf;
 	u64 last_index;
 	struct extent_state *llseek_cached_state;
+	bool fsync_skip_inode_lock;
 };
 
 static inline u32 BTRFS_LEAF_DATA_SIZE(const struct btrfs_fs_info *info)
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index f9fb2db6a1e4..4301092e02c6 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -856,21 +856,37 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 * So here we disable page faults in the iov_iter and then retry if we
 	 * got -EFAULT, faulting in the pages before the retry.
 	 */
+again:
 	from->nofault = true;
 	dio = btrfs_dio_write(iocb, from, written);
 	from->nofault = false;
 
-	/*
-	 * iomap_dio_complete() will call btrfs_sync_file() if we have a dsync
-	 * iocb, and that needs to lock the inode. So unlock it before calling
-	 * iomap_dio_complete() to avoid a deadlock.
-	 */
-	btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
-
-	if (IS_ERR_OR_NULL(dio))
+	if (IS_ERR_OR_NULL(dio)) {
 		ret = PTR_ERR_OR_ZERO(dio);
-	else
+	} else {
+		struct btrfs_file_private stack_private = { 0 };
+		struct btrfs_file_private *private;
+		const bool have_private = (file->private_data != NULL);
+
+		if (!have_private)
+			file->private_data = &stack_private;
+
+		/*
+		 * If we have a synchoronous write, we must make sure the fsync
+		 * triggered by the iomap_dio_complete() call below doesn't
+		 * deadlock on the inode lock - we are already holding it and we
+		 * can't call it after unlocking because we may need to complete
+		 * partial writes due to the input buffer (or parts of it) not
+		 * being already faulted in.
+		 */
+		private = file->private_data;
+		private->fsync_skip_inode_lock = true;
 		ret = iomap_dio_complete(dio);
+		private->fsync_skip_inode_lock = false;
+
+		if (!have_private)
+			file->private_data = NULL;
+	}
 
 	/* No increment (+=) because iomap returns a cumulative value. */
 	if (ret > 0)
@@ -897,10 +913,12 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		} else {
 			fault_in_iov_iter_readable(from, left);
 			prev_left = left;
-			goto relock;
+			goto again;
 		}
 	}
 
+	btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
+
 	/*
 	 * If 'ret' is -ENOTBLK or we have not written all data, then it means
 	 * we must fallback to buffered IO.
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 21381de906f6..60f6c6c069d4 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1603,6 +1603,7 @@ static inline bool skip_inode_logging(const struct btrfs_log_ctx *ctx)
  */
 int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 {
+	struct btrfs_file_private *private = file->private_data;
 	struct dentry *dentry = file_dentry(file);
 	struct btrfs_inode *inode = BTRFS_I(d_inode(dentry));
 	struct btrfs_root *root = inode->root;
@@ -1612,6 +1613,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	int ret = 0, err;
 	u64 len;
 	bool full_sync;
+	const bool skip_ilock = (private ? private->fsync_skip_inode_lock : false);
 
 	trace_btrfs_sync_file(file, datasync);
 
@@ -1639,7 +1641,10 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	if (ret)
 		goto out;
 
-	btrfs_inode_lock(inode, BTRFS_ILOCK_MMAP);
+	if (skip_ilock)
+		down_write(&inode->i_mmap_lock);
+	else
+		btrfs_inode_lock(inode, BTRFS_ILOCK_MMAP);
 
 	atomic_inc(&root->log_batch);
 
@@ -1788,7 +1793,10 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * file again, but that will end up using the synchronization
 	 * inside btrfs_sync_log to keep things safe.
 	 */
-	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
+	if (skip_ilock)
+		up_write(&inode->i_mmap_lock);
+	else
+		btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 
 	if (ret == BTRFS_NO_LOG_SYNC) {
 		ret = btrfs_end_transaction(trans);
-- 
2.43.0


