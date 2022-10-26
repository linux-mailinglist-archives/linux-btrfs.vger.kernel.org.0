Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2323F60E8C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiJZTME (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbiJZTLi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:38 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899CE101DE
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:10 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id w29so3598595qtv.9
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zvvGoD/3b3GciQMg81uLJgKSmnSxMK44N+tX/swOv8w=;
        b=lnU8uyWRgnkzEzrqeKCvvvkFJYWvnM4vL22g79BHb/BvMgI5F1IabbMRYDkmKvCkp+
         ct3R998sSWPK/lf/DFNtHQLxaY+oPc3CCBKo3IbCC6nnD3+AeIeQ9iTmNDJLYoxCXGhs
         Qjd/T61i/IOdogscpoGf6O7x7rlglmR3/I7go0kYV1GGbDVoi7N8FaFKCh9GtkMAvsCo
         gp2R9q1Qtf9yIWdgeoZfObMhPiuKw4uSGOcWTuHnDhMcbUgp3RxA2tIJWBnOG+6jOq1x
         P7SxI+eIaC+DduOoVKgjbrhXZOWgbRXQpbrNRKQ7JDfMVJwdkkHPriLgXGemjFqGPnwI
         gf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvvGoD/3b3GciQMg81uLJgKSmnSxMK44N+tX/swOv8w=;
        b=blNlNHyIwxBiXD6OXJ7BKMLejR4dELRE2ixgeTtJI7YLIuf8ZdseU23LvirG79V7w6
         I8/xmnaTeYp6ZyDhLJ0rHbbbnnNHYLJzpaGyiNJwsvNw5wDq9v97BgzM/d15L6Rb5KKv
         bW0QAkLszQsPu+LUAmRMI13sx4gh5WEiAxsfSo6eqjhrMcjbaEa+1Z/qSn5vNqPu7oKY
         DAdgh+valx+2v9nNrUz1UKVhkiHD6V6yCZHEZRMu7YixU2xeXZr2TP8WQII0Y6Nuo5xB
         wEsBArMg+o4kbRBCDPky9cwRa5ALfWFkE+S7KDRA7Tm0ZxoC/uNwlXwvO5qUZn6vF/QO
         DAVw==
X-Gm-Message-State: ACrzQf2v0U1YutYmDqi359M75ewQJ8hCkHS/JLKui3N5V82upcO+fIvJ
        dEFSSAqW8+F0PxbbmjoAKU80e+9zMNSZOg==
X-Google-Smtp-Source: AMsMyM5qfZKskH+W8Wmf5jMsAhIbiEocW51aw/sZZ8Ij2Kyt//s3pc2ChxhFimsoIBt7SHnDdVvcJA==
X-Received: by 2002:a05:622a:44b:b0:39c:f5bf:694d with SMTP id o11-20020a05622a044b00b0039cf5bf694dmr36887974qtx.531.1666811338860;
        Wed, 26 Oct 2022 12:08:58 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id o5-20020ac86985000000b0035cd6a4ba3csm3571595qtq.39.2022.10.26.12.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:08:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/26] btrfs: move dir-item prototypes into dir-item.h
Date:   Wed, 26 Oct 2022 15:08:26 -0400
Message-Id: <538b284da3a43e4ffa11f057e4db2ffe3119a6e0.1666811038.git.josef@toxicpanda.com>
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

Move these prototypes out of ctree.h and into their own header file.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       | 38 -------------------------------------
 fs/btrfs/dir-item.c    |  1 +
 fs/btrfs/dir-item.h    | 43 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/inode.c       |  1 +
 fs/btrfs/ioctl.c       |  1 +
 fs/btrfs/send.c        |  1 +
 fs/btrfs/super.c       |  1 +
 fs/btrfs/transaction.c |  1 +
 fs/btrfs/tree-log.c    |  1 +
 fs/btrfs/xattr.c       |  1 +
 10 files changed, 51 insertions(+), 38 deletions(-)
 create mode 100644 fs/btrfs/dir-item.h

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6828a4640acf..a2ec5044a1c6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -689,44 +689,6 @@ int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 			u64 subid);
 int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info);
 
-/* dir-item.c */
-int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
-			  const struct fscrypt_str *name);
-int btrfs_insert_dir_item(struct btrfs_trans_handle *trans,
-			  const struct fscrypt_str *name, struct btrfs_inode *dir,
-			  struct btrfs_key *location, u8 type, u64 index);
-struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
-					     struct btrfs_root *root,
-					     struct btrfs_path *path, u64 dir,
-					     const struct fscrypt_str *name, int mod);
-struct btrfs_dir_item *
-btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
-			    struct btrfs_root *root,
-			    struct btrfs_path *path, u64 dir,
-			    u64 index, const struct fscrypt_str *name, int mod);
-struct btrfs_dir_item *
-btrfs_search_dir_index_item(struct btrfs_root *root,
-			    struct btrfs_path *path, u64 dirid,
-			    const struct fscrypt_str *name);
-int btrfs_delete_one_dir_name(struct btrfs_trans_handle *trans,
-			      struct btrfs_root *root,
-			      struct btrfs_path *path,
-			      struct btrfs_dir_item *di);
-int btrfs_insert_xattr_item(struct btrfs_trans_handle *trans,
-			    struct btrfs_root *root,
-			    struct btrfs_path *path, u64 objectid,
-			    const char *name, u16 name_len,
-			    const void *data, u16 data_len);
-struct btrfs_dir_item *btrfs_lookup_xattr(struct btrfs_trans_handle *trans,
-					  struct btrfs_root *root,
-					  struct btrfs_path *path, u64 dir,
-					  const char *name, u16 name_len,
-					  int mod);
-struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_fs_info *fs_info,
-						 struct btrfs_path *path,
-						 const char *name,
-						 int name_len);
-
 /* orphan.c */
 int btrfs_insert_orphan_item(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root, u64 offset);
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index ca69fb35a2cc..082eb0e19598 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -8,6 +8,7 @@
 #include "disk-io.h"
 #include "transaction.h"
 #include "accessors.h"
+#include "dir-item.h"
 
 /*
  * insert a name into a directory, doing overflow properly if there is a hash
diff --git a/fs/btrfs/dir-item.h b/fs/btrfs/dir-item.h
new file mode 100644
index 000000000000..4cfc7cbe1677
--- /dev/null
+++ b/fs/btrfs/dir-item.h
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef BTRFS_DIR_ITEM_H
+#define BTRFS_DIR_ITEM_H
+
+int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
+			  const struct fscrypt_str *name);
+int btrfs_insert_dir_item(struct btrfs_trans_handle *trans,
+			  const struct fscrypt_str *name, struct btrfs_inode *dir,
+			  struct btrfs_key *location, u8 type, u64 index);
+struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
+					     struct btrfs_root *root,
+					     struct btrfs_path *path, u64 dir,
+					     const struct fscrypt_str *name, int mod);
+struct btrfs_dir_item *
+btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
+			    struct btrfs_root *root,
+			    struct btrfs_path *path, u64 dir,
+			    u64 index, const struct fscrypt_str *name, int mod);
+struct btrfs_dir_item *
+btrfs_search_dir_index_item(struct btrfs_root *root,
+			    struct btrfs_path *path, u64 dirid,
+			    const struct fscrypt_str *name);
+int btrfs_delete_one_dir_name(struct btrfs_trans_handle *trans,
+			      struct btrfs_root *root,
+			      struct btrfs_path *path,
+			      struct btrfs_dir_item *di);
+int btrfs_insert_xattr_item(struct btrfs_trans_handle *trans,
+			    struct btrfs_root *root,
+			    struct btrfs_path *path, u64 objectid,
+			    const char *name, u16 name_len,
+			    const void *data, u16 data_len);
+struct btrfs_dir_item *btrfs_lookup_xattr(struct btrfs_trans_handle *trans,
+					  struct btrfs_root *root,
+					  struct btrfs_path *path, u64 dir,
+					  const char *name, u16 name_len,
+					  int mod);
+struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_fs_info *fs_info,
+						 struct btrfs_path *path,
+						 const char *name,
+						 int name_len);
+
+#endif
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1634a872f9c8..d02b0d7179ab 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -60,6 +60,7 @@
 #include "extent-tree.h"
 #include "root-tree.h"
 #include "defrag.h"
+#include "dir-item.h"
 
 struct btrfs_iget_args {
 	u64 ino;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 2ae437b2432a..e728bcec9419 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -55,6 +55,7 @@
 #include "extent-tree.h"
 #include "root-tree.h"
 #include "defrag.h"
+#include "dir-item.h"
 
 #ifdef CONFIG_64BIT
 /* If we have a 32-bit userspace and 64-bit kernel, then the UAPI
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index f9f0a4b968c8..78de4bf661f4 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -28,6 +28,7 @@
 #include "xattr.h"
 #include "print-tree.h"
 #include "accessors.h"
+#include "dir-item.h"
 
 /*
  * Maximum number of references an extent can have in order for us to attempt to
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f105d360d6c9..9756b0cda626 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -53,6 +53,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "defrag.h"
+#include "dir-item.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 0a5258780e00..910d176ccec0 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -29,6 +29,7 @@
 #include "extent-tree.h"
 #include "root-tree.h"
 #include "defrag.h"
+#include "dir-item.h"
 
 static struct kmem_cache *btrfs_trans_handle_cachep;
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index aff14a9ad98f..5b89a9b755d8 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -25,6 +25,7 @@
 #include "accessors.h"
 #include "extent-tree.h"
 #include "root-tree.h"
+#include "dir-item.h"
 
 #define MAX_CONFLICT_INODES 10
 
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index fcf2d5f7e198..0ed4b119a7ca 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -22,6 +22,7 @@
 #include "props.h"
 #include "locking.h"
 #include "accessors.h"
+#include "dir-item.h"
 
 int btrfs_getxattr(struct inode *inode, const char *name,
 				void *buffer, size_t size)
-- 
2.26.3

