Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74426016F2
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 21:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiJQTJY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 15:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiJQTJV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 15:09:21 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6295275FF4
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:18 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a5so7273131qkl.6
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QEnYGiF/oDzFKf+7tddqd635O0fVISyQTCkIPPxmhzE=;
        b=JvoBKpF8D9T3NU2cdxFT6mwwh+OL8pKm7JKIyaz+8lawuNGGIsE9BzxDgEGgOgWs0v
         5watFkQXKcjwwI5x4RAJTEtkjy+g/n1tBeeQwV6UlLkn4DhpM4WewMKmuMMIQmvVy/md
         6k79v9E8Fy6ISe4jFiaG8S8InnNZUcTDb8P5HEYVGA9LHxGImDyiqwWi4ijzNANmGWpj
         RFOjlmdJESpWDGQ8AS8Rb54nmFZiVh//r9amRWgGtOwPaNm73XyOqZlsOtBcO58FqBWH
         jCs664JOLnZcE+ZCjczJs5oQt4ZDdOdNMddNAanKtCn+f/nLGn+YpfM3gIYZRnwdVAsj
         R4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEnYGiF/oDzFKf+7tddqd635O0fVISyQTCkIPPxmhzE=;
        b=Z/HHOrOx/KI3t9C9XqpQUVUMRNCfn4jMp5HdXVSJxwfp9JS4MHWLiTAQ0w78/kKDRH
         ccQX0U4w0cJbUwOBQHjwCGU+CancmoORuMysUsjrPnU9obyt5fxtapEvYVeyf6djE0dw
         f+yomCRJW7UOeDGvcNJenG+VGoYybUP3udniL8ALGLS8CcG4Vqe5FiSJCElVdQkF6KDd
         ZyNa4BS6vX2ezoqJAwKpSqf1eFjs7CJ6YgkYin7FMV4U7SWOZj4rJGXsl2EjayGe+Xt/
         gbZGINGGanD/Wn274vNgDlZJalfKaMdzDevKFRXPQOuPCZmEGMupSj7F19kNQJTbh2Xs
         W+iQ==
X-Gm-Message-State: ACrzQf2MJHjeosKmQ4nEhnPX9h8rlrFhmK7mq0LeZ2dGeYQ1kDFqor05
        zuZsVG2IVOHLHUdd1lsNyRie4QdFhWxvFA==
X-Google-Smtp-Source: AMsMyM6wARfT5gEAxeeVC5HVpQcCPw0Adkyvn380j7a4JnKOgtqHka6f7eIJU5kmj69Qv/6FBGJgyQ==
X-Received: by 2002:a05:620a:2189:b0:6e9:856f:944a with SMTP id g9-20020a05620a218900b006e9856f944amr8675810qka.322.1666033756776;
        Mon, 17 Oct 2022 12:09:16 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id h14-20020ac8568e000000b0039913d588fbsm406974qta.48.2022.10.17.12.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:09:16 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 01/16] btrfs: move fs wide helpers out of ctree.h
Date:   Mon, 17 Oct 2022 15:08:58 -0400
Message-Id: <b2a22c4b8a6683c3fa9be964230b8d37f3abdd32.1666033501.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666033501.git.josef@toxicpanda.com>
References: <cover.1666033501.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have several fs wide related helpers in ctree.h.  The bulk of these
are the incompat flag test helpers, but there are things such as
btrfs_fs_closing() and the read only helpers that also aren't directly
related to the ctree code.  Move these into a fs.h header, which will
serve as the location for file system wide related helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c         |   1 +
 fs/btrfs/block-group.c     |   1 +
 fs/btrfs/ctree.h           | 164 -----------------------------------
 fs/btrfs/disk-io.c         |   1 +
 fs/btrfs/extent-tree.c     |   1 +
 fs/btrfs/file-item.c       |   1 +
 fs/btrfs/file.c            |   1 +
 fs/btrfs/free-space-tree.c |   1 +
 fs/btrfs/fs.h              | 170 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/inode.c           |   1 +
 fs/btrfs/ioctl.c           |   1 +
 fs/btrfs/props.c           |   1 +
 fs/btrfs/qgroup.c          |   1 +
 fs/btrfs/relocation.c      |   1 +
 fs/btrfs/scrub.c           |   1 +
 fs/btrfs/space-info.c      |   1 +
 fs/btrfs/super.c           |   1 +
 fs/btrfs/transaction.c     |   1 +
 fs/btrfs/tree-checker.c    |   1 +
 fs/btrfs/tree-log.c        |   1 +
 fs/btrfs/uuid-tree.c       |   1 +
 fs/btrfs/verity.c          |   1 +
 fs/btrfs/volumes.c         |   1 +
 fs/btrfs/zoned.c           |   1 +
 24 files changed, 192 insertions(+), 164 deletions(-)
 create mode 100644 fs/btrfs/fs.h

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index dce3a16996b9..64ead955a5d3 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -15,6 +15,7 @@
 #include "locking.h"
 #include "misc.h"
 #include "tree-mod-log.h"
+#include "fs.h"
 
 /* Just an arbitrary number so we can be sure this happened */
 #define BACKREF_FOUND_SHARED 6
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 11fd52657b76..2bdf52daca47 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -17,6 +17,7 @@
 #include "discard.h"
 #include "raid56.h"
 #include "zoned.h"
+#include "fs.h"
 
 #ifdef CONFIG_BTRFS_DEBUG
 int btrfs_should_fragment_free_space(struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index dff9b84d7677..52987ee61c72 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2849,44 +2849,6 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 			struct btrfs_root *root,
 			struct extent_buffer *node,
 			struct extent_buffer *parent);
-static inline int btrfs_fs_closing(struct btrfs_fs_info *fs_info)
-{
-	/*
-	 * Do it this way so we only ever do one test_bit in the normal case.
-	 */
-	if (test_bit(BTRFS_FS_CLOSING_START, &fs_info->flags)) {
-		if (test_bit(BTRFS_FS_CLOSING_DONE, &fs_info->flags))
-			return 2;
-		return 1;
-	}
-	return 0;
-}
-
-/*
- * If we remount the fs to be R/O or umount the fs, the cleaner needn't do
- * anything except sleeping. This function is used to check the status of
- * the fs.
- * We check for BTRFS_FS_STATE_RO to avoid races with a concurrent remount,
- * since setting and checking for SB_RDONLY in the superblock's flags is not
- * atomic.
- */
-static inline int btrfs_need_cleaner_sleep(struct btrfs_fs_info *fs_info)
-{
-	return test_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state) ||
-		btrfs_fs_closing(fs_info);
-}
-
-static inline void btrfs_set_sb_rdonly(struct super_block *sb)
-{
-	sb->s_flags |= SB_RDONLY;
-	set_bit(BTRFS_FS_STATE_RO, &btrfs_sb(sb)->fs_state);
-}
-
-static inline void btrfs_clear_sb_rdonly(struct super_block *sb)
-{
-	sb->s_flags &= ~SB_RDONLY;
-	clear_bit(BTRFS_FS_STATE_RO, &btrfs_sb(sb)->fs_state);
-}
 
 /* root-item.c */
 int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
@@ -3513,132 +3475,6 @@ do {									\
 } while (0)
 
 
-/* compatibility and incompatibility defines */
-
-#define btrfs_set_fs_incompat(__fs_info, opt) \
-	__btrfs_set_fs_incompat((__fs_info), BTRFS_FEATURE_INCOMPAT_##opt, \
-				#opt)
-
-static inline void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info,
-					   u64 flag, const char* name)
-{
-	struct btrfs_super_block *disk_super;
-	u64 features;
-
-	disk_super = fs_info->super_copy;
-	features = btrfs_super_incompat_flags(disk_super);
-	if (!(features & flag)) {
-		spin_lock(&fs_info->super_lock);
-		features = btrfs_super_incompat_flags(disk_super);
-		if (!(features & flag)) {
-			features |= flag;
-			btrfs_set_super_incompat_flags(disk_super, features);
-			btrfs_info(fs_info,
-				"setting incompat feature flag for %s (0x%llx)",
-				name, flag);
-		}
-		spin_unlock(&fs_info->super_lock);
-	}
-}
-
-#define btrfs_clear_fs_incompat(__fs_info, opt) \
-	__btrfs_clear_fs_incompat((__fs_info), BTRFS_FEATURE_INCOMPAT_##opt, \
-				  #opt)
-
-static inline void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info,
-					     u64 flag, const char* name)
-{
-	struct btrfs_super_block *disk_super;
-	u64 features;
-
-	disk_super = fs_info->super_copy;
-	features = btrfs_super_incompat_flags(disk_super);
-	if (features & flag) {
-		spin_lock(&fs_info->super_lock);
-		features = btrfs_super_incompat_flags(disk_super);
-		if (features & flag) {
-			features &= ~flag;
-			btrfs_set_super_incompat_flags(disk_super, features);
-			btrfs_info(fs_info,
-				"clearing incompat feature flag for %s (0x%llx)",
-				name, flag);
-		}
-		spin_unlock(&fs_info->super_lock);
-	}
-}
-
-#define btrfs_fs_incompat(fs_info, opt) \
-	__btrfs_fs_incompat((fs_info), BTRFS_FEATURE_INCOMPAT_##opt)
-
-static inline bool __btrfs_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag)
-{
-	struct btrfs_super_block *disk_super;
-	disk_super = fs_info->super_copy;
-	return !!(btrfs_super_incompat_flags(disk_super) & flag);
-}
-
-#define btrfs_set_fs_compat_ro(__fs_info, opt) \
-	__btrfs_set_fs_compat_ro((__fs_info), BTRFS_FEATURE_COMPAT_RO_##opt, \
-				 #opt)
-
-static inline void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info,
-					    u64 flag, const char *name)
-{
-	struct btrfs_super_block *disk_super;
-	u64 features;
-
-	disk_super = fs_info->super_copy;
-	features = btrfs_super_compat_ro_flags(disk_super);
-	if (!(features & flag)) {
-		spin_lock(&fs_info->super_lock);
-		features = btrfs_super_compat_ro_flags(disk_super);
-		if (!(features & flag)) {
-			features |= flag;
-			btrfs_set_super_compat_ro_flags(disk_super, features);
-			btrfs_info(fs_info,
-				"setting compat-ro feature flag for %s (0x%llx)",
-				name, flag);
-		}
-		spin_unlock(&fs_info->super_lock);
-	}
-}
-
-#define btrfs_clear_fs_compat_ro(__fs_info, opt) \
-	__btrfs_clear_fs_compat_ro((__fs_info), BTRFS_FEATURE_COMPAT_RO_##opt, \
-				   #opt)
-
-static inline void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info,
-					      u64 flag, const char *name)
-{
-	struct btrfs_super_block *disk_super;
-	u64 features;
-
-	disk_super = fs_info->super_copy;
-	features = btrfs_super_compat_ro_flags(disk_super);
-	if (features & flag) {
-		spin_lock(&fs_info->super_lock);
-		features = btrfs_super_compat_ro_flags(disk_super);
-		if (features & flag) {
-			features &= ~flag;
-			btrfs_set_super_compat_ro_flags(disk_super, features);
-			btrfs_info(fs_info,
-				"clearing compat-ro feature flag for %s (0x%llx)",
-				name, flag);
-		}
-		spin_unlock(&fs_info->super_lock);
-	}
-}
-
-#define btrfs_fs_compat_ro(fs_info, opt) \
-	__btrfs_fs_compat_ro((fs_info), BTRFS_FEATURE_COMPAT_RO_##opt)
-
-static inline int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag)
-{
-	struct btrfs_super_block *disk_super;
-	disk_super = fs_info->super_copy;
-	return !!(btrfs_super_compat_ro_flags(disk_super) & flag);
-}
-
 /* acl.c */
 #ifdef CONFIG_BTRFS_FS_POSIX_ACL
 struct posix_acl *btrfs_get_acl(struct inode *inode, int type, bool rcu);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c29052f5d4e3..fb437d1246e0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -43,6 +43,7 @@
 #include "space-info.h"
 #include "zoned.h"
 #include "subpage.h"
+#include "fs.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index cd2d36580f1a..1d87989e9d41 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -36,6 +36,7 @@
 #include "rcu-string.h"
 #include "zoned.h"
 #include "dev-replace.h"
+#include "fs.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 6bb9fa961a6a..824ff54d8155 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -16,6 +16,7 @@
 #include "volumes.h"
 #include "print-tree.h"
 #include "compression.h"
+#include "fs.h"
 
 #define __MAX_CSUM_ITEMS(r, size) ((unsigned long)(((BTRFS_LEAF_DATA_SIZE(r) - \
 				   sizeof(struct btrfs_item) * 2) / \
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 176b432035ae..5b944f1b714e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -30,6 +30,7 @@
 #include "delalloc-space.h"
 #include "reflink.h"
 #include "subpage.h"
+#include "fs.h"
 
 static struct kmem_cache *btrfs_inode_defrag_cachep;
 /*
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 367bcfcf68f5..bfc21eb8ec63 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -11,6 +11,7 @@
 #include "free-space-tree.h"
 #include "transaction.h"
 #include "block-group.h"
+#include "fs.h"
 
 static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 					struct btrfs_block_group *block_group,
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
new file mode 100644
index 000000000000..56be405a008c
--- /dev/null
+++ b/fs/btrfs/fs.h
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef BTRFS_FS_H
+#define BTRFS_FS_H
+
+/* compatibility and incompatibility defines */
+
+#define btrfs_set_fs_incompat(__fs_info, opt) \
+	__btrfs_set_fs_incompat((__fs_info), BTRFS_FEATURE_INCOMPAT_##opt, \
+				#opt)
+
+static inline void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info,
+					   u64 flag, const char* name)
+{
+	struct btrfs_super_block *disk_super;
+	u64 features;
+
+	disk_super = fs_info->super_copy;
+	features = btrfs_super_incompat_flags(disk_super);
+	if (!(features & flag)) {
+		spin_lock(&fs_info->super_lock);
+		features = btrfs_super_incompat_flags(disk_super);
+		if (!(features & flag)) {
+			features |= flag;
+			btrfs_set_super_incompat_flags(disk_super, features);
+			btrfs_info(fs_info,
+				"setting incompat feature flag for %s (0x%llx)",
+				name, flag);
+		}
+		spin_unlock(&fs_info->super_lock);
+	}
+}
+
+#define btrfs_clear_fs_incompat(__fs_info, opt) \
+	__btrfs_clear_fs_incompat((__fs_info), BTRFS_FEATURE_INCOMPAT_##opt, \
+				  #opt)
+
+static inline void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info,
+					     u64 flag, const char* name)
+{
+	struct btrfs_super_block *disk_super;
+	u64 features;
+
+	disk_super = fs_info->super_copy;
+	features = btrfs_super_incompat_flags(disk_super);
+	if (features & flag) {
+		spin_lock(&fs_info->super_lock);
+		features = btrfs_super_incompat_flags(disk_super);
+		if (features & flag) {
+			features &= ~flag;
+			btrfs_set_super_incompat_flags(disk_super, features);
+			btrfs_info(fs_info,
+				"clearing incompat feature flag for %s (0x%llx)",
+				name, flag);
+		}
+		spin_unlock(&fs_info->super_lock);
+	}
+}
+
+#define btrfs_fs_incompat(fs_info, opt) \
+	__btrfs_fs_incompat((fs_info), BTRFS_FEATURE_INCOMPAT_##opt)
+
+static inline bool __btrfs_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag)
+{
+	struct btrfs_super_block *disk_super;
+	disk_super = fs_info->super_copy;
+	return !!(btrfs_super_incompat_flags(disk_super) & flag);
+}
+
+#define btrfs_set_fs_compat_ro(__fs_info, opt) \
+	__btrfs_set_fs_compat_ro((__fs_info), BTRFS_FEATURE_COMPAT_RO_##opt, \
+				 #opt)
+
+static inline void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info,
+					    u64 flag, const char *name)
+{
+	struct btrfs_super_block *disk_super;
+	u64 features;
+
+	disk_super = fs_info->super_copy;
+	features = btrfs_super_compat_ro_flags(disk_super);
+	if (!(features & flag)) {
+		spin_lock(&fs_info->super_lock);
+		features = btrfs_super_compat_ro_flags(disk_super);
+		if (!(features & flag)) {
+			features |= flag;
+			btrfs_set_super_compat_ro_flags(disk_super, features);
+			btrfs_info(fs_info,
+				"setting compat-ro feature flag for %s (0x%llx)",
+				name, flag);
+		}
+		spin_unlock(&fs_info->super_lock);
+	}
+}
+
+#define btrfs_clear_fs_compat_ro(__fs_info, opt) \
+	__btrfs_clear_fs_compat_ro((__fs_info), BTRFS_FEATURE_COMPAT_RO_##opt, \
+				   #opt)
+
+static inline void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info,
+					      u64 flag, const char *name)
+{
+	struct btrfs_super_block *disk_super;
+	u64 features;
+
+	disk_super = fs_info->super_copy;
+	features = btrfs_super_compat_ro_flags(disk_super);
+	if (features & flag) {
+		spin_lock(&fs_info->super_lock);
+		features = btrfs_super_compat_ro_flags(disk_super);
+		if (features & flag) {
+			features &= ~flag;
+			btrfs_set_super_compat_ro_flags(disk_super, features);
+			btrfs_info(fs_info,
+				"clearing compat-ro feature flag for %s (0x%llx)",
+				name, flag);
+		}
+		spin_unlock(&fs_info->super_lock);
+	}
+}
+
+#define btrfs_fs_compat_ro(fs_info, opt) \
+	__btrfs_fs_compat_ro((fs_info), BTRFS_FEATURE_COMPAT_RO_##opt)
+
+static inline int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag)
+{
+	struct btrfs_super_block *disk_super;
+	disk_super = fs_info->super_copy;
+	return !!(btrfs_super_compat_ro_flags(disk_super) & flag);
+}
+
+static inline int btrfs_fs_closing(struct btrfs_fs_info *fs_info)
+{
+	/*
+	 * Do it this way so we only ever do one test_bit in the normal case.
+	 */
+	if (test_bit(BTRFS_FS_CLOSING_START, &fs_info->flags)) {
+		if (test_bit(BTRFS_FS_CLOSING_DONE, &fs_info->flags))
+			return 2;
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * If we remount the fs to be R/O or umount the fs, the cleaner needn't do
+ * anything except sleeping. This function is used to check the status of
+ * the fs.
+ * We check for BTRFS_FS_STATE_RO to avoid races with a concurrent remount,
+ * since setting and checking for SB_RDONLY in the superblock's flags is not
+ * atomic.
+ */
+static inline int btrfs_need_cleaner_sleep(struct btrfs_fs_info *fs_info)
+{
+	return test_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state) ||
+		btrfs_fs_closing(fs_info);
+}
+
+static inline void btrfs_set_sb_rdonly(struct super_block *sb)
+{
+	sb->s_flags |= SB_RDONLY;
+	set_bit(BTRFS_FS_STATE_RO, &btrfs_sb(sb)->fs_state);
+}
+
+static inline void btrfs_clear_sb_rdonly(struct super_block *sb)
+{
+	sb->s_flags &= ~SB_RDONLY;
+	clear_bit(BTRFS_FS_STATE_RO, &btrfs_sb(sb)->fs_state);
+}
+#endif /* BTRFS_FS_H */
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4bdca28b3c35..c9e0ebcad0ef 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -55,6 +55,7 @@
 #include "zoned.h"
 #include "subpage.h"
 #include "inode-item.h"
+#include "fs.h"
 
 struct btrfs_iget_args {
 	u64 ino;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d5dd8bed1488..e8b5dc147637 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -50,6 +50,7 @@
 #include "delalloc-space.h"
 #include "block-group.h"
 #include "subpage.h"
+#include "fs.h"
 
 #ifdef CONFIG_64BIT
 /* If we have a 32-bit userspace and 64-bit kernel, then the UAPI
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index 07f62e3ba6a5..ef17014221e2 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -11,6 +11,7 @@
 #include "xattr.h"
 #include "compression.h"
 #include "space-info.h"
+#include "fs.h"
 
 #define BTRFS_PROP_HANDLERS_HT_BITS 8
 static DEFINE_HASHTABLE(prop_handlers_ht, BTRFS_PROP_HANDLERS_HT_BITS);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9334c3157c22..041e4b368ea8 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -24,6 +24,7 @@
 #include "block-group.h"
 #include "sysfs.h"
 #include "tree-mod-log.h"
+#include "fs.h"
 
 /*
  * Helpers to access qgroup reservation
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 748c171a9488..9fc6c7ce7c42 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -28,6 +28,7 @@
 #include "zoned.h"
 #include "inode-item.h"
 #include "space-info.h"
+#include "fs.h"
 
 /*
  * Relocation overview
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 9e3b2e60e571..bd8e4d8b4cce 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -21,6 +21,7 @@
 #include "raid56.h"
 #include "block-group.h"
 #include "zoned.h"
+#include "fs.h"
 
 /*
  * This is only the first step towards a full-features scrub. It reads all
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index f171bf875633..024e033883d0 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -10,6 +10,7 @@
 #include "transaction.h"
 #include "block-group.h"
 #include "zoned.h"
+#include "fs.h"
 
 /*
  * HOW DOES SPACE RESERVATION WORK
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 46a11d5d7213..ebd59dc448dd 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -50,6 +50,7 @@
 #include "qgroup.h"
 #include "raid56.h"
 #include "space-info.h"
+#include "fs.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index ae7d4aca771d..bae77fb05e2b 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -23,6 +23,7 @@
 #include "block-group.h"
 #include "space-info.h"
 #include "zoned.h"
+#include "fs.h"
 
 static struct kmem_cache *btrfs_trans_handle_cachep;
 
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 43f905ab0a18..862d67798de5 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -25,6 +25,7 @@
 #include "volumes.h"
 #include "misc.h"
 #include "btrfs_inode.h"
+#include "fs.h"
 
 /*
  * Error message should follow the following format:
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 813986e38258..e911139fd2d3 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -21,6 +21,7 @@
 #include "space-info.h"
 #include "zoned.h"
 #include "inode-item.h"
+#include "fs.h"
 
 #define MAX_CONFLICT_INODES 10
 
diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index b458452a1aaf..2d7eb290fb9c 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -9,6 +9,7 @@
 #include "transaction.h"
 #include "disk-io.h"
 #include "print-tree.h"
+#include "fs.h"
 
 
 static void btrfs_uuid_to_key(u8 *uuid, u8 type, struct btrfs_key *key)
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index ee00e33c309e..ab0b39badbbe 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -15,6 +15,7 @@
 #include "transaction.h"
 #include "disk-io.h"
 #include "locking.h"
+#include "fs.h"
 
 /*
  * Implementation of the interface defined in struct fsverity_operations.
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b4de4d5ed69f..1938fbf49507 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -33,6 +33,7 @@
 #include "block-group.h"
 #include "discard.h"
 #include "zoned.h"
+#include "fs.h"
 
 static struct bio_set btrfs_bioset;
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e2d073b08a7d..19b533a5766d 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -15,6 +15,7 @@
 #include "transaction.h"
 #include "dev-replace.h"
 #include "space-info.h"
+#include "fs.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
-- 
2.26.3

