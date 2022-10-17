Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129236016F3
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 21:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiJQTJY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 15:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiJQTJV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 15:09:21 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11F5CF
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:19 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id h10so7995929qvq.7
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYdcAPOcXfVd6197w0C9DNr241Mt1Gqrqxu3YlVIxmE=;
        b=DRnacWy7/KhYrj9Qp1dCbp4qJs0NrOThCoByx3nw/GkH4voBqxLfHN373vOUIzAbqX
         QISwYcgtX0ByqgZQck6/GGxhSlCf7zphpVp7TNCV5FAbuzu94zkqgu9pxHYMiiWxTExa
         +42OoBtyj05ugh1aizx6s2rHzMkZVPFuW3Nxkw0Y/O+IV72hmQ4Cm6msnPnHCX7pKgQf
         rhh8gBzIm7vxgpIA1yX5OQf8Wz8tMHTwD78KA55IG8JkkcZMFMUNnuqpqFyv+fP/e6nT
         Kxpgim0k6qhOK7xLDOCeDTWVJ2w0ipNK02CY0kvuNHn/XFu2ofzBK6geD+1DP1Evk9sJ
         QOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYdcAPOcXfVd6197w0C9DNr241Mt1Gqrqxu3YlVIxmE=;
        b=aHQSv6t3xxcFuZa82ehUSBVrM3j27OWaRYZ1TM4k9TJDdqGFFYSKMRhQ1PgSLmovB5
         T/K/9Ej8O45s47p7vjzXJWNpNhHTGGqfcNgaUCXM5kGlqip8hPUqrNpFw5XnYo+Ndko9
         NDnzr1SIXGo3eFQ8jjeHuxmu5w7BmwE4zDmDxSP0ni9SjNnl3N7oyWp/Aa52TSs+yw73
         iQQSPDv/CBsnrLjAzxLeWtqp+LQDcYk7ewKVy/RmAsRldS4QSmeJwdQTx/zP/vq92Chx
         SHmYcBecLrqIMKlJOU1wkO6E81kiXmOkSzWnr94bPhkrer7ofgwaNJdUULN779p0YsPO
         u4Og==
X-Gm-Message-State: ACrzQf0jWK+UJwDcKhArrXcvmGWbKbJc47Wrsh0VTbt0gTfMzD+4KG28
        lcVmzG77GRhOrWq0RCFh5QLXrpukfpfezA==
X-Google-Smtp-Source: AMsMyM6ioPtavByu1JenspQWEhbANLi+55cuDCmjh8PFVZkawlE6DhF23JzmqQhPJPjDKMrKqSz+2Q==
X-Received: by 2002:a05:6214:d06:b0:4b3:f2ea:f67c with SMTP id 6-20020a0562140d0600b004b3f2eaf67cmr9658556qvh.84.1666033758301;
        Mon, 17 Oct 2022 12:09:18 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id d4-20020ac81184000000b00359961365f1sm370629qtj.68.2022.10.17.12.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:09:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 02/16] btrfs: move larger compat flag helpers to their own c file
Date:   Mon, 17 Oct 2022 15:08:59 -0400
Message-Id: <bd00bf180e1f4437d887fb7b893bd37d5103c25c.1666033501.git.josef@toxicpanda.com>
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

These helpers use a lot of different functions that would be defined
elsewhere.  Push them into a C file so we don't end up with weird header
file dependencies.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/Makefile |   2 +-
 fs/btrfs/fs.c     |  92 ++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/fs.h     | 106 ++++++----------------------------------------
 3 files changed, 106 insertions(+), 94 deletions(-)
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
index 56be405a008c..fc7564ebf286 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -4,124 +4,44 @@
 #define BTRFS_FS_H
 
 /* compatibility and incompatibility defines */
+void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
+			     const char *name);
+void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
+			       const char *name);
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

