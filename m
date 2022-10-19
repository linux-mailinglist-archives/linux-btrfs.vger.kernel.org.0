Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B87C604A1F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Oct 2022 16:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiJSO6L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 10:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiJSO5h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 10:57:37 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F5013B516
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:10 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id a5so10824423qkl.6
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvxALYXgMwO86dbBMH8J8LY8xiCt55UXO8c/H57S5zY=;
        b=M/43tGOcQbux4gnOAqkMUQJMt1LKNGYlROrQ965On5N90TMBHpPTHT4WvZcgU0Fc+W
         6ypHU78a7jpfBAaeNTc2cCUtbkU2rJkLqU9yZysnWoE1qpu7+ftmsiPf0rDOdtQbgppu
         Zgs+AsrmefAh0s3Xa7ERfjt9gX6BMCi1/J3D3h2n2vskynurjx8WRpvjS5tybYkclonK
         9LklPxFClGiP+yTKxwhunuh7nbj243SwE4HKJ6IEM9ElDBC7qpPNWQMlZPryosWFvoPY
         yhI/NCxFiXNkIuLIcJCkA9FwSK0GmNsd2+nHmRbRjatFUEw8jTffJtgR2IjTfIXvBldl
         86vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvxALYXgMwO86dbBMH8J8LY8xiCt55UXO8c/H57S5zY=;
        b=x9JF/cBD0UfvD+ABhp16FlD5EPQl/ssrL5aH/YN0U4rvha1E0LTnt/95rDJK2btNd1
         ZwiHw8Ryq0C7TIfEW62SRVC+ZBYcQQj1pGqSZoROQc4XDjyD8gEAvBe/iVwoCdbkaw7C
         gKfXBIY3OL2e06UZ9pG0YRMjy1KTIFJZJlShXhbyxuDgKeREpIUmqAUfV4RADJZfOHZ4
         sb2DyxW/+HINbnsizrJdh8ZDPtfTQmyJRQqBIIeEK9xhO/48iLRKSZFf55qb4UFaitt3
         XUONWQyjV+3NjEiqagvuy/OsMEhfRbK4x7H5j+tVe6zKgFcrInOL1gGjWSSuwmm++iAO
         NQsA==
X-Gm-Message-State: ACrzQf0KG1okKDS6P4tPQkDGpEMS5m5o19FMbtTcfZc+IaAPDOMk9u9b
        qYrQb042kVJJLvOhqb0zyhGgOUr+HFK+AQ==
X-Google-Smtp-Source: AMsMyM5yHLpnDSaMR7B3/rXxUr4xkcrk22O6bWPw9pc273Eb6fGdmOIWYLTyKSf3d1rE0aejcQJQ6Q==
X-Received: by 2002:a37:9106:0:b0:6cf:cb33:ed55 with SMTP id t6-20020a379106000000b006cfcb33ed55mr5721960qkd.150.1666191069622;
        Wed, 19 Oct 2022 07:51:09 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id a21-20020a05620a067500b006e54251993esm4763386qkh.97.2022.10.19.07.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:51:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 05/15] btrfs: move BTRFS_FS_STATE* defs and helpers to fs.h
Date:   Wed, 19 Oct 2022 10:50:51 -0400
Message-Id: <6331d7b0724fd065d5364b1f68c952ac7b37d657.1666190849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666190849.git.josef@toxicpanda.com>
References: <cover.1666190849.git.josef@toxicpanda.com>
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

We're going to use fs.h to hold fs wide related helpers and definitions,
move the FS_STATE enum and related helpers to fs.h, and then update all
files that need these definitions to include fs.h.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/compression.c       |  1 +
 fs/btrfs/ctree.c             |  1 +
 fs/btrfs/ctree.h             | 46 ---------------------------------
 fs/btrfs/delalloc-space.c    |  1 +
 fs/btrfs/delayed-inode.c     |  3 ++-
 fs/btrfs/dev-replace.c       |  1 +
 fs/btrfs/extent_io.c         |  1 +
 fs/btrfs/free-space-cache.c  |  3 ++-
 fs/btrfs/fs.h                | 50 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/inode-item.c        |  3 ++-
 fs/btrfs/reflink.c           |  3 ++-
 fs/btrfs/root-tree.c         |  3 ++-
 fs/btrfs/sysfs.c             |  1 +
 fs/btrfs/tests/btrfs-tests.c |  1 +
 fs/btrfs/xattr.c             |  3 ++-
 15 files changed, 69 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 54caa00a2245..7e516e816c4a 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -21,6 +21,7 @@
 #include <crypto/hash.h>
 #include "misc.h"
 #include "ctree.h"
+#include "fs.h"
 #include "disk-io.h"
 #include "transaction.h"
 #include "btrfs_inode.h"
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 8deba9cc0ee3..8ba72009bacb 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -18,6 +18,7 @@
 #include "qgroup.h"
 #include "tree-mod-log.h"
 #include "tree-checker.h"
+#include "fs.h"
 
 static struct kmem_cache *btrfs_path_cachep;
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 45df323caa38..b7a5263b6a3f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -59,37 +59,6 @@ struct reloc_control;
 
 #define BTRFS_MAX_EXTENT_SIZE SZ_128M
 
-/*
- * Runtime (in-memory) states of filesystem
- */
-enum {
-	/* Global indicator of serious filesystem errors */
-	BTRFS_FS_STATE_ERROR,
-	/*
-	 * Filesystem is being remounted, allow to skip some operations, like
-	 * defrag
-	 */
-	BTRFS_FS_STATE_REMOUNTING,
-	/* Filesystem in RO mode */
-	BTRFS_FS_STATE_RO,
-	/* Track if a transaction abort has been reported on this filesystem */
-	BTRFS_FS_STATE_TRANS_ABORTED,
-	/*
-	 * Bio operations should be blocked on this filesystem because a source
-	 * or target device is being destroyed as part of a device replace
-	 */
-	BTRFS_FS_STATE_DEV_REPLACING,
-	/* The btrfs_fs_info created for self-tests */
-	BTRFS_FS_STATE_DUMMY_FS_INFO,
-
-	BTRFS_FS_STATE_NO_CSUMS,
-
-	/* Indicates there was an error cleaning up a log tree. */
-	BTRFS_FS_STATE_LOG_CLEANUP_ERROR,
-
-	BTRFS_FS_STATE_COUNT
-};
-
 #define BTRFS_SUPER_INFO_OFFSET			SZ_64K
 #define BTRFS_SUPER_INFO_SIZE			4096
 static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
@@ -3211,12 +3180,6 @@ static inline unsigned long get_eb_page_index(unsigned long offset)
 #define EXPORT_FOR_TESTS
 #endif
 
-#define BTRFS_FS_ERROR(fs_info)	(unlikely(test_bit(BTRFS_FS_STATE_ERROR, \
-						   &(fs_info)->fs_state)))
-#define BTRFS_FS_LOG_CLEANUP_ERROR(fs_info)				\
-	(unlikely(test_bit(BTRFS_FS_STATE_LOG_CLEANUP_ERROR,		\
-			   &(fs_info)->fs_state)))
-
 /* acl.c */
 #ifdef CONFIG_BTRFS_FS_POSIX_ACL
 struct posix_acl *btrfs_get_acl(struct inode *inode, int type, bool rcu);
@@ -3310,15 +3273,6 @@ static inline int btrfs_get_verity_descriptor(struct inode *inode, void *buf,
 /* Sanity test specific functions */
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 void btrfs_test_destroy_inode(struct inode *inode);
-static inline int btrfs_is_testing(struct btrfs_fs_info *fs_info)
-{
-	return test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state);
-}
-#else
-static inline int btrfs_is_testing(struct btrfs_fs_info *fs_info)
-{
-	return 0;
-}
 #endif
 
 static inline bool btrfs_is_data_reloc_root(const struct btrfs_root *root)
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 045545145a2b..605d8874a446 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -9,6 +9,7 @@
 #include "transaction.h"
 #include "qgroup.h"
 #include "block-group.h"
+#include "fs.h"
 
 /*
  * HOW DOES THIS WORK
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 8cf5ee646147..2f68570fbb53 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -6,12 +6,13 @@
 
 #include <linux/slab.h>
 #include <linux/iversion.h>
+#include "ctree.h"
+#include "fs.h"
 #include "messages.h"
 #include "misc.h"
 #include "delayed-inode.h"
 #include "disk-io.h"
 #include "transaction.h"
-#include "ctree.h"
 #include "qgroup.h"
 #include "locking.h"
 #include "inode-item.h"
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 61e58066b5fd..348aef453e69 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -23,6 +23,7 @@
 #include "sysfs.h"
 #include "zoned.h"
 #include "block-group.h"
+#include "fs.h"
 
 /*
  * Device replace overview
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1eae68fbae21..907c8518dab9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -30,6 +30,7 @@
 #include "zoned.h"
 #include "block-group.h"
 #include "compression.h"
+#include "fs.h"
 
 static struct kmem_cache *extent_buffer_cache;
 
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 83d866f5ab6c..703902156f97 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -11,9 +11,10 @@
 #include <linux/ratelimit.h>
 #include <linux/error-injection.h>
 #include <linux/sched/mm.h>
+#include "ctree.h"
+#include "fs.h"
 #include "messages.h"
 #include "misc.h"
-#include "ctree.h"
 #include "free-space-cache.h"
 #include "transaction.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index fc7564ebf286..c4786e838ee0 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -3,6 +3,37 @@
 #ifndef BTRFS_FS_H
 #define BTRFS_FS_H
 
+/*
+ * Runtime (in-memory) states of filesystem
+ */
+enum {
+	/* Global indicator of serious filesystem errors */
+	BTRFS_FS_STATE_ERROR,
+	/*
+	 * Filesystem is being remounted, allow to skip some operations, like
+	 * defrag
+	 */
+	BTRFS_FS_STATE_REMOUNTING,
+	/* Filesystem in RO mode */
+	BTRFS_FS_STATE_RO,
+	/* Track if a transaction abort has been reported on this filesystem */
+	BTRFS_FS_STATE_TRANS_ABORTED,
+	/*
+	 * Bio operations should be blocked on this filesystem because a source
+	 * or target device is being destroyed as part of a device replace
+	 */
+	BTRFS_FS_STATE_DEV_REPLACING,
+	/* The btrfs_fs_info created for self-tests */
+	BTRFS_FS_STATE_DUMMY_FS_INFO,
+
+	BTRFS_FS_STATE_NO_CSUMS,
+
+	/* Indicates there was an error cleaning up a log tree. */
+	BTRFS_FS_STATE_LOG_CLEANUP_ERROR,
+
+	BTRFS_FS_STATE_COUNT
+};
+
 /* compatibility and incompatibility defines */
 void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
 			     const char *name);
@@ -87,4 +118,23 @@ static inline void btrfs_clear_sb_rdonly(struct super_block *sb)
 	sb->s_flags &= ~SB_RDONLY;
 	clear_bit(BTRFS_FS_STATE_RO, &btrfs_sb(sb)->fs_state);
 }
+
+#define BTRFS_FS_ERROR(fs_info)	(unlikely(test_bit(BTRFS_FS_STATE_ERROR, \
+						   &(fs_info)->fs_state)))
+#define BTRFS_FS_LOG_CLEANUP_ERROR(fs_info)				\
+	(unlikely(test_bit(BTRFS_FS_STATE_LOG_CLEANUP_ERROR,		\
+			   &(fs_info)->fs_state)))
+
+#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
+static inline int btrfs_is_testing(struct btrfs_fs_info *fs_info)
+{
+	return test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state);
+}
+#else
+static inline int btrfs_is_testing(struct btrfs_fs_info *fs_info)
+{
+	return 0;
+}
+#endif
+
 #endif /* BTRFS_FS_H */
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index b301d8e3df87..25e9f1d65067 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -3,8 +3,9 @@
  * Copyright (C) 2007 Oracle.  All rights reserved.
  */
 
-#include "messages.h"
 #include "ctree.h"
+#include "fs.h"
+#include "messages.h"
 #include "inode-item.h"
 #include "disk-io.h"
 #include "transaction.h"
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 6179864de6e7..daf65bfad30e 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -2,9 +2,10 @@
 
 #include <linux/blkdev.h>
 #include <linux/iversion.h>
+#include "ctree.h"
+#include "fs.h"
 #include "messages.h"
 #include "compression.h"
-#include "ctree.h"
 #include "delalloc-space.h"
 #include "disk-io.h"
 #include "reflink.h"
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 44c8c8ad0a16..112b4bf3c3b8 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -5,8 +5,9 @@
 
 #include <linux/err.h>
 #include <linux/uuid.h>
-#include "messages.h"
 #include "ctree.h"
+#include "fs.h"
+#include "messages.h"
 #include "transaction.h"
 #include "disk-io.h"
 #include "print-tree.h"
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 404a314ec8a2..0d98984af0e9 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -23,6 +23,7 @@
 #include "block-group.h"
 #include "qgroup.h"
 #include "misc.h"
+#include "fs.h"
 
 /*
  * Structure name                       Path
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index 9c478fa256f6..1538c65f2b17 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -16,6 +16,7 @@
 #include "../disk-io.h"
 #include "../qgroup.h"
 #include "../block-group.h"
+#include "../fs.h"
 
 static struct vfsmount *test_mnt = NULL;
 
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index d12903f01f83..b26c869f0226 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -12,8 +12,9 @@
 #include <linux/posix_acl_xattr.h>
 #include <linux/iversion.h>
 #include <linux/sched/mm.h>
-#include "messages.h"
 #include "ctree.h"
+#include "fs.h"
+#include "messages.h"
 #include "btrfs_inode.h"
 #include "transaction.h"
 #include "xattr.h"
-- 
2.26.3

