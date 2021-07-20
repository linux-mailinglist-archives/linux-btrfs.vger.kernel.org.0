Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0823CFDBC
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 17:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242051AbhGTO7N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 10:59:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238576AbhGTOXJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 10:23:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D653E61244
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jul 2021 15:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626793427;
        bh=qJYMnIHJFv6el45auyHCESyrnRmfKhTw4Iy1GLKXXQk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NpxrgmHFzAPu/WDWQEkU7QaC1FtufzJ/wiVwmrJ83eltwW6tbOg5ISiGRuTD7fOJ1
         WuS4UQkYeVMfFYKjbZMcwKo5v4P4R8apqE/SWr3J4/yQvzQLU2/B14YUrGHB9NFhMY
         y+Yte/raBghrVPqYP66GDfPQGq3wKTgVsQIzBcT0Fcl6sCTlc5i2h8/4LgQ1lydu6j
         tlYCB1PGAPF8+9YJqlihcab+/sIHoX4Xw+O+ZjA5WhDL8C9GAmFqeHR3B1jNZzKpB5
         aFja8yoiMYeXqWPKIJKAfnrOsc+Ty33upJ5mXJKt5/NGHa2dvizMxPl9jaIql6ddwW
         bqpf3DeXuonSA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: avoid unnecessary log mutex contention when syncing log
Date:   Tue, 20 Jul 2021 16:03:41 +0100
Message-Id: <1c622321ea689e2b75b7f6b151631cb584ac9ca7.1626791500.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1626791500.git.fdmanana@suse.com>
References: <cover.1626791500.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When syncing the log we acquire the root's log mutex just to update the
root's last_log_commit. This is unnecessary because:

1) At this point there can only be one task updating this value, which is
   the task committing the current log transaction. Any task that enters
   btrfs_sync_log() has to wait for the previous log transaction to commit
   and wait for the current log transaction to commit if someone else
   already started it (in this case it never reaches to the point of
   updating last_log_commit, as that is done by the comitting task);

2) All readers of the root's last_log_commit don't acquire the root's
   log mutex. This is to avoid blocking the readers, potentially for too
   long and because getting a stale value of last_log_commit does not
   cause any functional problem, in the worst case getting a stale value
   results in logging an inode unnecessarily. Plus it's actually very
   rare to get a stale value that results in unnecessarily logging the
   inode.

So in order to avoid unnecessary contention on the root's log mutex,
which is used for several different purposes, like starting/joining a
log transaction and starting writeback of a log transaction, stop
acquiring the log mutex for updating the root's last_log_commit.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 9fd0348be7f5..90fb5a2fc60b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3328,10 +3328,16 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 		goto out_wake_log_root;
 	}
 
-	mutex_lock(&root->log_mutex);
-	if (root->last_log_commit < log_transid)
-		root->last_log_commit = log_transid;
-	mutex_unlock(&root->log_mutex);
+	/*
+	 * We know there can only be one task here, since we have not yet set
+	 * root->log_commit[index1] to 0 and any task attempting to sync the
+	 * log must wait for the previous log transaction to commit if it's
+	 * still in progress or wait for the current log transaction commit if
+	 * someone else already started it. We use <= and not < because the
+	 * first log transaction has an ID of 0.
+	 */
+	ASSERT(root->last_log_commit <= log_transid);
+	root->last_log_commit = log_transid;
 
 out_wake_log_root:
 	mutex_lock(&log_root_tree->log_mutex);
-- 
2.30.2

