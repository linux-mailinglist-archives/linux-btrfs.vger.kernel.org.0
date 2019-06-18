Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4044AB6E
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 22:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbfFRUJe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 16:09:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38861 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfFRUJd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 16:09:33 -0400
Received: by mail-qt1-f196.google.com with SMTP id n11so17006389qtl.5
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 13:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Y6fw9xxp28/KvjWZ10xCD9CGARnM3o/rFIWNnR4bM40=;
        b=XJQeyAnjDxE9cUoiIfRQdDV7PRv0pHVatQHeY0XCHr7Oe5ufR8h8T/qHnNbWhB0ubO
         R1mXYdPkG8/SFK1jL6lnqJI4H2EorZBA7S5CjBfLFjpKyPgN0F2rXTe84YtFaL6S8wYz
         FamtNBYLtOcwIyRw5wTZyDN+GGZPKN+bMx9andboHuOg8wnvzRe8/sF6WiC+v1PmvYVM
         Bzcroy3ElSuUt67VgafiIZIdyDmAW6yZChjNccJ2tpA+Z+ZKPpoX90AAQIPY/lotvaJu
         UKGeqDhGkV/5xaleecCSg/m121frP5RGHu/ir4FcyinfixwqLyv05G6grI4TraF1rcmb
         kd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Y6fw9xxp28/KvjWZ10xCD9CGARnM3o/rFIWNnR4bM40=;
        b=I9XcmCZaxnY3LmAq8tZcHEOdUns/RdnkHy1ltq7ZxocsESmRHLLV/4GuI2csKy4JmA
         VmQbIzjYWg3wLnyeM6/dlfycnA6nwbf30XZ5HDbcasR1DEVbFeYM3mquoqB1RtrL2K1F
         a2dPqHchlwb3KKMi8yhvp0FAl5qauKrTS67rcMR2NJm9lBqXw/j7vHc8iL4sFleOTU2X
         AotqcZTOTF1NQRZzf/WR1pqM+9JfpXuttyQO/x74uu4589Mn+isF0bbwe+KNNuaVbnRh
         EBAvO8NJILEPcSTlSen/hqOSgAhak5d3RoqVYOpCpXeylX/ZkWNoAa0gHoMDuQEe8ETy
         jbxA==
X-Gm-Message-State: APjAAAW0Epq+T8iRhF1kL7GaKt3jONOM2h4dJln9Ge5M1X2yy+jfK16V
        sTV01vFSdUEGgxNQCBzcStP42F3IVrhz2Q==
X-Google-Smtp-Source: APXvYqxNpbShJJT9HHfYMD34w+A2Gv+9R6Go5gDnsfyynk829z23Y7dPKIgTYpckA6Y6v1nToWyDxg==
X-Received: by 2002:ac8:17a5:: with SMTP id o34mr103491506qtj.232.1560888571874;
        Tue, 18 Jun 2019 13:09:31 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k5sm8639048qkc.75.2019.06.18.13.09.31
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 13:09:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/11] btrfs: move space_info to space_info.h
Date:   Tue, 18 Jun 2019 16:09:16 -0400
Message-Id: <20190618200926.3352-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190618200926.3352-1-josef@toxicpanda.com>
References: <20190618200926.3352-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Migrate the struct definition and the one helper that's in ctree.h into
space_info.h

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h            | 73 +---------------------------------------
 fs/btrfs/extent-tree.c      |  1 +
 fs/btrfs/free-space-cache.c |  1 +
 fs/btrfs/ioctl.c            |  1 +
 fs/btrfs/space-info.h       | 81 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/super.c            |  1 +
 fs/btrfs/sysfs.c            |  1 +
 fs/btrfs/volumes.c          |  1 +
 8 files changed, 88 insertions(+), 72 deletions(-)
 create mode 100644 fs/btrfs/space-info.h

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 47ab5b1ff7d8..0936db74d3e3 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -37,6 +37,7 @@ struct btrfs_trans_handle;
 struct btrfs_transaction;
 struct btrfs_pending_snapshot;
 struct btrfs_delayed_ref_root;
+struct btrfs_space_info;
 extern struct kmem_cache *btrfs_trans_handle_cachep;
 extern struct kmem_cache *btrfs_bit_radix_cachep;
 extern struct kmem_cache *btrfs_path_cachep;
@@ -393,72 +394,6 @@ struct raid_kobject {
 	struct list_head list;
 };
 
-struct btrfs_space_info {
-	spinlock_t lock;
-
-	u64 total_bytes;	/* total bytes in the space,
-				   this doesn't take mirrors into account */
-	u64 bytes_used;		/* total bytes used,
-				   this doesn't take mirrors into account */
-	u64 bytes_pinned;	/* total bytes pinned, will be freed when the
-				   transaction finishes */
-	u64 bytes_reserved;	/* total bytes the allocator has reserved for
-				   current allocations */
-	u64 bytes_may_use;	/* number of bytes that may be used for
-				   delalloc/allocations */
-	u64 bytes_readonly;	/* total bytes that are read only */
-
-	u64 max_extent_size;	/* This will hold the maximum extent size of
-				   the space info if we had an ENOSPC in the
-				   allocator. */
-
-	unsigned int full:1;	/* indicates that we cannot allocate any more
-				   chunks for this space */
-	unsigned int chunk_alloc:1;	/* set if we are allocating a chunk */
-
-	unsigned int flush:1;		/* set if we are trying to make space */
-
-	unsigned int force_alloc;	/* set if we need to force a chunk
-					   alloc for this space */
-
-	u64 disk_used;		/* total bytes used on disk */
-	u64 disk_total;		/* total bytes on disk, takes mirrors into
-				   account */
-
-	u64 flags;
-
-	/*
-	 * bytes_pinned is kept in line with what is actually pinned, as in
-	 * we've called update_block_group and dropped the bytes_used counter
-	 * and increased the bytes_pinned counter.  However this means that
-	 * bytes_pinned does not reflect the bytes that will be pinned once the
-	 * delayed refs are flushed, so this counter is inc'ed every time we
-	 * call btrfs_free_extent so it is a realtime count of what will be
-	 * freed once the transaction is committed.  It will be zeroed every
-	 * time the transaction commits.
-	 */
-	struct percpu_counter total_bytes_pinned;
-
-	struct list_head list;
-	/* Protected by the spinlock 'lock'. */
-	struct list_head ro_bgs;
-	struct list_head priority_tickets;
-	struct list_head tickets;
-	/*
-	 * tickets_id just indicates the next ticket will be handled, so note
-	 * it's not stored per ticket.
-	 */
-	u64 tickets_id;
-
-	struct rw_semaphore groups_sem;
-	/* for block groups in our same type */
-	struct list_head block_groups[BTRFS_NR_RAID_TYPES];
-	wait_queue_head_t wait;
-
-	struct kobject kobj;
-	struct kobject *block_group_kobjs[BTRFS_NR_RAID_TYPES];
-};
-
 /*
  * Types of block reserves
  */
@@ -2677,12 +2612,6 @@ static inline u64 btrfs_extref_hash(u64 parent_objectid, const char *name,
        return (u64) crc32c(parent_objectid, name, len);
 }
 
-static inline bool btrfs_mixed_space_info(struct btrfs_space_info *space_info)
-{
-	return ((space_info->flags & BTRFS_BLOCK_GROUP_METADATA) &&
-		(space_info->flags & BTRFS_BLOCK_GROUP_DATA));
-}
-
 static inline gfp_t btrfs_alloc_write_mask(struct address_space *mapping)
 {
 	return mapping_gfp_constraint(mapping, ~__GFP_FS);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 396edca9b31f..fbd173ebc4be 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -28,6 +28,7 @@
 #include "sysfs.h"
 #include "qgroup.h"
 #include "ref-verify.h"
+#include "space-info.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 6814fa42eba3..390cd3d7d5ea 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -18,6 +18,7 @@
 #include "extent_io.h"
 #include "inode-map.h"
 #include "volumes.h"
+#include "space-info.h"
 
 #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
 #define MAX_CACHE_BYTES_PER_GIG	SZ_32K
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 803577d42518..1af3af3d708c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -43,6 +43,7 @@
 #include "qgroup.h"
 #include "tree-log.h"
 #include "compression.h"
+#include "space-info.h"
 
 #ifdef CONFIG_64BIT
 /* If we have a 32-bit userspace and 64-bit kernel, then the UAPI
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
new file mode 100644
index 000000000000..2f69cf9e13da
--- /dev/null
+++ b/fs/btrfs/space-info.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Facebook.  All rights reserved.
+ */
+
+#ifndef BTRFS_SPACE_INFO_H
+#define BTRFS_SPACE_INFO_H
+
+struct btrfs_space_info {
+	spinlock_t lock;
+
+	u64 total_bytes;	/* total bytes in the space,
+				   this doesn't take mirrors into account */
+	u64 bytes_used;		/* total bytes used,
+				   this doesn't take mirrors into account */
+	u64 bytes_pinned;	/* total bytes pinned, will be freed when the
+				   transaction finishes */
+	u64 bytes_reserved;	/* total bytes the allocator has reserved for
+				   current allocations */
+	u64 bytes_may_use;	/* number of bytes that may be used for
+				   delalloc/allocations */
+	u64 bytes_readonly;	/* total bytes that are read only */
+
+	u64 max_extent_size;	/* This will hold the maximum extent size of
+				   the space info if we had an ENOSPC in the
+				   allocator. */
+
+	unsigned int full:1;	/* indicates that we cannot allocate any more
+				   chunks for this space */
+	unsigned int chunk_alloc:1;	/* set if we are allocating a chunk */
+
+	unsigned int flush:1;		/* set if we are trying to make space */
+
+	unsigned int force_alloc;	/* set if we need to force a chunk
+					   alloc for this space */
+
+	u64 disk_used;		/* total bytes used on disk */
+	u64 disk_total;		/* total bytes on disk, takes mirrors into
+				   account */
+
+	u64 flags;
+
+	/*
+	 * bytes_pinned is kept in line with what is actually pinned, as in
+	 * we've called update_block_group and dropped the bytes_used counter
+	 * and increased the bytes_pinned counter.  However this means that
+	 * bytes_pinned does not reflect the bytes that will be pinned once the
+	 * delayed refs are flushed, so this counter is inc'ed every time we
+	 * call btrfs_free_extent so it is a realtime count of what will be
+	 * freed once the transaction is committed.  It will be zeroed every
+	 * time the transaction commits.
+	 */
+	struct percpu_counter total_bytes_pinned;
+
+	struct list_head list;
+	/* Protected by the spinlock 'lock'. */
+	struct list_head ro_bgs;
+	struct list_head priority_tickets;
+	struct list_head tickets;
+	/*
+	 * tickets_id just indicates the next ticket will be handled, so note
+	 * it's not stored per ticket.
+	 */
+	u64 tickets_id;
+
+	struct rw_semaphore groups_sem;
+	/* for block groups in our same type */
+	struct list_head block_groups[BTRFS_NR_RAID_TYPES];
+	wait_queue_head_t wait;
+
+	struct kobject kobj;
+	struct kobject *block_group_kobjs[BTRFS_NR_RAID_TYPES];
+};
+
+static inline bool btrfs_mixed_space_info(struct btrfs_space_info *space_info)
+{
+	return ((space_info->flags & BTRFS_BLOCK_GROUP_METADATA) &&
+		(space_info->flags & BTRFS_BLOCK_GROUP_DATA));
+}
+
+#endif /* BTRFS_SPACE_INFO_H */
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 72998695e302..267f74b2ea8b 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -42,6 +42,7 @@
 #include "dev-replace.h"
 #include "free-space-cache.h"
 #include "backref.h"
+#include "space-info.h"
 #include "tests/btrfs-tests.h"
 
 #include "qgroup.h"
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 2f078b77fe14..e6493b068294 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -16,6 +16,7 @@
 #include "transaction.h"
 #include "sysfs.h"
 #include "volumes.h"
+#include "space-info.h"
 
 static inline struct btrfs_fs_info *to_fs_info(struct kobject *kobj);
 static inline struct btrfs_fs_devices *to_fs_devs(struct kobject *kobj);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9cbeec2bfbf9..68bc894ec48e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -28,6 +28,7 @@
 #include "dev-replace.h"
 #include "sysfs.h"
 #include "tree-checker.h"
+#include "space-info.h"
 
 const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 	[BTRFS_RAID_RAID10] = {
-- 
2.14.3

