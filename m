Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBD1251BC2
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 17:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHYPCo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 11:02:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:52230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbgHYPCn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 11:02:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8414AADDB;
        Tue, 25 Aug 2020 15:03:11 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/2] btrfs: enumerate the type of exclusive operation in progress
Date:   Tue, 25 Aug 2020 10:02:32 -0500
Message-Id: <20200825150233.30294-2-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825150233.30294-1-rgoldwyn@suse.de>
References: <20200825150233.30294-1-rgoldwyn@suse.de>
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
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h       | 24 +++++++++++++++++++-----
 fs/btrfs/dev-replace.c |  4 ++--
 fs/btrfs/inode.c       |  4 ++--
 fs/btrfs/ioctl.c       | 36 +++++++++++++++++++++++-------------
 fs/btrfs/volumes.c     |  8 ++++----
 5 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a3b110ffbc93..e7ac63446346 100644
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
 	 * Indicate that balance has been set up from the ioctl and is in the
 	 * main phase. The fs_info::balance_ctl is initialized.
@@ -565,6 +560,20 @@ enum {
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
@@ -936,6 +945,9 @@ struct btrfs_fs_info {
 	 */
 	int send_in_progress;
 
+	/* Type of exclusive operation running */
+	atomic_t exclusive_operation;
+
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
@@ -3034,6 +3046,8 @@ void btrfs_get_block_group_info(struct list_head *groups_list,
 				struct btrfs_ioctl_space_info *space);
 void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
 			       struct btrfs_ioctl_balance_args *bargs);
+bool btrfs_exclop_start(struct btrfs_fs_info *fs_info, int type);
+void btrfs_exclop_finish(struct btrfs_fs_info *fs_info);
 
 /* file.c */
 int __init btrfs_auto_defrag_init(void);
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 769ac3098880..3671a2039dad 100644
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
index 144b9bd79cfb..87d1b7888d1c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9978,7 +9978,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	 * concurrent device add which isn't actually necessary, but it's not
 	 * really worth the trouble to allow it.
 	 */
-	if (test_and_set_bit(BTRFS_FS_EXCL_OP, &fs_info->flags)) {
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_SWAP_ACTIVATE)) {
 		btrfs_warn(fs_info,
 	   "cannot activate swapfile while exclusive operation is running");
 		return -EBUSY;
@@ -10124,7 +10124,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	if (ret)
 		btrfs_swap_deactivate(file);
 
-	clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);
+	btrfs_exclop_finish(fs_info);
 
 	if (ret)
 		return ret;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e45520d3cf51..256e58d42a7b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -378,6 +378,17 @@ static int check_xflags(unsigned int flags)
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
@@ -1638,7 +1649,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 	if (ret)
 		return ret;
 
-	if (test_and_set_bit(BTRFS_FS_EXCL_OP, &fs_info->flags)) {
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_RESIZE)) {
 		mnt_drop_write_file(file);
 		return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
 	}
@@ -1752,7 +1763,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 out_free:
 	kfree(vol_args);
 out:
-	clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);
+	btrfs_exclop_finish(fs_info);
 	mnt_drop_write_file(file);
 	return ret;
 }
@@ -3112,7 +3123,7 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (test_and_set_bit(BTRFS_FS_EXCL_OP, &fs_info->flags))
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_ADD))
 		return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
 
 	vol_args = memdup_user(arg, sizeof(*vol_args));
@@ -3129,7 +3140,7 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
 
 	kfree(vol_args);
 out:
-	clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);
+	btrfs_exclop_finish(fs_info);
 	return ret;
 }
 
@@ -3158,7 +3169,7 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 		goto out;
 	}
 
-	if (test_and_set_bit(BTRFS_FS_EXCL_OP, &fs_info->flags)) {
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_REMOVE)) {
 		ret = BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
 		goto out;
 	}
@@ -3169,7 +3180,7 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 		vol_args->name[BTRFS_SUBVOL_NAME_MAX] = '\0';
 		ret = btrfs_rm_device(fs_info, vol_args->name, 0);
 	}
-	clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);
+	btrfs_exclop_finish(fs_info);
 
 	if (!ret) {
 		if (vol_args->flags & BTRFS_DEVICE_SPEC_BY_ID)
@@ -3200,7 +3211,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	if (ret)
 		return ret;
 
-	if (test_and_set_bit(BTRFS_FS_EXCL_OP, &fs_info->flags)) {
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_REMOVE)) {
 		ret = BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
 		goto out_drop_write;
 	}
@@ -3218,7 +3229,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 		btrfs_info(fs_info, "disk deleted %s", vol_args->name);
 	kfree(vol_args);
 out:
-	clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);
+	btrfs_exclop_finish(fs_info);
 out_drop_write:
 	mnt_drop_write_file(file);
 
@@ -3722,11 +3733,11 @@ static long btrfs_ioctl_dev_replace(struct btrfs_fs_info *fs_info,
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
@@ -3937,7 +3948,7 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 		return ret;
 
 again:
-	if (!test_and_set_bit(BTRFS_FS_EXCL_OP, &fs_info->flags)) {
+	if (btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
 		mutex_lock(&fs_info->balance_mutex);
 		need_unlock = true;
 		goto locked;
@@ -3983,7 +3994,6 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 	}
 
 locked:
-	BUG_ON(!test_bit(BTRFS_FS_EXCL_OP, &fs_info->flags));
 
 	if (arg) {
 		bargs = memdup_user(arg, sizeof(*bargs));
@@ -4060,7 +4070,7 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
 out_unlock:
 	mutex_unlock(&fs_info->balance_mutex);
 	if (need_unlock)
-		clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);
+		btrfs_exclop_finish(fs_info);
 out:
 	mnt_drop_write_file(file);
 	return ret;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1d5026fdfc75..a65199f3dc2b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4183,7 +4183,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 	if ((ret && ret != -ECANCELED && ret != -ENOSPC) ||
 	    balance_need_close(fs_info)) {
 		reset_balance_state(fs_info);
-		clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);
+		btrfs_exclop_finish(fs_info);
 	}
 
 	wake_up(&fs_info->balance_wait_q);
@@ -4194,7 +4194,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 		reset_balance_state(fs_info);
 	else
 		kfree(bctl);
-	clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);
+	btrfs_exclop_finish(fs_info);
 
 	return ret;
 }
@@ -4296,7 +4296,7 @@ int btrfs_recover_balance(struct btrfs_fs_info *fs_info)
 	 * is in a paused state and must have fs_info::balance_ctl properly
 	 * set up.
 	 */
-	if (test_and_set_bit(BTRFS_FS_EXCL_OP, &fs_info->flags))
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
 		btrfs_warn(fs_info,
 	"balance: cannot set exclusive op status, resume manually");
 
@@ -4378,7 +4378,7 @@ int btrfs_cancel_balance(struct btrfs_fs_info *fs_info)
 
 		if (fs_info->balance_ctl) {
 			reset_balance_state(fs_info);
-			clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);
+			btrfs_exclop_finish(fs_info);
 			btrfs_info(fs_info, "balance: canceled");
 		}
 	}
-- 
2.26.2

