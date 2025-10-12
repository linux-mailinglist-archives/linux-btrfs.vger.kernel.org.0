Return-Path: <linux-btrfs+bounces-17645-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A75FBD0DB9
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 01:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D7F3B62EE
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Oct 2025 23:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50901272E41;
	Sun, 12 Oct 2025 23:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JhLtc1c+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kfc0wRY2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFFE78F54
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Oct 2025 23:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760313169; cv=none; b=QzFPQ526JMpu+VY7vHYWtAUcaZGvtbT8VvlChyP4IrOnVdx8pDoc97rDAQ7XTFgDUIFqtGOHfbg21NLyOlLXurvndBqm1aX/IqeHmMHqitPFmUMtoYKYLBnHI+Zu8ZxXMbVcyy1Q432oRGUOv5ywWr+mHmZym0bJaljcbbMR7mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760313169; c=relaxed/simple;
	bh=OTvMcWWSB4IEk3tmx0YYLH+ykxA1sHW/yxnUYAf/EUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErnvuLK5EKy2/J45EtOcxqRi8eEHVkS8kE2mWLRJzQcMxjABZnThudsU8c9bhh8Xte1tuBUyc1ky46OM5C1IbOhVY3LGPojyCnFLImYVlL/LsczniK4TFlyrfRQ4iyD8g6XwyDsLFzPJNg4n1VzWPL1vcRyCdm9AVz8vhWXpZNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JhLtc1c+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kfc0wRY2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2580B1F388;
	Sun, 12 Oct 2025 23:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760313148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kMCJ5kXVzEID/s+ngVg+UPOsaTqFtwMcdtJ+uVm+GEg=;
	b=JhLtc1c+fY4YW01mFsjZPE3lRVpWu0niJ7WtOrAlrT585rcKP6aNSvhoIUAKWh6bVHCLKc
	bFrsoVeldSPAPQpLz5VUEKU4Z8jNaw4Vq0iuzXgd1/sxsFKd0zllYqIGWnOYxV/F/cBlAf
	vPbNpfxa7q5c9X5PG9NXTnPLNwsFGIM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760313147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kMCJ5kXVzEID/s+ngVg+UPOsaTqFtwMcdtJ+uVm+GEg=;
	b=kfc0wRY2suTEYj2jKb2IaNeCFjrcOmdmVrOtgnACmdBsJSfTkMsZGIASQHBxEImG99HVgV
	1+US68Mw8BhFH1Rk65Mx8ObG9wCL0zjam2praG8dNMdQoErQwPy4QrhfDCZnr55eF2ufRk
	8dkQFUMamDmYbeArJUJvQzdwjlkr2/8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27C3313782;
	Sun, 12 Oct 2025 23:52:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SEDNNjk/7Gj8SQAAD6G6ig
	(envelope-from <wqu@suse.com>); Sun, 12 Oct 2025 23:52:25 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v7 2/3] btrfs: implement shutdown ioctl
Date: Mon, 13 Oct 2025 10:22:04 +1030
Message-ID: <f7a1708e28b6476e52e1bcd36ef306a4f89f65ca.1760312845.git.wqu@suse.com>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

The shutdown ioctl should follow the XFS one, which use magic number 'X',
and ioctl number 125, with a uint32 as flags.

For now btrfs don't distinguish DEFAULT and LOGFLUSH flags (just like
f2fs), both will freeze the fs first (implies committing the current
transaction), setting the SHUTDOWN flag and finally thaw the fs.

For NOLOGFLUSH flag, the freeze/thaw part is skipped thus the current
transaction is aborted.

The new shutdown ioctl is hidden behind experimental features for more
testing.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c           | 41 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/btrfs.h |  9 +++++++++
 2 files changed, 50 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 342c8412c859..80dffe5780b0 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5223,6 +5223,43 @@ static int btrfs_ioctl_subvol_sync(struct btrfs_fs_info *fs_info, void __user *a
 	return 0;
 }
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+static int btrfs_ioctl_shutdown(struct btrfs_fs_info *fs_info, unsigned long arg)
+{
+	int ret = 0;
+	uint32_t flags;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (get_user(flags, (uint32_t __user *)arg))
+		return -EFAULT;
+
+	if (flags >= BTRFS_SHUTDOWN_FLAGS_LAST)
+		return -EINVAL;
+
+	if (btrfs_is_shutdown(fs_info))
+		return 0;
+
+	switch (flags) {
+	case BTRFS_SHUTDOWN_FLAGS_LOGFLUSH:
+	case BTRFS_SHUTDOWN_FLAGS_DEFAULT:
+		ret = freeze_super(fs_info->sb, FREEZE_HOLDER_KERNEL, NULL);
+		if (ret)
+			return ret;
+		btrfs_force_shutdown(fs_info);
+		ret = thaw_super(fs_info->sb, FREEZE_HOLDER_KERNEL, NULL);
+		if (ret)
+			return ret;
+		break;
+	case BTRFS_SHUTDOWN_FLAGS_NOLOGFLUSH:
+		btrfs_force_shutdown(fs_info);
+		break;
+	}
+	return ret;
+}
+#endif
+
 long btrfs_ioctl(struct file *file, unsigned int
 		cmd, unsigned long arg)
 {
@@ -5378,6 +5415,10 @@ long btrfs_ioctl(struct file *file, unsigned int
 #endif
 	case BTRFS_IOC_SUBVOL_SYNC_WAIT:
 		return btrfs_ioctl_subvol_sync(fs_info, argp);
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	case BTRFS_IOC_SHUTDOWN:
+		return btrfs_ioctl_shutdown(fs_info, arg);
+#endif
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 8e710bbb688e..f40b300bd664 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -1099,6 +1099,12 @@ enum btrfs_err_code {
 	BTRFS_ERROR_DEV_RAID1C4_MIN_NOT_MET,
 };
 
+/* Flags for IOC_SHUTDOWN, should match XFS' flags. */
+#define BTRFS_SHUTDOWN_FLAGS_DEFAULT	0x0
+#define BTRFS_SHUTDOWN_FLAGS_LOGFLUSH	0x1
+#define BTRFS_SHUTDOWN_FLAGS_NOLOGFLUSH	0x2
+#define BTRFS_SHUTDOWN_FLAGS_LAST	0x3
+
 #define BTRFS_IOC_SNAP_CREATE _IOW(BTRFS_IOCTL_MAGIC, 1, \
 				   struct btrfs_ioctl_vol_args)
 #define BTRFS_IOC_DEFRAG _IOW(BTRFS_IOCTL_MAGIC, 2, \
@@ -1220,6 +1226,9 @@ enum btrfs_err_code {
 #define BTRFS_IOC_SUBVOL_SYNC_WAIT _IOW(BTRFS_IOCTL_MAGIC, 65, \
 					struct btrfs_ioctl_subvol_wait)
 
+/* Shutdown ioctl should follow XFS's interfaces, thus not using btrfs magic. */
+#define BTRFS_IOC_SHUTDOWN	_IOR('X', 125, uint32_t)
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.50.1


