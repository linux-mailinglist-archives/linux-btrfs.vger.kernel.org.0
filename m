Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF35245D6F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Nov 2021 10:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346871AbhKYJTu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 04:19:50 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42468 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347256AbhKYJR6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 04:17:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0EAE621B37;
        Thu, 25 Nov 2021 09:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637831687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JVB+jvD0FfvkmqKgKkNUSuN6lvfExuQDaID7SHPrgtc=;
        b=JcjhXEWFoh1TtlvSZXzR5ExXpNNOxaPmrEj3hJZxbWiwN2FqsNcNbnre9fk23aNyEHfy0g
        ZOk2ALGgmb9ALAEuZAyl0FuRLnAb0vKD+Isx12CrgzAwOXZ1pSLu7GIvuzIbaCUefnDwZn
        j+pNnmP4BBwW+8iFNlr/953XuZL8o3U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1A2E13F62;
        Thu, 25 Nov 2021 09:14:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aECBMAZUn2EOHAAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 25 Nov 2021 09:14:46 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 1/3] btrfs: introduce BTRFS_EXCLOP_BALANCE_PAUSED exclusive state
Date:   Thu, 25 Nov 2021 11:14:41 +0200
Message-Id: <20211125091443.762092-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125091443.762092-1-nborisov@suse.com>
References: <20211125091443.762092-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Current set of exclusive operation states is not sufficient to handle all
practical use cases. In particular there is a need to be able to add a
device to a filesystem that have paused balance. Currently there is no
way to distinguish between a running and a paused balance. Fix this by
introducing BTRFS_EXCLOP_BALANCE_PAUSED which is going to be set in 2
occasions:

1. When a filesystem is mounted with skip_balance and there is an
   unfinished balance it will now be into BALANCE_PAUSED instead of
   simply BALANCE state.

2. When a running balance is paused.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h   |  4 ++++
 fs/btrfs/ioctl.c   | 23 +++++++++++++++++++++++
 fs/btrfs/volumes.c | 10 ++++++++--
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 5e29f3fc527d..79a873c6d186 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -613,6 +613,7 @@ enum {
  */
 enum btrfs_exclusive_operation {
 	BTRFS_EXCLOP_NONE,
+	BTRFS_EXCLOP_BALANCE_PAUSED,
 	BTRFS_EXCLOP_BALANCE,
 	BTRFS_EXCLOP_DEV_ADD,
 	BTRFS_EXCLOP_DEV_REMOVE,
@@ -3316,6 +3317,9 @@ bool btrfs_exclop_start_try_lock(struct btrfs_fs_info *fs_info,
 				 enum btrfs_exclusive_operation type);
 void btrfs_exclop_start_unlock(struct btrfs_fs_info *fs_info);
 void btrfs_exclop_finish(struct btrfs_fs_info *fs_info);
+void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
+			  enum btrfs_exclusive_operation op);
+
 
 /* file.c */
 int __init btrfs_auto_defrag_init(void);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 5263f991ffff..ffe33e853bfa 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -414,6 +414,28 @@ void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
 	sysfs_notify(&fs_info->fs_devices->fsid_kobj, NULL, "exclusive_operation");
 }
 
+void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
+			  enum btrfs_exclusive_operation op)
+{
+	switch (op) {
+	case BTRFS_EXCLOP_BALANCE_PAUSED:
+		spin_lock(&fs_info->super_lock);
+		ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE ||
+		       fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD);
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
+		WARN(1, "BTRFS: invalid balance operation requested\n");
+	}
+}
+
 static int btrfs_ioctl_getversion(struct file *file, int __user *arg)
 {
 	struct inode *inode = file_inode(file);
@@ -4062,6 +4084,7 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 			spin_lock(&fs_info->balance_lock);
 			bctl->flags |= BTRFS_BALANCE_RESUME;
 			spin_unlock(&fs_info->balance_lock);
+			btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE);
 
 			goto do_balance;
 		}
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 45c91a2f172c..8cbc82d49ef0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4388,8 +4388,10 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 	ret = __btrfs_balance(fs_info);
 
 	mutex_lock(&fs_info->balance_mutex);
-	if (ret == -ECANCELED && atomic_read(&fs_info->balance_pause_req))
+	if (ret == -ECANCELED && atomic_read(&fs_info->balance_pause_req)) {
 		btrfs_info(fs_info, "balance: paused");
+		btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED);
+	}
 	/*
 	 * Balance can be canceled by:
 	 *
@@ -4465,6 +4467,10 @@ int btrfs_resume_balance_async(struct btrfs_fs_info *fs_info)
 		return 0;
 	}
 
+	spin_lock(&fs_info->super_lock);
+	ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED);
+	fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE;
+	spin_unlock(&fs_info->super_lock);
 	/*
 	 * A ro->rw remount sequence should continue with the paused balance
 	 * regardless of who pauses it, system or the user as of now, so set
@@ -4533,7 +4539,7 @@ int btrfs_recover_balance(struct btrfs_fs_info *fs_info)
 	 * is in a paused state and must have fs_info::balance_ctl properly
 	 * set up.
 	 */
-	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED))
 		btrfs_warn(fs_info,
 	"balance: cannot set exclusive op status, resume manually");
 
-- 
2.25.1

