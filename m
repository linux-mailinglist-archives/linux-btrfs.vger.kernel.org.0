Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66C254B79C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 14:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfFSMFo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 08:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfFSMFo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 08:05:44 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EF41206E0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 12:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560945943;
        bh=U7jeFA5ldBynT3NcOMPcDnEPvvIMh6iX8LOhbBvYl3c=;
        h=From:To:Subject:Date:From;
        b=fX43+k3n8l77BRJsoDtFYq4iMiW4YvQ57mb1V+RIoCmPwsSVPqVgja2tIp6akNw53
         pNG6TI7jkaesnH6RiC9FjMSsmPQa3ijxVWeWEfbAUWHoq21QYTJXAMohgVwuoKgEfR
         P/3OAcCx+KfvIIgwjIOou5dsC3kTUtcEcsz4ps3k=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix fsync not persisting dentry deletions due to inode evictions
Date:   Wed, 19 Jun 2019 13:05:39 +0100
Message-Id: <20190619120539.9775-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

In order to avoid searches on a log tree when unlinking an inode, we check
if the inode being unlinked was logged in the current transaction, as well
as the inode of its parent directory. When any of the inodes are logged,
we proceed to delete directory items and inode reference items from the
log, to ensure that if a subsequent fsync of only the inode being unlinked
or only of the parent directory when the other is not fsync'ed as well,
does not result in the entry still existing after a power failure.

That check however is not reliable when one of the inodes involved (the
one being unlinked or its parent directory's inode) is evicted, since the
logged_trans field is transient, that is, it is not stored on disk, so it
is lost when the inode is evicted and loaded into memory again (which is
set to zero on load). As a consequence the checks currently being done by
btrfs_del_dir_entries_in_log() and btrfs_del_inode_ref_in_log() always
return true if the inode was evicted before, regardless of the inode
having been logged or not before (and in the current transaction), this
results in the dentry being unlinked still existing after a log replay
if after the unlink operation only one of the inodes involved is fsync'ed.

Example:

  $ mkfs.btrfs -f /dev/sdb
  $ mount /dev/sdb /mnt

  $ mkdir /mnt/dir
  $ touch /mnt/dir/foo
  $ xfs_io -c fsync /mnt/dir/foo

  # Keep an open file descriptor on our directory while we evict inodes.
  # We just want to evict the file's inode, the directory's inode must not
  # be evicted.
  $ ( cd /mnt/dir; while true; do :; done ) &
  $ pid=$!

  # Wait a bit to give time to background process to chdir to our test
  # directory.
  $ sleep 0.5

  # Trigger eviction of the file's inode.
  $ echo 2 > /proc/sys/vm/drop_caches

  # Unlink our file and fsync the parent directory. After a power failure
  # we don't expect to see the file anymore, since we fsync'ed the parent
  # directory.
  $ rm -f $SCRATCH_MNT/dir/foo
  $ xfs_io -c fsync /mnt/dir

  <power failure>

  $ mount /dev/sdb /mnt
  $ ls /mnt/dir
  foo
  $
   --> file still there, unlink not persisted despite explicit fsync on dir

Fix this by checking if the inode has the full_sync bit set in its runtime
flags as well, since that bit is set everytime an inode is loaded from
disk, or for other less common cases such as after a shrinking truncate
or failure to allocate extent maps for holes, and gets cleared after the
first fsync. Also consider the inode as possibly logged only if it was
last modified in the current transaction (besides having the full_fsync
flag set).

Fixes: 3a5f1d458ad161 ("Btrfs: Optimize btree walking while logging inodes")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 4a04659fded7..6c8297bcfeb7 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3323,6 +3323,30 @@ int btrfs_free_log_root_tree(struct btrfs_trans_handle *trans,
 }
 
 /*
+ * Check if an inode was logged in the current transaction. We can't always rely
+ * on an inode's logged_trans value, because it's an in-memory only field and
+ * therefore not persisted. This means that its value is lost if the inode gets
+ * evicted and loaded again from disk (in which case it has a value of 0, and
+ * certainly it is smaller then any possible transaction ID), when that happens
+ * the full_sync flag is set in the inode's runtime flags, so on that case we
+ * assume eviction happened and ignore the logged_trans value, assuming the
+ * worst case, that the inode was logged before in the current transaction.
+ */
+static bool inode_logged(struct btrfs_trans_handle *trans,
+			 struct btrfs_inode *inode)
+{
+	if (inode->logged_trans == trans->transid)
+		return true;
+
+	if (inode->last_trans == trans->transid &&
+	    test_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags) &&
+	    !test_bit(BTRFS_FS_LOG_RECOVERING, &trans->fs_info->flags))
+		return true;
+
+	return false;
+}
+
+/*
  * If both a file and directory are logged, and unlinks or renames are
  * mixed in, we have a few interesting corners:
  *
@@ -3356,7 +3380,7 @@ int btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 	int bytes_del = 0;
 	u64 dir_ino = btrfs_ino(dir);
 
-	if (dir->logged_trans < trans->transid)
+	if (!inode_logged(trans, dir))
 		return 0;
 
 	ret = join_running_log_trans(root);
@@ -3460,7 +3484,7 @@ int btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
 	u64 index;
 	int ret;
 
-	if (inode->logged_trans < trans->transid)
+	if (!inode_logged(trans, inode))
 		return 0;
 
 	ret = join_running_log_trans(root);
-- 
2.11.0

