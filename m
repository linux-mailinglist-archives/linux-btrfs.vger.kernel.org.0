Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6104551FF84
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 16:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbiEIO02 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 10:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236987AbiEIO0W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 10:26:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3871D4A34;
        Mon,  9 May 2022 07:22:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDC8C615BC;
        Mon,  9 May 2022 14:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE1AC385AB;
        Mon,  9 May 2022 14:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652106147;
        bh=sSIoYa6iDtZuA4VRX9K/Gfl5be/3u7oyJ2jIynKJu60=;
        h=From:To:Cc:Subject:Date:From;
        b=RjuBUWoLnRSTyNrV6lEOOJR0pfntmvnzlo7lmJ0GPfenntFu6pv05g2hWFeWoUHXh
         qbzB49AlEHOsxudBSO78rwqQGvpt8RNos4ZtPP5ROtHKCzROFiIZ73t/5AZ+fSQs2E
         eALfQ4YlkAB6ac5hcBoG/qmjHn4GN2SUDV/H/F80HIA68e61tA7/oKJL214fkXhJTO
         ScJPO6w9SS02NwF2TUmsYyIs7SXFYr8ZfQaAvP3zBHDhwSJyxrcPpr5Fcl8iHWSc4I
         WO8Q4glTMUql+kYtgYuuPVReOOsvfs0bKinbs8K4fj91mKWpefT0pLQ2m27gfnYTDH
         PWoQvle4E+w2A==
From:   fdmanana@kernel.org
To:     stable@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.17-stable] btrfs: always log symlinks in full mode
Date:   Mon,  9 May 2022 15:22:07 +0100
Message-Id: <a16d71c5518d24df053acafcbe381ae6d5e1c406.1652103634.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

commit d0e64a981fd841cb0f28fcd6afcac55e6f1e6994 upstream.

On Linux, empty symlinks are invalid, and attempting to create one with
the system call symlink(2) results in an -ENOENT error and this is
explicitly documented in the man page.

If we rename a symlink that was created in the current transaction and its
parent directory was logged before, we actually end up logging the symlink
without logging its content, which is stored in an inline extent. That
means that after a power failure we can end up with an empty symlink,
having no content and an i_size of 0 bytes.

It can be easily reproduced like this:

  $ mkfs.btrfs -f /dev/sdc
  $ mount /dev/sdc /mnt

  $ mkdir /mnt/testdir
  $ sync

  # Create a file inside the directory and fsync the directory.
  $ touch /mnt/testdir/foo
  $ xfs_io -c "fsync" /mnt/testdir

  # Create a symlink inside the directory and then rename the symlink.
  $ ln -s /mnt/testdir/foo /mnt/testdir/bar
  $ mv /mnt/testdir/bar /mnt/testdir/baz

  # Now fsync again the directory, this persist the log tree.
  $ xfs_io -c "fsync" /mnt/testdir

  <power failure>

  $ mount /dev/sdc /mnt
  $ stat -c %s /mnt/testdir/baz
  0
  $ readlink /mnt/testdir/baz
  $

Fix this by always logging symlinks in full mode (LOG_INODE_ALL), so that
their content is also logged.

A test case for fstests will follow.

CC: stable@vger.kernel.org # 4.9+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/tree-log.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 7a0bfa5bedb9..049ee19041c7 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5655,6 +5655,18 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 		mutex_lock(&inode->log_mutex);
 	}
 
+	/*
+	 * For symlinks, we must always log their content, which is stored in an
+	 * inline extent, otherwise we could end up with an empty symlink after
+	 * log replay, which is invalid on linux (symlink(2) returns -ENOENT if
+	 * one attempts to create an empty symlink).
+	 * We don't need to worry about flushing delalloc, because when we create
+	 * the inline extent when the symlink is created (we never have delalloc
+	 * for symlinks).
+	 */
+	if (S_ISLNK(inode->vfs_inode.i_mode))
+		inode_only = LOG_INODE_ALL;
+
 	/*
 	 * This is for cases where logging a directory could result in losing a
 	 * a file after replaying the log. For example, if we move a file from a
@@ -6015,7 +6027,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 			}
 
 			ctx->log_new_dentries = false;
-			if (type == BTRFS_FT_DIR || type == BTRFS_FT_SYMLINK)
+			if (type == BTRFS_FT_DIR)
 				log_mode = LOG_INODE_ALL;
 			ret = btrfs_log_inode(trans, BTRFS_I(di_inode),
 					      log_mode, ctx);
-- 
2.34.1

