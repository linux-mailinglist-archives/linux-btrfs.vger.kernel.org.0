Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE75836AC2E
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhDZG3I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:29:08 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41929 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbhDZG3G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418504; x=1650954504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iQ/n5nLYIxw5jRuhvo4gw0nJIIoC8SyC1rasLoLInpI=;
  b=DXtEChKRWNZccHM2ZsCbevNoC3lzyAdS4pWZjZIUn17CHneqTR6yKUW8
   lNSg5GkKA9xhsMk9rTeIlt5iM/EwsnRolRVqeSlvXfIlOVh8MMiLQR81O
   N/poZwNwXnWNRDaksY93RrEVPvLouqagx5FN9KI4zt12XbauPWAsTkq/D
   tvEj3CaHcGCzkGEc+y+qltKVLjAW1MjaqSYkCuZv4/zZe7YY8oooWiEJe
   yLxPhaiTmObER4RHIf43dsF/6biLBK0B6oNOnEcyYvAkeF+Rw0OLAPv0h
   vrtLEgEvzgcjsVr+07QKEO886EVV3K8/KgyH3+t4kcdatqH/bhufgEtxe
   Q==;
IronPort-SDR: p1QBKbCzRDAFAU8DOI3SQdcVanQPhIG111GRm504qolRBxtuHFlV2IMfD2FkSOr3+WDt+HdXS1
 hJGpDaZJKH8Tu9JV8VXAyfa1euHpNfT52r6sgo+o1E52V5NKcbrAHIOk1K7IO7RidMmR3MaRkr
 KdVWy8gYTHJrMatB7y4bSQToG5iGkXxrAA3d5vFUTtjKqifKEuYctUvdIXW8n6MPpvLbl10KFX
 6T1Y3fbSquEgiRjhJmV5pQpoc5AddpKScPesWOOWZ+gUuzXKq9TLeFl+JkZMpuC5VULpCr0rjw
 BC8=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788129"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:24 +0800
IronPort-SDR: 9pvGEftP3yKr+E6yC9AnO2yQGv/VdUYnF5GMTetQ6WDXHuJ8Wy8B6zfaLwCoxyCyqsSaHtDpEt
 StFaq++AGyv7hkqYYkWz2KfMdgji0FpvMrhw7b/5fTI/Pv2ekIj+YitbatVWgqiT3WP+M7rcGE
 KOhJIya4ZhIePkhTd+L+hd7TzGma+BGHFL9UOcwn984R/OwQrTaxPlCE7gsbeIbTjH4+LEnaAn
 teG7YXHYCpDuwSzVmQ2FW/9TIRv1EE/qyo49KXcdKrXL4wJzgwnSiqyEa4VlpnSfB+nAt5tAUW
 Cb/OnPRCo3nI1k9q5mZ5f04d
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:48 -0700
IronPort-SDR: tCiunZEryTfolYsIQxkM2hn3ItfmCMR/zHgIPpBwDmTXcxWrvCLI1rr0i/71sfka4qd7k6UzNN
 llv1IVGWr22lzDOJ8cRmoWQ6w/jfcn5PgQUwTcdMiZYPfL7lXV9alUKkGt+1lbl5U1UXMEPcOm
 0fAWF6Vkv628zteto713EXdDWCZWR70r7G+2jKWpwXXole/M9TjpCiQyemqA68TA/Yx0b4RU+L
 1dUI0540UKXQUSgGJU2ls+/T/1w43hDidyj+f0hy4lrY3iAsmfxUGtMVZ1Uerx8kd6tVeLiZ8d
 fac=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:24 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 14/26] btrfs-progs: zoned: calculate allocation offset for conventional zones
Date:   Mon, 26 Apr 2021 15:27:30 +0900
Message-Id: <5ea922c1b1410e0b41c0309106116927d77bdf5b.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Conventional zones do not have a write pointer, so we cannot use it to
determine the allocation offset for sequential allocation if a block group
contains a conventional zone.

But instead, we can consider the end of the highest addressed extent in the
block group for the allocation offset.

For new block group, we cannot calculate the allocation offset by
consulting the extent tree, because it can cause deadlock by taking extent
buffer lock after chunk mutex, which is already taken in
btrfs_make_block_group(). Since it is a new block group anyways, we can
simply set the allocation offset to 0.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/zoned.c | 85 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 79 insertions(+), 6 deletions(-)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 8b51115e667f..715a7881328c 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -654,6 +654,67 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 	return pos;
 }
 
+/*
+ * Calculate an allocation pointer from the extent allocation information
+ * for a block group consist of conventional zones. It is pointed to the
+ * end of the highest addressed extent in the block group as an allocation
+ * offset.
+ */
+static int calculate_alloc_pointer(struct btrfs_fs_info *fs_info,
+				   struct btrfs_block_group *cache,
+				   u64 *offset_ret)
+{
+	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_path *path;
+	struct btrfs_key key;
+	struct btrfs_key found_key;
+	int ret;
+	u64 length;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	key.objectid = cache->start + cache->length;
+	key.type = 0;
+	key.offset = 0;
+
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	/* We should not find the exact match */
+	if (!ret)
+		ret = -EUCLEAN;
+	if (ret < 0)
+		goto out;
+
+	ret = btrfs_previous_extent_item(root, path, cache->start);
+	if (ret) {
+		if (ret == 1) {
+			ret = 0;
+			*offset_ret = 0;
+		}
+		goto out;
+	}
+
+	btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0]);
+
+	if (found_key.type == BTRFS_EXTENT_ITEM_KEY)
+		length = found_key.offset;
+	else
+		length = fs_info->nodesize;
+
+	if (!(found_key.objectid >= cache->start &&
+	       found_key.objectid + length <= cache->start + cache->length)) {
+		ret = -EUCLEAN;
+		goto out;
+	}
+	*offset_ret = found_key.objectid + length - cache->start;
+	ret = 0;
+
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
 int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 				     struct btrfs_block_group *cache)
 {
@@ -667,6 +728,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 	int ret = 0;
 	int i;
 	u64 *alloc_offsets = NULL;
+	u64 last_alloc = 0;
 	u32 num_sequential = 0, num_conventional = 0;
 
 	if (!btrfs_is_zoned(fs_info))
@@ -752,12 +814,16 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 	}
 
 	if (num_conventional > 0) {
-		/*
-		 * Since conventional zones do not have a write pointer, we
-		 * cannot determine alloc_offset from the pointer
-		 */
-		ret = -EINVAL;
-		goto out;
+		ret = calculate_alloc_pointer(fs_info, cache, &last_alloc);
+		if (ret || map->num_stripes == num_conventional) {
+			if (!ret)
+				cache->alloc_offset = last_alloc;
+			else
+				error(
+		"zoned: failed to determine allocation offset of bg %llu",
+					  cache->start);
+			goto out;
+		}
 	}
 
 	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
@@ -779,6 +845,13 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 	}
 
 out:
+	/* An extent is allocated after the write pointer */
+	if (!ret && num_conventional && last_alloc > cache->alloc_offset) {
+		error("zoned: got wrong write pointer in BG %llu: %llu > %llu",
+		      logical, last_alloc, cache->alloc_offset);
+		ret = -EIO;
+	}
+
 	free(alloc_offsets);
 	return ret;
 }
-- 
2.31.1

