Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCB060170B
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 21:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiJQTJo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 15:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJQTJd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 15:09:33 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7ACDFF6
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:29 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id f14so8007271qvo.3
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ckPjrtKK/3iuDAeigLFb4ru1nqO2Yh/Gb1x+vc32YuE=;
        b=xWsIrP/nEv+YXLfLTXC4GyhWQRcRscdDzfsIBnuo3j5blksY0uJCmNeM1YXBfSApPP
         UEAg8FyeGqOXztGJm39Iqg2mhIkXiO4eoEU0qpmVC7UME6ZKQdjECsML++76gAMiM0K0
         3j2d8iBh8Eg2E6mnz7Xkj7I+nbVNimewiMBVhxpIpqXmaPbjuOFBXvu8OEnvbCZv08hG
         Pm2O4Ofp6qtyRRlhneGeaUFI9bJK1OkRzhJYXzJZcVS6fld1B9afBmDmMOPgmTk9rx7W
         A3sjkBQNwOC0wbcc0XL5cm6sTJYTyZJXAG+OmCnYfvf9cot5ha3OzLhE9s8bUyWNpKq1
         oo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckPjrtKK/3iuDAeigLFb4ru1nqO2Yh/Gb1x+vc32YuE=;
        b=fucXNOQdcFPwbGr+sPADJt0XfxHn1paWz2Dk5zq2MEQUvER+SI1RGs/80Wa/aCDJo+
         7A5Bw+mVjmoX+XQprYZXcWNVlHjoJ4qsNLum3qDSbtevEsIwbBJFa6qpbSrIYUD0O0x4
         H5AbTKXIF45as1jpiNqEKyQJp0Lip2ttWQjiJlNNsDFCJupjSQtkBE9h0GGOZBMiDEDa
         nQEQlDN/LJBMN6N+14SD1CoL61hJIVgVnNPM5khLcJylTfgIUyOEe2AnbKHjlVCCUx2G
         6wNB6g3Q6QeUbJPxLYoHCI2Qm3KH3N3TWi+Bq0jUQXfFG1zUSeL7eSolCjHYkJGPTkCX
         MBxQ==
X-Gm-Message-State: ACrzQf3/GaKlj9M8cDtniIX++CCjFc5Z/JyZWpi68lMoGff4w11Z6OCl
        l55InWim3p8J66kQKkD1fjfHFUcaJuf5xg==
X-Google-Smtp-Source: AMsMyM7COJkc0a/ZJz1ozOKqgjjQqHn89S8i4BIHIrB//VQsBvFtyPy2HMwbAxcMhIkIlpK6o9JoQw==
X-Received: by 2002:a0c:b689:0:b0:4b4:a840:4cf9 with SMTP id u9-20020a0cb689000000b004b4a8404cf9mr9665852qvd.85.1666033767726;
        Mon, 17 Oct 2022 12:09:27 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id ca27-20020a05622a1f1b00b003436103df40sm434916qtb.8.2022.10.17.12.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:09:27 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 09/16] btrfs: move fs_info->flags enum to fs.h
Date:   Mon, 17 Oct 2022 15:09:06 -0400
Message-Id: <e0d28f8bbdf3c48870ca483fadd9d38562a4712c.1666033501.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666033501.git.josef@toxicpanda.com>
References: <cover.1666033501.git.josef@toxicpanda.com>
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

These definitions are fs wide, take them out of ctree.h and put them in
fs.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h              | 68 -----------------------------------
 fs/btrfs/delayed-inode.c      |  1 +
 fs/btrfs/fs.h                 | 68 +++++++++++++++++++++++++++++++++++
 fs/btrfs/root-tree.c          |  1 +
 fs/btrfs/tests/qgroup-tests.c |  1 +
 fs/btrfs/tree-mod-log.c       |  1 +
 6 files changed, 72 insertions(+), 68 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 89d70589d479..99c51bc29b8a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -272,69 +272,6 @@ struct btrfs_discard_ctl {
 	atomic64_t discard_bytes_saved;
 };
 
-enum {
-	BTRFS_FS_CLOSING_START,
-	BTRFS_FS_CLOSING_DONE,
-	BTRFS_FS_LOG_RECOVERING,
-	BTRFS_FS_OPEN,
-	BTRFS_FS_QUOTA_ENABLED,
-	BTRFS_FS_UPDATE_UUID_TREE_GEN,
-	BTRFS_FS_CREATING_FREE_SPACE_TREE,
-	BTRFS_FS_BTREE_ERR,
-	BTRFS_FS_LOG1_ERR,
-	BTRFS_FS_LOG2_ERR,
-	BTRFS_FS_QUOTA_OVERRIDE,
-	/* Used to record internally whether fs has been frozen */
-	BTRFS_FS_FROZEN,
-	/*
-	 * Indicate that balance has been set up from the ioctl and is in the
-	 * main phase. The fs_info::balance_ctl is initialized.
-	 */
-	BTRFS_FS_BALANCE_RUNNING,
-
-	/*
-	 * Indicate that relocation of a chunk has started, it's set per chunk
-	 * and is toggled between chunks.
-	 */
-	BTRFS_FS_RELOC_RUNNING,
-
-	/* Indicate that the cleaner thread is awake and doing something. */
-	BTRFS_FS_CLEANER_RUNNING,
-
-	/*
-	 * The checksumming has an optimized version and is considered fast,
-	 * so we don't need to offload checksums to workqueues.
-	 */
-	BTRFS_FS_CSUM_IMPL_FAST,
-
-	/* Indicate that the discard workqueue can service discards. */
-	BTRFS_FS_DISCARD_RUNNING,
-
-	/* Indicate that we need to cleanup space cache v1 */
-	BTRFS_FS_CLEANUP_SPACE_CACHE_V1,
-
-	/* Indicate that we can't trust the free space tree for caching yet */
-	BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED,
-
-	/* Indicate whether there are any tree modification log users */
-	BTRFS_FS_TREE_MOD_LOG_USERS,
-
-	/* Indicate that we want the transaction kthread to commit right now. */
-	BTRFS_FS_COMMIT_TRANS,
-
-	/* Indicate we have half completed snapshot deletions pending. */
-	BTRFS_FS_UNFINISHED_DROPS,
-
-	/* Indicate we have to finish a zone to do next allocation. */
-	BTRFS_FS_NEED_ZONE_FINISH,
-
-#if BITS_PER_LONG == 32
-	/* Indicate if we have error/warn message printed on 32bit systems */
-	BTRFS_FS_32BIT_ERROR,
-	BTRFS_FS_32BIT_WARN,
-#endif
-};
-
 /*
  * Exclusive operations (device replace, resize, device add/remove, balance)
  */
@@ -1029,11 +966,6 @@ enum btrfs_lockdep_trans_states {
 				 &lock##_key, 0);				\
 	} while (0)
 
-static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
-{
-	clear_and_wake_up_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags);
-}
-
 /*
  * Record swapped tree blocks of a subvolume tree for delayed subtree trace
  * code. For detail check comment in fs/btrfs/qgroup.c.
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 2f68570fbb53..cabda586af2a 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -17,6 +17,7 @@
 #include "locking.h"
 #include "inode-item.h"
 #include "space-info.h"
+#include "fs.h"
 
 #define BTRFS_DELAYED_WRITEBACK		512
 #define BTRFS_DELAYED_BACKGROUND	128
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 92a17b1fda8b..2d06add70695 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -34,6 +34,69 @@ enum {
 	BTRFS_FS_STATE_COUNT
 };
 
+enum {
+	BTRFS_FS_CLOSING_START,
+	BTRFS_FS_CLOSING_DONE,
+	BTRFS_FS_LOG_RECOVERING,
+	BTRFS_FS_OPEN,
+	BTRFS_FS_QUOTA_ENABLED,
+	BTRFS_FS_UPDATE_UUID_TREE_GEN,
+	BTRFS_FS_CREATING_FREE_SPACE_TREE,
+	BTRFS_FS_BTREE_ERR,
+	BTRFS_FS_LOG1_ERR,
+	BTRFS_FS_LOG2_ERR,
+	BTRFS_FS_QUOTA_OVERRIDE,
+	/* Used to record internally whether fs has been frozen */
+	BTRFS_FS_FROZEN,
+	/*
+	 * Indicate that balance has been set up from the ioctl and is in the
+	 * main phase. The fs_info::balance_ctl is initialized.
+	 */
+	BTRFS_FS_BALANCE_RUNNING,
+
+	/*
+	 * Indicate that relocation of a chunk has started, it's set per chunk
+	 * and is toggled between chunks.
+	 */
+	BTRFS_FS_RELOC_RUNNING,
+
+	/* Indicate that the cleaner thread is awake and doing something. */
+	BTRFS_FS_CLEANER_RUNNING,
+
+	/*
+	 * The checksumming has an optimized version and is considered fast,
+	 * so we don't need to offload checksums to workqueues.
+	 */
+	BTRFS_FS_CSUM_IMPL_FAST,
+
+	/* Indicate that the discard workqueue can service discards. */
+	BTRFS_FS_DISCARD_RUNNING,
+
+	/* Indicate that we need to cleanup space cache v1 */
+	BTRFS_FS_CLEANUP_SPACE_CACHE_V1,
+
+	/* Indicate that we can't trust the free space tree for caching yet */
+	BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED,
+
+	/* Indicate whether there are any tree modification log users */
+	BTRFS_FS_TREE_MOD_LOG_USERS,
+
+	/* Indicate that we want the transaction kthread to commit right now. */
+	BTRFS_FS_COMMIT_TRANS,
+
+	/* Indicate we have half completed snapshot deletions pending. */
+	BTRFS_FS_UNFINISHED_DROPS,
+
+	/* Indicate we have to finish a zone to do next allocation. */
+	BTRFS_FS_NEED_ZONE_FINISH,
+
+#if BITS_PER_LONG == 32
+	/* Indicate if we have error/warn message printed on 32bit systems */
+	BTRFS_FS_32BIT_ERROR,
+	BTRFS_FS_32BIT_WARN,
+#endif
+};
+
 /*
  * Flags for mount options.
  *
@@ -173,6 +236,11 @@ static inline void btrfs_clear_sb_rdonly(struct super_block *sb)
 	clear_bit(BTRFS_FS_STATE_RO, &btrfs_sb(sb)->fs_state);
 }
 
+static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
+{
+	clear_and_wake_up_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags);
+}
+
 #define BTRFS_FS_ERROR(fs_info)	(unlikely(test_bit(BTRFS_FS_STATE_ERROR, \
 						   &(fs_info)->fs_state)))
 #define BTRFS_FS_LOG_CLEANUP_ERROR(fs_info)				\
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 112b4bf3c3b8..b70ed41c2ce0 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -13,6 +13,7 @@
 #include "print-tree.h"
 #include "qgroup.h"
 #include "space-info.h"
+#include "fs.h"
 
 /*
  * Read a root item from the tree. In case we detect a root item smaller then
diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
index eee1e4459541..09b45c3d8386 100644
--- a/fs/btrfs/tests/qgroup-tests.c
+++ b/fs/btrfs/tests/qgroup-tests.c
@@ -10,6 +10,7 @@
 #include "../disk-io.h"
 #include "../qgroup.h"
 #include "../backref.h"
+#include "../fs.h"
 
 static int insert_normal_tree_ref(struct btrfs_root *root, u64 bytenr,
 				  u64 num_bytes, u64 parent, u64 root_objectid)
diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index bf894de47731..dc5e909ee299 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -3,6 +3,7 @@
 #include "messages.h"
 #include "tree-mod-log.h"
 #include "disk-io.h"
+#include "fs.h"
 
 struct tree_mod_root {
 	u64 logical;
-- 
2.26.3

