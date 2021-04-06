Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C44354E49
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 10:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbhDFIIH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 04:08:07 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:34778 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239307AbhDFIIG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Apr 2021 04:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617696478; x=1649232478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZUIIE4X9IFzid6X8BbvdqDvUBb9qz4NyZvtEN3vVsi4=;
  b=lHhfXU48rB5Ay4UX2693mglp8AdfUq6jfvXf1sMoJ1Z2mQMQSYKzneT+
   a/bu9NH/PpMKEOsrLvKeQj49XGdCF6a2xfw8NklhzGk9YpwxeI5uCO1Fl
   lHy5qCRiJtkbiugJWaEt/LoIc8YIWbjFMTGSVwScYB3mVJUf4xDvM5zXj
   2IAwxq91IPTNxKV9VvN+KBh+jYENC2or5cM3FqAm4dEwPdwi/GikL1ATF
   wI46npzSN2cf7Cwa1Pd4aAvFff4JhCyILWyIS1S7JTb60a8oOzX1yjdmi
   SoDv3jbFF+gIhh9lT67VLsop/L8zHk76KTxVEXhF6T73U0BI9Yh1ZSy5/
   g==;
IronPort-SDR: TF8lzwkFAlq3PX0ah+yQDopS+nlu4iaH9OeoHTrT9+3fNaia2QJV8bJK2xLI31QodKUlFsL5BM
 7m8FCIQR2EJPGvJDtpY0DCP3hnQLmmKHvhP4UvLzFjPOUMX4XEXqoVIQtNXZp3zvtUSchaL/bD
 IKOoU7eZPRprmwJA1smDaCPX64m7n02KWKJd+JN+kLncetWezP1vcJYWXujo6dxvoklQIINoWJ
 kgb6GfhvBC/r+uu/xL/wHxpTTm8MS+fxHoB3On2Tls/IMb/3lD9oM1UQx+7KviZZyfg3VOYnhW
 i/M=
X-IronPort-AV: E=Sophos;i="5.81,308,1610380800"; 
   d="scan'208";a="163733747"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2021 16:07:44 +0800
IronPort-SDR: VtALeHekJYi1NmwKUFCD4rBCbEsvd0qOAL1YM4qz05gedpoo/3AqeQAhFySB9JLEVUWnIDLDEd
 EV736/ZRVB0ih5z7CZudZBMoG9ikbR4f7XKV1UYm+cuBR3IlPSw5Gs17anvci1LYGO/W8g9efU
 khXXx2rf2SaF4mURDj4bYoDZXqyDtah8NtluXBfm6rwCBD2uC5mxnjqBBeAxGQuJff/bguEBHJ
 it8wxvG0XoytdDSA4p+/uodb2BWND0hQ/0GrB8t1ViHLH0iQRzyGjy5sDVPnnvjcuaB4ChRpHg
 le7RBFAlP1b8vSDoSYG2ce9x
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 00:48:26 -0700
IronPort-SDR: U/KCdOHT66c6Jrr88YR7Ox2q/2TwVDX5Cy38U1AHrexgZbV8Q3xSKcP6TDQGascjUlev4z+ZhH
 uQH/Asahd7zH8W8VHDnO3cl1+4Ykiv3eTMZpsYZc+j09+YN5lPq21SdAnFCl4al9cVNREKXMz+
 oRQPZdR7CAJ6Fd4ow8drJiGM9WYhm97tpdCKne21XqPX0T7Z5le3ZVp7EkBsXqe0WGPKRC+Enq
 da4c4faTqM9rsB49gxR2k0v34+OvPaNnwFtL6AbxYmTgX/JvURvzE61TGwVs0Fv94KZjgn68Zd
 Qn4=
WDCIronportException: Internal
Received: from 5pgg7h2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.29])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Apr 2021 01:07:01 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 07/12] btrfs-progs: rewrite btrfs_alloc_data_chunk() using create_chunk()
Date:   Tue,  6 Apr 2021 17:05:49 +0900
Message-Id: <3c99ea11e476f18e5d1aa42bc11807a1e0c2e626.1617694997.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617694997.git.naohiro.aota@wdc.com>
References: <cover.1617694997.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_alloc_data_chunk() and create_chunk() have the most part in common.
Let's rewrite btrfs_alloc_data_chunk() using create_chunk().

There are two differences between btrfs_alloc_data_chunk() and
create_chunk(). create_chunk() uses find_next_chunk() to decide the logical
address of the chunk, and it uses btrfs_alloc_dev_extent() to decide the
physical address of a device extent. On the other hand,
btrfs_alloc_data_chunk() uses *start for both logical and physical
addresses.

To support the btrfs_alloc_data_chunk()'s use case,  we use ctl->start and
ctl->dev_offset. If these values are set (non-zero), use the specified
values as the address. It is safe to use 0 to indicate the value is not set
here. Because both lower addresses of logical
(0..BTRFS_FIRST_CHUNK_TREE_OBJECT_ID) and physical
(0..BTRFS_BLOCK_RESERVED_1M_FOR_SUPER) are reserved.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/volumes.c | 136 +++++++++++++---------------------------
 1 file changed, 43 insertions(+), 93 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index a409dd3d0366..2a094eab4971 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -161,6 +161,7 @@ struct alloc_chunk_ctl {
 	u64 max_chunk_size;
 	int stripe_len;
 	int total_devs;
+	u64 dev_offset;
 };
 
 struct stripe {
@@ -1058,6 +1059,7 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_info *info,
 	ctl->max_chunk_size = 4 * ctl->calc_size;
 	ctl->stripe_len = BTRFS_STRIPE_LEN;
 	ctl->total_devs = btrfs_super_num_devices(info->super_copy);
+	ctl->dev_offset = 0;
 
 	switch (info->fs_devices->chunk_alloc_policy) {
 	case BTRFS_CHUNK_ALLOC_REGULAR:
@@ -1137,9 +1139,14 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	u64 offset;
 
-	ret = find_next_chunk(info, &offset);
-	if (ret)
-		return ret;
+	if (!ctl->start) {
+		ret = find_next_chunk(info, &offset);
+		if (ret)
+			return ret;
+	} else {
+		offset = ctl->start;
+	}
+
 	key.objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
 	key.type = BTRFS_CHUNK_ITEM_KEY;
 	key.offset = offset;
@@ -1170,10 +1177,18 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 		    (index == ctl->num_stripes - 1))
 			list_move(&device->dev_list, dev_list);
 
-		ret = btrfs_alloc_dev_extent(trans, device, key.offset,
-			     ctl->calc_size, &dev_offset);
-		if (ret < 0)
-			goto out_chunk_map;
+		if (!ctl->dev_offset) {
+			ret = btrfs_alloc_dev_extent(trans, device, key.offset,
+				ctl->calc_size, &dev_offset);
+			if (ret < 0)
+				goto out_chunk_map;
+		} else {
+			dev_offset = ctl->dev_offset;
+			ret = btrfs_insert_dev_extent(trans, device, key.offset,
+						      ctl->calc_size,
+						      ctl->dev_offset);
+			BUG_ON(ret);
+		}
 
 		device->bytes_used += ctl->calc_size;
 		ret = btrfs_update_device(trans, device);
@@ -1330,23 +1345,10 @@ again:
 int btrfs_alloc_data_chunk(struct btrfs_trans_handle *trans,
 			   struct btrfs_fs_info *info, u64 *start, u64 num_bytes)
 {
-	u64 dev_offset;
-	struct btrfs_root *extent_root = info->extent_root;
-	struct btrfs_root *chunk_root = info->chunk_root;
-	struct btrfs_stripe *stripes;
-	struct btrfs_device *device = NULL;
-	struct btrfs_chunk *chunk;
 	struct list_head *dev_list = &info->fs_devices->devices;
-	struct list_head *cur;
-	struct map_lookup *map;
-	u64 calc_size = SZ_8M;
-	int num_stripes = 1;
-	int sub_stripes = 1;
-	int ret;
-	int index;
-	int stripe_len = BTRFS_STRIPE_LEN;
-	struct btrfs_key key;
-
+	struct list_head private_devs;
+	struct btrfs_device *device;
+	struct alloc_chunk_ctl ctl;
 
 	if (*start != round_down(*start, info->sectorsize)) {
 		error("DATA chunk start not sectorsize aligned: %llu",
@@ -1354,78 +1356,26 @@ int btrfs_alloc_data_chunk(struct btrfs_trans_handle *trans,
 		return -EINVAL;
 	}
 
-	key.objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
-	key.type = BTRFS_CHUNK_ITEM_KEY;
-	key.offset = *start;
-	dev_offset = *start;
-
-	chunk = kmalloc(btrfs_chunk_item_size(num_stripes), GFP_NOFS);
-	if (!chunk)
-		return -ENOMEM;
-
-	map = kmalloc(btrfs_map_lookup_size(num_stripes), GFP_NOFS);
-	if (!map) {
-		kfree(chunk);
-		return -ENOMEM;
-	}
-
-	stripes = &chunk->stripe;
-	calc_size = num_bytes;
-
-	index = 0;
-	cur = dev_list->next;
-	device = list_entry(cur, struct btrfs_device, dev_list);
-
-	while (index < num_stripes) {
-		struct btrfs_stripe *stripe;
-
-		ret = btrfs_insert_dev_extent(trans, device, key.offset, calc_size,
-				dev_offset);
-		BUG_ON(ret);
+	ctl.start = *start;
+	ctl.type = BTRFS_BLOCK_GROUP_DATA;
+	ctl.num_stripes = 1;
+	ctl.max_stripes = 1;
+	ctl.min_stripes = 1;
+	ctl.sub_stripes = 1;
+	ctl.calc_size = num_bytes;
+	ctl.min_stripe_size = num_bytes;
+	ctl.num_bytes = num_bytes;
+	ctl.max_chunk_size = num_bytes;
+	ctl.stripe_len = BTRFS_STRIPE_LEN;
+	ctl.total_devs = btrfs_super_num_devices(info->super_copy);
+	ctl.dev_offset = *start;
 
-		device->bytes_used += calc_size;
-		ret = btrfs_update_device(trans, device);
-		BUG_ON(ret);
-
-		map->stripes[index].dev = device;
-		map->stripes[index].physical = dev_offset;
-		stripe = stripes + index;
-		btrfs_set_stack_stripe_devid(stripe, device->devid);
-		btrfs_set_stack_stripe_offset(stripe, dev_offset);
-		memcpy(stripe->dev_uuid, device->uuid, BTRFS_UUID_SIZE);
-		index++;
-	}
-
-	/* key was set above */
-	btrfs_set_stack_chunk_length(chunk, num_bytes);
-	btrfs_set_stack_chunk_owner(chunk, extent_root->root_key.objectid);
-	btrfs_set_stack_chunk_stripe_len(chunk, stripe_len);
-	btrfs_set_stack_chunk_type(chunk, BTRFS_BLOCK_GROUP_DATA);
-	btrfs_set_stack_chunk_num_stripes(chunk, num_stripes);
-	btrfs_set_stack_chunk_io_align(chunk, stripe_len);
-	btrfs_set_stack_chunk_io_width(chunk, stripe_len);
-	btrfs_set_stack_chunk_sector_size(chunk, info->sectorsize);
-	btrfs_set_stack_chunk_sub_stripes(chunk, sub_stripes);
-	map->sector_size = info->sectorsize;
-	map->stripe_len = stripe_len;
-	map->io_align = stripe_len;
-	map->io_width = stripe_len;
-	map->type = BTRFS_BLOCK_GROUP_DATA;
-	map->num_stripes = num_stripes;
-	map->sub_stripes = sub_stripes;
-
-	ret = btrfs_insert_item(trans, chunk_root, &key, chunk,
-				btrfs_chunk_item_size(num_stripes));
-	BUG_ON(ret);
-
-	map->ce.start = key.offset;
-	map->ce.size = num_bytes;
-
-	ret = insert_cache_extent(&info->mapping_tree.cache_tree, &map->ce);
-	BUG_ON(ret);
+	INIT_LIST_HEAD(&private_devs);
+	/* Build a list containing one device */
+	device = list_entry(dev_list->next, struct btrfs_device, dev_list);
+	list_move(&device->dev_list, &private_devs);
 
-	kfree(chunk);
-	return ret;
+	return create_chunk(trans, info, &ctl, &private_devs);
 }
 
 int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
-- 
2.31.1

