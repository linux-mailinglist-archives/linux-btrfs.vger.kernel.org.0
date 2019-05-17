Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02DF521674
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 11:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfEQJmn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 05:42:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:33370 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729019AbfEQJmn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 05:42:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9BF1FAECD
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2019 09:42:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4712CDA871; Fri, 17 May 2019 11:43:41 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 13/15] btrfs: refactor helper for bg flags to name conversion
Date:   Fri, 17 May 2019 11:43:41 +0200
Message-Id: <ee614925f1ed1e597a556d7e154897b6dfb63e3b.1558085801.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558085801.git.dsterba@suse.com>
References: <cover.1558085801.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The helper lacks the btrfs_ prefix and the parameter is the raw
blockgroup type, so none of the callers has to do the flags -> index
conversion.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c |  4 +---
 fs/btrfs/volumes.c     | 34 +++++++++++++---------------------
 fs/btrfs/volumes.h     |  3 +--
 3 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 37d7e5261079..436c53a105a5 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -10134,7 +10134,6 @@ void btrfs_add_raid_kobjects(struct btrfs_fs_info *fs_info)
 	struct btrfs_space_info *space_info;
 	struct raid_kobject *rkobj;
 	LIST_HEAD(list);
-	int index;
 	int ret = 0;
 
 	spin_lock(&fs_info->pending_raid_kobjs_lock);
@@ -10143,10 +10142,9 @@ void btrfs_add_raid_kobjects(struct btrfs_fs_info *fs_info)
 
 	list_for_each_entry(rkobj, &list, list) {
 		space_info = __find_space_info(fs_info, rkobj->flags);
-		index = btrfs_bg_flags_to_raid_index(rkobj->flags);
 
 		ret = kobject_add(&rkobj->kobj, &space_info->kobj,
-				  "%s", get_raid_name(index));
+				"%s", btrfs_bg_type_to_raid_name(rkobj->flags));
 		if (ret) {
 			kobject_put(&rkobj->kobj);
 			break;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9ee35fe9ee0f..a8bf76d5f8e6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -123,12 +123,14 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 	},
 };
 
-const char *get_raid_name(enum btrfs_raid_types type)
+const char *btrfs_bg_type_to_raid_name(u64 flags)
 {
-	if (type >= BTRFS_NR_RAID_TYPES)
+	const int index = btrfs_bg_flags_to_raid_index(flags);
+
+	if (index >= BTRFS_NR_RAID_TYPES)
 		return NULL;
 
-	return btrfs_raid_array[type].raid_name;
+	return btrfs_raid_array[index].raid_name;
 }
 
 /*
@@ -3926,11 +3928,9 @@ static void describe_balance_args(struct btrfs_balance_args *bargs, char *buf,
 		bp += ret;						\
 	} while (0)
 
-	if (flags & BTRFS_BALANCE_ARGS_CONVERT) {
-		int index = btrfs_bg_flags_to_raid_index(bargs->target);
-
-		CHECK_APPEND_1ARG("convert=%s,", get_raid_name(index));
-	}
+	if (flags & BTRFS_BALANCE_ARGS_CONVERT)
+		CHECK_APPEND_1ARG("convert=%s,",
+				  btrfs_bg_type_to_raid_name(bargs->target));
 
 	if (flags & BTRFS_BALANCE_ARGS_SOFT)
 		CHECK_APPEND_NOARG("soft,");
@@ -4088,29 +4088,23 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 			allowed |= btrfs_raid_array[i].bg_flag;
 
 	if (validate_convert_profile(&bctl->data, allowed)) {
-		int index = btrfs_bg_flags_to_raid_index(bctl->data.target);
-
 		btrfs_err(fs_info,
 			  "balance: invalid convert data profile %s",
-			  get_raid_name(index));
+			  btrfs_bg_type_to_raid_name(bctl->data.target));
 		ret = -EINVAL;
 		goto out;
 	}
 	if (validate_convert_profile(&bctl->meta, allowed)) {
-		int index = btrfs_bg_flags_to_raid_index(bctl->meta.target);
-
 		btrfs_err(fs_info,
 			  "balance: invalid convert metadata profile %s",
-			  get_raid_name(index));
+			  btrfs_bg_type_to_raid_name(bctl->meta.target));
 		ret = -EINVAL;
 		goto out;
 	}
 	if (validate_convert_profile(&bctl->sys, allowed)) {
-		int index = btrfs_bg_flags_to_raid_index(bctl->sys.target);
-
 		btrfs_err(fs_info,
 			  "balance: invalid convert system profile %s",
-			  get_raid_name(index));
+			  btrfs_bg_type_to_raid_name(bctl->sys.target));
 		ret = -EINVAL;
 		goto out;
 	}
@@ -4159,12 +4153,10 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 
 	if (btrfs_get_num_tolerated_disk_barrier_failures(meta_target) <
 		btrfs_get_num_tolerated_disk_barrier_failures(data_target)) {
-		int meta_index = btrfs_bg_flags_to_raid_index(meta_target);
-		int data_index = btrfs_bg_flags_to_raid_index(data_target);
-
 		btrfs_warn(fs_info,
 	"balance: metadata profile %s has lower redundancy than data profile %s",
-			   get_raid_name(meta_index), get_raid_name(data_index));
+				btrfs_bg_type_to_raid_name(meta_target),
+				btrfs_bg_type_to_raid_name(data_target));
 	}
 
 	ret = insert_balance_item(fs_info, bctl);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 73520a6ed90a..4a7a4d90ded8 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -556,8 +556,6 @@ static inline enum btrfs_raid_types btrfs_bg_flags_to_raid_index(u64 flags)
 	return BTRFS_RAID_SINGLE; /* BTRFS_BLOCK_GROUP_SINGLE */
 }
 
-const char *get_raid_name(enum btrfs_raid_types type);
-
 void btrfs_commit_device_sizes(struct btrfs_transaction *trans);
 
 struct list_head *btrfs_get_fs_uuids(void);
@@ -567,6 +565,7 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 					struct btrfs_device *failing_dev);
 
 int btrfs_bg_type_to_factor(u64 flags);
+const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
 
 #endif
-- 
2.21.0

