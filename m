Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62F8B32D83
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 12:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfFCKGI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 06:06:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:53988 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727363AbfFCKGH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 06:06:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BD2F9AF90
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2019 10:06:05 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4/4] btrfs: Don't trim returned range based on input value in find_first_clear_extent_bit
Date:   Mon,  3 Jun 2019 13:06:02 +0300
Message-Id: <20190603100602.19362-5-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603100602.19362-1-nborisov@suse.com>
References: <20190603100602.19362-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently find_first_clear_extent_bit always returns a range whose
starting value is >= passed 'start'. This implicit trimming behavior is
somewhat subtle and an implementation detail. Instead, this patch
modifies the function such that now it always returns the range which
contains passed 'start' and has the given bits unset. This range could
either be due to presence of existing records which contains 'start'
but have the bits unset or because there are no records that contain
the given starting offset.

This patch also adds test cases which cover find_first_clear_extent_bit
since they were missing up until now.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent_io.c             | 51 +++++++++++++++---
 fs/btrfs/tests/extent-io-tests.c | 89 ++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d5979558c96f..1dd900cfb7ea 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1553,8 +1553,8 @@ int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
 }
 
 /**
- * find_first_clear_extent_bit - finds the first range that has @bits not set
- * and that starts after @start
+ * find_first_clear_extent_bit - finds the first range that has @bits not set.
+ * This range could start before @start.
  *
  * @tree - the tree to search
  * @start - the offset at/after which the found extent should start
@@ -1594,12 +1594,51 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 				goto out;
 			}
 		}
+		/*
+		 * At this point 'node' either contains 'start' or start is
+		 * before 'node'
+		 */
 		state = rb_entry(node, struct extent_state, rb_node);
-		if (in_range(start, state->start, state->end - state->start + 1) &&
-			(state->state & bits)) {
-			start = state->end + 1;
+
+		if (in_range(start, state->start, state->end - state->start + 1)) {
+			if (state->state & bits) {
+				/*
+				 * |--range with bits sets--|
+				 *    |
+				 *    start
+				 */
+				start = state->end + 1;
+			} else {
+				/*
+				 * 'start' falls within a range that doesn't
+				 * have the bits set, so take its start as
+				 * the beginning of the desire range
+				 *
+				 * |--range with bits cleared----|
+				 *      |
+				 *      start
+				 */
+				*start_ret = state->start;
+				break;
+			}
 		} else {
-			*start_ret = start;
+			/*
+			 * |---prev range---|---hole/unset---|---node range---|
+			 *                          |
+			 *                        start
+			 *
+			 *                        or
+			 *
+			 * |---hole/unset--||--first node--|
+			 * 0   |
+			 *    start
+			 */
+			if (prev) {
+				state = rb_entry(prev, struct extent_state, rb_node);
+				*start_ret = state->end + 1;
+			} else {
+				*start_ret = 0;
+			}
 			break;
 		}
 	}
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 7bf4d5734dbe..36fe720fc823 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -432,6 +432,91 @@ static int test_eb_bitmaps(u32 sectorsize, u32 nodesize)
 	return ret;
 }
 
+static int test_find_first_clear_extent_bit(void)
+{
+
+	struct extent_io_tree tree;
+	u64 start, end;
+
+	test_msg("Running find_first_clear_extent_bit test");
+	extent_io_tree_init(NULL, &tree, IO_TREE_SELFTEST, NULL);
+
+	/*
+	 * Set 1m-4m alloc/discard and 32m-64m thus leaving a hole
+	 * between 4m-32m
+	 */
+	set_extent_bits(&tree, SZ_1M, SZ_4M - 1,
+			CHUNK_TRIMMED | CHUNK_ALLOCATED);
+
+
+	find_first_clear_extent_bit(&tree, SZ_512K, &start, &end,
+				    CHUNK_TRIMMED | CHUNK_ALLOCATED);
+
+	if (start != 0 || end != SZ_1M -1)
+		test_err("Error finding beginning range: start: %llu end: %llu\n",
+			 start, end);
+
+	/* Now add 32m-64m so that we have a hole between 4m-32m */
+	set_extent_bits(&tree, SZ_32M, SZ_64M - 1,
+			CHUNK_TRIMMED | CHUNK_ALLOCATED);
+
+	/*
+	 * Request first hole starting at 12m, we should get 4m-32m
+	 */
+	find_first_clear_extent_bit(&tree, 12 * SZ_1M, &start, &end,
+				    CHUNK_TRIMMED | CHUNK_ALLOCATED);
+
+	if (start != SZ_4M || end != SZ_32M - 1)
+		test_err("Error finding trimmed range: start: %llu end: %llu",
+			 start, end);
+
+	/*
+	 * Search in the middle of allocated range, should get next available,
+	 * which happens to be unallocated -> 4m-32m
+	 */
+	find_first_clear_extent_bit(&tree, SZ_2M, &start, &end,
+				    CHUNK_TRIMMED | CHUNK_ALLOCATED);
+
+	if (start != SZ_4M || end != SZ_32M -1)
+		test_err("Error finding next unalloc range: start: %llu end: %llu",
+			 start, end);
+
+	/*
+	 * Set 64M-72M with CHUNK_ALLOC flag, then search for CHUNK_TRIMMED flag
+	 * being unset in this range, we should get the entry in range 64m-72M
+	 */
+	set_extent_bits(&tree, SZ_64M, SZ_64M + SZ_8M - 1, CHUNK_ALLOCATED);
+	find_first_clear_extent_bit(&tree, SZ_64M + SZ_1M, &start, &end,
+				    CHUNK_TRIMMED);
+
+	if (start != SZ_64M || end != SZ_64M + SZ_8M - 1)
+		test_err("Error finding exact range: start: %llu end: %llu",
+			 start, end);
+
+	find_first_clear_extent_bit(&tree, SZ_64M - SZ_8M, &start, &end,
+				    CHUNK_TRIMMED);
+
+	/*
+	 * Search in the middle of set range whose immediate neighbour doesn't
+	 * have the bits set so it must be returned
+	 */
+	if (start != SZ_64M || end != SZ_64M + SZ_8M - 1)
+		test_err("Error finding next alloc range: start: %llu end: %llu",
+			 start, end);
+
+	/*
+	 * Search beyond any known range, shall return after last known range
+	 * and end should be -1
+	 */
+	find_first_clear_extent_bit(&tree, -1, &start, &end, CHUNK_TRIMMED);
+	if (start != SZ_64M+SZ_8M || end != -1)
+		test_err("Error handling beyond end of range search: start: %llu"
+			 " end: %llu\n", start, end);
+
+	return 0;
+
+}
+
 int btrfs_test_extent_io(u32 sectorsize, u32 nodesize)
 {
 	int ret;
@@ -442,6 +527,10 @@ int btrfs_test_extent_io(u32 sectorsize, u32 nodesize)
 	if (ret)
 		goto out;
 
+	ret = test_find_first_clear_extent_bit();
+	if (ret)
+		goto out;
+
 	ret = test_eb_bitmaps(sectorsize, nodesize);
 out:
 	return ret;
-- 
2.17.1

