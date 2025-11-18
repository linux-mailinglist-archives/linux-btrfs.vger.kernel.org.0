Return-Path: <linux-btrfs+bounces-19091-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFF8C6A7C1
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 17:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE9F74F1424
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 15:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC613369965;
	Tue, 18 Nov 2025 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="RZb1oXGL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79250368287
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481582; cv=none; b=qHIFIUwvcY7rDRQ//reqFNCzF3BXy7ETFC0o+F4nJ72YBsDQiWzN0b2kuUJL8ze+23FvuJTNubKrPNSVW7iBzq9bIZUtHDxn2dv1Jv/WS1JYt4lAv/NTdq/GsOFfK5k/HYgdmx4o0CvApE5fB2SHTyUjh/HB8vuy6mxr8g4t+nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481582; c=relaxed/simple;
	bh=u3fpEPG5iBJoKdioKZTATHNy79AvYYQHUYzg+gw32XQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3/RKo44xGGhvHJwn9S8xD7IYsVR8GDQsrFKtbnbBVTiQ/lg5uGyc6AgGORwFZQ13kjLcn5dO8gUsdOxz0LTElUR30Uu5Rs+4gReeuBGIbIV04Ad/hQ6FUmqq77A1C0xyn5NekhG18hOvDelxLwSq5XpVcZK676Pma7DHM8QPgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=RZb1oXGL; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ed6882991aso49856811cf.1
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 07:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1763481579; x=1764086379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBPodgZsYH1Y2dNIvmJGtHA8RnatwcuIyg3dZCI7TnU=;
        b=RZb1oXGLTlVTKRGO1ETW3o+ZaFGr+67xdo+/1l8qzq7oY/oCNeySKhglkpimwq5OwZ
         13dcuFOoXENC+ae2vCAoqaw1w6sjk1VpVWJhLx+BfhWe0hgk5iZeb5/cK0v82ziS6N7f
         Ww2ESGcQLDDSD52E8vN9BRpkIwyAmLmlJaZAkm7ufKkI19YnxfPYKqFHdUqeHtrGcWd2
         72GpPAwHhXnzClSrUVJf8DJe7zOEZEzx7t/bRbD3fhH+6ZG8Js14emsvLbQaW6pqyTsx
         vzd3bp6gsjCzRDbr2c4aIxxnvUp8GB8svaPKJoRuhLeuFNnkPS/g8yaPwL+3KpBgK5Lu
         8Viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763481579; x=1764086379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mBPodgZsYH1Y2dNIvmJGtHA8RnatwcuIyg3dZCI7TnU=;
        b=stDqD5WM+kqkt+yxqohzbFX/t7c6l1f/CRxB29cXymS1cCltv7QetKPR0CfSbyPodk
         eW8hkIHcb+gC/fMMW0Nz21M4NqhCTsDrXGvDUC/VGT83daXQmCsXE52G8pe3LT/LG3W1
         /TRqjYMziI5a0ygbf8hVTV+hvXlDWlysP623v1hn6/8isw4pVjUrH2ebIfCtNiwbtzwQ
         w0kYh97NhbpgFSADj+KciVJ71w85EBvwUWNkJebtnk2hLIrK5iLJC6BaywhP6NZoDvUf
         I5Q/88HefnguDeT2EcZNlDbwjJV7AKRN1fOmUFClaw8EzTAWeubSRy6KRO/zYgbuLSUM
         JJPQ==
X-Gm-Message-State: AOJu0YzD9s2SSwv2YURUX4UsiVHYI7DNAjZR5QBNTubEAyNh5VnlWcOH
	mF8EF2BBVR+6vIDQDIqmU0sZjoebEKa1juDnFzP/c/WBT9JffjF0uwPgpbB7ZoqrsyZM8v4ULHw
	eACMeup1FpA==
X-Gm-Gg: ASbGncul6/sFGxXFE3tjtazKYuHzOMGTAOmlL/BuPWRsVt1tPRcLo2/tq+mBZNMNxz/
	+svm43Ny/MDTkMYdknbplHA3hqRrmw1AiFfnicY5BA42CCncNFXtJYVL2tRMUrLNR/tgGqvwW2/
	uxaS6II2qVNijrd0oQpcH+1GJhdHKlGzJvto71Dc6LQAvvUbzGwZyYWou7Hk2Is3JOfSDHaED9/
	XmyvDxgbZdX5lgZfEx6IfBZ8JUjBgVS+rchwORwc2uey6cobpdH0C+xhF2AWWkPOSsu3IeH4PyK
	2V3YfoybTOY93egIXaXkerdkPQm4r83FPnucqFIa762DTjz6sl62YJbkm5gaKYYQoiaN5hqBvU5
	/4j5PcNeVqLDLDS2TGl5tABGApPIbIK8KphfaQu8OxtYj71Sfk1LJy/hJQtEs3ljYaOguR43CuB
	ah9fa8jP1rWc5t/lGAtLNsYAA=
X-Google-Smtp-Source: AGHT+IF+CJneKu9LUVb2k9+iskqtdbLi/BtZGZOWyNuXn/PpRXSt06HO5JRJ6vX7Xnw1YkBfV1uwWA==
X-Received: by 2002:ac8:59c1:0:b0:4ee:2721:9ed3 with SMTP id d75a77b69052e-4ee3086d6d5mr38810781cf.26.1763481578896;
        Tue, 18 Nov 2025 07:59:38 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:f528:9f2f:44c:2c84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee0f0d51bdsm65223991cf.15.2025.11.18.07.59.38
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 07:59:38 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix data race on transaction->state
Date: Tue, 18 Nov 2025 10:59:28 -0500
Message-ID: <9db5125d171003458bcf98470f4044c5890fb789.1763481355.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1763481355.git.josef@toxicpanda.com>
References: <cover.1763481355.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Debugging a hang with btrfs on QEMU I discovered a data race with
transaction->state. In wait_current_trans we do

wait_event(fs_info->transaction_wait,
	   cur_trans->state>=TRANS_STATE_UNBLOCKED ||
	   TRANS_ABORTED(cur_trans));

however we're doing this outside of the fs_info->trans_lock. This
generally isn't super problematic because we hit
wake_up(fs_info->transaction_wait) quite a bit, but it could lead to
latencies where we miss wakeups, or in the worst case (like the compiler
re-orders the load of the ->state outside of the wait_event loop) we
could hang completely.

Fix this by using WRITE_ONCE whenever we update trans->state, and use
READ_ONCE everywhere we're not holding fs_info->trans_lock.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c     |  8 ++++----
 fs/btrfs/qgroup.c      |  2 +-
 fs/btrfs/transaction.c | 28 +++++++++++++++-------------
 fs/btrfs/volumes.c     |  3 ++-
 4 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0aa7e5d1b05f..3859d934f658 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4795,17 +4795,17 @@ void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans)
 
 	btrfs_destroy_delayed_refs(cur_trans);
 
-	cur_trans->state = TRANS_STATE_COMMIT_START;
+	WRITE_ONCE(cur_trans->state, TRANS_STATE_COMMIT_START);
 	wake_up(&fs_info->transaction_blocked_wait);
 
-	cur_trans->state = TRANS_STATE_UNBLOCKED;
+	WRITE_ONCE(cur_trans->state, TRANS_STATE_UNBLOCKED);
 	wake_up(&fs_info->transaction_wait);
 
 	btrfs_destroy_marked_extents(fs_info, &cur_trans->dirty_pages,
 				     EXTENT_DIRTY);
 	btrfs_destroy_pinned_extent(fs_info, &cur_trans->pinned_extents);
 
-	cur_trans->state =TRANS_STATE_COMPLETED;
+	WRITE_ONCE(cur_trans->state, TRANS_STATE_COMPLETED);
 	wake_up(&cur_trans->commit_wait);
 }
 
@@ -4828,7 +4828,7 @@ static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)
 			continue;
 		}
 		if (t == fs_info->running_transaction) {
-			t->state = TRANS_STATE_COMMIT_DOING;
+			WRITE_ONCE(t->state, TRANS_STATE_COMMIT_DOING);
 			spin_unlock(&fs_info->trans_lock);
 			/*
 			 * We wait for 0 num_writers since we don't hold a trans
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 1175b8192cd7..658171e96bee 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3094,7 +3094,7 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
 	 * are holding the qgroup_ioctl_lock, otherwise we can race with a quota
 	 * disable operation (ioctl) and access a freed quota root.
 	 */
-	if (trans->transaction->state != TRANS_STATE_COMMIT_DOING)
+	if (READ_ONCE(trans->transaction->state) != TRANS_STATE_COMMIT_DOING)
 		lockdep_assert_held(&fs_info->qgroup_ioctl_lock);
 
 	if (!fs_info->quota_root)
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 89ae0c7a610a..20bacee478d1 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -345,7 +345,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	extwriter_counter_init(cur_trans, type);
 	init_waitqueue_head(&cur_trans->writer_wait);
 	init_waitqueue_head(&cur_trans->commit_wait);
-	cur_trans->state = TRANS_STATE_RUNNING;
+	WRITE_ONCE(cur_trans->state, TRANS_STATE_RUNNING);
 	/*
 	 * One for this trans handle, one so it will live on until we
 	 * commit the transaction.
@@ -509,6 +509,8 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
 
 static inline int is_transaction_blocked(struct btrfs_transaction *trans)
 {
+	lockdep_assert_held(&trans->fs_info->trans_lock);
+
 	return (trans->state >= TRANS_STATE_COMMIT_START &&
 		trans->state < TRANS_STATE_UNBLOCKED &&
 		!TRANS_ABORTED(trans));
@@ -530,7 +532,7 @@ static void wait_current_trans(struct btrfs_fs_info *fs_info)
 
 		btrfs_might_wait_for_state(fs_info, BTRFS_LOCKDEP_TRANS_UNBLOCKED);
 		wait_event(fs_info->transaction_wait,
-			   cur_trans->state >= TRANS_STATE_UNBLOCKED ||
+			   READ_ONCE(cur_trans->state) >= TRANS_STATE_UNBLOCKED ||
 			   TRANS_ABORTED(cur_trans));
 		btrfs_put_transaction(cur_trans);
 	} else {
@@ -726,7 +728,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	btrfs_init_metadata_block_rsv(fs_info, &h->delayed_rsv, BTRFS_BLOCK_RSV_DELOPS);
 
 	smp_mb();
-	if (cur_trans->state >= TRANS_STATE_COMMIT_START &&
+	if (READ_ONCE(cur_trans->state) >= TRANS_STATE_COMMIT_START &&
 	    may_wait_transaction(fs_info, type)) {
 		current->journal_info = h;
 		btrfs_commit_transaction(h);
@@ -912,7 +914,7 @@ static noinline void wait_for_commit(struct btrfs_transaction *commit,
 		btrfs_might_wait_for_state(fs_info, BTRFS_LOCKDEP_TRANS_SUPER_COMMITTED);
 
 	while (1) {
-		wait_event(commit->commit_wait, commit->state >= min_state);
+		wait_event(commit->commit_wait, READ_ONCE(commit->state) >= min_state);
 		if (put)
 			btrfs_put_transaction(commit);
 
@@ -1008,7 +1010,7 @@ bool btrfs_should_end_transaction(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_transaction *cur_trans = trans->transaction;
 
-	if (cur_trans->state >= TRANS_STATE_COMMIT_START ||
+	if (READ_ONCE(cur_trans->state) >= TRANS_STATE_COMMIT_START ||
 	    test_bit(BTRFS_DELAYED_REFS_FLUSHING, &cur_trans->delayed_refs.flags))
 		return true;
 
@@ -1986,7 +1988,7 @@ void btrfs_commit_transaction_async(struct btrfs_trans_handle *trans)
 	 */
 	btrfs_might_wait_for_state(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_PREP);
 	wait_event(fs_info->transaction_blocked_wait,
-		   cur_trans->state >= TRANS_STATE_COMMIT_START ||
+		   READ_ONCE(cur_trans->state) >= TRANS_STATE_COMMIT_START ||
 		   TRANS_ABORTED(cur_trans));
 	btrfs_put_transaction(cur_trans);
 }
@@ -2029,7 +2031,7 @@ static void cleanup_transaction(struct btrfs_trans_handle *trans, int err)
 	BUG_ON(list_empty(&cur_trans->list));
 
 	if (cur_trans == fs_info->running_transaction) {
-		cur_trans->state = TRANS_STATE_COMMIT_DOING;
+		WRITE_ONCE(cur_trans->state, TRANS_STATE_COMMIT_DOING);
 		spin_unlock(&fs_info->trans_lock);
 
 		/*
@@ -2269,7 +2271,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 		return ret;
 	}
 
-	cur_trans->state = TRANS_STATE_COMMIT_PREP;
+	WRITE_ONCE(cur_trans->state, TRANS_STATE_COMMIT_PREP);
 	wake_up(&fs_info->transaction_blocked_wait);
 	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_PREP);
 
@@ -2307,7 +2309,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 		}
 	}
 
-	cur_trans->state = TRANS_STATE_COMMIT_START;
+	WRITE_ONCE(cur_trans->state, TRANS_STATE_COMMIT_START);
 	wake_up(&fs_info->transaction_blocked_wait);
 	spin_unlock(&fs_info->trans_lock);
 
@@ -2362,7 +2364,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	 */
 	spin_lock(&fs_info->trans_lock);
 	add_pending_snapshot(trans);
-	cur_trans->state = TRANS_STATE_COMMIT_DOING;
+	WRITE_ONCE(cur_trans->state, TRANS_STATE_COMMIT_DOING);
 	spin_unlock(&fs_info->trans_lock);
 
 	/*
@@ -2517,7 +2519,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	mutex_lock(&fs_info->tree_log_mutex);
 
 	spin_lock(&fs_info->trans_lock);
-	cur_trans->state = TRANS_STATE_UNBLOCKED;
+	WRITE_ONCE(cur_trans->state, TRANS_STATE_UNBLOCKED);
 	fs_info->running_transaction = NULL;
 	spin_unlock(&fs_info->trans_lock);
 	mutex_unlock(&fs_info->reloc_mutex);
@@ -2552,7 +2554,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	 * We needn't acquire the lock here because there is no other task
 	 * which can change it.
 	 */
-	cur_trans->state = TRANS_STATE_SUPER_COMMITTED;
+	WRITE_ONCE(cur_trans->state, TRANS_STATE_SUPER_COMMITTED);
 	wake_up(&cur_trans->commit_wait);
 	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_SUPER_COMMITTED);
 
@@ -2568,7 +2570,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	 * We needn't acquire the lock here because there is no other task
 	 * which can change it.
 	 */
-	cur_trans->state = TRANS_STATE_COMPLETED;
+	WRITE_ONCE(cur_trans->state, TRANS_STATE_COMPLETED);
 	wake_up(&cur_trans->commit_wait);
 	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_COMPLETED);
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 88065e52184c..aac09223eb5d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7889,7 +7889,8 @@ void btrfs_commit_device_sizes(struct btrfs_transaction *trans)
 {
 	struct btrfs_device *curr, *next;
 
-	ASSERT(trans->state == TRANS_STATE_COMMIT_DOING, "state=%d" , trans->state);
+	ASSERT(READ_ONCE(trans->state) == TRANS_STATE_COMMIT_DOING, "state=%d",
+	       READ_ONCE(trans->state));
 
 	if (list_empty(&trans->dev_update_list))
 		return;
-- 
2.51.1


