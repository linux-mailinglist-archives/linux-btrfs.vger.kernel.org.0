Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA543FC9C0
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 16:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbhHaObn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 10:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237420AbhHaObm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 10:31:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CC4E600AA
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 14:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630420246;
        bh=A8Qc5bvzlI0RbXx6x/Ev0DmuSuhmhwUEoixG3ASCUjg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Kijh6oMkSEf3DVzbv0AtE0eYx/XynwMQmDcuR4jWygMlRvv7A4iRbEWVp9pUmJWL1
         7lFi0uQIV4aKfHGDOTtGN15Mpcrupu94IiO0JDbanRslNRwGHn8rug64LtJ1TFs0/r
         QYVkKxHHfZuG2mI6lyOo8Kwj9H9+Dlo0CSQZJoOyahiB6hCEZ4V7xExBJNmY9bVpbe
         ruFtbAULwPA9DO8Lm0mpkX6iv53kPlHSHYXou22r6OAsotUGwqmHzIqbm9AVYH5bjp
         EXfMJ2AdncVBvMhS811JHYxvx4cHHcLWfoiODVhG4zTEgQZmqZEWPxX3IZx9hkNTSB
         wzCGU8kaq6dhA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/10] btrfs: always update the logged transaction when logging new names
Date:   Tue, 31 Aug 2021 15:30:34 +0100
Message-Id: <67597c5a0f0ca1b0605c565548091fc065d7c93b.1630419897.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1630419897.git.fdmanana@suse.com>
References: <cover.1630419897.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When we are logging a new name for an inode, due to a link or rename
operation, if the inode has ancestor inodes that are new, created in the
current transaction, we need to log that these inodes exist. To ensure
that a subsequent explicit fsync on one of these ancestor inodes does
sync the log, we don't set the logged_trans field of these inodes.
This was done in commit 75b463d2b47aef ("btrfs: do not commit logs and
transactions during link and rename operations"), to avoid syncing a
log after a rename or link operation.

In order to allow for future changes to do some optimizations, change
this behaviour to always update the logged_trans of any logged inode
and don't update the last_log_commit of the inode if we are logging
that it exists. This accomplishes that same objective with simpler
logic, allowing for some optimizations in the next patches.

So just do that simplification.

This patch is part of a patch set comprised of the following patches:

  btrfs: check if a log tree exists at inode_logged()
  btrfs: remove no longer needed checks for NULL log context
  btrfs: do not log new dentries when logging that a new name exists
  btrfs: always update the logged transaction when logging new names
  btrfs: avoid expensive search when dropping inode items from log
  btrfs: add helper to truncate inode items when logging inode
  btrfs: avoid expensive search when truncating inode items from the log
  btrfs: avoid search for logged i_size when logging inode if possible
  btrfs: avoid attempt to drop extents when logging inode for the first time
  btrfs: do not commit delayed inode when logging a file in full sync mode

This is patch 4/10 and test results are listed in the change log of the
last patch in the set.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 73 +++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 27b0c908b10c..9ca2d99b293b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5552,47 +5552,42 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 		}
 	}
 
+	spin_lock(&inode->lock);
+	inode->logged_trans = trans->transid;
 	/*
-	 * If we are logging that an ancestor inode exists as part of logging a
-	 * new name from a link or rename operation, don't mark the inode as
-	 * logged - otherwise if an explicit fsync is made against an ancestor,
-	 * the fsync considers the inode in the log and doesn't sync the log,
-	 * resulting in the ancestor missing after a power failure unless the
-	 * log was synced as part of an fsync against any other unrelated inode.
-	 * So keep it simple for this case and just don't flag the ancestors as
-	 * logged.
+	 * Don't update last_log_commit if we logged that an inode exists.
+	 * We do this for three reasons:
+	 *
+	 * 1) We might have had buffered writes to this inode that were
+	 *    flushed and had their ordered extents completed in this
+	 *    transaction, but we did not previously log the inode with
+	 *    LOG_INODE_ALL. Later the inode was evicted and after that
+	 *    it was loaded again and this LOG_INODE_EXISTS log operation
+	 *    happened. We must make sure that if an explicit fsync against
+	 *    the inode is performed later, it logs the new extents, an
+	 *    updated inode item, etc, and syncs the log. The same logic
+	 *    applies to direct IO writes instead of buffered writes.
+	 *
+	 * 2) When we log the inode with LOG_INODE_EXISTS, its inode item
+	 *    is logged with an i_size of 0 or whatever value was logged
+	 *    before. If later the i_size of the inode is increased by a
+	 *    truncate operation, the log is synced through an fsync of
+	 *    some other inode and then finally an explicit fsync against
+	 *    this inode is made, we must make sure this fsync logs the
+	 *    inode with the new i_size, the hole between old i_size and
+	 *    the new i_size, and syncs the log.
+	 *
+	 * 3) If we are logging that an ancestor inode exists as part of
+	 *    logging a new name from a link or rename operation, don't update
+	 *    its last_log_commit - otherwise if an explicit fsync is made
+	 *    against an ancestor, the fsync considers the inode in the log
+	 *    and doesn't sync the log, resulting in the ancestor missing after
+	 *    a power failure unless the log was synced as part of an fsync
+	 *    against any other unrelated inode.
 	 */
-	if (!(S_ISDIR(inode->vfs_inode.i_mode) && ctx->logging_new_name &&
-	      &inode->vfs_inode != ctx->inode)) {
-		spin_lock(&inode->lock);
-		inode->logged_trans = trans->transid;
-		/*
-		 * Don't update last_log_commit if we logged that an inode exists.
-		 * We do this for two reasons:
-		 *
-		 * 1) We might have had buffered writes to this inode that were
-		 *    flushed and had their ordered extents completed in this
-		 *    transaction, but we did not previously log the inode with
-		 *    LOG_INODE_ALL. Later the inode was evicted and after that
-		 *    it was loaded again and this LOG_INODE_EXISTS log operation
-		 *    happened. We must make sure that if an explicit fsync against
-		 *    the inode is performed later, it logs the new extents, an
-		 *    updated inode item, etc, and syncs the log. The same logic
-		 *    applies to direct IO writes instead of buffered writes.
-		 *
-		 * 2) When we log the inode with LOG_INODE_EXISTS, its inode item
-		 *    is logged with an i_size of 0 or whatever value was logged
-		 *    before. If later the i_size of the inode is increased by a
-		 *    truncate operation, the log is synced through an fsync of
-		 *    some other inode and then finally an explicit fsync against
-		 *    this inode is made, we must make sure this fsync logs the
-		 *    inode with the new i_size, the hole between old i_size and
-		 *    the new i_size, and syncs the log.
-		 */
-		if (inode_only != LOG_INODE_EXISTS)
-			inode->last_log_commit = inode->last_sub_trans;
-		spin_unlock(&inode->lock);
-	}
+	if (inode_only != LOG_INODE_EXISTS)
+		inode->last_log_commit = inode->last_sub_trans;
+	spin_unlock(&inode->lock);
 out_unlock:
 	mutex_unlock(&inode->log_mutex);
 
-- 
2.28.0

