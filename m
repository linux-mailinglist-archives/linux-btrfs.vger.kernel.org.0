Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A0D75C004
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 09:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjGUHmj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 03:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjGUHmf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 03:42:35 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976342D54
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 00:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689925343; x=1721461343;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6Fvg1M5TtOIY/qUav+CbuFlwMrJjR9nnBu/t0NtiQQo=;
  b=NPZt7VIcusE1YAOu8bHul/JhkxomjZ8/NWYN9/T8WQUztp89mx2xoYV0
   jn4Y/HJnVBViNocNXNA7tVatGtk7sFzwgD0hRAWjLfefcPVTYROsp9Ksw
   DVCAjgRn6RwH7mTnGSAr7Ud/JlTXtVl0qsVCAz6dN/yJmfzvRhTNmfM1+
   BKfWDIOxUdb3bMVi3tOrQlrE8KPnl25tO15FqQTuLdhuY9rHyU9iL4kfQ
   E+s1PQQJS2skS0SX216fY9fGLqfO62UizRwKcW1jbA9JWUffh3eUQ7Jty
   fz3cDG+4bSpW3ANg8Zd12taKZysFCSgXEICeAOhBPxkVU9uFmzMRivt25
   w==;
X-IronPort-AV: E=Sophos;i="6.01,220,1684771200"; 
   d="scan'208";a="238478410"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2023 15:42:22 +0800
IronPort-SDR: sb59gX1X442cK43JP/2tZzbzdTy1xNDhvXM7CQtQUGeVP8jrd/hZDfRc8iC4NtvqOVx9GkRFhi
 pf1OiKcUdDVnWu0nW0J20JoPunwr0+lFER0agr5Y6WHxFYqv7M8Au9ycAk/XYnxguCAUH0h01Z
 R5qBL1aZS8GqaUmCH7wsMvhkS5aolLdkpxxSDEhJTvXS8xlwtOw3yp4qJzWLJKdjtJFSEBfqSg
 Ywu/JMulVuFKsZLJEnLY3UACLup5eMP0tlnkreOoiAs4nKLPVpO2gN56i1RpvPkVnqpcCNONvw
 X+U=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jul 2023 23:50:31 -0700
IronPort-SDR: uqw5+3H9ShvonazKaPnceu73raD2dcKip1/uhIjxm27SayDySzKrSpTYHXIilClUgdRtUTk74A
 gbZ3sQQpQGiHfV0FajiMA9sXguM2fyFBBYPXDp1blYoOo8amHBU4soxyCAteoEYoiXXLWcXtYm
 D2I3ge9OnmpwleleK213D1vzoeMjmfY/dMUKe7LvEk896+onY2wDFpDlsCE/HTw0W8RZU6w2si
 X5DeNCRy3fAEX+9OdjPqdyMQuCFDe0H7z3Y/tMYORDbsbdaGlZ1Boi/8tEwhuXKups4W7oFZM6
 L4Q=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.119])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jul 2023 00:42:20 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2] btrfs: zoned: do not zone finish data relocation block group
Date:   Fri, 21 Jul 2023 16:42:14 +0900
Message-ID: <a57f943e28a5bd86cddcf9d0839b124880f2f6c7.1689924624.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When multiple writes happen at once, we may need to sacrifice a currently
active block group to be zone finished for a new allocation. We choose a
block group with the least free space left, and zone finish it.

To do the finishing, we need to send IOs for already allocated region
and wait for them and on-going IOs. Otherwise, these IOs fail because the
zone is already finished at the time the IO reach a device.

However, if a block group dedicated to the data relocation is zone
finished, there is a chance that finishing it before an ongoing write IO
reaches the device. That is because there is timing gap between an
allocation is done (block_group->reservations == 0, as pre-allocation is
done) and an ordered extent is created when the relocation IO starts.
Thus, if we finish the zone between them, we can fail the IOs.

We cannot simply use "fs_info->data_reloc_bg == block_group->start" to
avoid the zone finishing. Because, the data_reloc_bg may already switch to
a new block group, while there are still ongoing write IOs to the old
data_reloc_bg.

So, this patch reworks the BLOCK_GROUP_FLAG_ZONED_DATA_RELOC bit to
indicate there is a data relocation allocation and/or ongoing write to the
block group. The bit is set on allocation and cleared in end_io function of
the last IO for the currently allocated region.

To change the timing of the bit setting also solves the issue that the bit
being left even after there is no IO going on. With the current code, if
the data_reloc_bg switches after the last IO to the current data_reloc_bg,
the bit is set at this timing and there is no one clearing that bit. As a
result, that block group is kept unallocatable for anything.

Fixes: 343d8a30851c ("btrfs: zoned: prevent allocation from previous data relocation BG")
Fixes: 74e91b12b115 ("btrfs: zoned: zone finish unused block group")
CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 44 +++++++++++++++++++++++-------------------
 fs/btrfs/zoned.c       | 18 ++++++++++++++---
 2 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 04ceb9d25d3e..602cb750100c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3687,7 +3687,8 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	       fs_info->data_reloc_bg == 0);
 
 	if (block_group->ro ||
-	    test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &block_group->runtime_flags)) {
+	    (!ffe_ctl->for_data_reloc &&
+	     test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &block_group->runtime_flags))) {
 		ret = 1;
 		goto out;
 	}
@@ -3730,8 +3731,27 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	if (ffe_ctl->for_treelog && !fs_info->treelog_bg)
 		fs_info->treelog_bg = block_group->start;
 
-	if (ffe_ctl->for_data_reloc && !fs_info->data_reloc_bg)
-		fs_info->data_reloc_bg = block_group->start;
+	if (ffe_ctl->for_data_reloc) {
+		if (!fs_info->data_reloc_bg)
+			fs_info->data_reloc_bg = block_group->start;
+		/*
+		 * Do not allow allocations from this block group, unless it is
+		 * for data relocation. Compared to increasing the ->ro, setting
+		 * the ->zoned_data_reloc_ongoing flag still allows nocow
+		 * writers to come in. See btrfs_inc_nocow_writers().
+		 *
+		 * We need to disable an allocation to avoid an allocation of
+		 * regular (non-relocation data) extent. With mix of relocation
+		 * extents and regular extents, we can dispatch WRITE commands
+		 * (for relocation extents) and ZONE APPEND commands (for
+		 * regular extents) at the same time to the same zone, which
+		 * easily break the write pointer.
+		 *
+		 * Also, this flag avoids this block group to be zone finished.
+		 */
+		set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
+			&block_group->runtime_flags);
+	}
 
 	ffe_ctl->found_offset = start + block_group->alloc_offset;
 	block_group->alloc_offset += num_bytes;
@@ -3749,24 +3769,8 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 out:
 	if (ret && ffe_ctl->for_treelog)
 		fs_info->treelog_bg = 0;
-	if (ret && ffe_ctl->for_data_reloc &&
-	    fs_info->data_reloc_bg == block_group->start) {
-		/*
-		 * Do not allow further allocations from this block group.
-		 * Compared to increasing the ->ro, setting the
-		 * ->zoned_data_reloc_ongoing flag still allows nocow
-		 *  writers to come in. See btrfs_inc_nocow_writers().
-		 *
-		 * We need to disable an allocation to avoid an allocation of
-		 * regular (non-relocation data) extent. With mix of relocation
-		 * extents and regular extents, we can dispatch WRITE commands
-		 * (for relocation extents) and ZONE APPEND commands (for
-		 * regular extents) at the same time to the same zone, which
-		 * easily break the write pointer.
-		 */
-		set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &block_group->runtime_flags);
+	if (ret && ffe_ctl->for_data_reloc)
 		fs_info->data_reloc_bg = 0;
-	}
 	spin_unlock(&fs_info->relocation_bg_lock);
 	spin_unlock(&fs_info->treelog_bg_lock);
 	spin_unlock(&block_group->lock);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index b43c4536e685..5e4285ae112c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2006,6 +2006,11 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 	 * and block_group->meta_write_pointer for metadata.
 	 */
 	if (!fully_written) {
+		if (test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
+			     &block_group->runtime_flags)) {
+			spin_unlock(&block_group->lock);
+			return -EAGAIN;
+		}
 		spin_unlock(&block_group->lock);
 
 		ret = btrfs_inc_block_group_ro(block_group, false);
@@ -2034,7 +2039,9 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 			return 0;
 		}
 
-		if (block_group->reserved) {
+		if (block_group->reserved ||
+		    test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
+			     &block_group->runtime_flags)) {
 			spin_unlock(&block_group->lock);
 			btrfs_dec_block_group_ro(block_group);
 			return -EAGAIN;
@@ -2265,7 +2272,10 @@ void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u64 logica
 
 	/* All relocation extents are written. */
 	if (block_group->start + block_group->alloc_offset == logical + length) {
-		/* Now, release this block group for further allocations. */
+		/*
+		 * Now, release this block group for further allocations
+		 * and zone finish.
+		 */
 		clear_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
 			  &block_group->runtime_flags);
 	}
@@ -2289,7 +2299,9 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info)
 
 		spin_lock(&block_group->lock);
 		if (block_group->reserved || block_group->alloc_offset == 0 ||
-		    (block_group->flags & BTRFS_BLOCK_GROUP_SYSTEM)) {
+		    (block_group->flags & BTRFS_BLOCK_GROUP_SYSTEM) ||
+		    test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
+			     &block_group->runtime_flags)) {
 			spin_unlock(&block_group->lock);
 			continue;
 		}
-- 
2.41.0

