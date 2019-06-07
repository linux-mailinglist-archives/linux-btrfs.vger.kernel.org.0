Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7996387E0
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2019 12:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfFGKZ3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jun 2019 06:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbfFGKZ2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Jun 2019 06:25:28 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CB71208C3
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2019 10:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559903128;
        bh=oCFj11bkJbrjN1IqM1V41AqeC2ToUiynIE2xSn9ap44=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XzgXj+kP26odbkMD5G1n6QsQpaIWHNnjWI9yc4IAyo+D8a8Bytr0F7Ik0pJeNc4pu
         SHAdXzseXfTA3km5HaTGoz/+TNYcuE94+8pDnr6Yh1ZyVpSHgNY4p+lhJeyuZbb7Z8
         o6H0Uw5hHzSyijfdh3INq2nYvEGgVelINxOypJ5g=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3] Btrfs: fix data loss after inode eviction, renaming it, and fsync it
Date:   Fri,  7 Jun 2019 11:25:24 +0100
Message-Id: <20190607102524.32655-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190606110719.20855-1-fdmanana@kernel.org>
References: <20190606110719.20855-1-fdmanana@kernel.org>
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

Fix this by not updating last_sub_trans of an inode when we are logging
only that it exists and the inode was not yet logged since it was loaded
from disk (full_sync bit set), this is enough to make btrfs_inode_in_log()
return false for this scenario and make us log the inode. The logged_trans
of the inode is still always setsince that alone is used to track if names
need to be deleted as part of unlink operations.

Fixes: 257c62e1bce03e ("Btrfs: avoid tree log commit when there are no changes")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Fixed typo in comment "from memory" -> "to memory", and added missing
    "Fixes:" tag.
V3: Updated the logic to still set the inode's logged_trans always, and
    updated change log to justify it.

 fs/btrfs/tree-log.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 83755d3b96e3..40c839161596 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5407,9 +5407,19 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 		}
 	}
 
+	/*
+	 * Don't update last_log_commit if we logged that an inode exists after
+	 * it was loaded to memory (full_sync bit set).
+	 * This is to prevent data loss when we do a write to the inode, then
+	 * the inode gets evicted after all delalloc was flushed, then we log
+	 * it exists (due to a rename for example) and then fsync it. This last
+	 * fsync would do nothing (not logging the extents previously written).
+	 */
 	spin_lock(&inode->lock);
 	inode->logged_trans = trans->transid;
-	inode->last_log_commit = inode->last_sub_trans;
+	if (inode_only != LOG_INODE_EXISTS ||
+	    !test_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags))
+		inode->last_log_commit = inode->last_sub_trans;
 	spin_unlock(&inode->lock);
 out_unlock:
 	mutex_unlock(&inode->log_mutex);
-- 
2.11.0

