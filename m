Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697F275EA74
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 06:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjGXETL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 00:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjGXETF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 00:19:05 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ED912A
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jul 2023 21:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690172344; x=1721708344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EOIx5R8F2C+vcy+NgP4Gc8zlL/SVADlDIopMb2F49TM=;
  b=fqbm5WnznkXcdS4qmyab6dcPlomwnHTtGgIaqLmswDM2ztF5K+AzqEk3
   nSfm7/WQbvXsPNstriJQmIVdwMb+bOnDc4mVFaGRMaQU6ShpKkAw+zCy6
   k54oy0VkjLOyiyRsP3Gx9Zg4syOOX7Pqunapzxgvsk8a00Z4OrItngh/4
   hDZJ+LQHinyMWJu6xKRScf2T1RfOcQpej2HWmky7a3eoTrdsPO68IE/d+
   fLEjZGI3hipuJ1S/pHBWLpstvzWEFn+l+BYKg4EfQG815aWF59daGC8s4
   ZLPamsHYiUdIwaxJyQA/aDqqdy9CWFkog8qgsyyORLyU+X1uuJvj+MKTC
   g==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684771200"; 
   d="scan'208";a="243524381"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2023 12:19:03 +0800
IronPort-SDR: DlRNV4z9yTjH6xhBKQVaEr+Ma0xrl8gZL9lktkl+bXnTy+aKpxTEmje3XV+2BJ4V3LQilrmvYz
 XE7VfG4bDXqmxlI8G1Fsync3TIUN0J4aafp1OkbuUoePe6mpQTRV9EjtjYC2Ou6a8eW8Tlp3/v
 RE5V2df6Fmiqj8pDaEfJZmY+oKz2Ws3R+p7Uu8twUNbVTIca5WaNJoRT5qcAEuUPYAtepUVZGO
 qZ533LgrABC5979u7qYYJl77/LoGl+SQaGdAY/sDHG+1jGYvKn0Cl/CJMnjfzdPuMyMkiuv6YK
 Jlk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jul 2023 20:27:09 -0700
IronPort-SDR: 0ibRRB1Flv2uqIkz/kS04bCGqFFJ5ZlQ/+8X2wRUwJXi3iBytvWK1bDTd1Ubl8BsmyJqg3V9dC
 zN82mNeTeZ5hd/txkCrOOQ+mczOuXSKymBzH9QviKX3UVd4oVaG4KGpX2LbBBDELyJxpPRDuPd
 l3txTeeZyYgPejP4iXA2hGhymdpmX/ieP37niUFfxS3LYmw4oWVNcQXvZktRGUCK7LUZCwVJ3E
 0x72MXG/J3GBUhhHRkaHOJDyNx/me1amCsINQSCMCdat+KBUeq6QNYuxMKvnF0BlNGPLx0a9j0
 0bo=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.123])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jul 2023 21:19:02 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 7/8] btrfs: zoned: don't activate non-DATA BG on allocation
Date:   Mon, 24 Jul 2023 13:18:36 +0900
Message-ID: <49ce7039618840211f6e06034200c7e7ba178e08.1690171333.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690171333.git.naohiro.aota@wdc.com>
References: <cover.1690171333.git.naohiro.aota@wdc.com>
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

Now that, a non-DATA block group is activated at write time. Don't activate
it on allocation time.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |  2 +-
 fs/btrfs/extent-tree.c |  8 +++++++-
 fs/btrfs/space-info.c  | 28 ----------------------------
 3 files changed, 8 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 75f8482f45e5..fc5f6b977189 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4076,7 +4076,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 
 	if (IS_ERR(ret_bg)) {
 		ret = PTR_ERR(ret_bg);
-	} else if (from_extent_allocation) {
+	} else if (from_extent_allocation && (flags & BTRFS_BLOCK_GROUP_DATA)) {
 		/*
 		 * New block group is likely to be used soon. Try to activate
 		 * it now. Failure is OK for now.
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 602cb750100c..9804e3fcc5ba 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3663,7 +3663,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	}
 	spin_unlock(&block_group->lock);
 
-	if (!ret && !btrfs_zone_activate(block_group)) {
+	/* Metadata block group is activated on write time. */
+	if (!ret && (block_group->flags & BTRFS_BLOCK_GROUP_DATA) &&
+	    !btrfs_zone_activate(block_group)) {
 		ret = 1;
 		/*
 		 * May need to clear fs_info->{treelog,data_reloc}_bg.
@@ -3843,6 +3845,10 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
 static int can_allocate_chunk_zoned(struct btrfs_fs_info *fs_info,
 				    struct find_free_extent_ctl *ffe_ctl)
 {
+	/* Block group's activeness is not a requirement for METADATA block groups. */
+	if (!(ffe_ctl->flags & BTRFS_BLOCK_GROUP_DATA))
+		return 0;
+
 	/* If we can activate new zone, just allocate a chunk and use it */
 	if (btrfs_can_activate_zone(fs_info->fs_devices, ffe_ctl->flags))
 		return 0;
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 75e7fa337e66..a84b6088a73d 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -747,18 +747,6 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		break;
 	case ALLOC_CHUNK:
 	case ALLOC_CHUNK_FORCE:
-		/*
-		 * For metadata space on zoned filesystem, reaching here means we
-		 * don't have enough space left in active_total_bytes. Try to
-		 * activate a block group first, because we may have inactive
-		 * block group already allocated.
-		 */
-		ret = btrfs_zoned_activate_one_bg(fs_info, space_info, false);
-		if (ret < 0)
-			break;
-		else if (ret == 1)
-			break;
-
 		trans = btrfs_join_transaction(root);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
@@ -770,22 +758,6 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 					CHUNK_ALLOC_FORCE);
 		btrfs_end_transaction(trans);
 
-		/*
-		 * For metadata space on zoned filesystem, allocating a new chunk
-		 * is not enough. We still need to activate the block * group.
-		 * Active the newly allocated block group by (maybe) finishing
-		 * a block group.
-		 */
-		if (ret == 1) {
-			ret = btrfs_zoned_activate_one_bg(fs_info, space_info, true);
-			/*
-			 * Revert to the original ret regardless we could finish
-			 * one block group or not.
-			 */
-			if (ret >= 0)
-				ret = 1;
-		}
-
 		if (ret > 0 || ret == -ENOSPC)
 			ret = 0;
 		break;
-- 
2.41.0

