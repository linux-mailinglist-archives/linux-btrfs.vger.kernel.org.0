Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989BD6A7E5A
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 10:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjCBJqA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 04:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjCBJp4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 04:45:56 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2221F5C0
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 01:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677750342; x=1709286342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YTeD/W4HwepwYrQ4gN7KD38BpdkOVOpFOk9Fnt+u+xs=;
  b=e8/xf110xLLIOUUi2qS5ROCPITo8K2BGj31WuqXuM5DM90XzBrxq69jK
   gcAa24eAXbnsIq2nStKlUHJiqkvhaIfiB+qy+H8fgDot8znXBBFBCFedU
   X95YahsN/d4TSwK5jwJrhrTDI23aXHLH3bw027o4Vuxe+36x6tJAGlYTz
   vQ35vlzVcSRLXiwp7Kdfq/GQgBGltkFlWXeQpnjR/8WScuDgurwxkv6h3
   v7aUmyfyLdBrI7fzNxElXRdQPZRTQEQrX+HYisWVPMJPluRBmwIFyuP3O
   k5ru1TdsN1RvkBhV8QN60AfXN5g5Pwhz69oneTF55DTRuSO5EJ7heDXUC
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="328939176"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 17:45:40 +0800
IronPort-SDR: CeEK3vJMhiil2pNssZwEoVoXTYGAPSKuKvtqQj2RZ5gKYA1rAEBzBdMEgBdCuD5QunHdetQnK4
 nO0USRXmWQu8xyqS+VdODYIH8DOWNsjr93FSbksp7qKuxWVUu1ch5R0kyJgFzvQMgI1Iekjgh0
 pLbYB11LGI/TkuqBkkt1qhMV2waPPyUuocJVfXyVTwMfdcPSyXLrvyxeuZaUuVY0X9KG/31Ziw
 PtLyPum82IWPcf/+4GskvEFtv/Y/B2QgUQn3RhsHlx7ERoGzCNNDFR1N0xckFU7ACij3iCKVeZ
 ik0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2023 00:56:44 -0800
IronPort-SDR: 8HkLDbvc9n/Me3ZbtLWYIcwwkeVddTS16ftdU8WFccPmc+3hSkDZRaBMzNM+imNOlV8R6zUGfr
 fUdDoqn8EMeRgxiLwiT4TToLXmUiIjVrW+hZMic66JbWcjbNzZqIfZw6qJjT7ZO4jn4R+eqyEH
 fMs0KkVqikjZiMXTKIQ7JhcNjSDrMfTE27X2T97SZHOgNX8/ClL9cUC2/nJJ8CYZo4CjNEONuC
 YTAR0Xflvpp/mKV90RWyzQPbKoA/VgAZRBVXf8aTR84kLrF3LzyNtNmtJ9pn59lz+JNNZUSfg1
 X9g=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Mar 2023 01:45:40 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v7 02/13] btrfs: add raid stripe tree definitions
Date:   Thu,  2 Mar 2023 01:45:24 -0800
Message-Id: <2810f6d796a2270cf8827c98cc64d9c523022e9d.1677750131.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677750131.git.johannes.thumshirn@wdc.com>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
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
2.39.1

