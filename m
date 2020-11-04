Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4DC2A62E3
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 12:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgKDLHk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 06:07:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:53056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgKDLHk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Nov 2020 06:07:40 -0500
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFD25221F8
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 11:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604488058;
        bh=V2ZO5qLTCok3NCM9guMdqM+MkbTXtmrf96tDYAHaqKo=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=JYiCM8PIRp+S38K+VOHwcgzWSwEc+go9aRBumoHS8GasXbD8k8QngOCoumxn+Wb2o
         3hoHZQzJ9nkMUPpDokgH4F0IJdIjO5q1kdLJ4Ll1leVKc5DSwBqf3wr1+CY0c5qEKs
         AuO/srM/iGyJ7DhQ6MI7FT/5h5sfyzRVqwroeR6Q=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: fix missing delalloc new bit for new delalloc ranges
Date:   Wed,  4 Nov 2020 11:07:31 +0000
Message-Id: <7f215e2509aa557504a5d352ff4371f2e2606f59.1604486892.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1604486892.git.fdmanana@suse.com>
References: <cover.1604486892.git.fdmanana@suse.com>
In-Reply-To: <cover.1604486892.git.fdmanana@suse.com>
References: <cover.1604486892.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing a buffered write, through one of the write family syscalls, we
look for ranges which currenly don't have allocated extents and set the
'delalloc new' bit on them, so that we can report a correct number of used
blocks to the stat(2) syscall until delalloc is flushed and ordered extents
complete.

However there are a few other places where we can do a buffered write
against a range that is mapped to a hole (no extent allocated) and where
we do not set the 'new delalloc' bit. Those places are:

- Doing a memory mapped write against a hole;

- Cloning an inline extent into a hole starting at file offset 0;

- Calling btrfs_cont_expand() when the i_size of the file is not aligned
  to the sector size and is located in a hole. For example when cloning
  to a destination offset beyond eof.

So after such cases, until the corresponding delalloc range is flushed and
the respective ordered extents complete, we can report an incorrect number
of blocks used through the stat(2) syscall.

In some cases we can end up reporting 0 used blocks to stat(2), which is a
particular bad value to report as it may mislead tools to think a file is
completely sparse when its i_size is not zero, making them skip reading
any data, an undesired consequence for tools such as archivers and other
backup tools, as reported a long time ago in the following thread (and
other past threads):

  https://lists.gnu.org/archive/html/bug-tar/2016-07/msg00001.html

Example reproducer:

  $ cat reproducer.sh
  #!/bin/bash

  MNT=/mnt/sdi
  DEV=/dev/sdi

  mkfs.btrfs -f $DEV > /dev/null
  # mkfs.xfs -f $DEV > /dev/null
  # mkfs.ext4 -F $DEV > /dev/null
  # mkfs.f2fs -f $DEV > /dev/null
  mount $DEV $MNT

  xfs_io -f -c "truncate 64K"   \
      -c "mmap -w 0 64K"        \
      -c "mwrite -S 0xab 0 64K" \
      -c "munmap"               \
      $MNT/foo

  blocks_used=$(stat -c %b $MNT/foo)
  echo "blocks used: $blocks_used"

  if [ $blocks_used -eq 0 ]; then
      echo "ERROR: blocks used is 0"
  fi

  umount $DEV

  $ ./reproducer.sh
  blocks used: 0
  ERROR: blocks used is 0

So move the logic that decides to set the 'delalloc bit' bit into the
function btrfs_set_extent_delalloc(), since that is what we use for all
those missing cases as well as for the cases that currently work well.

This change is also preparatory work for an upcoming patch that fixes
other problems related to tracking and reporting the number of bytes used
by an inode.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c              | 56 -----------------------------------
 fs/btrfs/inode.c             | 57 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/tests/inode-tests.c | 12 +++++---
 3 files changed, 65 insertions(+), 60 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 1e87267b9e21..56c1fe3988bd 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -452,45 +452,6 @@ static void btrfs_drop_pages(struct page **pages, size_t num_pages)
 	}
 }
 
-static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
-					 const u64 start,
-					 const u64 len,
-					 struct extent_state **cached_state)
-{
-	u64 search_start = start;
-	const u64 end = start + len - 1;
-
-	while (search_start < end) {
-		const u64 search_len = end - search_start + 1;
-		struct extent_map *em;
-		u64 em_len;
-		int ret = 0;
-
-		em = btrfs_get_extent(inode, NULL, 0, search_start, search_len);
-		if (IS_ERR(em))
-			return PTR_ERR(em);
-
-		if (em->block_start != EXTENT_MAP_HOLE)
-			goto next;
-
-		em_len = em->len;
-		if (em->start < search_start)
-			em_len -= search_start - em->start;
-		if (em_len > search_len)
-			em_len = search_len;
-
-		ret = set_extent_bit(&inode->io_tree, search_start,
-				     search_start + em_len - 1,
-				     EXTENT_DELALLOC_NEW, cached_state, GFP_NOFS);
-next:
-		search_start = extent_map_end(em);
-		free_extent_map(em);
-		if (ret)
-			return ret;
-	}
-	return 0;
-}
-
 /*
  * after copy_from_user, pages need to be dirtied and we need to make
  * sure holes are created between the current EOF and the start of
@@ -533,23 +494,6 @@ int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
 			 0, 0, cached);
 
-	if (!btrfs_is_free_space_inode(inode)) {
-		if (start_pos >= isize &&
-		    !(inode->flags & BTRFS_INODE_PREALLOC)) {
-			/*
-			 * There can't be any extents following eof in this case
-			 * so just set the delalloc new bit for the range
-			 * directly.
-			 */
-			extra_bits |= EXTENT_DELALLOC_NEW;
-		} else {
-			err = btrfs_find_new_delalloc_bytes(inode, start_pos,
-							    num_bytes, cached);
-			if (err)
-				return err;
-		}
-	}
-
 	err = btrfs_set_extent_delalloc(inode, start_pos, end_of_last_block,
 					extra_bits, cached);
 	if (err)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c54e0ed0b938..2fb3d2ea75fd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2301,11 +2301,68 @@ static int add_pending_csums(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
+static int btrfs_find_new_delalloc_bytes(struct btrfs_inode *inode,
+					 const u64 start,
+					 const u64 len,
+					 struct extent_state **cached_state)
+{
+	u64 search_start = start;
+	const u64 end = start + len - 1;
+
+	while (search_start < end) {
+		const u64 search_len = end - search_start + 1;
+		struct extent_map *em;
+		u64 em_len;
+		int ret = 0;
+
+		em = btrfs_get_extent(inode, NULL, 0, search_start, search_len);
+		if (IS_ERR(em))
+			return PTR_ERR(em);
+
+		if (em->block_start != EXTENT_MAP_HOLE)
+			goto next;
+
+		em_len = em->len;
+		if (em->start < search_start)
+			em_len -= search_start - em->start;
+		if (em_len > search_len)
+			em_len = search_len;
+
+		ret = set_extent_bit(&inode->io_tree, search_start,
+				     search_start + em_len - 1,
+				     EXTENT_DELALLOC_NEW, cached_state, GFP_NOFS);
+next:
+		search_start = extent_map_end(em);
+		free_extent_map(em);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 			      unsigned int extra_bits,
 			      struct extent_state **cached_state)
 {
 	WARN_ON(PAGE_ALIGNED(end));
+
+	if (start >= i_size_read(&inode->vfs_inode) &&
+	    !(inode->flags & BTRFS_INODE_PREALLOC)) {
+		/*
+		 * There can't be any extents following eof in this case so just
+		 * set the delalloc new bit for the range directly.
+		 */
+		extra_bits |= EXTENT_DELALLOC_NEW;
+	} else {
+		int ret;
+
+		ret = btrfs_find_new_delalloc_bytes(inode, start,
+						    end + 1 - start,
+						    cached_state);
+		if (ret)
+			return ret;
+	}
+
 	return set_extent_delalloc(&inode->io_tree, start, end, extra_bits,
 				   cached_state);
 }
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index e6719f7db386..04022069761d 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -983,7 +983,8 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	ret = clear_extent_bit(&BTRFS_I(inode)->io_tree,
 			       BTRFS_MAX_EXTENT_SIZE >> 1,
 			       (BTRFS_MAX_EXTENT_SIZE >> 1) + sectorsize - 1,
-			       EXTENT_DELALLOC | EXTENT_UPTODATE, 0, 0, NULL);
+			       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
+			       EXTENT_UPTODATE, 0, 0, NULL);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1050,7 +1051,8 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	ret = clear_extent_bit(&BTRFS_I(inode)->io_tree,
 			       BTRFS_MAX_EXTENT_SIZE + sectorsize,
 			       BTRFS_MAX_EXTENT_SIZE + 2 * sectorsize - 1,
-			       EXTENT_DELALLOC | EXTENT_UPTODATE, 0, 0, NULL);
+			       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
+			       EXTENT_UPTODATE, 0, 0, NULL);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1082,7 +1084,8 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 
 	/* Empty */
 	ret = clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
-			       EXTENT_DELALLOC | EXTENT_UPTODATE, 0, 0, NULL);
+			       EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
+			       EXTENT_UPTODATE, 0, 0, NULL);
 	if (ret) {
 		test_err("clear_extent_bit returned %d", ret);
 		goto out;
@@ -1097,7 +1100,8 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 out:
 	if (ret)
 		clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, (u64)-1,
-				 EXTENT_DELALLOC | EXTENT_UPTODATE, 0, 0, NULL);
+				 EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
+				 EXTENT_UPTODATE, 0, 0, NULL);
 	iput(inode);
 	btrfs_free_dummy_root(root);
 	btrfs_free_dummy_fs_info(fs_info);
-- 
2.28.0

