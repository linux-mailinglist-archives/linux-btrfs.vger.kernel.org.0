Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8729015F872
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 22:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387421AbgBNVLx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 16:11:53 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44731 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbgBNVLw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 16:11:52 -0500
Received: by mail-qt1-f194.google.com with SMTP id k7so7901757qth.11
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2020 13:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tac0hod1HpnKVWQlgE9yuLlNWX1oam4cvdgdevUB4Rs=;
        b=elmF7fy6dtXFl58ME/lcLhtsoIFB7aXDIBVyUv65jlKgYJcTi1q3amdrFCVBZI3GRh
         HZWqzOyDNwUA9ImiSeff4oKSGi1ZeaDuyEUV3X1gYnFsdc6nKLSUtwjJQsLuY4ZjeIAG
         ahpYZ8JlRF0QoqAwBKtbDsbBhnZ2K5gXSGC258qauycNNuWfl4M6JYUjhIr+yN3wYZQO
         1P9xSvbAWlUw9EA45e6a3lMvbR61zbUocn5JoOfWjqoqMt27eC9hDCZqwhgb6Bcx7k5D
         +vkJ2zpstFiEL0Je7Ulf+/U5yJ2Z6J1rSEa+IAYvVvNo0B4zqy4FhquHlZCO8jg57YqI
         ViWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tac0hod1HpnKVWQlgE9yuLlNWX1oam4cvdgdevUB4Rs=;
        b=TnlLxbN6qjdUftIDCkWrL9siB1d1aTX6nUEscfjHY9xRZrhz1TW/Gz9IFkVcJm6V+a
         ojMiDc7HAcbjuM5Lz9elKqYV3pCjfbZu3BFzsHbRH1A+VfumfePSTrjTs0CV7m+LnltE
         Hdx9S9W0nGHtTyGpf7m6Ni64qxfG7WTzrCIfh/xKk7mKROEMq0hdVv7Bwid5qLmeaEQZ
         Vwr2TnVAbAlimAkBHOVFDOFgerQCJl13oN2W+kcKlqdJnN3M1ltZCwVsCVQIjrtwQ25P
         3Bbdlfx8Eo9WghfcniWFqdD3Ty/780WitLS+Nddw2tndRvIpGVwWH1tz1o2TVSna0xXx
         1cbw==
X-Gm-Message-State: APjAAAX8x2wc8x/JadGrydpqJbYu1x2iYTx+U1fL0z/71rtLVpytGXJX
        P/UUvHnDQKidgaGReAAQqDXaToFyPHE=
X-Google-Smtp-Source: APXvYqx3IsgjGG2WfbdRqPRYneuO1YJFufZ+bSFKqMPbokYpPooq/I5Y3Z+L+krDcf3x3vXiIyH7qQ==
X-Received: by 2002:ac8:67d2:: with SMTP id r18mr4229960qtp.34.1581714711490;
        Fri, 14 Feb 2020 13:11:51 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c21sm364957qkj.130.2020.02.14.13.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:11:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/8] btrfs: make the extent buffer leak check per fs info
Date:   Fri, 14 Feb 2020 16:11:40 -0500
Message-Id: <20200214211147.24610-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214211147.24610-1-josef@toxicpanda.com>
References: <20200214211147.24610-1-josef@toxicpanda.com>
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
index ffd99c3f64db..000ad54629e3 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -948,6 +948,9 @@ struct btrfs_fs_info {
 	struct kobject *debug_kobj;
 	struct kobject *discard_debug_kobj;
 	struct list_head allocated_roots;
+
+	spinlock_t eb_leak_lock;
+	struct list_head alloced_ebs;
 #endif
 };
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 018681ec159b..2a237aecc6d7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1574,6 +1574,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
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
 	INIT_LIST_HEAD(&fs_info->allocated_roots);
+	INIT_LIST_HEAD(&fs_info->alloced_ebs);
+	spin_lock_init(&fs_info->eb_leak_lock);
 #endif
 	extent_map_tree_init(&fs_info->mapping_tree);
 	btrfs_init_block_rsv(&fs_info->global_block_rsv,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6f9638350470..e82e3817e811 100644
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
@@ -245,8 +247,6 @@ void __cold extent_state_cache_exit(void)
 
 void __cold extent_io_exit(void)
 {
-	btrfs_extent_buffer_leak_debug_check();
-
 	/*
 	 * Make sure all delayed rcu free are flushed before we
 	 * destroy caches.
@@ -324,7 +324,7 @@ static struct extent_state *alloc_extent_state(gfp_t mask)
 	state->state = 0;
 	state->failrec = NULL;
 	RB_CLEAR_NODE(&state->rb_node);
-	btrfs_leak_debug_add(&state->leak_list, &states);
+	btrfs_leak_debug_add(&leak_lock, &state->leak_list, &states);
 	refcount_set(&state->refs, 1);
 	init_waitqueue_head(&state->wq);
 	trace_alloc_extent_state(state, mask, _RET_IP_);
@@ -337,7 +337,7 @@ void free_extent_state(struct extent_state *state)
 		return;
 	if (refcount_dec_and_test(&state->refs)) {
 		WARN_ON(extent_state_in_tree(state));
-		btrfs_leak_debug_del(&state->leak_list);
+		btrfs_leak_debug_del(&leak_lock, &state->leak_list);
 		trace_free_extent_state(state, _RET_IP_);
 		kmem_cache_free(extent_state_cache, state);
 	}
@@ -4795,7 +4795,7 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 static void __free_extent_buffer(struct extent_buffer *eb)
 {
-	btrfs_leak_debug_del(&eb->leak_list);
+	btrfs_leak_debug_del(&eb->fs_info->eb_leak_lock, &eb->leak_list);
 	kmem_cache_free(extent_buffer_cache, eb);
 }
 
@@ -4882,7 +4882,8 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 	init_waitqueue_head(&eb->write_lock_wq);
 	init_waitqueue_head(&eb->read_lock_wq);
 
-	btrfs_leak_debug_add(&eb->leak_list, &buffers);
+	btrfs_leak_debug_add(&fs_info->eb_leak_lock, &eb->leak_list,
+			     &fs_info->alloced_ebs);
 
 	spin_lock_init(&eb->refs_lock);
 	atomic_set(&eb->refs, 1);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 234622101230..2ed65bd0760e 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -325,4 +325,11 @@ bool find_lock_delalloc_range(struct inode *inode,
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
2.24.1

