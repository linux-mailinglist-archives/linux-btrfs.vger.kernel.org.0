Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B177860BA78
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Oct 2022 22:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbiJXUhb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 16:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbiJXUgr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 16:36:47 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6AA186D75
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 11:48:32 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id r19so6169170qtx.6
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 11:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8s5XJIhbBQQmdILOVsO3LPJcBV08ZB09wgLYaeJiz0E=;
        b=dOddpFzdpRkVkBaVhNeZ104ear5eztLN2CSq85BKELEeFfoPqcS9bV/KCByWlfbciQ
         HHbngf1kNMKQ6b5yQ1rosQlnDQi9IbFMFX8UJljT8yu2by2/CpsIyQ9lDcfL0wuExCwO
         yoQNPR72etSDik99Sxv6RjfYHDTHRWnq8H5WHo2ws8il8Id4YIUT9p86qZ579W+NLYI4
         Kc55z0gSuX/ieUTbH3w7l4LVlAKJILoDQCKOtDdowwujICHHfoCH2xZ06P6061bi80q4
         0cDfRgMTvSYzDJ/Jm/iQ2cNwA4LgWttGvd4Xq3/cAxEFmctKC1LaS9JiidlULxqhadUl
         DTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8s5XJIhbBQQmdILOVsO3LPJcBV08ZB09wgLYaeJiz0E=;
        b=a2ay23yuqEFMKq4gs41aaQJILwhnXBN3qhPytg+jtTvZj/frPUNJnZdKIAOEZ9kGKR
         rXMlG0R4QQm1lAx6Ou79BimCpWotS//0g/lN4nv7I0FqvIQ19QAnH5iIH6mCH23O3PGg
         CSPj+7gZ+yiz2S+M5Auu7S32x8eiYjxKZ9zBFteuGI8AO6jqvogkF0oq65vR5vta7p8B
         HSRvcZFhiOeu6kSHrdXD82FqjCl6m+IFGjF1wBiA+q9TkTih8SOUeEOfbYQzvnX7pTGR
         nua79t3Gn3sOuTNQcJ6PfAN+uZHeoDKskgOLH34MXc82dd3FttSqjtZFsWWug/a7iGd9
         yLDA==
X-Gm-Message-State: ACrzQf1X0YWFQhl6TQB7Fk7IQUXzElmPqfto01KiG7Yy610NQ+dE0lb6
        L4smSMC5n4oRzVQ1N7Ln+uuMlbHKVlj3eA==
X-Google-Smtp-Source: AMsMyM40RRqSIQWaEv80IAMdA3PeYRePnfA+EhD6jT8ecYt4Xi3eIlYq70SL09W7e0O6KuB3KuFD/Q==
X-Received: by 2002:ac8:5849:0:b0:39a:8e35:1bfa with SMTP id h9-20020ac85849000000b0039a8e351bfamr28230911qth.573.1666637236276;
        Mon, 24 Oct 2022 11:47:16 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id r2-20020ac85e82000000b0035ba48c032asm373224qtx.25.2022.10.24.11.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:47:15 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 9/9] btrfs: move root tree prototypes to their own header
Date:   Mon, 24 Oct 2022 14:47:00 -0400
Message-Id: <84346572982f274f797e214d8093e1eab12012da.1666637013.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666637013.git.josef@toxicpanda.com>
References: <cover.1666637013.git.josef@toxicpanda.com>
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

Move all the root-tree.c prototypes to root-tree.h, and then update all
the necessary files to include the new header.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h           | 32 --------------------------------
 fs/btrfs/disk-io.c         |  1 +
 fs/btrfs/extent-tree.c     |  1 +
 fs/btrfs/free-space-tree.c |  1 +
 fs/btrfs/inode.c           |  1 +
 fs/btrfs/ioctl.c           |  1 +
 fs/btrfs/qgroup.c          |  1 +
 fs/btrfs/relocation.c      |  1 +
 fs/btrfs/root-tree.c       |  1 +
 fs/btrfs/root-tree.h       | 36 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/transaction.c     |  1 +
 fs/btrfs/tree-log.c        |  1 +
 12 files changed, 46 insertions(+), 32 deletions(-)
 create mode 100644 fs/btrfs/root-tree.h

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1aff14f35796..98ef5aed419b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -486,12 +486,6 @@ static inline gfp_t btrfs_alloc_write_mask(struct address_space *mapping)
 	return mapping_gfp_constraint(mapping, ~__GFP_FS);
 }
 
-int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
-				     struct btrfs_block_rsv *rsv,
-				     int nitems, bool use_global_rsv);
-void btrfs_subvolume_release_metadata(struct btrfs_root *root,
-				      struct btrfs_block_rsv *rsv);
-
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end);
 int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
@@ -687,32 +681,6 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 			struct extent_buffer *node,
 			struct extent_buffer *parent);
 
-/* root-item.c */
-int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
-		       u64 ref_id, u64 dirid, u64 sequence, const char *name,
-		       int name_len);
-int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
-		       u64 ref_id, u64 dirid, u64 *sequence, const char *name,
-		       int name_len);
-int btrfs_del_root(struct btrfs_trans_handle *trans,
-		   const struct btrfs_key *key);
-int btrfs_insert_root(struct btrfs_trans_handle *trans, struct btrfs_root *root,
-		      const struct btrfs_key *key,
-		      struct btrfs_root_item *item);
-int __must_check btrfs_update_root(struct btrfs_trans_handle *trans,
-				   struct btrfs_root *root,
-				   struct btrfs_key *key,
-				   struct btrfs_root_item *item);
-int btrfs_find_root(struct btrfs_root *root, const struct btrfs_key *search_key,
-		    struct btrfs_path *path, struct btrfs_root_item *root_item,
-		    struct btrfs_key *root_key);
-int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info);
-void btrfs_set_root_node(struct btrfs_root_item *item,
-			 struct extent_buffer *node);
-void btrfs_check_and_init_root_item(struct btrfs_root_item *item);
-void btrfs_update_root_times(struct btrfs_trans_handle *trans,
-			     struct btrfs_root *root);
-
 /* uuid-tree.c */
 int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 			u64 subid);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5c47f7a7e37e..57cf07d28c67 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -46,6 +46,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "extent-tree.h"
+#include "root-tree.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 8deb70c33702..b49a555ed83a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -39,6 +39,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "extent-tree.h"
+#include "root-tree.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index a652e5dc465b..869d062d6765 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -15,6 +15,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "extent-tree.h"
+#include "root-tree.h"
 
 static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 					struct btrfs_block_group *block_group,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2efcfc3d797f..108d23f88e7b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -58,6 +58,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "extent-tree.h"
+#include "root-tree.h"
 
 struct btrfs_iget_args {
 	u64 ino;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 517cb80a9ab3..3d7ee71299e9 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -53,6 +53,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "extent-tree.h"
+#include "root-tree.h"
 
 #ifdef CONFIG_64BIT
 /* If we have a 32-bit userspace and 64-bit kernel, then the UAPI
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index aaf33a574ed3..22dee034d79d 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -27,6 +27,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "extent-tree.h"
+#include "root-tree.h"
 
 /*
  * Helpers to access qgroup reservation
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 969f9037fabd..9f7e16b2532d 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -31,6 +31,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "extent-tree.h"
+#include "root-tree.h"
 
 /*
  * Relocation overview
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 74cfbbc30572..43b803a92a44 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -15,6 +15,7 @@
 #include "space-info.h"
 #include "fs.h"
 #include "accessors.h"
+#include "root-tree.h"
 
 /*
  * Read a root item from the tree. In case we detect a root item smaller then
diff --git a/fs/btrfs/root-tree.h b/fs/btrfs/root-tree.h
new file mode 100644
index 000000000000..738abc683347
--- /dev/null
+++ b/fs/btrfs/root-tree.h
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef BTRFS_ROOT_TREE_H
+#define BTRFS_ROOT_TREE_H
+
+int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
+				     struct btrfs_block_rsv *rsv,
+				     int nitems, bool use_global_rsv);
+void btrfs_subvolume_release_metadata(struct btrfs_root *root,
+				      struct btrfs_block_rsv *rsv);
+int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
+		       u64 ref_id, u64 dirid, u64 sequence, const char *name,
+		       int name_len);
+int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
+		       u64 ref_id, u64 dirid, u64 *sequence, const char *name,
+		       int name_len);
+int btrfs_del_root(struct btrfs_trans_handle *trans,
+		   const struct btrfs_key *key);
+int btrfs_insert_root(struct btrfs_trans_handle *trans, struct btrfs_root *root,
+		      const struct btrfs_key *key,
+		      struct btrfs_root_item *item);
+int __must_check btrfs_update_root(struct btrfs_trans_handle *trans,
+				   struct btrfs_root *root,
+				   struct btrfs_key *key,
+				   struct btrfs_root_item *item);
+int btrfs_find_root(struct btrfs_root *root, const struct btrfs_key *search_key,
+		    struct btrfs_path *path, struct btrfs_root_item *root_item,
+		    struct btrfs_key *root_key);
+int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info);
+void btrfs_set_root_node(struct btrfs_root_item *item,
+			 struct extent_buffer *node);
+void btrfs_check_and_init_root_item(struct btrfs_root_item *item);
+void btrfs_update_root_times(struct btrfs_trans_handle *trans,
+			     struct btrfs_root *root);
+
+#endif /* BTRFS_ROOT_TREE_H */
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index e5acb95c6a5c..37b953153c4e 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -26,6 +26,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "extent-tree.h"
+#include "root-tree.h"
 
 static struct kmem_cache *btrfs_trans_handle_cachep;
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 9b62a1fff517..6ed7cfa609ff 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -24,6 +24,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "extent-tree.h"
+#include "root-tree.h"
 
 #define MAX_CONFLICT_INODES 10
 
-- 
2.26.3

