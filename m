Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADA560BA7E
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Oct 2022 22:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbiJXUhx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 16:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbiJXUhQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 16:37:16 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FF21D63BC
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 11:48:37 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g16so6167932qtu.2
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 11:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PDtHGn4ghaOLU/lvqQ5AfBChGCTPAopc6LUskV14b8M=;
        b=0NbPFg5gGJvkCmTgeiHnFNPpacaDNsh0YU4CaMZc9DVFtRUwFufcztgrSw5gM6yhe3
         n0whHTZBR96CXY4Xm2qF5YXebFyhh1Z1uy47JHiqgGuMFeoqf2yqfLTBFWBd8zEQRwBb
         KrM2M0EolFc3hn4Xv/2EFqWy5+1pWpxu5m7Tnwonwnrhl50l7R1bFx8ZqtMzykq6pcwN
         DR3psFjk9lEy9gC5PetNWMLtfIQz/MWqnsq24LrpbieOATXNBk+hvKOS0UiX6+H3RP/h
         GID4/mkuaVbhxD9lw8CSEI2sGb62HACYjoer3cCSlRDWrBPHbRCHji9XgW4DcR3A0voM
         JbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDtHGn4ghaOLU/lvqQ5AfBChGCTPAopc6LUskV14b8M=;
        b=lOMvqanvFD3FwxSrVGZiI1xzgMiQ12nwA/Bs2HHsdpbuLgaBLz/tcLdVkHuuIQHVqz
         eokF1O+BfM9uT5ZmroBOwQaIqvpciVb1zT14xkZfl7lQTPJZmqYFZ4CmbIT7Xe3HuJk2
         SufKK5l/vwx8EbAZnLnM/cxmDfYVgeZbJmteTgI6hyZuG+jcSn6hngUGcz3yKxSEXO9V
         6yN2bzRX/ykgWjPCi4Sor9wwfN9eo7Vt0ywKc8aaZ5IliK+5DIiw7a38XdDTtV3jmn+M
         4PxN5j1yzrAfdLthjRuRhHvkWXDLNOvDUpEaW88GGWuP1d6sDAhUQh623UcFIppj6PbJ
         vDTA==
X-Gm-Message-State: ACrzQf2b+OMs4yfuxUp4yceuVxNzbpmejq1j32ycnVOdzXGHCOvNITTr
        KCBCGUudIFKsywJ6TZ6RncLvnj7n5Izpwg==
X-Google-Smtp-Source: AMsMyM4YzlnbKI+swPxzrYF4Lwbht9wv+rIvoFpQBdJucFjd6hRbVYdDyF82sdXGdR9AYGdiI2bxjQ==
X-Received: by 2002:ac8:5b50:0:b0:39c:bf7d:7d5a with SMTP id n16-20020ac85b50000000b0039cbf7d7d5amr28371186qtw.203.1666637232021;
        Mon, 24 Oct 2022 11:47:12 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id w5-20020a05620a444500b006e2d087fd63sm454003qkp.63.2022.10.24.11.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:47:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/9] btrfs: move extent-tree helpers into their own header file
Date:   Mon, 24 Oct 2022 14:46:57 -0400
Message-Id: <5cca8a850fe53d81399762f201ba14d061d4d00b.1666637013.git.josef@toxicpanda.com>
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

Move all the extent tree related prototypes to extent-tree.h out of
ctree.h, and then go include it everywhere needed so everything
compiles.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c         |  1 +
 fs/btrfs/block-group.c     |  1 +
 fs/btrfs/ctree.c           |  1 +
 fs/btrfs/ctree.h           | 72 ------------------------------------
 fs/btrfs/disk-io.c         |  1 +
 fs/btrfs/extent-tree.c     |  1 +
 fs/btrfs/extent-tree.h     | 76 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/file.c            |  1 +
 fs/btrfs/free-space-tree.c |  1 +
 fs/btrfs/inode-item.c      |  1 +
 fs/btrfs/inode.c           |  1 +
 fs/btrfs/ioctl.c           |  1 +
 fs/btrfs/qgroup.c          |  1 +
 fs/btrfs/relocation.c      |  1 +
 fs/btrfs/space-info.c      |  1 +
 fs/btrfs/transaction.c     |  1 +
 fs/btrfs/tree-log.c        |  1 +
 17 files changed, 91 insertions(+), 72 deletions(-)
 create mode 100644 fs/btrfs/extent-tree.h

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 629e1ff25767..fe02b1bfd1fe 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -17,6 +17,7 @@
 #include "tree-mod-log.h"
 #include "fs.h"
 #include "accessors.h"
+#include "extent-tree.h"
 
 /* Just an arbitrary number so we can be sure this happened */
 #define BACKREF_FOUND_SHARED 6
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5d58c6a454c7..e415aa777510 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -19,6 +19,7 @@
 #include "zoned.h"
 #include "fs.h"
 #include "accessors.h"
+#include "extent-tree.h"
 
 #ifdef CONFIG_BTRFS_DEBUG
 int btrfs_should_fragment_free_space(struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 01c5b021ee1f..83e45f52a909 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -20,6 +20,7 @@
 #include "tree-checker.h"
 #include "fs.h"
 #include "accessors.h"
+#include "extent-tree.h"
 
 static struct kmem_cache *btrfs_path_cachep;
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 514b0eba290c..a2cc9dda9ca2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -486,78 +486,6 @@ static inline gfp_t btrfs_alloc_write_mask(struct address_space *mapping)
 	return mapping_gfp_constraint(mapping, ~__GFP_FS);
 }
 
-/* extent-tree.c */
-
-enum btrfs_inline_ref_type {
-	BTRFS_REF_TYPE_INVALID,
-	BTRFS_REF_TYPE_BLOCK,
-	BTRFS_REF_TYPE_DATA,
-	BTRFS_REF_TYPE_ANY,
-};
-
-int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
-				     struct btrfs_extent_inline_ref *iref,
-				     enum btrfs_inline_ref_type is_data);
-u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset);
-
-
-int btrfs_add_excluded_extent(struct btrfs_fs_info *fs_info,
-			      u64 start, u64 num_bytes);
-void btrfs_free_excluded_extents(struct btrfs_block_group *cache);
-int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
-			   unsigned long count);
-void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
-				  struct btrfs_delayed_ref_root *delayed_refs,
-				  struct btrfs_delayed_ref_head *head);
-int btrfs_lookup_data_extent(struct btrfs_fs_info *fs_info, u64 start, u64 len);
-int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
-			     struct btrfs_fs_info *fs_info, u64 bytenr,
-			     u64 offset, int metadata, u64 *refs, u64 *flags);
-int btrfs_pin_extent(struct btrfs_trans_handle *trans, u64 bytenr, u64 num,
-		     int reserved);
-int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
-				    u64 bytenr, u64 num_bytes);
-int btrfs_exclude_logged_extents(struct extent_buffer *eb);
-int btrfs_cross_ref_exist(struct btrfs_root *root,
-			  u64 objectid, u64 offset, u64 bytenr, bool strict,
-			  struct btrfs_path *path);
-struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
-					     struct btrfs_root *root,
-					     u64 parent, u64 root_objectid,
-					     const struct btrfs_disk_key *key,
-					     int level, u64 hint,
-					     u64 empty_size,
-					     enum btrfs_lock_nesting nest);
-void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
-			   u64 root_id,
-			   struct extent_buffer *buf,
-			   u64 parent, int last_ref);
-int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
-				     struct btrfs_root *root, u64 owner,
-				     u64 offset, u64 ram_bytes,
-				     struct btrfs_key *ins);
-int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
-				   u64 root_objectid, u64 owner, u64 offset,
-				   struct btrfs_key *ins);
-int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes, u64 num_bytes,
-			 u64 min_alloc_size, u64 empty_size, u64 hint_byte,
-			 struct btrfs_key *ins, int is_data, int delalloc);
-int btrfs_inc_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
-		  struct extent_buffer *buf, int full_backref);
-int btrfs_dec_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
-		  struct extent_buffer *buf, int full_backref);
-int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
-				struct extent_buffer *eb, u64 flags, int level);
-int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref);
-
-int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
-			       u64 start, u64 len, int delalloc);
-int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans, u64 start,
-			      u64 len);
-int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans);
-int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
-			 struct btrfs_ref *generic_ref);
-
 int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 				     struct btrfs_block_rsv *rsv,
 				     int nitems, bool use_global_rsv);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index aa02157e1a34..5c47f7a7e37e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -45,6 +45,7 @@
 #include "subpage.h"
 #include "fs.h"
 #include "accessors.h"
+#include "extent-tree.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index db3d417ae9b0..8deb70c33702 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -38,6 +38,7 @@
 #include "dev-replace.h"
 #include "fs.h"
 #include "accessors.h"
+#include "extent-tree.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
new file mode 100644
index 000000000000..2a3c25e3fd52
--- /dev/null
+++ b/fs/btrfs/extent-tree.h
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef BTRFS_EXTENT_TREE_H
+#define BTRFS_EXTENT_TREE_H
+
+enum btrfs_inline_ref_type {
+	BTRFS_REF_TYPE_INVALID,
+	BTRFS_REF_TYPE_BLOCK,
+	BTRFS_REF_TYPE_DATA,
+	BTRFS_REF_TYPE_ANY,
+};
+
+int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
+				     struct btrfs_extent_inline_ref *iref,
+				     enum btrfs_inline_ref_type is_data);
+u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset);
+
+
+int btrfs_add_excluded_extent(struct btrfs_fs_info *fs_info,
+			      u64 start, u64 num_bytes);
+void btrfs_free_excluded_extents(struct btrfs_block_group *cache);
+int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
+			   unsigned long count);
+void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
+				  struct btrfs_delayed_ref_root *delayed_refs,
+				  struct btrfs_delayed_ref_head *head);
+int btrfs_lookup_data_extent(struct btrfs_fs_info *fs_info, u64 start, u64 len);
+int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
+			     struct btrfs_fs_info *fs_info, u64 bytenr,
+			     u64 offset, int metadata, u64 *refs, u64 *flags);
+int btrfs_pin_extent(struct btrfs_trans_handle *trans, u64 bytenr, u64 num,
+		     int reserved);
+int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
+				    u64 bytenr, u64 num_bytes);
+int btrfs_exclude_logged_extents(struct extent_buffer *eb);
+int btrfs_cross_ref_exist(struct btrfs_root *root,
+			  u64 objectid, u64 offset, u64 bytenr, bool strict,
+			  struct btrfs_path *path);
+struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
+					     struct btrfs_root *root,
+					     u64 parent, u64 root_objectid,
+					     const struct btrfs_disk_key *key,
+					     int level, u64 hint,
+					     u64 empty_size,
+					     enum btrfs_lock_nesting nest);
+void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
+			   u64 root_id,
+			   struct extent_buffer *buf,
+			   u64 parent, int last_ref);
+int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
+				     struct btrfs_root *root, u64 owner,
+				     u64 offset, u64 ram_bytes,
+				     struct btrfs_key *ins);
+int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
+				   u64 root_objectid, u64 owner, u64 offset,
+				   struct btrfs_key *ins);
+int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes, u64 num_bytes,
+			 u64 min_alloc_size, u64 empty_size, u64 hint_byte,
+			 struct btrfs_key *ins, int is_data, int delalloc);
+int btrfs_inc_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
+		  struct extent_buffer *buf, int full_backref);
+int btrfs_dec_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
+		  struct extent_buffer *buf, int full_backref);
+int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
+				struct extent_buffer *eb, u64 flags, int level);
+int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref);
+
+int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
+			       u64 start, u64 len, int delalloc);
+int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans, u64 start,
+			      u64 len);
+int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans);
+int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
+			 struct btrfs_ref *generic_ref);
+
+#endif /* BTRFS_EXTENT_TREE_H */
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 1e4a53ad7999..e81bfc738a79 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -32,6 +32,7 @@
 #include "subpage.h"
 #include "fs.h"
 #include "accessors.h"
+#include "extent-tree.h"
 
 static struct kmem_cache *btrfs_inode_defrag_cachep;
 /*
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index fc79d21e7b4f..a652e5dc465b 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -14,6 +14,7 @@
 #include "block-group.h"
 #include "fs.h"
 #include "accessors.h"
+#include "extent-tree.h"
 
 static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 					struct btrfs_block_group *block_group,
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index b8dbabfa8b31..0b60ef5f4bca 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -12,6 +12,7 @@
 #include "print-tree.h"
 #include "space-info.h"
 #include "accessors.h"
+#include "extent-tree.h"
 
 struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
 						   int slot, const char *name,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 831bcd03c3e0..2efcfc3d797f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -57,6 +57,7 @@
 #include "inode-item.h"
 #include "fs.h"
 #include "accessors.h"
+#include "extent-tree.h"
 
 struct btrfs_iget_args {
 	u64 ino;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 983f06e138ac..517cb80a9ab3 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -52,6 +52,7 @@
 #include "subpage.h"
 #include "fs.h"
 #include "accessors.h"
+#include "extent-tree.h"
 
 #ifdef CONFIG_64BIT
 /* If we have a 32-bit userspace and 64-bit kernel, then the UAPI
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 1e42404afc8d..aaf33a574ed3 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -26,6 +26,7 @@
 #include "tree-mod-log.h"
 #include "fs.h"
 #include "accessors.h"
+#include "extent-tree.h"
 
 /*
  * Helpers to access qgroup reservation
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c4063978e5bb..969f9037fabd 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -30,6 +30,7 @@
 #include "space-info.h"
 #include "fs.h"
 #include "accessors.h"
+#include "extent-tree.h"
 
 /*
  * Relocation overview
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index e4a59d611f07..6e3dcdc88c59 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -12,6 +12,7 @@
 #include "zoned.h"
 #include "fs.h"
 #include "accessors.h"
+#include "extent-tree.h"
 
 /*
  * HOW DOES SPACE RESERVATION WORK
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 25e6b504edb4..e5acb95c6a5c 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -25,6 +25,7 @@
 #include "zoned.h"
 #include "fs.h"
 #include "accessors.h"
+#include "extent-tree.h"
 
 static struct kmem_cache *btrfs_trans_handle_cachep;
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 823fbd826944..9b62a1fff517 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -23,6 +23,7 @@
 #include "inode-item.h"
 #include "fs.h"
 #include "accessors.h"
+#include "extent-tree.h"
 
 #define MAX_CONFLICT_INODES 10
 
-- 
2.26.3

