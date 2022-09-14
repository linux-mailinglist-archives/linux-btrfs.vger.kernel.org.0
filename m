Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803505B8E07
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 19:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiINRSu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 13:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiINRSj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 13:18:39 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0962580379
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:38 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id k12so11384632qkj.8
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=M8WlHjSsEb0WUDbj6tkGZhkeSsACjzJox++mu/hjqbM=;
        b=ZPo16/Mn4AR0+qb9Tveu70777BO8cPDCrCWuChh0cUenqz2WVCjVEormuOs8T1f1Et
         GGIgdz/A7PdP4zTD94tA0k4pwiSVDMz+pUb6mncNaZNdW4xXsWe/CvjTpwCsCYFHVlU2
         ko1obDiPAyIJ7ldAAp+2tR/FW3b7/WF276NlDIUaEeDWT2HK+93zWxxAqmiRSm+tEaII
         cWmvL/pBf2FXnz36AuMEcbCcFI3UC0mmk7Mtdr8OX6tRUzKETRbd80nUvBexheEHNzBa
         7bnVnWlRE1FSPNKNXCnHoP/mywDJIXVnYN6SJ0SMv3qMnQwgvV+Zy9dSVdKKu4rum4Zi
         GJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=M8WlHjSsEb0WUDbj6tkGZhkeSsACjzJox++mu/hjqbM=;
        b=b6okm1sK42BNQgcjpZwCwnali05OiRdJLDw0YOEPIRYxzm9ak4NMrSSgMnejiyUH3/
         VnY2gNw5D+i7/VBMRPFdvlmtm5J8yDF41dmlWgqJDt/0K03XRJxYOov+4unNTaEuD9kT
         XIvH/J4s+HSnTojQiLUgyuYbQCyUXcXrJLfCvLhtpY/2IndgXwz1hAyC4Q4EKTerskRw
         Iuc9hIdADE4PJ5E86FzxHA3Qry5whEjfHln6avpQTBSXVrDZmD2yCdUno4h4RdJun9RU
         FkBcwgrR/Zsx4gGFr6gFQ/1Ceh+KvkO1EMdtR8M0s6cMemUh9NQgIFtPRvPw0SHxDAcb
         jnUA==
X-Gm-Message-State: ACgBeo2N1fv5FKfz0yWFLydZ/q9LsMWDixOX6gswEBvlbJeqsnENILuq
        pbiZbupHNzdcqb2g3H0aaRyu70ZcTeOwVQ==
X-Google-Smtp-Source: AA6agR6ojIslzx00dKOrv8Xp06W1bfYv0O8qIUir1kX3Dqa+p1pa/kbMZ3O+/sYRhc5FmXSGtZYexQ==
X-Received: by 2002:a05:620a:4554:b0:6ce:4e75:fa2a with SMTP id u20-20020a05620a455400b006ce4e75fa2amr9528107qkp.281.1663175917241;
        Wed, 14 Sep 2022 10:18:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p8-20020a05622a00c800b0035bb8168daesm2124299qtw.57.2022.09.14.10.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 10:18:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/16] btrfs: move fs_info->flags enum to fs.h
Date:   Wed, 14 Sep 2022 13:18:15 -0400
Message-Id: <eab7da9a54588b8ad9641a148f54824bed1c1fcd.1663175597.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663175597.git.josef@toxicpanda.com>
References: <cover.1663175597.git.josef@toxicpanda.com>
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
index e08e956bd603..8decad27a6c5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -317,69 +317,6 @@ struct btrfs_swapfile_pin {
 
 bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
 
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
@@ -1012,11 +949,6 @@ enum btrfs_lockdep_trans_states {
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
index f3ff22ce3a7b..8acb3785ad6e 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -16,6 +16,7 @@
 #include "locking.h"
 #include "inode-item.h"
 #include "space-info.h"
+#include "fs.h"
 
 #define BTRFS_DELAYED_WRITEBACK		512
 #define BTRFS_DELAYED_BACKGROUND	128
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 9f1fa2e88ffe..c7eb21768b66 100644
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
@@ -171,6 +234,11 @@ static inline void btrfs_clear_sb_rdonly(struct super_block *sb)
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
index ab9e891ddb79..04b94727373f 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -12,6 +12,7 @@
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
index 51ace0ac5c2d..523a184d10cc 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -3,6 +3,7 @@
 #include "btrfs-printk.h"
 #include "tree-mod-log.h"
 #include "disk-io.h"
+#include "fs.h"
 
 struct tree_mod_root {
 	u64 logical;
-- 
2.26.3

