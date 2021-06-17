Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC63C3AB3A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jun 2021 14:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhFQMhP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Jun 2021 08:37:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47636 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhFQMhO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Jun 2021 08:37:14 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4764C1FDD7;
        Thu, 17 Jun 2021 12:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623933306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=GFNPKF/TKf7vix0I6YgVsxNqnt0K3WcNuu1eK1RfzJs=;
        b=Yi9BN3ieOBxO/rSOfkyoXbCnNIl5WYobb5Xj6Yuoyb4ORAXIAr4EdhLhpor5k58SZR0Vhu
        GasbZMty4ro8c5GijQCm/kapKOE2HS39ZS0N9TbPgkl+NMLwjqcAfKlyW7RNDuKj4EV4g9
        ELEooFG6xKsDR4KCvo/dSbKjrhLpHnE=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id C48BA118DD;
        Thu, 17 Jun 2021 12:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623933306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=GFNPKF/TKf7vix0I6YgVsxNqnt0K3WcNuu1eK1RfzJs=;
        b=Yi9BN3ieOBxO/rSOfkyoXbCnNIl5WYobb5Xj6Yuoyb4ORAXIAr4EdhLhpor5k58SZR0Vhu
        GasbZMty4ro8c5GijQCm/kapKOE2HS39ZS0N9TbPgkl+NMLwjqcAfKlyW7RNDuKj4EV4g9
        ELEooFG6xKsDR4KCvo/dSbKjrhLpHnE=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 4mS/IXhBy2CsKAAALh3uQQ
        (envelope-from <mpdesouza@suse.com>); Thu, 17 Jun 2021 12:35:04 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, wqu@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs: quota: Introduce new flag to cancel quota rescan
Date:   Thu, 17 Jun 2021 09:34:36 -0300
Message-Id: <20210617123436.28327-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Until now, there wasn't a way to cancel a currently running quota
rescan. The QUOTA_CTL ioctl has only commands to enable and disable,
thus, no way to cancel and restart the rescan. This functionality can be
useful to applications like snapper, that can create and delete
snapshots, and thus restarting the quota scan can be used instead of
waiting for the current scan to finish.

The new command BTRFS_QUOTA_CTL_CANCEL_RESCAN can now be used in
QUOTA_CTL ioctl to reset the progress of the rescan and stopping
btrfs_qgroup_rescan_worker.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---

 Can someone check if locking only qgrop_ioctl_lock is enough for this case, or
 if I missed something? Thanks!

 fs/btrfs/ctree.h           |  1 +
 fs/btrfs/ioctl.c           |  3 +++
 fs/btrfs/qgroup.c          | 29 +++++++++++++++++++++++++++++
 fs/btrfs/qgroup.h          |  1 +
 include/uapi/linux/btrfs.h |  1 +
 5 files changed, 35 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6131b58f779f..e1f2153d4a42 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -933,6 +933,7 @@ struct btrfs_fs_info {
 
 	/* qgroup rescan items */
 	struct mutex qgroup_rescan_lock; /* protects the progress item */
+	bool qgroup_cancel_rescan;
 	struct btrfs_key qgroup_rescan_progress;
 	struct btrfs_workqueue *qgroup_rescan_workers;
 	struct completion qgroup_rescan_completion;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0ba98e08a029..b39b6ff4650f 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4206,6 +4206,9 @@ static long btrfs_ioctl_quota_ctl(struct file *file, void __user *arg)
 	case BTRFS_QUOTA_CTL_DISABLE:
 		ret = btrfs_quota_disable(fs_info);
 		break;
+	case BTRFS_QUOTA_CTL_CANCEL_RESCAN:
+		ret = btrfs_quota_cancel_rescan(fs_info);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index d72885903b8c..077021fc63c8 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1233,6 +1233,21 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
+int btrfs_quota_cancel_rescan(struct btrfs_fs_info *fs_info)
+{
+	int ret;
+
+	mutex_lock(&fs_info->qgroup_ioctl_lock);
+	fs_info->qgroup_cancel_rescan = true;
+
+	ret = btrfs_qgroup_wait_for_completion(fs_info, false);
+
+	fs_info->qgroup_cancel_rescan = false;
+	mutex_unlock(&fs_info->qgroup_ioctl_lock);
+
+	return ret;
+}
+
 static void qgroup_dirty(struct btrfs_fs_info *fs_info,
 			 struct btrfs_qgroup *qgroup)
 {
@@ -3214,6 +3229,7 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 	int err = -ENOMEM;
 	int ret = 0;
 	bool stopped = false;
+	bool canceled = false;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -3234,6 +3250,9 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 		}
 		if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)) {
 			err = -EINTR;
+		} else if (fs_info->qgroup_cancel_rescan) {
+			canceled = true;
+			err = -ECANCELED;
 		} else {
 			err = qgroup_rescan_leaf(trans, path);
 		}
@@ -3280,6 +3299,14 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 		}
 	}
 	fs_info->qgroup_rescan_running = false;
+
+	/*
+	 * If we cancel the current rescan, set progress to zero to start over
+	 * on next rescan.
+	 */
+	if (canceled)
+		fs_info->qgroup_rescan_progress.objectid = 0;
+
 	complete_all(&fs_info->qgroup_rescan_completion);
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
 
@@ -3290,6 +3317,8 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 
 	if (stopped) {
 		btrfs_info(fs_info, "qgroup scan paused");
+	} else if (canceled) {
+		btrfs_info(fs_info, "qgroup scan canceled");
 	} else if (err >= 0) {
 		btrfs_info(fs_info, "qgroup scan completed%s",
 			err > 0 ? " (inconsistency flag cleared)" : "");
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 7283e4f549af..ae6a42312ab8 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -245,6 +245,7 @@ static inline u64 btrfs_qgroup_subvolid(u64 qgroupid)
 
 int btrfs_quota_enable(struct btrfs_fs_info *fs_info);
 int btrfs_quota_disable(struct btrfs_fs_info *fs_info);
+int btrfs_quota_cancel_rescan(struct btrfs_fs_info *fs_info);
 int btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info);
 void btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info);
 int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 22cd037123fa..29a66dd01df7 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -714,6 +714,7 @@ struct btrfs_ioctl_get_dev_stats {
 #define BTRFS_QUOTA_CTL_ENABLE	1
 #define BTRFS_QUOTA_CTL_DISABLE	2
 #define BTRFS_QUOTA_CTL_RESCAN__NOTUSED	3
+#define BTRFS_QUOTA_CTL_CANCEL_RESCAN 4
 struct btrfs_ioctl_quota_ctl_args {
 	__u64 cmd;
 	__u64 status;
-- 
2.26.2

