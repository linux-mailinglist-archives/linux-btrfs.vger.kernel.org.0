Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6062581AFC
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 22:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239930AbiGZUYL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 16:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiGZUYJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 16:24:09 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E4232070
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 13:24:08 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id o21so11868478qkm.10
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 13:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QEdD/gUBQDQ2nRgqBjdsK2NNDSTgpnMXZZkeDafudqM=;
        b=lRCmI1dGALr26HLxpLkfRfd/QggEfki2oWOusZ1OcJWodN7B5D6T7x313fHS8gJz9e
         r3Jl/bPHupSd26B3NgMmhkh64PBlP2ZHWutuYdeb5V9YqwYpis6mGehQbtZ3gAQCDlNN
         OzSzl/1c1SvIkgnCqHTo2QB6daKjmfwPKIBdGjv8XNemCuWS88qtAZ0D+4Y6Z7aDroJO
         I9Xal5gS7TJQCmjr44vwQjA+FrC7kmXLZXuCVLdi9MtaKUYnop6HbtRdUxxj8cjrxMvB
         vqdNHV5WvIGB4jev7BQlS9JX5C/KQ8uNDYKA+RL92ZcXTzyGk8qQlU/OoXdnm6QyVn9X
         P00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QEdD/gUBQDQ2nRgqBjdsK2NNDSTgpnMXZZkeDafudqM=;
        b=CX+JB3mMiKDPA4ENP6JemnimAPtqXr8CzspqnVXyCteHts4qsrCsxaHZjxGpSnk2Gf
         jXkqYKkYvfvbscco4VGnh2uNn98kssFCrzB8SR2LA1rW79tAyaedtNG0DmMGeiyxAfiD
         kHpsng3hBm0JMGQtaA9misOGq/QZUoHxU1/4/k2v7h5hJf8JOQNRJ8ZMZm3XiBy/71CL
         H8p1aj71BQyidy3+DF72QiWmOVRDM1IWknaqBbBHMPISd+HXSjM1GEKZ1F2gQPMc+VaA
         ODAcy3LHCUw8Dkan9RhMkA3p8zyHKFY8B1GwitmTFwL7I/Qe8NtRlZrBX8qd3Q41DeAF
         U/+Q==
X-Gm-Message-State: AJIora/DGiuoscEKNECpFNyinP3HOc5lLez3E34SWCBoKpOfd2H8H47U
        cp2nH9vbTXetxB+WRIpVnLkMJarsuP0Zqw==
X-Google-Smtp-Source: AGRyM1tK0af2VqWcfE/su40jUav3zpXZF7rgRiPdaZb2aNxzraIPT7vukjxSufp3OxxW0yH5DN3/Yg==
X-Received: by 2002:a05:620a:2809:b0:6b6:5908:316e with SMTP id f9-20020a05620a280900b006b65908316emr9231818qkp.734.1658867047255;
        Tue, 26 Jul 2022 13:24:07 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q20-20020a37f714000000b006b5e60c4de1sm11532827qkj.78.2022.07.26.13.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 13:24:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: move lockdep class helpers to locking.*
Date:   Tue, 26 Jul 2022 16:24:03 -0400
Message-Id: <832bf851dbe55b076bb29e8bab499b999b9c2b0b.1658866962.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1658866962.git.josef@toxicpanda.com>
References: <cover.1658866962.git.josef@toxicpanda.com>
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

These definitions exist in disk-io.c, which is not related to the
locking.  Move this over to locking.h/c where it makes more sense.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 82 ----------------------------------------------
 fs/btrfs/disk-io.h | 10 ------
 fs/btrfs/locking.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/locking.h | 10 ++++++
 4 files changed, 92 insertions(+), 92 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3fac429cf8a4..b0345aa16c01 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -86,88 +86,6 @@ struct async_submit_bio {
 	blk_status_t status;
 };
 
-/*
- * Lockdep class keys for extent_buffer->lock's in this root.  For a given
- * eb, the lockdep key is determined by the btrfs_root it belongs to and
- * the level the eb occupies in the tree.
- *
- * Different roots are used for different purposes and may nest inside each
- * other and they require separate keysets.  As lockdep keys should be
- * static, assign keysets according to the purpose of the root as indicated
- * by btrfs_root->root_key.objectid.  This ensures that all special purpose
- * roots have separate keysets.
- *
- * Lock-nesting across peer nodes is always done with the immediate parent
- * node locked thus preventing deadlock.  As lockdep doesn't know this, use
- * subclass to avoid triggering lockdep warning in such cases.
- *
- * The key is set by the readpage_end_io_hook after the buffer has passed
- * csum validation but before the pages are unlocked.  It is also set by
- * btrfs_init_new_buffer on freshly allocated blocks.
- *
- * We also add a check to make sure the highest level of the tree is the
- * same as our lockdep setup here.  If BTRFS_MAX_LEVEL changes, this code
- * needs update as well.
- */
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# if BTRFS_MAX_LEVEL != 8
-#  error
-# endif
-
-#define DEFINE_LEVEL(stem, level)					\
-	.names[level] = "btrfs-" stem "-0" #level,
-
-#define DEFINE_NAME(stem)						\
-	DEFINE_LEVEL(stem, 0)						\
-	DEFINE_LEVEL(stem, 1)						\
-	DEFINE_LEVEL(stem, 2)						\
-	DEFINE_LEVEL(stem, 3)						\
-	DEFINE_LEVEL(stem, 4)						\
-	DEFINE_LEVEL(stem, 5)						\
-	DEFINE_LEVEL(stem, 6)						\
-	DEFINE_LEVEL(stem, 7)
-
-static struct btrfs_lockdep_keyset {
-	u64			id;		/* root objectid */
-	/* Longest entry: btrfs-free-space-00 */
-	char			names[BTRFS_MAX_LEVEL][20];
-	struct lock_class_key	keys[BTRFS_MAX_LEVEL];
-} btrfs_lockdep_keysets[] = {
-	{ .id = BTRFS_ROOT_TREE_OBJECTID,	DEFINE_NAME("root")	},
-	{ .id = BTRFS_EXTENT_TREE_OBJECTID,	DEFINE_NAME("extent")	},
-	{ .id = BTRFS_CHUNK_TREE_OBJECTID,	DEFINE_NAME("chunk")	},
-	{ .id = BTRFS_DEV_TREE_OBJECTID,	DEFINE_NAME("dev")	},
-	{ .id = BTRFS_CSUM_TREE_OBJECTID,	DEFINE_NAME("csum")	},
-	{ .id = BTRFS_QUOTA_TREE_OBJECTID,	DEFINE_NAME("quota")	},
-	{ .id = BTRFS_TREE_LOG_OBJECTID,	DEFINE_NAME("log")	},
-	{ .id = BTRFS_TREE_RELOC_OBJECTID,	DEFINE_NAME("treloc")	},
-	{ .id = BTRFS_DATA_RELOC_TREE_OBJECTID,	DEFINE_NAME("dreloc")	},
-	{ .id = BTRFS_UUID_TREE_OBJECTID,	DEFINE_NAME("uuid")	},
-	{ .id = BTRFS_FREE_SPACE_TREE_OBJECTID,	DEFINE_NAME("free-space") },
-	{ .id = 0,				DEFINE_NAME("tree")	},
-};
-
-#undef DEFINE_LEVEL
-#undef DEFINE_NAME
-
-void btrfs_set_buffer_lockdep_class(u64 objectid, struct extent_buffer *eb,
-				    int level)
-{
-	struct btrfs_lockdep_keyset *ks;
-
-	BUG_ON(level >= ARRAY_SIZE(ks->keys));
-
-	/* find the matching keyset, id 0 is the default entry */
-	for (ks = btrfs_lockdep_keysets; ks->id; ks++)
-		if (ks->id == objectid)
-			break;
-
-	lockdep_set_class_and_name(&eb->lock,
-				   &ks->keys[level], ks->names[level]);
-}
-
-#endif
-
 /*
  * Compute the csum of a btree block and store the result to provided buffer.
  */
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 8993b428e09c..47ad8e0a2d33 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -137,14 +137,4 @@ int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags);
 int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid);
 int btrfs_init_root_free_objectid(struct btrfs_root *root);
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-void btrfs_set_buffer_lockdep_class(u64 objectid,
-			            struct extent_buffer *eb, int level);
-#else
-static inline void btrfs_set_buffer_lockdep_class(u64 objectid,
-					struct extent_buffer *eb, int level)
-{
-}
-#endif
-
 #endif
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 33461b4f9c8b..a4b671c5e678 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -13,6 +13,88 @@
 #include "extent_io.h"
 #include "locking.h"
 
+/*
+ * Lockdep class keys for extent_buffer->lock's in this root.  For a given
+ * eb, the lockdep key is determined by the btrfs_root it belongs to and
+ * the level the eb occupies in the tree.
+ *
+ * Different roots are used for different purposes and may nest inside each
+ * other and they require separate keysets.  As lockdep keys should be
+ * static, assign keysets according to the purpose of the root as indicated
+ * by btrfs_root->root_key.objectid.  This ensures that all special purpose
+ * roots have separate keysets.
+ *
+ * Lock-nesting across peer nodes is always done with the immediate parent
+ * node locked thus preventing deadlock.  As lockdep doesn't know this, use
+ * subclass to avoid triggering lockdep warning in such cases.
+ *
+ * The key is set by the readpage_end_io_hook after the buffer has passed
+ * csum validation but before the pages are unlocked.  It is also set by
+ * btrfs_init_new_buffer on freshly allocated blocks.
+ *
+ * We also add a check to make sure the highest level of the tree is the
+ * same as our lockdep setup here.  If BTRFS_MAX_LEVEL changes, this code
+ * needs update as well.
+ */
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# if BTRFS_MAX_LEVEL != 8
+#  error
+# endif
+
+#define DEFINE_LEVEL(stem, level)					\
+	.names[level] = "btrfs-" stem "-0" #level,
+
+#define DEFINE_NAME(stem)						\
+	DEFINE_LEVEL(stem, 0)						\
+	DEFINE_LEVEL(stem, 1)						\
+	DEFINE_LEVEL(stem, 2)						\
+	DEFINE_LEVEL(stem, 3)						\
+	DEFINE_LEVEL(stem, 4)						\
+	DEFINE_LEVEL(stem, 5)						\
+	DEFINE_LEVEL(stem, 6)						\
+	DEFINE_LEVEL(stem, 7)
+
+static struct btrfs_lockdep_keyset {
+	u64			id;		/* root objectid */
+	/* Longest entry: btrfs-free-space-00 */
+	char			names[BTRFS_MAX_LEVEL][20];
+	struct lock_class_key	keys[BTRFS_MAX_LEVEL];
+} btrfs_lockdep_keysets[] = {
+	{ .id = BTRFS_ROOT_TREE_OBJECTID,	DEFINE_NAME("root")	},
+	{ .id = BTRFS_EXTENT_TREE_OBJECTID,	DEFINE_NAME("extent")	},
+	{ .id = BTRFS_CHUNK_TREE_OBJECTID,	DEFINE_NAME("chunk")	},
+	{ .id = BTRFS_DEV_TREE_OBJECTID,	DEFINE_NAME("dev")	},
+	{ .id = BTRFS_CSUM_TREE_OBJECTID,	DEFINE_NAME("csum")	},
+	{ .id = BTRFS_QUOTA_TREE_OBJECTID,	DEFINE_NAME("quota")	},
+	{ .id = BTRFS_TREE_LOG_OBJECTID,	DEFINE_NAME("log")	},
+	{ .id = BTRFS_TREE_RELOC_OBJECTID,	DEFINE_NAME("treloc")	},
+	{ .id = BTRFS_DATA_RELOC_TREE_OBJECTID,	DEFINE_NAME("dreloc")	},
+	{ .id = BTRFS_UUID_TREE_OBJECTID,	DEFINE_NAME("uuid")	},
+	{ .id = BTRFS_FREE_SPACE_TREE_OBJECTID,	DEFINE_NAME("free-space") },
+	{ .id = 0,				DEFINE_NAME("tree")	},
+};
+
+#undef DEFINE_LEVEL
+#undef DEFINE_NAME
+
+void btrfs_set_buffer_lockdep_class(u64 objectid, struct extent_buffer *eb,
+				    int level)
+{
+	struct btrfs_lockdep_keyset *ks;
+
+	BUG_ON(level >= ARRAY_SIZE(ks->keys));
+
+	/* find the matching keyset, id 0 is the default entry */
+	for (ks = btrfs_lockdep_keysets; ks->id; ks++)
+		if (ks->id == objectid)
+			break;
+
+	lockdep_set_class_and_name(&eb->lock,
+				   &ks->keys[level], ks->names[level]);
+}
+
+#endif
+
 /*
  * Extent buffer locking
  * =====================
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index bbc45534ae9a..394264bdac3d 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -131,4 +131,14 @@ void btrfs_drew_write_unlock(struct btrfs_drew_lock *lock);
 void btrfs_drew_read_lock(struct btrfs_drew_lock *lock);
 void btrfs_drew_read_unlock(struct btrfs_drew_lock *lock);
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void btrfs_set_buffer_lockdep_class(u64 objectid,
+				    struct extent_buffer *eb, int level);
+#else
+static inline void btrfs_set_buffer_lockdep_class(u64 objectid,
+					struct extent_buffer *eb, int level)
+{
+}
+#endif
+
 #endif
-- 
2.26.3

