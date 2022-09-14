Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3205B8E11
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 19:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiINRSt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 13:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiINRSi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 13:18:38 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE238169E
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:37 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id w2so8071823qtv.9
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=COYyCjtGsgqxoWJ4fp8T8yJeYd9BVwrKte1g6idtIiU=;
        b=KsfTNM/wQjsyQS/gqQOyu7nNL6NRFmH6MfuqtCTehK5CHp7QSG02dAV5uNKIc8C88V
         dsy/jn2GYNlM9aldiRoNqYjFoeBhiFNeeUQcmk+02YtJYAyjCZNNk4mBHjeSORV6M7aB
         Ql5BzqIHw9TuzCPoNq92xaFj7zhZ2E7+sDbaNxR9jO6ubNWrYciKb6nOvlbAQY13/Wem
         i0WQ4r0NO6mBtrX8MN04i5zEErW5mk6LJKP+yHhSBylXdbCZ0zBoYrIayQkFE3NG9GnK
         rEqDIcBc1vQ7tTIFPdd6eOyyqiFGyn42MOVZ5kqMXQgH4Vrmv8DB4SeRdzHPVPvJ8in1
         T+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=COYyCjtGsgqxoWJ4fp8T8yJeYd9BVwrKte1g6idtIiU=;
        b=NGpSY+xllUHG0GdwWCum4L+UOT/LcrtEgTxzEUAZusjPiS5m3DJFfMacrThGkqxWAo
         cGQCZf8DPAGU/IPrsbq9HE6RhuMa3KMrRkPcnIQS/6xON2P7frNcZlUCNQWEJdQa/8s0
         G/TKiFxYjwvbSGsZ24M4fJFpSMMffkGnZZpgCvI0grjnwr6fvC9IVUGRJWT8tBQvok3z
         nb8ym6snomLXmgU1eHGNyLXwf40ryOzyv5StvEdgFmz0uc6Rf4tjYY6HSW5VuIN8WMFc
         m4CH0IKESZl4gvFh0lv23LnfscRJ7i4+1QxSSw+LZrTJKU52U8lufBEPJB2fYbjq2jOG
         BO0w==
X-Gm-Message-State: ACgBeo3NLrFTJQ8pfAYvfr6li2zIm9anj55XWHQptCLkHeeBFqko0VSA
        RD9BVm2a36zs6og4iObrs/M0oEBY0Vzw/w==
X-Google-Smtp-Source: AA6agR7XoDnWJOJOt7Zy49dRM8EvCv5/7h/7J21ZONwGcqy2AWcXVHthHvKRbicVVSdTXKKbj5+gzw==
X-Received: by 2002:ac8:598c:0:b0:35c:b7d4:f4af with SMTP id e12-20020ac8598c000000b0035cb7d4f4afmr5668321qte.503.1663175915834;
        Wed, 14 Sep 2022 10:18:35 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id de20-20020a05620a371400b006bb49cfe147sm2138241qkb.84.2022.09.14.10.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 10:18:35 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/16] btrfs: move mount option definitions to fs.h
Date:   Wed, 14 Sep 2022 13:18:14 -0400
Message-Id: <7f0974cdcb5a900311ddfa3bc602433e3aee2000.1663175597.git.josef@toxicpanda.com>
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

These are fs wide definitions and helpers, move them out of ctree.h and
into fs.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.c        |  1 +
 fs/btrfs/ctree.h            | 62 -------------------------------------
 fs/btrfs/delayed-ref.c      |  1 +
 fs/btrfs/discard.c          |  1 +
 fs/btrfs/free-space-cache.c |  1 +
 fs/btrfs/fs.h               | 62 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/ref-verify.c       |  1 +
 7 files changed, 67 insertions(+), 62 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index ec96285357e0..6dad02dd1d63 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -7,6 +7,7 @@
 #include "transaction.h"
 #include "block-group.h"
 #include "disk-io.h"
+#include "fs.h"
 
 /*
  * HOW DO BLOCK RESERVES WORK
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2f4a29a36d08..e08e956bd603 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1303,68 +1303,6 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 	return BTRFS_MAX_ITEM_SIZE(info) - sizeof(struct btrfs_dir_item);
 }
 
-/*
- * Flags for mount options.
- *
- * Note: don't forget to add new options to btrfs_show_options()
- */
-enum {
-	BTRFS_MOUNT_NODATASUM			= (1UL << 0),
-	BTRFS_MOUNT_NODATACOW			= (1UL << 1),
-	BTRFS_MOUNT_NOBARRIER			= (1UL << 2),
-	BTRFS_MOUNT_SSD				= (1UL << 3),
-	BTRFS_MOUNT_DEGRADED			= (1UL << 4),
-	BTRFS_MOUNT_COMPRESS			= (1UL << 5),
-	BTRFS_MOUNT_NOTREELOG   		= (1UL << 6),
-	BTRFS_MOUNT_FLUSHONCOMMIT		= (1UL << 7),
-	BTRFS_MOUNT_SSD_SPREAD			= (1UL << 8),
-	BTRFS_MOUNT_NOSSD			= (1UL << 9),
-	BTRFS_MOUNT_DISCARD_SYNC		= (1UL << 10),
-	BTRFS_MOUNT_FORCE_COMPRESS      	= (1UL << 11),
-	BTRFS_MOUNT_SPACE_CACHE			= (1UL << 12),
-	BTRFS_MOUNT_CLEAR_CACHE			= (1UL << 13),
-	BTRFS_MOUNT_USER_SUBVOL_RM_ALLOWED	= (1UL << 14),
-	BTRFS_MOUNT_ENOSPC_DEBUG		= (1UL << 15),
-	BTRFS_MOUNT_AUTO_DEFRAG			= (1UL << 16),
-	BTRFS_MOUNT_USEBACKUPROOT		= (1UL << 17),
-	BTRFS_MOUNT_SKIP_BALANCE		= (1UL << 18),
-	BTRFS_MOUNT_CHECK_INTEGRITY		= (1UL << 19),
-	BTRFS_MOUNT_CHECK_INTEGRITY_DATA	= (1UL << 20),
-	BTRFS_MOUNT_PANIC_ON_FATAL_ERROR	= (1UL << 21),
-	BTRFS_MOUNT_RESCAN_UUID_TREE		= (1UL << 22),
-	BTRFS_MOUNT_FRAGMENT_DATA		= (1UL << 23),
-	BTRFS_MOUNT_FRAGMENT_METADATA		= (1UL << 24),
-	BTRFS_MOUNT_FREE_SPACE_TREE		= (1UL << 25),
-	BTRFS_MOUNT_NOLOGREPLAY			= (1UL << 26),
-	BTRFS_MOUNT_REF_VERIFY			= (1UL << 27),
-	BTRFS_MOUNT_DISCARD_ASYNC		= (1UL << 28),
-	BTRFS_MOUNT_IGNOREBADROOTS		= (1UL << 29),
-	BTRFS_MOUNT_IGNOREDATACSUMS		= (1UL << 30),
-};
-
-#define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
-#define BTRFS_DEFAULT_MAX_INLINE	(2048)
-
-#define btrfs_clear_opt(o, opt)		((o) &= ~BTRFS_MOUNT_##opt)
-#define btrfs_set_opt(o, opt)		((o) |= BTRFS_MOUNT_##opt)
-#define btrfs_raw_test_opt(o, opt)	((o) & BTRFS_MOUNT_##opt)
-#define btrfs_test_opt(fs_info, opt)	((fs_info)->mount_opt & \
-					 BTRFS_MOUNT_##opt)
-
-#define btrfs_set_and_info(fs_info, opt, fmt, args...)			\
-do {									\
-	if (!btrfs_test_opt(fs_info, opt))				\
-		btrfs_info(fs_info, fmt, ##args);			\
-	btrfs_set_opt(fs_info->mount_opt, opt);				\
-} while (0)
-
-#define btrfs_clear_and_info(fs_info, opt, fmt, args...)		\
-do {									\
-	if (btrfs_test_opt(fs_info, opt))				\
-		btrfs_info(fs_info, fmt, ##args);			\
-	btrfs_clear_opt(fs_info->mount_opt, opt);			\
-} while (0)
-
 /*
  * Requests for changes that need to be done during transaction commit.
  *
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 6d30f74a4574..a2fbd48b46f1 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -13,6 +13,7 @@
 #include "qgroup.h"
 #include "space-info.h"
 #include "tree-mod-log.h"
+#include "fs.h"
 
 struct kmem_cache *btrfs_delayed_ref_head_cachep;
 struct kmem_cache *btrfs_delayed_tree_ref_cachep;
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index e1b7bd927d69..51f0ef386046 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -11,6 +11,7 @@
 #include "block-group.h"
 #include "discard.h"
 #include "free-space-cache.h"
+#include "fs.h"
 
 /*
  * This contains the logic to handle async discard.
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 3027c709a7cf..b472da0e9d1b 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -25,6 +25,7 @@
 #include "discard.h"
 #include "subpage.h"
 #include "inode-item.h"
+#include "fs.h"
 
 #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
 #define MAX_CACHE_BYTES_PER_GIG	SZ_64K
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 5e21ca9d172a..9f1fa2e88ffe 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -34,6 +34,48 @@ enum {
 	BTRFS_FS_STATE_COUNT
 };
 
+/*
+ * Flags for mount options.
+ *
+ * Note: don't forget to add new options to btrfs_show_options()
+ */
+enum {
+	BTRFS_MOUNT_NODATASUM			= (1UL << 0),
+	BTRFS_MOUNT_NODATACOW			= (1UL << 1),
+	BTRFS_MOUNT_NOBARRIER			= (1UL << 2),
+	BTRFS_MOUNT_SSD				= (1UL << 3),
+	BTRFS_MOUNT_DEGRADED			= (1UL << 4),
+	BTRFS_MOUNT_COMPRESS			= (1UL << 5),
+	BTRFS_MOUNT_NOTREELOG   		= (1UL << 6),
+	BTRFS_MOUNT_FLUSHONCOMMIT		= (1UL << 7),
+	BTRFS_MOUNT_SSD_SPREAD			= (1UL << 8),
+	BTRFS_MOUNT_NOSSD			= (1UL << 9),
+	BTRFS_MOUNT_DISCARD_SYNC		= (1UL << 10),
+	BTRFS_MOUNT_FORCE_COMPRESS      	= (1UL << 11),
+	BTRFS_MOUNT_SPACE_CACHE			= (1UL << 12),
+	BTRFS_MOUNT_CLEAR_CACHE			= (1UL << 13),
+	BTRFS_MOUNT_USER_SUBVOL_RM_ALLOWED	= (1UL << 14),
+	BTRFS_MOUNT_ENOSPC_DEBUG		= (1UL << 15),
+	BTRFS_MOUNT_AUTO_DEFRAG			= (1UL << 16),
+	BTRFS_MOUNT_USEBACKUPROOT		= (1UL << 17),
+	BTRFS_MOUNT_SKIP_BALANCE		= (1UL << 18),
+	BTRFS_MOUNT_CHECK_INTEGRITY		= (1UL << 19),
+	BTRFS_MOUNT_CHECK_INTEGRITY_DATA	= (1UL << 20),
+	BTRFS_MOUNT_PANIC_ON_FATAL_ERROR	= (1UL << 21),
+	BTRFS_MOUNT_RESCAN_UUID_TREE		= (1UL << 22),
+	BTRFS_MOUNT_FRAGMENT_DATA		= (1UL << 23),
+	BTRFS_MOUNT_FRAGMENT_METADATA		= (1UL << 24),
+	BTRFS_MOUNT_FREE_SPACE_TREE		= (1UL << 25),
+	BTRFS_MOUNT_NOLOGREPLAY			= (1UL << 26),
+	BTRFS_MOUNT_REF_VERIFY			= (1UL << 27),
+	BTRFS_MOUNT_DISCARD_ASYNC		= (1UL << 28),
+	BTRFS_MOUNT_IGNOREBADROOTS		= (1UL << 29),
+	BTRFS_MOUNT_IGNOREDATACSUMS		= (1UL << 30),
+};
+
+#define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
+#define BTRFS_DEFAULT_MAX_INLINE	(2048)
+
 /* compatibility and incompatibility defines */
 void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
 			       const char *name);
@@ -70,6 +112,26 @@ int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag);
 #define btrfs_fs_compat_ro(fs_info, opt) \
 	__btrfs_fs_compat_ro((fs_info), BTRFS_FEATURE_COMPAT_RO_##opt)
 
+#define btrfs_clear_opt(o, opt)		((o) &= ~BTRFS_MOUNT_##opt)
+#define btrfs_set_opt(o, opt)		((o) |= BTRFS_MOUNT_##opt)
+#define btrfs_raw_test_opt(o, opt)	((o) & BTRFS_MOUNT_##opt)
+#define btrfs_test_opt(fs_info, opt)	((fs_info)->mount_opt & \
+					 BTRFS_MOUNT_##opt)
+
+#define btrfs_set_and_info(fs_info, opt, fmt, args...)			\
+do {									\
+	if (!btrfs_test_opt(fs_info, opt))				\
+		btrfs_info(fs_info, fmt, ##args);			\
+	btrfs_set_opt(fs_info->mount_opt, opt);				\
+} while (0)
+
+#define btrfs_clear_and_info(fs_info, opt, fmt, args...)		\
+do {									\
+	if (btrfs_test_opt(fs_info, opt))				\
+		btrfs_info(fs_info, fmt, ##args);			\
+	btrfs_clear_opt(fs_info->mount_opt, opt);			\
+} while (0)
+
 static inline int btrfs_fs_closing(struct btrfs_fs_info *fs_info)
 {
 	/*
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 0d74ebd07159..eddeb8885701 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -11,6 +11,7 @@
 #include "locking.h"
 #include "delayed-ref.h"
 #include "ref-verify.h"
+#include "fs.h"
 
 /*
  * Used to keep track the roots and number of refs each root has for a given
-- 
2.26.3

