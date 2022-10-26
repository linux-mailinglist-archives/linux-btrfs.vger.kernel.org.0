Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E532560E8C8
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbiJZTMN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbiJZTLl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:41 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29698FE91D
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:15 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id s27so4840944ioa.10
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p/Phw7/gATXP7Xzb19gl+17rrzysKl6GYM3Y9ZqJ3Y4=;
        b=vXsJsk0moNy1+b8wMtoSK+4dbphNp8S9JeZXHXlgkBHhg0iKwToxQ3b5Cp7nDPT/di
         kN3jEGRJyxJX+4HeuwUzA5DK4MM8vJB7rSlYW26fQouCJnGyE+HCaGARxWaXd9toEgnR
         /PmHHA8+d0pkqWPlXZQUP80sWBPGyfsf2z9rwl+VUx2EZqK/ZBO/IflAmeMDYlqy44j6
         QDih1/k0YFyp7r4br45wfWlTHXVmRQZm5ekcKJpaNZSp1CcxoLABl5waW+P4LiSP6o8/
         GKYkstc8+Pg458BWEeGVModNrRZb8FjGK6AopSUGMyw9EKqZStClL7vnoLal4JoxdCZ+
         nsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/Phw7/gATXP7Xzb19gl+17rrzysKl6GYM3Y9ZqJ3Y4=;
        b=JdA3zJmIvwGOoXOBB+FpKyx2bq5TfgwjEvW2gQiszC34T32VKgPxii5OgiYmbKF4Ze
         2Zq/ES8ummuk44uUQaPO8t0qzJX6b/woEtNYni4qT7xRO/BYL1V/GGgazMGqcwId9zIL
         NuDwWjpXXNN5USLZvf/d0anuJl9pynHgz4JGW4QNT0QAHJOajt8SyNpBCfCu6AxaFdZH
         WTgpNd50uM9+wS59LVyUFmqDs+qd9oNkT8MH+VmJSHU+b/xCMpJ8tMfSIcyEwV8TXONk
         8lQDwg+8v3weqWPpJoNl01QQD7V9EZUNeAJxlWoqF6YqTwlksi+572NhTc9upXolNCsW
         EYYQ==
X-Gm-Message-State: ACrzQf15S93Gnzn+9WPlFZR5KAz2o92lsnYrCmKmZiYAJLCB858v52A8
        +NIWpgDDs7t48CrH0AdTh1jnR0eBU6YLyw==
X-Google-Smtp-Source: AMsMyM4PTQhF7EWXHyvS/h2wIOFNpCa9D8jM469OExrv0PQ5t/MYBlQco81ap7EWcGHQsBvqSVQFxw==
X-Received: by 2002:ac8:5f87:0:b0:39c:dfc2:40f9 with SMTP id j7-20020ac85f87000000b0039cdfc240f9mr37824734qta.315.1666811343127;
        Wed, 26 Oct 2022 12:09:03 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id dm10-20020a05620a1d4a00b006af0ce13499sm4521008qkb.115.2022.10.26.12.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:09:02 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 14/26] btrfs: move ioctl prototypes into ioctl.h
Date:   Wed, 26 Oct 2022 15:08:29 -0400
Message-Id: <779e5d48b8e1c54974e6d90d5825b6477f5750aa.1666811039.git.josef@toxicpanda.com>
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

Move these out of ctree.h into ioctl.h to cut down on code in ctree.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       | 12 ------------
 fs/btrfs/file.c        |  1 +
 fs/btrfs/inode.c       |  1 +
 fs/btrfs/ioctl.c       |  1 +
 fs/btrfs/ioctl.h       | 17 +++++++++++++++++
 fs/btrfs/send.c        |  1 +
 fs/btrfs/super.c       |  1 +
 fs/btrfs/transaction.c |  1 +
 fs/btrfs/verity.c      |  1 +
 fs/btrfs/volumes.c     |  1 +
 10 files changed, 25 insertions(+), 12 deletions(-)
 create mode 100644 fs/btrfs/ioctl.h

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 910a23e7cd8f..87930337b301 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -688,18 +688,6 @@ int btrfs_insert_orphan_item(struct btrfs_trans_handle *trans,
 int btrfs_del_orphan_item(struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root, u64 offset);
 
-/* ioctl.c */
-long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
-long btrfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
-int btrfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
-int btrfs_fileattr_set(struct user_namespace *mnt_userns,
-		       struct dentry *dentry, struct fileattr *fa);
-int btrfs_ioctl_get_supported_features(void __user *arg);
-void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
-int __pure btrfs_is_empty_uuid(u8 *uuid);
-void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
-			       struct btrfs_ioctl_balance_args *bargs);
-
 /* file.c */
 int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
 extern const struct file_operations btrfs_file_operations;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 65a98bd5e395..7b361a3d7785 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -34,6 +34,7 @@
 #include "accessors.h"
 #include "extent-tree.h"
 #include "file-item.h"
+#include "ioctl.h"
 
 /* simple helper to fault in pages and copy.  This should go away
  * and be replaced with calls into generic code.
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0be05e267283..d33b4f9f4aaa 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -63,6 +63,7 @@
 #include "dir-item.h"
 #include "file-item.h"
 #include "uuid-tree.h"
+#include "ioctl.h"
 
 struct btrfs_iget_args {
 	u64 ino;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d255757b3450..2d691d147876 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -57,6 +57,7 @@
 #include "defrag.h"
 #include "dir-item.h"
 #include "uuid-tree.h"
+#include "ioctl.h"
 
 #ifdef CONFIG_64BIT
 /* If we have a 32-bit userspace and 64-bit kernel, then the UAPI
diff --git a/fs/btrfs/ioctl.h b/fs/btrfs/ioctl.h
new file mode 100644
index 000000000000..2cd749cfcfb6
--- /dev/null
+++ b/fs/btrfs/ioctl.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef BTRFS_IOCTL_H
+#define BTRFS_IOCTL_H
+
+long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+long btrfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+int btrfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+int btrfs_fileattr_set(struct user_namespace *mnt_userns,
+		       struct dentry *dentry, struct fileattr *fa);
+int btrfs_ioctl_get_supported_features(void __user *arg);
+void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
+int __pure btrfs_is_empty_uuid(u8 *uuid);
+void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
+			       struct btrfs_ioctl_balance_args *bargs);
+
+#endif /* BTRFS_IOCTL_H */
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 07524d070c48..1ee8149c0440 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -30,6 +30,7 @@
 #include "accessors.h"
 #include "dir-item.h"
 #include "file-item.h"
+#include "ioctl.h"
 
 /*
  * Maximum number of references an extent can have in order for us to attempt to
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 9756b0cda626..2cd05246bcd3 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -54,6 +54,7 @@
 #include "accessors.h"
 #include "defrag.h"
 #include "dir-item.h"
+#include "ioctl.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index ded084cb46d9..e491fbcd404f 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -31,6 +31,7 @@
 #include "defrag.h"
 #include "dir-item.h"
 #include "uuid-tree.h"
+#include "ioctl.h"
 
 static struct kmem_cache *btrfs_trans_handle_cachep;
 
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index d02fa354fc2b..00ba5143a17d 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -18,6 +18,7 @@
 #include "locking.h"
 #include "fs.h"
 #include "accessors.h"
+#include "ioctl.h"
 
 /*
  * Implementation of the interface defined in struct fsverity_operations.
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2495c8f62d87..4b70cfab02ab 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -36,6 +36,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "uuid-tree.h"
+#include "ioctl.h"
 
 static struct bio_set btrfs_bioset;
 
-- 
2.26.3

