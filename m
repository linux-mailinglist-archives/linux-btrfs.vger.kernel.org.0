Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A05A27FB39
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 15:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393942AbfHBNjk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 09:39:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:60050 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391928AbfHBNjk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Aug 2019 09:39:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D292FAFA4
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2019 13:39:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ADF0EDADC0; Fri,  2 Aug 2019 15:40:12 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 05/13] btrfs: factor out sysfs code for creating space infos
Date:   Fri,  2 Aug 2019 15:40:12 +0200
Message-Id: <1b744f678db69e7c5464630c0bfe119c9cc02349.1564752900.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564752900.git.dsterba@suse.com>
References: <cover.1564752900.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Move creation of data/metadata/system space info directories to sysfs.c.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/space-info.c | 25 ++-----------------------
 fs/btrfs/sysfs.c      | 37 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/sysfs.h      |  2 ++
 3 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index ab7b9ec4c240..061a216ff966 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -33,23 +33,6 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
 	rcu_read_unlock();
 }
 
-static const char *alloc_name(u64 flags)
-{
-	switch (flags) {
-	case BTRFS_BLOCK_GROUP_METADATA|BTRFS_BLOCK_GROUP_DATA:
-		return "mixed";
-	case BTRFS_BLOCK_GROUP_METADATA:
-		return "metadata";
-	case BTRFS_BLOCK_GROUP_DATA:
-		return "data";
-	case BTRFS_BLOCK_GROUP_SYSTEM:
-		return "system";
-	default:
-		WARN_ON(1);
-		return "invalid-combination";
-	};
-}
-
 static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 {
 
@@ -79,13 +62,9 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 	INIT_LIST_HEAD(&space_info->tickets);
 	INIT_LIST_HEAD(&space_info->priority_tickets);
 
-	ret = kobject_init_and_add(&space_info->kobj, &space_info_ktype,
-				    info->space_info_kobj, "%s",
-				    alloc_name(space_info->flags));
-	if (ret) {
-		kobject_put(&space_info->kobj);
+	ret = btrfs_sysfs_add_space_info_type(info, space_info);
+	if (ret)
 		return ret;
-	}
 
 	list_add_rcu(&space_info->list, &info->space_info);
 	if (flags & BTRFS_BLOCK_GROUP_DATA)
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 25097d6cf2ca..24aaac281580 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -784,6 +784,43 @@ void btrfs_sysfs_add_block_group_type(struct btrfs_block_group_cache *cache)
 	space_info->block_group_kobjs[index] = &rkobj->kobj;
 }
 
+static const char *alloc_name(u64 flags)
+{
+	switch (flags) {
+	case BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA:
+		return "mixed";
+	case BTRFS_BLOCK_GROUP_METADATA:
+		return "metadata";
+	case BTRFS_BLOCK_GROUP_DATA:
+		return "data";
+	case BTRFS_BLOCK_GROUP_SYSTEM:
+		return "system";
+	default:
+		WARN_ON(1);
+		return "invalid-combination";
+	};
+}
+
+/*
+ * Create a sysfs entry for a space info type at path
+ * /sys/fs/btrfs/UUID/allocation/TYPE
+ */
+int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
+				    struct btrfs_space_info *space_info)
+{
+	int ret;
+
+	ret = kobject_init_and_add(&space_info->kobj, &space_info_ktype,
+				   fs_info->space_info_kobj, "%s",
+				   alloc_name(space_info->flags));
+	if (ret) {
+		kobject_put(&space_info->kobj);
+		return ret;
+	}
+
+	return 0;
+}
+
 /* when one_device is NULL, it removes all device links */
 
 int btrfs_sysfs_rm_device_link(struct btrfs_fs_devices *fs_devices,
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index 7f659ce7be84..928c8ab37fd9 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -103,5 +103,7 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info);
 void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info);
 void btrfs_add_raid_kobjects(struct btrfs_fs_info *fs_info);
 void btrfs_sysfs_add_block_group_type(struct btrfs_block_group_cache *cache);
+int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
+				    struct btrfs_space_info *space_info);
 
 #endif
-- 
2.22.0

