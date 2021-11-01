Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26BE441AE7
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Nov 2021 12:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhKAL4B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Nov 2021 07:56:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44284 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhKAL4A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Nov 2021 07:56:00 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2397C1FD29;
        Mon,  1 Nov 2021 11:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635767607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1vt4KBq6ZrMw/AX3yduRfnEj4Sr6DtsZl1kDkekUJ78=;
        b=sV2210RmT9y9qWalZs5QAU1iqR5G75oqGTj+Z1/caMgBNjKSYTtP524vXFpS/sc/dQcs2Y
        xG/OnPVgjOkrQQlTWGX1j4znYgvjcv2kXjlswc3MSTP7Cyo68b2toK0Pzyu0rS+yOXnfhY
        NXB4/YBdUVMItLJUpjhvxqhqt3eBDLk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E07AE133FE;
        Mon,  1 Nov 2021 11:53:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QIrFMzbVf2HabQAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 01 Nov 2021 11:53:26 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/3] btrfs: introduce BTRFS_EXCLOP_BALANCE_PAUSED exclusive state
Date:   Mon,  1 Nov 2021 13:53:22 +0200
Message-Id: <20211101115324.374076-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211101115324.374076-1-nborisov@suse.com>
References: <20211101115324.374076-1-nborisov@suse.com>
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
 fs/btrfs/ctree.h   |  1 +
 fs/btrfs/ioctl.c   | 20 +++++++++++++++++---
 fs/btrfs/volumes.c | 23 +++++++++++++++++++----
 fs/btrfs/volumes.h |  2 +-
 4 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 7553e9dc5f93..b1916fa548b6 100644
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
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c474f7e24163..4aa6191889a3 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3982,6 +3982,7 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_ioctl_balance_args *bargs;
 	struct btrfs_balance_control *bctl;
+	bool paused = false;
 	bool need_unlock; /* for mut. excl. ops lock */
 	int ret;
 
@@ -4019,6 +4020,10 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
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
@@ -4100,7 +4105,7 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 	 */
 	need_unlock = false;
 
-	ret = btrfs_balance(fs_info, bctl, bargs);
+	ret = btrfs_balance(fs_info, bctl, bargs, &paused);
 	bctl = NULL;
 
 	if ((ret == 0 || ret == -ECANCELED) && arg) {
@@ -4114,8 +4119,17 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 	kfree(bargs);
 out_unlock:
 	mutex_unlock(&fs_info->balance_mutex);
-	if (need_unlock)
-		btrfs_exclop_finish(fs_info);
+	if (need_unlock) {
+		if (paused) {
+			/* Transition directly to BALANCE_PAUSED */
+			spin_lock(&fs_info->super_lock);
+			ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE);
+			fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE_PAUSED;
+			spin_unlock(&fs_info->super_lock);
+		} else {
+			btrfs_exclop_finish(fs_info);
+		}
+	}
 out:
 	mnt_drop_write_file(file);
 	return ret;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 546bf1146b2d..593583307f55 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4219,7 +4219,7 @@ static void describe_balance_start_or_resume(struct btrfs_fs_info *fs_info)
  */
 int btrfs_balance(struct btrfs_fs_info *fs_info,
 		  struct btrfs_balance_control *bctl,
-		  struct btrfs_ioctl_balance_args *bargs)
+		  struct btrfs_ioctl_balance_args *bargs, bool *paused)
 {
 	u64 meta_target, data_target;
 	u64 allowed;
@@ -4355,8 +4355,11 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 	ret = __btrfs_balance(fs_info);
 
 	mutex_lock(&fs_info->balance_mutex);
-	if (ret == -ECANCELED && atomic_read(&fs_info->balance_pause_req))
+	if (ret == -ECANCELED && atomic_read(&fs_info->balance_pause_req)) {
 		btrfs_info(fs_info, "balance: paused");
+		if (paused)
+			*paused = true;
+	}
 	/*
 	 * Balance can be canceled by:
 	 *
@@ -4406,13 +4409,21 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 static int balance_kthread(void *data)
 {
 	struct btrfs_fs_info *fs_info = data;
+	bool paused = false;
 	int ret = 0;
 
 	mutex_lock(&fs_info->balance_mutex);
 	if (fs_info->balance_ctl)
-		ret = btrfs_balance(fs_info, fs_info->balance_ctl, NULL);
+		ret = btrfs_balance(fs_info, fs_info->balance_ctl, NULL, &paused);
 	mutex_unlock(&fs_info->balance_mutex);
 
+	if (paused) {
+		spin_lock(&fs_info->super_lock);
+		ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE);
+		fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE_PAUSED;
+		spin_unlock(&fs_info->super_lock);
+	}
+
 	return ret;
 }
 
@@ -4432,6 +4443,10 @@ int btrfs_resume_balance_async(struct btrfs_fs_info *fs_info)
 		return 0;
 	}
 
+	spin_lock(&fs_info->super_lock);
+	ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED);
+	fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE;
+	spin_unlock(&fs_info->super_lock);
 	/*
 	 * A ro->rw remount sequence should continue with the paused balance
 	 * regardless of who pauses it, system or the user as of now, so set
@@ -4500,7 +4515,7 @@ int btrfs_recover_balance(struct btrfs_fs_info *fs_info)
 	 * is in a paused state and must have fs_info::balance_ctl properly
 	 * set up.
 	 */
-	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED))
 		btrfs_warn(fs_info,
 	"balance: cannot set exclusive op status, resume manually");
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 3b8130680749..babcf447104b 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -541,7 +541,7 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size);
 int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *path);
 int btrfs_balance(struct btrfs_fs_info *fs_info,
 		  struct btrfs_balance_control *bctl,
-		  struct btrfs_ioctl_balance_args *bargs);
+		  struct btrfs_ioctl_balance_args *bargs, bool *paused);
 void btrfs_describe_block_groups(u64 flags, char *buf, u32 size_buf);
 int btrfs_resume_balance_async(struct btrfs_fs_info *fs_info);
 int btrfs_recover_balance(struct btrfs_fs_info *fs_info);
-- 
2.25.1

