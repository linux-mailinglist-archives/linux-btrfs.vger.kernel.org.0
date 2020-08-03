Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454B123AE19
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Aug 2020 22:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgHCU30 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Aug 2020 16:29:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:50216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727831AbgHCU3Z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Aug 2020 16:29:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 65775AC94;
        Mon,  3 Aug 2020 20:29:38 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 1/3] btrfs: enumerate the type of exclusive operation in progress
Date:   Mon,  3 Aug 2020 15:29:10 -0500
Message-Id: <20200803202913.15913-2-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200803202913.15913-1-rgoldwyn@suse.de>
References: <20200803202913.15913-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Instead of using a flag bit for exclusive operation, use an atomic_t
variable to store if the exclusive operation is being performed.
Introduce an API to start and finish an exclusive operation.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h       | 24 +++++++++++++++++++-----
 fs/btrfs/dev-replace.c |  4 ++--
 fs/btrfs/inode.c       |  4 ++--
 fs/btrfs/ioctl.c       | 36 +++++++++++++++++++++++-------------
 fs/btrfs/volumes.c     |  8 ++++----
 5 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d404cce8ae40..a56f383a7894 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -540,11 +540,6 @@ enum {
 	BTRFS_FS_QUOTA_OVERRIDE,
 	/* Used to record internally whether fs has been frozen */
 	BTRFS_FS_FROZEN,
-	/*
-	 * Indicate that a whole-filesystem exclusive operation is running
-	 * (device replace, resize, device add/delete, balance)
-	 */
-	BTRFS_FS_EXCL_OP,
 	/*
 	 * To info transaction_kthread we need an immediate commit so it
 	 * doesn't need to wait for commit_interval
@@ -570,6 +565,20 @@ enum {
 	BTRFS_FS_DISCARD_RUNNING,
 };
 
+/*
+ * Exclusive operation values
+ * (device replace, resize, device add/remove, balance)
+ */
+enum btrfs_exclusive_operation_t {
+	BTRFS_EXCLOP_NONE = 0,
+	BTRFS_EXCLOP_BALANCE,
+	BTRFS_EXCLOP_DEV_ADD,
+	BTRFS_EXCLOP_DEV_REPLACE,
+	BTRFS_EXCLOP_DEV_REMOVE,
+	BTRFS_EXCLOP_SWAP_ACTIVATE,
+	BTRFS_EXCLOP_RESIZE,
+};
+
 struct btrfs_fs_info {
 	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
 	unsigned long flags;
@@ -939,6 +948,9 @@ struct btrfs_fs_info {
 	 */
 	int send_in_progress;
 
+	/* Type of exclusive operation running */
+	atomic_t exclusive_operation;
+
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
@@ -2949,6 +2961,8 @@ void btrfs_get_block_group_info(struct list_head *groups_list,
 				struct btrfs_ioctl_space_info *space);
 void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
 			       struct btrfs_ioctl_balance_args *bargs);
+bool btrfs_exclop_start(struct btrfs_fs_info *fs_info, int type);
+void btrfs_exclop_finish(struct btrfs_fs_info *fs_info);
 
 /* file.c */
 int __init btrfs_auto_defrag_init(void);
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index db93909b25e0..b8406f5cc8ff 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -983,7 +983,7 @@ int btrfs_resume_dev_replace_async(struct btrfs_fs_info *fs_info)
 	 * should never allow both to start and pause. We don't want to allow
 	 * dev-replace to start anyway.
 	 */
-	if (test_and_set_bit(BTRFS_FS_EXCL_OP, &fs_info->flags)) {
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_REPLACE)) {
 		down_write(&dev_replace->rwsem);
 		dev_replace->replace_state =
 					BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED;
@@ -1020,7 +1020,7 @@ static int btrfs_dev_replace_kthread(void *data)
 	ret = btrfs_dev_replace_finishing(fs_info, ret);
 	WARN_ON(ret && ret != -ECANCELED);
 
-	clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);
+	btrfs_exclop_finish(fs_info);
 	return 0;
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6862cd7e21a9..9842dbcd0d7e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10009,7 +10009,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	 * concurrent device add which isn't actually necessary, but it's not
 	 * really worth the trouble to allow it.
 	 */
-	if (test_and_set_bit(BTRFS_FS_EXCL_OP, &fs_info->flags)) {
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_SWAP_ACTIVATE)) {
 		btrfs_warn(fs_info,
 	   "cannot activate swapfile while exclusive operation is running");
 		return -EBUSY;
@@ -10155,7 +10155,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	if (ret)
 		btrfs_swap_deactivate(file);
 
-	clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);
+	btrfs_exclop_finish(fs_info);
 
 	if (ret)
 		return ret;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e8f7c5f00894..3352b4ffa5c6 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -364,6 +364,17 @@ static int check_xflags(unsigned int flags)
 	return 0;
 }
 
+bool btrfs_exclop_start(struct btrfs_fs_info *fs_info, int type)
+{
+	return !atomic_cmpxchg(&fs_info->exclusive_operation, BTRFS_EXCLOP_NONE,
+			type);
+}
+
+void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
+{
+	atomic_set(&fs_info->exclusive_operation, BTRFS_EXCLOP_NONE);
+}
+
 /*
  * Set the xflags from the internal inode flags. The remaining items of fsxattr
  * are zeroed.
@@ -1605,7 +1616,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 	if (ret)
 		return ret;
 
-	if (test_and_set_bit(BTRFS_FS_EXCL_OP, &fs_info->flags)) {
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_RESIZE)) {
 		mnt_drop_write_file(file);
 		return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
 	}
@@ -1719,7 +1730,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 out_free:
 	kfree(vol_args);
 out:
-	clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);
+	btrfs_exclop_finish(fs_info);
 	mnt_drop_write_file(file);
 	return ret;
 }
@@ -3079,7 +3090,7 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (test_and_set_bit(BTRFS_FS_EXCL_OP, &fs_info->flags))
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_ADD))
 		return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
 
 	vol_args = memdup_user(arg, sizeof(*vol_args));
@@ -3096,7 +3107,7 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
 
 	kfree(vol_args);
 out:
-	clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);
+	btrfs_exclop_finish(fs_info);
 	return ret;
 }
 
@@ -3125,7 +3136,7 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 		goto out;
 	}
 
-	if (test_and_set_bit(BTRFS_FS_EXCL_OP, &fs_info->flags)) {
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_REMOVE)) {
 		ret = BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
 		goto out;
 	}
@@ -3136,7 +3147,7 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 		vol_args->name[BTRFS_SUBVOL_NAME_MAX] = '\0';
 		ret = btrfs_rm_device(fs_info, vol_args->name, 0);
 	}
-	clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);
+	btrfs_exclop_finish(fs_info);
 
 	if (!ret) {
 		if (vol_args->flags & BTRFS_DEVICE_SPEC_BY_ID)
@@ -3167,7 +3178,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	if (ret)
 		return ret;
 
-	if (test_and_set_bit(BTRFS_FS_EXCL_OP, &fs_info->flags)) {
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_REMOVE)) {
 		ret = BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
 		goto out_drop_write;
 	}
@@ -3185,7 +3196,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 		btrfs_info(fs_info, "disk deleted %s", vol_args->name);
 	kfree(vol_args);
 out:
-	clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);
+	btrfs_exclop_finish(fs_info);
 out_drop_write:
 	mnt_drop_write_file(file);
 
@@ -3668,11 +3679,11 @@ static long btrfs_ioctl_dev_replace(struct btrfs_fs_info *fs_info,
 			ret = -EROFS;
 			goto out;
 		}
-		if (test_and_set_bit(BTRFS_FS_EXCL_OP, &fs_info->flags)) {
+		if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_REPLACE)) {
 			ret = BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
 		} else {
 			ret = btrfs_dev_replace_by_ioctl(fs_info, p);
-			clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);
+			btrfs_exclop_finish(fs_info);
 		}
 		break;
 	case BTRFS_IOCTL_DEV_REPLACE_CMD_STATUS:
@@ -3883,7 +3894,7 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 		return ret;
 
 again:
-	if (!test_and_set_bit(BTRFS_FS_EXCL_OP, &fs_info->flags)) {
+	if (btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
 		mutex_lock(&fs_info->balance_mutex);
 		need_unlock = true;
 		goto locked;
@@ -3929,7 +3940,6 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 	}
 
 locked:
-	BUG_ON(!test_bit(BTRFS_FS_EXCL_OP, &fs_info->flags));
 
 	if (arg) {
 		bargs = memdup_user(arg, sizeof(*bargs));
@@ -4006,7 +4016,7 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 out_unlock:
 	mutex_unlock(&fs_info->balance_mutex);
 	if (need_unlock)
-		clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);
+		btrfs_exclop_finish(fs_info);
 out:
 	mnt_drop_write_file(file);
 	return ret;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f403fb1e6d37..1dbee87167ac 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4150,7 +4150,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 	if ((ret && ret != -ECANCELED && ret != -ENOSPC) ||
 	    balance_need_close(fs_info)) {
 		reset_balance_state(fs_info);
-		clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);
+		btrfs_exclop_finish(fs_info);
 	}
 
 	wake_up(&fs_info->balance_wait_q);
@@ -4161,7 +4161,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 		reset_balance_state(fs_info);
 	else
 		kfree(bctl);
-	clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);
+	btrfs_exclop_finish(fs_info);
 
 	return ret;
 }
@@ -4263,7 +4263,7 @@ int btrfs_recover_balance(struct btrfs_fs_info *fs_info)
 	 * is in a paused state and must have fs_info::balance_ctl properly
 	 * set up.
 	 */
-	if (test_and_set_bit(BTRFS_FS_EXCL_OP, &fs_info->flags))
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
 		btrfs_warn(fs_info,
 	"balance: cannot set exclusive op status, resume manually");
 
@@ -4345,7 +4345,7 @@ int btrfs_cancel_balance(struct btrfs_fs_info *fs_info)
 
 		if (fs_info->balance_ctl) {
 			reset_balance_state(fs_info);
-			clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);
+			btrfs_exclop_finish(fs_info);
 			btrfs_info(fs_info, "balance: canceled");
 		}
 	}
-- 
2.26.2

