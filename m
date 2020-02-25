Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF2F116B84A
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 04:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgBYD5N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 22:57:13 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34231 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbgBYD5M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 22:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582603032; x=1614139032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4gKHM1cxWMBKItzCjnljwfJOG9PGvWyOJiXX2xNIIZ8=;
  b=nW0emgl7Vxo8ePStoL3wj/zieFzFnj85j5gRwAbyiHyUJyCqU3V3ebij
   dzYh7v6w6sQ2iq/TkW8UxFYKQdoBzKPidHyVvtyl1naBo7m8U0kQuAP4U
   44pMvhcLw1AZ5LWBm0DlvnwYv2wPpwmk8oD0sBgCEYyqyeEJRv71277U3
   VTqAAmL9+X7TDIkg1saXjab4VD3AnmtoAs24JFxOMIWTHIVQZbkTvJnvg
   HethIF1V+0tJ/Lm1rnMgmmakVYQWWaYM02ygL9aL66j8szahBtsupJEHx
   KoYeJ4kh7YJxyQaNIREnAygVdFNafOLwz6tN3MgxsexWaP0HlWoWtx0pK
   g==;
IronPort-SDR: 9vwUnehC9MBRJIU0HxOZKkWA89dLLOJKMIaa3CIuxvCy8+xFwl62KA8RBFtlCXDpVZS1BQWz6y
 6w+vQs9Kmc9pW88vTYdlDKQ7uKVz14UUEeGa6Ptcxmt9QtQGcfRB42XUO3v9+yXcg61wy+ycZI
 gnzAGSemz6Rr+sP3RKNFpMSYSNvl3EjmbB0WCOeFYDuGdXE4/Q6bWHRtmFun1lifhfkdFqa4IU
 eCt6Bd5ZpZXo5YOyfW9ygGurcjQVBYXixbQtAZBjE6WPiu5KN9Jjf50NkeyeIEbtP+iprXNP03
 Ufg=
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="131168287"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 11:57:07 +0800
IronPort-SDR: DCtrkvrxJ4Xg8CDNNDzch7h+BVKt/bWPJgLp3FNPzAIe2/3+e0PNuPTV2wONynXsYpCNvwYu2f
 GYn7dBOQrSQcPxSWvNRks/ZRnssSKYXqxF865MJNPUz3/XLM5XG5LapfV3/ZlqBesl13z3d68X
 8YUxg6gCSiFOkFlU9lOAGIkh1KWIJxruqc0fm5QgfjHanbAPNi175gVcIdubOdIwVoI/lbMybR
 p68nthHfIMK0zGeVXKTM9kMQ1GAurE9vXYpkYs8A+28kSZEs5OLjfLfkqDC0fhnGFwCJxKKfSS
 LmYKwOqNO+ZBJWrKSENTohK2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 19:49:35 -0800
IronPort-SDR: 5v3XTsPu6k/5tzaYXuOXjOx9IbKsQLpv5iKrgnHx27dj0Hjyh7bgc7dTqmTLb4hLdIP7Z+kUEN
 +a1UCMp3bTNLYgNHkEFqvjGf1zcGzyMp+vh/DMEvQkkxIBInf1PZbNAOl98AzKw0oMS7wpAvDj
 hrHf+JSuuhiyneLU6TaGP3z6rxY1jh0/s7w+RUsFAFP2Zl/mcP7Njj2F3WlbLwX8bJNC2CjCLG
 hDDWPcZQgBCk0NKts5Mp8hgQ0qmZqxIuuozoD3dX/ewEyLzUfzc6kyJHt0QwL8WukgeuoZj0Jh
 3Gs=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Feb 2020 19:57:06 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 09/21] btrfs: factor out create_chunk()
Date:   Tue, 25 Feb 2020 12:56:14 +0900
Message-Id: <20200225035626.1049501-10-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225035626.1049501-1-naohiro.aota@wdc.com>
References: <20200225035626.1049501-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Factor out create_chunk() from __btrfs_alloc_chunk(). This function finally
creates a chunk. There is no functional changes.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 132 ++++++++++++++++++++++++---------------------
 1 file changed, 71 insertions(+), 61 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fe194bc0bce3..cd854d6b8208 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5052,91 +5052,53 @@ static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
 	}
 }
 
-static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
-			       u64 start, u64 type)
+static int create_chunk(struct btrfs_trans_handle *trans,
+			struct alloc_chunk_ctl *ctl,
+			struct btrfs_device_info *devices_info)
 {
 	struct btrfs_fs_info *info = trans->fs_info;
-	struct btrfs_fs_devices *fs_devices = info->fs_devices;
 	struct map_lookup *map = NULL;
 	struct extent_map_tree *em_tree;
 	struct extent_map *em;
-	struct btrfs_device_info *devices_info = NULL;
-	struct alloc_chunk_ctl ctl;
+	u64 start = ctl->start;
+	u64 type = ctl->type;
 	int ret;
 	int i;
 	int j;
 
-	if (!alloc_profile_is_valid(type, 0)) {
-		ASSERT(0);
-		return -EINVAL;
-	}
-
-	if (list_empty(&fs_devices->alloc_list)) {
-		if (btrfs_test_opt(info, ENOSPC_DEBUG))
-			btrfs_debug(info, "%s: no writable device", __func__);
-		return -ENOSPC;
-	}
-
-	if (!(type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
-		btrfs_err(info, "invalid chunk type 0x%llx requested", type);
-		ASSERT(0);
-		return -EINVAL;
-	}
-
-	ctl.start = start;
-	ctl.type = type;
-	init_alloc_chunk_ctl(fs_devices, &ctl);
-
-	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
-			       GFP_NOFS);
-	if (!devices_info)
+	map = kmalloc(map_lookup_size(ctl->num_stripes), GFP_NOFS);
+	if (!map)
 		return -ENOMEM;
+	map->num_stripes = ctl->num_stripes;
 
-	ret = gather_device_info(fs_devices, &ctl, devices_info);
-	if (ret < 0)
-		goto error;
-
-	ret = decide_stripe_size(fs_devices, &ctl, devices_info);
-	if (ret < 0)
-		goto error;
-
-	map = kmalloc(map_lookup_size(ctl.num_stripes), GFP_NOFS);
-	if (!map) {
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	map->num_stripes = ctl.num_stripes;
-
-	for (i = 0; i < ctl.ndevs; ++i) {
-		for (j = 0; j < ctl.dev_stripes; ++j) {
-			int s = i * ctl.dev_stripes + j;
+	for (i = 0; i < ctl->ndevs; ++i) {
+		for (j = 0; j < ctl->dev_stripes; ++j) {
+			int s = i * ctl->dev_stripes + j;
 			map->stripes[s].dev = devices_info[i].dev;
 			map->stripes[s].physical = devices_info[i].dev_offset +
-						   j * ctl.stripe_size;
+						   j * ctl->stripe_size;
 		}
 	}
 	map->stripe_len = BTRFS_STRIPE_LEN;
 	map->io_align = BTRFS_STRIPE_LEN;
 	map->io_width = BTRFS_STRIPE_LEN;
 	map->type = type;
-	map->sub_stripes = ctl.sub_stripes;
+	map->sub_stripes = ctl->sub_stripes;
 
-	trace_btrfs_chunk_alloc(info, map, start, ctl.chunk_size);
+	trace_btrfs_chunk_alloc(info, map, start, ctl->chunk_size);
 
 	em = alloc_extent_map();
 	if (!em) {
 		kfree(map);
-		ret = -ENOMEM;
-		goto error;
+		return -ENOMEM;
 	}
 	set_bit(EXTENT_FLAG_FS_MAPPING, &em->flags);
 	em->map_lookup = map;
 	em->start = start;
-	em->len = ctl.chunk_size;
+	em->len = ctl->chunk_size;
 	em->block_start = 0;
 	em->block_len = em->len;
-	em->orig_block_len = ctl.stripe_size;
+	em->orig_block_len = ctl->stripe_size;
 
 	em_tree = &info->mapping_tree;
 	write_lock(&em_tree->lock);
@@ -5144,11 +5106,11 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	if (ret) {
 		write_unlock(&em_tree->lock);
 		free_extent_map(em);
-		goto error;
+		return ret;
 	}
 	write_unlock(&em_tree->lock);
 
-	ret = btrfs_make_block_group(trans, 0, type, start, ctl.chunk_size);
+	ret = btrfs_make_block_group(trans, 0, type, start, ctl->chunk_size);
 	if (ret)
 		goto error_del_extent;
 
@@ -5156,20 +5118,19 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		struct btrfs_device *dev = map->stripes[i].dev;
 
 		btrfs_device_set_bytes_used(dev,
-					    dev->bytes_used + ctl.stripe_size);
+					    dev->bytes_used + ctl->stripe_size);
 		if (list_empty(&dev->post_commit_list))
 			list_add_tail(&dev->post_commit_list,
 				      &trans->transaction->dev_update_list);
 	}
 
-	atomic64_sub(ctl.stripe_size * map->num_stripes,
+	atomic64_sub(ctl->stripe_size * map->num_stripes,
 		     &info->free_chunk_space);
 
 	free_extent_map(em);
 	check_raid56_incompat_flag(info, type);
 	check_raid1c34_incompat_flag(info, type);
 
-	kfree(devices_info);
 	return 0;
 
 error_del_extent:
@@ -5181,7 +5142,56 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	free_extent_map(em);
 	/* One for the tree reference */
 	free_extent_map(em);
-error:
+
+	return ret;
+}
+
+static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
+			       u64 start, u64 type)
+{
+	struct btrfs_fs_info *info = trans->fs_info;
+	struct btrfs_fs_devices *fs_devices = info->fs_devices;
+	struct btrfs_device_info *devices_info = NULL;
+	struct alloc_chunk_ctl ctl;
+	int ret;
+
+	if (!alloc_profile_is_valid(type, 0)) {
+		ASSERT(0);
+		return -EINVAL;
+	}
+
+	if (list_empty(&fs_devices->alloc_list)) {
+		if (btrfs_test_opt(info, ENOSPC_DEBUG))
+			btrfs_debug(info, "%s: no writable device", __func__);
+		return -ENOSPC;
+	}
+
+	if (!(type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
+		btrfs_err(info, "invalid chunk type 0x%llx requested", type);
+		ASSERT(0);
+		return -EINVAL;
+	}
+
+	ctl.start = start;
+	ctl.type = type;
+	init_alloc_chunk_ctl(fs_devices, &ctl);
+
+	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
+			       GFP_NOFS);
+	if (!devices_info)
+		return -ENOMEM;
+
+	ret = gather_device_info(fs_devices, &ctl, devices_info);
+	if (ret < 0)
+		goto out;
+
+	ret = decide_stripe_size(fs_devices, &ctl, devices_info);
+	if (ret < 0)
+		goto out;
+
+	ret = create_chunk(trans, &ctl, devices_info);
+
+out:
 	kfree(devices_info);
 	return ret;
 }
-- 
2.25.1

