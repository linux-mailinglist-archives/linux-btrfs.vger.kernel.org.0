Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCECC15521F
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 06:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgBGFia (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 00:38:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:34698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgBGFia (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Feb 2020 00:38:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E17D4AB95;
        Fri,  7 Feb 2020 05:38:27 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Jeff Mahoney <jeffm@suse.com>
Subject: [PATCH v2 1/2] btrfs: qgroup: Ensure qgroup_rescan_running is only set when the worker is at least queued
Date:   Fri,  7 Feb 2020 13:38:20 +0800
Message-Id: <20200207053821.25643-2-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207053821.25643-1-wqu@suse.com>
References: <20200207053821.25643-1-wqu@suse.com>
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
The problem happens when we have called qgroup_rescan_init(), but
doesn't queue the worker. It can be caused mostly by error handling.

	Qgroup ioctl thread		|	Unmount thread
----------------------------------------+-----------------------------------
					|
btrfs_qgroup_rescan()			|
|- qgroup_rescan_init()			|
|  |- qgroup_rescan_running = true;	|
|					|
|- trans = btrfs_join_transaction()	|
|  Some error happened			|
|					|
|- btrfs_qgroup_rescan() returns error	|
   But qgroup_rescan_running == true;	|
					| close_ctree()
					| |- btrfs_qgroup_wait_for_completion()
					|    |- running == true;
					|    |- wait_for_completion();

btrfs_qgroup_rescan_worker is never queued, thus no one is going to wake
up close_ctree() and we get a deadlock.

All involved qgroup_rescan_init() callers are:
- btrfs_qgroup_rescan()
  The example above. It's possible to trigger the deadlock when error
  happened.

- btrfs_quota_enable()
  Not possible. Just after qgroup_rescan_init() we queue the work.

- btrfs_read_qgroup_config()
  It's possible to trigger the deadlock. It only init the work, the
  work queueing happens in btrfs_qgroup_rescan_resume().
  Thus if error happened between, deadlock is possible.

We shouldn't set fs_info->qgroup_rescan_running just in
qgroup_rescan_init(), as at that stage we haven't yet submit qgroup
rescan worker to run.

[FIX]
This patch fixes the problem by setting qgroup_rescan_running before
queueing the work, so that we ensure the rescan work is queued when we
wait for it.

Fixes: 8d9eddad194 (Btrfs: fix qgroup rescan worker initialization)
Signed-off-by: Jeff Mahoney <jeffm@suse.com>
[ Change subject and cause analyse, use a smaller fix ]
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Change the subject
  It's not about race. I got confused by the initial patch.

- Change the cause analyse
  No need for any race. Also add analyse for all qgroup_rescan_init()
  callers to ensure no missing fixes.
  BTW, qgroup_rescan_init() uses BTRFS_QGROUP_STATUS_FLAG_RESCAN flag to
  determine if there is a conflicting rescan, thus it's not affected by
  the timing change.

- Split the spinlock cleanup into another patch

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index d4282e12f2a6..812f51f67903 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1030,6 +1030,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	ret = qgroup_rescan_init(fs_info, 0, 1);
 	if (!ret) {
 	        qgroup_rescan_zero_tracking(fs_info);
+		fs_info->qgroup_rescan_running = true;
 	        btrfs_queue_work(fs_info->qgroup_rescan_workers,
 	                         &fs_info->qgroup_rescan_work);
 	}
@@ -3272,7 +3273,6 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 		sizeof(fs_info->qgroup_rescan_progress));
 	fs_info->qgroup_rescan_progress.objectid = progress_objectid;
 	init_completion(&fs_info->qgroup_rescan_completion);
-	fs_info->qgroup_rescan_running = true;
 
 	spin_unlock(&fs_info->qgroup_lock);
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
@@ -3335,8 +3335,11 @@ btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info)
 
 	qgroup_rescan_zero_tracking(fs_info);
 
+	mutex_lock(&fs_info->qgroup_rescan_lock);
+	fs_info->qgroup_rescan_running = true;
 	btrfs_queue_work(fs_info->qgroup_rescan_workers,
 			 &fs_info->qgroup_rescan_work);
+	mutex_unlock(&fs_info->qgroup_rescan_lock);
 
 	return 0;
 }
@@ -3372,9 +3375,13 @@ int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,
 void
 btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info)
 {
-	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN)
+	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
+		mutex_lock(&fs_info->qgroup_rescan_lock);
+		fs_info->qgroup_rescan_running = true;
 		btrfs_queue_work(fs_info->qgroup_rescan_workers,
 				 &fs_info->qgroup_rescan_work);
+		mutex_unlock(&fs_info->qgroup_rescan_lock);
+	}
 }
 
 /*
-- 
2.25.0

