Return-Path: <linux-btrfs+bounces-17603-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B7EBCBAF5
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 07:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B91E9353C67
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 05:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D201B2749E4;
	Fri, 10 Oct 2025 05:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="e+eMvt18";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="e+eMvt18"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6CF26FDBB
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 05:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760072427; cv=none; b=ieXQLgCYiNDZvAUy7OxOUWztCIIAuXnaBhELRTYg9xT9ZcmKlvpb8v+Msr2HDU2wYVjJiShmVm0s/xmv9FRH1v11Hs4AhqV32Nm0FiX8H+FnXTcFcs1rzt+aSnsnc+rpodsVs60+470k3Nx8R+Va9ZG8kBWWVwC0rfjIobNRhks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760072427; c=relaxed/simple;
	bh=Wb6K7Ol+1ns10Uhh4n1tmyZmzqUL6vm65F3oA7bGcuU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPLEotgREMwDSQLDG4aqXPiKQBAiWM+MNyid0DO3ax8foBA3HY62OwmWIzShj5T4G+TM2bppbCUmkxUUZQcfRTDQA8FEtGuSVGBqywdbmVdm6S2uJKpu9tghk3K6JLpIVo4Ky2WYeTJp9oEbGq73FBxWoqqss6ujsoLfjNRCqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=e+eMvt18; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=e+eMvt18; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6F56821999
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 05:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760072416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYur8lVrcZtQGfDrIIHu2iE6+YBnNzzZlzaJ8IMJG18=;
	b=e+eMvt18RcEf2SGz/V3ll3UedlSgh5XIXOTUvGLyynFNEw9AWJKI6HKnRBAdYQbsYt+KiW
	GrFq5lTTVE45SI9mLLAAVJZ7G3eRU0CQhsD0qjiYvJQiRJZDqAmN0V4B2f3YQVz1roaHBJ
	MHeopX3o2b4Wcn8QZzSjLPIgs3ynSJE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760072416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYur8lVrcZtQGfDrIIHu2iE6+YBnNzzZlzaJ8IMJG18=;
	b=e+eMvt18RcEf2SGz/V3ll3UedlSgh5XIXOTUvGLyynFNEw9AWJKI6HKnRBAdYQbsYt+KiW
	GrFq5lTTVE45SI9mLLAAVJZ7G3eRU0CQhsD0qjiYvJQiRJZDqAmN0V4B2f3YQVz1roaHBJ
	MHeopX3o2b4Wcn8QZzSjLPIgs3ynSJE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADBD613A40
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 05:00:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CD4CHN+S6GgCcQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 05:00:15 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v6 2/5] btrfs: reject file operations if in shutdown state
Date: Fri, 10 Oct 2025 15:29:44 +1030
Message-ID: <dd1578ec017a4d96326bd2a2c3b1a65d35ce6fd5.1760069261.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1760069261.git.wqu@suse.com>
References: <cover.1760069261.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

This includes the following callbacks of file_operations:

- read_iter()
- write_iter()
- mmap()
- open()
- remap_file_range()
- uring_cmd()
- splice_read()
  This requires a small wrapper to do the extra shutdown check, then call
  the regular filemap_splice_read() function

This should reject most of the file operations on a shutdown btrfs.

The callback ioctl() is intentionally skipped, as ext4 doesn't do the
shutdown check on ioctl() either, thus I believe there is some special
require for ioctl() callback even if the fs is fully shutdown.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c    | 25 ++++++++++++++++++++++++-
 fs/btrfs/ioctl.c   |  3 +++
 fs/btrfs/reflink.c |  3 +++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index dcbd038d1ad1..837da30303fd 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1440,6 +1440,8 @@ ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	struct btrfs_inode *inode = BTRFS_I(file_inode(file));
 	ssize_t num_written, num_sync;
 
+	if (unlikely(btrfs_is_shutdown(inode->root->fs_info)))
+		return -EIO;
 	/*
 	 * If the fs flips readonly due to some impossible error, although we
 	 * have opened a file as writable, we have to stop this write operation
@@ -2042,6 +2044,8 @@ static int btrfs_file_mmap_prepare(struct vm_area_desc *desc)
 	struct file *filp = desc->file;
 	struct address_space *mapping = filp->f_mapping;
 
+	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(file_inode(filp)))))
+		return -EIO;
 	if (!mapping->a_ops->read_folio)
 		return -ENOEXEC;
 
@@ -3101,6 +3105,9 @@ static long btrfs_fallocate(struct file *file, int mode,
 	int blocksize = BTRFS_I(inode)->root->fs_info->sectorsize;
 	int ret;
 
+	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(inode))))
+		return -EIO;
+
 	/* Do not allow fallocate in ZONED mode */
 	if (btrfs_is_zoned(inode_to_fs_info(inode)))
 		return -EOPNOTSUPP;
@@ -3792,6 +3799,9 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
 {
 	int ret;
 
+	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(inode))))
+		return -EIO;
+
 	filp->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
 
 	ret = fsverity_file_open(inode, filp);
@@ -3804,6 +3814,9 @@ static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t ret = 0;
 
+	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(file_inode(iocb->ki_filp)))))
+		return -EIO;
+
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = btrfs_direct_read(iocb, to);
 		if (ret < 0 || !iov_iter_count(to) ||
@@ -3814,10 +3827,20 @@ static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return filemap_read(iocb, to, ret);
 }
 
+static ssize_t btrfs_file_splice_read(struct file *in, loff_t *ppos,
+				      struct pipe_inode_info *pipe,
+				      size_t len, unsigned int flags)
+{
+	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(file_inode(in)))))
+		return -EIO;
+
+	return filemap_splice_read(in, ppos, pipe, len, flags);
+}
+
 const struct file_operations btrfs_file_operations = {
 	.llseek		= btrfs_file_llseek,
 	.read_iter      = btrfs_file_read_iter,
-	.splice_read	= filemap_splice_read,
+	.splice_read	= btrfs_file_splice_read,
 	.write_iter	= btrfs_file_write_iter,
 	.splice_write	= iter_file_splice_write,
 	.mmap_prepare	= btrfs_file_mmap_prepare,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 938286bee6a8..342c8412c859 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5077,6 +5077,9 @@ static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issu
 
 int btrfs_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
+	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(file_inode(cmd->file)))))
+		return -EIO;
+
 	switch (cmd->cmd_op) {
 	case BTRFS_IOC_ENCODED_READ:
 #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 5465a5eae9b2..1bbe3bb7e1bb 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -868,6 +868,9 @@ loff_t btrfs_remap_file_range(struct file *src_file, loff_t off,
 	bool same_inode = dst_inode == src_inode;
 	int ret;
 
+	if (unlikely(btrfs_is_shutdown(inode_to_fs_info(file_inode(src_file)))))
+		return -EIO;
+
 	if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
 		return -EINVAL;
 
-- 
2.50.1


