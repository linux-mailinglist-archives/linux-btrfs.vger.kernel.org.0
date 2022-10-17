Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9F0600E42
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 13:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiJQLzm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 07:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiJQLzj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 07:55:39 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A694B982
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 04:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666007736; x=1697543736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hf9Z+o4YR38WziKkB9Uph07xCV0Nto76Q3RiaGWWnM4=;
  b=ArKDli7u0dQmQvCKmpyBvvEUYyIUrHR/DzRM1+omycefm4ZG41KFDUqU
   C4Y2nRqpmpIZ1gBtmh9NJ2nsK22KCGXGI21nlZ13kJZp7B88DDwm3eUm+
   q3gPVjPSGMLEmYSzp1ayxRpmNdS92YKljJviB8Uju0gPzQILHA/Nb93TS
   3XCROquCHRh7G4GLwM/YrlYXpNQveG4ml2xcXJK8U2Hpfg1zpLxKlgRHK
   /9zZ3Mb6HF5KI92hTsSZ9Y6md/ruf2KJSwTQ5ALFfiyRUAu06835M6uTL
   vYuCb1s5I/x6dMaaDxU5jy6AZz/ZC2cYGWAKdQ2rNykRdbL+vkxQPVQso
   A==;
X-IronPort-AV: E=Sophos;i="5.95,191,1661788800"; 
   d="scan'208";a="212337154"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 19:55:35 +0800
IronPort-SDR: LoBlhstHrBppIRf7//BY07BxVmTeFr5XcoVBlRk3sQhE/rSkpOhv9s9j5pKNJJrpo/paJlJEHB
 UBwAs0PGIT7m2XH77lCF57Hcuh5yn0VrlN/mGvdmDgF02b6F6jMBN2Yz0jQVpIgXSMZxsE8OB9
 hpoItu+ljBEEAibidtqHSFAATHCW+GZWti4ToEWJrX31V3xQBVjcafS/eb27fAo0NBEV7JKRjm
 2shYZlf9TZ9r68UMMJBNgI57LptVeNoYI9gEm1Qs7WXjxQ33NKzTdHxwsd7RU3+qLfOeDiyE4J
 FSgdJf5V1GYDp17brjWkGr81
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2022 04:15:08 -0700
IronPort-SDR: WlRG0oubXsD1OszfGhTjTzW7vIT6TDohWto6mzugZckwr+5U1aZzfyBgVU++xrCFTg5MEzZ0VC
 vDOlnQeTB65M9AJM5Wu8P4Ra7WZl+I0Vhf/G8BtkvwCl+ZG5trqZb2xRZuVYiWrLG+SmUejrOD
 H739UTqWzkj6851eA6590tBcZS2e76n6JqKWX3Wj60MpeHK+eEfTBKK5F8Oi9XSYiqPi/+Wu+h
 lHCArTUM8chqee0iwvuLPwfjZ+5KWYxYoqjWqURoYvq/fD6OOuwySPIqQDew5W9MCGwd+Ya3dV
 kpg=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Oct 2022 04:55:35 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC v3 01/11] btrfs: add raid stripe tree definitions
Date:   Mon, 17 Oct 2022 04:55:19 -0700
Message-Id: <6ca9b49af62a15f7a3482aca3f2566cc10ce8330.1666007330.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666007330.git.johannes.thumshirn@wdc.com>
References: <cover.1666007330.git.johannes.thumshirn@wdc.com>
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
 fs/btrfs/ctree.h                | 29 +++++++++++++++++++++++++++++
 include/uapi/linux/btrfs_tree.h | 20 ++++++++++++++++++--
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 87bb4218276b..80ead27299dc 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1992,6 +1992,35 @@ BTRFS_SETGET_FUNCS(timespec_nsec, struct btrfs_timespec, nsec, 32);
 BTRFS_SETGET_STACK_FUNCS(stack_timespec_sec, struct btrfs_timespec, sec, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_timespec_nsec, struct btrfs_timespec, nsec, 32);
 
+BTRFS_SETGET_FUNCS(stripe_extent_devid, struct btrfs_stripe_extent, devid, 64);
+BTRFS_SETGET_FUNCS(stripe_extent_physical, struct btrfs_stripe_extent, physical, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_stripe_extent_devid, struct btrfs_stripe_extent, devid, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_stripe_extent_physical, struct btrfs_stripe_extent, physical, 64);
+
+static inline struct btrfs_stripe_extent *btrfs_stripe_extent_nr(
+					 struct btrfs_dp_stripe *dps, int nr)
+{
+	unsigned long offset = (unsigned long)dps;
+
+	offset += offsetof(struct btrfs_dp_stripe, extents);
+	offset += nr * sizeof(struct btrfs_stripe_extent);
+	return (struct btrfs_stripe_extent *)offset;
+}
+
+static inline u64 btrfs_stripe_extent_devid_nr(const struct extent_buffer *eb,
+					       struct btrfs_dp_stripe *dps,
+					       int nr)
+{
+	return btrfs_stripe_extent_devid(eb, btrfs_stripe_extent_nr(dps, nr));
+}
+
+static inline u64 btrfs_stripe_extent_physical_nr(const struct extent_buffer *eb,
+						  struct btrfs_dp_stripe *dps,
+						  int nr)
+{
+	return btrfs_stripe_extent_physical(eb, btrfs_stripe_extent_nr(dps, nr));
+}
+
 /* struct btrfs_dev_extent */
 BTRFS_SETGET_FUNCS(dev_extent_chunk_tree, struct btrfs_dev_extent,
 		   chunk_tree, 64);
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 5f32a2a495dc..047e1d0b2ff6 100644
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
 
@@ -56,6 +55,9 @@
 /* Holds the block group items for extent tree v2. */
 #define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
 
+/* tracks RAID stripes in block groups. */
+#define BTRFS_RAID_STRIPE_TREE_OBJECTID 12ULL
+
 /* device stats in the device tree */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
 
@@ -264,6 +266,8 @@
  */
 #define BTRFS_QGROUP_RELATION_KEY       246
 
+#define BTRFS_RAID_STRIPE_KEY		247
+
 /*
  * Obsolete name, see BTRFS_TEMPORARY_ITEM_KEY.
  */
@@ -488,6 +492,18 @@ struct btrfs_free_space_header {
 	__le64 num_bitmaps;
 } __attribute__ ((__packed__));
 
+struct btrfs_stripe_extent {
+	/* btrfs device-id this raid extent lives on */
+	__le64 devid;
+	/* physical location on disk */
+	__le64 physical;
+} __attribute__ ((__packed__));
+
+struct btrfs_dp_stripe {
+	/* array of stripe extents this stripe is composed of */
+	__DECLARE_FLEX_ARRAY(struct btrfs_stripe_extent, extents);
+} __attribute__ ((__packed__));
+
 #define BTRFS_HEADER_FLAG_WRITTEN	(1ULL << 0)
 #define BTRFS_HEADER_FLAG_RELOC		(1ULL << 1)
 
-- 
2.37.3

