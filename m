Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7F873727A
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2019 13:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfFFLHZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jun 2019 07:07:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbfFFLHY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Jun 2019 07:07:24 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4F3120657
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2019 11:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559819243;
        bh=1yDwYsXR+j7BIUD8zF8k8D5lghmqIVTY5/DF8HKXt/M=;
        h=From:To:Subject:Date:From;
        b=XydEVms13GcJAjnAYwritB36eEHjA6REzAERygE/O2mHtX4jtRq7AnMAZv6a+58Os
         iV6jjcI50F8TawkT0FVUgb7rMUzrHg7JcVhRH48x4YuPuaUEBQKVlroNWuRIIi0hJO
         0QIqGVZt31lpHiQvQWP68RZsRkpPSLF8Ci0ZIXSQ=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix data loss after inode eviction, renaming it, and fsync it
Date:   Thu,  6 Jun 2019 12:07:19 +0100
Message-Id: <20190606110719.20855-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When we log an inode, regardless of logging it completely or only that it
exists, we always update it as logged (logged_trans and last_log_commit
fields of the inode are updated). This is generally fine and avoids future
attempts to log it from having to do repeated work that brings no value.

However, if we write data to a file, then evict its inode after all the
dealloc was flushed (and ordered extents completed), rename the file and
fsync it, we end up not logging the new extents, since the rename may
result in logging that the inode exists in case the parent directory was
logged before. The following reproducer shows and explains how this can
happen:

  $ mkfs.btrfs -f /dev/sdb
  $ mount /dev/sdb /mnt

  $ mkdir /mnt/dir
  $ touch /mnt/dir/foo
  $ touch /mnt/dir/bar

  # Do a direct IO write instead of a buffered write because with a
  # buffered write we would need to make sure dealloc gets flushed and
  # complete before we do the inode eviction later, and we can not do that
  # from user space with call to things such as sync(2) since that results
  # in a transaction commit as well.
  $ xfs_io -d -c "pwrite -S 0xd3 0 4K" /mnt/dir/bar

  # Keep the directory dir in use while we evict inodes. We want our file
  # bar's inode to be evicted but we don't want our directory's inode to
  # be evicted (if it were evicted too, we would not be able to reproduce
  # the issue since the first fsync below, of file foo, would result in a
  # transaction commit.
  $ ( cd /mnt/dir; while true; do :; done ) &
  $ pid=$!

  # Wait a bit to give time for the background process to chdir.
  $ sleep 0.1

  # Evict all inodes, except the inode for the directory dir because it is
  # currently in use by our background process.
  $ echo 2 > /proc/sys/vm/drop_caches

  # fsync file foo, which ends up persisting information about the parent
  # directory because it is a new inode.
  $ xfs_io -c fsync /mnt/dir/foo

  # Rename bar, this results in logging that this inode exists (inode item,
  # names, xattrs) because the parent directory is in the log.
  $ mv /mnt/dir/bar /mnt/dir/baz

  # Now fsync baz, which ends up doing absolutely nothing because of the
  # rename operation which logged that the inode exists only.
  $ xfs_io -c fsync /mnt/dir/baz

  <power failure>

  $ mount /dev/sdb /mnt
  $ od -t x1 -A d /mnt/dir/baz
  0000000

    --> Empty file, data we wrote is missing.

Fix this by not updating the logged_trans and last_sub_trans of an inode
when we are logging only that it exists and the inode was not yet logged
since it was loaded from disk (full_sync bit set).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 83755d3b96e3..8db230935098 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5407,10 +5407,21 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	spin_lock(&inode->lock);
-	inode->logged_trans = trans->transid;
-	inode->last_log_commit = inode->last_sub_trans;
-	spin_unlock(&inode->lock);
+	/*
+	 * Don't update logged_trans and last_log_commit if we logged that an
+	 * inode exists after it was loaded from memory (full_sync bit set).
+	 * This is to prevent data loss when we do a write to the inode, then
+	 * the inode gets evicted after all delalloc was flushed, then we log
+	 * it exists (due to a rename for example) and then fsync it. This last
+	 * fsync would do nothing (not logging the extents previously written).
+	 */
+	if (inode_only != LOG_INODE_EXISTS ||
+	    !test_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags)) {
+		spin_lock(&inode->lock);
+		inode->logged_trans = trans->transid;
+		inode->last_log_commit = inode->last_sub_trans;
+		spin_unlock(&inode->lock);
+	}
 out_unlock:
 	mutex_unlock(&inode->log_mutex);
 
-- 
2.11.0

