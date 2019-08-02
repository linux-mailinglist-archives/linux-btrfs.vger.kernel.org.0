Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEAB27FB37
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 15:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391659AbfHBNjg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 09:39:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:59972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391798AbfHBNjg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Aug 2019 09:39:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D359AFA4
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2019 13:39:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0FCB8DADC0; Fri,  2 Aug 2019 15:40:08 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 03/13] btrfs: factor sysfs code out of link_block_group
Date:   Fri,  2 Aug 2019 15:40:08 +0200
Message-Id: <10294f5a46ce3ca20dc621a649d3b5aea4ff5cbb.1564752900.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564752900.git.dsterba@suse.com>
References: <cover.1564752900.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The part of link_block_group that just creates the sysfs object is
independent and can be factored out to a helper.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c | 18 ++----------------
 fs/btrfs/sysfs.c       | 27 +++++++++++++++++++++++++++
 fs/btrfs/sysfs.h       |  1 +
 3 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 7f7a0530b0e2..8ac496fddc59 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -7777,7 +7777,6 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 static void link_block_group(struct btrfs_block_group_cache *cache)
 {
 	struct btrfs_space_info *space_info = cache->space_info;
-	struct btrfs_fs_info *fs_info = cache->fs_info;
 	int index = btrfs_bg_flags_to_raid_index(cache->flags);
 	bool first = false;
 
@@ -7787,21 +7786,8 @@ static void link_block_group(struct btrfs_block_group_cache *cache)
 	list_add_tail(&cache->list, &space_info->block_groups[index]);
 	up_write(&space_info->groups_sem);
 
-	if (first) {
-		struct raid_kobject *rkobj = kzalloc(sizeof(*rkobj), GFP_NOFS);
-		if (!rkobj) {
-			btrfs_warn(cache->fs_info,
-				"couldn't alloc memory for raid level kobject");
-			return;
-		}
-		rkobj->flags = cache->flags;
-		kobject_init(&rkobj->kobj, &btrfs_raid_ktype);
-
-		spin_lock(&fs_info->pending_raid_kobjs_lock);
-		list_add_tail(&rkobj->list, &fs_info->pending_raid_kobjs);
-		spin_unlock(&fs_info->pending_raid_kobjs_lock);
-		space_info->block_group_kobjs[index] = &rkobj->kobj;
-	}
+	if (first)
+		btrfs_sysfs_add_block_group_type(cache);
 }
 
 static struct btrfs_block_group_cache *
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index a6894b6c2623..008d58f618cd 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -757,6 +757,33 @@ void btrfs_add_raid_kobjects(struct btrfs_fs_info *fs_info)
 			   "failed to add kobject for block cache, ignoring");
 }
 
+/*
+ * Create a sysfs entry for a given block group type at path
+ * /sys/fs/btrfs/UUID/allocation/data/TYPE
+ */
+void btrfs_sysfs_add_block_group_type(struct btrfs_block_group_cache *cache)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct btrfs_space_info *space_info = cache->space_info;
+	struct raid_kobject *rkobj;
+	const int index = btrfs_bg_flags_to_raid_index(cache->flags);
+
+	rkobj = kzalloc(sizeof(*rkobj), GFP_NOFS);
+	if (!rkobj) {
+		btrfs_warn(cache->fs_info,
+				"couldn't alloc memory for raid level kobject");
+		return;
+	}
+
+	rkobj->flags = cache->flags;
+	kobject_init(&rkobj->kobj, &btrfs_raid_ktype);
+
+	spin_lock(&fs_info->pending_raid_kobjs_lock);
+	list_add_tail(&rkobj->list, &fs_info->pending_raid_kobjs);
+	spin_unlock(&fs_info->pending_raid_kobjs_lock);
+	space_info->block_group_kobjs[index] = &rkobj->kobj;
+}
+
 /* when one_device is NULL, it removes all device links */
 
 int btrfs_sysfs_rm_device_link(struct btrfs_fs_devices *fs_devices,
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index 25f028b65316..fa1b9bb5d320 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -103,5 +103,6 @@ void __cold btrfs_exit_sysfs(void);
 int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info);
 void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info);
 void btrfs_add_raid_kobjects(struct btrfs_fs_info *fs_info);
+void btrfs_sysfs_add_block_group_type(struct btrfs_block_group_cache *cache);
 
 #endif
-- 
2.22.0

