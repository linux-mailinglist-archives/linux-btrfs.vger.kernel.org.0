Return-Path: <linux-btrfs+bounces-11273-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ADFA276F2
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 17:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8505D18858F0
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 16:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981282139DC;
	Tue,  4 Feb 2025 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwOVczYi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEF0481D1
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Feb 2025 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738685783; cv=none; b=WAimW8qvuGWHyWAXeJoCfoEmEYwb2//RG+dTiLhZdDhwDnpfyRk5khNmLDCY4Jvc+Jozpfd+QT2KMvTT9C96Q2jz6FdxdFU+RXGAapr2WwK8SE3bQ0z7FPznCQiE1tX+Sr3fvlBEBICuUbuKFiz+8hhyy0yIvmnyCfyw5+oyY2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738685783; c=relaxed/simple;
	bh=t7DYv8/ER5y6o5uUX7Ig3+8hr6EsuYKMBicC3ZxtF7g=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=o0nH8/OJgeIZn2h/oKhtrH4sdgZ3XP66hqMQGTkXqZtIU+bFW6SEU+8FCojLEVun4b6CdIby9ZxgiVjzxgdpz53q9SsauiwAKjda1wHhNW+0NDezUd1TZqMpu9EmFvgbfsAGjDp9RF2u0tmuSg1xRn+vzySzApE1xnSb4anXMy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwOVczYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FC2C4CEDF
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Feb 2025 16:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738685783;
	bh=t7DYv8/ER5y6o5uUX7Ig3+8hr6EsuYKMBicC3ZxtF7g=;
	h=From:To:Subject:Date:From;
	b=DwOVczYidRnrA2vze4q1UkklivB0Q1SeRRIGOFUq1CN1lybpnZgK3f9HD88NGAQ/3
	 4/UnezxVXxdj6YhnFz2N9vZq1LZRzfareResgZeoMwIQ8E9LHtmo1M7ioWZagDAEZY
	 NLjAy7qLCatf+ubDcQAsdbgcU+jyX/qyIECMIeiXnhRMltc9p3I6qiger0BFi6pnKy
	 5t4ddFS+p3HlI4VNJmlhr8bnMPHPJVf9cjYryel/0p/qo6pX95Iy+keC8XJmHz7VGB
	 t9xDriWKMJsebUe9NqwXg2iCtGcLFevBlNOgdDVjEVt+yOG+S3HqgY8quPdvRded5p
	 gzQOurhpsyraw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix stale page cache after race between readahead and direct IO write
Date: Tue,  4 Feb 2025 16:16:19 +0000
Message-Id: <24617a89550bed4ef0e0db12d17187940de551b0.1738685146.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

After commit ac325fc2aad5 ("btrfs: do not hold the extent lock for entire
read") we can now trigger a race between a task doing a direct IO write
and readahead. When this race is triggered it results in tasks getting
stale data when they attempt do a buffered read (including the task that
did the direct IO write).

This race can be sporadically triggered with test case generic/418, failing
like this:

   $ ./check generic/418
   FSTYP         -- btrfs
   PLATFORM      -- Linux/x86_64 debian0 6.13.0-rc7-btrfs-next-185+ #17 SMP PREEMPT_DYNAMIC Mon Feb  3 12:28:46 WET 2025
   MKFS_OPTIONS  -- /dev/sdc
   MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

   generic/418 14s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//generic/418.out.bad)
       --- tests/generic/418.out	2020-06-10 19:29:03.850519863 +0100
       +++ /home/fdmanana/git/hub/xfstests/results//generic/418.out.bad	2025-02-03 15:42:36.974609476 +0000
       @@ -1,2 +1,5 @@
        QA output created by 418
       +cmpbuf: offset 0: Expected: 0x1, got 0x0
       +[6:0] FAIL - comparison failed, offset 24576
       +diotest -wp -b 4096 -n 8 -i 4 failed at loop 3
        Silence is golden
       ...
       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/generic/418.out /home/fdmanana/git/hub/xfstests/results//generic/418.out.bad'  to see the entire diff)
   Ran: generic/418
   Failures: generic/418
   Failed 1 of 1 tests

The race happens like this:

1) A file has a prealloc extent for the range [16K, 28K);

2) Task A starts a direct IO write against file range [24K, 28K).
   At the start of the direct IO write it invalidates the page cache at
   __iomap_dio_rw() with kiocb_invalidate_pages() for the 4K page at file
   offset 24K;

3) Task A enters btrfs_dio_iomap_begin() and locks the extent range
   [24K, 28K);

4) Task B starts a readahead for file range [16K, 28K), entering
   btrfs_readahead().

   First it attempts to read the page at offset 16K by entering
   btrfs_do_readpage(), where it calls get_extent_map(), locks the range
   [16K, 20K) and gets the extent map for the range [16K, 28K), caching
   it into the 'em_cached' variable declared in the local stack of
   btrfs_readahead(), and then unlocks the range [16K, 20K).

   Since the extent map has the prealloc flag, at btrfs_do_readpage() we
   zero out the page's content and don't submit any bio to read the page
   from the extent.

   Then it attempts to read the page at offset 20K entering
   btrfs_do_readpage() where we reuse the previously cached extent map
   (decided by get_extent_map()) since it spans the page's range and
   it's still in the inode's extent map tree.

   Just like for the previous page, we zero out the page's content since
   the extent map has the prealloc flag set.

   Then it attempts to read the page at offset 24K entering
   btrfs_do_readpage() where we reuse the previously cached extent map
   (decided by get_extent_map()) since it spans the page's range and
   it's still in the inode's extent map tree.

   Just like for the previous pages, we zero out the page's content since
   the extent map has the prealloc flag set. Note that we didn't lock the
   extent range [24K, 28K), so we didn't synchronize with the ongoig
   direct IO write being performed by task A;

5) Task A enters btrfs_create_dio_extent() and creates an ordered extent
   for the range [24K, 28K), with the flags BTRFS_ORDERED_DIRECT and
   BTRFS_ORDERED_PREALLOC set;

6) Task A unlocks the range [24K, 28K) at btrfs_dio_iomap_begin();

7) The ordered extent enters btrfs_finish_one_ordered() and locks the
   range [24K, 28K);

8) Task A enters fs/iomap/direct-io.c:iomap_dio_complete() and it tries
   to invalidate the page at offset 24K by calling
   kiocb_invalidate_post_direct_write(), resulting in a call chain that
   ends up at btrfs_release_folio().

   The btrfs_release_folio() call ends up returning false because the range
   for the page at file offset 24K is currently locked by the task doing
   the ordered extent completion in the previous step (7), so we have:

   btrfs_release_folio() ->
      __btrfs_release_folio() ->
         try_release_extent_mapping() ->
	     try_release_extent_state()

   This last function checking that the range is locked and returning false
   and propagating it up to btrfs_release_folio().

   So this results in a failure to invalidate the page and
   kiocb_invalidate_post_direct_write() triggers this message logged in
   dmesg:

     Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!

   After this we leave the page cache with stale data for the file range
   [24K, 28K), filled with zeroes instead of the data written by direct IO
   write (all bytes with a 0x01 value), so any task attempting to read with
   buffered IO, including the task that did the direct IO write, will get
   all bytes in the range with a 0x00 value instead of the written data.

Fix this by locking the range, with btrfs_lock_and_flush_ordered_range(),
at the two callers of btrfs_do_readpage() instead of doing it at
get_extent_map(), just like we did before commit ac325fc2aad5 ("btrfs: do
not hold the extent lock for entire read"), and unlocking the range after
all the calls to btrfs_do_readpage(). This way we never reuse a cached
extent map without flushing any pending ordered extents from a concurrent
direct IO write.

Fixes: ac325fc2aad5 ("btrfs: do not hold the extent lock for entire read")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 838ab2b6ed43..bdb9816bf125 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -898,7 +898,6 @@ static struct extent_map *get_extent_map(struct btrfs_inode *inode,
 					 u64 len, struct extent_map **em_cached)
 {
 	struct extent_map *em;
-	struct extent_state *cached_state = NULL;
 
 	ASSERT(em_cached);
 
@@ -914,14 +913,12 @@ static struct extent_map *get_extent_map(struct btrfs_inode *inode,
 		*em_cached = NULL;
 	}
 
-	btrfs_lock_and_flush_ordered_range(inode, start, start + len - 1, &cached_state);
 	em = btrfs_get_extent(inode, folio, start, len);
 	if (!IS_ERR(em)) {
 		BUG_ON(*em_cached);
 		refcount_inc(&em->refs);
 		*em_cached = em;
 	}
-	unlock_extent(&inode->io_tree, start, start + len - 1, &cached_state);
 
 	return em;
 }
@@ -1078,11 +1075,18 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 
 int btrfs_read_folio(struct file *file, struct folio *folio)
 {
+	struct btrfs_inode *inode = folio_to_inode(folio);
+	const u64 start = folio_pos(folio);
+	const u64 end = start + folio_size(folio) - 1;
+	struct extent_state *cached_state = NULL;
 	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ };
 	struct extent_map *em_cached = NULL;
 	int ret;
 
+	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached_state);
 	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
+	unlock_extent(&inode->io_tree, start, end, &cached_state);
+
 	free_extent_map(em_cached);
 
 	/*
@@ -2377,12 +2381,20 @@ void btrfs_readahead(struct readahead_control *rac)
 {
 	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ | REQ_RAHEAD };
 	struct folio *folio;
+	struct btrfs_inode *inode = BTRFS_I(rac->mapping->host);
+	const u64 start = readahead_pos(rac);
+	const u64 end = start + readahead_length(rac) - 1;
+	struct extent_state *cached_state = NULL;
 	struct extent_map *em_cached = NULL;
 	u64 prev_em_start = (u64)-1;
 
+	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached_state);
+
 	while ((folio = readahead_folio(rac)) != NULL)
 		btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
 
+	unlock_extent(&inode->io_tree, start, end, &cached_state);
+
 	if (em_cached)
 		free_extent_map(em_cached);
 	submit_one_bio(&bio_ctrl);
-- 
2.45.2


