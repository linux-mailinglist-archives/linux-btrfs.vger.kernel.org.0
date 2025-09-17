Return-Path: <linux-btrfs+bounces-16905-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A90F9B82304
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 00:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4961B1B280FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 22:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F6430EF80;
	Wed, 17 Sep 2025 22:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oWd8QA3V";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oWd8QA3V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BE82E5404
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 22:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758149237; cv=none; b=Wa4Ppd12AuVmeniNcKOGW9nKls8lafVCMkzfbp4XR8CunY2JUClpVxS9iV6OJjEzQPKkKRuyQfmAtSvsJgz4ySxcvGdugpCe4AMGf2hV7VbhbuMqTLqEiBFzbi9bd5A0ei2bZsYugfFj4yvOs1uH5XGu6m97mhCYD4Z6pif8v+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758149237; c=relaxed/simple;
	bh=C5zS3n1DVmqWY1kYiBggvexsDLt+F6c9yXQWsiLLxbI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHbZ+t4v+vDdlXFm21V1ZJM7zYTYpDYYRhJ2wCgIr/n5Oax19IGaFdIqRMXcBrJ9NKwlGMtZ5ZklUckqIUF/gGvyGPM9qMHJxRy+Sz53JxW8gr68QZqoSFTeD9yWutqc2pGNMQUqt5hg2O9au1wFQPUPT5iE7ipVa/nYjsqjA/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oWd8QA3V; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oWd8QA3V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0C255D1D5
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 22:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758149205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDgy7JddhAnRTmH2lq8X2LeJx49Dkb2pLGPVN9rfxVU=;
	b=oWd8QA3VmPXAkh5fX9rSJy2nBB+oHjWsUYqqgvpqc4qXHoXxJEJQaIX4otPPHiknms1QvK
	xOJThB8Yt9NTF9HXjz/2lT2V3GOdYJKWaEvDXeuegK/Ax2rkdI+z2+/l4iTu9IkRjD91vI
	Vr9ANUqFv7ioHoP7n3v4pXcHgS8CnQY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=oWd8QA3V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758149205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDgy7JddhAnRTmH2lq8X2LeJx49Dkb2pLGPVN9rfxVU=;
	b=oWd8QA3VmPXAkh5fX9rSJy2nBB+oHjWsUYqqgvpqc4qXHoXxJEJQaIX4otPPHiknms1QvK
	xOJThB8Yt9NTF9HXjz/2lT2V3GOdYJKWaEvDXeuegK/Ax2rkdI+z2+/l4iTu9IkRjD91vI
	Vr9ANUqFv7ioHoP7n3v4pXcHgS8CnQY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EC1E1368D
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 22:46:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QKQmMVQ6y2j/HQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 22:46:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 8/8] btrfs: enable experimental bs > ps support
Date: Thu, 18 Sep 2025 08:16:13 +0930
Message-ID: <8f2f0be2b8ff75439c8cbe3451c42a1e128bebf1.1758147788.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1758147788.git.wqu@suse.com>
References: <cover.1758147788.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C0C255D1D5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

With all the preparation patches, we're able to finally enable btrfs
block size (sector size) larger than page size support and give it a
full fstests run.

And obvious this new feature is hidden behind experimental flags, and
should not be considered as a core feature yet as btrfs' default block
size is still 4K.

But this is still a feature that will shine in the future where 16K
block sized device are widely adapted.

For now there are some features explicitly disabled:

- Direct IO
  This is the most complex part to support, the root reason is we can
  not control the pages of iov iter passed in.

  User space programs can only ensure the virtual addresses are
  contiguous, but no control on their physical addresses.

  Our bs > ps support heavily relies on large folios, and direct IO
  memory can easily break it.

  So direct IO is disabled and will always fall back to buffered IO.

- RAID56
  In theory we can convert RAID56 to use large folios, but it will need
  to be converted back to page based if we want to support direct IO in
  the future.
  So just reject it for now.

- Encoded send
- Encoded read
  Both are utilizing btrfs_encoded_read_regular_fill_pages(), and send
  is utilizing vmallocated memory.
  Unfortunately for vmallocated memory we can not guarantee the minimal
  folio order.

  For send, it will just always fallback to regular writes, which reads
  from page cache and will follow the existing folio order requirement.

- Encoded write
  Encoded write itself is allocating pages by themselves, and we can
  easily change it to follow the minimal order.
  But since encoded read is already disabled, there is no need to only
  enable encoded write.

Finally just like what we did for bs < ps support in the past, add a
warning message for bs > ps mounts.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/direct-io.c | 12 ++++++++++++
 fs/btrfs/disk-io.c   | 14 ++++++++++++--
 fs/btrfs/fs.c        |  3 +--
 fs/btrfs/ioctl.c     | 35 +++++++++++++++++++++++++----------
 fs/btrfs/send.c      |  9 ++++++++-
 5 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index fe9a4bd7e6e6..abe0d5c42baa 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -786,6 +786,18 @@ static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
 	if (iov_iter_alignment(iter) & blocksize_mask)
 		return -EINVAL;
 
+	/*
+	 * For bs > ps support, btrfs heavily relies on large folios to make
+	 * sure no block will cross large folio boundaries.
+	 *
+	 * But memory provided by direct IO is only virtually contiguous, not
+	 * physically contiguous, and will break the btrfs' large folio requirement.
+	 *
+	 * So for bs > ps support, all direct IOs should fallback to buffered ones.
+	 */
+	if (fs_info->sectorsize > PAGE_SIZE)
+		return -EINVAL;
+
 	return 0;
 }
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a2eba8bc4336..d3dce247f3d4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3243,18 +3243,24 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount)
 	}
 
 	/*
-	 * Subpage runtime limitation on v1 cache.
+	 * Subpage/bs > ps runtime limitation on v1 cache.
 	 *
 	 * V1 space cache still has some hard coded PAGE_SIZE usage, while
 	 * we're already defaulting to v2 cache, no need to bother v1 as it's
 	 * going to be deprecated anyway.
 	 */
-	if (fs_info->sectorsize < PAGE_SIZE && btrfs_test_opt(fs_info, SPACE_CACHE)) {
+	if (fs_info->sectorsize != PAGE_SIZE && btrfs_test_opt(fs_info, SPACE_CACHE)) {
 		btrfs_warn(fs_info,
 	"v1 space cache is not supported for page size %lu with sectorsize %u",
 			   PAGE_SIZE, fs_info->sectorsize);
 		return -EINVAL;
 	}
+	if (fs_info->sectorsize > PAGE_SIZE && btrfs_fs_incompat(fs_info, RAID56)) {
+		btrfs_err(fs_info,
+		"RAID56 is not supported for page size %lu with sectorsize %u",
+			  PAGE_SIZE, fs_info->sectorsize);
+		return -EINVAL;
+	}
 
 	/* This can be called by remount, we need to protect the super block. */
 	spin_lock(&fs_info->super_lock);
@@ -3389,6 +3395,10 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	fs_info->stripesize = stripesize;
 	fs_info->fs_devices->fs_info = fs_info;
 
+	if (fs_info->sectorsize > PAGE_SIZE)
+		btrfs_warn(fs_info,
+			   "support for block size %u with page size %zu is experimental, some features may be missing",
+			   fs_info->sectorsize, PAGE_SIZE);
 	/*
 	 * Handle the space caching options appropriately now that we have the
 	 * super block loaded and validated.
diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index 35084b4e498b..3b4040e9c45d 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -96,8 +96,7 @@ bool __attribute_const__ btrfs_supported_blocksize(u32 blocksize)
 	 */
 	if (IS_ENABLED(CONFIG_HIGHMEM) && blocksize > PAGE_SIZE)
 		return false;
-	if (blocksize <= PAGE_SIZE)
-		return true;
+	return true;
 #endif
 	return false;
 }
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 063291519b36..0e9e2b999392 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4418,6 +4418,10 @@ static int btrfs_ioctl_encoded_read(struct file *file, void __user *argp,
 		goto out_acct;
 	}
 
+	if (fs_info->sectorsize > PAGE_SIZE) {
+		ret = -ENOTTY;
+		goto out_acct;
+	}
 	if (compat) {
 #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
 		struct btrfs_ioctl_encoded_io_args_32 args32;
@@ -4509,6 +4513,7 @@ static int btrfs_ioctl_encoded_read(struct file *file, void __user *argp,
 
 static int btrfs_ioctl_encoded_write(struct file *file, void __user *argp, bool compat)
 {
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(file->f_inode);
 	struct btrfs_ioctl_encoded_io_args args;
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov = iovstack;
@@ -4522,6 +4527,11 @@ static int btrfs_ioctl_encoded_write(struct file *file, void __user *argp, bool
 		goto out_acct;
 	}
 
+	if (fs_info->sectorsize > PAGE_SIZE) {
+		ret = -ENOTTY;
+		goto out_acct;
+	}
+
 	if (!(file->f_mode & FMODE_WRITE)) {
 		ret = -EBADF;
 		goto out_acct;
@@ -4780,14 +4790,14 @@ static int btrfs_uring_read_extent(struct kiocb *iocb, struct iov_iter *iter,
 
 static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
+	struct file *file = cmd->file;
+	struct btrfs_inode *inode = BTRFS_I(file->f_inode);
+	struct extent_io_tree *io_tree = &inode->io_tree;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	size_t copy_end_kernel = offsetofend(struct btrfs_ioctl_encoded_io_args, flags);
 	size_t copy_end;
 	int ret;
 	u64 disk_bytenr, disk_io_size;
-	struct file *file;
-	struct btrfs_inode *inode;
-	struct btrfs_fs_info *fs_info;
-	struct extent_io_tree *io_tree;
 	loff_t pos;
 	struct kiocb kiocb;
 	struct extent_state *cached_state = NULL;
@@ -4803,10 +4813,11 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 		ret = -EPERM;
 		goto out_acct;
 	}
-	file = cmd->file;
-	inode = BTRFS_I(file->f_inode);
-	fs_info = inode->root->fs_info;
-	io_tree = &inode->io_tree;
+	if (fs_info->sectorsize > PAGE_SIZE) {
+		ret = -ENOTTY;
+		goto out_acct;
+	}
+
 	sqe_addr = u64_to_user_ptr(READ_ONCE(cmd->sqe->addr));
 
 	if (issue_flags & IO_URING_F_COMPAT) {
@@ -4933,9 +4944,10 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 
 static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
+	struct file *file = cmd->file;
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(file->f_inode);
 	loff_t pos;
 	struct kiocb kiocb;
-	struct file *file;
 	ssize_t ret;
 	void __user *sqe_addr;
 	struct io_btrfs_cmd *bc = io_uring_cmd_to_pdu(cmd, struct io_btrfs_cmd);
@@ -4948,8 +4960,11 @@ static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issu
 		ret = -EPERM;
 		goto out_acct;
 	}
+	if (fs_info->sectorsize > PAGE_SIZE) {
+		ret = -ENOTTY;
+		goto out_acct;
+	}
 
-	file = cmd->file;
 	sqe_addr = u64_to_user_ptr(READ_ONCE(cmd->sqe->addr));
 
 	if (!(file->f_mode & FMODE_WRITE)) {
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index c5771df3a2c7..cf561a1ae2e8 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5654,7 +5654,14 @@ static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
 
 	ei = btrfs_item_ptr(leaf, path->slots[0],
 			    struct btrfs_file_extent_item);
-	if ((sctx->flags & BTRFS_SEND_FLAG_COMPRESSED) &&
+	/*
+	 * Do not go through encoded read for bs > ps cases.
+	 *
+	 * Encoded send is using vmallocated pages as buffer, which we can
+	 * not ensure every folio is large enough to contain a block.
+	 */
+	if (sctx->send_root->fs_info->sectorsize <= PAGE_SIZE &&
+	    (sctx->flags & BTRFS_SEND_FLAG_COMPRESSED) &&
 	    btrfs_file_extent_compression(leaf, ei) != BTRFS_COMPRESS_NONE) {
 		bool is_inline = (btrfs_file_extent_type(leaf, ei) ==
 				  BTRFS_FILE_EXTENT_INLINE);
-- 
2.50.1


