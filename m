Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 509847FB35
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 15:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391746AbfHBNje (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 09:39:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:59966 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbfHBNjd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Aug 2019 09:39:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D1802AFA4
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2019 13:39:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B710FDADC0; Fri,  2 Aug 2019 15:40:05 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 02/13] btrfs: move btrfs_add_raid_kobjects to sysfs.c
Date:   Fri,  2 Aug 2019 15:40:05 +0200
Message-Id: <71752794404c1147f258e70918cb21d33deea171.1564752900.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564752900.git.dsterba@suse.com>
References: <cover.1564752900.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function manipulates sysfs entries so this belongs to sysfs.c.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h       |  1 -
 fs/btrfs/extent-tree.c | 27 ---------------------------
 fs/btrfs/sysfs.c       | 27 +++++++++++++++++++++++++++
 fs/btrfs/sysfs.h       |  1 +
 4 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 894a249b2182..a61bf19a7ef6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2700,7 +2700,6 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info);
 int btrfs_make_block_group(struct btrfs_trans_handle *trans,
 			   u64 bytes_used, u64 type, u64 chunk_offset,
 			   u64 size);
-void btrfs_add_raid_kobjects(struct btrfs_fs_info *fs_info);
 struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
 				struct btrfs_fs_info *fs_info,
 				const u64 chunk_offset);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 81f109357050..7f7a0530b0e2 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -7774,33 +7774,6 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 	return 0;
 }
 
-/* link_block_group will queue up kobjects to add when we're reclaim-safe */
-void btrfs_add_raid_kobjects(struct btrfs_fs_info *fs_info)
-{
-	struct btrfs_space_info *space_info;
-	struct raid_kobject *rkobj;
-	LIST_HEAD(list);
-	int ret = 0;
-
-	spin_lock(&fs_info->pending_raid_kobjs_lock);
-	list_splice_init(&fs_info->pending_raid_kobjs, &list);
-	spin_unlock(&fs_info->pending_raid_kobjs_lock);
-
-	list_for_each_entry(rkobj, &list, list) {
-		space_info = btrfs_find_space_info(fs_info, rkobj->flags);
-
-		ret = kobject_add(&rkobj->kobj, &space_info->kobj,
-				"%s", btrfs_bg_type_to_raid_name(rkobj->flags));
-		if (ret) {
-			kobject_put(&rkobj->kobj);
-			break;
-		}
-	}
-	if (ret)
-		btrfs_warn(fs_info,
-			   "failed to add kobject for block cache, ignoring");
-}
-
 static void link_block_group(struct btrfs_block_group_cache *cache)
 {
 	struct btrfs_space_info *space_info = cache->space_info;
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 9539f8143b7a..a6894b6c2623 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -730,6 +730,33 @@ static void init_feature_attrs(void)
 	}
 }
 
+/* link_block_group will queue up kobjects to add when we're reclaim-safe */
+void btrfs_add_raid_kobjects(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_space_info *space_info;
+	struct raid_kobject *rkobj;
+	LIST_HEAD(list);
+	int ret = 0;
+
+	spin_lock(&fs_info->pending_raid_kobjs_lock);
+	list_splice_init(&fs_info->pending_raid_kobjs, &list);
+	spin_unlock(&fs_info->pending_raid_kobjs_lock);
+
+	list_for_each_entry(rkobj, &list, list) {
+		space_info = btrfs_find_space_info(fs_info, rkobj->flags);
+
+		ret = kobject_add(&rkobj->kobj, &space_info->kobj,
+				"%s", btrfs_bg_type_to_raid_name(rkobj->flags));
+		if (ret) {
+			kobject_put(&rkobj->kobj);
+			break;
+		}
+	}
+	if (ret)
+		btrfs_warn(fs_info,
+			   "failed to add kobject for block cache, ignoring");
+}
+
 /* when one_device is NULL, it removes all device links */
 
 int btrfs_sysfs_rm_device_link(struct btrfs_fs_devices *fs_devices,
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index f9fc7101e696..25f028b65316 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -102,5 +102,6 @@ int __init btrfs_init_sysfs(void);
 void __cold btrfs_exit_sysfs(void);
 int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info);
 void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info);
+void btrfs_add_raid_kobjects(struct btrfs_fs_info *fs_info);
 
 #endif
-- 
2.22.0

