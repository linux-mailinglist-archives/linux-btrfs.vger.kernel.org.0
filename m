Return-Path: <linux-btrfs+bounces-17644-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13408BD0DB6
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 01:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65753B6392
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Oct 2025 23:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884052EBDD7;
	Sun, 12 Oct 2025 23:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="evlUJFB6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="evlUJFB6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CB222AE5D
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Oct 2025 23:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760313162; cv=none; b=eCJQ0gN0hN9CoaFDklizj6IGGgK6aAV4OSk8nhRRmdrOKab6SDtWGZD0ciPA0LtiuXC+Hyf6mAEyBLg0G6uLoxETf2SBSKPRV+oufyTZniDk1MTgYvyURvvduPQHFrLdOhNhoWzEabc6qH559s5SFStv55heDWYXCNYd4F6xJNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760313162; c=relaxed/simple;
	bh=QiQAHVI8yNr6OWTAsAk6AeiqxPQF39IiXdrm+Nlv57E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6+3JTPJD7sGK6Pj0jn84ErnFuqEcQOx95k05tbmgVdA+DoK7tm7Vr1dzs4im7ofCet7EhrD4/syrTcKTimSofgnq26kF8O5X8RuCcEcUTYpStms8yoFdE7PrnEuRZ1vw8sngcQNLWmeE5WE4tung8KmXMPP3BueMw+0tb/6ELM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=evlUJFB6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=evlUJFB6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA5C81F387
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Oct 2025 23:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760313145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OfXUhKBLLWNEUOLjxoGUxyWvA6lbvjOBZ+/JYS8nAL4=;
	b=evlUJFB6PDagoIefWVBP/nQMgn554CWqaWzWDCE47U6PD8kSSxLbPDt4ZpVrI1O83Zz0KJ
	uPgtzQEcJftIggEQcXqZBu2AyCI1ElVchK6ogCSAbJibDeLU74VIX+uYdC6QN3yBYja04V
	nxPqUBC5+zSTE2wayydw1CVYnbP1YJI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760313145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OfXUhKBLLWNEUOLjxoGUxyWvA6lbvjOBZ+/JYS8nAL4=;
	b=evlUJFB6PDagoIefWVBP/nQMgn554CWqaWzWDCE47U6PD8kSSxLbPDt4ZpVrI1O83Zz0KJ
	uPgtzQEcJftIggEQcXqZBu2AyCI1ElVchK6ogCSAbJibDeLU74VIX+uYdC6QN3yBYja04V
	nxPqUBC5+zSTE2wayydw1CVYnbP1YJI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E672C13782
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Oct 2025 23:52:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GNXFKTg/7Gj8SQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Oct 2025 23:52:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v7 1/3] btrfs: introduce a new shutdown state
Date: Mon, 13 Oct 2025 10:22:03 +1030
Message-ID: <5242fe0720756535300cfaa90ddbdadf5e1a85e7.1760312845.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1760312845.git.wqu@suse.com>
References: <cover.1760312845.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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

A new fs state EMERGENCY_SHUTDOWN is introduced, which is btrfs'
equivalent of XFS_IOC_GOINGDOWN or EXT4_IOC_SHUTDOWN, after entering
emergency shutdown state, all operations will return errors (-EIO), and
can not be bring back to normal state until unmouont.

The new state will reject the following file operations:

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

And for the existing dirty folios, extra shutdown checks are introduced
to the following functions:

- run_delalloc_nocow()
- run_delalloc_compressed()
- cow_file_range()

So that dirty ranges will still be properly cleaned without being
submitted.

Finally the shutdown state will also set the fs error, so that no new
transaction will be committed, protecting the metadata from any possible
further corruption.

And when the fs entered shutdown mode for the first time, a critical
level kernel message will show up to indicate the incident.

That message will be important for end users as rejected delalloc ranges
will output error messages, hopefully that shutdown message and the fact
that all fs operations are returning error will prevent end users from
getting too confused about the delalloc error messages.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c     | 25 ++++++++++++++++++++++++-
 fs/btrfs/fs.h       | 28 ++++++++++++++++++++++++++++
 fs/btrfs/inode.c    | 14 +++++++++++++-
 fs/btrfs/ioctl.c    |  3 +++
 fs/btrfs/messages.c |  1 +
 fs/btrfs/reflink.c  |  3 +++
 6 files changed, 72 insertions(+), 2 deletions(-)

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
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 814bbc9417d2..0bb0c01d7952 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -29,6 +29,7 @@
 #include "extent-io-tree.h"
 #include "async-thread.h"
 #include "block-rsv.h"
+#include "messages.h"
 
 struct inode;
 struct super_block;
@@ -124,6 +125,12 @@ enum {
 	/* No more delayed iput can be queued. */
 	BTRFS_FS_STATE_NO_DELAYED_IPUT,
 
+	/*
+	 * Emergency shutdown, a step further than trans aborted by rejecting
+	 * all operations.
+	 */
+	BTRFS_FS_STATE_EMERGENCY_SHUTDOWN,
+
 	BTRFS_FS_STATE_COUNT
 };
 
@@ -1120,6 +1127,27 @@ static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
 	(unlikely(test_bit(BTRFS_FS_STATE_LOG_CLEANUP_ERROR,		\
 			   &(fs_info)->fs_state)))
 
+static inline bool btrfs_is_shutdown(struct btrfs_fs_info *fs_info)
+{
+	return test_bit(BTRFS_FS_STATE_EMERGENCY_SHUTDOWN, &fs_info->fs_state);
+}
+
+static inline void btrfs_force_shutdown(struct btrfs_fs_info *fs_info)
+{
+	/*
+	 * Here we do not want to use handle_fs_error(), which will mark
+	 * the fs read-only.
+	 * Some call sites like shutdown ioctl will mark the fs shutdown
+	 * when the fs is frozen. But thaw path will handle RO and RW fs
+	 * differently.
+	 *
+	 * So here we only mark the fs error without flipping it RO.
+	 */
+	WRITE_ONCE(fs_info->fs_error, -EIO);
+	if (!test_and_set_bit(BTRFS_FS_STATE_EMERGENCY_SHUTDOWN, &fs_info->fs_state))
+		btrfs_crit(fs_info, "emergency shutdown");
+}
+
 /*
  * We use folio flag owner_2 to indicate there is an ordered extent with
  * unfinished IO.
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ac2fd589697d..509309edcf5d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -871,6 +871,9 @@ static void compress_file_range(struct btrfs_work *work)
 	int compress_type = fs_info->compress_type;
 	int compress_level = fs_info->compress_level;
 
+	if (unlikely(btrfs_is_shutdown(fs_info)))
+		goto cleanup_and_bail_uncompressed;
+
 	inode_should_defrag(inode, start, end, end - start + 1, SZ_16K);
 
 	/*
@@ -1286,6 +1289,11 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	unsigned long page_ops;
 	int ret = 0;
 
+	if (unlikely(btrfs_is_shutdown(fs_info))) {
+		ret = -EIO;
+		goto out_unlock;
+	}
+
 	if (btrfs_is_free_space_inode(inode)) {
 		ret = -EINVAL;
 		goto out_unlock;
@@ -2004,7 +2012,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_root *root = inode->root;
-	struct btrfs_path *path;
+	struct btrfs_path *path = NULL;
 	u64 cow_start = (u64)-1;
 	/*
 	 * If not 0, represents the inclusive end of the last fallback_to_cow()
@@ -2034,6 +2042,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	 */
 	ASSERT(!btrfs_is_zoned(fs_info) || btrfs_is_data_reloc_root(root));
 
+	if (unlikely(btrfs_is_shutdown(fs_info))) {
+		ret = -EIO;
+		goto error;
+	}
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
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
diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index a0cf8effe008..2f853de44473 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -24,6 +24,7 @@ static const char fs_state_chars[] = {
 	[BTRFS_FS_STATE_NO_DATA_CSUMS]		= 'C',
 	[BTRFS_FS_STATE_SKIP_META_CSUMS]	= 'S',
 	[BTRFS_FS_STATE_LOG_CLEANUP_ERROR]	= 'L',
+	[BTRFS_FS_STATE_EMERGENCY_SHUTDOWN]	= 'E',
 };
 
 static void btrfs_state_to_string(const struct btrfs_fs_info *info, char *buf)
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


