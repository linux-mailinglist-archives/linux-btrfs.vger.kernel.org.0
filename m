Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8188612309E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfLQPh7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:59 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37035 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbfLQPh7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:59 -0500
Received: by mail-qv1-f67.google.com with SMTP id f16so2130258qvi.4
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QerJUE/el+KqfGfZ2WVHOkCSSXTLoHCSqdbmeuetiNo=;
        b=1CikNiGBk3xK5SxUWK6eSPNYeJ2uqos8+2lQdaDPd5cCWGUEN1cJA9TsBSNKtYbvzz
         5coOGEIVDhD1oP+IT6l01weXgdJasX0d1W/apyhxWyWVGP0JnVvRpLOg5E/eg3hkndca
         88X4SXmxs0txVvPkZiJ5geF35rNBns34TPKoZ4F+n4ddMZrwb+WhfP2P/ZAVsvV90uR2
         Wi6ga3469kJrSTZDQZX01VzjEvkFmYLaqaOMj+Rzr1VP6jHUEyDwYSuabpHuFClRdY+y
         /JSGdGJ8ZCKmcLQKjnuhSNPRAi7ompzCurBVBI9OopS3v5qZ400RxNrZ3XVYtn9/KKoF
         zWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QerJUE/el+KqfGfZ2WVHOkCSSXTLoHCSqdbmeuetiNo=;
        b=pykgNsYdQQGH36xDCpWQh9u3eEfzzLDgTE15VN4GQ/wMnBdOPJiwwifCrAU7DgAIBd
         lbddJxE3tsZugY5OvPS2eMUKDKVhjV5VQgwittEiCR5iqNgpHo1mrHEx39MxmfPXSJaZ
         bW4gBKTCAiqwSmdVIyoMrGD7zAJ0A8OBtvDKOvEnyQRiVsnQeaJqeW1ysyJGQSn/jJ5Y
         UQBaqv4w2AFpa2Hvm5Zj0bKZ9zHkuqnIQQ2c3hX47DTN5Kogtg/BSM2BdX8MQ10jMzcY
         Olgt5dYGP+s6x3O+5gId+qNiGfAKOshSyxd5I6JP1wvBzJnU8KzOUDSg7Tf9HuBbn+ya
         ju3g==
X-Gm-Message-State: APjAAAVJPMhTErgJPjvl2HqenEDcTqSzStRmClGT04IiKTx1J58go7WM
        DRZK6LFzqZkApgY/CHGXA2Ednj6Pj8V8Ew==
X-Google-Smtp-Source: APXvYqxGjNs953TEeVX5kABwUiEFZ/AnN+Vu0XGl1KBIZYG6vOn02UlDs3xlQUdc4oq4v4JQGuhn8A==
X-Received: by 2002:a0c:91b4:: with SMTP id n49mr5178567qvn.202.1576597077346;
        Tue, 17 Dec 2019 07:37:57 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l6sm8293606qti.10.2019.12.17.07.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 44/45] btrfs: add a leak check for roots
Date:   Tue, 17 Dec 2019 10:36:34 -0500
Message-Id: <20191217153635.44733-45-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
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
 fs/btrfs/ctree.h             |  8 ++++++++
 fs/btrfs/disk-io.c           | 28 ++++++++++++++++++++++++++++
 fs/btrfs/disk-io.h           |  9 ++++++++-
 fs/btrfs/tests/btrfs-tests.c |  1 +
 4 files changed, 45 insertions(+), 1 deletion(-)

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
index 991a6f518c0f..67bd4c91352b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1204,6 +1204,12 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 
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
@@ -1533,6 +1539,24 @@ int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
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
@@ -1553,6 +1577,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_put_fs_root(fs_info->uuid_root);
 	btrfs_put_fs_root(fs_info->free_space_root);
 	btrfs_put_fs_root(fs_info->fs_root);
+	btrfs_check_leaked_roots(fs_info);
 	kfree(fs_info->super_copy);
 	kfree(fs_info->super_for_commit);
 	kvfree(fs_info);
@@ -2675,6 +2700,9 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
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
index 5467227f007d..7b79b92fb768 100644
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
index 2bcef946d92a..8cfcd8ace55c 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -164,6 +164,7 @@ void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_free_fs_roots(fs_info);
 	cleanup_srcu_struct(&fs_info->subvol_srcu);
 	kfree(fs_info->super_copy);
+	btrfs_check_leaked_roots(fs_info);
 	kfree(fs_info->fs_devices);
 	kfree(fs_info);
 }
-- 
2.23.0

