Return-Path: <linux-btrfs+bounces-9040-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5F09A8FCA
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 21:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50A2281D54
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 19:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8731FBC8B;
	Mon, 21 Oct 2024 19:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nun+qR78";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nun+qR78"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C859A1F8EEC
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2024 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729538921; cv=none; b=XlVRqBHu3rZlR3Dn1QTmB8C4u7rzh7ztRPzFBEjibgVhOfl+5ggno5UZpgwD1U+hB5JzX1S8UC+sAvS24LFuaF5lWQG3m/eUf+VwLI7ZejgL47p68FE75t6hemMyioGhvBdJUN4GIXS0AMlUj8LKnJwyWDaNiNEk6NGUSArCW8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729538921; c=relaxed/simple;
	bh=r84EtK05pzmpcGfd4qEfEUaQJLaFEPpFP4u1PAn2Mac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RDkb7NK19AcFEMW1cOVIzsBqq91l4d/Jgm2Jkk9SQJtZ3Z3kzc6c+bQ60scu9HFvVm9X54POzKChNWhD3zvs80LY0mxSCXQjeDVAHunAe2fYXsMmIVoVA3SINXA9xWLITvu1IQ5rreCjfPUZagfZvIkQP/Si6tUKLijTjb1FsQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nun+qR78; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nun+qR78; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C4B161FCE0;
	Mon, 21 Oct 2024 19:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729538915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NfI519/6kVCjPy4WqzV3yzIp+5Z3a25Vkd5h64t/Q/0=;
	b=nun+qR78lUMmL5/9KgKMQ6d6UEr0qePDIZUHx5C16QMpNNle+JiUje3txtpJHzOai6RmLQ
	+YBTL1ZC9e8K7XmmwsukPLf5lluhh+k/LEYS9uLeRuJZiBvEAsN/QUICRbla6ctOaBADC8
	z7AcNxZy6JT1DjHOYHxZCvyzTHaSIBc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729538915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NfI519/6kVCjPy4WqzV3yzIp+5Z3a25Vkd5h64t/Q/0=;
	b=nun+qR78lUMmL5/9KgKMQ6d6UEr0qePDIZUHx5C16QMpNNle+JiUje3txtpJHzOai6RmLQ
	+YBTL1ZC9e8K7XmmwsukPLf5lluhh+k/LEYS9uLeRuJZiBvEAsN/QUICRbla6ctOaBADC8
	z7AcNxZy6JT1DjHOYHxZCvyzTHaSIBc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD616136DC;
	Mon, 21 Oct 2024 19:28:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vLo0LmOrFmfpMQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 21 Oct 2024 19:28:35 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: add new ioctl to wait for cleaned subvolumes
Date: Mon, 21 Oct 2024 21:28:26 +0200
Message-ID: <20241021192826.10206-1-dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Add a new unprivileged ioctl that will let the command
'btrfs subvolume sync' work without the (privileged) SEARCH_TREE ioctl.

There are several modes of operation, where the most common ones are to
wait on a specific subvolume or all currently queued for cleaning. This
is utilized e.g. in backup applications that delete subvolumes and wait
until they're cleaned to check for remaining space.

The other modes are for flexibility, e.g. for monitoring or
checkpoints in the queue of deleted subvolumes, again without the need
to use SEARCH_TREE.

Notes:

- waiting is interruptible, the timeout is set to 1 second and is not
  configurable

- repeated calls to the ioctl see a different state, so this is
  inherently racy when using e.g. the count or peek next/last

Use cases:

- a subvolume A was deleted, wait for cleaning (WAIT_FOR_ONE)

- a bunch of subvolumes were deleted, wait for all (WAIT_FOR_QUEUED or
  PEEK_LAST + WAIT_FOR_ONE)

- count how many are queued (not blocking), for monitoring purposes

- report progress (PEEK_NEXT), may miss some if cleaning is quick

- own waiting in user space (PEEK_LAST until it's 0)

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c           | 114 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/btrfs.h |  25 ++++++++
 2 files changed, 139 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 226c91fe31a7..2d58859786c9 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4690,6 +4690,118 @@ static int btrfs_ioctl_encoded_write(struct file *file, void __user *argp, bool
 	return ret;
 }
 
+static int btrfs_ioctl_subvol_sync(struct btrfs_fs_info *fs_info, void __user *argp)
+{
+	struct btrfs_root *root;
+	struct btrfs_ioctl_subvol_wait args = { 0 };
+	signed long sched_ret;
+	int refs;
+	u64 root_flags;
+	bool wait_for_deletion = false;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+
+	switch (args.mode) {
+	case BTRFS_SUBVOL_SYNC_WAIT_FOR_QUEUED:
+		/*
+		 * Wait for the first one deleted that waits until all previous
+		 * are cleaned.
+		 */
+		spin_lock(&fs_info->trans_lock);
+		root = list_last_entry(&fs_info->dead_roots, struct btrfs_root, root_list);
+		args.subvolid = btrfs_root_id(root);
+		spin_unlock(&fs_info->trans_lock);
+
+		fallthrough;
+	case BTRFS_SUBVOL_SYNC_WAIT_FOR_ONE:
+		if ((0 < args.subvolid && args.subvolid < BTRFS_FIRST_FREE_OBJECTID) ||
+		    BTRFS_LAST_FREE_OBJECTID < args.subvolid)
+			return -EINVAL;
+		break;
+	case BTRFS_SUBVOL_SYNC_COUNT:
+		spin_lock(&fs_info->trans_lock);
+		args.count = list_count_nodes(&fs_info->dead_roots);
+		spin_unlock(&fs_info->trans_lock);
+		if (copy_to_user(argp, &args, sizeof(args)))
+			return -EFAULT;
+		return 0;
+	case BTRFS_SUBVOL_SYNC_PEEK_FIRST:
+		spin_lock(&fs_info->trans_lock);
+		/* Last in the list was deleted first. */
+		if (!list_empty(&fs_info->dead_roots)) {
+			root = list_last_entry(&fs_info->dead_roots,
+					       struct btrfs_root, root_list);
+			args.subvolid = btrfs_root_id(root);
+		} else {
+			args.subvolid = 0;
+		}
+		spin_unlock(&fs_info->trans_lock);
+		if (copy_to_user(argp, &args, sizeof(args)))
+			return -EFAULT;
+		return 0;
+	case BTRFS_SUBVOL_SYNC_PEEK_LAST:
+		spin_lock(&fs_info->trans_lock);
+		/* First in the list was deleted last */
+		if (!list_empty(&fs_info->dead_roots)) {
+			root = list_first_entry(&fs_info->dead_roots,
+						struct btrfs_root, root_list);
+			args.subvolid = btrfs_root_id(root);
+		} else {
+			args.subvolid = 0;
+		}
+		spin_unlock(&fs_info->trans_lock);
+		if (copy_to_user(argp, &args, sizeof(args)))
+			return -EFAULT;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+
+	/* 32bit limitation: fs_roots_radix key is not wide enough. */
+	if (sizeof(unsigned long) != sizeof(u64) && args.subvolid > U32_MAX)
+		return -EOVERFLOW;
+
+wait_again:
+	/* Wait for the specific one. */
+	if (down_read_interruptible(&fs_info->subvol_sem) == -EINTR)
+		return -EINTR;
+	refs = -1;
+	spin_lock(&fs_info->fs_roots_radix_lock);
+	root = radix_tree_lookup(&fs_info->fs_roots_radix, (unsigned long)args.subvolid);
+	if (root) {
+		spin_lock(&root->root_item_lock);
+		refs = btrfs_root_refs(&root->root_item);
+		root_flags = btrfs_root_flags(&root->root_item);
+		spin_unlock(&root->root_item_lock);
+	}
+	spin_unlock(&fs_info->fs_roots_radix_lock);
+	up_read(&fs_info->subvol_sem);
+
+	/* Subvolume not deleted at all. */
+	if (refs > 0)
+		return -EEXIST;
+	/* We've waited and now the subvolume is gone. */
+	if (wait_for_deletion && refs == -1) {
+		/* Return the one we waited for as the last one. */
+		if (copy_to_user(argp, &args, sizeof(args)))
+			return -EFAULT;
+		return 0;
+	}
+	/* Subvolume not found on first try (deleted or never existed). */
+	if (refs == -1)
+		return -ENOENT;
+
+	wait_for_deletion = true;
+	ASSERT(root_flags & BTRFS_ROOT_SUBVOL_DEAD);
+	sched_ret = schedule_timeout_interruptible(HZ);
+	/* Early wake up or error. */
+	if (sched_ret != 0)
+		return -EINTR;
+
+	goto wait_again;
+}
+
 long btrfs_ioctl(struct file *file, unsigned int
 		cmd, unsigned long arg)
 {
@@ -4841,6 +4953,8 @@ long btrfs_ioctl(struct file *file, unsigned int
 	case BTRFS_IOC_ENCODED_WRITE_32:
 		return btrfs_ioctl_encoded_write(file, argp, true);
 #endif
+	case BTRFS_IOC_SUBVOL_SYNC_WAIT:
+		return btrfs_ioctl_subvol_sync(fs_info, argp);
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index cdf6ad872149..e2362a7ef206 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -1049,6 +1049,29 @@ struct btrfs_ioctl_encoded_io_args {
 #define BTRFS_ENCODED_IO_ENCRYPTION_NONE 0
 #define BTRFS_ENCODED_IO_ENCRYPTION_TYPES 1
 
+/*
+ * Wait for subvolume cleaning process. This queries the kernel queue and it
+ * can change between the calls.
+ *
+ * - FOR_ONE	- specify the subvolid
+ * - FOR_QUEUED - wait for all currently queued
+ * - COUNT	- count number of queued
+ * - PEEK_FIRST - read which is the first in the queue (to be cleaned or being
+ * 		  cleaned already), or 0 if the queue is empty
+ * - PEEK_LAST  - read the last subvolid in the queue, or 0 if the queue is empty
+ */
+struct btrfs_ioctl_subvol_wait {
+	u64 subvolid;
+	u32 mode;
+	u32 count;
+};
+
+#define BTRFS_SUBVOL_SYNC_WAIT_FOR_ONE		(0)
+#define BTRFS_SUBVOL_SYNC_WAIT_FOR_QUEUED	(1)
+#define BTRFS_SUBVOL_SYNC_COUNT			(2)
+#define BTRFS_SUBVOL_SYNC_PEEK_FIRST		(3)
+#define BTRFS_SUBVOL_SYNC_PEEK_LAST		(4)
+
 /* Error codes as returned by the kernel */
 enum btrfs_err_code {
 	BTRFS_ERROR_DEV_RAID1_MIN_NOT_MET = 1,
@@ -1181,6 +1204,8 @@ enum btrfs_err_code {
 				    struct btrfs_ioctl_encoded_io_args)
 #define BTRFS_IOC_ENCODED_WRITE _IOW(BTRFS_IOCTL_MAGIC, 64, \
 				     struct btrfs_ioctl_encoded_io_args)
+#define BTRFS_IOC_SUBVOL_SYNC_WAIT _IOW(BTRFS_IOCTL_MAGIC, 65, \
+					struct btrfs_ioctl_subvol_wait)
 
 #ifdef __cplusplus
 }
-- 
2.45.0


