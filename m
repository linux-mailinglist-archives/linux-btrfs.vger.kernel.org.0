Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C91A3BD898
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jul 2021 16:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhGFOpJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jul 2021 10:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232130AbhGFOn5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Jul 2021 10:43:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26B5F61376
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jul 2021 14:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625582478;
        bh=NyVzdSaPWug223YEyxEX5fz2yp32X9SB7CZj290/pV0=;
        h=From:To:Subject:Date:From;
        b=UWdcTXwxrDsZKsWpztRJqGV57hYsRmYQIpnR5dHKmrvae24u3RVPLQddOp1K0GF3J
         SX/i91EmjYSqjdYdkWXpIhm3WaSM7KCXvbJ7KVN+YMgOF0oY/MBG35U4Tv8KoDk5QV
         gHUQdKoCcPwgx2rJwX0CwTZ7mIItVfkr0Xp6xdficqeqFUZe66hB8arW3Dtd2Ol1Cj
         AZpAQFDkhnY8RGyjrgy3CvV1MrmmIjmjVCdLwr8Ct+v+RtmzYTAoR+ENfjOg+bmKaO
         4E3bHn8IzA88vtMPJTHdNXQDI3CWQOLlw86/ym2w5wcQmLbgcHJFGX2dKBLyHohNyi
         Qn7pnHWv76FGg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix unpersisted i_size on fsync after expanding truncate
Date:   Tue,  6 Jul 2021 15:41:15 +0100
Message-Id: <6cceff8fdd4cf0293d28201c5602e011574d3b97.1625582327.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

If we have an inode that does not have the full sync flag set, was changed
in the current transaction, then it is logged while logging some other
inode (like its parent directory for example), its i_size is increased by
a truncate operation, the log is synced through an fsync of some other
inode and then finally we explicitly call fsync on our inode, the new
i_size is not persisted.

The following example shows how to trigger it, with comments explaining
how and why the issue happens:

  $ mkfs.btrfs -f /dev/sdc
  $ mount /dev/sdc /mnt

  $ touch /mnt/foo
  $ xfs_io -f -c "pwrite -S 0xab 0 1M" /mnt/bar

  $ sync

  # Fsync bar, this will be a noop since the file has not yet been
  # modified in the current transaction. The goal here is to clear
  # BTRFS_INODE_NEEDS_FULL_SYNC from the inode's runtime flags.
  $ xfs_io -c "fsync" /mnt/bar

  # Now rename both files, without changing their parent directory.
  $ mv /mnt/bar /mnt/bar2
  $ mv /mnt/foo /mnt/foo2

  # Increase the size of bar2 with a truncate operation.
  $ xfs_io -c "truncate 2M" /mnt/bar2

  # Now fsync foo2, this results in logging its parent inode (the root
  # directory), and logging the parent results in logging the inode of
  # file bar2 (its inode item and the new name). The inode of file bar2
  # is logged with an i_size of 0 bytes since it's logged in
  # LOG_INODE_EXISTS mode, meaning we are only logging its names (and
  # xattrs if it had any) and the i_size of the inode will not be changed
  # when the log is replayed.
  $ xfs_io -c "fsync" /mnt/foo2

  # Now explicitly fsync bar2. This resulted in doing nothing, not
  # logging the inode with the new i_size of 2M and the hole from file
  # offset 1M to 2M. Because the inode did not have the flag
  # BTRFS_INODE_NEEDS_FULL_SYNC set, when it was logged through the
  # fsync of file foo2, its last_log_commit field was updated,
  # resulting in this explicit of file bar2 not doing anything.
  $ xfs_io -c "fsync" /mnt/bar2

  # File bar2 content and size before a power failure.
  $ od -A d -t x1 /mnt/bar2
  0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
  *
  1048576 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  *
  2097152

  <power failure>

  # Mount the filesystem to replay the log.
  $ mount /dev/sdc /mnt

  # Read the file again, should have the same content and size as before
  # the power failure happened, but it doesn't, i_size is still at 1M.
  $ od -A d -t x1 /mnt/bar2
  0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
  *
  1048576

This started to happen after commit 209ecbb8585bf6 ("btrfs: remove stale
comment and logic from btrfs_inode_in_log()"), since btrfs_inode_in_log()
no longer checks if the inode's list of modified extents is not empty.
However, checking that list is not the right way to address this case
and the check was added long time ago in commit 125c4cf9f37c98
("Btrfs: set inode's logged_trans/last_log_commit after ranged fsync")
for a different purpose, to address consecutive ranged fsyncs.

The reason that checking for the list emptiness makes this test pass is
because during an expanding truncate we create an extent map to represent
a hole from the old i_size to the new i_size, and add that extent map to
the list of modified extents in the inode. However if we are low on
available memory and we can not allocate a new extent map, then we don't
treat it as an error and just set the full sync flag on the inode, so that
the next fsync does not rely on the list of modified extents - so checking
for the emptiness of the list to decide if the inode needs to be logged is
not reliable, and results in not logging the inode if it was not possible
to allocate the extent map for the hole.

Fix this by ensuring that if we are only logging that an inode exists
(inode item, names/references and xattrs), we don't update the inode's
last_log_commit even if it does not have the full sync runtime flag set.

A test case for fstests follows soon.

CC: stable@vger.kernel.org # 5.13+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index cab451d19547..8471837e7eb9 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5526,16 +5526,29 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 		spin_lock(&inode->lock);
 		inode->logged_trans = trans->transid;
 		/*
-		 * Don't update last_log_commit if we logged that an inode exists
-		 * after it was loaded to memory (full_sync bit set).
-		 * This is to prevent data loss when we do a write to the inode,
-		 * then the inode gets evicted after all delalloc was flushed,
-		 * then we log it exists (due to a rename for example) and then
-		 * fsync it. This last fsync would do nothing (not logging the
-		 * extents previously written).
+		 * Don't update last_log_commit if we logged that an inode exists.
+		 * We do this for two reasons:
+		 *
+		 * 1) We might have had buffered writes to this inode that were
+		 *    flushed and had their ordered extents completed in this
+		 *    transaction, but we did not previously log the inode with
+		 *    LOG_INODE_ALL. Later the inode was evicted and after that
+		 *    it was loaded again and this LOG_INODE_EXISTS log operation
+		 *    happened. We must make sure that if an explicit fsync against
+		 *    the inode is performed later, it logs the new extents, an
+		 *    updated inode item, etc, and syncs the log. The same logic
+		 *    applies to direct IO writes instead of buffered writes.
+		 *
+		 * 2) When we log the inode with LOG_INODE_EXISTS, its inode item
+		 *    is logged with an i_size of 0 or whatever value was logged
+		 *    before. If later the i_size of the inode is increased by a
+		 *    truncate operation, the log is synced through an fsync of
+		 *    some other inode and then finally an explicit fsync against
+		 *    this inode is made, we must make sure this fsync logs the
+		 *    inode with the new i_size, the hole between old i_size and
+		 *    the new i_size, and syncs the log.
 		 */
-		if (inode_only != LOG_INODE_EXISTS ||
-		    !test_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags))
+		if (inode_only != LOG_INODE_EXISTS)
 			inode->last_log_commit = inode->last_sub_trans;
 		spin_unlock(&inode->lock);
 	}
-- 
2.30.2

