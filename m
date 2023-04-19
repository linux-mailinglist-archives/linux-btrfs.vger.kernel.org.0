Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2E06E83AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjDSV0R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjDSV0I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:26:08 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EFE44B9
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:26:01 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id u37so609107qtc.10
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939259; x=1684531259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Irty1JCzmlqfbhk1GjFOZaC956f0imcZUTjycoE/40I=;
        b=BDKQubUyJHfh0npSCFlilZXEHLux5FcXAdOfaXAW46Zvw30czzP9Nx+pS/NeTlkIUZ
         Di4vRWu5kVrMsbyC2ofykfb1YUOii2u/Z3Bhyc7MjltDWM1xkGvfKwd6UuKcHv5YP/df
         omxbg4BH1ab5UvZbRXJb5e9MqfbBK9psfpqtXhyj6DtGjylLCMmU8T2JGv2eQFAaDgrH
         x6UBQKdaMzcEAJTNrEjz+RcL+LqLjJPklvfyTx7a2G9Wmzb5acjz7MICpbfDSlHvRhHj
         nBdQciFZSHgjVC7G9e2gCssNmp/mxY8ksarPwF8n0h61/Mjal08EfEQTgNUSW1+Oljnq
         UY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939259; x=1684531259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Irty1JCzmlqfbhk1GjFOZaC956f0imcZUTjycoE/40I=;
        b=Yi0Sx5p1NhpeQjjutuLej4st9JTxHJLs4ZeprZp5xMGt78urYej2gMQ9N5svjaAqRD
         UFv9PyGxQKPjJz4Q1rPQ80YKs0OvMs3MWJjzLS4mBlboTGLoEOGCkt95C4AKaXsfHBnu
         sZiigew6/VobHvHDwPK2vNqawzU6EnIxQ3aRwsw66+BmbGwDgtEjhJR0pIcz5GDzt+5e
         dCDzr9ZlcFx6TzirW9b276zz0/HVXxnS43Dpz6qCxz5BVmWgaBHRx+D3vi77yVynUDqr
         xb/VjO/Cpp4182DwHgFGV7Gahr5ZRIPLtP+HBACBcj3gWPX5DIQC/NgR4W+TxgVd1oVR
         BM8Q==
X-Gm-Message-State: AAQBX9fnHJh1fnyjJYcm3XqpvcWDrCNu/pVSkYk0aiDPd2+X9m7luLbB
        Mpb+GE32yEz+FIeNhvYARobsTkyDvmW5+/Tg7T1JWg==
X-Google-Smtp-Source: AKy350bqe63FzPzKG7DTsjAIg0UrA6iIC+blAsRWUI4NKZcqEK5dHKvoEP6/AmCkGXzt9uQq/sz4pg==
X-Received: by 2002:ac8:5b8e:0:b0:3ee:4dc1:2c3a with SMTP id a14-20020ac85b8e000000b003ee4dc12c3amr7008991qta.64.1681939259006;
        Wed, 19 Apr 2023 14:20:59 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id r2-20020a05622a034200b003ef42f84532sm35898qtw.49.2023.04.19.14.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:20:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/10] btrfs-progs: sync locking.h and stub out all the helpers
Date:   Wed, 19 Apr 2023 17:20:44 -0400
Message-Id: <8fa8bb3bb91f23cc1c0b567941eecce129499251.1681939107.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681939107.git.josef@toxicpanda.com>
References: <cover.1681939107.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We want locking.h to have all the definitions that get used throughout
the codebase, however we don't want to actually use any of the actual
locking.  This sync's the bulk of locking.h, and then stubs out all of
the definitions.  We need a locking.c for the root lock helpers that
return the extent buffer, but everything else can simply be inlined out.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Makefile                |   1 +
 include/kerncompat.h    |   4 +
 kernel-shared/locking.c |  22 ++++
 kernel-shared/locking.h | 258 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 285 insertions(+)
 create mode 100644 kernel-shared/locking.c
 create mode 100644 kernel-shared/locking.h

diff --git a/Makefile b/Makefile
index 43dfd296..8001f46a 100644
--- a/Makefile
+++ b/Makefile
@@ -182,6 +182,7 @@ objects = \
 	kernel-shared/free-space-tree.o	\
 	kernel-shared/inode-item.o	\
 	kernel-shared/inode.o	\
+	kernel-shared/locking.o	\
 	kernel-shared/messages.o	\
 	kernel-shared/print-tree.o	\
 	kernel-shared/root-tree.o	\
diff --git a/include/kerncompat.h b/include/kerncompat.h
index 68007915..28e9f443 100644
--- a/include/kerncompat.h
+++ b/include/kerncompat.h
@@ -615,6 +615,10 @@ do {									\
 #define smp_mb__before_atomic() do {} while (0)
 #define smp_mb() do {} while (0)
 
+struct percpu_counter {
+	int count;
+};
+
 typedef struct refcount_struct {
 	int refs;
 } refcount_t;
diff --git a/kernel-shared/locking.c b/kernel-shared/locking.c
new file mode 100644
index 00000000..c4138e68
--- /dev/null
+++ b/kernel-shared/locking.c
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2008 Oracle.  All rights reserved.
+ */
+
+#include "ctree.h"
+#include "locking.h"
+
+struct extent_buffer *btrfs_read_lock_root_node(struct btrfs_root *root)
+{
+	return root->node;
+}
+
+struct extent_buffer *btrfs_try_read_lock_root_node(struct btrfs_root *root)
+{
+	return root->node;
+}
+
+struct extent_buffer *btrfs_lock_root_node(struct btrfs_root *root)
+{
+	return root->node;
+}
diff --git a/kernel-shared/locking.h b/kernel-shared/locking.h
new file mode 100644
index 00000000..02c302e4
--- /dev/null
+++ b/kernel-shared/locking.h
@@ -0,0 +1,258 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2008 Oracle.  All rights reserved.
+ */
+
+#ifndef BTRFS_LOCKING_H
+#define BTRFS_LOCKING_H
+
+#include "kerncompat.h"
+
+#define BTRFS_WRITE_LOCK 1
+#define BTRFS_READ_LOCK 2
+
+struct btrfs_root;
+
+/*
+ * We are limited in number of subclasses by MAX_LOCKDEP_SUBCLASSES, which at
+ * the time of this patch is 8, which is how many we use.  Keep this in mind if
+ * you decide you want to add another subclass.
+ */
+enum btrfs_lock_nesting {
+	BTRFS_NESTING_NORMAL,
+
+	/*
+	 * When we COW a block we are holding the lock on the original block,
+	 * and since our lockdep maps are rootid+level, this confuses lockdep
+	 * when we lock the newly allocated COW'd block.  Handle this by having
+	 * a subclass for COW'ed blocks so that lockdep doesn't complain.
+	 */
+	BTRFS_NESTING_COW,
+
+	/*
+	 * Oftentimes we need to lock adjacent nodes on the same level while
+	 * still holding the lock on the original node we searched to, such as
+	 * for searching forward or for split/balance.
+	 *
+	 * Because of this we need to indicate to lockdep that this is
+	 * acceptable by having a different subclass for each of these
+	 * operations.
+	 */
+	BTRFS_NESTING_LEFT,
+	BTRFS_NESTING_RIGHT,
+
+	/*
+	 * When splitting we will be holding a lock on the left/right node when
+	 * we need to cow that node, thus we need a new set of subclasses for
+	 * these two operations.
+	 */
+	BTRFS_NESTING_LEFT_COW,
+	BTRFS_NESTING_RIGHT_COW,
+
+	/*
+	 * When splitting we may push nodes to the left or right, but still use
+	 * the subsequent nodes in our path, keeping our locks on those adjacent
+	 * blocks.  Thus when we go to allocate a new split block we've already
+	 * used up all of our available subclasses, so this subclass exists to
+	 * handle this case where we need to allocate a new split block.
+	 */
+	BTRFS_NESTING_SPLIT,
+
+	/*
+	 * When promoting a new block to a root we need to have a special
+	 * subclass so we don't confuse lockdep, as it will appear that we are
+	 * locking a higher level node before a lower level one.  Copying also
+	 * has this problem as it appears we're locking the same block again
+	 * when we make a snapshot of an existing root.
+	 */
+	BTRFS_NESTING_NEW_ROOT,
+
+	/*
+	 * We are limited to MAX_LOCKDEP_SUBLCLASSES number of subclasses, so
+	 * add this in here and add a static_assert to keep us from going over
+	 * the limit.  As of this writing we're limited to 8, and we're
+	 * definitely using 8, hence this check to keep us from messing up in
+	 * the future.
+	 */
+	BTRFS_NESTING_MAX,
+};
+
+enum btrfs_lockdep_trans_states {
+	BTRFS_LOCKDEP_TRANS_COMMIT_START,
+	BTRFS_LOCKDEP_TRANS_UNBLOCKED,
+	BTRFS_LOCKDEP_TRANS_SUPER_COMMITTED,
+	BTRFS_LOCKDEP_TRANS_COMPLETED,
+};
+
+/*
+ * Lockdep annotation for wait events.
+ *
+ * @owner:  The struct where the lockdep map is defined
+ * @lock:   The lockdep map corresponding to a wait event
+ *
+ * This macro is used to annotate a wait event. In this case a thread acquires
+ * the lockdep map as writer (exclusive lock) because it has to block until all
+ * the threads that hold the lock as readers signal the condition for the wait
+ * event and release their locks.
+ */
+#define btrfs_might_wait_for_event(owner, lock)					\
+	do {									\
+		rwsem_acquire(&owner->lock##_map, 0, 0, _THIS_IP_);		\
+		rwsem_release(&owner->lock##_map, _THIS_IP_);			\
+	} while (0)
+
+/*
+ * Protection for the resource/condition of a wait event.
+ *
+ * @owner:  The struct where the lockdep map is defined
+ * @lock:   The lockdep map corresponding to a wait event
+ *
+ * Many threads can modify the condition for the wait event at the same time
+ * and signal the threads that block on the wait event. The threads that modify
+ * the condition and do the signaling acquire the lock as readers (shared
+ * lock).
+ */
+#define btrfs_lockdep_acquire(owner, lock)					\
+	rwsem_acquire_read(&owner->lock##_map, 0, 0, _THIS_IP_)
+
+/*
+ * Used after signaling the condition for a wait event to release the lockdep
+ * map held by a reader thread.
+ */
+#define btrfs_lockdep_release(owner, lock)					\
+	rwsem_release(&owner->lock##_map, _THIS_IP_)
+
+/*
+ * Macros for the transaction states wait events, similar to the generic wait
+ * event macros.
+ */
+#define btrfs_might_wait_for_state(owner, i)					\
+	do {									\
+		rwsem_acquire(&owner->btrfs_state_change_map[i], 0, 0, _THIS_IP_); \
+		rwsem_release(&owner->btrfs_state_change_map[i], _THIS_IP_);	\
+	} while (0)
+
+#define btrfs_trans_state_lockdep_acquire(owner, i)				\
+	rwsem_acquire_read(&owner->btrfs_state_change_map[i], 0, 0, _THIS_IP_)
+
+#define btrfs_trans_state_lockdep_release(owner, i)				\
+	rwsem_release(&owner->btrfs_state_change_map[i], _THIS_IP_)
+
+/* Initialization of the lockdep map */
+#define btrfs_lockdep_init_map(owner, lock)					\
+	do {									\
+		static struct lock_class_key lock##_key;			\
+		lockdep_init_map(&owner->lock##_map, #lock, &lock##_key, 0);	\
+	} while (0)
+
+/* Initialization of the transaction states lockdep maps. */
+#define btrfs_state_lockdep_init_map(owner, lock, state)			\
+	do {									\
+		static struct lock_class_key lock##_key;			\
+		lockdep_init_map(&owner->btrfs_state_change_map[state], #lock,	\
+				 &lock##_key, 0);				\
+	} while (0)
+
+struct btrfs_path;
+
+static inline void __btrfs_tree_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest)
+{
+}
+
+static inline void btrfs_tree_lock(struct extent_buffer *eb)
+{
+}
+
+static inline void btrfs_tree_unlock(struct extent_buffer *eb)
+{
+}
+
+static inline void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest)
+{
+}
+
+static inline void btrfs_tree_read_lock(struct extent_buffer *eb)
+{
+}
+
+static inline void btrfs_tree_read_unlock(struct extent_buffer *eb)
+{
+}
+
+static inline int btrfs_try_tree_read_lock(struct extent_buffer *eb)
+{
+	return 1;
+}
+
+static inline int btrfs_try_tree_write_lock(struct extent_buffer *eb)
+{
+	return 1;
+}
+
+static inline void btrfs_assert_tree_write_locked(struct extent_buffer *eb) { }
+
+static inline void btrfs_unlock_up_safe(struct btrfs_path *path, int level)
+{
+}
+
+struct extent_buffer *btrfs_read_lock_root_node(struct btrfs_root *root);
+struct extent_buffer *btrfs_try_read_lock_root_node(struct btrfs_root *root);
+struct extent_buffer *btrfs_lock_root_node(struct btrfs_root *root);
+
+static inline void btrfs_tree_unlock_rw(struct extent_buffer *eb, int rw)
+{
+	if (rw == BTRFS_WRITE_LOCK)
+		btrfs_tree_unlock(eb);
+	else if (rw == BTRFS_READ_LOCK)
+		btrfs_tree_read_unlock(eb);
+	else
+		BUG();
+}
+
+struct btrfs_drew_lock {
+	atomic_t readers;
+	struct percpu_counter writers;
+	wait_queue_head_t pending_writers;
+	wait_queue_head_t pending_readers;
+};
+
+static inline int btrfs_drew_lock_init(struct btrfs_drew_lock *lock)
+{
+	return 0;
+}
+
+static inline void btrfs_drew_lock_destroy(struct btrfs_drew_lock *lock)
+{
+}
+
+static inline void btrfs_drew_write_lock(struct btrfs_drew_lock *lock)
+{
+}
+
+static inline bool btrfs_drew_try_write_lock(struct btrfs_drew_lock *lock)
+{
+	return true;
+}
+
+static inline void btrfs_drew_write_unlock(struct btrfs_drew_lock *lock)
+{
+}
+
+static inline void btrfs_drew_read_lock(struct btrfs_drew_lock *lock)
+{
+}
+
+static inline void btrfs_drew_read_unlock(struct btrfs_drew_lock *lock)
+{
+}
+
+static inline void btrfs_set_buffer_lockdep_class(u64 objectid,
+					struct extent_buffer *eb, int level)
+{
+}
+static inline void btrfs_maybe_reset_lockdep_class(struct btrfs_root *root,
+						   struct extent_buffer *eb)
+{
+}
+
+#endif
-- 
2.40.0

