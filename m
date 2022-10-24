Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C8F60BA74
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Oct 2022 22:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiJXUh3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 16:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbiJXUgk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 16:36:40 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB20F1C19EF
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 11:48:19 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id r19so6168877qtx.6
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 11:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGy/T4AMKc0XfOeWGua96eFOtXWcYTuKkFcHz60T+5g=;
        b=PG+DDTGlHbc06Ha5eFZW/2U4t8oGN7R+o0gTYRmwQqm2oSgymAnv1SZSGnIc4/FJbY
         bWhM9ArkYJuBv4Fl/hEjRvnyI/rxlp5uBfoRmrIcTdANRFoAa/LbxIpjKjhMrHjhbnPo
         NS88gkNxu+NxPuN1WKFcKSKjNF22fuQ4tReJUISC+tq82gqG4tZ3rC+Swc79FFUVgB7B
         xqX+fmlvlXfetTezrnC9FhTFSOL73cxt3Kle0qXTmGI7P3y1BMdodN8mTDm3VdgzpQyD
         0K3ccWyLR8uf+6dMUzNFwTnkB27bhdhvgB3YvZn0pkX5wAD83oTT9e3AdkiRcvOc//hG
         USwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGy/T4AMKc0XfOeWGua96eFOtXWcYTuKkFcHz60T+5g=;
        b=Zk5RIATLKNS0z5VfdfEkvUxO/bLUvpQvy/NDCRhIDbi1Udy7JQNP2ETZpTUdlXsjFq
         lBlYsHDc2pI7S2jAxdgZSK3/8fUaZZ5JNh9YtyJdNaM7/76vSH9ffIlwD3zWvxU49ElW
         0eEQJbnbPFmv5knN3FnQoxncv6aM6cr8qSxgH9hE0dc8cWK2+BsEXRU1t8cZzlhrxxh2
         XmVJI9zJpyo/nMeHNGIAC7IuE6xJDeB9YVLq7Y0wM2F4sIrmYDrzCXdexYiahVucdrps
         1dsKrLe/+L4r71lgyPPYQpQQ3lKxQlK7WMHMxzcEpCgJ5tfb7/Ip6mpsPxjMGzjI4MLD
         q/gw==
X-Gm-Message-State: ACrzQf1c6kZmvnwClMYRAagnJ/0QYq31+UjOGGW+n0WeBYwsnqMjSGZk
        3f4YvqYdFJv7Op5z6gYlBApnQ4bxxBs8yA==
X-Google-Smtp-Source: AMsMyM4RuRynokK4YbrY+gKSLjq9uJ1SkF8svkrp6S0Pt9QDTONxgIXJyyd0BPbfW4LlFWGS6ajhZA==
X-Received: by 2002:ac8:5d49:0:b0:39c:526f:217d with SMTP id g9-20020ac85d49000000b0039c526f217dmr29022992qtx.543.1666637225798;
        Mon, 24 Oct 2022 11:47:05 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id 3-20020ac85903000000b00399d5d564b7sm373669qty.56.2022.10.24.11.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:47:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/9] btrfs: move the lockdep helpers into locking.h
Date:   Mon, 24 Oct 2022 14:46:53 -0400
Message-Id: <b9918fd6d70153a51c3870381b90b34d3eb026c7.1666637013.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666637013.git.josef@toxicpanda.com>
References: <cover.1666637013.git.josef@toxicpanda.com>
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

These more naturally fit in with the locking related code, and they're
all defines so they can easily go anywhere, move them out of ctree.h
into locking.h

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h   | 76 ----------------------------------------------
 fs/btrfs/locking.h | 76 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 76 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 065137f0920f..df60aa960ce0 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -172,82 +172,6 @@ enum {
 	BTRFS_ROOT_RESET_LOCKDEP_CLASS,
 };
 
-enum btrfs_lockdep_trans_states {
-	BTRFS_LOCKDEP_TRANS_COMMIT_START,
-	BTRFS_LOCKDEP_TRANS_UNBLOCKED,
-	BTRFS_LOCKDEP_TRANS_SUPER_COMMITTED,
-	BTRFS_LOCKDEP_TRANS_COMPLETED,
-};
-
-/*
- * Lockdep annotation for wait events.
- *
- * @owner:  The struct where the lockdep map is defined
- * @lock:   The lockdep map corresponding to a wait event
- *
- * This macro is used to annotate a wait event. In this case a thread acquires
- * the lockdep map as writer (exclusive lock) because it has to block until all
- * the threads that hold the lock as readers signal the condition for the wait
- * event and release their locks.
- */
-#define btrfs_might_wait_for_event(owner, lock)					\
-	do {									\
-		rwsem_acquire(&owner->lock##_map, 0, 0, _THIS_IP_);		\
-		rwsem_release(&owner->lock##_map, _THIS_IP_);			\
-	} while (0)
-
-/*
- * Protection for the resource/condition of a wait event.
- *
- * @owner:  The struct where the lockdep map is defined
- * @lock:   The lockdep map corresponding to a wait event
- *
- * Many threads can modify the condition for the wait event at the same time
- * and signal the threads that block on the wait event. The threads that modify
- * the condition and do the signaling acquire the lock as readers (shared
- * lock).
- */
-#define btrfs_lockdep_acquire(owner, lock)					\
-	rwsem_acquire_read(&owner->lock##_map, 0, 0, _THIS_IP_)
-
-/*
- * Used after signaling the condition for a wait event to release the lockdep
- * map held by a reader thread.
- */
-#define btrfs_lockdep_release(owner, lock)					\
-	rwsem_release(&owner->lock##_map, _THIS_IP_)
-
-/*
- * Macros for the transaction states wait events, similar to the generic wait
- * event macros.
- */
-#define btrfs_might_wait_for_state(owner, i)					\
-	do {									\
-		rwsem_acquire(&owner->btrfs_state_change_map[i], 0, 0, _THIS_IP_); \
-		rwsem_release(&owner->btrfs_state_change_map[i], _THIS_IP_);	\
-	} while (0)
-
-#define btrfs_trans_state_lockdep_acquire(owner, i)				\
-	rwsem_acquire_read(&owner->btrfs_state_change_map[i], 0, 0, _THIS_IP_)
-
-#define btrfs_trans_state_lockdep_release(owner, i)				\
-	rwsem_release(&owner->btrfs_state_change_map[i], _THIS_IP_)
-
-/* Initialization of the lockdep map */
-#define btrfs_lockdep_init_map(owner, lock)					\
-	do {									\
-		static struct lock_class_key lock##_key;			\
-		lockdep_init_map(&owner->lock##_map, #lock, &lock##_key, 0);	\
-	} while (0)
-
-/* Initialization of the transaction states lockdep maps. */
-#define btrfs_state_lockdep_init_map(owner, lock, state)			\
-	do {									\
-		static struct lock_class_key lock##_key;			\
-		lockdep_init_map(&owner->btrfs_state_change_map[state], #lock,	\
-				 &lock##_key, 0);				\
-	} while (0)
-
 /*
  * Record swapped tree blocks of a subvolume tree for delayed subtree trace
  * code. For detail check comment in fs/btrfs/qgroup.c.
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 490c7a79e995..11c2269b4b6f 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -78,6 +78,82 @@ enum btrfs_lock_nesting {
 	BTRFS_NESTING_MAX,
 };
 
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
 static_assert(BTRFS_NESTING_MAX <= MAX_LOCKDEP_SUBCLASSES,
 	      "too many lock subclasses defined");
 
-- 
2.26.3

