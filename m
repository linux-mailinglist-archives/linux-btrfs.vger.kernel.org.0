Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EF2604A1A
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Oct 2022 16:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiJSO6O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 10:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiJSO5i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 10:57:38 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6C192F6F
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:13 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id m6so10825106qkm.4
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gq582dryUxhFjASK+r8qUyUXtOhkg8MxzAZmIdbs8vo=;
        b=yGLrggo7Swp7D5V42Q8eG/HTcSC40TX3c4q/K2R+ZlOLIGJoh71Oe8fgs1NpZsBHtN
         z9naOCw0IxGTBn3flnLUoi4jqc2SWFzEPi0LYZ4nV90MuKgFjmtwCuniHOP52Rcpoghc
         PB3aUVEHJOzh0VbgBvrtHVCW+hjW5ddjBM7WzlhQqpw42LpDO88mnUufo5RQ2GobtpkF
         D/p1+w9qdCalo5+uATNJm5gXz0he2ZOMW2blad1ZNYxu/WoiASF1VVQIl3hGj3cPBV2V
         ia1a3OBYSbc4mZ4H0iOoxOdY6wXSeRjigxaeNdOg/nPQmpFXtggK9YBnoha7HE01ikGN
         z4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gq582dryUxhFjASK+r8qUyUXtOhkg8MxzAZmIdbs8vo=;
        b=np7dlhb9ek3oZJ5rzXoRKsylyATOZkWNg9XSBO5hBhy7VyjTDQOPwyuvjgyEbyyi2U
         1bg68TPhDBtm9afh6UuN1bdcRPyJgAJ9QJp8KoJh31voFRNrLSfJU8tWbq0vFA2soam4
         wg4SUxs+ESSIqtzV7Q09kPe4ozy92dVdCSXeWHD+EAwdE/xrziepjYjtP1ZN+1dXvAy/
         2DmVOgaXiiVeRQCFVWIggUz/qozGzWRmAZKy4Pdpg+gDMcdIa8jMdHeNMB/eWdRWvpgr
         VaTfGQfo+llbzNElQZAcx7T0TK22iuv4OyKVAOInU9cl6MG623coERnAO7eKupIhpwvi
         OPcA==
X-Gm-Message-State: ACrzQf3NYIxKPohQKjEKABYdEiqE1hgyLWw/JS8oNj+3zhYJDHJeEy7L
        eMPvJrwesh97MrasovJZ0S0bWrQNoUUU2A==
X-Google-Smtp-Source: AMsMyM5CZws4aFGLsIzxFJi568ZyDlPwllXDkfE1zQ9Qcx65y6mllFiyR747lTRuZvA6hbpfIBrgBQ==
X-Received: by 2002:a05:620a:2807:b0:6cf:cb30:8ff5 with SMTP id f7-20020a05620a280700b006cfcb308ff5mr5691439qkp.206.1666191072452;
        Wed, 19 Oct 2022 07:51:12 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id h19-20020a05620a401300b006eed47a1a1esm5176289qko.134.2022.10.19.07.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:51:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 07/15] btrfs: move mount option definitions to fs.h
Date:   Wed, 19 Oct 2022 10:50:53 -0400
Message-Id: <9a53b66cecf607e6ccdd9b5ed0a60cf5dac343fc.1666190849.git.josef@toxicpanda.com>
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

These are fs wide definitions and helpers, move them out of ctree.h and
into fs.h.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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
index b7a5263b6a3f..89d70589d479 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1320,68 +1320,6 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
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
index c775ff4f1cb1..010cc16297d8 100644
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
index 703902156f97..2f785ae42c55 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -26,6 +26,7 @@
 #include "discard.h"
 #include "subpage.h"
 #include "inode-item.h"
+#include "fs.h"
 
 #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
 #define MAX_CACHE_BYTES_PER_GIG	SZ_64K
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 857caa07fd77..92a17b1fda8b 100644
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
 void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
 			     const char *name);
@@ -72,6 +114,26 @@ void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
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
index f7535b8b62f5..9b09dc50ba14 100644
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

