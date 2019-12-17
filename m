Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A57041230B2
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfLQPoL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:44:11 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35181 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbfLQPoK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:44:10 -0500
Received: by mail-qt1-f196.google.com with SMTP id e12so3951455qto.2
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZBqz90KVB2kaXnUMgte1GYvat5/1tok3BoCrzscXnKU=;
        b=KwEyUYdsOjbPNHQmpp/ni8qdtht4mkGQ+joWlN1Z3fesSHBrIG+J5WGy6hAydq6wZQ
         bF7Eq5abLhE0uj4FpwoHYygIkCBx3sY4Tbb3iTk23UM30aFJZa2bdNOEs+JQlkrkWDqO
         h6ISg6/j1N8nmxeGsNAVlHibZah/BhSqpKysP3X0n0hPzcHvX5R4yWMShr3q7tGfo349
         d9Ec7yl2Pk6d0ORyxv4OAg26Yhw2J9PUDrgg+W7W42an2oQzEUiGNwP0ohVFBG5hjD3L
         5Vetf2pbRO5Y4n+7hb7K1Dhkhn+asmtl6ESvwVYEowpEjBa0fgoGRMWFmd8Czc9K22Q6
         5trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZBqz90KVB2kaXnUMgte1GYvat5/1tok3BoCrzscXnKU=;
        b=bLZF0OWDLmhknAYxiaajCucytswXr33N+YPCMKb4CkfnYTwWYgtxa/kpPPElLV0FSK
         xzGDSGeWUFBSBc2xTy7r1MPRP2rl4qYRN8hxz80uk1R7Rs4pAtSVO7Yi3LT82GoHGM0r
         IIvlzHsasEchbFCnYByt3gqvR/sTWQ/KMJN8CDIaghMluT6l7xV8Xu3c/5IDFH1GnbzO
         mOOnx1/vlwHLYs7sKe6oQ6TRSar4gY3J2KB9YTBwB8RxYal7+lJql5lDownqWnJDZIi4
         cejLtjF7Cix8glhsGiWmnSVRH/t/XvYi9pT3Ig08iXXhujku0/bzsqSlwvboDE2m41ig
         JRPw==
X-Gm-Message-State: APjAAAV9YwcEn0xae8kNo81i60paWlYf2gG2LcFc5516ppTEPP9Xtf8i
        Bo7k5Vsc4JXKdb03DKrt2lz5pwCS5GqcMw==
X-Google-Smtp-Source: APXvYqyAvQeNuxm9Ghgtm4D8101pvFWPjsmlXtiLE0yy0nGiLk8pjxhkxYKFwa1Kpb+j3rUER3TrbA==
X-Received: by 2002:ac8:768e:: with SMTP id g14mr2340513qtr.147.1576597449068;
        Tue, 17 Dec 2019 07:44:09 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c7sm8112104qtj.91.2019.12.17.07.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:44:08 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/7] btrfs: make the extent buffer leak check per fs info
Date:   Tue, 17 Dec 2019 10:43:58 -0500
Message-Id: <20191217154404.44831-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217154404.44831-1-josef@toxicpanda.com>
References: <20191217154404.44831-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm going to make the entire destruction of btrfs_root's controlled by
their refcount, so it will be helpful to notice if we're leaking their
eb's on umount.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h     |  3 +++
 fs/btrfs/disk-io.c   |  3 +++
 fs/btrfs/extent_io.c | 45 ++++++++++++++++++++++----------------------
 fs/btrfs/extent_io.h |  7 +++++++
 4 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 59d7e55c94d8..fb92c35edadb 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -905,6 +905,9 @@ struct btrfs_fs_info {
 
 #ifdef CONFIG_BTRFS_DEBUG
 	struct list_head alloced_roots;
+
+	spinlock_t eb_leak_lock;
+	struct list_head alloced_ebs;
 #endif
 };
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c1c8851a7b6a..3ab285f7ce84 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1578,6 +1578,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_put_root(fs_info->free_space_root);
 	btrfs_put_root(fs_info->fs_root);
 	btrfs_check_leaked_roots(fs_info);
+	btrfs_extent_buffer_leak_debug_check(fs_info);
 	kfree(fs_info->super_copy);
 	kfree(fs_info->super_for_commit);
 	kvfree(fs_info);
@@ -2702,6 +2703,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	INIT_LIST_HEAD(&fs_info->unused_bgs);
 #ifdef CONFIG_BTRFS_DEBUG
 	INIT_LIST_HEAD(&fs_info->alloced_roots);
+	INIT_LIST_HEAD(&fs_info->alloced_ebs);
+	spin_lock_init(&fs_info->eb_leak_lock);
 #endif
 	extent_map_tree_init(&fs_info->mapping_tree);
 	btrfs_init_block_rsv(&fs_info->global_block_rsv,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ceb3c028894e..3057d4934206 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -35,42 +35,45 @@ static inline bool extent_state_in_tree(const struct extent_state *state)
 }
 
 #ifdef CONFIG_BTRFS_DEBUG
-static LIST_HEAD(buffers);
 static LIST_HEAD(states);
-
 static DEFINE_SPINLOCK(leak_lock);
 
-static inline
-void btrfs_leak_debug_add(struct list_head *new, struct list_head *head)
+static inline void btrfs_leak_debug_add(spinlock_t *lock,
+					struct list_head *new,
+					struct list_head *head)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&leak_lock, flags);
+	spin_lock_irqsave(lock, flags);
 	list_add(new, head);
-	spin_unlock_irqrestore(&leak_lock, flags);
+	spin_unlock_irqrestore(lock, flags);
 }
 
-static inline
-void btrfs_leak_debug_del(struct list_head *entry)
+static inline void btrfs_leak_debug_del(spinlock_t *lock,
+					struct list_head *entry)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&leak_lock, flags);
+	spin_lock_irqsave(lock, flags);
 	list_del(entry);
-	spin_unlock_irqrestore(&leak_lock, flags);
+	spin_unlock_irqrestore(lock, flags);
 }
 
-static inline void btrfs_extent_buffer_leak_debug_check(void)
+void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
 {
 	struct extent_buffer *eb;
+	unsigned long flags;
 
-	while (!list_empty(&buffers)) {
-		eb = list_entry(buffers.next, struct extent_buffer, leak_list);
+	spin_lock_irqsave(&fs_info->eb_leak_lock, flags);
+	while (!list_empty(&fs_info->alloced_ebs)) {
+		eb = list_first_entry(&fs_info->alloced_ebs,
+				      struct extent_buffer, leak_list);
 		pr_err("BTRFS: buffer leak start %llu len %lu refs %d bflags %lu\n",
 		       eb->start, eb->len, atomic_read(&eb->refs), eb->bflags);
 		list_del(&eb->leak_list);
 		kmem_cache_free(extent_buffer_cache, eb);
 	}
+	spin_unlock_irqrestore(&fs_info->eb_leak_lock, flags);
 }
 
 static inline void btrfs_extent_state_leak_debug_check(void)
@@ -107,9 +110,8 @@ static inline void __btrfs_debug_check_extent_io_range(const char *caller,
 	}
 }
 #else
-#define btrfs_leak_debug_add(new, head)	do {} while (0)
-#define btrfs_leak_debug_del(entry)	do {} while (0)
-#define btrfs_extent_buffer_leak_debug_check()	do {} while (0)
+#define btrfs_leak_debug_add(lock, new, head)	do {} while (0)
+#define btrfs_leak_debug_del(lock, entry)	do {} while (0)
 #define btrfs_extent_state_leak_debug_check()	do {} while (0)
 #define btrfs_debug_check_extent_io_range(c, s, e)	do {} while (0)
 #endif
@@ -246,8 +248,6 @@ void __cold extent_state_cache_exit(void)
 
 void __cold extent_io_exit(void)
 {
-	btrfs_extent_buffer_leak_debug_check();
-
 	/*
 	 * Make sure all delayed rcu free are flushed before we
 	 * destroy caches.
@@ -314,7 +314,7 @@ static struct extent_state *alloc_extent_state(gfp_t mask)
 	state->state = 0;
 	state->failrec = NULL;
 	RB_CLEAR_NODE(&state->rb_node);
-	btrfs_leak_debug_add(&state->leak_list, &states);
+	btrfs_leak_debug_add(&leak_lock, &state->leak_list, &states);
 	refcount_set(&state->refs, 1);
 	init_waitqueue_head(&state->wq);
 	trace_alloc_extent_state(state, mask, _RET_IP_);
@@ -327,7 +327,7 @@ void free_extent_state(struct extent_state *state)
 		return;
 	if (refcount_dec_and_test(&state->refs)) {
 		WARN_ON(extent_state_in_tree(state));
-		btrfs_leak_debug_del(&state->leak_list);
+		btrfs_leak_debug_del(&leak_lock, &state->leak_list);
 		trace_free_extent_state(state, _RET_IP_);
 		kmem_cache_free(extent_state_cache, state);
 	}
@@ -4806,7 +4806,7 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 static void __free_extent_buffer(struct extent_buffer *eb)
 {
-	btrfs_leak_debug_del(&eb->leak_list);
+	btrfs_leak_debug_del(&eb->fs_info->eb_leak_lock, &eb->leak_list);
 	kmem_cache_free(extent_buffer_cache, eb);
 }
 
@@ -4893,7 +4893,8 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 	init_waitqueue_head(&eb->write_lock_wq);
 	init_waitqueue_head(&eb->read_lock_wq);
 
-	btrfs_leak_debug_add(&eb->leak_list, &buffers);
+	btrfs_leak_debug_add(&fs_info->eb_leak_lock, &eb->leak_list,
+			     &fs_info->alloced_ebs);
 
 	spin_lock_init(&eb->refs_lock);
 	atomic_set(&eb->refs, 1);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index a8551a1f56e2..054f98e60a90 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -327,4 +327,11 @@ bool find_lock_delalloc_range(struct inode *inode,
 #endif
 struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 					       u64 start);
+
+#ifdef CONFIG_BTRFS_DEBUG
+void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info);
+#else
+#define btrfs_extent_buffer_leak_debug_check(fs_info)	do {} while (0)
+#endif
+
 #endif
-- 
2.23.0

