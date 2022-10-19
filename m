Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAC9604A21
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Oct 2022 16:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiJSO6Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 10:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiJSO5j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 10:57:39 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267564151C
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:15 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id bb5so11779453qtb.11
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prekNHroNmBWzWM8ex8eQvCS1V4Vvv2irg2whWwCyag=;
        b=jN0Ew0Ix9w/IB3lSAZL67krTV4gJk0ARdqgjMMzANvwhOuSJAry3mBiSuZloNJMM2i
         h4W/YGROS5Z/cFN729mhjFS/oBpuxA/60KK9TeKfA5UNWJNPBrD2ammZABGa5tuYOoUp
         2W0gAv6QsTJK2VPfk2vYhSRfnIKk+XPWgGCOzi9FDV0a5KPYPaAC+APSzUBbbxurv1uS
         FA5MASxCafadJZv1VVu2DAV5uRiWPJRQX9Bq/dFkBSzr6wYkzrEBarEBkNgXT4pnOt/t
         7jFzu46z+YHqV52HkQTcwI144B76vWuwN7AwoP/KL4yZwjf11CnUR5jAdj7fU1zwTzyL
         r1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prekNHroNmBWzWM8ex8eQvCS1V4Vvv2irg2whWwCyag=;
        b=Sgr5tUxjsygy08Jk0aOJ3pPXs2ymbtV/B7xnOhzswl8WGek+GMCO+wjv6OADyBOkd6
         FuqmSLZs2fQhM1W6fxDTz66Jvpxuau2jrrz6vwiCcfz0AAJLHSdKb3CS+55+krweq+To
         8TOb3hFVU1v7vfYIiabcpnDbHH1ER5YLVlK1YtBMAT9D7KP5hSnlFFH2G1evcEto1BzE
         jICmjDRcthKTdlS2+a7TNCM0s1pssFYuTMn8LcLmqskxgrDTVPZODugqGBD9KATw144m
         3UKycov3hWExvIFZDYFd6h9OZ/ab4T9nHpO7kLxDDLoQu7/pbls1zGAsLfNsnqNHAP9L
         Bong==
X-Gm-Message-State: ACrzQf2lAuQPeQDWq4MMf33LpvUR3M4eLLPaGzSLxKlX9RX9aIQyUHXt
        sl61rVHjg43x/rEJQt+bCgETaSS1Ys2sBA==
X-Google-Smtp-Source: AMsMyM5SeIkGxG9xpwXVJQ3YuiGQ6a6GjF11s0M6LBmtV7J3EvhvXUij0mLAY3tWw5ToMnTEGbivgg==
X-Received: by 2002:ac8:4e44:0:b0:399:efde:98c5 with SMTP id e4-20020ac84e44000000b00399efde98c5mr6782694qtw.640.1666191073869;
        Wed, 19 Oct 2022 07:51:13 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id d3-20020a05620a240300b006cfc01b4461sm4985067qkn.118.2022.10.19.07.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:51:13 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 08/15] btrfs: move fs_info->flags enum to fs.h
Date:   Wed, 19 Oct 2022 10:50:54 -0400
Message-Id: <dd6a84746e98212744297de1f72ca634c51419e7.1666190849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666190849.git.josef@toxicpanda.com>
References: <cover.1666190849.git.josef@toxicpanda.com>
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

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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

