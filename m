Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EF97A4F67
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 18:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjIRQmS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 12:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjIRQmE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 12:42:04 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341303376C
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Sep 2023 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695054480; x=1726590480;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qR+pbQes1zr0xI7iX0cFREb5LsPU6Ip9x/gNipbsoNo=;
  b=eZoFOfpANClOsNH8C0Mm7BqoQnRgT+bEUo7oHewcdGScGzcdqR4VZ5rm
   Dh/xHEn9w3gOofR+OqcLvIcVcin6AQHXn+OhzWaVbs4wxuplNyUATBAvt
   O2wsupcTweRRdSqVeygERERNTZIj6osv8b4k+9O7NFFunev/p6Q/4Cr7w
   phWK0RExT+JeEggDmixGoXDmvXTsTGALn2lnRt1gPjIyR0gTtJvSOMK2F
   xxNQl3JWHRM5DVuO0evtA/zrpJJV9Xa2erSdKsNZFcEUiwObgf1soyOkb
   sDa/q0eq1WMJR9HkQO5dmy25HO/T+2FsHdkPQbVf9yL8B/JOqQNknEO3/
   w==;
X-CSE-ConnectionGUID: R+u8ta4bQaWhNZaa4JH4zQ==
X-CSE-MsgGUID: 3GuiNIXwS4+6t+lI7qfrng==
X-IronPort-AV: E=Sophos;i="6.02,156,1688400000"; 
   d="scan'208";a="356324015"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2023 22:05:20 +0800
IronPort-SDR: 37NU581IT37QrXilNPvZa5B22b8rSBg93tt9Mxd9UHyRPj7UR82Kr/5tgVMLNnbCDgDNGeIyI1
 cxrvJTqMq9rQXS63rdxYIXSSIgpyEJTkFoA+Gz8/4q9qmWhqtnZbhkJ350UCPURy2lhlF8aKb8
 PF9gMvz1gSHwc2PhC2/BxRob///PwzBpMrQ39fkEHXxZ+q+TFNRf/YekuBuiK1W05YhKaDN3gT
 hqBOmZaks678B5uelp9ZZ6An4M+muNZaG6L156HtuatD+7Bzkz+IIrxQ1vhKl6aAvvrmFmjtgq
 ofM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2023 06:12:17 -0700
IronPort-SDR: VnYk7v1lOvDYKXBtNeCspzaJujVLVfyCWjQ9A00+636Ax1mqWyuqCkPMrY0qo0d99cIA1BoOTj
 Sz/i1BTuIFkrMjXEBUNl5RhMN4i6qNkFrC57s0oj7TmW0uYyfWm0ifi84vIpyhoNSZ9QIsoQl7
 czRaTxB0TyWWlGvVqmAZ515eoWhwSWctSR/Jv3guRJIIebA9AJHdQ4tMGPTKR8dYAPtPbY7imh
 t45onr+YEbF7w/F7CTcNmCnKZH5cs6BxC66A8ggFeKHE/8Z5HL7q2GN5UtuEe5d3zEKHuC0mTf
 tjs=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Sep 2023 07:05:20 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs-dev-docs: add document for RAID stripe tree
Date:   Mon, 18 Sep 2023 07:05:11 -0700
Message-ID: <20230918140515.2597127-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RISK_FREE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a document describing the layout and functionallity of the newly
introduced RAID Stripe Tree.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 raid-stripe-tree.txt | 318 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 318 insertions(+)
 create mode 100644 raid-stripe-tree.txt

diff --git a/raid-stripe-tree.txt b/raid-stripe-tree.txt
new file mode 100644
index 000000000000..7cba1d2f0d75
--- /dev/null
+++ b/raid-stripe-tree.txt
@@ -0,0 +1,318 @@
+BTRFS RAID Stripe Tree Design
+=============================
+
+
+Problem Statement
+-----------------
+
+
+RAID on zoned devices
+---------------------
+The current implementation of RAID profiles in BTRFS is based on the implicit
+assumption that data placement is deterministic in the device chunks used for
+mapping block groups. 
+With deterministic data placement, all physical on-disk extents of one logical
+file extent are positioned at the same offset relative to the starting LBA of
+a device chunk. This prevents the need for reading any meta-data to access an
+on-disk file extent. Figure 1 shows an example of it.
+
+
+	+------------+      +------------+
+	|            |      |            |
+	|            |      |            |
+	|            |      |            |
+	+------------+      +------------+
+	|            |      |            |
+	|    D 1     |      |    D 1     |
+	|            |      |            |
+	+------------+      +------------+
+	|            |      |            |
+	|    D 2     |      |    D 2     |
+	|            |      |            |
+	+------------+      +------------+
+	|            |      |            |
+	|            |      |            |
+	|            |      |            |
+	|            |      |            |
+	+------------+      +------------+
+	Figure 1: Deterministic data placement
+
+
+
+With non-deterministic data placement, the on-disk extents of a logical file
+extent can be scattered around inside the chunk. To read back the data with
+non-deterministic data placement, additional meta-data describing the position
+of the extents inside a chunk is needed. Figure 2 shows an example for this
+style of data placement.
+
+
+	+------------+      +------------+
+	|            |      |            |
+	|            |      |            |
+	|            |      |            |
+	+------------+      +------------+
+	|            |      |            |
+	|    D 1     |      |    D 2     |
+	|            |      |            |
+	+------------+      +------------+
+	|            |      |            |
+	|    D 2     |      |    D 1     |
+	|            |      |            |
+	+------------+      +------------+
+	|            |      |            |
+	|            |      |            |
+	|            |      |            |
+	|            |      |            |
+	+------------+      +------------+
+	Figure 2: Non-deterministic data placement
+  
+As BTRFS support for zoned block devices uses the Zone Append operation for
+writing file data extents, there is no guarantee that the written extents have
+the same offset within different device chunks. This implies that to be able
+to use RAID with zoned devices, non-deterministic data placement must be
+supported and additional meta-data describing the location of file extents
+within device chunks is needed.
+
+
+Lessons learned from RAID 5
+---------------------------
+BTRFS implementation of RAID levels 5 and 6 suffer from the well-known RAID
+write hole problem. This problem exists because sub-stripe write operations
+are not done using a copy-on-write (COW) but done using Read-Modify-Write
+(RMW). With out-of-place writing like COW, no blocks will be overwritten and
+there is no risk of exposing bad data or corrupting a data stripe parity in
+case of sudden power loss or other unexpected events preventing correctly
+writing to the device.
+
+RAID Stripe Tree Design overview
+--------------------------------
+
+To solve the problems stated above, additional meta-data is introduced: a RAID
+Stripe Tree holds the logical to physical translation for the RAID stripes.
+For each logical file extent (struct btrfs_file_extent_item) a stripe extent
+is created (struct btrfs_stripe_extent). Each btrfs_stripe_extent entry is a
+container for an array of struct btrfs_raid_stride. A struct btrfs_raid_stride
+holds the device ID and the physical start location on that device of the
+sub-stripe of a file extent, as well as the stride's length.
+Each struct btrfs_stripe_extent is keyed by the struct btrfs_file_extent_item
+disk_bytenr and disk_num_bytes, with disk_bytenr as the objectid for the
+btrfs_key and disk_num_bytes as the offset. The key’s type is
+BTRFS_STRIPE_EXTENT_KEY.
+
+On-disk format
+--------------
+
+struct btrfs_file_extent_item {
+        /* […] */
+        __le64 disk_bytenr; ------------------------------------+ 
+        __le64 disk_num_bytes;  --------------------------------|----+
+	/* […] */                                               |    |
+};                                                              |    |
+                                                                |    |
+struct btrfs_key key = {   -------------------------------------|----|--+
+	.objectid = btrfs_file_extent_item::disk_bytenr, <------+    |  |
+	.type = BTRFS_STRIPE_EXTENT_KEY,                             |  |
+	.offset = btrfs_file_extent_item::disk_num_bytes, <----------+  |
+};                                                                      |
+                                                                        |
+struct btrfs_raid_stride { <------------------+                         |
+       __le64 devid;                          |                         |
+       __le64 physical;                       |                         |
+       __le64 length;                         |                         |
+};                                            |                         |
+                                              |                         |
+struct btrfs_stripe_extent {  <---------------|-------------------------+
+	u8 encoding;                          |
+	u8 reserved[7];                       |
+       struct btrfs_raid_stride strides[]; ---+
+};
+
+
+User-space support
+------------------
+
+
+mkfs
+----
+Supporting the RAID Stripe Tree in user-space consists of three things to do
+for mkfs. The first step is creating the root of the RAID Stripe Tree itself.
+Then mkfs must set the incompat flag, so mounting a filesystem with a RAID
+Stripe Tree is impossible for a kernel version without appropriate support.
+Lastly it must allow RAID profiles on zoned devices once the tree is present.
+
+
+Check
+-----
+The ‘btrfs check’ support for RAID Stripe Tree is not implemented yet, but its
+task is to read the struct btrfs_stripe_extent entries for each struct
+btrfs_file_extent_item and verify that a correct mapping between these two
+exists. If data checksum verification is requested as well, the tree also must
+be read to perform the logical to physical translation, otherwise the data
+cannot be read, and the checksums cannot be verified.
+
+
+Example tree dumps
+------------------
+
+Example 1: Write 128k to and empty FS
+
+RAID0
+        item 0 key (XXXXXX RAID_STRIPE_KEY 131072) itemoff XXXXX itemsize 56
+                        encoding: RAID0
+                        stripe 0 devid 1 physical XXXXXXXXX length 65536
+                        stripe 1 devid 2 physical XXXXXXXXX length 65536
+RAID1
+                        stripe 0 devid 1 physical XXXXXXXXX length 131072
+                        stripe 1 devid 2 physical XXXXXXXXX length 131072
+RAID10
+        item 0 key (XXXXXX RAID_STRIPE_KEY 131072) itemoff XXXXX itemsize 104
+                        encoding: RAID10
+                        stripe 0 devid 1 physical XXXXXXXXX length 65536
+                        stripe 1 devid 2 physical XXXXXXXXX length 65536
+                        stripe 2 devid 3 physical XXXXXXXXX length 65536
+                        stripe 3 devid 4 physical XXXXXXXXX length 65536
+
+Example 2: Pre-fill one 65k stripe, write 4k to 2nd stripe, write 64k then
+write 16k.
+
+RAID0
+        item 0 key (XXXXXX RAID_STRIPE_KEY 65536) itemoff XXXXX itemsize 32
+                        encoding: RAID0
+                        stripe 0 devid 1 physical XXXXXXXXX length 65536
+        item 1 key (XXXXXX RAID_STRIPE_KEY 4096) itemoff XXXXX itemsize 32
+                        encoding: RAID0
+                        stripe 0 devid 2 physical XXXXXXXXX length 4096
+        item 2 key (XXXXXX RAID_STRIPE_KEY 65536) itemoff XXXXX itemsize 56
+                        encoding: RAID0
+                        stripe 0 devid 2 physical XXXXXXXXX length 61440
+                        stripe 1 devid 1 physical XXXXXXXXX length 4096
+        item 3 key (XXXXXX RAID_STRIPE_KEY 4096) itemoff XXXXX itemsize 32
+                        encoding: RAID0
+                        stripe 0 devid 1 physical XXXXXXXXX length 4096
+RAID1
+        item 0 key (XXXXXX RAID_STRIPE_KEY 65536) itemoff XXXXX itemsize 56
+                        encoding: RAID1
+                        stripe 0 devid 1 physical XXXXXXXXX length 65536
+                        stripe 1 devid 2 physical XXXXXXXXX length 65536
+        item 1 key (XXXXXX RAID_STRIPE_KEY 4096) itemoff XXXXX itemsize 56
+                        encoding: RAID1
+                        stripe 0 devid 1 physical XXXXXXXXX length 4096
+                        stripe 1 devid 2 physical XXXXXXXXX length 4096
+        item 2 key (XXXXXX RAID_STRIPE_KEY 65536) itemoff XXXXX itemsize 56
+                        encoding: RAID1
+                        stripe 0 devid 1 physical XXXXXXXXX length 65536
+                        stripe 1 devid 2 physical XXXXXXXXX length 65536
+        item 3 key (XXXXXX RAID_STRIPE_KEY 4096) itemoff XXXXX itemsize 56
+                        encoding: RAID1
+                        stripe 0 devid 1 physical XXXXXXXXX length 4096
+                        stripe 1 devid 2 physical XXXXXXXXX length 4096
+RAID10
+        item 0 key (XXXXXX RAID_STRIPE_KEY 65536) itemoff XXXXX itemsize 56
+                        encoding: RAID10
+                        stripe 0 devid 1 physical XXXXXXXXX length 65536
+                        stripe 1 devid 2 physical XXXXXXXXX length 65536
+        item 1 key (XXXXXX RAID_STRIPE_KEY 4096) itemoff XXXXX itemsize 56
+                        encoding: RAID10
+                        stripe 0 devid 3 physical XXXXXXXXX length 4096
+                        stripe 1 devid 4 physical XXXXXXXXX length 4096
+        item 2 key (XXXXXX RAID_STRIPE_KEY 65536) itemoff XXXXX itemsize 104
+                        encoding: RAID10
+                        stripe 0 devid 3 physical XXXXXXXXX length 61440
+                        stripe 1 devid 4 physical XXXXXXXXX length 61440
+                        stripe 2 devid 1 physical XXXXXXXXX length 4096
+                        stripe 3 devid 2 physical XXXXXXXXX length 4096
+        item 3 key (XXXXXX RAID_STRIPE_KEY 4096) itemoff XXXXX itemsize 56
+                        encoding: RAID10
+                        stripe 0 devid 1 physical XXXXXXXXX length 4096
+                        stripe 1 devid 2 physical XXXXXXXXX length 4096
+
+Example 3: Pre-fill stripe with 32K data, then write 64K of data and then
+overwrite 8k in the middle.
+
+RAID0
+        item 0 key (XXXXXX RAID_STRIPE_KEY 32768) itemoff XXXXX itemsize 32
+                        encoding: RAID0
+                        stripe 0 devid 1 physical XXXXXXXXX length 32768
+        item 1 key (XXXXXX RAID_STRIPE_KEY 131072) itemoff XXXXX itemsize 80
+                        encoding: RAID0
+                        stripe 0 devid 1 physical XXXXXXXXX length 32768
+                        stripe 1 devid 2 physical XXXXXXXXX length 65536
+                        stripe 2 devid 1 physical XXXXXXXXX length 32768
+        item 2 key (XXXXXX RAID_STRIPE_KEY 8192) itemoff XXXXX itemsize 32
+                        encoding: RAID0
+                        stripe 0 devid 1 physical XXXXXXXXX length 8192
+RAID1
+        item 0 key (XXXXXX RAID_STRIPE_KEY 32768) itemoff XXXXX itemsize 56
+                        encoding: RAID1
+                        stripe 0 devid 1 physical XXXXXXXXX length 32768
+                        stripe 1 devid 2 physical XXXXXXXXX length 32768
+        item 1 key (XXXXXX RAID_STRIPE_KEY 131072) itemoff XXXXX itemsize 56
+                        encoding: RAID1
+                        stripe 0 devid 1 physical XXXXXXXXX length 131072
+                        stripe 1 devid 2 physical XXXXXXXXX length 131072
+        item 2 key (XXXXXX RAID_STRIPE_KEY 8192) itemoff XXXXX itemsize 56
+                        encoding: RAID1
+                        stripe 0 devid 1 physical XXXXXXXXX length 8192
+                        stripe 1 devid 2 physical XXXXXXXXX length 8192
+RAID10
+        item 0 key (XXXXXX RAID_STRIPE_KEY 32768) itemoff XXXXX itemsize 56
+                        encoding: RAID10
+                        stripe 0 devid 1 physical XXXXXXXXX length 32768
+                        stripe 1 devid 2 physical XXXXXXXXX length 32768
+        item 1 key (XXXXXX RAID_STRIPE_KEY 131072) itemoff XXXXX itemsize 152
+                        encoding: RAID10
+                        stripe 0 devid 1 physical XXXXXXXXX length 32768
+                        stripe 1 devid 2 physical XXXXXXXXX length 32768
+                        stripe 2 devid 3 physical XXXXXXXXX length 65536
+                        stripe 3 devid 4 physical XXXXXXXXX length 65536
+                        stripe 4 devid 1 physical XXXXXXXXX length 32768
+                        stripe 5 devid 2 physical XXXXXXXXX length 32768
+        item 2 key (XXXXXX RAID_STRIPE_KEY 8192) itemoff XXXXX itemsize 56
+                        encoding: RAID10
+                        stripe 0 devid 1 physical XXXXXXXXX length 8192
+                        stripe 1 devid 2 physical XXXXXXXXX length 8192
+
+
+Glossary
+--------
+
+
+RAID
+	Redundant Array of Independent Disks. This is a storage mechanism
+	where data is not stored on a single disk alone but either mirrored
+	(in case of RAID 1) or split across multiple disks (RAID 0). Other
+	RAID levels like RAID5 and RAID6 stripe the data across multiple disks
+	and add parity information to enable data recovery in case of a disk
+	failure. 
+
+
+LBA 
+	Logical Block Address. LBAs describe the address space of a block
+	device as a linearly increasing address map. LBAs are internally
+	mapped to different physical locations  by the device firmware.
+
+
+Zoned Block Device 
+	Zoned Block Devices are a special kind of block devices that partition
+	their LBA space into so called zones. These zones can impose write
+	constraints on the host, e.g., allowing only sequential writes aligned
+	to a zone write pointer.
+
+
+Zone Append 
+	A write operation where the start LBA of a Zone is specified instead
+	of a destination LBA for the data to be written. On completion the
+	device reports the starting LBA used to write the data back to the
+	host.
+
+
+Copy-on-Write
+	A write technique where the data is not overwritten, but a new version
+	of it is written out of place.
+
+
+Read-Modify-Write
+	A write technique where the data to be written is first read from the
+	block device, modified in memory and the modified data written back in
+	place on the block device.
+
-- 
2.41.0

