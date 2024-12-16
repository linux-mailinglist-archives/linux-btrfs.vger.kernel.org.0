Return-Path: <linux-btrfs+bounces-10414-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 651EB9F3750
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 18:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50C277A658D
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 17:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16881207666;
	Mon, 16 Dec 2024 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcQZ/+wz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC40207644
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369451; cv=none; b=MXWJBeKsyos+VLbRJ0Zzbro680LPpvMGqfYiDchXwuXiol+IbfHp93+9Cmv9FTpCLbUz1IKR6HO3dzmqjFhp0qpzPnOvx/uHMHvGDqjrL8E5zEz/ql4JRxDrJdYLjfwIJrYtCgKG7tLczPpRal3s+FSwzTaM5fdaYAD19nvx4Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369451; c=relaxed/simple;
	bh=dP3Ckdy3Nb33xPgAef0Qj/1WsDhSW53bFnO+MaSP4/Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KLB29Os29uqLti8Eq6vdrAPNSgIaxD3FPsaDrF0BZ3ZE771IAtJtC7h5N/jlKMn2pg/DS3fsAS+CbYydm4tF0L0FOyuGuQC2twelGIg1zyTpT8hLuvw+G3pVHrJHn05DxX2odv3cxH28dWXH1WD0qelBgWmfySSISD7oH1dKgyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcQZ/+wz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17225C4CED0
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 17:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734369450;
	bh=dP3Ckdy3Nb33xPgAef0Qj/1WsDhSW53bFnO+MaSP4/Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hcQZ/+wzpz//uN1KlI1Lqoc7bNig6mbf20wutgwPEeRlnuTYMw0vwI8nRMeDwOWvx
	 +GHqx0PNEXax7xSGofhhQYygY2toigc1xZPw15AenOtsOX1k7/3s9eddRem+4LF5Gs
	 yG+CKKvOBviUQuHbLEjEFSop8t3gqYHvM5VpEAUmMB9DxOV3Uog2R/pYgoaM/0hndJ
	 AkO3mrUnP4anVSenT1bqA6fzTxmVNEGwKoP5I+iCHFLRVMzMDasz8tMt740J7hKPWU
	 Hhiaz2wWPwIylPGc3qexqiIekBD8tFZIqwAkGR4oChTsP7qlb/iwoqRqXWzU5DNjkv
	 sFi6v5IqL3RVg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/9] btrfs: move the exclusive operation functions into fs.c
Date: Mon, 16 Dec 2024 17:17:18 +0000
Message-Id: <e83eb7ea0a18d6866c58ca85703d4f5142bfd2e6.1734368270.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734368270.git.fdmanana@suse.com>
References: <cover.1734368270.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The declarations for the exclusive operation functions are located at fs.h
but their definitions are in ioctl.c, which doesn't make much sense since
(most of them) are used in several files other than ioctl.c. Since they
are used in several files and they are generic enough, move them out of
ioctl.c and into fs.c, even the ones that are currently only used at
ioctl.c, for the sake of having them all in the same C file.

This also reduces the module's size.

Before this change:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1782094	 161045	  16920	1960059	 1de87b	fs/btrfs/btrfs.ko

After this change:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1781492	 161037	  16920	1959449	 1de619	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/fs.c    | 81 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/ioctl.c | 80 -----------------------------------------------
 2 files changed, 81 insertions(+), 80 deletions(-)

diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index 3756a3b9c9da..09cfb43580cb 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -4,6 +4,7 @@
 #include "ctree.h"
 #include "fs.h"
 #include "accessors.h"
+#include "volumes.h"
 
 static const struct btrfs_csums {
 	u16		size;
@@ -54,6 +55,86 @@ size_t __attribute_const__ btrfs_get_num_csums(void)
 	return ARRAY_SIZE(btrfs_csums);
 }
 
+/*
+ * Start exclusive operation @type, return true on success.
+ */
+bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
+			enum btrfs_exclusive_operation type)
+{
+	bool ret = false;
+
+	spin_lock(&fs_info->super_lock);
+	if (fs_info->exclusive_operation == BTRFS_EXCLOP_NONE) {
+		fs_info->exclusive_operation = type;
+		ret = true;
+	}
+	spin_unlock(&fs_info->super_lock);
+
+	return ret;
+}
+
+/*
+ * Conditionally allow to enter the exclusive operation in case it's compatible
+ * with the running one.  This must be paired with btrfs_exclop_start_unlock()
+ * and btrfs_exclop_finish().
+ *
+ * Compatibility:
+ * - the same type is already running
+ * - when trying to add a device and balance has been paused
+ * - not BTRFS_EXCLOP_NONE - this is intentionally incompatible and the caller
+ *   must check the condition first that would allow none -> @type
+ */
+bool btrfs_exclop_start_try_lock(struct btrfs_fs_info *fs_info,
+				 enum btrfs_exclusive_operation type)
+{
+	spin_lock(&fs_info->super_lock);
+	if (fs_info->exclusive_operation == type ||
+	    (fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED &&
+	     type == BTRFS_EXCLOP_DEV_ADD))
+		return true;
+
+	spin_unlock(&fs_info->super_lock);
+	return false;
+}
+
+void btrfs_exclop_start_unlock(struct btrfs_fs_info *fs_info)
+{
+	spin_unlock(&fs_info->super_lock);
+}
+
+void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
+{
+	spin_lock(&fs_info->super_lock);
+	WRITE_ONCE(fs_info->exclusive_operation, BTRFS_EXCLOP_NONE);
+	spin_unlock(&fs_info->super_lock);
+	sysfs_notify(&fs_info->fs_devices->fsid_kobj, NULL, "exclusive_operation");
+}
+
+void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
+			  enum btrfs_exclusive_operation op)
+{
+	switch (op) {
+	case BTRFS_EXCLOP_BALANCE_PAUSED:
+		spin_lock(&fs_info->super_lock);
+		ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE ||
+		       fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD ||
+		       fs_info->exclusive_operation == BTRFS_EXCLOP_NONE ||
+		       fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED);
+		fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE_PAUSED;
+		spin_unlock(&fs_info->super_lock);
+		break;
+	case BTRFS_EXCLOP_BALANCE:
+		spin_lock(&fs_info->super_lock);
+		ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED);
+		fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE;
+		spin_unlock(&fs_info->super_lock);
+		break;
+	default:
+		btrfs_warn(fs_info,
+			"invalid exclop balance operation %d requested", op);
+	}
+}
+
 void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
 			     const char *name)
 {
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index dc5faa89cdba..0ede6a5524c2 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -403,86 +403,6 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 	return ret;
 }
 
-/*
- * Start exclusive operation @type, return true on success
- */
-bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
-			enum btrfs_exclusive_operation type)
-{
-	bool ret = false;
-
-	spin_lock(&fs_info->super_lock);
-	if (fs_info->exclusive_operation == BTRFS_EXCLOP_NONE) {
-		fs_info->exclusive_operation = type;
-		ret = true;
-	}
-	spin_unlock(&fs_info->super_lock);
-
-	return ret;
-}
-
-/*
- * Conditionally allow to enter the exclusive operation in case it's compatible
- * with the running one.  This must be paired with btrfs_exclop_start_unlock and
- * btrfs_exclop_finish.
- *
- * Compatibility:
- * - the same type is already running
- * - when trying to add a device and balance has been paused
- * - not BTRFS_EXCLOP_NONE - this is intentionally incompatible and the caller
- *   must check the condition first that would allow none -> @type
- */
-bool btrfs_exclop_start_try_lock(struct btrfs_fs_info *fs_info,
-				 enum btrfs_exclusive_operation type)
-{
-	spin_lock(&fs_info->super_lock);
-	if (fs_info->exclusive_operation == type ||
-	    (fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED &&
-	     type == BTRFS_EXCLOP_DEV_ADD))
-		return true;
-
-	spin_unlock(&fs_info->super_lock);
-	return false;
-}
-
-void btrfs_exclop_start_unlock(struct btrfs_fs_info *fs_info)
-{
-	spin_unlock(&fs_info->super_lock);
-}
-
-void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
-{
-	spin_lock(&fs_info->super_lock);
-	WRITE_ONCE(fs_info->exclusive_operation, BTRFS_EXCLOP_NONE);
-	spin_unlock(&fs_info->super_lock);
-	sysfs_notify(&fs_info->fs_devices->fsid_kobj, NULL, "exclusive_operation");
-}
-
-void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
-			  enum btrfs_exclusive_operation op)
-{
-	switch (op) {
-	case BTRFS_EXCLOP_BALANCE_PAUSED:
-		spin_lock(&fs_info->super_lock);
-		ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE ||
-		       fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD ||
-		       fs_info->exclusive_operation == BTRFS_EXCLOP_NONE ||
-		       fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED);
-		fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE_PAUSED;
-		spin_unlock(&fs_info->super_lock);
-		break;
-	case BTRFS_EXCLOP_BALANCE:
-		spin_lock(&fs_info->super_lock);
-		ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED);
-		fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE;
-		spin_unlock(&fs_info->super_lock);
-		break;
-	default:
-		btrfs_warn(fs_info,
-			"invalid exclop balance operation %d requested", op);
-	}
-}
-
 static int btrfs_ioctl_getversion(struct inode *inode, int __user *arg)
 {
 	return put_user(inode->i_generation, arg);
-- 
2.45.2


