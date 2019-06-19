Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBED4C028
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 19:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfFSRrb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 13:47:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35588 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSRra (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 13:47:30 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so40939qto.2
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 10:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=9U0XAqqhx7QAoCVNOS4kNt9ZQlyfPj58ied+Bo80rmA=;
        b=nHcEh3TwgIg3FAghRHHGG146nhMCN7p2EO9kfe27eMGV3AnYYeT3mMNBWx9+MxcHF8
         YuTpZJE7vJgswgAiQKoEHGBbAW+qksmtpTTRoREPjRC/TcrFi7rUlBPkB4GENIsIdkiU
         V3UxRpOJxlVHNpQBRjwDFWcfxucWnVdUKW1MLLqL5pylncu9slxC58GQIuq43FPJZrpW
         t+mFmX1CGm31psTm1JUbnWu986z0c4LYZrS56Xb71Mjm7VPJD1b1wxqb7BZ1ZF6xwpoo
         FZCfN2U1id11mIl60pyDsWhkww0StFrYYoky46QaZ/mbToUvdrwwMvZk17ckyhFMXMd4
         D67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=9U0XAqqhx7QAoCVNOS4kNt9ZQlyfPj58ied+Bo80rmA=;
        b=TkD/eH7d2f7kGNAz3U8J9bKamqTD8/n4iURN9fRl6lu9BXW7oF2R7kaEkZiEfFRD9p
         wR1msGdw1BnonuVpnYDMlVQQ9mAMpZcvWv6xM24CrlXetX1NgG+Li3qEx8enOvDJdSWT
         sHnHqoyKCFZR8CS7yV5Xt9ZgM1CanwuchNlztCWF0j2VydVlolEuia3Fm5sZ3Vq2jyr4
         V4uW+oAkJVzL9ym18hFXsiVoAmIARb9hZdj9afXI6FFWSA4gnKdz2ZjwWPsbFyvumpup
         oNyKaQAkWf6eD8L3JuL92nHb3VAoOxG2U5zm9Idg/b1ZgT5kY+dVUQlUkN6+FJsktGA8
         EMRQ==
X-Gm-Message-State: APjAAAVY7wttJg8YBJ0AfOIU40f800CQBdqVg1IDzSjNWLUZhNK9CAUl
        klrZ0LJhZ7qHPzb8riF7ALUBmmtCc5y0nw==
X-Google-Smtp-Source: APXvYqxDGrCp68r4czcKHnH0O2XMHCCpCAhtR2q5hx+O43Vj3HacMD6Xe5hkfdTrKzUOaugQxq4M9w==
X-Received: by 2002:a0c:8aaa:: with SMTP id 39mr35023857qvv.17.1560966449161;
        Wed, 19 Jun 2019 10:47:29 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t8sm14313733qtc.80.2019.06.19.10.47.28
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 10:47:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/8] btrfs: move btrfs_block_rsv definitions into it's own header
Date:   Wed, 19 Jun 2019 13:47:17 -0400
Message-Id: <20190619174724.1675-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190619174724.1675-1-josef@toxicpanda.com>
References: <20190619174724.1675-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Prep work for separating out all of the block_rsv related code into its
own file.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.h   | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/ctree.h       | 70 +------------------------------------------
 fs/btrfs/extent-tree.c |  1 +
 3 files changed, 83 insertions(+), 69 deletions(-)
 create mode 100644 fs/btrfs/block-rsv.h

diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
new file mode 100644
index 000000000000..13f5ab02a635
--- /dev/null
+++ b/fs/btrfs/block-rsv.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Facebook.  All rights reserved.
+ */
+
+#ifndef BTRFS_BLOCK_RSV_H
+#define BTRFS_BLOCK_RSV_H
+
+
+enum btrfs_reserve_flush_enum;
+
+/*
+ * Types of block reserves
+ */
+enum {
+	BTRFS_BLOCK_RSV_GLOBAL,
+	BTRFS_BLOCK_RSV_DELALLOC,
+	BTRFS_BLOCK_RSV_TRANS,
+	BTRFS_BLOCK_RSV_CHUNK,
+	BTRFS_BLOCK_RSV_DELOPS,
+	BTRFS_BLOCK_RSV_DELREFS,
+	BTRFS_BLOCK_RSV_EMPTY,
+	BTRFS_BLOCK_RSV_TEMP,
+};
+
+struct btrfs_block_rsv {
+	u64 size;
+	u64 reserved;
+	struct btrfs_space_info *space_info;
+	spinlock_t lock;
+	unsigned short full;
+	unsigned short type;
+	unsigned short failfast;
+
+	/*
+	 * Qgroup equivalent for @size @reserved
+	 *
+	 * Unlike normal @size/@reserved for inode rsv, qgroup doesn't care
+	 * about things like csum size nor how many tree blocks it will need to
+	 * reserve.
+	 *
+	 * Qgroup cares more about net change of the extent usage.
+	 *
+	 * So for one newly inserted file extent, in worst case it will cause
+	 * leaf split and level increase, nodesize for each file extent is
+	 * already too much.
+	 *
+	 * In short, qgroup_size/reserved is the upper limit of possible needed
+	 * qgroup metadata reservation.
+	 */
+	u64 qgroup_rsv_size;
+	u64 qgroup_rsv_reserved;
+};
+
+void btrfs_init_block_rsv(struct btrfs_block_rsv *rsv, unsigned short type);
+struct btrfs_block_rsv *btrfs_alloc_block_rsv(struct btrfs_fs_info *fs_info,
+					      unsigned short type);
+void btrfs_init_metadata_block_rsv(struct btrfs_fs_info *fs_info,
+				   struct btrfs_block_rsv *rsv,
+				   unsigned short type);
+void btrfs_free_block_rsv(struct btrfs_fs_info *fs_info,
+			  struct btrfs_block_rsv *rsv);
+int btrfs_block_rsv_add(struct btrfs_root *root,
+			struct btrfs_block_rsv *block_rsv, u64 num_bytes,
+			enum btrfs_reserve_flush_enum flush);
+int btrfs_block_rsv_check(struct btrfs_block_rsv *block_rsv, int min_factor);
+int btrfs_block_rsv_refill(struct btrfs_root *root,
+			   struct btrfs_block_rsv *block_rsv, u64 min_reserved,
+			   enum btrfs_reserve_flush_enum flush);
+int btrfs_block_rsv_migrate(struct btrfs_block_rsv *src_rsv,
+			    struct btrfs_block_rsv *dst_rsv, u64 num_bytes,
+			    bool update_size);
+int btrfs_block_rsv_use_bytes(struct btrfs_block_rsv *block_rsv,
+			      u64 num_bytes);
+int btrfs_cond_migrate_bytes(struct btrfs_fs_info *fs_info,
+			     struct btrfs_block_rsv *dest, u64 num_bytes,
+			     int min_factor);
+void btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
+			     struct btrfs_block_rsv *block_rsv,
+			     u64 num_bytes);
+#endif /* BTRFS_BLOCK_RSV_H */
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2aeb323cc86e..9b8b8d07e66f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -32,6 +32,7 @@
 #include "extent_io.h"
 #include "extent_map.h"
 #include "async-thread.h"
+#include "block-rsv.h"
 
 struct btrfs_trans_handle;
 struct btrfs_transaction;
@@ -394,49 +395,6 @@ struct raid_kobject {
 	struct list_head list;
 };
 
-/*
- * Types of block reserves
- */
-enum {
-	BTRFS_BLOCK_RSV_GLOBAL,
-	BTRFS_BLOCK_RSV_DELALLOC,
-	BTRFS_BLOCK_RSV_TRANS,
-	BTRFS_BLOCK_RSV_CHUNK,
-	BTRFS_BLOCK_RSV_DELOPS,
-	BTRFS_BLOCK_RSV_DELREFS,
-	BTRFS_BLOCK_RSV_EMPTY,
-	BTRFS_BLOCK_RSV_TEMP,
-};
-
-struct btrfs_block_rsv {
-	u64 size;
-	u64 reserved;
-	struct btrfs_space_info *space_info;
-	spinlock_t lock;
-	unsigned short full;
-	unsigned short type;
-	unsigned short failfast;
-
-	/*
-	 * Qgroup equivalent for @size @reserved
-	 *
-	 * Unlike normal @size/@reserved for inode rsv, qgroup doesn't care
-	 * about things like csum size nor how many tree blocks it will need to
-	 * reserve.
-	 *
-	 * Qgroup cares more about net change of the extent usage.
-	 *
-	 * So for one newly inserted file extent, in worst case it will cause
-	 * leaf split and level increase, nodesize for each file extent is
-	 * already too much.
-	 *
-	 * In short, qgroup_size/reserved is the upper limit of possible needed
-	 * qgroup metadata reservation.
-	 */
-	u64 qgroup_rsv_size;
-	u64 qgroup_rsv_reserved;
-};
-
 /*
  * free clusters are used to claim free space in relatively large chunks,
  * allowing us to do less seeky writes. They are used for all metadata
@@ -2810,32 +2768,6 @@ void btrfs_delalloc_release_metadata(struct btrfs_inode *inode, u64 num_bytes,
 				     bool qgroup_free);
 int btrfs_delalloc_reserve_space(struct inode *inode,
 			struct extent_changeset **reserved, u64 start, u64 len);
-void btrfs_init_block_rsv(struct btrfs_block_rsv *rsv, unsigned short type);
-struct btrfs_block_rsv *btrfs_alloc_block_rsv(struct btrfs_fs_info *fs_info,
-					      unsigned short type);
-void btrfs_init_metadata_block_rsv(struct btrfs_fs_info *fs_info,
-				   struct btrfs_block_rsv *rsv,
-				   unsigned short type);
-void btrfs_free_block_rsv(struct btrfs_fs_info *fs_info,
-			  struct btrfs_block_rsv *rsv);
-int btrfs_block_rsv_add(struct btrfs_root *root,
-			struct btrfs_block_rsv *block_rsv, u64 num_bytes,
-			enum btrfs_reserve_flush_enum flush);
-int btrfs_block_rsv_check(struct btrfs_block_rsv *block_rsv, int min_factor);
-int btrfs_block_rsv_refill(struct btrfs_root *root,
-			   struct btrfs_block_rsv *block_rsv, u64 min_reserved,
-			   enum btrfs_reserve_flush_enum flush);
-int btrfs_block_rsv_migrate(struct btrfs_block_rsv *src_rsv,
-			    struct btrfs_block_rsv *dst_rsv, u64 num_bytes,
-			    bool update_size);
-int btrfs_block_rsv_use_bytes(struct btrfs_block_rsv *block_rsv,
-			      u64 num_bytes);
-int btrfs_cond_migrate_bytes(struct btrfs_fs_info *fs_info,
-			     struct btrfs_block_rsv *dest, u64 num_bytes,
-			     int min_factor);
-void btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
-			     struct btrfs_block_rsv *block_rsv,
-			     u64 num_bytes);
 void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr);
 void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans);
 int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3fc140dfcc58..2e128ecc95f7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -29,6 +29,7 @@
 #include "qgroup.h"
 #include "ref-verify.h"
 #include "space-info.h"
+#include "block-rsv.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
-- 
2.14.3

