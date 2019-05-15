Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4091F710
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2019 17:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfEOPCm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 May 2019 11:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfEOPCm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 May 2019 11:02:42 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A30520815
        for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2019 15:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557932561;
        bh=HnKb9fbiDTjakNGJd2mkGZy4Npa15nPsvVDCVYpDvMY=;
        h=From:To:Subject:Date:From;
        b=Ldit1y5md5wVHsrSiBoHhWRN+2yO/8E6cMxutjux7ohZ4mGUvcuE2/cn4vcVIJU/N
         ZvzoJJ2NfK8s4K6USPNrTyxWNh0wB7d3O+5Y/huXBB4WqUqH5im72uDoMr6LepMm5s
         Aa6Tmu0UpCUqpaDXKqxe8d4E2zzUjR9I7EZOnKtQ=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] Btrfs: fix fsync not persisting changed attributes of a directory
Date:   Wed, 15 May 2019 16:02:38 +0100
Message-Id: <20190515150238.21939-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

While logging an inode we follow its ancestors and for each one we mark
it as logged in the current transaction, even if we have not logged it.
As a consequence if we change an attribute of an ancestor, such as the
UID or GID for example, and then explicitly fsync it, we end up not
logging the inode at all despite returning success to user space, which
results in the attribute being lost if a power failure happens after
the fsync.

Sample reproducer:

  $ mkfs.btrfs -f /dev/sdb
  $ mount /dev/sdb /mnt

  $ mkdir /mnt/dir
  $ chown 6007:6007 /mnt/dir

  $ sync

  $ chown 9003:9003 /mnt/dir
  $ touch /mnt/dir/file
  $ xfs_io -c fsync /mnt/dir/file

  # fsync our directory after fsync'ing the new file, should persist the
  # new values for the uid and gid.
  $ xfs_io -c fsync /mnt/dir

  <power failure>

  $ mount /dev/sdb /mnt
  $ stat -c %u:%g /mnt/dir
  6007:6007

    --> should be 9003:9003, the uid and gid were not persisted, despite
        the explicit fsync on the directory prior to the power failure

Fix this by not updating the logged_trans field of ancestor inodes when
logging an inode, since we have not logged them. Let only future calls to
btrfs_log_inode() to mark inodes as logged.

This could be triggered by my recent fsync fuzz tester for fstests, for
which an fstests patch exists titled "fstests: generic, fsync fuzz tester
with fsstress".

Fixes: 12fcfd22fe5b ("Btrfs: tree logging unlink/rename fixes")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 87e3e4e37606..7d13533a9620 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5465,7 +5465,6 @@ static noinline int check_parent_dirs_for_sync(struct btrfs_trans_handle *trans,
 {
 	int ret = 0;
 	struct dentry *old_parent = NULL;
-	struct btrfs_inode *orig_inode = inode;
 
 	/*
 	 * for regular files, if its inode is already on disk, we don't
@@ -5485,16 +5484,6 @@ static noinline int check_parent_dirs_for_sync(struct btrfs_trans_handle *trans,
 	}
 
 	while (1) {
-		/*
-		 * If we are logging a directory then we start with our inode,
-		 * not our parent's inode, so we need to skip setting the
-		 * logged_trans so that further down in the log code we don't
-		 * think this inode has already been logged.
-		 */
-		if (inode != orig_inode)
-			inode->logged_trans = trans->transid;
-		smp_mb();
-
 		if (btrfs_must_commit_transaction(trans, inode)) {
 			ret = 1;
 			break;
-- 
2.11.0

