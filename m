Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9CA15BC9E
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 11:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgBMKUG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 05:20:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:53758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbgBMKUG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 05:20:06 -0500
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD4B2217F4;
        Thu, 13 Feb 2020 10:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581589205;
        bh=+fiioPgccicJo9MKKpP7Sm4yzs8aNAbAyPMLPLLUjx0=;
        h=From:To:Cc:Subject:Date:From;
        b=A+B2oFv4dO2vdp7cbHC/aKFuJqL9JyyIPzbSn2ZtJ+UlsV1KbaMUWFOyvxpF9T6vP
         LY5pPM0TlNFKF9WgZyg8N6WjTeoZ4BHgL2TEDnXA2WSzgzFwiRlhagwunXxhHCYJga
         sWZ+J1yRxW+d2fun4wB5D2OOHjC7MxjuxNflPjHg=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
Subject: [PATCH] Btrfs: avoid unnecessary splits when setting bits on an extent io tree
Date:   Thu, 13 Feb 2020 10:20:02 +0000
Message-Id: <20200213102002.6176-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When attempting to set bits on a range of an exent io tree that already
has those bits set we can end up splitting an extent state record, use
the preallocated extent state record, insert it into the red black tree,
do another search on the red black tree, merge the preallocated extent
state record with the previous extent state record, remove that previous
record from the red black tree and then free it. This is all unnecessary
work that consumes time.

This happens specifically at the following case at __set_extent_bit():

  $ cat -n fs/btrfs/extent_io.c
   957  static int __must_check
   958  __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
  (...)
  1044          /*
  1045           *     | ---- desired range ---- |
  1046           * | state |
  1047           *   or
  1048           * | ------------- state -------------- |
  1049           *
  (...)
  1060          if (state->start < start) {
  1061                  if (state->state & exclusive_bits) {
  1062                          *failed_start = start;
  1063                          err = -EEXIST;
  1064                          goto out;
  1065                  }
  1066
  1067                  prealloc = alloc_extent_state_atomic(prealloc);
  1068                  BUG_ON(!prealloc);
  1069                  err = split_state(tree, state, prealloc, start);
  1070                  if (err)
  1071                          extent_io_tree_panic(tree, err);
  1072
  1073                  prealloc = NULL;

So if our extent state represents a range from 0 to 1Mb for example, and
we want to set bits in the range 128Kb to 256Kb for example, and that
extent state record already has all those bits set, we end up splitting
that record, so we end up with extent state records in the tree which
represent the ranges from 0 to 128Kb and from 128Kb to 1Mb. This is
temporary because a subsequent iteration in that function will end up
merging the records.

The splitting requires using the preallocated extent state record, so
a future iteration that needs to do another split will need to allocate
another extent state record in an atomic context, something not ideal
that we try to avoid as much as possible. The splitting also requires
an insertion in the red black tree, and a subsequent merge will require
a deletion from the red black tree and freeing an extent state record.

This change just skips the splitting of an extent state record when it
already has all the bits the we need to set.

Setting a bit that is already set for a range is very common in the
inode's 'file_extent_tree' extent io tree for example, where we keep
setting the EXTENT_DIRTY bit every time we replace an extent.

This change also fixes a bug that happens after the recent patchset from
Josef that avoids having implicit holes after a power failure when not
using the NO_HOLES feature, more specifically the patch with the subject:

  "btrfs: introduce the inode->file_extent_tree"

This patch introduced an extent io tree per inode to keep track of
completed ordered extents and figure out at any time what is the safe
value for the inode's disk_i_size. This assumes that for contiguous
ranges in a file we always end up with a single extent state record in
the io tree, but that is not the case, as there is a short time window
where we can have two extent state records representing contiguous
ranges. When this happens we end setting up an incorrect value for the
inode's disk_i_size, resulting in data loss after a clean unmount
of the filesystem. The following example explains how this can happen.

Suppose we have an inode with an i_size and a disk_i_size of 1Mb, so in
the inode's file_extent_tree we have a single extent state record that
represents the range [0, 1Mb[ with the EXTENT_DIRTY bit set. Then the
following steps happen:

1) A buffered write against file range [512Kb, 768Kb[ is made. At this
   point delalloc was not flushed yet;

2) Deduplication from some other inode into this inode's range
   [128Kb, 256Kb[ is made. This causes btrfs_inode_set_file_extent_range()
   to be called, from btrfs_insert_clone_extent(), to mark the range
   [128Kb, 256Kb[ with EXTENT_DIRTY in the inode's file_extent_tree;

3) When btrfs_inode_set_file_extent_range() calls set_extent_bits(), we
   end up at __set_extent_bit(). In the first iteration of that function's
   loop we end up in the following branch:

   $ cat -n fs/btrfs/extent_io.c
    957  static int __must_check
    958  __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
   (...)
   1044          /*
   1045           *     | ---- desired range ---- |
   1046           * | state |
   1047           *   or
   1048           * | ------------- state -------------- |
   1049           *
   (...)
   1060          if (state->start < start) {
   1061                  if (state->state & exclusive_bits) {
   1062                          *failed_start = start;
   1063                          err = -EEXIST;
   1064                          goto out;
   1065                  }
   1066
   1067                  prealloc = alloc_extent_state_atomic(prealloc);
   1068                  BUG_ON(!prealloc);
   1069                  err = split_state(tree, state, prealloc, start);
   1070                  if (err)
   1071                          extent_io_tree_panic(tree, err);
   1072
   1073                  prealloc = NULL;
   (...)
   1089                  goto search_again;

   This splits the state record into two, one for range [0, 128Kb[ and
   another for the range [128Kb, 1Mb[. Both already have the EXTENT_DIRTY
   bit set. Then we jump to the 'search_again' label, where we unlock the
   the spinlock protecting the extent io tree before jumping to the
   'again' label to perform the next iteration;

4) In the meanwhile, delalloc is flushed, the ordered extent for the range
   [512Kb, 768Kb[ is created and when it completes, at
   btrfs_finish_ordered_io(), it calls btrfs_inode_safe_disk_i_size_write()
   with a value of 0 for its 'new_size' argument;

5) Before the deduplication task currently at __set_extent_bit() moves to
   the next iteration, the task finishing the ordered extent calls
   find_first_extent_bit() through btrfs_inode_safe_disk_i_size_write()
   and gets 'start' set to 0 and 'end' set to 128Kb - because at this
   moment the io tree has two extent state records, one representing the
   range [0, 128Kb[ and another representing the range [128Kb, 1Mb[,
   both with EXTENT_DIRTY set. Then we set 'isize' to:

   isize = min(isize, end + 1)
         = min(1Mb, 128Kb - 1 + 1)
         = 128Kb

   Then we set the inode's disk_i_size to 128Kb (isize).

   After a clean unmount of the filesystem and mounting it again, we have
   the file with a size of 128Kb, and effectively lost all the data it
   had before in the range from 128Kb to 1Mb.

This change fixes that issue too, as we never end up splitting extent
state records when they already have all the bits we want set.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 56258f4e3e50..a477862121cc 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1064,6 +1064,16 @@ __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 			goto out;
 		}
 
+		/*
+		 * If this extent already has all the bits we want set, then
+		 * skip it, not necessary to split it or do anything with it.
+		 */
+		if ((state->state & bits) == bits) {
+			start = state->end + 1;
+			cache_state(state, cached_state);
+			goto search_again;
+		}
+
 		prealloc = alloc_extent_state_atomic(prealloc);
 		BUG_ON(!prealloc);
 		err = split_state(tree, state, prealloc, start);
-- 
2.11.0

