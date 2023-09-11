Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7A679BDC6
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 02:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356017AbjIKWCk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237462AbjIKMwa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 08:52:30 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06433CEB;
        Mon, 11 Sep 2023 05:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694436746; x=1725972746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rko1kr0Bp04UELCy7Ta/M1dYbKfLv8H02oeXzXTMR18=;
  b=G6Jp+5993tk4PQ0GWVI8W1odlT1YtGvSXmi+OhRqNBgJc9piQ85LIJvP
   wCTFkIxs9uv+CgsQCEzNJkTfnaM84xo5aOrJh1gP7zb4BoWJd5U3lVLDx
   ix+ezGj24m38jg2wq54/zHg6g/Ibj7r5eYqsSE6MMjJvZ2yYt4ldqpYwm
   n0DxlnERyQBOFi8oiSUAKEOATUqyOUnopCI8wZFb0PRotN7r+e4StXTPe
   z+B3Ucc3+WtDokzCM68mBeaZ/9RPbRtelUrRNV1Q+W3gXAjrFaRHN0fWw
   rVW4KMDikl6BWYrF7tAKVBBl/a+B9XC1aj6ZTvmfy5vGiFLkGPq9eh2eI
   g==;
X-CSE-ConnectionGUID: DaKU9agaQimiLQGY0wFCWA==
X-CSE-MsgGUID: B7j8IrEWRYS+KzKOcm47Qg==
X-IronPort-AV: E=Sophos;i="6.02,244,1688400000"; 
   d="scan'208";a="243594378"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2023 20:52:26 +0800
IronPort-SDR: 3nSB9lgfDD9Taii1mtOdJXrK6ItcBjfhbZSUFaKh771D+44P4yHr3SjTRcH8we2ljcSxxq4Me7
 xImvLfDlJyYRABZ1JX5Kz+ze57uzR7Wr9Y4foifrM5jI7Rr13ai0p3dy+D5jgBX1Vk1EO7uYJN
 ZUksRdB4vFvnHnMqkh/Ruw/jXVSqfYr7ghgI45P3fL7Ew7nwUC/e8pWdqvDJYA8R117tBMWbkE
 ug5uEP8faztQr6l+kBRj2MRAeCWcvuTJa55kcR0/eYoRhWRj2wEPlFa1zFEDG4Xhthb+3uFdnp
 jq8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 04:59:31 -0700
IronPort-SDR: MdE6VJtl9GGWzPSXdCj+oWCkzGdCIzqV2ByodE/P4+lR1HhxafqpInKJtFRBTqiezjeLifUw8M
 dQN80BstGoE6JwHkd+qmsnEDW+GQITblt8quvjhCsfycQJo0qfSXJQpMTKgk8rRXpo4Xgh+xsG
 +sLga87MRjGtBP5lAEzdEnTM0rF2esUv79o/WZtQqUPmF/s1VpYb9qLCNcGpiV81rDb530ZTsr
 IBRnVIxpfA/5xDsNtALRBBCuy6qMshWK5JufGx/r3YIlI3EXZE1Wsi0eWNgkjhfKMYutzjCRWN
 dcA=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2023 05:52:24 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 01/11] btrfs: add raid stripe tree definitions
Date:   Mon, 11 Sep 2023 05:52:02 -0700
Message-ID: <20230911-raid-stripe-tree-v8-1-647676fa852c@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694436627; l=4617; i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id; bh=rko1kr0Bp04UELCy7Ta/M1dYbKfLv8H02oeXzXTMR18=; b=wYRBOpcnTXFzs4PjGT4KN36cNiyrKoj9lnML5aDEdtNjnRs7VyDLia0V6VIrOcATdCjWn2tme PV/j1Q51hrrAJI5LkpTFysMGVFHlwyGIvGfXBnxeV8UVL+vUiBhGu9O
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519; pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 fs/btrfs/accessors.h            | 10 ++++++++++
 fs/btrfs/locking.c              |  5 +++--
 include/uapi/linux/btrfs_tree.h | 33 +++++++++++++++++++++++++++++++--
 3 files changed, 44 insertions(+), 4 deletions(-)

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
index 6ac4fd8cc8dc..e7760d40feab 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -58,8 +58,8 @@
 
 static struct btrfs_lockdep_keyset {
 	u64			id;		/* root objectid */
-	/* Longest entry: btrfs-block-group-00 */
-	char			names[BTRFS_MAX_LEVEL][24];
+	/* Longest entry: btrfs-raid-stripe-tree-00 */
+	char			names[BTRFS_MAX_LEVEL][25];
 	struct lock_class_key	keys[BTRFS_MAX_LEVEL];
 } btrfs_lockdep_keysets[] = {
 	{ .id = BTRFS_ROOT_TREE_OBJECTID,	DEFINE_NAME("root")	},
@@ -74,6 +74,7 @@ static struct btrfs_lockdep_keyset {
 	{ .id = BTRFS_UUID_TREE_OBJECTID,	DEFINE_NAME("uuid")	},
 	{ .id = BTRFS_FREE_SPACE_TREE_OBJECTID,	DEFINE_NAME("free-space") },
 	{ .id = BTRFS_BLOCK_GROUP_TREE_OBJECTID, DEFINE_NAME("block-group") },
+	{ .id = BTRFS_RAID_STRIPE_TREE_OBJECTID,DEFINE_NAME("raid-stripe-tree") },
 	{ .id = 0,				DEFINE_NAME("tree")	},
 };
 
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index fc3c32186d7e..3fb758ce3ac0 100644
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
 
@@ -285,6 +287,8 @@
  */
 #define BTRFS_QGROUP_RELATION_KEY       246
 
+#define BTRFS_RAID_STRIPE_KEY		247
+
 /*
  * Obsolete name, see BTRFS_TEMPORARY_ITEM_KEY.
  */
@@ -719,6 +723,31 @@ struct btrfs_free_space_header {
 	__le64 num_bitmaps;
 } __attribute__ ((__packed__));
 
+struct btrfs_raid_stride {
+	/* btrfs device-id this raid extent lives on */
+	__le64 devid;
+	/* physical location on disk */
+	__le64 physical;
+	/* length of stride on this disk */
+	__le64 length;
+};
+
+#define BTRFS_STRIPE_DUP	0
+#define BTRFS_STRIPE_RAID0	1
+#define BTRFS_STRIPE_RAID1	2
+#define BTRFS_STRIPE_RAID1C3	3
+#define BTRFS_STRIPE_RAID1C4	4
+#define BTRFS_STRIPE_RAID5	5
+#define BTRFS_STRIPE_RAID6	6
+#define BTRFS_STRIPE_RAID10	7
+
+struct btrfs_stripe_extent {
+	__u8 encoding;
+	__u8 reserved[7];
+	/* array of raid strides this stripe is composed of */
+	__DECLARE_FLEX_ARRAY(struct btrfs_raid_stride, strides);
+};
+
 #define BTRFS_HEADER_FLAG_WRITTEN	(1ULL << 0)
 #define BTRFS_HEADER_FLAG_RELOC		(1ULL << 1)
 

-- 
2.41.0

