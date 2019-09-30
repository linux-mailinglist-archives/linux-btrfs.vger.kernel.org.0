Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 005E9C1DD2
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 11:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbfI3JUb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 05:20:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfI3JUb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 05:20:31 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0DFE21855
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2019 09:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569835230;
        bh=//5BMacmCtFwZNIk5FMVOe6N8qp1pZdnAC0WHbdf/s4=;
        h=From:To:Subject:Date:From;
        b=rlfAvSDD9FVZlXMf5gc/ed7QNjuyHal9KMnq1xS0X3ulLBc4ApN2OMD9fsR4GrmN3
         NW34bcYiksqqHohOXsv2XasR3QuQL/BDVYE/8DToNXz/Ga5wYcuSsFaJdUKegoT3i3
         smAO9qH9gsoDfgYIFyvpCJuq2RoNR4lJVPlsPm+4=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix memory leak due to concurrent append writes with fiemap
Date:   Mon, 30 Sep 2019 10:20:25 +0100
Message-Id: <20190930092025.31118-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When we have a buffered write that starts at an offset greater than or
equals to the file's size happening concurrently with a full ranged
fiemap, we can end up leaking an extent state structure.

Suppose we have a file with a size of 1Mb, and before the buffered write
and fiemap are performed, it has a single extent state in its io tree
representing the range from 0 to 1Mb, with the EXTENT_DELALLOC bit set.

The following sequence diagram shows how the memory leak happens if a
fiemap a buffered write, starting at offset 1Mb and with a length of
4Kb, are performed concurrently.

          CPU 1                                                  CPU 2

  extent_fiemap()
    --> it's a full ranged fiemap
        range from 0 to LLONG_MAX - 1
        (9223372036854775807)

    --> locks range in the inode's
        io tree
      --> after this we have 2 extent
          states in the io tree:
          --> 1 for range [0, 1Mb[ with
              the bits EXTENT_LOCKED and
              EXTENT_DELALLOC_BITS set
          --> 1 for the range
              [1Mb, LLONG_MAX[ with
              the EXTENT_LOCKED bit set

                                                  --> start buffered write at offset
                                                      1Mb with a length of 4Kb

                                                  btrfs_file_write_iter()

                                                    btrfs_buffered_write()
                                                      --> cached_state is NULL

                                                      lock_and_cleanup_extent_if_need()
                                                        --> returns 0 and does not lock
                                                            range because it starts
                                                            at current i_size / eof

                                                      --> cached_state remains NULL

                                                      btrfs_dirty_pages()
                                                        btrfs_set_extent_delalloc()
                                                          (...)
                                                          __set_extent_bit()

                                                            --> splits extent state for range
                                                                [1Mb, LLONG_MAX[ and now we
                                                                have 2 extent states:

                                                                --> one for the range
                                                                    [1Mb, 1Mb + 4Kb[ with
                                                                    EXTENT_LOCKED set
                                                                --> another one for the range
                                                                    [1Mb + 4Kb, LLONG_MAX[ with
                                                                    EXTENT_LOCKED set as well

                                                            --> sets EXTENT_DELALLOC on the
                                                                extent state for the range
                                                                [1Mb, 1Mb + 4Kb[
                                                            --> caches extent state
                                                                [1Mb, 1Mb + 4Kb[ into
                                                                @cached_state because it has
                                                                the bit EXTENT_LOCKED set

                                                    --> btrfs_buffered_write() ends up
                                                        with a non-NULL cached_state and
                                                        never calls anything to release its
                                                        reference on it, resulting in a
                                                        memory leak

Fix this by calling free_extent_state() on cached_state if the range was
not locked by lock_and_cleanup_extent_if_need().

The same issue can happen if anything else other than fiemap locks a range
that covers eof and beyond.

This could be triggered, sporadically, by test case generic/561 from the
fstests suite, which makes duperemove run concurrently with fsstress, and
duperemove does plenty of calls to fiemap. When CONFIG_BTRFS_DEBUG is set
the leak is reported in dmesg/syslog when removing the btrfs module with
a message like the following:

  [77100.039461] BTRFS: state leak: start 6574080 end 6582271 state 16402 in tree 0 refs 1

Otherwise (CONFIG_BTRFS_DEBUG not set) detectable with kmemleak.

CC: stable@vger.kernel.org # 4.16+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 35c3499a425a..3d151f788177 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1591,7 +1591,6 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct page **pages = NULL;
-	struct extent_state *cached_state = NULL;
 	struct extent_changeset *data_reserved = NULL;
 	u64 release_bytes = 0;
 	u64 lockstart;
@@ -1611,6 +1610,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		return -ENOMEM;
 
 	while (iov_iter_count(i) > 0) {
+		struct extent_state *cached_state = NULL;
 		size_t offset = offset_in_page(pos);
 		size_t sector_offset;
 		size_t write_bytes = min(iov_iter_count(i),
@@ -1758,9 +1758,20 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		if (copied > 0)
 			ret = btrfs_dirty_pages(inode, pages, dirty_pages,
 						pos, copied, &cached_state);
+
+		/*
+		 * If we have not locked the extent range, because the range's
+		 * start offset is >= i_size, we might still have a non-NULL
+		 * cached extent state, acquired while marking the extent range
+		 * as delalloc through btrfs_dirty_pages(). Therefore free any
+		 * possible cached extent state to avoid a memory leak.
+		 */
 		if (extents_locked)
 			unlock_extent_cached(&BTRFS_I(inode)->io_tree,
 					     lockstart, lockend, &cached_state);
+		else
+			free_extent_state(cached_state);
+
 		btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes,
 					       true);
 		if (ret) {
-- 
2.11.0

