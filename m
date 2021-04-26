Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E76336AC37
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhDZG3S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:29:18 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41951 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhDZG3O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418512; x=1650954512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qyf1WvQDTZ6O1PcEII/rrzmWoCLf/e+D5iQfoxLJIBI=;
  b=aG38qulDmZzonRJJEWPwP5SvCQ55ZiWhWttKAlXlg1ryjoBjZPolr2Nf
   NQaDkdfOQ7uQlO1jpX5L/Bd5j6DxSw2qTaWkWSqM78X1mUrVf//uuv7gi
   1LQ3StpI41x7x4z4i8O9xJpD16XJr9Z8ekMnYZPi6hot8qM2eTQinE5uC
   dU5MNvNfkrNyBVJWQJJxdCBanFJQocqdVJB2pLngHmQTiOHwB/kYyTAL4
   mUQaJXVNTvYCriACgknaCaGax0zfpx+044ziWrLvSvj/Gu+339TDsWJcS
   mXZOma7v8MdowQmyixejq53UiWErulKjhfBwCf92Ur+jPRrimTffBG4Nv
   A==;
IronPort-SDR: Y+IDZ8IIdjdE6/LX0jHyXOu/1U/iUAc1bBYchtyO1PyyN6BwOr0anTWdZcPYuno5n3sJwPwsKr
 e+8AsCOpy5kTfkzKZ20gIqMJJHlejVXz7fGhCEIEeswatG/yoncq9QsXjwB/LpQW1lBLghZDmF
 4wfRF1IHr2T21oxZ3WCgMcEma4xlj5PB1a73+wvOtlherNKQHVDc9YxZvIfmHuJNr00VfZNOeA
 IRK2WoBA/7+xSK6dgypQArSjNxk2lZq9T1aOnYAi5Vrj1kkbiBG6m7P3mn2b9QXunrkxPvw1kw
 oqc=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788141"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:32 +0800
IronPort-SDR: NWqMznZDbOn+J7HqGY0AiHSADlVWHxQBynaViyoR2w4PPofmwf7j27Ycx4xnNAlcWTrVtzYYKX
 gc1S4Fi3168lCPpQiuvOkmGCHqmNuNiKxxgga4nuCVF2zGVPsHNIaV/nllpGAP01bgQS7ETXtj
 PUMMfazkz+s61Xs3ypWm64HnnBecfmSl5W7+Ow60QtkJfaq7lC8b9c2cwXZRGqTQM2IeYbYtyp
 qUaXIC4BjuJnLjY9KJ6r6qZuHOZeelnATW/AzpDD6T0rNbxWtWbR0pjuA8vYM+MH4FQL6o//0L
 i99ppdVaQwFjhhRbGUqaH1Vn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:57 -0700
IronPort-SDR: Nmkn/5a+mJc2guVFL3Gls0aHoQTh//SxgPLF/Ao1sSf7nfzH69ENM2RZtVsoOlk3n55RpsM+Di
 MMW/I+T9zxS+P+8X1JZdUg1CbkGEHI/OB3rhEliR4UERRVtRhqoOm64VVaWGHNDEx4kTuDjIwk
 m9oRy6YnIH1yHVs6gUw3D5RnEqlfv3hFQvb4UdM/5wBQqwv8rdIlqcS6zo0RE+qkRSBWSsGm3i
 v26o9jvL0YxIO9Pb/Iq5crKRGTrhYZZIcvFkhaeH3wHo8y+2YzVTlAAr+8xWvdUyeLDnpO8qjn
 qzM=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:33 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 22/26] btrfs-progs: mkfs: zoned: tweak initial system block group placement
Date:   Mon, 26 Apr 2021 15:27:38 +0900
Message-Id: <ab69c1805ec16235f20cae4e74d44bf26ac49e8e.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On zoned btrfs, chunks must be aligned to zone size to ensure sequential
writing to a block group maps to sequential writing to a device zone. Thus,
we need to tweak the position and the size of the initial system block
group.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 mkfs/common.c | 26 ++++++++++++++++----------
 mkfs/main.c   | 21 ++++++++++++++++-----
 2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 6b0c434fbd6a..3d10ad086754 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -22,6 +22,7 @@
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/volumes.h"
+#include "kernel-shared/zoned.h"
 #include "common/utils.h"
 #include "common/path-utils.h"
 #include "common/device-utils.h"
@@ -155,6 +156,13 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	int skinny_metadata = !!(cfg->features &
 				 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA);
 	u64 num_bytes;
+	u64 system_group_offset = BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
+	u64 system_group_size =  BTRFS_MKFS_SYSTEM_GROUP_SIZE;
+
+	if ((cfg->features & BTRFS_FEATURE_INCOMPAT_ZONED)) {
+		system_group_offset = cfg->zone_size * BTRFS_NR_SB_LOG_ZONES;
+		system_group_size = cfg->zone_size;
+	}
 
 	buf = malloc(sizeof(*buf) + max(cfg->sectorsize, cfg->nodesize));
 	if (!buf)
@@ -186,7 +194,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 
 	cfg->blocks[MKFS_SUPER_BLOCK] = BTRFS_SUPER_INFO_OFFSET;
 	for (i = 1; i < MKFS_BLOCK_COUNT; i++) {
-		cfg->blocks[i] = BTRFS_BLOCK_RESERVED_1M_FOR_SUPER +
+		cfg->blocks[i] = system_group_offset +
 			cfg->nodesize * (i - 1);
 	}
 
@@ -323,8 +331,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_device_id(buf, dev_item, 1);
 	btrfs_set_device_generation(buf, dev_item, 0);
 	btrfs_set_device_total_bytes(buf, dev_item, num_bytes);
-	btrfs_set_device_bytes_used(buf, dev_item,
-				    BTRFS_MKFS_SYSTEM_GROUP_SIZE);
+	btrfs_set_device_bytes_used(buf, dev_item, system_group_size);
 	btrfs_set_device_io_align(buf, dev_item, cfg->sectorsize);
 	btrfs_set_device_io_width(buf, dev_item, cfg->sectorsize);
 	btrfs_set_device_sector_size(buf, dev_item, cfg->sectorsize);
@@ -345,14 +352,14 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 
 	/* then we have chunk 0 */
 	btrfs_set_disk_key_objectid(&disk_key, BTRFS_FIRST_CHUNK_TREE_OBJECTID);
-	btrfs_set_disk_key_offset(&disk_key, BTRFS_BLOCK_RESERVED_1M_FOR_SUPER);
+	btrfs_set_disk_key_offset(&disk_key, system_group_offset);
 	btrfs_set_disk_key_type(&disk_key, BTRFS_CHUNK_ITEM_KEY);
 	btrfs_set_item_key(buf, &disk_key, nritems);
 	btrfs_set_item_offset(buf, btrfs_item_nr(nritems), itemoff);
 	btrfs_set_item_size(buf, btrfs_item_nr(nritems), item_size);
 
 	chunk = btrfs_item_ptr(buf, nritems, struct btrfs_chunk);
-	btrfs_set_chunk_length(buf, chunk, BTRFS_MKFS_SYSTEM_GROUP_SIZE);
+	btrfs_set_chunk_length(buf, chunk, system_group_size);
 	btrfs_set_chunk_owner(buf, chunk, BTRFS_EXTENT_TREE_OBJECTID);
 	btrfs_set_chunk_stripe_len(buf, chunk, BTRFS_STRIPE_LEN);
 	btrfs_set_chunk_type(buf, chunk, BTRFS_BLOCK_GROUP_SYSTEM);
@@ -362,7 +369,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_chunk_num_stripes(buf, chunk, 1);
 	btrfs_set_stripe_devid_nr(buf, chunk, 0, 1);
 	btrfs_set_stripe_offset_nr(buf, chunk, 0,
-				   BTRFS_BLOCK_RESERVED_1M_FOR_SUPER);
+				   system_group_offset);
 	nritems++;
 
 	write_extent_buffer(buf, super.dev_item.uuid,
@@ -401,7 +408,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 		sizeof(struct btrfs_dev_extent);
 
 	btrfs_set_disk_key_objectid(&disk_key, 1);
-	btrfs_set_disk_key_offset(&disk_key, BTRFS_BLOCK_RESERVED_1M_FOR_SUPER);
+	btrfs_set_disk_key_offset(&disk_key, system_group_offset);
 	btrfs_set_disk_key_type(&disk_key, BTRFS_DEV_EXTENT_KEY);
 	btrfs_set_item_key(buf, &disk_key, nritems);
 	btrfs_set_item_offset(buf, btrfs_item_nr(nritems), itemoff);
@@ -413,14 +420,13 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_dev_extent_chunk_objectid(buf, dev_extent,
 					BTRFS_FIRST_CHUNK_TREE_OBJECTID);
 	btrfs_set_dev_extent_chunk_offset(buf, dev_extent,
-					  BTRFS_BLOCK_RESERVED_1M_FOR_SUPER);
+					  system_group_offset);
 
 	write_extent_buffer(buf, chunk_tree_uuid,
 		    (unsigned long)btrfs_dev_extent_chunk_tree_uuid(dev_extent),
 		    BTRFS_UUID_SIZE);
 
-	btrfs_set_dev_extent_length(buf, dev_extent,
-				    BTRFS_MKFS_SYSTEM_GROUP_SIZE);
+	btrfs_set_dev_extent_length(buf, dev_extent, system_group_size);
 	nritems++;
 
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_DEV_TREE]);
diff --git a/mkfs/main.c b/mkfs/main.c
index 9407cdfa8fe7..915e42b7f9cd 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -71,8 +71,17 @@ static int create_metadata_block_groups(struct btrfs_root *root, int mixed,
 	u64 bytes_used;
 	u64 chunk_start = 0;
 	u64 chunk_size = 0;
+	u64 system_group_offset = BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
+	u64 system_group_size = BTRFS_MKFS_SYSTEM_GROUP_SIZE;
 	int ret;
 
+	if (btrfs_is_zoned(fs_info)) {
+		/* Two zones are reserved for superblock */
+		system_group_offset = fs_info->zone_size *
+			BTRFS_NR_SB_LOG_ZONES;
+		system_group_size = fs_info->zone_size;
+	}
+
 	if (mixed)
 		flags |= BTRFS_BLOCK_GROUP_DATA;
 
@@ -92,9 +101,8 @@ static int create_metadata_block_groups(struct btrfs_root *root, int mixed,
 	 */
 	ret = btrfs_make_block_group(trans, fs_info, bytes_used,
 				     BTRFS_BLOCK_GROUP_SYSTEM,
-				     BTRFS_BLOCK_RESERVED_1M_FOR_SUPER,
-				     BTRFS_MKFS_SYSTEM_GROUP_SIZE);
-	allocation->system += BTRFS_MKFS_SYSTEM_GROUP_SIZE;
+				     system_group_offset, system_group_size);
+	allocation->system += system_group_size;
 	if (ret)
 		return ret;
 
@@ -917,6 +925,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	struct mkfs_allocation allocation = { 0 };
 	struct btrfs_mkfs_config mkfs_cfg;
 	enum btrfs_csum_type csum_type = BTRFS_CSUM_TYPE_CRC32;
+	u64 system_group_size;
 
 	crc32c_optimization_init();
 
@@ -1330,9 +1339,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	}
 
 	/* To create the first block group and chunk 0 in make_btrfs */
-	if (dev_block_count < BTRFS_MKFS_SYSTEM_GROUP_SIZE) {
+	system_group_size = zoned ?
+		zone_size(file) : BTRFS_MKFS_SYSTEM_GROUP_SIZE;
+	if (dev_block_count < system_group_size) {
 		error("device is too small to make filesystem, must be at least %llu",
-				(unsigned long long)BTRFS_MKFS_SYSTEM_GROUP_SIZE);
+				(unsigned long long)system_group_size);
 		goto error;
 	}
 
-- 
2.31.1

