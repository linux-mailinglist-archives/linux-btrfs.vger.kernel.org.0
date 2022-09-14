Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD665B8B5A
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 17:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiINPHP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 11:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiINPHB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 11:07:01 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B0A7694D
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:07:00 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id d15so11069356qka.9
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=WhDj7S4ZAtRZpe7QjuqEx84NdUSTMg4XxgEuAjzN58w=;
        b=uJwNzcJ4b34m2xHmZsulTW5hIFE1HDE92Lc7VW0c+4aw6RUcXOQl2qzz99nYcmaZ4o
         djniHVNNDkAaGawW/Hh5VYLaJ2F+HKJhCXaTOsBukRpFDCdFAhNks+Tq5MsvmPD5Diew
         odjx11yhSCk/KurXX1W29dEbdj+yZXEQwiLr9YLQKY89cUxRBFSPJ6/RMy9Dj4hqaA+q
         vDoUM+aRU3s+e/3LVkLlRp6t594MMDbqBi7RxFVYKu4ilbdYcdazaVFsWKJW3bOW73KL
         Z1xHDwILOQbsrhn99mt2vKKCK9G02ocXMuITqOBcj35dcRp022mMnQ4PBVl/DvfyAJe7
         hsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WhDj7S4ZAtRZpe7QjuqEx84NdUSTMg4XxgEuAjzN58w=;
        b=UHxqItgK1tyXoRopdOnBICbHxZqgqqma5SsVBZ/BCuwpYwVFu8W+/9VNqTuFtNdTHi
         7iN9W83L+H+rPEDP7HOTaeyLK2sodDIlrCkDdXBycUzQ/I+dJYVBfheU8/cJ0gi2TdcZ
         yBpQL0rLiOdPV4j+TChxPorQlQSWQGEWibQ5sVrCtzjO4nc8M45OD4OR5mFrJw/vbGH6
         XIk3axfWKg1jmN4MxpVnfZ7JGwr8YRt7A/YwRfnd1jZ+rOHQ1mE75h0VNVH+iTf024r7
         e2cPANT062LSoa7RewNANPqSE2UnPz2FGpifesQMvghneHxwiEzan/nlwsfMtCZxEoOB
         bCRg==
X-Gm-Message-State: ACgBeo2KRNjSMgrGTD+CrflvTan6piUqxWL2v0RQGdJpmDbSiGdcEe0F
        60DNc8ryWJ52vTEGeFSl8JCBsJJS9KlVNQ==
X-Google-Smtp-Source: AA6agR5u3NoHsBbXRdqDmT1FHg3sIcGMrMMyhn1q7FyegkJoW7PTUrbVVlcatHWYGg0EHiDmsF2u0w==
X-Received: by 2002:a05:620a:13cf:b0:6ce:3df8:5ccc with SMTP id g15-20020a05620a13cf00b006ce3df85cccmr10700816qkl.623.1663168019344;
        Wed, 14 Sep 2022 08:06:59 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bl27-20020a05620a1a9b00b006bbc09af9f5sm1844441qkb.101.2022.09.14.08.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:06:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/17] btrfs: move flush related definitions to space-info.h
Date:   Wed, 14 Sep 2022 11:06:35 -0400
Message-Id: <a946709036f0527dba6ec810e9cd61b19d267d6c.1663167823.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663167823.git.josef@toxicpanda.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This code is used in space-info.c, move the definitions to space-info.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h         | 59 ----------------------------------------
 fs/btrfs/delayed-inode.c |  1 +
 fs/btrfs/inode-item.c    |  1 +
 fs/btrfs/props.c         |  1 +
 fs/btrfs/relocation.c    |  1 +
 fs/btrfs/space-info.h    | 59 ++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/super.c         |  1 +
 7 files changed, 64 insertions(+), 59 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 60f8817f5b7c..d99720cf4835 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2654,65 +2654,6 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 
 void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
 
-/*
- * Different levels for to flush space when doing space reservations.
- *
- * The higher the level, the more methods we try to reclaim space.
- */
-enum btrfs_reserve_flush_enum {
-	/* If we are in the transaction, we can't flush anything.*/
-	BTRFS_RESERVE_NO_FLUSH,
-
-	/*
-	 * Flush space by:
-	 * - Running delayed inode items
-	 * - Allocating a new chunk
-	 */
-	BTRFS_RESERVE_FLUSH_LIMIT,
-
-	/*
-	 * Flush space by:
-	 * - Running delayed inode items
-	 * - Running delayed refs
-	 * - Running delalloc and waiting for ordered extents
-	 * - Allocating a new chunk
-	 */
-	BTRFS_RESERVE_FLUSH_EVICT,
-
-	/*
-	 * Flush space by above mentioned methods and by:
-	 * - Running delayed iputs
-	 * - Committing transaction
-	 *
-	 * Can be interrupted by a fatal signal.
-	 */
-	BTRFS_RESERVE_FLUSH_DATA,
-	BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE,
-	BTRFS_RESERVE_FLUSH_ALL,
-
-	/*
-	 * Pretty much the same as FLUSH_ALL, but can also steal space from
-	 * global rsv.
-	 *
-	 * Can be interrupted by a fatal signal.
-	 */
-	BTRFS_RESERVE_FLUSH_ALL_STEAL,
-};
-
-enum btrfs_flush_state {
-	FLUSH_DELAYED_ITEMS_NR	=	1,
-	FLUSH_DELAYED_ITEMS	=	2,
-	FLUSH_DELAYED_REFS_NR	=	3,
-	FLUSH_DELAYED_REFS	=	4,
-	FLUSH_DELALLOC		=	5,
-	FLUSH_DELALLOC_WAIT	=	6,
-	FLUSH_DELALLOC_FULL	=	7,
-	ALLOC_CHUNK		=	8,
-	ALLOC_CHUNK_FORCE	=	9,
-	RUN_DELAYED_IPUTS	=	10,
-	COMMIT_TRANS		=	11,
-};
-
 int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 				     struct btrfs_block_rsv *rsv,
 				     int nitems, bool use_global_rsv);
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index cac5169eaf8d..a411f04a7b97 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -14,6 +14,7 @@
 #include "qgroup.h"
 #include "locking.h"
 #include "inode-item.h"
+#include "space-info.h"
 
 #define BTRFS_DELAYED_WRITEBACK		512
 #define BTRFS_DELAYED_BACKGROUND	128
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 0eeb5ea87894..366f3a788c6a 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -8,6 +8,7 @@
 #include "disk-io.h"
 #include "transaction.h"
 #include "print-tree.h"
+#include "space-info.h"
 
 struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
 						   int slot, const char *name,
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index 055a631276ce..07f62e3ba6a5 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -10,6 +10,7 @@
 #include "ctree.h"
 #include "xattr.h"
 #include "compression.h"
+#include "space-info.h"
 
 #define BTRFS_PROP_HANDLERS_HT_BITS 8
 static DEFINE_HASHTABLE(prop_handlers_ht, BTRFS_PROP_HANDLERS_HT_BITS);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d87020ae5810..41adbfa3a5f6 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -27,6 +27,7 @@
 #include "subpage.h"
 #include "zoned.h"
 #include "inode-item.h"
+#include "space-info.h"
 
 /*
  * Relocation overview
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 8f5948740941..729820582fa7 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -5,6 +5,65 @@
 
 #include "volumes.h"
 
+/*
+ * Different levels for to flush space when doing space reservations.
+ *
+ * The higher the level, the more methods we try to reclaim space.
+ */
+enum btrfs_reserve_flush_enum {
+	/* If we are in the transaction, we can't flush anything.*/
+	BTRFS_RESERVE_NO_FLUSH,
+
+	/*
+	 * Flush space by:
+	 * - Running delayed inode items
+	 * - Allocating a new chunk
+	 */
+	BTRFS_RESERVE_FLUSH_LIMIT,
+
+	/*
+	 * Flush space by:
+	 * - Running delayed inode items
+	 * - Running delayed refs
+	 * - Running delalloc and waiting for ordered extents
+	 * - Allocating a new chunk
+	 */
+	BTRFS_RESERVE_FLUSH_EVICT,
+
+	/*
+	 * Flush space by above mentioned methods and by:
+	 * - Running delayed iputs
+	 * - Committing transaction
+	 *
+	 * Can be interrupted by a fatal signal.
+	 */
+	BTRFS_RESERVE_FLUSH_DATA,
+	BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE,
+	BTRFS_RESERVE_FLUSH_ALL,
+
+	/*
+	 * Pretty much the same as FLUSH_ALL, but can also steal space from
+	 * global rsv.
+	 *
+	 * Can be interrupted by a fatal signal.
+	 */
+	BTRFS_RESERVE_FLUSH_ALL_STEAL,
+};
+
+enum btrfs_flush_state {
+	FLUSH_DELAYED_ITEMS_NR	=	1,
+	FLUSH_DELAYED_ITEMS	=	2,
+	FLUSH_DELAYED_REFS_NR	=	3,
+	FLUSH_DELAYED_REFS	=	4,
+	FLUSH_DELALLOC		=	5,
+	FLUSH_DELALLOC_WAIT	=	6,
+	FLUSH_DELALLOC_FULL	=	7,
+	ALLOC_CHUNK		=	8,
+	ALLOC_CHUNK_FORCE	=	9,
+	RUN_DELAYED_IPUTS	=	10,
+	COMMIT_TRANS		=	11,
+};
+
 struct btrfs_space_info {
 	spinlock_t lock;
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index be7df8d1d5b8..2add5b23c476 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -49,6 +49,7 @@
 #include "discard.h"
 #include "qgroup.h"
 #include "raid56.h"
+#include "space-info.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
 
-- 
2.26.3

