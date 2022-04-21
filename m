Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81059509CEA
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 11:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352377AbiDUJ7f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 05:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiDUJ7d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 05:59:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D8821250
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 02:56:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69BE660F6C
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 09:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FD9C385A9
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 09:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650535003;
        bh=Cpf6Mgxwv5hajs9HUyTXheWuak4FBePwa1ipp/iFUqM=;
        h=From:To:Subject:Date:From;
        b=RGFYiII3xW5s6x2QRxPnoPNiWP2FT9QTgxfJomMqPaV055BmaEccg/58YiQk7xLys
         UIAKYYBx11otwr+arDX9LwgJrxXVIzMlErXWbRv1uyi9q8L31oSf0m/yXw/809ZJOY
         6iI3+uq5dfktwXVvGe1Be0enj6lExTpcGt6wxDZY61fp98SRoYTzYBayTwipAbGKCq
         ZoP8KQ62ZgdH246s91sxb+BWKv29AfaDnElwp+2L2qkreyrNEgdtWzZQta7JRYq8gQ
         Zo+FmELkeB063fP+8I50n2/pjebaVbX7EJ9Ot8H0FXSe4D6HkNcP9Gt68WwoKWVerq
         1du5Wi02XjAgg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: always log symlinks in full mode
Date:   Thu, 21 Apr 2022 10:56:39 +0100
Message-Id: <058da244fe15b0c5f0d55eaccd9af9f7c039d0a8.1650534831.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

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
---
 fs/btrfs/tree-log.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e356334ef797..b561dc3807f2 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5803,6 +5803,18 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
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
 	 * Before logging the inode item, cache the value returned by
 	 * inode_logged(), because after that we have the need to figure out if
@@ -6181,7 +6193,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 			}
 
 			ctx->log_new_dentries = false;
-			if (type == BTRFS_FT_DIR || type == BTRFS_FT_SYMLINK)
+			if (type == BTRFS_FT_DIR)
 				log_mode = LOG_INODE_ALL;
 			ret = btrfs_log_inode(trans, BTRFS_I(di_inode),
 					      log_mode, ctx);
-- 
2.35.1

