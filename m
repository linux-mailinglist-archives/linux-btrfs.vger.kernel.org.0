Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64464645C62
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 15:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiLGOXG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 09:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiLGOWd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 09:22:33 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582CE5C77D
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 06:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670422948; x=1701958948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xLkIvW/cIPcN0iloSD6OpmuJtJYVhiqnfrgY4PIbvng=;
  b=Q1yCXTGLbvI1JcsqSN/7FKf45jqWEu1YOwISRjkt7tKqjycUb6bW6N0u
   yOrrHSWwCstRfz1QL7Tz/XPdwFcgOBIM5LHL+wG8WldISy0VaHwgdgyOS
   DSw3ueId2fDd27p2nXRBxU+pATl0KwQhBMAFRaWoGLKohNPxSfKbhKXGi
   T/dbKV8syGho6dS01rCUiEHV4eSw5fK64ct9dHYKG+EcnT4mRt40KzIZH
   kfksDbF+M5oDEdVZCkTQR8t7yLHURbNVdNJFLnQYQdcQuWFyDu2IoyPfj
   JanwejZxEKZUfLzw99KGeqYBYSaZokLF9tli6UAzWCEHZN7zO+j3JiFkw
   g==;
X-IronPort-AV: E=Sophos;i="5.96,225,1665417600"; 
   d="scan'208";a="218099475"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2022 22:22:28 +0800
IronPort-SDR: 0GMSidiFgJi4fXF+vUcNJPEGAxUNe6S9FjfIhIB2qu84lQQAXKZeVHYLwRJDmASnnxJusG9KXc
 UlbbhZFZ/E0ULFwoFcVxF3qLBHJX58jZJAf4K9Lm+ZdvgYwlHAwVLREgYWiKTA9Rx2YsSHfOXt
 MRvDY9MhPa4pcL0aL+Gbn404zrwgM9XprOkLJcAbfDdSG6ZO6y1vlsdBuU9EOQesMvmskqAhy+
 Dhvv+g9YXEVFsbv0WLxKt7cZPKroHZWtTte3ML8JPx3uBh86kC8CJ6RJ/tP6kalbSVq4Rxdgdg
 ehU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2022 05:35:14 -0800
IronPort-SDR: 1VpqRpnnYoKWSor4BhTCkcRp/HagZ9C+tT2ByUP77IxfaveqVazXkjm5zO+n2pm20ccJRRA9O3
 zgYS0uYXhvK9bUh/pFqQEMaF2aduDBQd0GR7QVZN9x4pw21OTz2agXxXhYovXq5kvwe0gJPdQV
 aed6Dyakic5Ff8T1TXsAV0EyN07VudsNruOflbH2jWGVd7J5Rqdy5aeBQRocZ8lzXO5+J6RBFp
 H4LoNsW2OjAG4iizw8YdbQ57ZlzbdhAxjx4NuMcybL43yVgg5BQvcB+u0+af9yOo43xuhYtfm6
 jbE=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Dec 2022 06:22:27 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH v4 1/9] btrfs: add raid stripe tree definitions
Date:   Wed,  7 Dec 2022 06:22:10 -0800
Message-Id: <18a27434a3ceda58050c660fdc412b5c8d576665.1670422590.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1670422590.git.johannes.thumshirn@wdc.com>
References: <cover.1670422590.git.johannes.thumshirn@wdc.com>
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
2.38.1

