Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF16760E8BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbiJZTLy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiJZTLc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:32 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F3E13C3E2
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:08:58 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id r19so10719657qtx.6
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7q1qlNX01JE5wzvoLl3hqTqXs8DjRjUyGN45lH3tFE=;
        b=AdReZVLYVAEzKT4ZGpfBib4jmIZAokhkzWJKGU8XDahrZBekSHocPfqy3RnC5I7keV
         3JSo8RfQ2KnaW/jBmxfRWJOcP9LDwaGGaLIPQkThHAyOnWi4W0IOi9Ni6sbOK3xQ3KoW
         LhE0cXEZk1pBqqY2JpVnQnmVzKi6ypiKgQToEsMn0jKgu4+V+nGGSsCq3YXhiV8grGot
         d6jZXq5jYekCP3py+L8JXP8rih7pCrZJHiC260QGz4GE4hVSlPZgBP3mq/OYNnW+kmxU
         4qVGZDhdXFjiTCCo1J+COOS7XoFwgyRW3QwP36huXlfgLOBZbg9GtBYhiCnbt7oNIss1
         jmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7q1qlNX01JE5wzvoLl3hqTqXs8DjRjUyGN45lH3tFE=;
        b=it1lwahUKNsiww5dMWKqHtMf1N2cObNUl7uxIqQ9O50wWDS726DJuH/ATlw9jZszXP
         16xChkz3G2MKK6yS+TvBX6w5nWUVNk87FmJMePiUd90GRWqij+SZFTqR3s3JT3Lf1/D5
         Ns8hmd3BvB3f8QyrIEiMK9rtb7YNlbx6uvt6FmARYf/cJX1yKcmJ4t/bcUAfrqZpi3/v
         vMUxIlrx33PDZVN17VfU3QN84DpVlv/EwqThoQX0b/xkDkTVdmCXgNg+AwQf2fkTdhyc
         82B4TDHqT7LXbRFZI0/OhyjyOiZ43IPSl4jCooncki7QPMj7oh3OLLB04P0SgW8k4qvE
         NT1A==
X-Gm-Message-State: ACrzQf3Amlt5OVLkKbjp2mHcy2DRU4woOkL90ztRwz1j5b7eLTrg1+k1
        z9ZnGFqXso+aRHiENDHkA1L1wXF/wq9QjQ==
X-Google-Smtp-Source: AMsMyM7w4j4FVjW+7Vs2wwSCXT2ZkO1QDnE+VswVTd2KaIGcEnL0speHzPGMCugJ5FNGMf1LFDTZZA==
X-Received: by 2002:ac8:5e06:0:b0:399:1f54:8db4 with SMTP id h6-20020ac85e06000000b003991f548db4mr37651850qtx.100.1666811337574;
        Wed, 26 Oct 2022 12:08:57 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id y13-20020a05620a25cd00b006e6a7c2a269sm4513299qko.22.2022.10.26.12.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:08:57 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/26] btrfs: move defrag related prototypes to their own header
Date:   Wed, 26 Oct 2022 15:08:25 -0400
Message-Id: <c190b1a94b741f0e8c8bfb9253932f24da006a67.1666811038.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666811038.git.josef@toxicpanda.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
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

Now that the defrag code is all in one file, create a defrag.h and move
all the defrag related prototypes and helper out of ctree.h and into
defrag.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       | 18 ------------------
 fs/btrfs/defrag.c      |  1 +
 fs/btrfs/defrag.h      | 23 +++++++++++++++++++++++
 fs/btrfs/disk-io.c     |  1 +
 fs/btrfs/inode.c       |  1 +
 fs/btrfs/ioctl.c       |  1 +
 fs/btrfs/super.c       |  1 +
 fs/btrfs/transaction.c |  1 +
 8 files changed, 29 insertions(+), 18 deletions(-)
 create mode 100644 fs/btrfs/defrag.h

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c81fc444780d..6828a4640acf 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -772,19 +772,10 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 int btrfs_ioctl_get_supported_features(void __user *arg);
 void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
 int __pure btrfs_is_empty_uuid(u8 *uuid);
-int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
-		      struct btrfs_ioctl_defrag_range_args *range,
-		      u64 newer_than, unsigned long max_to_defrag);
 void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
 			       struct btrfs_ioctl_balance_args *bargs);
 
 /* file.c */
-int __init btrfs_auto_defrag_init(void);
-void __cold btrfs_auto_defrag_exit(void);
-int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
-			   struct btrfs_inode *inode, u32 extent_thresh);
-int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info);
-void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info);
 int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
 extern const struct file_operations btrfs_file_operations;
 int btrfs_drop_extents(struct btrfs_trans_handle *trans,
@@ -810,10 +801,6 @@ void btrfs_check_nocow_unlock(struct btrfs_inode *inode);
 bool btrfs_find_delalloc_in_range(struct btrfs_inode *inode, u64 start, u64 end,
 				  u64 *delalloc_start_ret, u64 *delalloc_end_ret);
 
-/* tree-defrag.c */
-int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
-			struct btrfs_root *root);
-
 /* super.c */
 int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			unsigned long new_flags);
@@ -944,11 +931,6 @@ static inline int is_fstree(u64 rootid)
 	return 0;
 }
 
-static inline int btrfs_defrag_cancelled(struct btrfs_fs_info *fs_info)
-{
-	return signal_pending(current);
-}
-
 /* verity.c */
 #ifdef CONFIG_FS_VERITY
 
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 01a8d5ff706b..98234aa4ee33 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -13,6 +13,7 @@
 #include "messages.h"
 #include "delalloc-space.h"
 #include "subpage.h"
+#include "defrag.h"
 
 static struct kmem_cache *btrfs_inode_defrag_cachep;
 /*
diff --git a/fs/btrfs/defrag.h b/fs/btrfs/defrag.h
new file mode 100644
index 000000000000..5ef85e6d762a
--- /dev/null
+++ b/fs/btrfs/defrag.h
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef BTRFS_DEFRAG_H
+#define BTRFS_DEFRAG_H
+
+int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
+		      struct btrfs_ioctl_defrag_range_args *range,
+		      u64 newer_than, unsigned long max_to_defrag);
+int __init btrfs_auto_defrag_init(void);
+void __cold btrfs_auto_defrag_exit(void);
+int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
+			   struct btrfs_inode *inode, u32 extent_thresh);
+int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info);
+void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info);
+int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
+			struct btrfs_root *root);
+
+static inline int btrfs_defrag_cancelled(struct btrfs_fs_info *fs_info)
+{
+	return signal_pending(current);
+}
+
+#endif
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7fefd5baa86b..fe7c6f4ac20b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -47,6 +47,7 @@
 #include "accessors.h"
 #include "extent-tree.h"
 #include "root-tree.h"
+#include "defrag.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f2c0842cffb5..1634a872f9c8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -59,6 +59,7 @@
 #include "accessors.h"
 #include "extent-tree.h"
 #include "root-tree.h"
+#include "defrag.h"
 
 struct btrfs_iget_args {
 	u64 ino;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0af0596bf127..2ae437b2432a 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -54,6 +54,7 @@
 #include "accessors.h"
 #include "extent-tree.h"
 #include "root-tree.h"
+#include "defrag.h"
 
 #ifdef CONFIG_64BIT
 /* If we have a 32-bit userspace and 64-bit kernel, then the UAPI
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a4030dfeb2f2..f105d360d6c9 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -52,6 +52,7 @@
 #include "raid56.h"
 #include "fs.h"
 #include "accessors.h"
+#include "defrag.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 9624bbb4b777..0a5258780e00 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -28,6 +28,7 @@
 #include "accessors.h"
 #include "extent-tree.h"
 #include "root-tree.h"
+#include "defrag.h"
 
 static struct kmem_cache *btrfs_trans_handle_cachep;
 
-- 
2.26.3

