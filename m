Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CCD3D731E
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbhG0KZJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236186AbhG0KYs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:24:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F8CC61882
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 10:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627381488;
        bh=q6Wxsyz5iHTfrTlSvZ6w3uTROgvfLLAqXFO5j2Vslbo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ljh2G4cv2uRflj04y0amub4G8GP4c4kBuO8fg81a8CNvYtrJbl3Ulum1jL+oe6Nh5
         UktfQAUZ7gLAdpVE7dakmnFsEOL0cCkgUAv7cmaOQAFzgliQzilLq2pDxiwjA4zG15
         Gn7uYhIKgvFcFlHNBin8YD4O3w0L0obSdQ0cHMiqgNb6MA/zBmmDA+GOZT+/FjLMNm
         /HlY0k6u3WicDxnbdj1fsOAF/4geaTtp5IPNS4ImQiidx44XhUOqeozf0ptiCZws0C
         obn6hAADxaBd3GXsvMS+GqgL+LlyH9eal2J9zPZKl7cFPyPQOFgMXnpHVCBGp5RapM
         7KOT1m17JQ0jA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: fix lost inode on log replay after mix of fsync, rename and inode eviction
Date:   Tue, 27 Jul 2021 11:24:43 +0100
Message-Id: <237d613fab410aa98a0b9fcf6186c5368d561207.1627379796.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1627379796.git.fdmanana@suse.com>
References: <cover.1627379796.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When checking if we need to log the new name of a renamed inode, we are
checking if the inode and its parent inode have been logged before, and if
not we don't log the new name. The check however is buggy, as it directly
compares the logged_trans field of the inodes versus the ID of the current
transaction. The problem is that logged_trans is a transient field, only
stored in memory and never persisted in the inode item, so if an inode
was logged before, evicted and reloaded, its logged_trans field is set to
a value of 0, meaning the check will return false and the new name of the
renamed inode is not logged. If the old parent directory was previously
fsynced and we deleted the logged directory entries corresponding to the
old name, we end up with a log that when replayed will delete the renamed
inode.

The following example triggers the problem:

  $ mkfs.btrfs -f /dev/sdc
  $ mount /dev/sdc /mnt

  $ mkdir /mnt/A
  $ mkdir /mnt/B
  $ echo -n "hello world" > /mnt/A/foo

  $ sync

  # Add some new file to A and fsync directory A.
  $ touch /mnt/A/bar
  $ xfs_io -c "fsync" /mnt/A

  # Now trigger inode eviction. We are only interested in triggering
  # eviction for the inode of directory A.
  $ echo 2 > /proc/sys/vm/drop_caches

  # Move foo from directory A to directory B.
  # This deletes the directory entries for foo in A from the log, and
  # does not add the new name for foo in directory B to the log, because
  # logged_trans of A is 0, which is less than the current transaction ID.
  $ mv /mnt/A/foo /mnt/B/foo

  # Now make an fsync to anything except A, B or any file inside them,
  # like for example create a file at the root directory and fsync this
  # new file. This syncs the log that contains all the changes done by
  # previous rename operation.
  $ touch /mnt/baz
  $ xfs_io -c "fsync" /mnt/baz

  <power fail>

  # Mount the filesystem and replay the log.
  $ mount /dev/sdc /mnt

  # Check the filesystem content.
  $ ls -1R /mnt
  /mnt/:
  A
  B
  baz

  /mnt/A:
  bar

  /mnt/B:
  $

  # File foo is gone, it's neither in A/ nor in B/.

Fix this by using the inode_logged() helper at btrfs_log_new_name(), which
safely checks if an inode was logged before in the current transaction.

A test case for fstests will follow soon.

CC: stable@vger.kernel.org # 4.14+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index c2ebe700d6e2..8dde5c08a48f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6536,8 +6536,8 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 	 * if this inode hasn't been logged and directory we're renaming it
 	 * from hasn't been logged, we don't need to log it
 	 */
-	if (inode->logged_trans < trans->transid &&
-	    (!old_dir || old_dir->logged_trans < trans->transid))
+	if (!inode_logged(trans, inode) &&
+	    (!old_dir || !inode_logged(trans, old_dir)))
 		return;
 
 	/*
-- 
2.28.0

