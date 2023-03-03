Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DBB6A9265
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 09:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjCCI2U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 03:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjCCI2T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 03:28:19 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36C61588F
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 00:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677832085; x=1709368085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zcZHvx9a6MLpkq+T5ZgBcZV/3bQjGW6lImIDe+5ExlA=;
  b=ZsAAbDFnHxsXpw/zlShiEP4ICKw3p4n77foqj9pCipdN2wt2Pa+LlG6Z
   qzXtE+QrW2FK+vCbBIfswhL0QFSy/YWmZBnWgW3vmSNjJ27kPtY7s3FVh
   DC0m6ZbNNv/8H5PORd51IMBUE+MePsI1sC/ux0ua3fiYsl0gZeJBhc2Kh
   DYkjz8TD7Xv9CcSaNXNwsdic4UcrD1YFZ/y6GrEuMrRwlFuDedmrAlWYB
   R21zTUpQa4exO5VsamYM/hpdCLGv9r2+1P/N1iZlCPJ+pmKqITlq7rz3t
   q8z5wJoYpa5zAqa9sgfjZt9f7tSB3UQ6hxGF8Z6rh+dAzTnsCre8r/WZ0
   A==;
X-IronPort-AV: E=Sophos;i="5.98,230,1673884800"; 
   d="scan'208";a="329040643"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2023 16:26:52 +0800
IronPort-SDR: vTxJpLjeo4T/h4jQByUVQsd4zZtb0QdJAxRDq7r+U9Hntp/eKtd/ixXhUeN5xgu1dtBZ2xe8un
 X/AuxvzhjCKz7nNfwGbZaT1UQKVlHePBRsTf5WrD5CHv9rFd2tHmCulWIrYWEn0UKUFS3nK0QA
 eHR3UX5x4YacKWkW4sE32MKki0SkAtwd+LnNkA4jNc657lEiRf5HyjhUioIR4VyGmJByrTbrBE
 MGQVWogqf5KmInEl4VkDNiK+HMBTRr5HXU4U0hXKRFZP74Qv+Xk7Qrn9joK9SmiTFt0urwHwQL
 b10=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2023 23:43:37 -0800
IronPort-SDR: KMVmRp2YRYOBilp7QGiVx/fI7j3796paetRnP/j5W6i1kOurRaJytMeB+Cfh/MhpZM4yRkRLyf
 8qqJDW2VeFEUEFuaaXM0uk0R8WBhWTX+cBqZ3V7+SEDaLSSeKI/3JzuzfQFv32gnCXIsKR6t6i
 wTjwfCq1NvjgP//7Mbdm9qvJB0CvYqw5cJGPToi174w3n3ShkUYaqdIqQ0zNCjUc5E0g77ZxAr
 TTgfJlVg1AygVw8hHQefvxm9+TBhAXhGacno0UQPWpvLQO181qLSPMKGqJU5zj4xgknqbUrJ+u
 dpw=
WDCIronportException: Internal
Received: from 5cg21741p5.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.181])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Mar 2023 00:26:51 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [RFC PATCH 1/2] btrfs: zoned: count fresh BG region as zone unusable
Date:   Fri,  3 Mar 2023 17:26:43 +0900
Message-Id: <ae5d21d50546abaedd89d52cefdd1c61c9018ec2.1677831912.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677831912.git.naohiro.aota@wdc.com>
References: <cover.1677831912.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The space_info->active_total_bytes is misleading. It counts not only active
block groups but also previously active but now inactive (full BGs, due to
fully written) ones. That results in a bug not counting the full BGs into
active_total_bytes.

Instead, we can count a newly allocated block group's region as
zone_unusable. Then, once that block group is activated, subtract [0
.. zone_capcity] from the zone_unusable counters. With this, the regualr
space_info's accounting code will align naturally for zone activation
support.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/free-space-cache.c |  8 +++++++-
 fs/btrfs/zoned.c            | 22 ++++++++++++++++++----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 0d250d052487..4962d7bf1e3a 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2693,8 +2693,13 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 		bg_reclaim_threshold = READ_ONCE(sinfo->bg_reclaim_threshold);
 
 	spin_lock(&ctl->tree_lock);
+	/* Count initial region as zone_unusable until it gets activated. */
 	if (!used)
 		to_free = size;
+	else if (initial &&
+		 test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &block_group->fs_info->flags) &&
+		 block_group->flags & (BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM))
+		to_free = 0;
 	else if (initial)
 		to_free = block_group->zone_capacity;
 	else if (offset >= block_group->alloc_offset)
@@ -2722,7 +2727,8 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 	reclaimable_unusable = block_group->zone_unusable -
 			       (block_group->length - block_group->zone_capacity);
 	/* All the region is now unusable. Mark it as unused and reclaim */
-	if (block_group->zone_unusable == block_group->length) {
+	if (block_group->zone_unusable == block_group->length &&
+	    block_group->alloc_offset) {
 		btrfs_mark_bg_unused(block_group);
 	} else if (bg_reclaim_threshold &&
 		   reclaimable_unusable >=
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 808cfa3091c5..848d53b1f9d5 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1580,9 +1580,19 @@ void btrfs_calc_zone_unusable(struct btrfs_block_group *cache)
 		return;
 
 	WARN_ON(cache->bytes_super != 0);
-	unusable = (cache->alloc_offset - cache->used) +
-		   (cache->length - cache->zone_capacity);
-	free = cache->zone_capacity - cache->alloc_offset;
+
+	/* Check for block groups never get activated */
+	if (test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &cache->fs_info->flags) &&
+	    cache->flags & (BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM) &&
+	    !test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &cache->runtime_flags) &&
+	    cache->alloc_offset == 0) {
+		unusable = cache->length;
+		free = 0;
+	} else {
+		unusable = (cache->alloc_offset - cache->used) +
+			   (cache->length - cache->zone_capacity);
+		free = cache->zone_capacity - cache->alloc_offset;
+	}
 
 	/* We only need ->free_space in ALLOC_SEQ block groups */
 	cache->cached = BTRFS_CACHE_FINISHED;
@@ -1901,7 +1911,11 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 
 	/* Successfully activated all the zones */
 	set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags);
-	space_info->active_total_bytes += block_group->length;
+	WARN_ON(block_group->alloc_offset != 0);
+	if (block_group->zone_unusable == block_group->length) {
+		block_group->zone_unusable = block_group->length - block_group->zone_capacity;
+		space_info->bytes_zone_unusable -= block_group->zone_capacity;
+	}
 	spin_unlock(&block_group->lock);
 	btrfs_try_granting_tickets(fs_info, space_info);
 	spin_unlock(&space_info->lock);
-- 
2.39.2

