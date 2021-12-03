Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40814467FC7
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 23:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383377AbhLCWVu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 17:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240628AbhLCWVs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 17:21:48 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEB5C061751
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 14:18:23 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id u16so4153675qvk.4
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 14:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lbxHzMijQw7mL7Q1EwgegdzG4cyTaynJVs5wNTOjL+A=;
        b=7rMbJh5D587QLe8Fmp0nQRz6gLBY83G4NC9bN9B1n+b5ekeg85NYR0SmvTi2CXojvO
         XN7ZW4H8oPS+jMGKF3DvobhQYQrt6x9cqGwRiK7NrqN4jAq5jkyXFx9Um/hQ0P+tTCuE
         aOax8AFthT9WPniOCJDKQKvjHs2xUrgdVNei0Y6g8r1oTLjGruEyRYYKgmA8Mwtlvk7f
         DM6QVmoK3jLQnrEHxHSrOFQz3M+Qn5hy52giJtoC53Lg+O+iNp8/+j5YDcOAEdf5xxh5
         /4hw5Uv80Wqmm91pCXlmZVENvDpCSaDDK+66ZntXFn35hgh1zXl/2m6Ttf0TiasfjLNg
         X+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lbxHzMijQw7mL7Q1EwgegdzG4cyTaynJVs5wNTOjL+A=;
        b=yqiTF+syaZMuQr241jigiYtvoPn85aNESyPTKMdyIlsTPvpYYboCveagqK7lqen2UJ
         H6YtNXMmA++ZWHaXDeqngoqV9gBmj9+lu+Iv6KeD4YmyX6J7tV0R3NirIHQcXDwFb6wQ
         4oY4iZrBb7YGJqW6ORogP9qZnCx7zjsTNwYCIsKY/7lDqSKiaZTg75s6aFPId4hhCrHd
         ap96OwpAH4OTr3uTGTAPgK+NXvijHDZYR87GhudRjlG03NCHKmA2FfKl77vVR62jWp/9
         avKL16hlvDlPmToSHi9DgcOjZeicdKSTFpY4qMZcB4i4Pk2lJmE0qFK5bQD22RJrIwtg
         m36w==
X-Gm-Message-State: AOAM5301LfoPOYqIPgRG5YZwkX4NCyA0d8t/xFRbjkANzIPGd+Iu1R5Z
        uqaZscW5U0P54Q4qAsvHp3YnciRPUfatlA==
X-Google-Smtp-Source: ABdhPJy27teKZsTL/jzK7k4bPJD8jQkwNOLZ/i7+rOv6cRCT+OA9m55+UqOQ+S+SZJRcVgnvGih3Yw==
X-Received: by 2002:a0c:d841:: with SMTP id i1mr21666195qvj.126.1638569902531;
        Fri, 03 Dec 2021 14:18:22 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f18sm3046281qko.34.2021.12.03.14.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:18:22 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/18] btrfs: add an inode-item.h
Date:   Fri,  3 Dec 2021 17:18:03 -0500
Message-Id: <da8f34d466181ae99ccc229088f6173ce42914ae.1638569556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638569556.git.josef@toxicpanda.com>
References: <cover.1638569556.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a few helpers in inode-item.c, and I'm going to make a few
changes to how we do truncate in the future, so break out these
definitions into their own header file to trim down ctree.h some and
make it easier to do the work on truncate in the future.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h            | 30 ------------------------------
 fs/btrfs/delayed-inode.c    |  1 +
 fs/btrfs/free-space-cache.c |  1 +
 fs/btrfs/inode-item.c       |  1 +
 fs/btrfs/inode-item.h       | 37 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/inode.c            |  1 +
 fs/btrfs/relocation.c       |  1 +
 fs/btrfs/tree-log.c         |  1 +
 8 files changed, 43 insertions(+), 30 deletions(-)
 create mode 100644 fs/btrfs/inode-item.h

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index dfee4b403da1..f33cae82e7dd 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3126,36 +3126,6 @@ int btrfs_del_orphan_item(struct btrfs_trans_handle *trans,
 			  struct btrfs_root *root, u64 offset);
 int btrfs_find_orphan_item(struct btrfs_root *root, u64 offset);
 
-/* inode-item.c */
-int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
-			   struct btrfs_root *root,
-			   const char *name, int name_len,
-			   u64 inode_objectid, u64 ref_objectid, u64 index);
-int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
-			   struct btrfs_root *root,
-			   const char *name, int name_len,
-			   u64 inode_objectid, u64 ref_objectid, u64 *index);
-int btrfs_insert_empty_inode(struct btrfs_trans_handle *trans,
-			     struct btrfs_root *root,
-			     struct btrfs_path *path, u64 objectid);
-int btrfs_lookup_inode(struct btrfs_trans_handle *trans, struct btrfs_root
-		       *root, struct btrfs_path *path,
-		       struct btrfs_key *location, int mod);
-
-struct btrfs_inode_extref *
-btrfs_lookup_inode_extref(struct btrfs_trans_handle *trans,
-			  struct btrfs_root *root,
-			  struct btrfs_path *path,
-			  const char *name, int name_len,
-			  u64 inode_objectid, u64 ref_objectid, int ins_len,
-			  int cow);
-
-struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
-						   int slot, const char *name,
-						   int name_len);
-struct btrfs_inode_extref *btrfs_find_name_in_ext_backref(
-		struct extent_buffer *leaf, int slot, u64 ref_objectid,
-		const char *name, int name_len);
 /* file-item.c */
 struct btrfs_dio_private;
 int btrfs_del_csums(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 6f134f2c5e68..748bf6b0d860 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -13,6 +13,7 @@
 #include "ctree.h"
 #include "qgroup.h"
 #include "locking.h"
+#include "inode-item.h"
 
 #define BTRFS_DELAYED_WRITEBACK		512
 #define BTRFS_DELAYED_BACKGROUND	128
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 132209ff2262..55e1be703a39 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -23,6 +23,7 @@
 #include "block-group.h"
 #include "discard.h"
 #include "subpage.h"
+#include "inode-item.h"
 
 #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
 #define MAX_CACHE_BYTES_PER_GIG	SZ_64K
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 56755ce9a907..72593a93c43c 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -4,6 +4,7 @@
  */
 
 #include "ctree.h"
+#include "inode-item.h"
 #include "disk-io.h"
 #include "transaction.h"
 #include "print-tree.h"
diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
new file mode 100644
index 000000000000..cb4b140e3b7d
--- /dev/null
+++ b/fs/btrfs/inode-item.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_INODE_ITEM_H
+#define BTRFS_INODE_ITEM_H
+
+
+int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
+			   struct btrfs_root *root,
+			   const char *name, int name_len,
+			   u64 inode_objectid, u64 ref_objectid, u64 index);
+int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
+			   struct btrfs_root *root,
+			   const char *name, int name_len,
+			   u64 inode_objectid, u64 ref_objectid, u64 *index);
+int btrfs_insert_empty_inode(struct btrfs_trans_handle *trans,
+			     struct btrfs_root *root,
+			     struct btrfs_path *path, u64 objectid);
+int btrfs_lookup_inode(struct btrfs_trans_handle *trans, struct btrfs_root
+		       *root, struct btrfs_path *path,
+		       struct btrfs_key *location, int mod);
+
+struct btrfs_inode_extref *
+btrfs_lookup_inode_extref(struct btrfs_trans_handle *trans,
+			  struct btrfs_root *root,
+			  struct btrfs_path *path,
+			  const char *name, int name_len,
+			  u64 inode_objectid, u64 ref_objectid, int ins_len,
+			  int cow);
+
+struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
+						   int slot, const char *name,
+						   int name_len);
+struct btrfs_inode_extref *btrfs_find_name_in_ext_backref(
+		struct extent_buffer *leaf, int slot, u64 ref_objectid,
+		const char *name, int name_len);
+
+#endif /* BTRFS_INODE_ITEM_H */
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 504cf090fc88..6ccdcf76b02f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -54,6 +54,7 @@
 #include "space-info.h"
 #include "zoned.h"
 #include "subpage.h"
+#include "inode-item.h"
 
 struct btrfs_iget_args {
 	u64 ino;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 775aff5a2c26..f5465197996d 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -26,6 +26,7 @@
 #include "misc.h"
 #include "subpage.h"
 #include "zoned.h"
+#include "inode-item.h"
 
 /*
  * Relocation overview
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index de79e15a7c6a..c7a7f78708d5 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -20,6 +20,7 @@
 #include "block-group.h"
 #include "space-info.h"
 #include "zoned.h"
+#include "inode-item.h"
 
 /* magic values for the inode_only field in btrfs_log_inode:
  *
-- 
2.26.3

