Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFCCBC532
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 11:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395398AbfIXJt7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 05:49:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504383AbfIXJt6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 05:49:58 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B29F920872
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 09:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569318597;
        bh=Zg1jxdfhYnSHtmNw7o42pr55qxTRACpuA8Z8Jb+JtD0=;
        h=From:To:Subject:Date:From;
        b=uewu4CN1lcSzIc+T5BVTVb14ciLWzttWsi44nVIMCykgAC0nNlt4WZvLy6C38Gf8a
         VXePxBVabKUPxM4qFZtSehPeCDRbwRot1PPG5sozcZdkFar2ayCWyKuIgmwB1VUR20
         Az94Myjo5tDnAlGwPSBOfApF/0pydGouB5jsMCw4=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix race setting up and completing qgroup rescan workers
Date:   Tue, 24 Sep 2019 10:49:54 +0100
Message-Id: <20190924094954.1304-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

There is a race between setting up a qgroup rescan worker and completing
a qgroup rescan worker that can lead to callers of the qgroup rescan wait
ioctl to either not wait for the rescan worker to complete or to hang
forever due to missing wake ups. The following diagram shows a sequence
of steps that illustrates the race.

        CPU 1                                                         CPU 2                                  CPU 3

 btrfs_ioctl_quota_rescan()
  btrfs_qgroup_rescan()
   qgroup_rescan_init()
    mutex_lock(&fs_info->qgroup_rescan_lock)
    spin_lock(&fs_info->qgroup_lock)

    fs_info->qgroup_flags |=
      BTRFS_QGROUP_STATUS_FLAG_RESCAN

    init_completion(
      &fs_info->qgroup_rescan_completion)

    fs_info->qgroup_rescan_running = true

    mutex_unlock(&fs_info->qgroup_rescan_lock)
    spin_unlock(&fs_info->qgroup_lock)

    btrfs_init_work()
     --> starts the worker

                                                        btrfs_qgroup_rescan_worker()
                                                         mutex_lock(&fs_info->qgroup_rescan_lock)

                                                         fs_info->qgroup_flags &=
                                                           ~BTRFS_QGROUP_STATUS_FLAG_RESCAN

                                                         mutex_unlock(&fs_info->qgroup_rescan_lock)

                                                         starts transaction, updates qgroup status
                                                         item, etc

                                                                                                           btrfs_ioctl_quota_rescan()
                                                                                                            btrfs_qgroup_rescan()
                                                                                                             qgroup_rescan_init()
                                                                                                              mutex_lock(&fs_info->qgroup_rescan_lock)
                                                                                                              spin_lock(&fs_info->qgroup_lock)

                                                                                                              fs_info->qgroup_flags |=
                                                                                                                BTRFS_QGROUP_STATUS_FLAG_RESCAN

                                                                                                              init_completion(
                                                                                                                &fs_info->qgroup_rescan_completion)

                                                                                                              fs_info->qgroup_rescan_running = true

                                                                                                              mutex_unlock(&fs_info->qgroup_rescan_lock)
                                                                                                              spin_unlock(&fs_info->qgroup_lock)

                                                                                                              btrfs_init_work()
                                                                                                               --> starts another worker

                                                         mutex_lock(&fs_info->qgroup_rescan_lock)

                                                         fs_info->qgroup_rescan_running = false

                                                         mutex_unlock(&fs_info->qgroup_rescan_lock)

							 complete_all(&fs_info->qgroup_rescan_completion)

Before the rescan worker started by the task at CPU 3 completes, if another
task calls btrfs_ioctl_quota_rescan(), it will get -EINPROGRESS because the
flag BTRFS_QGROUP_STATUS_FLAG_RESCAN is set at fs_info->qgroup_flags, which
is expected and correct behaviour.

However if other task calls btrfs_ioctl_quota_rescan_wait() before the
rescan worker started by the task at CPU 3 completes, it will return
immediately without waiting for the new rescan worker to complete,
because fs_info->qgroup_rescan_running is set to false by CPU 2.

This race is making test case btrfs/171 (from fstests) to fail often:

  btrfs/171 9s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/171.out.bad)
      --- tests/btrfs/171.out     2018-09-16 21:30:48.505104287 +0100
      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/171.out.bad      2019-09-19 02:01:36.938486039 +0100
      @@ -1,2 +1,3 @@
       QA output created by 171
      +ERROR: quota rescan failed: Operation now in progress
       Silence is golden
      ...
      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/171.out /home/fdmanana/git/hub/xfstests/results//btrfs/171.out.bad'  to see the entire diff)

That is because the test calls the btrfs-progs commands "qgroup quota
rescan -w", "qgroup assign" and "qgroup remove" in a sequence that makes
calls to the rescan start ioctl fail with -EINPROGRESS (note the "btrfs"
commands 'qgroup assign' and 'qgroup remove' often call the rescan start
ioctl after calling the qgroup assign ioctl, btrfs_ioctl_qgroup_assign()),
since previous waits didn't actually wait for a rescan worker to complete.

Another problem the race can cause is missing wake ups for waiters, since
the call to complete_all() happens outside a critical section and after
clearing the flag BTRFS_QGROUP_STATUS_FLAG_RESCAN. In the sequence diagram
above, if we have a waiter for the first rescan task (executed by CPU 2),
then fs_info->qgroup_rescan_completion.wait is not empty, and if after the
rescan worker clears BTRFS_QGROUP_STATUS_FLAG_RESCAN and before it calls
complete_all() against fs_info->qgroup_rescan_completion, the task at CPU 3
calls init_completion() against fs_info->qgroup_rescan_completion which
re-initilizes its wait queue to an empty queue, therefore causing the
rescan worker at CPU 2 to call complete_all() against an empty queue, never
waking up the task waiting for that rescan worker.

Fix this by clearing BTRFS_QGROUP_STATUS_FLAG_RESCAN and setting
fs_info->qgroup_rescan_running to false in the same critical section,
delimited by the mutex fs_info->qgroup_rescan_lock, as well as doing
the call to complete_all() in that same critical section. This gives
the protection needed to avoid rescan wait ioctl callers not waiting
for a running rescan worker and the lost wake ups problem, since
setting that rescan flag and boolean as well as initializing the wait
queue is done already in a critical section delimited by that mutex
(at qgroup_rescan_init()).

Fixes: 57254b6ebce4ce ("Btrfs: add ioctl to wait for qgroup rescan completion")
Fixes: d2c609b834d62f ("btrfs: properly track when rescan worker is running")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 8d3bd799ac7d..52701c1be109 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3166,9 +3166,6 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 	btrfs_free_path(path);
 
 	mutex_lock(&fs_info->qgroup_rescan_lock);
-	if (!btrfs_fs_closing(fs_info))
-		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
-
 	if (err > 0 &&
 	    fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT) {
 		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
@@ -3184,16 +3181,30 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 	trans = btrfs_start_transaction(fs_info->quota_root, 1);
 	if (IS_ERR(trans)) {
 		err = PTR_ERR(trans);
+		trans = NULL;
 		btrfs_err(fs_info,
 			  "fail to start transaction for status update: %d",
 			  err);
-		goto done;
 	}
-	ret = update_qgroup_status_item(trans);
-	if (ret < 0) {
-		err = ret;
-		btrfs_err(fs_info, "fail to update qgroup status: %d", err);
+
+	mutex_lock(&fs_info->qgroup_rescan_lock);
+	if (!btrfs_fs_closing(fs_info))
+		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
+	if (trans) {
+		ret = update_qgroup_status_item(trans);
+		if (ret < 0) {
+			err = ret;
+			btrfs_err(fs_info, "fail to update qgroup status: %d",
+				  err);
+		}
 	}
+	fs_info->qgroup_rescan_running = false;
+	complete_all(&fs_info->qgroup_rescan_completion);
+	mutex_unlock(&fs_info->qgroup_rescan_lock);
+
+	if (!trans)
+		return;
+
 	btrfs_end_transaction(trans);
 
 	if (btrfs_fs_closing(fs_info)) {
@@ -3204,12 +3215,6 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 	} else {
 		btrfs_err(fs_info, "qgroup scan failed with %d", err);
 	}
-
-done:
-	mutex_lock(&fs_info->qgroup_rescan_lock);
-	fs_info->qgroup_rescan_running = false;
-	mutex_unlock(&fs_info->qgroup_rescan_lock);
-	complete_all(&fs_info->qgroup_rescan_completion);
 }
 
 /*
-- 
2.11.0

