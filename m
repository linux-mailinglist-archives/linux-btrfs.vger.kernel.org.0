Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234D968ED61
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 11:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjBHK6B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 05:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjBHK57 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 05:57:59 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4857F12F35
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 02:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675853877; x=1707389877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d9y+K1KNCJrWjn6zvnX0mY3KqOj6NwCi0YA+ypwIxPQ=;
  b=XyVbc3Kn0Xrtch4/kYcGyFu99xnZUcJWVsChYVZbbQSnxHXRUi1L4dOy
   5G2p/sd28as060TgXyYTETk9ygYchtavyDtAJF/PgC1rs05ly/P7EChD0
   RX1JiTfTCthwEwwpJZ3eYqsDYTalt0VpIBvVH9sLlL3S+1WlW1LFO/agY
   lZHRWjrjZCzYNtaVqSRTwfwiQJyPgJmjLUQzgqsQPKcp6C5HwzQO3k9pM
   RQnoSwHxyC89tm4/bo4fG5aPkakwNcRL66RviWxL1ReXcZG3gUQvaGY0F
   5vkqnHV6LzWMlfKERSggE4nObgcfHCA23C+TJjOuz8L3QIi7AxbILrDH6
   A==;
X-IronPort-AV: E=Sophos;i="5.97,280,1669046400"; 
   d="scan'208";a="221115626"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2023 18:57:56 +0800
IronPort-SDR: DchMWofBsyZ/HJ9xgvdSpM1fe4crThG/0ElcqO+4v2OfBpm0J9+KXj100tXqoLxNEfumI6EQ0R
 qQgbClmwLgWeYabHM2AAtGGROwRqKi0WfK4afaEbFJj74MwowLtqGb5dQv5bmAUCjEYxuLPG+5
 OWztAjymHCEey/d3iYbB60a7qC8TAQHFEKD6m9J0TKo6I94ppLZkt/J1uTLn7BMLFJEfMSCV1m
 RlXmHiogAVIDT7KJK3dc8B3ilSfLX/sJDSo1HKbEXDOhzjCcNok3penIRBvSdqCfZ6ZUgeEnGc
 HJ8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Feb 2023 02:15:12 -0800
IronPort-SDR: cdC/gtoWVgXW0nfgAQbhLImFQ7B+RP7zGDGfArTJHjXnlg64ASaI0l6jgcuKh+t+cPAqM+4p90
 BOy7vqqjWPz39z7xnUl+wnuAvFfxyg01wjm7MOcWjxFh/RQL0nNgSDwGui3q3UXK0AG/WCmuKJ
 Dcc9FA4/OzQ1w2GM1x0l4sguJ4rue6hqIa/6QoViLOq2zsJV6PYtV+d/rQrNg70jljXVXado/j
 P2zzH2R83aCzJIxOzDGHhxo8YEvHasGZ9O98iLZV4BVab1iZmJVSR47PnXKhjh5C3s9opq8iWx
 d/M=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2023 02:57:57 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 02/13] btrfs: add raid stripe tree definitions
Date:   Wed,  8 Feb 2023 02:57:39 -0800
Message-Id: <c9979f47d503ce623e9e8b8d1fb32188844c1990.1675853489.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1675853489.git.johannes.thumshirn@wdc.com>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
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

