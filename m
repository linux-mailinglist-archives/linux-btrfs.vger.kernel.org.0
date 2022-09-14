Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9575B8E02
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 19:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiINRSm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 13:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiINRS2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 13:18:28 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6F0816B6
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:27 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id k12so11384227qkj.8
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=LWyhuL3GZzibgo1c5hvDqO6F2qV3Gn0h91QBMdD4v+g=;
        b=Xi9TnipwBK8bhybeN4wiJVyqLL2xsNUZkVYlV2CHpMxp6M0DcVX0xESkzNQEo1kx1B
         P/TUmN2THWS1x9Ijxt28IB0F7XNWjxE/qgIO07cN/s/cO+dzjG8n6AlKfivcAk/hGmjb
         cZsQTwtfiIqF4Oho9Htw1kqThGAOqzCmyy1BHqMDU5/GOFmDG1J9yo/54t3iTgiIM7q4
         R3pssO6Mp4LSZuLcTIqTXv8IblVhpmCm3NVkpIg/yJY+RNfLW73ab4QnRltn6oK+v8wk
         iCK2JdpwD3Mu7N4LI8xMYKL/A103X1o6L11TwW1F5k6svegMRdBEp280YMpVwBV88foz
         Ledw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LWyhuL3GZzibgo1c5hvDqO6F2qV3Gn0h91QBMdD4v+g=;
        b=0TtLCrb/qPoBsQFQqeua7sislAw6u6QxzfOp9komgcSLzuGp8io6cjAtG44iU8st32
         w0DUdrVv83Fan0dASArzkodukgBSl6qto2F367IP+T8bbNAhJS8OMox+pOLF8arUCcoM
         OKCp83wGmLlrXjqicPAi7c9d0p7uH+gdDAKbWWKZ8YHn8NlzSp1Ko4Jq5mhhZQ9Ua35e
         em6PkY84gUk6vaeFYwyIG2XNgkrnA1iG78yp6Efp+9k358en9Cutd6bp7jgyZdMCVO1T
         UtKRM/J8/eLHL7uIiiqdaZEg+7/Tkg1GkmXQdedeoJUdP11HPL8Ko7sLpS/tJToslaCp
         gJSA==
X-Gm-Message-State: ACgBeo2f5SCvxHQxpRJF1kHsUR++x1/q3ia8wB5qq8vVXjyUW2+3P3es
        EJZ7MIOV8nohqqXQGZml0omy7oMPnejOfQ==
X-Google-Smtp-Source: AA6agR4J/dvkn9LveYaun48iGMnAkmuNTbFgBsOrpOffHqYmxTE4F7oUahbKr3C5zNhA40Mdnmerew==
X-Received: by 2002:a05:620a:1404:b0:6ce:1602:d46d with SMTP id d4-20020a05620a140400b006ce1602d46dmr14190731qkj.409.1663175905934;
        Wed, 14 Sep 2022 10:18:25 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v5-20020a05620a0f0500b006bb2bca5741sm2363554qkl.93.2022.09.14.10.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 10:18:25 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/16] btrfs: move larger compat flag helpers to their own c file
Date:   Wed, 14 Sep 2022 13:18:07 -0400
Message-Id: <92a20e2cd0cbf74630be86dfe0998aa3e711529c.1663175597.git.josef@toxicpanda.com>
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

These helpers use a lot of different functions that would be defined
elsewhere.  Push them into a C file so we don't end up with weird header
file dependencies.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/Makefile |   2 +-
 fs/btrfs/fs.c     |  92 +++++++++++++++++++++++++++++++++++++++
 fs/btrfs/fs.h     | 108 +++++++---------------------------------------
 3 files changed, 108 insertions(+), 94 deletions(-)
 create mode 100644 fs/btrfs/fs.c

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index fa9ddcc9eb0b..eebb45c06485 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -31,7 +31,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
 	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
-	   subpage.o tree-mod-log.o extent-io-tree.o
+	   subpage.o tree-mod-log.o extent-io-tree.o fs.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
new file mode 100644
index 000000000000..d4ba948eba56
--- /dev/null
+++ b/fs/btrfs/fs.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "ctree.h"
+#include "fs.h"
+
+void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
+			     const char *name)
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
+void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
+			       const char *name)
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
+void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
+			      const char *name)
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
+void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
+				const char *name)
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
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 56be405a008c..36ad05b329ce 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -4,124 +4,46 @@
 #define BTRFS_FS_H
 
 /* compatibility and incompatibility defines */
+void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
+			       const char *name);
+void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
+			     const char *name);
+void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
+			      const char *name);
+void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
+			      const char *name);
+void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
+				const char *name);
 
 #define btrfs_set_fs_incompat(__fs_info, opt) \
 	__btrfs_set_fs_incompat((__fs_info), BTRFS_FEATURE_INCOMPAT_##opt, \
 				#opt)
 
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
 #define btrfs_clear_fs_incompat(__fs_info, opt) \
 	__btrfs_clear_fs_incompat((__fs_info), BTRFS_FEATURE_INCOMPAT_##opt, \
 				  #opt)
 
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
 #define btrfs_fs_incompat(fs_info, opt) \
 	__btrfs_fs_incompat((fs_info), BTRFS_FEATURE_INCOMPAT_##opt)
 
-static inline bool __btrfs_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag)
-{
-	struct btrfs_super_block *disk_super;
-	disk_super = fs_info->super_copy;
-	return !!(btrfs_super_incompat_flags(disk_super) & flag);
-}
-
 #define btrfs_set_fs_compat_ro(__fs_info, opt) \
 	__btrfs_set_fs_compat_ro((__fs_info), BTRFS_FEATURE_COMPAT_RO_##opt, \
 				 #opt)
 
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
 #define btrfs_clear_fs_compat_ro(__fs_info, opt) \
 	__btrfs_clear_fs_compat_ro((__fs_info), BTRFS_FEATURE_COMPAT_RO_##opt, \
 				   #opt)
 
-static inline void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info,
-					      u64 flag, const char *name)
+#define btrfs_fs_compat_ro(fs_info, opt) \
+	__btrfs_fs_compat_ro((fs_info), BTRFS_FEATURE_COMPAT_RO_##opt)
+
+static inline bool __btrfs_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag)
 {
 	struct btrfs_super_block *disk_super;
-	u64 features;
-
 	disk_super = fs_info->super_copy;
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
+	return !!(btrfs_super_incompat_flags(disk_super) & flag);
 }
 
-#define btrfs_fs_compat_ro(fs_info, opt) \
-	__btrfs_fs_compat_ro((fs_info), BTRFS_FEATURE_COMPAT_RO_##opt)
-
 static inline int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag)
 {
 	struct btrfs_super_block *disk_super;
-- 
2.26.3

