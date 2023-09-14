Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F197A0A58
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 18:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241641AbjINQHP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 12:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241822AbjINQHK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 12:07:10 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FC22114;
        Thu, 14 Sep 2023 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694707624; x=1726243624;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=yig7ZYZ9K8+Q6gaqvbyj//qu2/U7MXP1hMerBHoL1fQ=;
  b=UZuuydUp0IS88mC3nyNJZ3buCGDEbyddC9lS7SKEvasojAAnIPpASXIx
   iYyMjYWWeyXSklCskGgGfg+7dcSVrVT9MMXZQVMujKyR5Q86vTwT6p1vL
   JcY16DsRNUYOeQCwS3AU01XsK/rywKpFBg9RY4PCzwtXFhtntXlF4FlIv
   T7R0K60LI3pdJU7suhVQF58IupRTbepOCfU7E6Wl4QQkhSUPHPbVImu7/
   qUe5rYw5lfHJDByEgK3zPzm8VwddbF2ifw92aHwBoFJdp/av3Z0+xLKfN
   5FldMk6rGorZvuc64NyIslgtM0+he3hsEaHCUnLoJKIbE+cE7ewcx9RGB
   g==;
X-CSE-ConnectionGUID: Oq6kqQ9xTHqTkLidpu+IHw==
X-CSE-MsgGUID: 6b046WrKR6SGOepNmxysbg==
X-IronPort-AV: E=Sophos;i="6.02,146,1688400000"; 
   d="scan'208";a="248490527"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 00:07:04 +0800
IronPort-SDR: d8sZR2K5C4RiTHJxWFO03PXgNqLIyAbaIfs1BGzhHQpxO90mj0ZT6h93Oxucz4cR9MaDYDZYL1
 EopFsfqwStvBshvZTBR4BqU+KOhqXNzEqf+opXXWhx+GBEwLn92pvUWL4zmNXj37QCB9E7c3+p
 a9Sw9B83xDNCYkjxws1KkUQal58/BWjxTdjXKH39tzytVhmo/PIHntsMk3aTAA53MMrRmaMUtz
 oXN3+Xh7cWxtipernJEK0rXXk2PRVwkk4PdNyDHGu9rbPe44iDSeQ2d+LxAp0fDNYxr0mAQItk
 XvQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 08:14:05 -0700
IronPort-SDR: d4BGto01G7yzNL8AbiuA/U+KaKuQ+zjOs9i9moHzhV9pOOh/0LkBd3FIgbOtxEpyqbya2mx8HB
 gnbqY1aZExcaokfwqDHecWBHUhUht/hUzAa6tJCZTSfovAvBV51T0DIfujpDnGEYYU/P+pmGdS
 EZW1Gaz8NSL0EABd9ADKpdZDofZ47yurdt2sNd4VCugyTBjF2eBgAq8Fm0gWYiIkPrQ0fjUx98
 +ihBS17KxqEtJK6unhPIEGLGxNSNRKdGDGVXbi48ZgM0BqUpMPJypaUhDsXiNlFGiVVI2vTe5R
 TqI=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Sep 2023 09:07:04 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Thu, 14 Sep 2023 09:06:56 -0700
Subject: [PATCH v9 01/11] btrfs: add raid stripe tree definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-raid-stripe-tree-v9-1-15d423829637@wdc.com>
References: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
In-Reply-To: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707621; l=4184;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=yig7ZYZ9K8+Q6gaqvbyj//qu2/U7MXP1hMerBHoL1fQ=;
 b=T2aI+H2ePlmrUB4XIWgfPXkzlHXUBMZ0knml0Vm/qH4n46fEcOOEKJ8TnRfcxlFIbyLARA4d3
 u/+FMs15Y4PAxnbpGtXHk80f+rIxztIDl3stCsIEXzVB4oFq3TVKZ2V
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
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
 fs/btrfs/accessors.h            | 10 ++++++++++
 fs/btrfs/locking.c              |  1 +
 include/uapi/linux/btrfs_tree.h | 31 +++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index f958eccff477..977ff160a024 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -306,6 +306,16 @@ BTRFS_SETGET_FUNCS(timespec_nsec, struct btrfs_timespec, nsec, 32);
 BTRFS_SETGET_STACK_FUNCS(stack_timespec_sec, struct btrfs_timespec, sec, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_timespec_nsec, struct btrfs_timespec, nsec, 32);
 
+BTRFS_SETGET_FUNCS(stripe_extent_encoding, struct btrfs_stripe_extent, encoding, 8);
+BTRFS_SETGET_FUNCS(raid_stride_devid, struct btrfs_raid_stride, devid, 64);
+BTRFS_SETGET_FUNCS(raid_stride_physical, struct btrfs_raid_stride, physical, 64);
+BTRFS_SETGET_FUNCS(raid_stride_length, struct btrfs_raid_stride, length, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_stripe_extent_encoding,
+			 struct btrfs_stripe_extent, encoding, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_raid_stride_devid, struct btrfs_raid_stride, devid, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_raid_stride_physical, struct btrfs_raid_stride, physical, 64);
+BTRFS_SETGET_STACK_FUNCS(stack_raid_stride_length, struct btrfs_raid_stride, length, 64);
+
 /* struct btrfs_dev_extent */
 BTRFS_SETGET_FUNCS(dev_extent_chunk_tree, struct btrfs_dev_extent, chunk_tree, 64);
 BTRFS_SETGET_FUNCS(dev_extent_chunk_objectid, struct btrfs_dev_extent,
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 6ac4fd8cc8dc..74d8e2003f58 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -74,6 +74,7 @@ static struct btrfs_lockdep_keyset {
 	{ .id = BTRFS_UUID_TREE_OBJECTID,	DEFINE_NAME("uuid")	},
 	{ .id = BTRFS_FREE_SPACE_TREE_OBJECTID,	DEFINE_NAME("free-space") },
 	{ .id = BTRFS_BLOCK_GROUP_TREE_OBJECTID, DEFINE_NAME("block-group") },
+	{ .id = BTRFS_RAID_STRIPE_TREE_OBJECTID, DEFINE_NAME("raid-stripe") },
 	{ .id = 0,				DEFINE_NAME("tree")	},
 };
 
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index fc3c32186d7e..6d9c43416b6e 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -73,6 +73,9 @@
 /* Holds the block group items for extent tree v2. */
 #define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
 
+/* Tracks RAID stripes in block groups. */
+#define BTRFS_RAID_STRIPE_TREE_OBJECTID 12ULL
+
 /* device stats in the device tree */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
 
@@ -261,6 +264,8 @@
 #define BTRFS_DEV_ITEM_KEY	216
 #define BTRFS_CHUNK_ITEM_KEY	228
 
+#define BTRFS_RAID_STRIPE_KEY	230
+
 /*
  * Records the overall state of the qgroups.
  * There's only one instance of this key present,
@@ -719,6 +724,32 @@ struct btrfs_free_space_header {
 	__le64 num_bitmaps;
 } __attribute__ ((__packed__));
 
+struct btrfs_raid_stride {
+	/* The btrfs device-id this raid extent lives on */
+	__le64 devid;
+	/* The physical location on disk */
+	__le64 physical;
+	/* The length of stride on this disk */
+	__le64 length;
+} __attribute__ ((__packed__));
+
+/* The stripe_extent::encoding, 1:1 mapping of enum btrfs_raid_types */
+#define BTRFS_STRIPE_RAID0	1
+#define BTRFS_STRIPE_RAID1	2
+#define BTRFS_STRIPE_DUP	3
+#define BTRFS_STRIPE_RAID10	4
+#define BTRFS_STRIPE_RAID5	5
+#define BTRFS_STRIPE_RAID6	6
+#define BTRFS_STRIPE_RAID1C3	7
+#define BTRFS_STRIPE_RAID1C4	8
+
+struct btrfs_stripe_extent {
+	__u8 encoding;
+	__u8 reserved[7];
+	/* An array of raid strides this stripe is composed of */
+	struct btrfs_raid_stride strides[];
+} __attribute__ ((__packed__));
+
 #define BTRFS_HEADER_FLAG_WRITTEN	(1ULL << 0)
 #define BTRFS_HEADER_FLAG_RELOC		(1ULL << 1)
 

-- 
2.41.0

