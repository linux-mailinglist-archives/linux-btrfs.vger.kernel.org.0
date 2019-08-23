Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 895AC9B525
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2019 19:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732949AbfHWRJN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Aug 2019 13:09:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:54290 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732426AbfHWRIN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Aug 2019 13:08:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 96C16AC0C
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2019 17:08:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B51D6DA796; Fri, 23 Aug 2019 19:08:36 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/7] btrfs: move math functions to misc.h
Date:   Fri, 23 Aug 2019 19:08:36 +0200
Message-Id: <e74f79c0bed6fcbbd47d8adcd3618acf1dc5e14e.1566579823.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566579823.git.dsterba@suse.com>
References: <cover.1566579823.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c |  2 +-
 fs/btrfs/block-rsv.c   |  2 +-
 fs/btrfs/extent-tree.c |  1 -
 fs/btrfs/math.h        | 28 ----------------------------
 fs/btrfs/misc.h        | 17 +++++++++++++++++
 fs/btrfs/space-info.c  |  2 +-
 fs/btrfs/volumes.c     |  2 +-
 7 files changed, 21 insertions(+), 33 deletions(-)
 delete mode 100644 fs/btrfs/math.h

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 162fd9d13b36..10ba8eddec22 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include "misc.h"
 #include "ctree.h"
 #include "block-group.h"
 #include "space-info.h"
@@ -13,7 +14,6 @@
 #include "sysfs.h"
 #include "tree-log.h"
 #include "delalloc-space.h"
-#include "math.h"
 
 /*
  * Return target flags in extended format or 0 if restripe for this chunk_type
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 698470b9f32d..ef8b8ae27386 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include "misc.h"
 #include "ctree.h"
 #include "block-rsv.h"
 #include "space-info.h"
-#include "math.h"
 #include "transaction.h"
 
 static u64 block_rsv_release_bytes(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 795b592e5269..2bf5dad82bf1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -25,7 +25,6 @@
 #include "locking.h"
 #include "free-space-cache.h"
 #include "free-space-tree.h"
-#include "math.h"
 #include "sysfs.h"
 #include "qgroup.h"
 #include "ref-verify.h"
diff --git a/fs/btrfs/math.h b/fs/btrfs/math.h
deleted file mode 100644
index 75246f2f56ba..000000000000
--- a/fs/btrfs/math.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2012 Fujitsu.  All rights reserved.
- * Written by Miao Xie <miaox@cn.fujitsu.com>
- */
-
-#ifndef BTRFS_MATH_H
-#define BTRFS_MATH_H
-
-#include <asm/div64.h>
-
-static inline u64 div_factor(u64 num, int factor)
-{
-	if (factor == 10)
-		return num;
-	num *= factor;
-	return div_u64(num, 10);
-}
-
-static inline u64 div_factor_fine(u64 num, int factor)
-{
-	if (factor == 100)
-		return num;
-	num *= factor;
-	return div_u64(num, 100);
-}
-
-#endif
diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index ef3901238ddd..7d564924dfeb 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -5,6 +5,7 @@
 
 #include <linux/sched.h>
 #include <linux/wait.h>
+#include <asm/div64.h>
 
 #define in_range(b, first, len) ((b) >= (first) && (b) < (first) + (len))
 
@@ -30,4 +31,20 @@ static inline void cond_wake_up_nomb(struct wait_queue_head *wq)
 		wake_up(wq);
 }
 
+static inline u64 div_factor(u64 num, int factor)
+{
+	if (factor == 10)
+		return num;
+	num *= factor;
+	return div_u64(num, 10);
+}
+
+static inline u64 div_factor_fine(u64 num, int factor)
+{
+	if (factor == 100)
+		return num;
+	num *= factor;
+	return div_u64(num, 100);
+}
+
 #endif
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 13a4326c8821..bea7ae0a9739 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include "misc.h"
 #include "ctree.h"
 #include "space-info.h"
 #include "sysfs.h"
@@ -7,7 +8,6 @@
 #include "free-space-cache.h"
 #include "ordered-data.h"
 #include "transaction.h"
-#include "math.h"
 #include "block-group.h"
 
 u64 btrfs_space_info_used(struct btrfs_space_info *s_info,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e2de7c7b674a..dc1f6985c2c4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -14,6 +14,7 @@
 #include <linux/semaphore.h>
 #include <linux/uuid.h>
 #include <linux/list_sort.h>
+#include "misc.h"
 #include "ctree.h"
 #include "extent_map.h"
 #include "disk-io.h"
@@ -24,7 +25,6 @@
 #include "async-thread.h"
 #include "check-integrity.h"
 #include "rcu-string.h"
-#include "math.h"
 #include "dev-replace.h"
 #include "sysfs.h"
 #include "tree-checker.h"
-- 
2.22.0

