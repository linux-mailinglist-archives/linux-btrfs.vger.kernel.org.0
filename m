Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00A64140B89
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgAQNtO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:49:14 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42887 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgAQNtN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:49:13 -0500
Received: by mail-qk1-f196.google.com with SMTP id z14so22687083qkg.9
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uACynp5qlac5/YtcsbMVcpMIHXQb8mk8TKlTvKmS+Jg=;
        b=lVUSuwdcnH5a+SJOfITBmZDxrmq3bVXEuHlToRVi5hp2xOI+LaT0OlmgqyVHKC9M2m
         Vp8XaZXGFZswExOROxp0hmftT16xA+LCjZCIX5XgWI3uaLOGZCVF35hPzQLPFwOx0kQT
         1gAqwJSFDJJkTwKIXQX4XWhpaFRR9xiJDlgrwsW5Vqkosbb7hI/sTg7gQ1F1a8UG+JUu
         8gjk4MbjGLXoVjVMoTj7vavfaGGI27SykxuyxFYnWrnijqgtOW+c+W+F2nHf7SIvK5f6
         YFkPV7h1mvNhIP5Ilv0/QkAPeVSQcXOfy49ymfn3J1wnUYruJJua2d7L4HlwR+tjbZBy
         wc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uACynp5qlac5/YtcsbMVcpMIHXQb8mk8TKlTvKmS+Jg=;
        b=BLUA9PeDCm9eTFSoNneIdQ9rUN1lAT8q/2r0ulQ4lmC3qgxb71tcyPICmLIGnMu2u7
         7ZziEQc8egMRJqW4HId+5htxLncrm1XVt1Pm8C070eDew8tUtzxlR8W8/djDKEo4LIKD
         VuZuXbi86k2MKKvA4MzhxFbgv5fjY16giyIF6yl/3xM8P0WRKoZ/XS6hbglU2fULMut9
         65lif2YqhZmfUkX5hGxn9wEzq6a0emSDxxRcMhYoErJr+cS1Uj5v9/OLtEm8Z2nbY42Z
         yFOP/BU5qiKdXNKXSJY4DmaV/rw8G2w9cqkZ7CT/tdkZBCkGVzuCHoIIXx5yIAzkJdI6
         2aLw==
X-Gm-Message-State: APjAAAUehGw1qCgSoc1X2x+SqOAsc0v/3y1J+602OlqfPN3wCDcRWUpk
        KNf4KEVgAYPkLSbI705OSPK7bGwxbNcYvg==
X-Google-Smtp-Source: APXvYqx5aQXaeORnuKZQH1c3pTwfFbFcKFqHhcAofp4heVDGVfXvu8HKauN71ID3l/czRd6AxaTikw==
X-Received: by 2002:a37:b93:: with SMTP id 141mr37431358qkl.54.1579268952118;
        Fri, 17 Jan 2020 05:49:12 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l6sm12922336qti.10.2020.01.17.05.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:49:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 42/43] btrfs: add a leak check for roots
Date:   Fri, 17 Jan 2020 08:47:57 -0500
Message-Id: <20200117134758.41494-43-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
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

