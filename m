Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10738E9B6F
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 13:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfJ3MXO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 08:23:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfJ3MXO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 08:23:14 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84DBD2083E
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2019 12:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572438194;
        bh=ndS4sLrq04szMQXeRVwlLElTzXM6XRPH1TzrkBYzFS4=;
        h=From:To:Subject:Date:From;
        b=YAz/1sVoR9vNvSXljQZR+PGQWnLenWAjqz5Z32JBSOoEnyNwvNrri3sdx23DFGvNF
         Ef+MEMXQE15gBlmure/JB9l4m8vh2xBKUAsaC6cqgkQirKycqGo7q0qVC0EhYu1Gpy
         29bOo1X0l1iE1eSCO0iGBea7nat1yKmdQgtLtwb8=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: send, allow clone operations within the same file
Date:   Wed, 30 Oct 2019 12:23:11 +0000
Message-Id: <20191030122311.31349-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

For send we currently skip clone operations when the source and destination
files are the same. This is so because clone didn't support this case in
its early days, but support for it was added back in May 2013 by commit
a96fbc72884fcb ("Btrfs: allow file data clone within a file"). This change
adds support for it.

Example:

  $ mkfs.btrfs -f /dev/sdd
  $ mount /dev/sdd /mnt/sdd

  $ xfs_io -f -c "pwrite -S 0xab -b 64K 0 64K" /mnt/sdd/foobar
  $ xfs_io -c "reflink /mnt/sdd/foobar 0 64K 64K" /mnt/sdd/foobar

  $ btrfs subvolume snapshot -r /mnt/sdd /mnt/sdd/snap

  $ mkfs.btrfs -f /dev/sde
  $ mount /dev/sde /mnt/sde

  $ btrfs send /mnt/sdd/snap | btrfs receive /mnt/sde

Without this change file foobar at the destination has a single 128Kb
extent:

  $ filefrag -v /mnt/sde/snap/foobar
  Filesystem type is: 9123683e
  File size of /mnt/sde/snap/foobar is 131072 (32 blocks of 4096 bytes)
   ext:     logical_offset:        physical_offset: length:   expected: flags:
     0:        0..      31:          0..        31:     32:             last,unknown_loc,delalloc,eof
  /mnt/sde/snap/foobar: 1 extent found

With this we get a single 64Kb extent that is shared at file offsets 0
and 64K, just like in the source filesystem:

  $ filefrag -v /mnt/sde/snap/foobar
  Filesystem type is: 9123683e
  File size of /mnt/sde/snap/foobar is 131072 (32 blocks of 4096 bytes)
   ext:     logical_offset:        physical_offset: length:   expected: flags:
     0:        0..      15:       3328..      3343:     16:             shared
     1:       16..      31:       3328..      3343:     16:       3344: last,shared,eof
  /mnt/sde/snap/foobar: 2 extents found

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 518ec1265a0c..1624df5e6aa6 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1256,12 +1256,20 @@ static int __iterate_backrefs(u64 ino, u64 offset, u64 root, void *ctx_)
 	 */
 	if (found->root == bctx->sctx->send_root) {
 		/*
-		 * TODO for the moment we don't accept clones from the inode
-		 * that is currently send. We may change this when
-		 * BTRFS_IOC_CLONE_RANGE supports cloning from and to the same
-		 * file.
+		 * If the source inode was not yet processed we can't issue a
+		 * clone operation, as the source extent does not exist yet at
+		 * the destination of the stream.
 		 */
-		if (ino >= bctx->cur_objectid)
+		if (ino > bctx->cur_objectid)
+			return 0;
+		/*
+		 * We clone from the inode currently being sent as long as the
+		 * source extent is already processed, otherwise we could try
+		 * to clone from an extent that does not exist yet at the
+		 * destination of the stream.
+		 */
+		if (ino == bctx->cur_objectid &&
+		    offset >= bctx->sctx->cur_inode_next_write_offset)
 			return 0;
 	}
 
-- 
2.11.0

