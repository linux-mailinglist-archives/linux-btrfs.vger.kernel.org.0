Return-Path: <linux-btrfs+bounces-9211-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 124009B5449
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 21:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85C89B239FD
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 20:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480B320C00E;
	Tue, 29 Oct 2024 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ACCfkiDc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ACCfkiDc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4764620BB5B
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Oct 2024 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234535; cv=none; b=SZhyehEnSRA6FKK2YxmX+YNuDQaPAmisqtqT2YItokhAF+93MlwSOc6M7IAJKeJAQDKFzCEAa8kL0R7Px6VRO6byfnHY2lbtzSw9LlRXwXZgtrcaWG/8IA6wqC7qRuv0CS6KmYITMTD6q+s9ZfSQTsd2Qoo7FRinC6mn4dM+7/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234535; c=relaxed/simple;
	bh=tQs9Jy2aa1ZDZUC6qoIzMjqqhqGTI1zW9ypCWLGY1A8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NEWy0tH32JoYJVvVO97Wy71uqRU/0eNA5YAIVf19yBbQRUdAoL/lZUcZJl9Ig5/zxMCqCO7OctF7NpCCmMxUv0p7R/03bWeRE84REe/WUP9wgTgRCKZ7iL8HsaKOV0x/wmrCWVLfIJNWm8c8B50cyCbolqWxs87491flpkPx/PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ACCfkiDc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ACCfkiDc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 212AB1F79F;
	Tue, 29 Oct 2024 20:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730234529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4UYyvIBzzh+8aHER0AolG9qW95zOoxP8Oyd6zmwIN3U=;
	b=ACCfkiDccKeDsRgtgZ+JFljAlGMa9fYbG6QrsleT4Wnd4Sy0X37kZChpXc6Qi6IsF4uE4n
	10JRM6jH5/mV9Hxwx9eMkmsCJkKGhbj9LIRSckj2xlyIH7Ptj2psrgEtGYhF64bQSjTvrV
	5fpZtCSNFzyOSulZPRJnHRjzrwRkizs=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ACCfkiDc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730234529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4UYyvIBzzh+8aHER0AolG9qW95zOoxP8Oyd6zmwIN3U=;
	b=ACCfkiDccKeDsRgtgZ+JFljAlGMa9fYbG6QrsleT4Wnd4Sy0X37kZChpXc6Qi6IsF4uE4n
	10JRM6jH5/mV9Hxwx9eMkmsCJkKGhbj9LIRSckj2xlyIH7Ptj2psrgEtGYhF64bQSjTvrV
	5fpZtCSNFzyOSulZPRJnHRjzrwRkizs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1701F136A5;
	Tue, 29 Oct 2024 20:42:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TP9ZBaFIIWfOZwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 29 Oct 2024 20:42:09 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2] btrfs: add new ioctl to wait for cleaned subvolumes
Date: Tue, 29 Oct 2024 21:41:47 +0100
Message-ID: <20241029204147.32031-1-dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 212AB1F79F
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

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

v2:
- rewrite waiting loop as while instead of goto
- handle empty list in WAIT_FOR_QUEUED mode and after
  radix_tree_lookup() call

 fs/btrfs/ioctl.c           | 128 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/btrfs.h |  25 ++++++++
 2 files changed, 153 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7f2731ef3dbb..a08c7e6fece5 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5029,6 +5029,132 @@ int btrfs_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	return -EINVAL;
 }
 
+static int btrfs_ioctl_subvol_sync(struct btrfs_fs_info *fs_info, void __user *argp)
+{
+	struct btrfs_root *root;
+	struct btrfs_ioctl_subvol_wait args = { 0 };
+	signed long sched_ret;
+	int refs;
+	u64 root_flags;
+	bool wait_for_deletion = false;
+	bool found = false;
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
+		if (!list_empty(&fs_info->dead_roots)) {
+			root = list_last_entry(&fs_info->dead_roots,
+					       struct btrfs_root, root_list);
+			args.subvolid = btrfs_root_id(root);
+			found = true;
+		}
+		spin_unlock(&fs_info->trans_lock);
+		if (!found)
+			return -ENOENT;
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
+		/* First in the list was deleted last. */
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
+	while (1) {
+		/* Wait for the specific one. */
+		if (down_read_interruptible(&fs_info->subvol_sem) == -EINTR)
+			return -EINTR;
+		refs = -1;
+		spin_lock(&fs_info->fs_roots_radix_lock);
+		root = radix_tree_lookup(&fs_info->fs_roots_radix,
+					 (unsigned long)args.subvolid);
+		if (root) {
+			spin_lock(&root->root_item_lock);
+			refs = btrfs_root_refs(&root->root_item);
+			root_flags = btrfs_root_flags(&root->root_item);
+			spin_unlock(&root->root_item_lock);
+		}
+		spin_unlock(&fs_info->fs_roots_radix_lock);
+		up_read(&fs_info->subvol_sem);
+
+		/* Subvolume does not exist. */
+		if (!root)
+			return -ENOENT;
+
+		/* Subvolume not deleted at all. */
+		if (refs > 0)
+			return -EEXIST;
+		/* We've waited and now the subvolume is gone. */
+		if (wait_for_deletion && refs == -1) {
+			/* Return the one we waited for as the last one. */
+			if (copy_to_user(argp, &args, sizeof(args)))
+				return -EFAULT;
+			return 0;
+		}
+
+		/* Subvolume not found on the first try (deleted or never existed). */
+		if (refs == -1)
+			return -ENOENT;
+
+		wait_for_deletion = true;
+		ASSERT(root_flags & BTRFS_ROOT_SUBVOL_DEAD);
+		sched_ret = schedule_timeout_interruptible(HZ);
+		/* Early wake up or error. */
+		if (sched_ret != 0)
+			return -EINTR;
+	}
+
+	return 0;
+}
+
 long btrfs_ioctl(struct file *file, unsigned int
 		cmd, unsigned long arg)
 {
@@ -5180,6 +5306,8 @@ long btrfs_ioctl(struct file *file, unsigned int
 	case BTRFS_IOC_ENCODED_WRITE_32:
 		return btrfs_ioctl_encoded_write(file, argp, true);
 #endif
+	case BTRFS_IOC_SUBVOL_SYNC_WAIT:
+		return btrfs_ioctl_subvol_sync(fs_info, argp);
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index cdf6ad872149..d3b222d7af24 100644
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
+	__u64 subvolid;
+	__u32 mode;
+	__u32 count;
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


