Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACB914896B
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404774AbgAXOeZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:34:25 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46691 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404722AbgAXOeY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:34:24 -0500
Received: by mail-qt1-f193.google.com with SMTP id e25so1610067qtr.13
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qNkIDLz8dmJwsmcSo1YUMF9saa/zRtpXMZgX5nnqA1o=;
        b=q3hYjh5lLQj8jJDLF3M3yBWq4HTpHyR+4OP9Jrv8vYaktB89pxYfX1ZGgqasiHBMZk
         IxsdWAULQe66nDH4SK4AgYx9eXyknBZ3lavAkCjyTzUOzz6oaZb4KHn4A+Un0YZUHj38
         iPkIoaxjbK+180StdBqyb5Vb9eEZrjK9QySnwmBXB2p6eSXxA7hY0VWJjygHRbf8+e6u
         NFK36Raq3EbElPsMxQG880vzo19Cn5l1tj8xW7BO3fgjEUhH8nb1GjR6vECw0ceAox5R
         3vd2TZcKo8RxnCaxVfCDAqRgeGFOwIoMxbQ345hXNjOf243YUwUtlONk/k3sCVp1wtHL
         vtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qNkIDLz8dmJwsmcSo1YUMF9saa/zRtpXMZgX5nnqA1o=;
        b=rCYzIwCOXXbIoHClWfhPeeVTxUbIqo3RI8MV5eeGyGfIemTT1oOlabboBw8xBbR6zh
         xNf7UJC3NQgM0FOt8W1KNJMcOfFbZG9zfmft1QU0Lf2UVXUQgvAtZ/SLaiGtfFz/C1p8
         JNm/ZA/ppCqrwfZwkbsHuYHPZXiHaFQwSm+CEkrFX5Kj1c49Ck4w1cgdjJNWpn2d081e
         Il4pscT9WTmUkwkkM6Pe/0aMf1BD20bslXsJQSeDmq4vzrLo7jJkto2ZrP79Xs+44Pf0
         56oJQSt4z5sCoSk019WQAV3639Jg7H2xKZqtw3QdZernSpq3ZMBcjueWpHIqr9UDuPzk
         B6Ig==
X-Gm-Message-State: APjAAAXM3FP069JNIKM/dHtwhQTksS9sghNicH++rs7Kn9EZbau2+u/u
        zwoEOrj7nXwpr8CeRX7jt6ciyA==
X-Google-Smtp-Source: APXvYqxZx8W6YkGA473S6aZ/Vn5lKAkD+s80bj1KTfB2l5jzPcsILcRMIaG3ToXuIDsephxLtuR0xw==
X-Received: by 2002:ac8:7103:: with SMTP id z3mr2432520qto.172.1579876463664;
        Fri, 24 Jan 2020 06:34:23 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g205sm3193796qke.16.2020.01.24.06.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:34:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 43/44] btrfs: add a leak check for roots
Date:   Fri, 24 Jan 2020 09:33:00 -0500
Message-Id: <20200124143301.2186319-44-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
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
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
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

