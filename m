Return-Path: <linux-btrfs+bounces-16236-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0978CB306D1
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B32F1D25032
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2F03743EC;
	Thu, 21 Aug 2025 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="wiYjKH8d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF5390965
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807672; cv=none; b=tupnUErQ0hfnG4GEeA+tLIq1zXLeE18j1+Keg0oIuJvSkNzfZY6dOcD9CuSghNN3MOw0VtpaNGrM0IcZZ6KPDVr1SBmpn00hi1mztnJETnpW8BalDRg6uk9Dn+oe8d+AIDVZlUcdInjET3IH4Oqd3QiOUpsSdkp3B2iQUQPp2lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807672; c=relaxed/simple;
	bh=UgBqtpARamUsj1A+LnNOpIJ49vDvjgtBQGImWXuJTMU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKEQiJx7Uebf4s9qZHRoojMkpeI9oFqtcyAeVrdxKX5w57ChHVVDWfkl5D6aKOmc46+j/AC59ahyZk/iyk/9ivO9LGw8OvoQ0Ax50PGKIkLUz3KktXgc41Cr3xNiCNkguUbMetRxnvVZBuDpiLFZBhNiCRjsrpRY+NneVPEwTZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=wiYjKH8d; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d60504bf8so12601377b3.2
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807669; x=1756412469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCzJ83ho866t2cHwyU2sLtn2/A8FHDkq0Lz5CVtgd1c=;
        b=wiYjKH8d6gRcPg1mLVEw8H4GHLLYVrRTJ/orPIf0OJDCcLac+61g1mLGVSYNEkE+mM
         QyHD5Lmku2q+hN7oAB/tiCSN+ZwwUAoMwKNNaeCl/1G/7PbA7XUPJg822T9vU7p9UQbB
         RYBejxwH4oRyCcS5PdaiLJREHn3N2WvgQKWYblfd6hbJ7dHsH1wipFueoVE59wbvlxVH
         KtYbmVju2tV8dLnIxkHEe026o2FcLJ4MlOV4aS0j1qK9WbAF00le1c6Gs/pMDXS2QAVX
         oVN/GhpCxypV2mdpmKUffggNVpjRn2QIz8Uanl5/ggmASVP7NhGSFLN99YOGNDmoN6Ks
         2YUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807669; x=1756412469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCzJ83ho866t2cHwyU2sLtn2/A8FHDkq0Lz5CVtgd1c=;
        b=K7CAXdYLmH6gy8ffyJ4OmiatTMOzJ+Jy4sabXiQ+hu07ksQFBHQjFx1sxyhsjiF6H0
         2MKi561iX76tENsakZZIzJw0nezPt05cbbFH/pScB3XO/vjl6Z1G273GhTvy6ehRxWt9
         A0NzmMOvqQE1gNlu2qv+BWahh07d7iVp5Dicn2VwgaiTbwLkvY6/PxZUgpYpM60yRxTQ
         gldlvMzwAJF+68m2aaV2sKrJYIhIvd7ouHWj7rDPbQwR9ORo3ItCeCK9z5l40OQ6jm9J
         KVM5KdIwUaYCjzTlvUpCzPqmiyUUMMOAP/oUyqCD1KI0R3C0O3I/HiqBblRi/teWjYtE
         8Yug==
X-Forwarded-Encrypted: i=1; AJvYcCWqxx+uC4tGy57vpVk1niBnz7AbUis9Q8z6uDjMAb/6k332+wXfldUoROK+TGtYG8aBpjXDAyB/aegueQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBNinbRMVgqQQaYcvipa5KpzD3/WAjMtMUm4q0w6S/EFQoZvuX
	7vJPzxmsIfAmUPnMEQ2IPqWM65xgfE0HvTPDN+xI3MmfZgRrnSw5kssO6iZQ1ayf/hhM3W2uV+Q
	4X5VIw4RJ9w==
X-Gm-Gg: ASbGncuBpWbh/7V9//xPtGu7sqw53XnO995lOaasFYcQbj/Epjy4NKBLsHcGhMCh9rF
	FHvESZIo8KUUOFlcWWBg7EMpYS3BUB2GFb6XxAKrShk5F2YaASj5t4nUpfTgj622AbEwK7evJSn
	kDja7q/nbz/FeZTm54AXPDJ9TkvuewTTuL554Ah1x1uiRlnopbGxCUQVqtp7gjKOo9wMTp0b0lB
	IvA8Nh+9pd3rkRPhVY1Uvqceas86uFK9t8vLejVaQexins0hqMxW49fl7aNd3uTDAJ1ryLHR7tI
	+Jmnasca+YK7WwXx1ug11lP3lPYmmvI3XUNXwOzahmiOdVO0ahgx5KxjQ0DjCoi294Jlt4OMPpN
	+XttyBFIjgbmXy3tJbmOd1faSWNGSjkxAXOMjBwA9h8KbUk1VuzZpbi5NZPM=
X-Google-Smtp-Source: AGHT+IG+qkt/ad2IRsfhbVTT3k6BgF0uMmUd+EuxlrROjkWL0rHslYOzEPK8vyiJHGYW9H2EdUIDZQ==
X-Received: by 2002:a05:690c:6a05:b0:71a:2d5f:49b4 with SMTP id 00721157ae682-71fdc3d609bmr6895017b3.25.1755807669383;
        Thu, 21 Aug 2025 13:21:09 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e830843e9sm35041497b3.73.2025.08.21.13.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:08 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 35/50] fs: remove I_WILL_FREE|I_FREEING from fs-writeback.c
Date: Thu, 21 Aug 2025 16:18:46 -0400
Message-ID: <4ce42c8d0da7647e98a7dc3b704d19b57e60b71d.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have the reference count to indicate live inodes, we can
remove all of the uses of I_WILL_FREE and I_FREEING in fs-writeback.c
and use the appropriate reference count checks.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fs-writeback.c | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 789c4228412c..0ea6d0e86791 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -129,7 +129,7 @@ static bool inode_io_list_move_locked(struct inode *inode,
 {
 	assert_spin_locked(&wb->list_lock);
 	assert_spin_locked(&inode->i_lock);
-	WARN_ON_ONCE(inode->i_state & I_FREEING);
+	WARN_ON_ONCE(!refcount_read(&inode->i_count));
 
 	if (list_empty(&inode->i_io_list))
 		iobj_get(inode);
@@ -314,7 +314,7 @@ static void inode_cgwb_move_to_attached(struct inode *inode,
 {
 	assert_spin_locked(&wb->list_lock);
 	assert_spin_locked(&inode->i_lock);
-	WARN_ON_ONCE(inode->i_state & I_FREEING);
+	WARN_ON_ONCE(!refcount_read(&inode->i_count));
 
 	inode->i_state &= ~I_SYNC_QUEUED;
 	if (wb != &wb->bdi->wb)
@@ -415,10 +415,10 @@ static bool inode_do_switch_wbs(struct inode *inode,
 	xa_lock_irq(&mapping->i_pages);
 
 	/*
-	 * Once I_FREEING or I_WILL_FREE are visible under i_lock, the eviction
-	 * path owns the inode and we shouldn't modify ->i_io_list.
+	 * Once the refcount is 0, the eviction path owns the inode and we
+	 * shouldn't modify ->i_io_list.
 	 */
-	if (unlikely(inode->i_state & (I_FREEING | I_WILL_FREE)))
+	if (unlikely(!refcount_read(&inode->i_count)))
 		goto skip_switch;
 
 	trace_inode_switch_wbs(inode, old_wb, new_wb);
@@ -570,13 +570,16 @@ static bool inode_prepare_wbs_switch(struct inode *inode,
 	/* while holding I_WB_SWITCH, no one else can update the association */
 	spin_lock(&inode->i_lock);
 	if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
-	    inode->i_state & (I_WB_SWITCH | I_FREEING | I_WILL_FREE) ||
+	    inode->i_state & I_WB_SWITCH ||
 	    inode_to_wb(inode) == new_wb) {
 		spin_unlock(&inode->i_lock);
 		return false;
 	}
+	if (!inode_tryget(inode)) {
+		spin_unlock(&inode->i_lock);
+		return false;
+	}
 	inode->i_state |= I_WB_SWITCH;
-	__iget(inode);
 	spin_unlock(&inode->i_lock);
 
 	return true;
@@ -1207,7 +1210,7 @@ static void inode_cgwb_move_to_attached(struct inode *inode,
 {
 	assert_spin_locked(&wb->list_lock);
 	assert_spin_locked(&inode->i_lock);
-	WARN_ON_ONCE(inode->i_state & I_FREEING);
+	WARN_ON_ONCE(!refcount_read(&inode->i_count));
 
 	inode->i_state &= ~I_SYNC_QUEUED;
 	inode_delete_from_io_list(inode);
@@ -1405,7 +1408,7 @@ static void redirty_tail_locked(struct inode *inode, struct bdi_writeback *wb)
 	 * tracking. Flush worker will ignore this inode anyway and it will
 	 * trigger assertions in inode_io_list_move_locked().
 	 */
-	if (inode->i_state & I_FREEING) {
+	if (!refcount_read(&inode->i_count)) {
 		inode_delete_from_io_list(inode);
 		wb_io_lists_depopulated(wb);
 		return;
@@ -1621,7 +1624,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 			  struct writeback_control *wbc,
 			  unsigned long dirtied_before)
 {
-	if (inode->i_state & I_FREEING)
+	if (!refcount_read(&inode->i_count))
 		return;
 
 	/*
@@ -1787,7 +1790,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
  * whether it is a data-integrity sync (%WB_SYNC_ALL) or not (%WB_SYNC_NONE).
  *
  * To prevent the inode from going away, either the caller must have a reference
- * to the inode, or the inode must have I_WILL_FREE or I_FREEING set.
+ * to the inode, or the inode must have a zero refcount.
  */
 static int writeback_single_inode(struct inode *inode,
 				  struct writeback_control *wbc)
@@ -1797,9 +1800,7 @@ static int writeback_single_inode(struct inode *inode,
 
 	spin_lock(&inode->i_lock);
 	if (!refcount_read(&inode->i_count))
-		WARN_ON(!(inode->i_state & (I_WILL_FREE|I_FREEING)));
-	else
-		WARN_ON(inode->i_state & I_WILL_FREE);
+		WARN_ON(inode->i_state & I_NEW);
 
 	if (inode->i_state & I_SYNC) {
 		/*
@@ -1837,7 +1838,7 @@ static int writeback_single_inode(struct inode *inode,
 	 * If the inode is freeing, its i_io_list shoudn't be updated
 	 * as it can be finally deleted at this moment.
 	 */
-	if (!(inode->i_state & I_FREEING)) {
+	if (refcount_read(&inode->i_count)) {
 		/*
 		 * If the inode is now fully clean, then it can be safely
 		 * removed from its writeback list (if any). Otherwise the
@@ -1957,7 +1958,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 		 * kind writeout is handled by the freer.
 		 */
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
+		if ((inode->i_state & I_NEW) || !refcount_read(&inode->i_count)) {
 			redirty_tail_locked(inode, wb);
 			spin_unlock(&inode->i_lock);
 			continue;
@@ -2615,7 +2616,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			if (inode_unhashed(inode))
 				goto out_unlock;
 		}
-		if (inode->i_state & I_FREEING)
+		if (!refcount_read(&inode->i_count))
 			goto out_unlock;
 
 		/*
@@ -2729,13 +2730,17 @@ static void wait_sb_inodes(struct super_block *sb)
 		spin_unlock_irq(&sb->s_inode_wblist_lock);
 
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) {
+		if (inode->i_state & I_NEW) {
+			spin_unlock(&inode->i_lock);
+			spin_lock_irq(&sb->s_inode_wblist_lock);
+			continue;
+		}
+
+		if (!inode_tryget(inode)) {
 			spin_unlock(&inode->i_lock);
-
 			spin_lock_irq(&sb->s_inode_wblist_lock);
 			continue;
 		}
-		__iget(inode);
 
 		/*
 		 * We could have potentially ended up on the cached LRU list, so
@@ -2886,7 +2891,7 @@ EXPORT_SYMBOL(sync_inodes_sb);
  * This function commits an inode to disk immediately if it is dirty. This is
  * primarily needed by knfsd.
  *
- * The caller must either have a ref on the inode or must have set I_WILL_FREE.
+ * The caller must either have a ref on the inode or the inode must have a zero refcount.
  */
 int write_inode_now(struct inode *inode, int sync)
 {
-- 
2.49.0


