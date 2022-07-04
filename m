Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587ED564CD9
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 06:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiGDE7B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 00:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbiGDE64 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 00:58:56 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A02726D0
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Jul 2022 21:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656910735; x=1688446735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rqvPzvggZRUsTFQpMlHe+FsZmzSbXOE57YSRsqXgEbw=;
  b=A3uVvroTpyQmUXcg27Drj8XB/x9vVyKXvifb4EmX9DJdLmb4yKBc5/ID
   398p+FYWrKKHUuqLJFPTcZh2WtRyX7xr/pRpP/X9rgnFrPDdW7deJ/B0C
   PMDuJoWSpiEPpBpMFxFBk2+oNIsJr61Hqi5R5BQnPJb/jEd9GGa5MBkIy
   73aAYlwrkMTZWXDnkItgB1EauVs37d6jvjHOgMcwSwZSybCSEPn8Gemqj
   s/ixvrVCvDXzCDYeGwIkESjru/mHhOxrGrFbUCRm8Cq6KMspI8jqgPVcF
   ROZkRhDF4RwjB/5At9x623OHiuwAe6Fgl6Xr6ZJi1i+5CPXZVQhoHhXLv
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="204732416"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 12:58:55 +0800
IronPort-SDR: AFNUwXZ8JTRPnCJqZmc/RDGUp/dJN4NSJhMBuasw3O1wj9LC05i9ERyMYvsaAgwihPx0B+Sze/
 aGx2zVxVkzfgzaKVKfrt/zRrrEk9okdtDlYr+RgoyrhXOL9GCZ3aPyD5FurflYZhQvG79U7LGE
 VVR7LMVXLD1gbMHYQv45MtJe4xdiyPLlcN5HbBWPF9d9W4IQKr6ReAmrtVQmyX4vAm0+3HfGmN
 bWG0JL0i9SlSBCS2HZJ4ejA3QGc/YMermym9U9x+AAWHGI3U71L8QdAILw5ubY28w6KufvOu0C
 43vEAs9fCoL7awagf74ysqha
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2022 21:20:48 -0700
IronPort-SDR: YsMAAnorb+sVsV/VwS2ooyg/RuOg0SVpKfHnHLMz3vPpcQnnVhJzWOP3TSUAq6ALsue3YCv4jH
 Y5usn6KhH7zD+UfhCrFxQ0VfLzQdkHXrVE0VIV0hklhNUyzzpk/4firuVkCCAIdiz2N7o9lEWb
 k/Lh7aWRYbqRybjMZEGmpDLawecqm8l6pylGeOMT/d84yXXRjXy1YUuadSY/IaRelwAyzgRtfm
 5mhIpnAjstGv1HGtQ+kA12SuqvlPs4P+QdGsvO1PkiasoNPYU0EV29pZcyUu0HgHh0Tmln2pZx
 JHA=
WDCIronportException: Internal
Received: from h5lk5s2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.53.119])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Jul 2022 21:58:56 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 12/13] btrfs: zoned: write out partially allocated region
Date:   Mon,  4 Jul 2022 13:58:16 +0900
Message-Id: <a22fe58623cd6b9d8fa3cbd3118ace0e488b651b.1656909695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1656909695.git.naohiro.aota@wdc.com>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

cow_file_range() works in an all-or-nothing way: if it fails to allocate an
extent for a part of the given region, it gives up all the region including
the successfully allocated parts. On cow_file_range(), run_delalloc_zoned()
writes data for the region only when it successfully allocate all the
region.

This all-or-nothing allocation and write-out are problematic when available
space in all the block groups are get tight with the active zone
restriction. btrfs_reserve_extent() try hard to utilize the left space in
the active block groups and gives up finally and fails with
-ENOSPC. However, if we send IOs for the successfully allocated region, we
can finish a zone and can continue on the rest of the allocation on a newly
allocated block group.

This patch implements the partial write-out for run_delalloc_zoned(). With
this patch applied, cow_file_range() returns -EAGAIN to tell the caller to
do something to progress the further allocation, and tells the successfully
allocated region with done_offset. Furthermore, the zoned extent allocator
returns -EAGAIN to tell cow_file_range() going back to the caller side.

Actually, we still need to wait for an IO to complete to continue the
allocation. The next patch implements that part.

CC: stable@vger.kernel.org # 5.16+
Fixes: afba2bc036b0 ("btrfs: zoned: implement active zone tracking")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 10 +++++++
 fs/btrfs/inode.c       | 63 ++++++++++++++++++++++++++++++++----------
 2 files changed, 59 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 62e75c1d1155..5637d1cea1c5 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3989,6 +3989,16 @@ static int can_allocate_chunk_zoned(struct btrfs_fs_info *fs_info,
 	if (ffe_ctl->max_extent_size >= ffe_ctl->min_alloc_size)
 		return -ENOSPC;
 
+	/*
+	 * Even min_alloc_size is not left in any block groups. Since we cannot
+	 * activate a new block group, allocating it may not help. Let's tell a
+	 * caller to try again and hope it progress something by writing some
+	 * parts of the region. That is only possible for data block groups,
+	 * where a part of the region can be written.
+	 */
+	if (ffe_ctl->flags & BTRFS_BLOCK_GROUP_DATA)
+		return -EAGAIN;
+
 	/*
 	 * We cannot activate a new block group and no enough space left in any
 	 * block groups. So, allocating a new block group may not help. But,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 357322da51b5..163f3d995f00 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -117,7 +117,8 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback);
 static noinline int cow_file_range(struct btrfs_inode *inode,
 				   struct page *locked_page,
 				   u64 start, u64 end, int *page_started,
-				   unsigned long *nr_written, int unlock);
+				   unsigned long *nr_written, int unlock,
+				   u64 *done_offset);
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 len, u64 orig_start, u64 block_start,
 				       u64 block_len, u64 orig_block_len,
@@ -921,7 +922,7 @@ static int submit_uncompressed_range(struct btrfs_inode *inode,
 	 * can directly submit them without interruption.
 	 */
 	ret = cow_file_range(inode, locked_page, start, end, &page_started,
-			     &nr_written, 0);
+			     &nr_written, 0, NULL);
 	/* Inline extent inserted, page gets unlocked and everything is done */
 	if (page_started) {
 		ret = 0;
@@ -1170,7 +1171,8 @@ static u64 get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
 static noinline int cow_file_range(struct btrfs_inode *inode,
 				   struct page *locked_page,
 				   u64 start, u64 end, int *page_started,
-				   unsigned long *nr_written, int unlock)
+				   unsigned long *nr_written, int unlock,
+				   u64 *done_offset)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -1363,6 +1365,21 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
 out_unlock:
+	/*
+	 * If done_offset is non-NULL and ret == -EAGAIN, we expect the
+	 * caller to write out the successfully allocated region and retry.
+	 */
+	if (done_offset && ret == -EAGAIN) {
+		if (orig_start < start)
+			*done_offset = start - 1;
+		else
+			*done_offset = start;
+		return ret;
+	} else if (ret == -EAGAIN) {
+		/* Convert to -ENOSPC since the caller cannot retry. */
+		ret = -ENOSPC;
+	}
+
 	/*
 	 * Now, we have three regions to clean up:
 	 *
@@ -1608,19 +1625,37 @@ static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
 				       u64 end, int *page_started,
 				       unsigned long *nr_written)
 {
+	u64 done_offset = end;
 	int ret;
+	bool locked_page_done = false;
 
-	ret = cow_file_range(inode, locked_page, start, end, page_started,
-			     nr_written, 0);
-	if (ret)
-		return ret;
+	while (start <= end) {
+		ret = cow_file_range(inode, locked_page, start, end, page_started,
+				     nr_written, 0, &done_offset);
+		if (ret && ret != -EAGAIN)
+			return ret;
 
-	if (*page_started)
-		return 0;
+		if (*page_started) {
+			ASSERT(ret == 0);
+			return 0;
+		}
+
+		if (ret == 0)
+			done_offset = end;
+
+		if (done_offset == start)
+			return -ENOSPC;
+
+		if (!locked_page_done) {
+			__set_page_dirty_nobuffers(locked_page);
+			account_page_redirty(locked_page);
+		}
+		locked_page_done = true;
+		extent_write_locked_range(&inode->vfs_inode, start, done_offset);
+
+		start = done_offset + 1;
+	}
 
-	__set_page_dirty_nobuffers(locked_page);
-	account_page_redirty(locked_page);
-	extent_write_locked_range(&inode->vfs_inode, start, end);
 	*page_started = 1;
 
 	return 0;
@@ -1712,7 +1747,7 @@ static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
 	}
 
 	return cow_file_range(inode, locked_page, start, end, page_started,
-			      nr_written, 1);
+			      nr_written, 1, NULL);
 }
 
 struct can_nocow_file_extent_args {
@@ -2185,7 +2220,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 						 page_started, nr_written);
 		else
 			ret = cow_file_range(inode, locked_page, start, end,
-					     page_started, nr_written, 1);
+					     page_started, nr_written, 1, NULL);
 	} else {
 		set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT, &inode->runtime_flags);
 		ret = cow_file_range_async(inode, wbc, locked_page, start, end,
-- 
2.35.1

