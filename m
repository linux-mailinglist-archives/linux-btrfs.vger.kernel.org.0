Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8EA785AAE
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbjHWOdl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236510AbjHWOdl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:41 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4EBE54
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:39 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59209b12c50so38715437b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801218; x=1693406018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3CVxHJH64G9pSVCR0UXaeIK4fHbECJBYN6AQ3B0iLlE=;
        b=gZ7Aknv0dnHYKRn1Ob1bdcF3glxXvn+K/P6yH/pWYDPQL2wGX3gw7PtH3C5S87x7da
         gWu/FhbWyvQ/S1AqJBlSEvbCSfvFacKPxVkBGWW57eDOytNjA3nBF7UTI6x3pCMu8VFj
         Gt3ix4oMvmd7IT3xu2UBtww/iFhrJEtZUHdL0s72DvT/1Ioy8TjB1LLjk7iqfvoLOwyF
         +pDXrrRQyJvfcTFi0dMZa1X9qRk9cyXqtCgksvna/N10aksXDGeu54K67u3uvqvh5yjU
         NV3xh3YBmlEArdDgC7Ln7F6mzsdhTG7frrxjXXTynN/YA5g8wPQzVNPeZSM/IQjb3fSt
         Bj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801218; x=1693406018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CVxHJH64G9pSVCR0UXaeIK4fHbECJBYN6AQ3B0iLlE=;
        b=PkuEfBWb/PaAn1fhSgzXPKF59LuMn5SqSQltjXENmgE/+0XKG2nV/sI0X8ug7I8vet
         DHDuLLwBVEasX/0BAZOMlvaiYPCsdjdYw+oiYnB4uDHrDkQcuS2hHoztKgnS7gnBzk5m
         KwLsA4EsYHlI90nHxkY2C+b0rDI9LKfrwq/sPUdUOWH3s7Y/vraCLzKOU7f0RixVH9bp
         7MNj1g43Eoog3D0o5RO5G7nUttzDr0Hc6sybHdt9akR56ptbpGD809itEQSaMtfIkGmh
         +r9jFxKsirlMBGM2Js5Z2S9KSgZbVFhUjr6ktuUwS0N4uQMf6TwL6j+/tcPJHjfE64ye
         n8rA==
X-Gm-Message-State: AOJu0Yw3D1zv2UMYoe802dAN+voGgazo+pqskbk23ZKrjUdPjBLCyu8O
        L52SML7Z1jYx/g+gVPl3TKtd1xjjZZwytCnoiro=
X-Google-Smtp-Source: AGHT+IERhZ55LDndzsXxNQeJTJXzoqjhnScpXwRbc7RB6QoF9sPVVvdlYquiPaX55QQFrKwJrl5IJA==
X-Received: by 2002:a81:4783:0:b0:56d:2d82:63dc with SMTP id u125-20020a814783000000b0056d2d8263dcmr12203330ywa.10.1692801218436;
        Wed, 23 Aug 2023 07:33:38 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t12-20020a81c24c000000b005925d7b62e0sm475532ywg.24.2023.08.23.07.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 25/38] btrfs-progs: add kerncompat helpers for ctree.c sync
Date:   Wed, 23 Aug 2023 10:32:51 -0400
Message-ID: <3de4bf57a30d11793cfd46f59d27f03233ff2451.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here are the helpers and stubbed out functions to be able to sync in
ctree.c into btrfs-progs.  These are various utilities the kernel
provides, 1 relocation and qgroup related function, and a trace point we
have in ctree.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/kerncompat.h | 76 ++++++++++++++++++++++++++++++++++++++++++++
 kernel-lib/trace.h   |  6 ++++
 2 files changed, 82 insertions(+)

diff --git a/include/kerncompat.h b/include/kerncompat.h
index 0f73efcd..4ba6b3dc 100644
--- a/include/kerncompat.h
+++ b/include/kerncompat.h
@@ -201,6 +201,10 @@ typedef struct spinlock_struct {
 	unsigned long lock;
 } spinlock_t;
 
+struct rw_semaphore {
+	long lock;
+};
+
 #define mutex_init(m)						\
 do {								\
 	(m)->lock = 1;						\
@@ -243,6 +247,27 @@ static inline void spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
 	spin_unlock(lock);
 }
 
+static inline void init_rwsem(struct rw_semaphore *sem)
+{
+	sem->lock = 0;
+}
+
+static inline bool down_read_trylock(struct rw_semaphore *sem)
+{
+	sem->lock++;
+	return true;
+}
+
+static inline void down_read(struct rw_semaphore *sem)
+{
+	sem->lock++;
+}
+
+static inline void up_read(struct rw_semaphore *sem)
+{
+	sem->lock--;
+}
+
 #define cond_resched()		do { } while (0)
 #define preempt_enable()	do { } while (0)
 #define preempt_disable()	do { } while (0)
@@ -400,6 +425,11 @@ static inline void *kmem_cache_alloc(struct kmem_cache *cache, gfp_t mask)
 	return malloc(cache->size);
 }
 
+static inline void *kmem_cache_zalloc(struct kmem_cache *cache, gfp_t mask)
+{
+	return calloc(1, cache->size);
+}
+
 static inline void kmem_cache_free(struct kmem_cache *cache, void *ptr)
 {
 	free(ptr);
@@ -704,6 +734,10 @@ static inline bool sb_rdonly(struct super_block *sb)
 
 #define unlikely(cond) (cond)
 
+#define rcu_dereference(c) (c)
+
+#define rcu_assign_pointer(p, v) do { (p) = (v); } while (0)
+
 static inline void atomic_set(atomic_t *a, int val)
 {
 	*a = val;
@@ -724,6 +758,15 @@ static inline void atomic_dec(atomic_t *a)
 	(*a)--;
 }
 
+static inline bool atomic_inc_not_zero(atomic_t *a)
+{
+	if (*a) {
+		atomic_inc(a);
+		return true;
+	}
+	return false;
+}
+
 static inline struct workqueue_struct *alloc_workqueue(const char *name,
 						       unsigned long flags,
 						       int max_active, ...)
@@ -766,6 +809,10 @@ static inline void lockdep_set_class(spinlock_t *lock, struct lock_class_key *lc
 {
 }
 
+static inline void lockdep_assert_held_read(struct rw_semaphore *sem)
+{
+}
+
 static inline bool cond_resched_lock(spinlock_t *lock)
 {
 	return false;
@@ -800,11 +847,26 @@ static inline void schedule(void)
 {
 }
 
+static inline void rcu_read_lock(void)
+{
+}
+
+static inline void rcu_read_unlock(void)
+{
+}
+
+static inline void synchronize_rcu(void)
+{
+}
+
 /*
  * Temporary definitions while syncing.
  */
 struct btrfs_inode;
 struct extent_state;
+struct extent_buffer;
+struct btrfs_root;
+struct btrfs_trans_handle;
 
 static inline void btrfs_merge_delalloc_extent(struct btrfs_inode *inode,
 					       struct extent_state *state,
@@ -830,4 +892,18 @@ static inline void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 {
 }
 
+static inline int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
+					struct btrfs_root *root,
+					struct extent_buffer *buf,
+					struct extent_buffer *cow)
+{
+	return 0;
+}
+
+static inline void btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
+							struct btrfs_root *root,
+							struct extent_buffer *buf)
+{
+}
+
 #endif
diff --git a/kernel-lib/trace.h b/kernel-lib/trace.h
index 588429e0..2542f9ea 100644
--- a/kernel-lib/trace.h
+++ b/kernel-lib/trace.h
@@ -57,4 +57,10 @@ static inline void trace_btrfs_convert_extent_bit(struct extent_io_tree *tree,
 {
 }
 
+static inline void trace_btrfs_cow_block(struct btrfs_root *root,
+					 struct extent_buffer *buf,
+					 struct extent_buffer *cow)
+{
+}
+
 #endif /* __PROGS_TRACE_H__ */
-- 
2.41.0

