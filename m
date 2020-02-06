Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 381AF153FD0
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 09:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgBFIRu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 03:17:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:38474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbgBFIRu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Feb 2020 03:17:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 19174AF93;
        Thu,  6 Feb 2020 08:17:47 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Jeff Mahoney <jeffm@suse.com>
Subject: [PATCH] btrfs: qgroups, fix rescan worker running races
Date:   Thu,  6 Feb 2020 16:17:41 +0800
Message-Id: <20200206081741.9023-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There are some reports about btrfs wait forever to unmount itself, with
the following call trace:
  INFO: task umount:4631 blocked for more than 491 seconds.
        Tainted: G               X  5.3.8-2-default #1
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  umount          D    0  4631   3337 0x00000000
  Call Trace:
  ([<00000000174adf7a>] __schedule+0x342/0x748)
   [<00000000174ae3ca>] schedule+0x4a/0xd8
   [<00000000174b1f08>] schedule_timeout+0x218/0x420
   [<00000000174af10c>] wait_for_common+0x104/0x1d8
   [<000003ff804d6994>] btrfs_qgroup_wait_for_completion+0x84/0xb0 [btrfs]
   [<000003ff8044a616>] close_ctree+0x4e/0x380 [btrfs]
   [<0000000016fa3136>] generic_shutdown_super+0x8e/0x158
   [<0000000016fa34d6>] kill_anon_super+0x26/0x40
   [<000003ff8041ba88>] btrfs_kill_super+0x28/0xc8 [btrfs]
   [<0000000016fa39f8>] deactivate_locked_super+0x68/0x98
   [<0000000016fcb198>] cleanup_mnt+0xc0/0x140
   [<0000000016d6a846>] task_work_run+0xc6/0x110
   [<0000000016d04f76>] do_notify_resume+0xae/0xb8
   [<00000000174b30ae>] system_call+0xe2/0x2c8

[CAUSE]
The problem can happen like this:

	Qgroup ioctl thread		|	Unmount thread
----------------------------------------+-----------------------------------
Fs has QGROUP_STATUS_RESCAN bit set	|
And is mounted RO			|
					|
open_ctree()				|
|- btrfs_read_qgroup_config()		|
|  |- qgroup_rescan_init()		|
|     |- qgroup_rescan_running = true;	|
|- btrfs_qgroup_rescan_resume()		|
|  |- rescan work queued		|
|     but not yet executing		|
-- open_ctree() returned		|
					| close_ctree()
					| |- btrfs_qgroup_wait_for_completion()
					|    |- running == true;
					|    |- wait_for_completion();
					|
btrfs_qgroup_rescan_worker()		|
 Which is expected to be run here,	|

Since rescan worker is not yet executed , no one will wake up
btrfs_qgroup_wait_for_completion().

[FIX]
This patch will introduce a new status (qgroup_rescan_queued) to ensure
above race won't happen.

Now the lifespan of qgroup enable/rescan looks like this:

  qgroup_rescan_init()				--
  |- qgroup_rescan_queued = true;		|  Section A
     qgroup_rescan_running is still false	|
						--
  btrfs_qgroup_rescan_worker()			|
  |- qgroup_rescan_queued = false;		|
  |- qgroup_rescan_running = true;		|  Section B
						--

No cross section can happen since qgroup_rescan_* are all protected by
qgroup_rescan_lock.

In section A, btrfs_qgroup_wait_for_completion() will exit as rescan is
not running.
In section B, btrfs_qgroup_wait_for_completion() will fail current
rescan to finish.

So that no race can happen now.

Fixes: 8d9eddad194 (Btrfs: fix qgroup rescan worker initialization)
Signed-off-by: Jeff Mahoney <jeffm@suse.com>
[Move the queued = false to btrfs_qgroup_rescan_worker, commit message
 update]
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
The original version still has a window as that running bit is still set
before rescan worker get running, thus it only reduces the window, not
eliminate it.
---
 fs/btrfs/ctree.h  |  2 ++
 fs/btrfs/ioctl.c  |  4 +++-
 fs/btrfs/qgroup.c | 15 +++++++--------
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 54efb21c2727..d3bf4b62df83 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -847,6 +847,8 @@ struct btrfs_fs_info {
 	struct btrfs_workqueue *qgroup_rescan_workers;
 	struct completion qgroup_rescan_completion;
 	struct btrfs_work qgroup_rescan_work;
+	/* qgroup rescan worker queued, but not yet executed */
+	bool qgroup_rescan_queued;	/* protected by qgroup_rescan_lock */
 	bool qgroup_rescan_running;	/* protected by qgroup_rescan_lock */
 
 	/* filesystem state */
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 18e328ce4b54..505a36196fb9 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4963,10 +4963,12 @@ static long btrfs_ioctl_quota_rescan_status(struct btrfs_fs_info *fs_info,
 	if (!qsa)
 		return -ENOMEM;
 
-	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
+	mutex_lock(&fs_info->qgroup_rescan_lock);
+	if (fs_info->qgroup_rescan_queued || fs_info->qgroup_rescan_running) {
 		qsa->flags = 1;
 		qsa->progress = fs_info->qgroup_rescan_progress.objectid;
 	}
+	mutex_unlock(&fs_info->qgroup_rescan_lock);
 
 	if (copy_to_user(arg, qsa, sizeof(*qsa)))
 		ret = -EFAULT;
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index d4282e12f2a6..1ee057cc2125 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2458,7 +2458,7 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	}
 
 	mutex_lock(&fs_info->qgroup_rescan_lock);
-	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
+	if (fs_info->qgroup_rescan_queued || fs_info->qgroup_rescan_running) {
 		if (fs_info->qgroup_rescan_progress.objectid <= bytenr) {
 			mutex_unlock(&fs_info->qgroup_rescan_lock);
 			ret = 0;
@@ -3144,6 +3144,11 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 	path->search_commit_root = 1;
 	path->skip_locking = 1;
 
+	mutex_lock(&fs_info->qgroup_rescan_lock);
+	fs_info->qgroup_rescan_queued = false;
+	fs_info->qgroup_rescan_running = true;
+	mutex_unlock(&fs_info->qgroup_rescan_lock);
+
 	err = 0;
 	while (!err && !btrfs_fs_closing(fs_info)) {
 		trans = btrfs_start_transaction(fs_info->fs_root, 0);
@@ -3246,7 +3251,6 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 	}
 
 	mutex_lock(&fs_info->qgroup_rescan_lock);
-	spin_lock(&fs_info->qgroup_lock);
 
 	if (init_flags) {
 		if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
@@ -3261,7 +3265,6 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 		}
 
 		if (ret) {
-			spin_unlock(&fs_info->qgroup_lock);
 			mutex_unlock(&fs_info->qgroup_rescan_lock);
 			return ret;
 		}
@@ -3272,9 +3275,7 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 		sizeof(fs_info->qgroup_rescan_progress));
 	fs_info->qgroup_rescan_progress.objectid = progress_objectid;
 	init_completion(&fs_info->qgroup_rescan_completion);
-	fs_info->qgroup_rescan_running = true;
-
-	spin_unlock(&fs_info->qgroup_lock);
+	fs_info->qgroup_rescan_queued = true;
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
 
 	btrfs_init_work(&fs_info->qgroup_rescan_work,
@@ -3348,9 +3349,7 @@ int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,
 	int ret = 0;
 
 	mutex_lock(&fs_info->qgroup_rescan_lock);
-	spin_lock(&fs_info->qgroup_lock);
 	running = fs_info->qgroup_rescan_running;
-	spin_unlock(&fs_info->qgroup_lock);
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
 
 	if (!running)
-- 
2.25.0

