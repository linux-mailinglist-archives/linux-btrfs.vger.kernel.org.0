Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334C1697E6B
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 15:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBOOd7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 09:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBOOd6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 09:33:58 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABF638EA5
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 06:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676471623; x=1708007623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=48Cmk2aOaGJS0a991MSx59EPyaPSJ4uYMqgpkcDU7Zo=;
  b=DC6YGmA8w8LR7Uos1iljlf9bWtBjo3SrXUVoEBoVXL6QEZk3OKKkKB7U
   ZaCfrrMCSI5kMPs4x9B6u4HwuZPsiGm6ux2NVXSPrgwuv4s93wehFHNAj
   1icyfWsLMMClYYRyPPCQHYN/LqzJJ1LqPfq6hF8SFtsUNskAhZE3YZGHG
   TR0rlfLVLin48aXX0qO6N6ClsIpmCoGNFPpg9izxU39Bo+DAf7+/qWbDk
   P+qlDqZpvYZE10pV3CfVQkDoojVKAOPaAJ1UevC3g3bFYeU0IyoAKZZG6
   dMipf+wE+BFTP1WOc0qdALMjntT7uTMrR0DH/w486PSCqsR4XtCRGeijP
   w==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669046400"; 
   d="scan'208";a="223394064"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 22:33:41 +0800
IronPort-SDR: d/1ay7bnWicEs7Zyp8NrC0gHrIQEXZ53wl989kAXUiUh3LDmcbc2VBlVRiBfztnMNyt68Ko9xU
 LKtQyKvZiUkJiX1+oOKqP3/3fMVOY2nZy13YWdgOKWFVOO0HzSMT52xSOkPRobdZy26RVoJ7Qi
 0RRFkkZ2l2/JLHfQ+9zZXLVjOzMf89AfzX14LnXJKB+s7Sa38Irqph8NzDxkd1UPLJ74Hf7+hv
 7mcpdKhHIqb/MCQFS9NY/ZDzxqg4sDcSmGL3u0G1y/pa31B6jYHYxHTnxogfTaqcdX09f9bl/X
 +dU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2023 05:45:03 -0800
IronPort-SDR: eIzhOwmbAGzVP8qMBOjrXlu1z+d6xX1C2ke0FAmYFnVNeISXpe2owMjueV2t7AC0Vh+ttkPp6P
 bmqYEDH9V50mHYxuEEaUpF0yyxZsgY+Zp3+1qQJF1qYqCsEkqRBPnVju+LWaeMAeG2yNhOLGF6
 3heSFW3leoCR4P3cTHaxOwfaru4MCX97Xcp0qEW4Uck953hqYrcblW+e6jwlGDX1YmhWbzmk9t
 1HpXPLu2CtXSZ7O+CGz2LJvrjSVCX/KVZoV7gE6tbFyF/lYE/0uuAHUNTUVoq7kA1Py46mxKZ8
 N9E=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Feb 2023 06:33:41 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v6 02/13] btrfs: add raid stripe tree definitions
Date:   Wed, 15 Feb 2023 06:33:23 -0800
Message-Id: <3b9e1dba6f3249434a617a56f1af010d9d3d4df5.1676470614.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1676470614.git.johannes.thumshirn@wdc.com>
References: <cover.1676470614.git.johannes.thumshirn@wdc.com>
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

Add definitions for the raid stripe tree. This tree will hold information
about the on-disk layout of the stripes in a RAID set.

Each stripe extent has a 1:1 relationship with an on-disk extent item and
is doing the logical to per-drive physical address translation for the
extent item in question.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/accessors.h            | 29 +++++++++++++++++++++++++++++
 include/uapi/linux/btrfs_tree.h | 20 ++++++++++++++++++--
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index ceadfc5d6c66..6e753b63faae 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -306,6 +306,35 @@ BTRFS_SETGET_FUNCS(timespec_nsec, struct btrfs_timespec, nsec, 32);
 BTRFS_SETGET_STACK_FUNCS(stack_timespec_sec, struct btrfs_timespec, sec, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_timespec_nsec, struct btrfs_timespec, nsec, 32);
 
+BTRFS_SETGET_FUNCS(raid_stride_devid, struct btrfs_raid_stride, devid, 64);
+BTRFS_SETGET_FUNCS(raid_stride_physical, struct btrfs_raid_stride, physical, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_raid_stride_devid, struct btrfs_raid_stride, devid, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_raid_stride_physical, struct btrfs_raid_stride, physical, 64);
+
+static inline struct btrfs_raid_stride *btrfs_raid_stride_nr(
+					 struct btrfs_stripe_extent *dps, int nr)
+{
+	unsigned long offset = (unsigned long)dps;
+
+	offset += offsetof(struct btrfs_stripe_extent, strides);
+	offset += nr * sizeof(struct btrfs_raid_stride);
+	return (struct btrfs_raid_stride *)offset;
+}
+
+static inline u64 btrfs_raid_stride_devid_nr(const struct extent_buffer *eb,
+					       struct btrfs_stripe_extent *dps,
+					       int nr)
+{
+	return btrfs_raid_stride_devid(eb, btrfs_raid_stride_nr(dps, nr));
+}
+
+static inline u64 btrfs_raid_stride_physical_nr(const struct extent_buffer *eb,
+						  struct btrfs_stripe_extent *dps,
+						  int nr)
+{
+	return btrfs_raid_stride_physical(eb, btrfs_raid_stride_nr(dps, nr));
+}
+
 /* struct btrfs_dev_extent */
 BTRFS_SETGET_FUNCS(dev_extent_chunk_tree, struct btrfs_dev_extent, chunk_tree, 64);
 BTRFS_SETGET_FUNCS(dev_extent_chunk_objectid, struct btrfs_dev_extent,
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index ab38d0f411fa..64e6bf2a10d8 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -4,9 +4,8 @@
 
 #include <linux/btrfs.h>
 #include <linux/types.h>
-#ifdef __KERNEL__
 #include <linux/stddef.h>
-#else
+#ifndef __KERNEL__
 #include <stddef.h>
 #endif
 
@@ -73,6 +72,9 @@
 /* Holds the block group items for extent tree v2. */
 #define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
 
+/* tracks RAID stripes in block groups. */
+#define BTRFS_RAID_STRIPE_TREE_OBJECTID 12ULL
+
 /* device stats in the device tree */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
 
@@ -281,6 +283,8 @@
  */
 #define BTRFS_QGROUP_RELATION_KEY       246
 
+#define BTRFS_RAID_STRIPE_KEY		247
+
 /*
  * Obsolete name, see BTRFS_TEMPORARY_ITEM_KEY.
  */
@@ -715,6 +719,18 @@ struct btrfs_free_space_header {
 	__le64 num_bitmaps;
 } __attribute__ ((__packed__));
 
+struct btrfs_raid_stride {
+	/* btrfs device-id this raid extent lives on */
+	__le64 devid;
+	/* physical location on disk */
+	__le64 physical;
+};
+
+struct btrfs_stripe_extent {
+	/* array of raid strides this stripe is composed of */
+	__DECLARE_FLEX_ARRAY(struct btrfs_raid_stride, strides);
+};
+
 #define BTRFS_HEADER_FLAG_WRITTEN	(1ULL << 0)
 #define BTRFS_HEADER_FLAG_RELOC		(1ULL << 1)
 
-- 
2.39.0

