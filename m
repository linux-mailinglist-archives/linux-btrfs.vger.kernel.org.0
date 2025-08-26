Return-Path: <linux-btrfs+bounces-16380-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E6AB36E31
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0C11BA83EF
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2203B35AAC1;
	Tue, 26 Aug 2025 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ph/qO0ac"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D1A2D322F
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222872; cv=none; b=qF7mpCEXSGGGpTw+Zt5zqD6np91RncNqxr4TUWba3VZ6yDywirkZW+RDL5yaXcXwpDmmlKMhQ9T7eKgeSYWkIZaAWGkUmCEOZrmrD5nKLhOHN5Dq1d3WqVd4pZFoA6NWUVLF17B5NzowIxT63JmephdkX6pyuwQkDRIicqkJEM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222872; c=relaxed/simple;
	bh=K/2E6jJOHKbiBNVw4qyhmvX0VNRB3Q1kRWjPnsEz6Qs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGezhoNuTOnQ+O/PAx4Fw0mE/Af1Wh+cZWmrdKn/ckLamDvoyDff201pr2yyMXLjuik1EMQEFslSvZ7Uv5FZCYxkGGWhEiyA0w4qjPX/etet6smWn0JSkpzaV6qflUsVDDvX0qa0uwpZA42tepAiKwMm4ZNI1TjFeq9e3xv7OwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ph/qO0ac; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d603b674aso39506117b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222868; x=1756827668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3dSZ2phmUuD6/YyE9yBKEL4BgEi76aqZtdAMW8+MgI=;
        b=ph/qO0acgBWtR0/azz/53tjkqOXuLxKzgb0NioNUALqyyHRUPsFAHLE79mtkkMre3p
         2ft+yPLT2YOqMVXLLApoASz3IMWLIHgBAED10sH32GRifaCmBMxJzmL2ng9mjmvIvwdA
         0n+avz75LthEDcBdAAQUML/+/AXMQyzzllpazy5zOyDFduI5jVwPvElu7xs3VOKriuxm
         qjn6wX4D7mnO3xUQOndPMGxM6NE6vGoHD5S/6pLlFR8WobtkFwtX5X9XNchG3oPA5LXc
         /xvr5QN98d/poFgJSh5fUTYXVeagu+GBaoh8PbgcSAay2AF4Sgpw/srYoe7uUcHw0erM
         AB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222868; x=1756827668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3dSZ2phmUuD6/YyE9yBKEL4BgEi76aqZtdAMW8+MgI=;
        b=dMvIuyutKNW0/KWx1Os2VwjHVpXjTmyOFSP5C67CDIL54XjMA7zoi3pC7RidyxcwMQ
         Gs7d6M2kHulJHDOakyfCEM97nWEWXPzNN1Fahyqnje05yqdU50T4NhlfVh2pGNplKLNw
         NfK8SYpxn2LVa801a3kMWFuDeQr5+pDLlYa1S/q/RenahVbTvL5JBrHGHyyWx+FMYrLr
         rqx8CkULVjGym+xTNTgu3UeHuqLKGJ2jCTKEcDRT5XnhQs3jTsxA3nMdgqfir9ELNbwf
         7Qgf8GJenv+fIujkTyTeT8n1gliLPJ5gZwYQbExM534m7zRZ3Dj6zviuTaZu8Hv9NrBb
         +XGA==
X-Forwarded-Encrypted: i=1; AJvYcCUFopLxfLtgqgYRSLVBijKSJGxYPtvbKL7F1nnsi3+1U5JGDye/5PYILHGLhwTqQJtp2Jncxk2HgqWw2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlAYQSg5mzMmcVVdktop8nmBMEdJ4PII1NWo+cNYLf88ngZtF5
	Lkk0+Q/eoSMZZ/jDTneoHnb2hoT5ZA/EfP84ZPhbMTpclWis1YG9isX+j9iFgwy7xhoJiHaw2Rp
	H9sgy
X-Gm-Gg: ASbGnctMHMh9U59LdHwzEl6vQoQYyi3nK86BGdpsVEzbk3oDdCA+0izQs0iUyHiVcxC
	vZSTCewxxSs28cVGG4dyBoX7xqMHaXEL/UQh8zw2B5/GGKnrLjbVRF851zksAC9NC6tR0CD79bk
	6LFnqdukpLW17zG8Ff68nwZnPzq2OU7mw7MOnH7D+3+ZmiBKMFwN5wIuzaBtKM43PzkaEtmswYz
	tIO8humgyjWrk1TxPlws0u+hcHN0JZLfVB4L8XmgXrR8KsUiM5yDU3m950U6y3F61EUwJHd+333
	vHGu+xmGVJwQdijD0SiFbtNCqMksgaKfwWn/q8OmWlMFba1hLiaCCFGQ0ITbC8v4swnULIHYh3O
	1RUBYJ3CDa/yjxH1iiNDA1rZxQNIyo43fpFjpJ4dN7YZTIVvxIn9oIlOmgB8=
X-Google-Smtp-Source: AGHT+IHgXLWIa08EKF5iBQbTPMW+F15MA8jv2gb9313joQGOaaJYJEPu1PArCNZdnFyQDIVStDqfzA==
X-Received: by 2002:a05:690c:c1a:b0:719:4421:70b2 with SMTP id 00721157ae682-71fdc2e0f12mr177717567b3.18.1756222867429;
        Tue, 26 Aug 2025 08:41:07 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff6edd00fsm22874937b3.10.2025.08.26.08.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:06 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 13/54] fs: hold an i_obj_count when we have an i_count reference
Date: Tue, 26 Aug 2025 11:39:13 -0400
Message-ID: <62383d1029eca5053a2fa320ae51f407c9ae2896.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the start of the semantic changes of inode lifetimes.
Unfortunately we have to do two things in one patch to be properly safe,
but this is the only case where this happens.

First we take and drop an i_obj_count reference every time we get an
i_count reference.  This is because we will be changing the i_count
reference to be the indicator of a "live" inode.

The second thing we do is move the life time of the memory allocation
for the inode under the control of the i_obj_count reference.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c   |  4 +++-
 fs/fs-writeback.c  |  2 --
 fs/inode.c         | 28 +++++++++-------------------
 include/linux/fs.h |  1 +
 4 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ac00554e8479..e16df38e0eef 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3418,8 +3418,10 @@ void btrfs_add_delayed_iput(struct btrfs_inode *inode)
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	unsigned long flags;
 
-	if (atomic_add_unless(&inode->vfs_inode.i_count, -1, 1))
+	if (atomic_add_unless(&inode->vfs_inode.i_count, -1, 1)) {
+		iobj_put(&inode->vfs_inode);
 		return;
+	}
 
 	WARN_ON_ONCE(test_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info->fs_state));
 	atomic_inc(&fs_info->nr_delayed_iputs);
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 773b276328ec..b83d556d7ffe 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2736,7 +2736,6 @@ static void wait_sb_inodes(struct super_block *sb)
 			continue;
 		}
 		__iget(inode);
-		iobj_get(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
 
@@ -2750,7 +2749,6 @@ static void wait_sb_inodes(struct super_block *sb)
 		cond_resched();
 
 		iput(inode);
-		iobj_put(inode);
 
 		rcu_read_lock();
 		spin_lock_irq(&sb->s_inode_wblist_lock);
diff --git a/fs/inode.c b/fs/inode.c
index b146b37f7097..ddaf282f7c25 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -527,6 +527,7 @@ static void init_once(void *foo)
  */
 void ihold(struct inode *inode)
 {
+	iobj_get(inode);
 	WARN_ON(atomic_inc_return(&inode->i_count) < 2);
 }
 EXPORT_SYMBOL(ihold);
@@ -843,13 +844,6 @@ static void evict(struct inode *inode)
 	 */
 	inode_wake_up_bit(inode, __I_NEW);
 	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
-
-	/*
-	 * refcount_dec_and_test must be used here to avoid the underflow
-	 * warning.
-	 */
-	WARN_ON(!refcount_dec_and_test(&inode->i_obj_count));
-	destroy_inode(inode);
 }
 
 /*
@@ -867,16 +861,8 @@ static void dispose_list(struct list_head *head)
 		inode = list_first_entry(head, struct inode, i_lru);
 		list_del_init(&inode->i_lru);
 
-		/*
-		 * This is going right here for now only because we are
-		 * currently not using the i_obj_count reference for anything,
-		 * and it needs to hit 0 when we call evict().
-		 *
-		 * This will be moved when we change the lifetime rules in a
-		 * future patch.
-		 */
-		iobj_put(inode);
 		evict(inode);
+		iobj_put(inode);
 		cond_resched();
 	}
 }
@@ -1943,8 +1929,10 @@ void iput(struct inode *inode)
 		return;
 	BUG_ON(inode->i_state & I_CLEAR);
 
-	if (atomic_add_unless(&inode->i_count, -1, 1))
+	if (atomic_add_unless(&inode->i_count, -1, 1)) {
+		iobj_put(inode);
 		return;
+	}
 
 	if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
 		trace_writeback_lazytime_iput(inode);
@@ -1958,6 +1946,7 @@ void iput(struct inode *inode)
 	} else {
 		spin_unlock(&inode->i_lock);
 	}
+	iobj_put(inode);
 }
 EXPORT_SYMBOL(iput);
 
@@ -1965,13 +1954,14 @@ EXPORT_SYMBOL(iput);
  *	iobj_put	- put a object reference on an inode
  *	@inode: inode to put
  *
- *	Puts a object reference on an inode.
+ *	Puts a object reference on an inode, free's it if we get to zero.
  */
 void iobj_put(struct inode *inode)
 {
 	if (!inode)
 		return;
-	refcount_dec(&inode->i_obj_count);
+	if (refcount_dec_and_test(&inode->i_obj_count))
+		destroy_inode(inode);
 }
 EXPORT_SYMBOL(iobj_put);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 84f5218755c3..023ad47685be 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3381,6 +3381,7 @@ static inline unsigned int iobj_count_read(const struct inode *inode)
  */
 static inline void __iget(struct inode *inode)
 {
+	iobj_get(inode);
 	atomic_inc(&inode->i_count);
 }
 
-- 
2.49.0


