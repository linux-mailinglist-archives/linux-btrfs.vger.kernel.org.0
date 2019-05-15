Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52EE81F713
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2019 17:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfEOPDV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 May 2019 11:03:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfEOPDV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 May 2019 11:03:21 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B98A920818
        for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2019 15:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557932600;
        bh=8ulhlo6PUm8u0/AjlXHAfUaRz3gT1vKq1WLSncQRGwM=;
        h=From:To:Subject:Date:From;
        b=X1kkk1cF37S4tefjsfKAcBCr9Et7b5zscpvkrfLwTap7qNSg2/hhfplJ0tfYTi+uO
         kpGfBKmpOJoU9bPsQ+jBFjTkFUQQhcIgtTmpZjGP4k1a/vPioeyrmkDr12aFixRawR
         FP5Gup0zJM6FWFF4MTx5zesgXOX2yTsrU1cMqc9U=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] Btrfs: fix race updating log root item during fsync
Date:   Wed, 15 May 2019 16:03:17 +0100
Message-Id: <20190515150317.1833-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When syncing the log, the final phase of a fsync operation, we need to
either create a log root's item or update the existing item in the log
tree of log roots, and that depends on the current value of the log
root's log_transid - if it's 1 we need to create the log root item,
otherwise it must exist already and we update it. Since there is no
synchronization between updating the log_transid and checking it for
deciding whether the log root's item needs to be created or updated, we
end up with a tiny race window that results in attempts to update the
item to fail because the item was not yet created:

              CPU 1                                    CPU 2

  btrfs_sync_log()

    lock root->log_mutex

    set log root's log_transid to 1

    unlock root->log_mutex

                                               btrfs_sync_log()

                                                 lock root->log_mutex

                                                 sets log root's
                                                 log_transid to 2

                                                 unlock root->log_mutex

    update_log_root()

      sees log root's log_transid
      with a value of 2

        calls btrfs_update_root(),
        which fails with -EUCLEAN
        and causes transaction abort

Until recently the race lead to a BUG_ON at btrfs_update_root(), but after
the recent commit 7ac1e464c4d47 ("btrfs: Don't panic when we can't find a
root key") we just abort the current transaction.

A sample trace of the BUG_ON() on a SLE12 kernel:

  ------------[ cut here ]------------
  kernel BUG at ../fs/btrfs/root-tree.c:157!
  Oops: Exception in kernel mode, sig: 5 [#1]
  SMP NR_CPUS=2048 NUMA pSeries
  (...)
  Supported: Yes, External
  CPU: 78 PID: 76303 Comm: rtas_errd Tainted: G                 X 4.4.156-94.57-default #1
  task: c00000ffa906d010 ti: c00000ff42b08000 task.ti: c00000ff42b08000
  NIP: d000000036ae5cdc LR: d000000036ae5cd8 CTR: 0000000000000000
  REGS: c00000ff42b0b860 TRAP: 0700   Tainted: G                 X  (4.4.156-94.57-default)
  MSR: 8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 22444484  XER: 20000000
  CFAR: d000000036aba66c SOFTE: 1
  GPR00: d000000036ae5cd8 c00000ff42b0bae0 d000000036bda220 0000000000000054
  GPR04: 0000000000000001 0000000000000000 c00007ffff8d37c8 0000000000000000
  GPR08: c000000000e19c00 0000000000000000 0000000000000000 3736343438312079
  GPR12: 3930373337303434 c000000007a3a800 00000000007fffff 0000000000000023
  GPR16: c00000ffa9d26028 c00000ffa9d261f8 0000000000000010 c00000ffa9d2ab28
  GPR20: c00000ff42b0bc48 0000000000000001 c00000ff9f0d9888 0000000000000001
  GPR24: c00000ffa9d26000 c00000ffa9d261e8 c00000ffa9d2a800 c00000ff9f0d9888
  GPR28: c00000ffa9d26028 c00000ffa9d2aa98 0000000000000001 c00000ffa98f5b20
  NIP [d000000036ae5cdc] btrfs_update_root+0x25c/0x4e0 [btrfs]
  LR [d000000036ae5cd8] btrfs_update_root+0x258/0x4e0 [btrfs]
  Call Trace:
  [c00000ff42b0bae0] [d000000036ae5cd8] btrfs_update_root+0x258/0x4e0 [btrfs] (unreliable)
  [c00000ff42b0bba0] [d000000036b53610] btrfs_sync_log+0x2d0/0xc60 [btrfs]
  [c00000ff42b0bce0] [d000000036b1785c] btrfs_sync_file+0x44c/0x4e0 [btrfs]
  [c00000ff42b0bd80] [c00000000032e300] vfs_fsync_range+0x70/0x120
  [c00000ff42b0bdd0] [c00000000032e44c] do_fsync+0x5c/0xb0
  [c00000ff42b0be10] [c00000000032e8dc] SyS_fdatasync+0x2c/0x40
  [c00000ff42b0be30] [c000000000009488] system_call+0x3c/0x100
  Instruction dump:
  7f43d378 4bffebb9 60000000 88d90008 3d220000 e8b90000 3b390009 e87a01f0
  e8898e08 e8f90000 4bfd48e5 60000000 <0fe00000> e95b0060 39200004 394a0ea0
  ---[ end trace 8f2dc8f919cabab8 ]---

So fix this by doing the check of log_transid and updating or creating the
log root's item while holding the root's log_mutex.

Fixes: 7237f1833601d ("Btrfs: fix tree logs parallel sync")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 7d13533a9620..6391df35ca48 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3096,6 +3096,12 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 	log->log_transid = root->log_transid;
 	root->log_start_pid = 0;
 	/*
+	 * Update or create log root item under the root's log_mutex to prevent
+	 * races with concurrent log syncs that can lead to failure to update
+	 * log root item because it was not created yet.
+	 */
+	ret = update_log_root(trans, log);
+	/*
 	 * IO has been started, blocks of the log tree have WRITTEN flag set
 	 * in their headers. new modifications of the log will be written to
 	 * new positions. so it's safe to allow log writers to go in.
@@ -3114,8 +3120,6 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 
 	mutex_unlock(&log_root_tree->log_mutex);
 
-	ret = update_log_root(trans, log);
-
 	mutex_lock(&log_root_tree->log_mutex);
 	if (atomic_dec_and_test(&log_root_tree->log_writers)) {
 		/* atomic_dec_and_test implies a barrier */
-- 
2.11.0

