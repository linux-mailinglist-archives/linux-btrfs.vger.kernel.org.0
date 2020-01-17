Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 352421412F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgAQV1T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:27:19 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39530 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729219AbgAQV1T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:27:19 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so22914101qtm.6
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uACynp5qlac5/YtcsbMVcpMIHXQb8mk8TKlTvKmS+Jg=;
        b=L2dQ8uMFzGSbDN0XJPUkcrPEY7VAAfjFAIlbTwwbMbMuKUm2Cxx+wJII1K2WXg7Qur
         xGxwij+7pTWX5JvLRRNlkEMQdBZWrEpnjTBGvq9AVwoduEYjtsP70rketu14dM8Zv152
         tZmRSB0Dzce7Mbl2lCiX5Pfq3QYS/I7RtwEc0Ytlko+fN7r5TGH7VVLA86dJsUCv9tpB
         zp/Tcd/H56emhpuNZJwQ0PPXVmzrQwyGfy8v/UnE3c9vX6qJc+/ykgauNCtmBEt2IwNe
         XY1oRcaQ3r5UHP3pdR0ct9xdsN4qUY6pT6DbEFjZgoTGrbqeRp4khe8GC/e7tTuFBD8n
         092w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uACynp5qlac5/YtcsbMVcpMIHXQb8mk8TKlTvKmS+Jg=;
        b=caRyTKNVdg8kk15naNFCco3G0iOb4oSRKcVJIpiXi/Q1q9RvwQVRkf1uZhtffEKHFS
         y6rxjb7JE3TVg4XiEEQdp7DI8ArY38oQbpqvl7ZAv0gJ4x1I/vVSMNEvV7xA5XgSd1Gz
         SbD+1nK1hdzW+Bi8m9GejoOhFT5fDL2hJMmSBN4ScZ21kBtxQpzlRFYpFqQtPDvwbmiN
         zPXmI2qQtHaG0FGkgf43Etn9rvb0ceOLDIARm127wQMYLBjMWW+D6rx4tY2fUdRgPyHt
         SkSZudDi7eQMsWcqxijUj+OTWDA6sAG3uZ/IREFYGYlocxL40/3a1da8HQX/mf33U2bk
         S8qg==
X-Gm-Message-State: APjAAAV8N/Q+YjV2E3W3ezVUZ7wPQe8EoYG3lJRljbaKlj12T+Lbhq2x
        zkOsjz3peI2fzE4pDJiLkTxgD2ixHSYXRg==
X-Google-Smtp-Source: APXvYqwjLYcVfqODw/d/4ls38WOFflbJ8v0tCyRtWxyhoQnueTLzDsy5lpwJOtVj/CCMgKu5ITe5YA==
X-Received: by 2002:ac8:34b4:: with SMTP id w49mr9880278qtb.24.1579296437883;
        Fri, 17 Jan 2020 13:27:17 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i2sm13700358qte.87.2020.01.17.13.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:27:17 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 42/43] btrfs: add a leak check for roots
Date:   Fri, 17 Jan 2020 16:26:01 -0500
Message-Id: <20200117212602.6737-43-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
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
 fs/btrfs/ctree.h             |  5 +++++
 fs/btrfs/disk-io.c           | 28 ++++++++++++++++++++++++++++
 fs/btrfs/disk-io.h           |  9 ++++++++-
 fs/btrfs/tests/btrfs-tests.c |  1 +
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 68510af4cacf..6006e10f371f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -949,6 +949,7 @@ struct btrfs_fs_info {
 #ifdef CONFIG_BTRFS_DEBUG
 	struct kobject *debug_kobj;
 	struct kobject *discard_debug_kobj;
+	struct list_head alloced_roots;
 #endif
 };
 
@@ -1151,6 +1152,10 @@ struct btrfs_root {
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
index 87bad959b1a5..c01cade1a935 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1202,6 +1202,12 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 
 	spin_lock_init(&root->root_item_lock);
 	btrfs_qgroup_init_swapped_blocks(&root->swapped_blocks);
+#ifdef CONFIG_BTRFS_DEBUG
+	INIT_LIST_HEAD(&root->leak_list);
+	spin_lock(&fs_info->fs_roots_radix_lock);
+	list_add_tail(&root->leak_list, &fs_info->alloced_roots);
+	spin_unlock(&fs_info->fs_roots_radix_lock);
+#endif
 }
 
 static struct btrfs_root *btrfs_alloc_root(struct btrfs_fs_info *fs_info,
@@ -1531,6 +1537,24 @@ int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info)
+{
+#ifdef CONFIG_BTRFS_DEBUG
+	struct btrfs_root *root;
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
@@ -1551,6 +1575,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_put_fs_root(fs_info->uuid_root);
 	btrfs_put_fs_root(fs_info->free_space_root);
 	btrfs_put_fs_root(fs_info->fs_root);
+	btrfs_check_leaked_roots(fs_info);
 	kfree(fs_info->super_copy);
 	kfree(fs_info->super_for_commit);
 	kvfree(fs_info);
@@ -2678,6 +2703,9 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
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
index 2414d572bc9a..04a29f961527 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -39,6 +39,7 @@ static inline u64 btrfs_sb_offset(int mirror)
 struct btrfs_device;
 struct btrfs_fs_devices;
 
+void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info);
 void btrfs_init_fs_info(struct btrfs_fs_info *fs_info);
 int btrfs_verify_level_key(struct extent_buffer *eb, int level,
 			   struct btrfs_key *first_key, u64 parent_transid);
@@ -101,8 +102,14 @@ static inline void btrfs_put_fs_root(struct btrfs_root *root)
 {
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
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index 683381a692bc..609abca4fe3a 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -193,6 +193,7 @@ void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_free_fs_roots(fs_info);
 	cleanup_srcu_struct(&fs_info->subvol_srcu);
 	kfree(fs_info->super_copy);
+	btrfs_check_leaked_roots(fs_info);
 	kfree(fs_info->fs_devices);
 	kfree(fs_info);
 }
-- 
2.24.1

