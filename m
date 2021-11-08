Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529674481BB
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 15:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbhKHObI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 09:31:08 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56520 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239426AbhKHObI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 09:31:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F327B1FD77;
        Mon,  8 Nov 2021 14:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636381703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0OPS7plwQ8h/iut88W/L9SD7N5GqIVniFsEOg3tgkjs=;
        b=JyBzqwd1Fmoz6B+InvP6Pf25vafp+VLNfHDud2XRkooxnxN7MJAR0Im8pGREwfH4N1BlY8
        qD5eLGZbNimJ0Kisdzh/2UNatEH53HpQDpmPvZOKYres+xJDUoroGQWSLgrXIO04D0FV/p
        8W0PI1Vxo9PM43ux2LS8n85Ndpoh+pk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C294613BA0;
        Mon,  8 Nov 2021 14:28:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8AnPLAY0iWGSJgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 08 Nov 2021 14:28:22 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 1/3] btrfs: introduce BTRFS_EXCLOP_BALANCE_PAUSED exclusive state
Date:   Mon,  8 Nov 2021 16:28:18 +0200
Message-Id: <20211108142820.1003187-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211108142820.1003187-1-nborisov@suse.com>
References: <20211108142820.1003187-1-nborisov@suse.com>
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
 fs/btrfs/ctree.h   |  3 +++
 fs/btrfs/ioctl.c   | 13 +++++++++++++
 fs/btrfs/volumes.c | 11 +++++++++--
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 7553e9dc5f93..8376271bfed1 100644
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
@@ -3305,6 +3306,8 @@ bool btrfs_exclop_start_try_lock(struct btrfs_fs_info *fs_info,
 				 enum btrfs_exclusive_operation type);
 void btrfs_exclop_start_unlock(struct btrfs_fs_info *fs_info);
 void btrfs_exclop_finish(struct btrfs_fs_info *fs_info);
+void btrfs_exclop_pause_balance(struct btrfs_fs_info *fs_info);
+
 
 /* file.c */
 int __init btrfs_auto_defrag_init(void);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 92424a22d8d6..f4c05a9aab84 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -414,6 +414,15 @@ void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
 	sysfs_notify(&fs_info->fs_devices->fsid_kobj, NULL, "exclusive_operation");
 }
 
+void btrfs_exclop_pause_balance(struct btrfs_fs_info *fs_info)
+{
+	spin_lock(&fs_info->super_lock);
+	ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE ||
+	       fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD);
+	fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE_PAUSED;
+	spin_unlock(&fs_info->super_lock);
+}
+
 static int btrfs_ioctl_getversion(struct file *file, int __user *arg)
 {
 	struct inode *inode = file_inode(file);
@@ -4020,6 +4029,10 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 			if (fs_info->balance_ctl &&
 			    !test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags)) {
 				/* this is (3) */
+				spin_lock(&fs_info->super_lock);
+				ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED);
+				fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE;
+				spin_unlock(&fs_info->super_lock);
 				need_unlock = false;
 				goto locked;
 			}
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index cc80f2a97a0b..e87f9ac440c2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4355,8 +4355,10 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 	ret = __btrfs_balance(fs_info);
 
 	mutex_lock(&fs_info->balance_mutex);
-	if (ret == -ECANCELED && atomic_read(&fs_info->balance_pause_req))
+	if (ret == -ECANCELED && atomic_read(&fs_info->balance_pause_req)) {
 		btrfs_info(fs_info, "balance: paused");
+		btrfs_exclop_pause_balance(fs_info);
+	}
 	/*
 	 * Balance can be canceled by:
 	 *
@@ -4406,6 +4408,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 static int balance_kthread(void *data)
 {
 	struct btrfs_fs_info *fs_info = data;
+	bool paused = false;
 	int ret = 0;
 
 	mutex_lock(&fs_info->balance_mutex);
@@ -4432,6 +4435,10 @@ int btrfs_resume_balance_async(struct btrfs_fs_info *fs_info)
 		return 0;
 	}
 
+	spin_lock(&fs_info->super_lock);
+	ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED);
+	fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE;
+	spin_unlock(&fs_info->super_lock);
 	/*
 	 * A ro->rw remount sequence should continue with the paused balance
 	 * regardless of who pauses it, system or the user as of now, so set
@@ -4500,7 +4507,7 @@ int btrfs_recover_balance(struct btrfs_fs_info *fs_info)
 	 * is in a paused state and must have fs_info::balance_ctl properly
 	 * set up.
 	 */
-	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED))
 		btrfs_warn(fs_info,
 	"balance: cannot set exclusive op status, resume manually");
 
-- 
2.25.1

