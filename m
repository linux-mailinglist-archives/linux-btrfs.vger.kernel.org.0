Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD0B81622
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 11:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfHEJ5r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 05:57:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbfHEJ5r (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Aug 2019 05:57:47 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E7A02182B
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2019 09:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564999065;
        bh=EtgzMJSlxkGJItjh3fKGo0yonNwfWVXEmpTxnmlAvPY=;
        h=From:To:Subject:Date:From;
        b=KxXexBv4wtcMj2QvW/NaQqzLbz2eoiMrcxeD4n4ratrJVBnK8OmLg7hQAbfLqXkHt
         vmX4wT7L2NBx1yETQrGjxsDC+HTKFHKuLP4aW1OTFrFAttydKb1sWZS/ogksJ0NYRP
         DiV0dpNktwVE2GxFguUlACa6kA/mSBNE1LeUbPvQ=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: make test_find_first_clear_extent_bit fail on incorrect results
Date:   Mon,  5 Aug 2019 10:57:41 +0100
Message-Id: <20190805095741.31265-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

If any call to find_first_clear_extent_bit() returns an unexpected result,
the test should fail and not just print an error message, otherwise it
makes detection of regressions much harder to notice.

Fixes: 1eaebb341d2b41 ("btrfs: Don't trim returned range based on input value in find_first_clear_extent_bit")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

Applies on top of recent patch with subject:

  "Btrfs: fix memory leaks in the test test_find_first_clear_extent_bit"

 fs/btrfs/tests/extent-io-tests.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 705a8a7eb815..123d9a614357 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -438,6 +438,7 @@ static int test_find_first_clear_extent_bit(void)
 {
 	struct extent_io_tree tree;
 	u64 start, end;
+	int ret = -EINVAL;
 
 	test_msg("running find_first_clear_extent_bit test");
 	extent_io_tree_init(NULL, &tree, IO_TREE_SELFTEST, NULL);
@@ -452,9 +453,11 @@ static int test_find_first_clear_extent_bit(void)
 	find_first_clear_extent_bit(&tree, SZ_512K, &start, &end,
 				    CHUNK_TRIMMED | CHUNK_ALLOCATED);
 
-	if (start != 0 || end != SZ_1M -1)
+	if (start != 0 || end != SZ_1M - 1) {
 		test_err("error finding beginning range: start %llu end %llu",
 			 start, end);
+		goto out;
+	}
 
 	/* Now add 32M-64M so that we have a hole between 4M-32M */
 	set_extent_bits(&tree, SZ_32M, SZ_64M - 1,
@@ -466,9 +469,11 @@ static int test_find_first_clear_extent_bit(void)
 	find_first_clear_extent_bit(&tree, 12 * SZ_1M, &start, &end,
 				    CHUNK_TRIMMED | CHUNK_ALLOCATED);
 
-	if (start != SZ_4M || end != SZ_32M - 1)
+	if (start != SZ_4M || end != SZ_32M - 1) {
 		test_err("error finding trimmed range: start %llu end %llu",
 			 start, end);
+		goto out;
+	}
 
 	/*
 	 * Search in the middle of allocated range, should get the next one
@@ -477,9 +482,11 @@ static int test_find_first_clear_extent_bit(void)
 	find_first_clear_extent_bit(&tree, SZ_2M, &start, &end,
 				    CHUNK_TRIMMED | CHUNK_ALLOCATED);
 
-	if (start != SZ_4M || end != SZ_32M -1)
+	if (start != SZ_4M || end != SZ_32M - 1) {
 		test_err("error finding next unalloc range: start %llu end %llu",
 			 start, end);
+		goto out;
+	}
 
 	/*
 	 * Set 64M-72M with CHUNK_ALLOC flag, then search for CHUNK_TRIMMED flag
@@ -489,9 +496,11 @@ static int test_find_first_clear_extent_bit(void)
 	find_first_clear_extent_bit(&tree, SZ_64M + SZ_1M, &start, &end,
 				    CHUNK_TRIMMED);
 
-	if (start != SZ_64M || end != SZ_64M + SZ_8M - 1)
+	if (start != SZ_64M || end != SZ_64M + SZ_8M - 1) {
 		test_err("error finding exact range: start %llu end %llu",
 			 start, end);
+		goto out;
+	}
 
 	find_first_clear_extent_bit(&tree, SZ_64M - SZ_8M, &start, &end,
 				    CHUNK_TRIMMED);
@@ -500,23 +509,29 @@ static int test_find_first_clear_extent_bit(void)
 	 * Search in the middle of set range whose immediate neighbour doesn't
 	 * have the bits set so it must be returned
 	 */
-	if (start != SZ_64M || end != SZ_64M + SZ_8M - 1)
+	if (start != SZ_64M || end != SZ_64M + SZ_8M - 1) {
 		test_err("error finding next alloc range: start %llu end %llu",
 			 start, end);
+		goto out;
+	}
 
 	/*
 	 * Search beyond any known range, shall return after last known range
 	 * and end should be -1
 	 */
 	find_first_clear_extent_bit(&tree, -1, &start, &end, CHUNK_TRIMMED);
-	if (start != SZ_64M + SZ_8M || end != -1)
+	if (start != SZ_64M + SZ_8M || end != -1) {
 		test_err(
 		"error handling beyond end of range search: start %llu end %llu",
 			start, end);
+		goto out;
+	}
 
+	ret = 0;
+out:
 	clear_extent_bits(&tree, 0, (u64)-1, CHUNK_TRIMMED | CHUNK_ALLOCATED);
 
-	return 0;
+	return ret;
 }
 
 int btrfs_test_extent_io(u32 sectorsize, u32 nodesize)
-- 
2.11.0

