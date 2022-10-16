Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC2B6000B5
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Oct 2022 17:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJPPeN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Oct 2022 11:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJPPeL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Oct 2022 11:34:11 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7AB38A36
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Oct 2022 08:34:07 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.17.17.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id CEF25486392C1;
        Sun, 16 Oct 2022 23:34:04 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1665934446; bh=MYPL/h1Fe4xjX3VnmBoDeHLveLHO6/KOdHlEew/VoeQ=;
        h=From:To:Cc:Subject:Date;
        b=fmghXdQ+fw3bazsSVWRA/CUX4bJOr/f1ZPcZqpIUSM37pBj4mVTBNeb3b+cMFoKM/
         zgK+0NOk2UUDiiqdxVZk36lzxQ/NcMmQItaW4B1uSX8gXYotX1eZPXBV2L+TI+FcN4
         9qgHuWQ+hLXSWvSIASgfkFelaOXSwhCCs+bvR2zA=
From:   bingjingc <bingjingc@synology.com>
To:     fdmanana@kernel.org, josef@toxicpanda.com, dsterba@suse.com,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     bingjingc@synology.com, bxxxjxxg@gmail.com
Subject: [PATCH] btrfs: send: fix send failure of a subcase of orphan inodes
Date:   Sun, 16 Oct 2022 23:33:46 +0800
Message-Id: <20221016153346.2794-1-bingjingc@synology.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: BingJing Chang <bingjingc@synology.com>

Commit 9ed0a72e5b35 ("btrfs: send: fix failures when processing inodes with
no links") tries to fix all incremental send cases of orphan inodes the
send operation will meet. However, there's still a bug causing the corner
subcase fails with a ENOENT error.

Here's shortened steps of that subcase:

  $ btrfs subvolume create vol
  $ touch vol/foo

  $ btrfs subvolume snapshot -r vol snap1
  $ btrfs subvolume snapshot -r vol snap2

  # Turn the second snapshot to RW mode and delete the file while
  # holding an open file descriptor on it
  $ btrfs property set snap2 ro false
  $ exec 73<snap2/foo
  $ rm snap2/foo

  # Set the second snapshot back to RO mode and do an incremental send
  # with an unusal reverse order
  $ btrfs property set snap2 ro true
  $ btrfs send -p snap2 snap1 > /dev/null
  At subvol snap1
  ERROR: send ioctl failed with -2: No such file or directory

It's subcase 3 of BTRFS_COMPARE_TREE_CHANGED in the commit 9ed0a72e5b35
("btrfs: send: fix failures when processing inodes with no links"). And
it's not a common case. We still have not met it in the real world.
Theoretically, this case can happen in a batch cascading snapshot backup.
In cascading backups, the receive operation in the middle may cause orphan
inodes to appear because of the open file descriptors on the snapshot files
during receiving. And if we don't do the batch snapshot backups in their
creation order, then we can have an inode, which is an orphan in the parent
snapshot but refers to a file in the send snapshot. Since an orphan inode
has no paths, the send operation will fail with a ENOENT error if it
tries to generate a path for it.

In that patch, this subcase will be treated as an inode with a new
generation. However, when the routine tries to delete the old paths in
the parent snapshot, the function process_all_refs() doesn't check whether
there are paths recorded or not before it calls the function
process_recorded_refs(). And the function process_recorded_refs() try
to get the first path in the parent snapshot in the beginning. Since it has
no paths in the parent snapshot, the send operation fails.

To fix this, we can easily put a link count check to avoid entering the
deletion routine like what we do a link count check to avoid creating a
new one. Moreover, we can assume that the function process_all_refs()
can always collect references to process because we know it has a
positive link count.

Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 fs/btrfs/send.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 4ef4167072b8..1568fa977ca1 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6665,17 +6665,19 @@ static int changed_inode(struct send_ctx *sctx,
 			/*
 			 * First, process the inode as if it was deleted.
 			 */
-			sctx->cur_inode_gen = right_gen;
-			sctx->cur_inode_new = false;
-			sctx->cur_inode_deleted = true;
-			sctx->cur_inode_size = btrfs_inode_size(
-					sctx->right_path->nodes[0], right_ii);
-			sctx->cur_inode_mode = btrfs_inode_mode(
-					sctx->right_path->nodes[0], right_ii);
-			ret = process_all_refs(sctx,
-					BTRFS_COMPARE_TREE_DELETED);
-			if (ret < 0)
-				goto out;
+			if (old_nlinks > 0) {
+				sctx->cur_inode_gen = right_gen;
+				sctx->cur_inode_new = false;
+				sctx->cur_inode_deleted = true;
+				sctx->cur_inode_size = btrfs_inode_size(
+						sctx->right_path->nodes[0], right_ii);
+				sctx->cur_inode_mode = btrfs_inode_mode(
+						sctx->right_path->nodes[0], right_ii);
+				ret = process_all_refs(sctx,
+						BTRFS_COMPARE_TREE_DELETED);
+				if (ret < 0)
+					goto out;
+			}
 
 			/*
 			 * Now process the inode as if it was new.
-- 
2.37.1

