Return-Path: <linux-btrfs+bounces-2122-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72CE84A7B6
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 22:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3801F2B1C4
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 21:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E929A12C81F;
	Mon,  5 Feb 2024 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gRu95KeB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01B112B165
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163572; cv=none; b=V4RToAVd4a2KPMgFIge3HLT088ze9trYwG7UN3EIpBdEkRRYlvQEvO9kvc8En8qdGRI38xqgsLYmVEeiho+WTT8ULREU+NNEhLYLXvy9/DUyKQVu1MyxCWYh6mNQJCAG/rjVxY17wD4WnU58Q20VWrRccgceL0WcCyNGNV3NJPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163572; c=relaxed/simple;
	bh=OdB2sC0IAQE2qn+uq4dM6SEPk8ivyay4tbCp7RxmvJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBnco59M8ju39l2VHElWCQnWP9jYImKTKMJ0vMKAbch8fDNeW2kRi7rqZ6A5Frlkob1AxFLcgbC6cc/pgIqLpM9MPczLk4/19SIKFydtmMSnfo+NdcidBmYC0GwQ7olpSNYOWwdMc5BzTFtfMQUlVrvT6ZYytfaW04Dxk9e1rh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gRu95KeB; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707163569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bL8wabdGusxxHP4HD7jQgm1B3xq2dag3vBv1kp/RjKg=;
	b=gRu95KeBmO7sGiIbVqCYHB62tHtBwScHj+QOvvEH7lwcGJhQRU4Id4sAq77nVqqAdbHcvq
	WLxA7xaJjngusplfaeucaDsaWwFjXqTUcYoVvkGuf88BCvqpXeJIIR+yzYkfGRbJ+OIIvr
	LO2rJ4oDpy+0FUucX1pT3epb4UOcd1k=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 4/6] fs: FS_IOC_GETSYSFSNAME
Date: Mon,  5 Feb 2024 15:05:15 -0500
Message-ID: <20240205200529.546646-5-kent.overstreet@linux.dev>
In-Reply-To: <20240205200529.546646-1-kent.overstreet@linux.dev>
References: <20240205200529.546646-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a new ioctl for getting the sysfs name of a filesystem - the path
under /sys/fs.

This is going to let us standardize exporting data from sysfs across
filesystems, e.g. time stats.

The returned path will always be of the form "$FSTYP/$SYSFS_IDENTIFIER",
where the sysfs identifier may be a UUID (for bcachefs) or a device name
(xfs).

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Josef Bacik <josef@toxicpanda.com>
---
 fs/ioctl.c              | 17 +++++++++++++++++
 include/linux/fs.h      |  1 +
 include/uapi/linux/fs.h |  5 +++++
 3 files changed, 23 insertions(+)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 858801060408..cb3690811d3d 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -776,6 +776,20 @@ static int ioctl_getfsuuid(struct file *file, void __user *argp)
 	return copy_to_user(argp, &u, sizeof(u)) ? -EFAULT : 0;
 }
 
+static int ioctl_getfssysfsname(struct file *file, void __user *argp)
+{
+	struct super_block *sb = file_inode(file)->i_sb;
+
+	if (!strlen(sb->s_sysfs_name))
+		return -ENOIOCTLCMD;
+
+	struct fssysfsname u = {};
+
+	snprintf(u.name, sizeof(u.name), "%s/%s", sb->s_type->name, sb->s_sysfs_name);
+
+	return copy_to_user(argp, &u, sizeof(u)) ? -EFAULT : 0;
+}
+
 /*
  * do_vfs_ioctl() is not for drivers and not intended to be EXPORT_SYMBOL()'d.
  * It's just a simple helper for sys_ioctl and compat_sys_ioctl.
@@ -861,6 +875,9 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
 	case FS_IOC_GETFSUUID:
 		return ioctl_getfsuuid(filp, argp);
 
+	case FS_IOC_GETFSSYSFSNAME:
+		return ioctl_getfssysfsname(filp, argp);
+
 	default:
 		if (S_ISREG(inode->i_mode))
 			return file_ioctl(filp, cmd, argp);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ff41ea6c3a9c..7f23f593f17c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1258,6 +1258,7 @@ struct super_block {
 	char			s_id[32];	/* Informational name */
 	uuid_t			s_uuid;		/* UUID */
 	u8			s_uuid_len;	/* Default 16, possibly smaller for weird filesystems */
+	char			s_sysfs_name[UUID_STRING_LEN + 1];
 
 	unsigned int		s_max_links;
 
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 0389fea87db5..6dd14a453277 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -78,6 +78,10 @@ struct fsuuid2 {
 	__u8        fsu_uuid[16];
 };
 
+struct fssysfsname {
+	__u8			name[64];
+};
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
@@ -231,6 +235,7 @@ struct fsxattr {
 #define FS_IOC_SETFSLABEL		_IOW(0x94, 50, char[FSLABEL_MAX])
 #define FS_IOC_GETFSUUID		_IOR(0x94, 51, struct fsuuid2)
 #define FS_IOC_SETFSUUID		_IOW(0x94, 52, struct fsuuid2)
+#define FS_IOC_GETFSSYSFSNAME		_IOR(0x94, 53, struct fssysfsname)
 
 /*
  * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
-- 
2.43.0


