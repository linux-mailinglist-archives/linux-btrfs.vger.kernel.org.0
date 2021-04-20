Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC533655CC
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Apr 2021 11:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhDTJzr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 05:55:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230511AbhDTJzr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 05:55:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3583E601FF
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Apr 2021 09:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618912515;
        bh=tz6yl4KgvsKx4iKCmcw3/q1uod73KiNwRL8VIhOf7Qs=;
        h=From:To:Subject:Date:From;
        b=PMZmjzoJ1vKjv0Nq9woTAUx8yYrrCT46h50auUPlQE3h2c7xjfsMB3UCtC6UUaiOR
         UGOanGrRiPH6M28ZGzmv/QfPzfPVFi5QqZwJp6iKHrEqmBl12UGNQvorhrfpzlpnsg
         6ohV8mCbG8upGCRXC6daYrxS/SUl97HaahQuY58NNZd7WZaIUiO3C9BUJMi5Hzy+3p
         7YLkIjqFiym+gNp4pQFTsv0++F48pRfc3SAKWb1bfhZo4QmpS2IziRLeltsn5VwIoQ
         H3RxNqsitwFmg1vyg39IJKktMz3LBIterxCX4qLPE2A1LhUjB4ivOedR13B0iqoU9W
         rTTo5KASYC0jA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix metadata extent leak after failure to create subvolume
Date:   Tue, 20 Apr 2021 10:55:12 +0100
Message-Id: <e94fda2a13e93bbeae458d9815a1610d6438ba33.1618912341.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When creating a subvolume we allocate an extent buffer for its root node
after starting a transaction. We setup a root item for the subvolume that
points to that extent buffer and then attempt to insert the root item into
the root tree - however if that fails, due to -ENOMEM for example, we do
not free the extent buffer previously allocated and we do not abort the
transaction (as at that point we did nothing that can not be undone).

This means that we effectively do not return the metadata extent back to
the free space cache/tree and we leave a delayed reference for it which
causes a metadata extent item to be added to the extent tree, in the next
transaction commit, without having backreferences. When this happens
'btrfs check' reports the following:

  $ btrfs check /dev/sdi
  Opening filesystem to check...
  Checking filesystem on /dev/sdi
  UUID: dce2cb9d-025f-4b05-a4bf-cee0ad3785eb
  [1/7] checking root items
  [2/7] checking extents
  ref mismatch on [30425088 16384] extent item 1, found 0
  backref 30425088 root 256 not referenced back 0x564a91c23d70
  incorrect global backref count on 30425088 found 1 wanted 0
  backpointer mismatch on [30425088 16384]
  owner ref check failed [30425088 16384]
  ERROR: errors found in extent allocation tree or chunk allocation
  [3/7] checking free space cache
  [4/7] checking fs roots
  [5/7] checking only csums items (without verifying data)
  [6/7] checking root refs
  [7/7] checking quota groups skipped (not enabled on this FS)
  found 212992 bytes used, error(s) found
  total csum bytes: 0
  total tree bytes: 131072
  total fs tree bytes: 32768
  total extent tree bytes: 16384
  btree space waste bytes: 124669
  file data blocks allocated: 65536
   referenced 65536

So fix this by freeing the metadata extent if btrfs_insert_root() returns
an error.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 3415a9f06c81..e3927bc114b0 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -697,8 +697,6 @@ static noinline int create_subvol(struct inode *dir,
 	btrfs_set_root_otransid(root_item, trans->transid);
 
 	btrfs_tree_unlock(leaf);
-	free_extent_buffer(leaf);
-	leaf = NULL;
 
 	btrfs_set_root_dirid(root_item, BTRFS_FIRST_FREE_OBJECTID);
 
@@ -707,8 +705,22 @@ static noinline int create_subvol(struct inode *dir,
 	key.type = BTRFS_ROOT_ITEM_KEY;
 	ret = btrfs_insert_root(trans, fs_info->tree_root, &key,
 				root_item);
-	if (ret)
+	if (ret) {
+		/*
+		 * Since we don't abort the transaction in this case, free the
+		 * tree block so that we don't leak space and leave the filesytem
+		 * in an inconsistent state (an extent item in the extent tree
+		 * without backreferences). Also no need to have the tree block
+		 * locked since it is not in any tree at this point, so no other
+		 * task can find it and use it.
+		 */
+		btrfs_free_tree_block(trans, root, leaf, 0, 1);
+		free_extent_buffer(leaf);
 		goto fail;
+	}
+
+	free_extent_buffer(leaf);
+	leaf = NULL;
 
 	key.offset = (u64)-1;
 	new_root = btrfs_get_new_fs_root(fs_info, objectid, anon_dev);
-- 
2.28.0

