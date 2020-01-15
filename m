Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09AC713C289
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 14:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgAONVk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 08:21:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbgAONVk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 08:21:40 -0500
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB84220728
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 13:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579094499;
        bh=GaU5J+P31LqOATgSA4E2Icoa97uyXnAbQqV5QiUbaJQ=;
        h=From:To:Subject:Date:From;
        b=AqaCBYJz477TvJY9GusGWAYs8p1q2N4e5To8ZtvghDVUSbnq99pZ9Pd9Thle0sW++
         4im5F6pj0ABWJnWHrZMXbW/0s9zzc5DQknaxzFM28H3taszhAMfPwed4lSNGT/kR80
         +fSupxjMzyhv7yzi9I1TADVzzSWCCHSSW7Wt0Pv4=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix infinite loop during fsync after rename operations
Date:   Wed, 15 Jan 2020 13:21:35 +0000
Message-Id: <20200115132135.23994-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Recently fsstress (from fstests) sporadically started to trigger an
infinite loop during fsync operations. This turned out to be because
support for the rename exchange and whiteout operations was added to
fsstress in fstests. These operations, unlike any others in fsstress,
cause file names to be reused, whence triggering this issue. However
it's not necessary to use rename exchange and rename whiteout operations
trigger this issue, simple rename operations and file creations are
enough to trigger the issue.

The issue boils down to when we are logging inodes that conflict (that
had the name of any inode we need to log during the fsync operation),
we keep logging them even if they were already logged before, and after
that we check if there's any other inode that conflicts with them and
then add it again to the list of inodes to log. Skipping already logged
inodes fixes the issue.

Consider the following example:

  $ mkfs.btrfs -f /dev/sdb
  $ mount /dev/sdb /mnt

  $ mkdir /mnt/testdir                           # inode 257

  $ touch /mnt/testdir/zz                        # inode 258
  $ ln /mnt/testdir/zz /mnt/testdir/zz_link

  $ touch /mnt/testdir/a                         # inode 259

  $ sync

  # The following 3 renames achieve the same result as a rename exchange
  # operation (<rename_exchange> /mnt/testdir/zz_link to /mnt/testdir/a).

  $ mv /mnt/testdir/a /mnt/testdir/a/tmp
  $ mv /mnt/testdir/zz_link /mnt/testdir/a
  $ mv /mnt/testdir/a/tmp /mnt/testdir/zz_link

  # The following rename and file creation give the same result as a
  # rename whiteout operation (<rename_whiteout> zz to a2).

  $ mv /mnt/testdir/zz /mnt/testdir/a2
  $ touch /mnt/testdir/zz                        # inode 260

  $ xfs_io -c fsync /mnt/testdir/zz
    --> results in the infinite loop

The following steps happen:

1) When logging inode 260, we find that its reference named "zz" was
   used by inode 258 in the previous transaction (through the commit
   root), so inode 258 is added to the list of conflicting indoes that
   need to be logged;

2) After logging inode 258, we find that its reference named "a" was
   used by inode 259 in the previous transaction, and therefore we add
   inode 259 to the list of conflicting inodes to be logged;

3) After logging inode 259, we find that its reference named "zz_link"
   was used by inode 258 in the previous transaction - we add inode 258
   to the list of conflicting inodes to log, again - we had already
   logged it before at step 3. After logging it again, we find again
   that inode 259 conflicts with him, and we add again 259 to the list,
   etc - we end up repeating all the previous steps.

So fix this by skipping logging of conflicting inodes that were already
logged.

Fixes: 6b5fc433a7ad67 ("Btrfs: fix fsync after succession of renames of different files")
CC: stable@vger.kernel.org
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index f674013f4771..2b23e557c457 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4836,6 +4836,50 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 			continue;
 		}
 		/*
+		 * If the inode was already logged skip it - otherwise we can
+		 * hit an infinite loop. Example:
+		 *
+		 * From the commit root (previous transaction) we have the
+		 * following inodes:
+		 *
+		 * inode 257 a directory
+		 * inode 258 with references "zz" and "zz_link" on inode 257
+		 * inode 259 with reference "a" on inode 257
+		 *
+		 * And in the current (uncommitted) transaction we have:
+		 *
+		 * inode 257 a directory, unchanged
+		 * inode 258 with references "a" and "a2" on inode 257
+		 * inode 259 with reference "zz_link" on inode 257
+		 * inode 261 with reference "zz" on inode 257
+		 *
+		 * When logging inode 261 the following infinite loop could
+		 * happen if we don't skip already logged inodes:
+		 *
+		 * - we detect inode 258 as a conflicting inode, with inode 261
+		 *   on reference "zz", and log it;
+		 *
+		 * - we detect inode 259 as a conflicting inode, with inode 258
+		 *   on reference "a", and log it;
+		 *
+		 * - we detect inode 258 as a conflicting inode, with inode 259
+		 *   on reference "zz_link", and log it - again! After this we
+		 *   repeat the above steps forever.
+		 */
+		spin_lock(&BTRFS_I(inode)->lock);
+		/*
+		 * Check the inode's logged_trans only instead of
+		 * btrfs_inode_in_log(). This is because the last_log_commit of
+		 * the inode is not updated when we only log that it exists and
+		 * and it has the full sync bit set (see btrfs_log_inode()).
+		 */
+		if (BTRFS_I(inode)->logged_trans == trans->transid) {
+			spin_unlock(&BTRFS_I(inode)->lock);
+			btrfs_add_delayed_iput(inode);
+			continue;
+		}
+		spin_unlock(&BTRFS_I(inode)->lock);
+		/*
 		 * We are safe logging the other inode without acquiring its
 		 * lock as long as we log with the LOG_INODE_EXISTS mode. We
 		 * are safe against concurrent renames of the other inode as
-- 
2.11.0

