Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708705B8E0A
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 19:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiINRSq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 13:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiINRSh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 13:18:37 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC8C816A6
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:34 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id m9so12259780qvv.7
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=5SF7ng+eUdtBPwxJbjsXUijHAYOlF4ieDMFgK+Bh3XA=;
        b=2odMr6hTVahsu9oc8gFrRyBs285WCDTdH4/w+3d999L1sOSk6f9/PsTyU5reAVZihW
         gAY/pj7To3mrh7D2q0OQKVQc9tsLsf4jCoKKBCH/YOzm6zu/L2gVp1RBwyut8iFgSs2W
         Ywl42vRFuCoeYgF0K3bnDuegM0GVY1KyGfhj1/X+f8HW6xTohF9fKyLEcYhm0qaPZVwv
         smP3492pCPWIakiVJksiQYXRqffwimb3h418qesW2u8TywhwS44QzGOZ6kp/T+8nnXeg
         4fypGzpcE9A4PpLSH5W40B8sK4NRuT3f6039TGTrUtRR8dYCiOVVDNXREzdINrDImMZz
         lgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5SF7ng+eUdtBPwxJbjsXUijHAYOlF4ieDMFgK+Bh3XA=;
        b=CtlH3CN4xItnTkmY/KV1F/RptJgMWQNlQco7qmL2ccDJc+KE+aaEOO8TWzHd9tSbyA
         gxCPYgaNIUpyQXXuAsfVCEThL7FSi/MyJ6fW0Ltv1TjL3Lc0ksCYaD9t+qxUod8NrUob
         rAzry07FvHwhVY9O7+sgCMkU7zOwj7ZnrpibPuReSsf9veMAV/mz8X2ITfAaM1s6JZ7L
         fy3K63Gje93idrqj7+usI8M/t1eKM5nbbF9CTIpR0r/AzPymcEPcBGrIwpGPAOvyNR2n
         jVISXEXGMrrzb2ZPmprY/1v3YQpwajfbvj9JjZoRfnFb70neNTr8p2aOBzUIkbYe3TuG
         kNXw==
X-Gm-Message-State: ACgBeo3LMp75EG2r/HNZTlNwLn8+edu4GhE/FIfCIef675YxPuIKhbDP
        NdpEhs0xjOL33ShZJQkxwDM3SfuzR1RZyA==
X-Google-Smtp-Source: AA6agR4mnqm6ZkH3olRxAUSOLcR3D96R2MxKecLePbHdhB8UftR4T/cTvRE6mosVPbT6CYx4e5UoNw==
X-Received: by 2002:ad4:5942:0:b0:4aa:b573:f80 with SMTP id eo2-20020ad45942000000b004aab5730f80mr31987891qvb.16.1663175913117;
        Wed, 14 Sep 2022 10:18:33 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s14-20020ac85ece000000b00339b8a5639csm1817833qtx.95.2022.09.14.10.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 10:18:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/16] btrfs: move BTRFS_FS_STATE* defs and helpers to fs.h
Date:   Wed, 14 Sep 2022 13:18:12 -0400
Message-Id: <5118fc3da0a134f1ebfc68825fb65e38b16f98e4.1663175597.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663175597.git.josef@toxicpanda.com>
References: <cover.1663175597.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're going to use fs.h to hold fs wide related helpers and definitions,
move the FS_STATE enum and related helpers to fs.h, and then update all
files that need these definitions to include fs.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/compression.c       |  1 +
 fs/btrfs/ctree.c             |  1 +
 fs/btrfs/ctree.h             | 46 ---------------------------------
 fs/btrfs/delalloc-space.c    |  1 +
 fs/btrfs/dev-replace.c       |  1 +
 fs/btrfs/extent_io.c         |  1 +
 fs/btrfs/fs.h                | 50 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/sysfs.c             |  1 +
 fs/btrfs/tests/btrfs-tests.c |  1 +
 9 files changed, 57 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 54caa00a2245..d456c85f94dd 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -31,6 +31,7 @@
 #include "extent_map.h"
 #include "subpage.h"
 #include "zoned.h"
+#include "fs.h"
 
 static const char* const btrfs_compress_types[] = { "", "zlib", "lzo", "zstd" };
 
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index c4a0228322fe..a5fd4e2369f1 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -18,6 +18,7 @@
 #include "qgroup.h"
 #include "tree-mod-log.h"
 #include "tree-checker.h"
+#include "fs.h"
 
 static struct kmem_cache *btrfs_path_cachep;
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 52efb662fdf9..2f4a29a36d08 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -54,37 +54,6 @@ struct btrfs_ioctl_encoded_io_args;
 
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
@@ -3244,12 +3213,6 @@ static inline unsigned long get_eb_page_index(unsigned long offset)
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
@@ -3349,15 +3312,6 @@ static inline int btrfs_get_verity_descriptor(struct inode *inode, void *buf,
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
 
 static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 006b12ee12af..7d561911f9ba 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -9,6 +9,7 @@
 #include "transaction.h"
 #include "qgroup.h"
 #include "block-group.h"
+#include "fs.h"
 
 /*
  * HOW DOES THIS WORK
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
index a426f0e6c145..c11c05ea099d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -30,6 +30,7 @@
 #include "zoned.h"
 #include "block-group.h"
 #include "compression.h"
+#include "fs.h"
 
 static struct kmem_cache *extent_buffer_cache;
 
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 36ad05b329ce..43fd78a9f46c 100644
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
 void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
 			       const char *name);
@@ -89,4 +120,23 @@ static inline void btrfs_clear_sb_rdonly(struct super_block *sb)
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
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 24079df977ff..4acff123fe66 100644
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
 
-- 
2.26.3

