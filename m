Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C579115393
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfLFOq6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:58 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45901 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfLFOq5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:57 -0500
Received: by mail-qk1-f195.google.com with SMTP id x1so6612586qkl.12
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=myP/GpgOhhc7A0D+0UMbyEYBq7kM0czy8uStOeX9pzU=;
        b=p+MJtZDii4F7d9WebPTbzGwtc2ocHstDJqCNgm6iiUYedJ17Wfv4zyXdKH96IlsPUc
         wIMWYRxhBDIddkEn6XRAeTZ25a5BjBHN1aCV8YXgDvFwlm4IgEogjPvf4l21B7TRtWPT
         BZpwmNlBXTnoTI9CqCzwJoqgZSQXh0XYZjKiKUNkSatZ6iikoB3+eqtdcSZ3c3FiDKsN
         7HC3hya9KZJV4h+YMPoK7GnzqvWY5V9mxMBW4TmX8vYng/F3yDoEKgIgXNNNeJsKqy4r
         ff4h3uSfq/LCMp4N9sSnHaVgLrsyHg1FTTjIrnANfSkOWQ0nervljEOkhUEnZ7LFVnvx
         perw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=myP/GpgOhhc7A0D+0UMbyEYBq7kM0czy8uStOeX9pzU=;
        b=KWAVCEwj/bT9hMeBonXiPS8SdIvrtxxmszxshS7vMwrH0tX9XCrCNfigGV+mbLVtsu
         84qzGX0mXQVtPu9pkjyVAHzHXmRJRjQuF0g+8a+GPtREdndguqEKhLU53gR57QaLWZBE
         n6ix9qORRMc2+6nYgO4p0rCM5x6h74kvSdLVZcn/07dazkTiDLtLtIeKOmqGlfWvjfHp
         XoWtxZHCpMZYHx+MWy/4vwtjREb7Hlxf658LX0EZrD8Q0r/YHenV730bbz2NL239vwE6
         4MZ1D6EQcO6983IMOTJz9kPExNyJJws64G6M0gEPIxLk8Ix8L3NA+Cb3nA282hNwWXv/
         25pw==
X-Gm-Message-State: APjAAAV23NarbekbdsqIBYrnp78W1m1JcAQ6zvhjuui+gjYRqzoUCudb
        ttsACiqvCQo6u/nhL2QXNTkk8qyClnxnVw==
X-Google-Smtp-Source: APXvYqzFCa/ziGbN4kY/IsEo1msow92Y7kJmMwwtRzgoHUJtCeBO3LDAEko6ZIqdJ/Vc4S3GBZI/dw==
X-Received: by 2002:a37:8504:: with SMTP id h4mr14231218qkd.276.1575643615814;
        Fri, 06 Dec 2019 06:46:55 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a185sm710994qkg.68.2019.12.06.06.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:55 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 43/44] btrfs: add a leak check for roots
Date:   Fri,  6 Dec 2019 09:45:37 -0500
Message-Id: <20191206144538.168112-44-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we're going to start relying on getting ref counting right for
roots, add a list to track allocated roots and print out any roots that
aren't free'd up at free_fs_info time.  Hide this behind
CONFIG_BTRFS_DEBUG because this will just be used for developers to
verify they aren't breaking things.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h   |  8 ++++++++
 fs/btrfs/disk-io.c | 38 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/disk-io.h |  8 +++++++-
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8578c65890b2..59d7e55c94d8 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -902,6 +902,10 @@ struct btrfs_fs_info {
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
 #endif
+
+#ifdef CONFIG_BTRFS_DEBUG
+	struct list_head alloced_roots;
+#endif
 };
 
 static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
@@ -1103,6 +1107,10 @@ struct btrfs_root {
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 	u64 alloc_bytenr;
 #endif
+
+#ifdef CONFIG_BTRFS_DEBUG
+	struct list_head leak_list;
+#endif
 };
 
 struct btrfs_clone_extent_info {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6151c828a311..143519aea1d0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1204,6 +1204,14 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 
 	spin_lock_init(&root->root_item_lock);
 	btrfs_qgroup_init_swapped_blocks(&root->swapped_blocks);
+#ifdef CONFIG_BTRFS_DEBUG
+	INIT_LIST_HEAD(&root->leak_list);
+	if (!dummy) {
+		spin_lock(&fs_info->fs_roots_radix_lock);
+		list_add_tail(&root->leak_list, &fs_info->alloced_roots);
+		spin_unlock(&fs_info->fs_roots_radix_lock);
+	}
+#endif
 }
 
 static struct btrfs_root *btrfs_alloc_root(struct btrfs_fs_info *fs_info,
@@ -1434,6 +1442,7 @@ struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 		goto find_fail;
 	}
 	root->commit_root = btrfs_root_node(root);
+
 out:
 	btrfs_free_path(path);
 	return root;
@@ -1533,6 +1542,31 @@ int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+static void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info)
+{
+#ifdef CONFIG_BTRFS_DEBUG
+	struct btrfs_root *root;
+
+	/*
+	 * If we didn't get to open_ctree our alloced_roots won't be init'ed, so
+	 * do this check just in case.
+	 */
+	if (fs_info->alloced_roots.next == NULL)
+		return;
+
+	while (!list_empty(&fs_info->alloced_roots)) {
+		root = list_first_entry(&fs_info->alloced_roots,
+					struct btrfs_root, leak_list);
+		btrfs_err(fs_info, "leaked root %llu-%llu refcount %d",
+			  root->root_key.objectid, root->root_key.offset,
+			  refcount_read(&root->refs));
+		while (refcount_read(&root->refs) > 1)
+			btrfs_put_fs_root(root);
+		btrfs_put_fs_root(root);
+	}
+#endif
+}
+
 void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 {
 	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
@@ -1553,6 +1587,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_put_fs_root(fs_info->uuid_root);
 	btrfs_put_fs_root(fs_info->free_space_root);
 	btrfs_put_fs_root(fs_info->fs_root);
+	btrfs_check_leaked_roots(fs_info);
 	kfree(fs_info->super_copy);
 	kfree(fs_info->super_for_commit);
 	kvfree(fs_info);
@@ -2680,6 +2715,9 @@ static int init_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
 	INIT_LIST_HEAD(&fs_info->space_info);
 	INIT_LIST_HEAD(&fs_info->tree_mod_seq_list);
 	INIT_LIST_HEAD(&fs_info->unused_bgs);
+#ifdef CONFIG_BTRFS_DEBUG
+	INIT_LIST_HEAD(&fs_info->alloced_roots);
+#endif
 	extent_map_tree_init(&fs_info->mapping_tree);
 	btrfs_init_block_rsv(&fs_info->global_block_rsv,
 			     BTRFS_BLOCK_RSV_GLOBAL);
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 8fa0c8748db9..3178849ee82d 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -99,8 +99,14 @@ static inline void btrfs_put_fs_root(struct btrfs_root *root)
 	if (!root)
 		return;
 
-	if (refcount_dec_and_test(&root->refs))
+	if (refcount_dec_and_test(&root->refs)) {
+#ifdef CONFIG_BTRFS_DEBUG
+		spin_lock(&root->fs_info->fs_roots_radix_lock);
+		list_del_init(&root->leak_list);
+		spin_unlock(&root->fs_info->fs_roots_radix_lock);
+#endif
 		kfree(root);
+	}
 }
 
 void btrfs_mark_buffer_dirty(struct extent_buffer *buf);
-- 
2.23.0

