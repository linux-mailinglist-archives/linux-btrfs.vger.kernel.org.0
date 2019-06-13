Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E35B43EFC
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2019 17:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbfFMPyQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jun 2019 11:54:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:55586 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731581AbfFMPyQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jun 2019 11:54:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7EFD7ABD4
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2019 15:54:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D6D8EDA897; Thu, 13 Jun 2019 17:55:04 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: improve messages when updating feature flags
Date:   Thu, 13 Jun 2019 17:55:03 +0200
Message-Id: <20190613155503.20814-1-dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently the messages printed after setting an incompat feature are
cryptis, we can easily make it better as the textual description is
passed to the helpers. Old:

  setting 128 feature flag

updated:

  setting incompat feature flag for RAID56 (0x80)

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index fb7435533478..6df4911c8f8d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3620,10 +3620,11 @@ do {									\
 /* compatibility and incompatibility defines */
 
 #define btrfs_set_fs_incompat(__fs_info, opt) \
-	__btrfs_set_fs_incompat((__fs_info), BTRFS_FEATURE_INCOMPAT_##opt)
+	__btrfs_set_fs_incompat((__fs_info), BTRFS_FEATURE_INCOMPAT_##opt, \
+				#opt)
 
 static inline void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info,
-					   u64 flag)
+					   u64 flag, const char* name)
 {
 	struct btrfs_super_block *disk_super;
 	u64 features;
@@ -3636,18 +3637,20 @@ static inline void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info,
 		if (!(features & flag)) {
 			features |= flag;
 			btrfs_set_super_incompat_flags(disk_super, features);
-			btrfs_info(fs_info, "setting %llu feature flag",
-					 flag);
+			btrfs_info(fs_info,
+				"setting incompat feature flag for %s (0x%llx)",
+				name, flag);
 		}
 		spin_unlock(&fs_info->super_lock);
 	}
 }
 
 #define btrfs_clear_fs_incompat(__fs_info, opt) \
-	__btrfs_clear_fs_incompat((__fs_info), BTRFS_FEATURE_INCOMPAT_##opt)
+	__btrfs_clear_fs_incompat((__fs_info), BTRFS_FEATURE_INCOMPAT_##opt, \
+				  #opt)
 
 static inline void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info,
-					     u64 flag)
+					     u64 flag, const char* name)
 {
 	struct btrfs_super_block *disk_super;
 	u64 features;
@@ -3660,8 +3663,9 @@ static inline void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info,
 		if (features & flag) {
 			features &= ~flag;
 			btrfs_set_super_incompat_flags(disk_super, features);
-			btrfs_info(fs_info, "clearing %llu feature flag",
-					 flag);
+			btrfs_info(fs_info,
+				"clearing incompat feature flag for %s (0x%llx)",
+				name, flag);
 		}
 		spin_unlock(&fs_info->super_lock);
 	}
@@ -3678,10 +3682,11 @@ static inline bool __btrfs_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag)
 }
 
 #define btrfs_set_fs_compat_ro(__fs_info, opt) \
-	__btrfs_set_fs_compat_ro((__fs_info), BTRFS_FEATURE_COMPAT_RO_##opt)
+	__btrfs_set_fs_compat_ro((__fs_info), BTRFS_FEATURE_COMPAT_RO_##opt, \
+				 #opt)
 
 static inline void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info,
-					    u64 flag)
+					    u64 flag, const char *name)
 {
 	struct btrfs_super_block *disk_super;
 	u64 features;
@@ -3694,18 +3699,20 @@ static inline void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info,
 		if (!(features & flag)) {
 			features |= flag;
 			btrfs_set_super_compat_ro_flags(disk_super, features);
-			btrfs_info(fs_info, "setting %llu ro feature flag",
-				   flag);
+			btrfs_info(fs_info,
+				"setting compat-ro feature flag for %s (0x%llx)",
+				name, flag);
 		}
 		spin_unlock(&fs_info->super_lock);
 	}
 }
 
 #define btrfs_clear_fs_compat_ro(__fs_info, opt) \
-	__btrfs_clear_fs_compat_ro((__fs_info), BTRFS_FEATURE_COMPAT_RO_##opt)
+	__btrfs_clear_fs_compat_ro((__fs_info), BTRFS_FEATURE_COMPAT_RO_##opt, \
+				   #opt)
 
 static inline void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info,
-					      u64 flag)
+					      u64 flag, const char *name)
 {
 	struct btrfs_super_block *disk_super;
 	u64 features;
@@ -3718,8 +3725,9 @@ static inline void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info,
 		if (features & flag) {
 			features &= ~flag;
 			btrfs_set_super_compat_ro_flags(disk_super, features);
-			btrfs_info(fs_info, "clearing %llu ro feature flag",
-				   flag);
+			btrfs_info(fs_info,
+				"clearing compat-ro feature flag for %s (0x%llx)",
+				name, flag);
 		}
 		spin_unlock(&fs_info->super_lock);
 	}
-- 
2.21.0

