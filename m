Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0B29B524
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2019 19:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732906AbfHWRJN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Aug 2019 13:09:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:54280 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732319AbfHWRIL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Aug 2019 13:08:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3403DACEC
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2019 17:08:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4F684DA796; Fri, 23 Aug 2019 19:08:34 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/7] btrfs: move cond_wake_up functions out of ctree
Date:   Fri, 23 Aug 2019 19:08:34 +0200
Message-Id: <39c04b1506061f2b94d9425eab60466f0a2146fb.1566579823.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566579823.git.dsterba@suse.com>
References: <cover.1566579823.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The file ctree.h serves as a header for everything and has become quite
bloated. Split some helpers that are generic and create a new file that
should be the catch-all for code that's not btrfs-specific.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c   |  1 +
 fs/btrfs/ctree.h         | 22 ----------------------
 fs/btrfs/delayed-inode.c |  1 +
 fs/btrfs/dev-replace.c   |  1 +
 fs/btrfs/extent-tree.c   |  1 +
 fs/btrfs/inode.c         |  1 +
 fs/btrfs/locking.c       |  1 +
 fs/btrfs/misc.h          | 33 +++++++++++++++++++++++++++++++++
 fs/btrfs/ordered-data.c  |  1 +
 fs/btrfs/transaction.c   |  1 +
 fs/btrfs/tree-log.c      |  1 +
 fs/btrfs/zstd.c          |  1 +
 12 files changed, 43 insertions(+), 22 deletions(-)
 create mode 100644 fs/btrfs/misc.h

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index fe7a8b5ff96c..b05b361e2062 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -18,6 +18,7 @@
 #include <linux/sched/mm.h>
 #include <linux/log2.h>
 #include <crypto/hash.h>
+#include "misc.h"
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d27b39858339..70d1b9767a96 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3516,26 +3516,4 @@ static inline int btrfs_is_testing(struct btrfs_fs_info *fs_info)
 }
 #endif
 
-static inline void cond_wake_up(struct wait_queue_head *wq)
-{
-	/*
-	 * This implies a full smp_mb barrier, see comments for
-	 * waitqueue_active why.
-	 */
-	if (wq_has_sleeper(wq))
-		wake_up(wq);
-}
-
-static inline void cond_wake_up_nomb(struct wait_queue_head *wq)
-{
-	/*
-	 * Special case for conditional wakeup where the barrier required for
-	 * waitqueue_active is implied by some of the preceding code. Eg. one
-	 * of such atomic operations (atomic_dec_and_return, ...), or a
-	 * unlock/lock sequence, etc.
-	 */
-	if (waitqueue_active(wq))
-		wake_up(wq);
-}
-
 #endif
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 9318cf761a07..1f7f39b10bd0 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -6,6 +6,7 @@
 
 #include <linux/slab.h>
 #include <linux/iversion.h>
+#include "misc.h"
 #include "delayed-inode.h"
 #include "disk-io.h"
 #include "transaction.h"
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 00ea828beb00..48890826b5e6 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -9,6 +9,7 @@
 #include <linux/blkdev.h>
 #include <linux/kthread.h>
 #include <linux/math64.h>
+#include "misc.h"
 #include "ctree.h"
 #include "extent_map.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index af7631472073..795b592e5269 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -16,6 +16,7 @@
 #include <linux/percpu_counter.h>
 #include <linux/lockdep.h>
 #include <linux/crc32c.h>
+#include "misc.h"
 #include "tree-log.h"
 #include "disk-io.h"
 #include "print-tree.h"
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index aece5dd0e7a8..30adbdd775a3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -30,6 +30,7 @@
 #include <linux/swap.h>
 #include <linux/sched/mm.h>
 #include <asm/unaligned.h>
+#include "misc.h"
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index e4309bcf0b5f..7f9a578a1a20 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -8,6 +8,7 @@
 #include <linux/spinlock.h>
 #include <linux/page-flags.h>
 #include <asm/bug.h>
+#include "misc.h"
 #include "ctree.h"
 #include "extent_io.h"
 #include "locking.h"
diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
new file mode 100644
index 000000000000..ef3901238ddd
--- /dev/null
+++ b/fs/btrfs/misc.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_MISC_H
+#define BTRFS_MISC_H
+
+#include <linux/sched.h>
+#include <linux/wait.h>
+
+#define in_range(b, first, len) ((b) >= (first) && (b) < (first) + (len))
+
+static inline void cond_wake_up(struct wait_queue_head *wq)
+{
+	/*
+	 * This implies a full smp_mb barrier, see comments for
+	 * waitqueue_active why.
+	 */
+	if (wq_has_sleeper(wq))
+		wake_up(wq);
+}
+
+static inline void cond_wake_up_nomb(struct wait_queue_head *wq)
+{
+	/*
+	 * Special case for conditional wakeup where the barrier required for
+	 * waitqueue_active is implied by some of the preceding code. Eg. one
+	 * of such atomic operations (atomic_dec_and_return, ...), or a
+	 * unlock/lock sequence, etc.
+	 */
+	if (waitqueue_active(wq))
+		wake_up(wq);
+}
+
+#endif
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index ae7f64a8facb..24b6c72b9a59 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -7,6 +7,7 @@
 #include <linux/blkdev.h>
 #include <linux/writeback.h>
 #include <linux/sched/mm.h>
+#include "misc.h"
 #include "ctree.h"
 #include "transaction.h"
 #include "btrfs_inode.h"
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index f21416d68c2c..8624bdee8c5b 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -10,6 +10,7 @@
 #include <linux/pagemap.h>
 #include <linux/blkdev.h>
 #include <linux/uuid.h>
+#include "misc.h"
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 19a4b9dc669f..34d087008b72 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -8,6 +8,7 @@
 #include <linux/blkdev.h>
 #include <linux/list_sort.h>
 #include <linux/iversion.h>
+#include "misc.h"
 #include "ctree.h"
 #include "tree-log.h"
 #include "disk-io.h"
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 0af4a5cd4313..764d47b107e5 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/zstd.h>
+#include "misc.h"
 #include "compression.h"
 #include "ctree.h"
 
-- 
2.22.0

