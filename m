Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B0F45B775
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 10:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbhKXJeM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 04:34:12 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32168 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbhKXJeL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637746262; x=1669282262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=clz0LjFMhfffqOoOspmRUz9Up0K3CBqv5S3kMZP40Y4=;
  b=pawJ+7MP0EafhTVgzkixEPzmXgOzS+jZum0VOYfARJ6IkYIhXyBiPHjS
   WG5BUAssU95TpVx1s1XG7Okc26tAKzvbgrY2ydF4582qZ2cRJHpUm2TvK
   4hqxaBeTydlUaP1UqDR+vBeWm3JQk/zks9T4rR1SgHAGWTrEemF+Qytfm
   FC5L2Ns3LW0CLG1bNhTf/btFh8cedrfBQzwgLUVYAT02R6WBrezo7YXjb
   TwkLgDI8UQg94WotAaoKUOgvv29eq0UcM2VAQkwJb20Qms963o9zAR/VN
   19p7aEAoRsbzyVRiLh6qpjqhLOAFaWvWgOQfg7mvkrtYtJzfEtuqe8xG1
   A==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631548800"; 
   d="scan'208";a="185499366"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 17:31:02 +0800
IronPort-SDR: 4nn4mynbNcFtVsm1US+oKyjw6DI9snua3ui3a2XZhjS6L2YDWH5Q5GGcQiyfUjPiuPiwd/gdQp
 JQYOg7t7CkvnHXiju5h/W9bql59GbEPon6mSR+RXjo2QGzWk5rxa767dz9Dic4wOg1fC0JSX08
 jvw9piccq9dcQUv8B81vwgUfhH+9Nxc0gED1vk9LI7o7za23j/NzSEAEifyx4qZZGqyb84w22x
 F+y7EHClFNM5rgSCn9P1oZDHVeAQw7i/KUEto6vlsczpacAWjN3Ys6C6AvZGpPzJuEZd08uru0
 3Q081h9RlQ7oEeC/DCXSHUmC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:05:55 -0800
IronPort-SDR: XY7KbriBlM553W8tCot7rlqn/PKrp4G72bwwfHwxWm3qANfatkBPLSfOHjwYi3rRJtl4Yd+2tv
 iMyPf4mjPfA8JUW9nboXdIKBc9lEzzZsuMbBWiqHgxUMY+PorqnAaRzakapTP/yKk1KEG+/7EQ
 elGM14mABNiAuQcDOFxjYDEuXc8j9N5jkjDrI6YxfBNY1oXrLWhUBSOaXfG5pkZzLR8mecOuBu
 3YrV6tRxcXNsJCyT6oH4p/o0ZaoY6VKijirImxuwoW8p+KljKT4JaWuMefUtsOxhHYXuzdiFaA
 1Jw=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2021 01:31:01 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 06/21] btrfs: zoned: move mark_block_group_to_copy to zoned code
Date:   Wed, 24 Nov 2021 01:30:32 -0800
Message-Id: <7515f0e28e89b7c2266bfcc021f9639dd45ae898.1637745470.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637745470.git.johannes.thumshirn@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

mark_block_group_to_copy() is only used in zoned filesystems, so move the
code to zoned code.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/dev-replace.c | 126 +----------------------------------------
 fs/btrfs/zoned.c       | 124 ++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |   8 +++
 3 files changed, 133 insertions(+), 125 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 66fa61cb3f235..7572d80bff2ac 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -460,130 +460,6 @@ static char* btrfs_dev_name(struct btrfs_device *device)
 		return rcu_str_deref(device->name);
 }
 
-static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
-				    struct btrfs_device *src_dev)
-{
-	struct btrfs_path *path;
-	struct btrfs_key key;
-	struct btrfs_key found_key;
-	struct btrfs_root *root = fs_info->dev_root;
-	struct btrfs_dev_extent *dev_extent = NULL;
-	struct btrfs_block_group *cache;
-	struct btrfs_trans_handle *trans;
-	int ret = 0;
-	u64 chunk_offset;
-
-	/* Do not use "to_copy" on non zoned filesystem for now */
-	if (!btrfs_is_zoned(fs_info))
-		return 0;
-
-	mutex_lock(&fs_info->chunk_mutex);
-
-	/* Ensure we don't have pending new block group */
-	spin_lock(&fs_info->trans_lock);
-	while (fs_info->running_transaction &&
-	       !list_empty(&fs_info->running_transaction->dev_update_list)) {
-		spin_unlock(&fs_info->trans_lock);
-		mutex_unlock(&fs_info->chunk_mutex);
-		trans = btrfs_attach_transaction(root);
-		if (IS_ERR(trans)) {
-			ret = PTR_ERR(trans);
-			mutex_lock(&fs_info->chunk_mutex);
-			if (ret == -ENOENT) {
-				spin_lock(&fs_info->trans_lock);
-				continue;
-			} else {
-				goto unlock;
-			}
-		}
-
-		ret = btrfs_commit_transaction(trans);
-		mutex_lock(&fs_info->chunk_mutex);
-		if (ret)
-			goto unlock;
-
-		spin_lock(&fs_info->trans_lock);
-	}
-	spin_unlock(&fs_info->trans_lock);
-
-	path = btrfs_alloc_path();
-	if (!path) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
-
-	path->reada = READA_FORWARD;
-	path->search_commit_root = 1;
-	path->skip_locking = 1;
-
-	key.objectid = src_dev->devid;
-	key.type = BTRFS_DEV_EXTENT_KEY;
-	key.offset = 0;
-
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		goto free_path;
-	if (ret > 0) {
-		if (path->slots[0] >=
-		    btrfs_header_nritems(path->nodes[0])) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				goto free_path;
-			if (ret > 0) {
-				ret = 0;
-				goto free_path;
-			}
-		} else {
-			ret = 0;
-		}
-	}
-
-	while (1) {
-		struct extent_buffer *leaf = path->nodes[0];
-		int slot = path->slots[0];
-
-		btrfs_item_key_to_cpu(leaf, &found_key, slot);
-
-		if (found_key.objectid != src_dev->devid)
-			break;
-
-		if (found_key.type != BTRFS_DEV_EXTENT_KEY)
-			break;
-
-		if (found_key.offset < key.offset)
-			break;
-
-		dev_extent = btrfs_item_ptr(leaf, slot, struct btrfs_dev_extent);
-
-		chunk_offset = btrfs_dev_extent_chunk_offset(leaf, dev_extent);
-
-		cache = btrfs_lookup_block_group(fs_info, chunk_offset);
-		if (!cache)
-			goto skip;
-
-		spin_lock(&cache->lock);
-		cache->to_copy = 1;
-		spin_unlock(&cache->lock);
-
-		btrfs_put_block_group(cache);
-
-skip:
-		ret = btrfs_next_item(root, path);
-		if (ret != 0) {
-			if (ret > 0)
-				ret = 0;
-			break;
-		}
-	}
-
-free_path:
-	btrfs_free_path(path);
-unlock:
-	mutex_unlock(&fs_info->chunk_mutex);
-
-	return ret;
-}
-
 bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
 				      struct btrfs_block_group *cache,
 				      u64 physical)
@@ -680,7 +556,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	if (ret)
 		return ret;
 
-	ret = mark_block_group_to_copy(fs_info, src_device);
+	ret = btrfs_mark_block_group_to_copy(fs_info, src_device);
 	if (ret)
 		return ret;
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index b0ab38a2e776e..73bfe30691b01 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2035,3 +2035,127 @@ void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info)
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
 }
+
+int btrfs_mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
+				    struct btrfs_device *src_dev)
+{
+	struct btrfs_path *path;
+	struct btrfs_key key;
+	struct btrfs_key found_key;
+	struct btrfs_root *root = fs_info->dev_root;
+	struct btrfs_dev_extent *dev_extent = NULL;
+	struct btrfs_block_group *cache;
+	struct btrfs_trans_handle *trans;
+	int ret = 0;
+	u64 chunk_offset;
+
+	/* Do not use "to_copy" on non zoned filesystem for now */
+	if (!btrfs_is_zoned(fs_info))
+		return 0;
+
+	mutex_lock(&fs_info->chunk_mutex);
+
+	/* Ensure we don't have pending new block group */
+	spin_lock(&fs_info->trans_lock);
+	while (fs_info->running_transaction &&
+	       !list_empty(&fs_info->running_transaction->dev_update_list)) {
+		spin_unlock(&fs_info->trans_lock);
+		mutex_unlock(&fs_info->chunk_mutex);
+		trans = btrfs_attach_transaction(root);
+		if (IS_ERR(trans)) {
+			ret = PTR_ERR(trans);
+			mutex_lock(&fs_info->chunk_mutex);
+			if (ret == -ENOENT) {
+				spin_lock(&fs_info->trans_lock);
+				continue;
+			} else {
+				goto unlock;
+			}
+		}
+
+		ret = btrfs_commit_transaction(trans);
+		mutex_lock(&fs_info->chunk_mutex);
+		if (ret)
+			goto unlock;
+
+		spin_lock(&fs_info->trans_lock);
+	}
+	spin_unlock(&fs_info->trans_lock);
+
+	path = btrfs_alloc_path();
+	if (!path) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	path->reada = READA_FORWARD;
+	path->search_commit_root = 1;
+	path->skip_locking = 1;
+
+	key.objectid = src_dev->devid;
+	key.type = BTRFS_DEV_EXTENT_KEY;
+	key.offset = 0;
+
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	if (ret < 0)
+		goto free_path;
+	if (ret > 0) {
+		if (path->slots[0] >=
+		    btrfs_header_nritems(path->nodes[0])) {
+			ret = btrfs_next_leaf(root, path);
+			if (ret < 0)
+				goto free_path;
+			if (ret > 0) {
+				ret = 0;
+				goto free_path;
+			}
+		} else {
+			ret = 0;
+		}
+	}
+
+	while (1) {
+		struct extent_buffer *leaf = path->nodes[0];
+		int slot = path->slots[0];
+
+		btrfs_item_key_to_cpu(leaf, &found_key, slot);
+
+		if (found_key.objectid != src_dev->devid)
+			break;
+
+		if (found_key.type != BTRFS_DEV_EXTENT_KEY)
+			break;
+
+		if (found_key.offset < key.offset)
+			break;
+
+		dev_extent = btrfs_item_ptr(leaf, slot, struct btrfs_dev_extent);
+
+		chunk_offset = btrfs_dev_extent_chunk_offset(leaf, dev_extent);
+
+		cache = btrfs_lookup_block_group(fs_info, chunk_offset);
+		if (!cache)
+			goto skip;
+
+		spin_lock(&cache->lock);
+		cache->to_copy = 1;
+		spin_unlock(&cache->lock);
+
+		btrfs_put_block_group(cache);
+
+skip:
+		ret = btrfs_next_item(root, path);
+		if (ret != 0) {
+			if (ret > 0)
+				ret = 0;
+			break;
+		}
+	}
+
+free_path:
+	btrfs_free_path(path);
+unlock:
+	mutex_unlock(&fs_info->chunk_mutex);
+
+	return ret;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 8e8f36c1d28a4..e2309e3b3d7b8 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -79,6 +79,8 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical,
 			     u64 length);
 void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg);
 void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info);
+int btrfs_mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
+				    struct btrfs_device *src_dev);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -237,6 +239,12 @@ static inline void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info,
 static inline void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg) { }
 
 static inline void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info) { }
+
+static inline int btrfs_mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
+						 struct btrfs_device *src_dev)
+{
+	return 0;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.31.1

