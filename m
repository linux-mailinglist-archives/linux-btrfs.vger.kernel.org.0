Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5ED1A40C6
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Apr 2020 05:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgDJD5l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Apr 2020 23:57:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbgDJDtE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Apr 2020 23:49:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DAAF20BED;
        Fri, 10 Apr 2020 03:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490543;
        bh=lABfZ7aitP7aSF+M8Hytllii8vJ7y4Z+qPIUpU69HGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UKoGc4oT1S0cGUvBqGe9YUkCsaSQNEnsvT3EnCj21BP9GaYDJOh9ISt2kw6zu3cjs
         ZpTzzDrSFxlY2nYjkjOh5Tew2NglLRvTZZPF6VlyKqwe6hHiF/UQfqhDYLw66WDSwC
         VRfu+g9GcB+yOZCu9PmXWAY2fDsD2ZhMf3626++o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 53/56] btrfs: qgroup: ensure qgroup_rescan_running is only set when the worker is at least queued
Date:   Thu,  9 Apr 2020 23:47:57 -0400
Message-Id: <20200410034800.8381-53-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410034800.8381-1-sashal@kernel.org>
References: <20200410034800.8381-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit d61acbbf54c612ea9bf67eed609494cda0857b3a ]

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
not queued the worker. It can be caused mostly by error handling.

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
  Thus if error happened in between, deadlock is possible.

We shouldn't set fs_info->qgroup_rescan_running just in
qgroup_rescan_init(), as at that stage we haven't yet queued qgroup
rescan worker to run.

[FIX]
Set qgroup_rescan_running before queueing the work, so that we ensure
the rescan work is queued when we wait for it.

Fixes: 8d9eddad1946 ("Btrfs: fix qgroup rescan worker initialization")
Signed-off-by: Jeff Mahoney <jeffm@suse.com>
[ Change subject and cause analyse, use a smaller fix ]
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/qgroup.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 410b791f28a56..06d4c219742f2 100644
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
@@ -3276,7 +3277,6 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 		sizeof(fs_info->qgroup_rescan_progress));
 	fs_info->qgroup_rescan_progress.objectid = progress_objectid;
 	init_completion(&fs_info->qgroup_rescan_completion);
-	fs_info->qgroup_rescan_running = true;
 
 	spin_unlock(&fs_info->qgroup_lock);
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
@@ -3339,8 +3339,11 @@ btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info)
 
 	qgroup_rescan_zero_tracking(fs_info);
 
+	mutex_lock(&fs_info->qgroup_rescan_lock);
+	fs_info->qgroup_rescan_running = true;
 	btrfs_queue_work(fs_info->qgroup_rescan_workers,
 			 &fs_info->qgroup_rescan_work);
+	mutex_unlock(&fs_info->qgroup_rescan_lock);
 
 	return 0;
 }
@@ -3376,9 +3379,13 @@ int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,
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
2.20.1

