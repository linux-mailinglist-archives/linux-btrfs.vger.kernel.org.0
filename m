Return-Path: <linux-btrfs+bounces-11944-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1929BA49C63
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 15:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F4103174E53
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 14:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF123270EAB;
	Fri, 28 Feb 2025 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IU0tgwEF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IU0tgwEF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E733D2702BE
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2025 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754181; cv=none; b=PpUK++JQfy29CFYKuFwI3xCZggcRgSvAod3JZjyJlL0FKnIUTM1X9FC96GCCH033ksnni2BafseaPYiMXqlJHWDmKVE7X4L3YKnlq2H9xFpFma6Kc0cz274DQaRtVgNv4WrEZlqEobQYJ9VQqSpYtJohYSaANNbhk2Lj8LFwZ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754181; c=relaxed/simple;
	bh=CNaAAS3i6eklEWZmqtgSxuFIrEAm4OWhn+JAXTj7WuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Txmv68b2ikLjU3JGM29y/QMT1DztbZaq6ymHskD4KAWv0X39OHqtCCLw8SyXsYqlkz+cP+5ts0Kz4+mTxrDQy3AlNNhUn0Plg6KsIikpdaQw73Amr4RemK0x3jZQAXGFi2vuhOVaC8EbqsaTHkPboIAMNGGtxIrgrR6IskXM9vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IU0tgwEF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IU0tgwEF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 245DB1F394;
	Fri, 28 Feb 2025 14:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740754172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86JF5A3Y1a/QIQE8d/d8KFj9u5yCItGzRTPIOvxSzhw=;
	b=IU0tgwEF14uTRPhKtNVRo7+a1u5Fg6HBjESGOKhmArLTHxQfFE1dBVPimzHUMneuLpkkQZ
	Jq/rLP3ksSRz+IS4KwBsuukpZb6RV6C1A1oFoDuidB3zK3GAGvJX2D39chIVgCg9Pmqohc
	JV6U7oleGF50nNrp7kriVQyPpXAjNDs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740754172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86JF5A3Y1a/QIQE8d/d8KFj9u5yCItGzRTPIOvxSzhw=;
	b=IU0tgwEF14uTRPhKtNVRo7+a1u5Fg6HBjESGOKhmArLTHxQfFE1dBVPimzHUMneuLpkkQZ
	Jq/rLP3ksSRz+IS4KwBsuukpZb6RV6C1A1oFoDuidB3zK3GAGvJX2D39chIVgCg9Pmqohc
	JV6U7oleGF50nNrp7kriVQyPpXAjNDs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DCE9137AC;
	Fri, 28 Feb 2025 14:49:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o39FB/zMwWdTPQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 28 Feb 2025 14:49:32 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/5] btrfs: add new ioctl CLEAR_FREE
Date: Fri, 28 Feb 2025 15:49:31 +0100
Message-ID: <ecc43a72997ae7836c2d227b69924d364698e665.1740753608.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740753608.git.dsterba@suse.com>
References: <cover.1740753608.git.dsterba@suse.com>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Add a new ioctl that is an extensible version of FITRIM. It currently
does only the trim/discard and will be extended by other modes like
zeroing or block unmapping.

We need a new ioctl for that because struct fstrim_range does not
provide any existing or reserved member for extensions. The new ioctl
also supports TRIM as the operation type.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c     | 92 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent-tree.h     |  2 +
 fs/btrfs/ioctl.c           | 42 +++++++++++++++++
 include/uapi/linux/btrfs.h | 20 +++++++++
 4 files changed, 156 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index df86ffde478b..4ab9850b7383 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6562,3 +6562,95 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 		return bg_ret;
 	return dev_ret;
 }
+
+int btrfs_clear_free_space(struct btrfs_fs_info *fs_info,
+			   struct btrfs_ioctl_clear_free_args *args)
+{
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_device *device;
+	struct btrfs_block_group *cache = NULL;
+	u64 group_cleared;
+	u64 range_end = U64_MAX;
+	u64 start;
+	u64 end;
+	u64 cleared = 0;
+	u64 bg_failed = 0;
+	u64 dev_failed = 0;
+	int bg_ret = 0;
+	int dev_ret = 0;
+	int ret = 0;
+
+	if (args->start == U64_MAX)
+		return -EINVAL;
+
+	/*
+	 * Check range overflow if args->length is set.  The default args->length
+	 * is U64_MAX.
+	 */
+	if (args->length != U64_MAX &&
+	    check_add_overflow(args->start, args->length, &range_end))
+		return -EINVAL;
+
+	cache = btrfs_lookup_first_block_group(fs_info, args->start);
+	for (; cache; cache = btrfs_next_block_group(cache)) {
+		if (cache->start >= range_end) {
+			btrfs_put_block_group(cache);
+			break;
+		}
+
+		start = max(args->start, cache->start);
+		end = min(range_end, cache->start + cache->length);
+
+		if (end - start >= args->minlen) {
+			if (!btrfs_block_group_done(cache)) {
+				ret = btrfs_cache_block_group(cache, true);
+				if (ret) {
+					bg_failed++;
+					bg_ret = ret;
+					continue;
+				}
+			}
+			ret = btrfs_trim_block_group(cache, &group_cleared,
+						     start, end, args->minlen,
+						     args->type);
+
+			cleared += group_cleared;
+			if (ret) {
+				bg_failed++;
+				bg_ret = ret;
+				continue;
+			}
+		}
+	}
+
+	if (bg_failed)
+		btrfs_warn(fs_info,
+			"failed to clear %llu block group(s), last error %d",
+			bg_failed, bg_ret);
+
+	mutex_lock(&fs_devices->device_list_mutex);
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
+			continue;
+
+		ret = btrfs_trim_free_extents(device, &group_cleared, args->type);
+		if (ret) {
+			dev_failed++;
+			dev_ret = ret;
+			break;
+		}
+
+		cleared += group_cleared;
+	}
+	mutex_unlock(&fs_devices->device_list_mutex);
+
+	if (dev_failed)
+		btrfs_warn(fs_info,
+			"failed to trim %llu device(s), last error %d",
+			dev_failed, dev_ret);
+	args->length = cleared;
+	if (bg_ret)
+		return bg_ret;
+
+	return dev_ret;
+}
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index c8e1a30309ab..e0702b276825 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -166,5 +166,7 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 			 u64 num_bytes, u64 *actual_bytes,
 			 enum btrfs_clear_op_type clear);
 int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range);
+int btrfs_clear_free_space(struct btrfs_fs_info *fs_info,
+			   struct btrfs_ioctl_clear_free_args *args);
 
 #endif
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index f3ce82d113be..203e8a23d6c2 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5213,6 +5213,46 @@ static int btrfs_ioctl_subvol_sync(struct btrfs_fs_info *fs_info, void __user *a
 	return 0;
 }
 
+static int btrfs_ioctl_clear_free(struct file *file, void __user *arg)
+{
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_ioctl_clear_free_args args;
+	u64 total_bytes;
+	int ret;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(&args, arg, sizeof(args)))
+		return -EFAULT;
+
+	if (args.type >= BTRFS_NR_CLEAR_OP_TYPES)
+		return -EOPNOTSUPP;
+
+	ret = mnt_want_write_file(file);
+	if (ret)
+		return ret;
+
+	fs_info = inode_to_fs_info(file_inode(file));
+	total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
+	if (args.start > total_bytes) {
+		ret = -EINVAL;
+		goto out_drop_write;
+	}
+
+	ret = btrfs_clear_free_space(fs_info, &args);
+	if (ret < 0)
+		goto out_drop_write;
+
+	if (copy_to_user(arg, &args, sizeof(args)))
+		ret = -EFAULT;
+
+out_drop_write:
+	mnt_drop_write_file(file);
+
+	return 0;
+}
+
 long btrfs_ioctl(struct file *file, unsigned int
 		cmd, unsigned long arg)
 {
@@ -5368,6 +5408,8 @@ long btrfs_ioctl(struct file *file, unsigned int
 #endif
 	case BTRFS_IOC_SUBVOL_SYNC_WAIT:
 		return btrfs_ioctl_subvol_sync(fs_info, argp);
+	case BTRFS_IOC_CLEAR_FREE:
+		return btrfs_ioctl_clear_free(file, argp);
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 64f971a6bcb2..278010aff02e 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -1094,6 +1094,24 @@ enum btrfs_clear_op_type {
 	BTRFS_NR_CLEAR_OP_TYPES,
 };
 
+struct btrfs_ioctl_clear_free_args {
+	/* In, type of clearing operation, enumerated in btrfs_clear_free_op_type. */
+	__u32 type;
+	/* Reserved must be zero. */
+	__u32 reserved1;
+	/*
+	 * In. Starting offset to clear from in the logical address space (same
+	 * as fstrim_range::start).
+	 */
+	__u64 start;			/* in */
+	/* In, out. Length from the start to clear (same as fstrim_range::length). */
+	__u64 length;
+	/* In. Minimal length to clear (same as fstrim_range::minlen). */
+	__u64 minlen;
+	/* Reserved, must be zero. */
+	__u64 reserved2[4];
+};
+
 #define BTRFS_IOC_SNAP_CREATE _IOW(BTRFS_IOCTL_MAGIC, 1, \
 				   struct btrfs_ioctl_vol_args)
 #define BTRFS_IOC_DEFRAG _IOW(BTRFS_IOCTL_MAGIC, 2, \
@@ -1200,6 +1218,8 @@ enum btrfs_clear_op_type {
 				   struct btrfs_ioctl_vol_args_v2)
 #define BTRFS_IOC_LOGICAL_INO_V2 _IOWR(BTRFS_IOCTL_MAGIC, 59, \
 					struct btrfs_ioctl_logical_ino_args)
+#define BTRFS_IOC_CLEAR_FREE _IOW(BTRFS_IOCTL_MAGIC, 90, \
+				struct btrfs_ioctl_clear_free_args)
 #define BTRFS_IOC_GET_SUBVOL_INFO _IOR(BTRFS_IOCTL_MAGIC, 60, \
 				struct btrfs_ioctl_get_subvol_info_args)
 #define BTRFS_IOC_GET_SUBVOL_ROOTREF _IOWR(BTRFS_IOCTL_MAGIC, 61, \
-- 
2.47.1


