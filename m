Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC8A37FB34
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 15:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389014AbfHBNja (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 09:39:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:59948 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbfHBNja (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Aug 2019 09:39:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B2D1B62C
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2019 13:39:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6600CDADC0; Fri,  2 Aug 2019 15:40:03 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 01/13] btrfs: move sysfs declarations out of ctree.h
Date:   Fri,  2 Aug 2019 15:40:03 +0200
Message-Id: <153556e369e93da23de32eebe56418ac5142ae9c.1564752900.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564752900.git.dsterba@suse.com>
References: <cover.1564752900.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As the header for sysfs code already exists, use it to clean up ctree.h.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h | 13 -------------
 fs/btrfs/super.c |  1 +
 fs/btrfs/sysfs.h | 12 ++++++++++++
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1110bbd4bffb..894a249b2182 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -397,13 +397,6 @@ struct btrfs_dev_replace {
 	wait_queue_head_t replace_wait;
 };
 
-/* For raid type sysfs entries */
-struct raid_kobject {
-	u64 flags;
-	struct kobject kobj;
-	struct list_head list;
-};
-
 /*
  * free clusters are used to claim free space in relatively large chunks,
  * allowing us to do less seeky writes. They are used for all metadata
@@ -3265,12 +3258,6 @@ loff_t btrfs_remap_file_range(struct file *file_in, loff_t pos_in,
 int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
 			struct btrfs_root *root);
 
-/* sysfs.c */
-int __init btrfs_init_sysfs(void);
-void __cold btrfs_exit_sysfs(void);
-int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info);
-void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info);
-
 /* super.c */
 int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			unsigned long new_flags);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 10bc7e6cca75..69eaa198e51e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -43,6 +43,7 @@
 #include "free-space-cache.h"
 #include "backref.h"
 #include "space-info.h"
+#include "sysfs.h"
 #include "tests/btrfs-tests.h"
 
 #include "qgroup.h"
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index 40716b357c1d..f9fc7101e696 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -40,6 +40,13 @@ struct btrfs_feature_attr {
 	u64 feature_bit;
 };
 
+/* For raid type sysfs entries */
+struct raid_kobject {
+	u64 flags;
+	struct kobject kobj;
+	struct list_head list;
+};
+
 #define BTRFS_FEAT_ATTR(_name, _feature_set, _feature_prefix, _feature_bit)  \
 static struct btrfs_feature_attr btrfs_attr_features_##_name = {	     \
 	.kobj_attr = __INIT_KOBJ_ATTR(_name, S_IRUGO,			     \
@@ -91,4 +98,9 @@ void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
 		u64 bit, enum btrfs_feature_set set);
 
+int __init btrfs_init_sysfs(void);
+void __cold btrfs_exit_sysfs(void);
+int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info);
+void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info);
+
 #endif
-- 
2.22.0

