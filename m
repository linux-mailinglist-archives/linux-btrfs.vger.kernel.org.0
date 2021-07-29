Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40F73DAA83
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jul 2021 19:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhG2Rww (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jul 2021 13:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229485AbhG2Rww (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jul 2021 13:52:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EC9160F42
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jul 2021 17:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627581168;
        bh=nadeIW/GuPJNhfKUg/Mo8x6Lw6YW9kr76tCAwTMRRSM=;
        h=From:To:Subject:Date:From;
        b=F9lRIe3GazFJGCj9HOlYOu8YwAv2OJyvpWTc0nxTn6MGoyqBfq5F38Y4XK7kWAkeB
         UVP9i2bZmAD22/nADDVE44C/3EK/UClOoBk73JKq8KJMrFPfgfYrBv33UzlQ7FgK83
         6RI3nZ58fWtja6T+E6HFW7cjOlwXBW4Sl2l4a+vaR7h3dr191L+THvgPi9ffz5wkJA
         WmO13hYYmXdZ9w44MHV8mnDdbcmgN3UpYOmAHbrRzIcNu6N8PXDLA6znaH1KlcPKnY
         Qr9rlZkZVakzhnilQqN4+X7YGoMldXNJcPoXpJygGqRnoY5DYoQDWU47ictrmzpKaH
         d8DLw1iHe4xLg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: avoid unnecessarily logging directories that had no changes
Date:   Thu, 29 Jul 2021 18:52:46 +0100
Message-Id: <ffa14771bb6d672a2a74d92625bd024013b3f8ce.1627580467.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

There are several cases where when logging an inode we need to log its
parent directories or logging subdirectories when logging a directory.

There are cases however where we end up logging a directory even if it was
not changed in the current transaction, no dentries added or removed since
the last transaction. While this is harmless from a functional point of
view, it is a waste time as it brings no advantage.

One example where this is triggered is the following:

  $ mkfs.btrfs -f /dev/sdc
  $ mount /dev/sdc /mnt

  $ mkdir /mnt/A
  $ mkdir /mnt/B
  $ mkdir /mnt/C

  $ touch /mnt/A/foo
  $ ln /mnt/A/foo /mnt/B/bar
  $ ln /mnt/A/foo /mnt/C/baz

  $ sync

  $ rm -f /mnt/A/foo
  $ xfs_io -c "fsync" /mnt/B/bar

This last fsync ends up logging directories A, B and C, however we only
need to log directory A, as B and C were not changed since the last
transaction commit.

So fix this by changing need_log_inode(), to return false in case the
given inode is a directory and has a ->last_trans value smaller than the
current transaction's ID.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index d2039743ecf2..b4e820cde461 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5610,6 +5610,13 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 static bool need_log_inode(struct btrfs_trans_handle *trans,
 			   struct btrfs_inode *inode)
 {
+	/*
+	 * If a directory was not modified, no dentries added or removed, we can
+	 * and should avoid logging it.
+	 */
+	if (S_ISDIR(inode->vfs_inode.i_mode) && inode->last_trans < trans->transid)
+		return false;
+
 	/*
 	 * If this inode does not have new/updated/deleted xattrs since the last
 	 * time it was logged and is flagged as logged in the current transaction,
-- 
2.28.0

