Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD77564CD7
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 06:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiGDE64 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 00:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiGDE6v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 00:58:51 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687E326D0
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Jul 2022 21:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656910729; x=1688446729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yfKfnFBF+lXgNVs1kpIXSL42zx5+0j29bNRAKN8Z1EM=;
  b=Vx4ZCLoFvG+7Z4jX80Y6kgG40+nQqLZI54+O8FJKgZlHZdf+nl/aIQl0
   Rwt93DXbef7m2QckvxdLtSro2u/F2TafP3+mvJDZKBVde344ABdYgAQM4
   qYhtB+IwE2nIvoBtam7xslOaxK00rd/3M7IXnbGMBbeAW4IOPgyPeqZaY
   BK7KlSf9PXoAAXt4LRgF5JQFH9rVMuK8hWxdWDSw6kPs4/SMPvNfMlTTH
   ASvQlX0NAsVpPzzA7pcN+aXJ/DEffjBWtYt2lf3VtskOLZesChP7SMEXD
   bpyFPakt+tU/qSySxf8ypLe7MD1GCgvQ2TCIuEpiX+0yDCrNwRkBsj466
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="204732403"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 12:58:49 +0800
IronPort-SDR: ggkL+KlqWMzv4ZvcAVx8csdXD5b18luyP/JHMCraGrTVMpGMk5+cCG99LFczq3TCTNa2OieE13
 OarVssXdA0zewxDCSY01a8Csyyjpul4+ONgCS4P6sMwjPhYKkpmuF5up4jwA4KDZVydtw/smsw
 EUJXu0L5N1YoVG71Lt/WOMy0vU6bnMSlOwE6V8P7WUtcCVO4H4u8TbVRDovFib7YMoM6mgkfGb
 sxJpK9DPKAufPfz+1UybVTbrARTgqFBBSizCVyW1+AHkGtjdvsqSMElHvLpX5pNBN0myjcM47R
 2esOXkyr5irlu1YRhbN3aqXx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2022 21:20:42 -0700
IronPort-SDR: 6R9zdRgwOXiynvFkCW7wE9wZXN02r2mVvRgcfA95XYPUF5UAoMCDqpZbL73v/TldkF4yHsvGeM
 D6/rjQUUtdNdazV8P0hxFDWsJ55BHfLiWlLOipT3UXSb8Vv5SE3NB+jF3WlV+zdUSMHGcGElwm
 OZ3ZdeGxGPsueSBp5eAnlXnN1ZhO0SSZbKOkM5zqP10VYh8NQQopiuksUuZf1Zk7dQzFjHoVei
 vHjhDSOF3TYZgRflA1AfX6Dn4423zyuG08lsTLc7OT9OQZ25Pxd9JhIDFDJX/APk8hqDlBV00Y
 PaY=
WDCIronportException: Internal
Received: from h5lk5s2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.53.119])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Jul 2022 21:58:50 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 05/13] btrfs: use fs_info->max_extent_size in get_extent_max_capacity()
Date:   Mon,  4 Jul 2022 13:58:09 +0900
Message-Id: <81fdc87b1b820d1d1bb54d3d2c24b085590ed506.1656909695.git.naohiro.aota@wdc.com>
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

Use fs_info->max_extent_size also in get_extent_max_capacity() for the
completeness. This is only used for defrag and not really necessary to fix
the metadata reservation size. But, it still suppresses unnecessary defrag
operations.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ioctl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7e1b4b0fbd6c..37480d4e6443 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1230,16 +1230,18 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
 	return em;
 }
 
-static u32 get_extent_max_capacity(const struct extent_map *em)
+static u32 get_extent_max_capacity(struct btrfs_fs_info *fs_info,
+				   const struct extent_map *em)
 {
 	if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags))
 		return BTRFS_MAX_COMPRESSED;
-	return BTRFS_MAX_EXTENT_SIZE;
+	return fs_info->max_extent_size;
 }
 
 static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
 				     u32 extent_thresh, u64 newer_than, bool locked)
 {
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map *next;
 	bool ret = false;
 
@@ -1263,7 +1265,7 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
 	 * If the next extent is at its max capacity, defragging current extent
 	 * makes no sense, as the total number of extents won't change.
 	 */
-	if (next->len >= get_extent_max_capacity(em))
+	if (next->len >= get_extent_max_capacity(fs_info, em))
 		goto out;
 	/* Skip older extent */
 	if (next->generation < newer_than)
@@ -1400,6 +1402,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 				  bool locked, struct list_head *target_list,
 				  u64 *last_scanned_ret)
 {
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	bool last_is_target = false;
 	u64 cur = start;
 	int ret = 0;
@@ -1484,7 +1487,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		 * Skip extents already at its max capacity, this is mostly for
 		 * compressed extents, which max cap is only 128K.
 		 */
-		if (em->len >= get_extent_max_capacity(em))
+		if (em->len >= get_extent_max_capacity(fs_info, em))
 			goto next;
 
 		/*
-- 
2.35.1

