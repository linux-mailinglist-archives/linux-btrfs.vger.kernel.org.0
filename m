Return-Path: <linux-btrfs+bounces-14828-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018D4AE2060
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 18:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B7F4C1A1C
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 16:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99A52E9EB4;
	Fri, 20 Jun 2025 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="Bo+cGcJZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCC22DF3E8;
	Fri, 20 Jun 2025 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750438222; cv=none; b=NZkn2uQLZ3hgHw162NIKSwmM/ibUvRmpi4Hh7j5Eb9Ozj+oozd4BgJmTLjZRk/ywSApetzV72z9LH0HP2m0udaHnb+9K5AHwHRUHcm3lG4NudVErE1Zqo/mzshCbIJQ3WlGefMxkbKNCdaH99sQdqXvJqw+Mn9dOWPTcCM3k9TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750438222; c=relaxed/simple;
	bh=Djr+3K7jIi45RsqDjkuU2kUeYUhAhVBD8G3UDQuEG+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mjj1HGakbVD0dL0zB+VWDomQwZUl/f+dMXHkxyI3CYUxBVnWcL5bOH3Ts6eS9xLT3lpM4kTHvIavbIWC5VFLimMKDwPO1IJGxBSgJDwnZMRXMM/4TVoAdb+nkX/DE5OXtqGk/9QJWMdYNTA59MBLgF4aHj/uI936NOiCp7du5Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=Bo+cGcJZ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bP3PF4GrMz9sSH;
	Fri, 20 Jun 2025 18:50:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1750438209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w+TsNKBMA7mmPQAazK1/o7louMuCJgM2Fjd4uBoSZWY=;
	b=Bo+cGcJZV81/ECcjgm1/g9xkeGRTegbshCg6Utv8S/Y2tVMZ+xCYR4XuTLkHXB8IRk6dib
	mTZVoS0kxV0Gu6HQCbk+WvqHZeBbqlNDaY6LBVYS/3lGFVVEyQIPCVnf10bdz3oBIJVKTN
	T35XeuPVCvgp3VUcq1/2YAVi1lShJR6Zmn6HiVENkvJYXU4XfgYpwgIUSD1NnCEbFQzx3D
	ycVXloxlmx5Zx/8A1O+SpRa1iBcWOdOLqKcNd451J7ONp4mzKDaz118ilfXSlnIkeLU/pw
	mdVawUjZo1nHat6rT7JQXuA4eHtrHZJNKBfEfyMRcYkOSfLkpq8mlmHvA5OULA==
From: Brahmajit Das <listout@listout.xyz>
To: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	kees@kernel.org,
	ailiop@suse.com,
	mark@harmstone.com,
	David Sterba <dsterba@suse.cz>,
	Brahmajit Das <bdas@suse.de>
Subject: [PATCH v4] btrfs: replace deprecated strcpy with strscpy
Date: Fri, 20 Jun 2025 22:19:57 +0530
Message-ID: <20250620164957.14922-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strcpy is deprecated due to lack of bounds checking. This patch replaces
strcpy with strscpy, the recommended alternative for null terminated
strings, to follow best practices.

There are instances where strscpy cannot be used such as where both the
source and destination are character pointers. In that instance we can
use sysfs_emit.

Link: https://github.com/KSPP/linux/issues/88
Suggested-by: Anthony Iliopoulos <ailiop@suse.com>
Suggested-by: David Sterba <dsterba@suse.cz>
Signed-off-by: Brahmajit Das <bdas@suse.de>
---

Changes in v2: using sysfs_emit instead of scnprintf.
Changes in v3: Removed string.h in xattr, since we are not using any.
fucntions from string.h and fixed length in memcpy in volumes.c
Changes in v4: As suggested by David, moving "NONE" as initial value of
buf in describe_relocation() and removed copying of "NONE" to bp in
btrfs_describe_block_groups().
---
 fs/btrfs/ioctl.c      | 2 +-
 fs/btrfs/relocation.c | 2 +-
 fs/btrfs/send.c       | 2 +-
 fs/btrfs/volumes.c    | 1 -
 fs/btrfs/xattr.c      | 3 +--
 5 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 913acef3f0a9..203f309f00b1 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4200,7 +4200,7 @@ static int btrfs_ioctl_set_fslabel(struct file *file, void __user *arg)
 	}
 
 	spin_lock(&fs_info->super_lock);
-	strcpy(super_block->label, label);
+	strscpy(super_block->label, label);
 	spin_unlock(&fs_info->super_lock);
 	ret = btrfs_commit_transaction(trans);
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 02086191630d..c136552e129c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3880,7 +3880,7 @@ static void free_reloc_control(struct reloc_control *rc)
  */
 static void describe_relocation(struct btrfs_block_group *block_group)
 {
-	char buf[128] = {'\0'};
+	char buf[128] = "NONE";
 
 	btrfs_describe_block_groups(block_group->flags, buf, sizeof(buf));
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 2891ec4056c6..66ee9e1b1e96 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -758,7 +758,7 @@ static int send_header(struct send_ctx *sctx)
 {
 	struct btrfs_stream_header hdr;
 
-	strcpy(hdr.magic, BTRFS_SEND_STREAM_MAGIC);
+	strscpy(hdr.magic, BTRFS_SEND_STREAM_MAGIC);
 	hdr.version = cpu_to_le32(sctx->proto);
 	return write_buf(sctx->send_filp, &hdr, sizeof(hdr),
 					&sctx->send_off);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 89835071cfea..8280474ec3d1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -215,7 +215,6 @@ void btrfs_describe_block_groups(u64 bg_flags, char *buf, u32 size_buf)
 	u32 size_bp = size_buf;
 
 	if (!flags) {
-		strcpy(bp, "NONE");
 		return;
 	}
 
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 3e0edbcf73e1..49fd8a49584a 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -516,8 +516,7 @@ static int btrfs_initxattrs(struct inode *inode,
 			ret = -ENOMEM;
 			break;
 		}
-		strcpy(name, XATTR_SECURITY_PREFIX);
-		strcpy(name + XATTR_SECURITY_PREFIX_LEN, xattr->name);
+		sysfs_emit(name, "%s%s", XATTR_SECURITY_PREFIX, xattr->name);
 
 		if (strcmp(name, XATTR_NAME_CAPS) == 0)
 			clear_bit(BTRFS_INODE_NO_CAP_XATTR, &BTRFS_I(inode)->runtime_flags);
-- 
2.50.0


