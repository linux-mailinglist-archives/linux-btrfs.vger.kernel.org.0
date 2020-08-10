Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673F9240AA3
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 17:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgHJPnD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 11:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgHJPnB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 11:43:01 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38325C061756
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:43:01 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id w2so4405695qvh.12
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bUNTmAgM6HC1cxl+HfSnJ9+16s2LLx4bdGju/rW5d40=;
        b=bSD441Tn2q5vTITt8Mwfl8M2Sp0qxp8Om76T0Ny+CfSbo8N2+BCT2hRAGCFbyo9usV
         40VYrpU9znLZBF10L6m8vEK7II3KTWQ2sSTyPjC95FVkFlULufL4UXf3HLb6tr8WRrl+
         CRSVoUYRTzAwx6B0k9RWiiSTlXTPet3gGxQ8jZcyqng9KsJBdP3VxkzNSEAscbdB35XL
         VrQYfYAGuFpZDEECdvn1oqD53/6rMDNHj25HbOLyF/dxL/KwT5ET7DO8LLSzITSHXp95
         DF3oGl51LFxT5eJTt5+hfxCy6qOtXe/73jY4nEqBgFtQ1UFCV4nI3Ukk+jM8FMryBPOO
         ZNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bUNTmAgM6HC1cxl+HfSnJ9+16s2LLx4bdGju/rW5d40=;
        b=aLXVZE8hJMcryCLJoyKKXT4ZRT06eLAy2IfdmI/cYqfs2TIPE6fNNegRUIGySjHfeB
         KM8t6x/eY9PNxbeyFUHfswOQu9lmmZF3R/nxnwRVGlfjJHFvFVWEqzN/qTx9F1/x0Oaz
         FBd9DhyUO+cyQH13VrAmF1d/4NOZZjCUN0Q5x5osLvSYcyfWPzLzORka71WWkDQeA9Es
         YOtJ79sWgBhP9g7v8q78WLgTAr+Y6Jg4IVVyCcpwq+7TJcLW64/v7Sp5cx+xDuJJITso
         24ZBoXrUsl7gUyfretNrsWOtu1AHHTc3OG2lrXq0q+8bzmT/h5584lEWLH4KYbHYsEJn
         Xe3w==
X-Gm-Message-State: AOAM531o82Cb/enCoyz/65HWAA2MJRNhF41pHU+a5wkEZmhb6FmMZRbG
        iaI7XD1WMBPrM65sM6tO+1vUfwH9yS4PNA==
X-Google-Smtp-Source: ABdhPJyFVN+E3DMkPx9L6Or7+NL8lFcgHqcm+TRnuWvI0s9q4E0D5uY1bPR+BD8JOqIfnUEQfnULlg==
X-Received: by 2002:a0c:bd8d:: with SMTP id n13mr28656020qvg.199.1597074179379;
        Mon, 10 Aug 2020 08:42:59 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m30sm17340147qtm.46.2020.08.10.08.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 08:42:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/17] btrfs: rename eb->lock_nested to eb->lock_recursed
Date:   Mon, 10 Aug 2020 11:42:32 -0400
Message-Id: <20200810154242.782802-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200810154242.782802-1-josef@toxicpanda.com>
References: <20200810154242.782802-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Nested locking with lockdep and everything else refers to lock hierarchy
within the same lock map.  This is how we indicate the same locks for
different objects are ok to take in a specific order, for our use case
that would be to take the lock on a leaf and then take a lock on an
adjacent leaf.

What ->lock_nested _actually_ refers to is if we happen to already be
holding the write lock on the extent buffer and we're allowing a read
lock to be taken on that extent buffer, which is recursion.  Rename this
so we don't get confused when we switch to a rwsem and have to start
using the _nested helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c |  2 +-
 fs/btrfs/extent_io.h |  2 +-
 fs/btrfs/locking.c   | 22 +++++++++++-----------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c15ab6c1897f..16b4e7655a96 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4988,7 +4988,7 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 	rwlock_init(&eb->lock);
 	atomic_set(&eb->blocking_readers, 0);
 	eb->blocking_writers = 0;
-	eb->lock_nested = false;
+	eb->lock_recursed = false;
 	init_waitqueue_head(&eb->write_lock_wq);
 	init_waitqueue_head(&eb->read_lock_wq);
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 30794ae58498..9e1e22f1586a 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -102,7 +102,7 @@ struct extent_buffer {
 
 	int blocking_writers;
 	atomic_t blocking_readers;
-	bool lock_nested;
+	bool lock_recursed;
 	/* >= 0 if eb belongs to a log tree, -1 otherwise */
 	short log_index;
 
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index f75612e18a82..8e3d107a6192 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -57,7 +57,7 @@
  * performance reasons.
  *
  *
- * Lock nesting
+ * Lock recursion
  * ------------
  *
  * A write operation on a tree might indirectly start a look up on the same
@@ -201,7 +201,7 @@ void btrfs_set_lock_blocking_read(struct extent_buffer *eb)
 	 * lock, but it won't change to or away from us.  If we have the write
 	 * lock, we are the owner and it'll never change.
 	 */
-	if (eb->lock_nested && current->pid == eb->lock_owner)
+	if (eb->lock_recursed && current->pid == eb->lock_owner)
 		return;
 	btrfs_assert_tree_read_locked(eb);
 	atomic_inc(&eb->blocking_readers);
@@ -225,7 +225,7 @@ void btrfs_set_lock_blocking_write(struct extent_buffer *eb)
 	 * lock, but it won't change to or away from us.  If we have the write
 	 * lock, we are the owner and it'll never change.
 	 */
-	if (eb->lock_nested && current->pid == eb->lock_owner)
+	if (eb->lock_recursed && current->pid == eb->lock_owner)
 		return;
 	if (eb->blocking_writers == 0) {
 		btrfs_assert_spinning_writers_put(eb);
@@ -263,8 +263,8 @@ void btrfs_tree_read_lock(struct extent_buffer *eb)
 			 * depends on this as it may be called on a partly
 			 * (write-)locked tree.
 			 */
-			BUG_ON(eb->lock_nested);
-			eb->lock_nested = true;
+			BUG_ON(eb->lock_recursed);
+			eb->lock_recursed = true;
 			read_unlock(&eb->lock);
 			trace_btrfs_tree_read_lock(eb, start_ns);
 			return;
@@ -362,11 +362,11 @@ void btrfs_tree_read_unlock(struct extent_buffer *eb)
 	/*
 	 * if we're nested, we have the write lock.  No new locking
 	 * is needed as long as we are the lock owner.
-	 * The write unlock will do a barrier for us, and the lock_nested
+	 * The write unlock will do a barrier for us, and the lock_recursed
 	 * field only matters to the lock owner.
 	 */
-	if (eb->lock_nested && current->pid == eb->lock_owner) {
-		eb->lock_nested = false;
+	if (eb->lock_recursed && current->pid == eb->lock_owner) {
+		eb->lock_recursed = false;
 		return;
 	}
 	btrfs_assert_tree_read_locked(eb);
@@ -388,11 +388,11 @@ void btrfs_tree_read_unlock_blocking(struct extent_buffer *eb)
 	/*
 	 * if we're nested, we have the write lock.  No new locking
 	 * is needed as long as we are the lock owner.
-	 * The write unlock will do a barrier for us, and the lock_nested
+	 * The write unlock will do a barrier for us, and the lock_recursed
 	 * field only matters to the lock owner.
 	 */
-	if (eb->lock_nested && current->pid == eb->lock_owner) {
-		eb->lock_nested = false;
+	if (eb->lock_recursed && current->pid == eb->lock_owner) {
+		eb->lock_recursed = false;
 		return;
 	}
 	btrfs_assert_tree_read_locked(eb);
-- 
2.24.1

