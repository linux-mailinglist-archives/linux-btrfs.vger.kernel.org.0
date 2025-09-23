Return-Path: <linux-btrfs+bounces-17118-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBA7B95813
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 12:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F283B0C45
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 10:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3021322A1A;
	Tue, 23 Sep 2025 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMBIXB5P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843FA322552
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624457; cv=none; b=bIWSYFTeBBwf7s/Sp5PAhT/Q3Z8Ozv9mMXzXVy5gigXvMbR49Q4KLQ6KpObFPyh1NSE2pZtZk9EXJCmw8dLXaARHc0gnx4zZZw5SXabyymJRMnflDCVp7HcmL0h49OD1ItkDl68KjMvh95X6c25EAQq7BvOYhyWqu+98qOOHEq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624457; c=relaxed/simple;
	bh=zG3yjnrkl3f9Gbf6hktwdT1azzHO5EGUz8OmVK27v6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAyBVrQTmJsBv+984U0r3UNdmFPtSDuI4FN+tlVl1KTWH9k7gDXSh8mKoHAJ0+UfXOlqv/Gh0V0XC0flZGOqmx2+GunZw7zFU5Tbrpc76O0jn0MaZTDH1kkeoWsKOLAlDU37tt3ikgQwln5qFVV/p4QFzXSDwrerqA7lVtv8iN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMBIXB5P; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e1cc6299cso7295485e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 03:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758624451; x=1759229251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kn2VAGUpv7/Mor8ahWemukeRgSpoWnnMGSO/+qqneC8=;
        b=MMBIXB5Pw+xO2p3qyx9o8nUO597D6vXTnitIUfoZiKrk9fp9R3+QWt5v3/JGkLCno2
         qkR+vYDq2XGFfbgx69fQ6TbXy22x744yxE+6W7yoWDJ/8rC+lK8ldtF+JRL67obKody+
         XSD236WyP6Xqoo2KxMhXIquGjwzktw0STfB/Y8fdJQAtHmr7k0HlN6ci0J7sQfu0WU+z
         3ngikmi3hVdIt2tQo2+v4/IzFZpgC8vvqB0oDe5Vv6+iDrrYfPnubehFO15SCIIFLY2W
         yx1m3fZppnPM1DCM0i20re3X7YGjmJEqclMqHcrGn2qwXl3LPzsD/jOuLSA8OaxKqB+x
         ZO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758624451; x=1759229251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kn2VAGUpv7/Mor8ahWemukeRgSpoWnnMGSO/+qqneC8=;
        b=O+aEKEl5hYaY+Dxa/y+TYsHzgpH6jNClYMFtOFxk8vp2UGrV1JBExQeJWVd4/PqpiN
         6v2yDAcC49C7Tvxx3btIDdB+aWq3/zRkNFb3Y+VKkqfIx6a56qI4EztHSzHyja+Crh1D
         krLtY5bxQNvDghRTGtfYD+TVjTr9wg91AYJqVuM7qpmjjEb01loCJihyZBnvOhf93OsS
         lgh3l7K8Png4osVFMT1OO4GIy7Lf9bt+4WUTzqZon6SjuivJgKs/6ouPo8TNvgECyET5
         eB1H9OQP4TyPT/T8FHuvW3hxA6y90evnKK0WHUAxZQE4ERaV3z64IIqaho9/+QX5C+eK
         mXSA==
X-Forwarded-Encrypted: i=1; AJvYcCVTOxQowjBi2AzOTGRy3j+yjLdjAKUUNJaTtoWcysXq2sXBya25qqFB6L9zyLGuxFYnnlY6YzsD438kpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkOuja7tjlGkvNTv2v4V31QkUson9BPKFn7DdXbV6euu0xd8WG
	TOuk1KBTWtwu5QeZOMzhz3JYLcjreLPb/TWTKYAZUd3TY4GufN6ZJNB0
X-Gm-Gg: ASbGncu4+Nsux00cow37KAy7HnYxmDt9mYeB1sBrYl1FyWAbOZ1JpjwWzk8m0+eWeDC
	XBavMFc1Egj5S5ga28LDObAjaR46KpUPTSz8SlRTTiYZjwlYee3ONwsq3/g7UuzSburs77pXr6n
	KdiP9SY7ovGK3VQTw7Hy4zuarhZpm5c2lfFuJQqXkXZWVBQFHYXvfuGmBpY0NpGsmm+AnMD/ecK
	Nv7a/hrcElsF/EDveMuBy07LTsodDUZDgZLvUCQlZm04X1xs9RHu0U0PeHjAjnjWQ/ojiV1WKKA
	cO5wRo5V7G8iMqoz69mwYNGjouYmPt57NUx6GKD/hklqafDSvc20pDC2kVuH3XOGppGd8VS36S+
	RrgRGRNuvdNMx1SqI9sOmH/I7zcTI3WmDAlM5UvCzCHGBxmKuXx7wdi9VcfnRnHMeA8A+bA==
X-Google-Smtp-Source: AGHT+IHAN3VM8X7DiDdNCdvCyO4HnG9UFF0s9A7HNltSZ8spV2+siSrinpLlvr2NHhUQeYsNJwmpKA==
X-Received: by 2002:a05:600c:c171:b0:46e:1abc:1811 with SMTP id 5b1f17b1804b1-46e1dadca3cmr19717045e9.27.1758624450497;
        Tue, 23 Sep 2025 03:47:30 -0700 (PDT)
Received: from f.. (cst-prg-21-74.cust.vodafone.cz. [46.135.21.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e23adce1bsm9710525e9.24.2025.09.23.03.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 03:47:29 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v6 3/4] Manual conversion of ->i_state uses
Date: Tue, 23 Sep 2025 12:47:09 +0200
Message-ID: <20250923104710.2973493-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923104710.2973493-1-mjguzik@gmail.com>
References: <20250923104710.2973493-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Takes care of spots not converted by coccinelle.

Nothing to look at with one exception: smp_store_release and
smp_load_acquire pair replaced with a manual store/load +
smb_wmb()/smp_rmb(), see I_WB_SWITCH.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 Documentation/filesystems/porting.rst | 2 +-
 fs/bcachefs/fs.c                      | 8 ++++----
 fs/btrfs/inode.c                      | 8 ++++----
 fs/dcache.c                           | 2 +-
 fs/fs-writeback.c                     | 6 +++---
 fs/inode.c                            | 8 ++++----
 fs/ocfs2/inode.c                      | 2 +-
 fs/xfs/xfs_reflink.h                  | 2 +-
 include/linux/backing-dev.h           | 7 ++++---
 include/linux/fs.h                    | 2 +-
 include/linux/writeback.h             | 4 ++--
 include/trace/events/writeback.h      | 8 ++++----
 12 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 85f590254f07..0629611600f1 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -211,7 +211,7 @@ test and set for you.
 e.g.::
 
 	inode = iget_locked(sb, ino);
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read(inode) & I_NEW) {
 		err = read_inode_from_disk(inode);
 		if (err < 0) {
 			iget_failed(inode);
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 687af0eea0c2..8c7efc194ad0 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -347,7 +347,7 @@ static struct bch_inode_info *bch2_inode_hash_find(struct bch_fs *c, struct btre
 			spin_unlock(&inode->v.i_lock);
 			return NULL;
 		}
-		if ((inode->v.i_state & (I_FREEING|I_WILL_FREE))) {
+		if ((inode_state_read(&inode->v) & (I_FREEING|I_WILL_FREE))) {
 			if (!trans) {
 				__wait_on_freeing_inode(c, inode, inum);
 			} else {
@@ -411,7 +411,7 @@ static struct bch_inode_info *bch2_inode_hash_insert(struct bch_fs *c,
 		 * only insert fully created inodes in the inode hash table. But
 		 * discard_new_inode() expects it to be set...
 		 */
-		inode->v.i_state |= I_NEW;
+		inode_state_set(&inode->v, I_NEW);
 		/*
 		 * We don't want bch2_evict_inode() to delete the inode on disk,
 		 * we just raced and had another inode in cache. Normally new
@@ -2224,8 +2224,8 @@ void bch2_evict_subvolume_inodes(struct bch_fs *c, snapshot_id_list *s)
 		if (!snapshot_list_has_id(s, inode->ei_inum.subvol))
 			continue;
 
-		if (!(inode->v.i_state & I_DONTCACHE) &&
-		    !(inode->v.i_state & I_FREEING) &&
+		if (!(inode_state_read(&inode->v) & I_DONTCACHE) &&
+		    !(inode_state_read(&inode->v) & I_FREEING) &&
 		    igrab(&inode->v)) {
 			this_pass_clean = false;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8e2ab3fb9070..d2f7e7c57a36 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3856,7 +3856,7 @@ static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
 		ASSERT(ret != -ENOMEM);
 		return ret;
 	} else if (existing) {
-		WARN_ON(!(existing->vfs_inode.i_state & (I_WILL_FREE | I_FREEING)));
+		WARN_ON(!(inode_state_read(&existing->vfs_inode) & (I_WILL_FREE | I_FREEING)));
 	}
 
 	return 0;
@@ -5745,7 +5745,7 @@ struct btrfs_inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->vfs_inode.i_state & I_NEW))
+	if (!(inode_state_read(&inode->vfs_inode) & I_NEW))
 		return inode;
 
 	ret = btrfs_read_locked_inode(inode, path);
@@ -5769,7 +5769,7 @@ struct btrfs_inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->vfs_inode.i_state & I_NEW))
+	if (!(inode_state_read(&inode->vfs_inode) & I_NEW))
 		return inode;
 
 	path = btrfs_alloc_path();
@@ -7435,7 +7435,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	u64 page_start = folio_pos(folio);
 	u64 page_end = page_start + folio_size(folio) - 1;
 	u64 cur;
-	int inode_evicting = inode->vfs_inode.i_state & I_FREEING;
+	int inode_evicting = inode_state_read(&inode->vfs_inode) & I_FREEING;
 
 	/*
 	 * We have folio locked so no new ordered extent can be created on this
diff --git a/fs/dcache.c b/fs/dcache.c
index 2cb340c52191..bc275f7364db 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1981,7 +1981,7 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
 	spin_lock(&inode->i_lock);
 	__d_instantiate(entry, inode);
 	WARN_ON(!(inode_state_read(inode) & I_NEW));
-	inode->i_state &= ~I_NEW & ~I_CREATING;
+	inode_state_clear(inode, I_NEW | I_CREATING);
 	/*
 	 * Pairs with the barrier in prepare_to_wait_event() to make sure
 	 * ___wait_var_event() either sees the bit cleared or
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index f521ef30d9a4..72424d3314aa 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -475,11 +475,11 @@ static bool inode_do_switch_wbs(struct inode *inode,
 	switched = true;
 skip_switch:
 	/*
-	 * Paired with load_acquire in unlocked_inode_to_wb_begin() and
+	 * Paired with smp_rmb in unlocked_inode_to_wb_begin() and
 	 * ensures that the new wb is visible if they see !I_WB_SWITCH.
 	 */
-	smp_store_release(&inode->i_state,
-			  inode_state_read(inode) & ~I_WB_SWITCH);
+	smp_wmb();
+	inode_state_clear(inode, I_WB_SWITCH);
 
 	xa_unlock_irq(&mapping->i_pages);
 	spin_unlock(&inode->i_lock);
diff --git a/fs/inode.c b/fs/inode.c
index 4b54aba2e939..f9f3476c773b 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -829,7 +829,7 @@ static void evict(struct inode *inode)
 	 * This also means we don't need any fences for the call below.
 	 */
 	inode_wake_up_bit(inode, __I_NEW);
-	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
+	BUG_ON(inode_state_read(inode) != (I_FREEING | I_CLEAR));
 
 	destroy_inode(inode);
 }
@@ -1895,7 +1895,7 @@ static void iput_final(struct inode *inode)
 
 	state = inode_state_read(inode);
 	if (!drop) {
-		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
+		inode_state_set(inode, I_WILL_FREE);
 		spin_unlock(&inode->i_lock);
 
 		write_inode_now(inode, 1);
@@ -1906,7 +1906,7 @@ static void iput_final(struct inode *inode)
 		state &= ~I_WILL_FREE;
 	}
 
-	WRITE_ONCE(inode->i_state, state | I_FREEING);
+	inode_state_assign(inode, state | I_FREEING);
 	if (!list_empty(&inode->i_lru))
 		inode_lru_list_del(inode);
 	spin_unlock(&inode->i_lock);
@@ -2964,7 +2964,7 @@ void dump_inode(struct inode *inode, const char *reason)
 	pr_warn("%s encountered for inode %px\n"
 		"fs %s mode %ho opflags 0x%hx flags 0x%x state 0x%x count %d\n",
 		reason, inode, sb->s_type->name, inode->i_mode, inode->i_opflags,
-		inode->i_flags, inode->i_state, atomic_read(&inode->i_count));
+		inode->i_flags, inode_state_read(inode), atomic_read(&inode->i_count));
 }
 
 EXPORT_SYMBOL(dump_inode);
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 549f9c145dcc..50218209d04d 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -152,7 +152,7 @@ struct inode *ocfs2_iget(struct ocfs2_super *osb, u64 blkno, unsigned flags,
 		mlog_errno(PTR_ERR(inode));
 		goto bail;
 	}
-	trace_ocfs2_iget5_locked(inode->i_state);
+	trace_ocfs2_iget5_locked(inode_state_read(inode));
 	if (inode_state_read(inode) & I_NEW) {
 		rc = ocfs2_read_locked_inode(inode, &args);
 		unlock_new_inode(inode);
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 36cda724da89..86e87e5936b5 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -17,7 +17,7 @@ xfs_can_free_cowblocks(struct xfs_inode *ip)
 {
 	struct inode *inode = VFS_I(ip);
 
-	if ((inode->i_state & I_DIRTY_PAGES) ||
+	if ((inode_state_read(inode) & I_DIRTY_PAGES) ||
 	    mapping_tagged(inode->i_mapping, PAGECACHE_TAG_DIRTY) ||
 	    mapping_tagged(inode->i_mapping, PAGECACHE_TAG_WRITEBACK) ||
 	    atomic_read(&inode->i_dio_count))
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index e721148c95d0..07a60bbbf668 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -289,10 +289,11 @@ unlocked_inode_to_wb_begin(struct inode *inode, struct wb_lock_cookie *cookie)
 	rcu_read_lock();
 
 	/*
-	 * Paired with store_release in inode_switch_wbs_work_fn() and
-	 * ensures that we see the new wb if we see cleared I_WB_SWITCH.
+	 * Paired with smp_wmb in inode_do_switch_wbs() and ensures that we see
+	 * the new wb if we see cleared I_WB_SWITCH.
 	 */
-	cookie->locked = smp_load_acquire(&inode->i_state) & I_WB_SWITCH;
+	cookie->locked = inode_state_read(inode) & I_WB_SWITCH;
+	smp_rmb();
 
 	if (unlikely(cookie->locked))
 		xa_lock_irqsave(&inode->i_mapping->i_pages, cookie->flags);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 06bece8d1f18..73f3ce5add6b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2656,7 +2656,7 @@ static inline int icount_read(const struct inode *inode)
  */
 static inline bool inode_is_dirtytime_only(struct inode *inode)
 {
-	return (inode->i_state & (I_DIRTY_TIME | I_NEW |
+	return (inode_state_read(inode) & (I_DIRTY_TIME | I_NEW |
 				  I_FREEING | I_WILL_FREE)) == I_DIRTY_TIME;
 }
 
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index a2848d731a46..5fcb5ab4fa47 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -193,7 +193,7 @@ void inode_io_list_del(struct inode *inode);
 static inline void wait_on_inode(struct inode *inode)
 {
 	wait_var_event(inode_state_wait_address(inode, __I_NEW),
-		       !(READ_ONCE(inode->i_state) & I_NEW));
+		       !(inode_state_read(inode) & I_NEW));
 }
 
 #ifdef CONFIG_CGROUP_WRITEBACK
@@ -234,7 +234,7 @@ static inline void inode_attach_wb(struct inode *inode, struct folio *folio)
 static inline void inode_detach_wb(struct inode *inode)
 {
 	if (inode->i_wb) {
-		WARN_ON_ONCE(!(inode->i_state & I_CLEAR));
+		WARN_ON_ONCE(!(inode_state_read(inode) & I_CLEAR));
 		wb_put(inode->i_wb);
 		inode->i_wb = NULL;
 	}
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 1e23919c0da9..70c496954473 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -120,7 +120,7 @@ DECLARE_EVENT_CLASS(writeback_dirty_inode_template,
 		/* may be called for files on pseudo FSes w/ unregistered bdi */
 		strscpy_pad(__entry->name, bdi_dev_name(bdi), 32);
 		__entry->ino		= inode->i_ino;
-		__entry->state		= inode->i_state;
+		__entry->state		= inode_state_read(inode);
 		__entry->flags		= flags;
 	),
 
@@ -719,7 +719,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
 		strscpy_pad(__entry->name,
 			    bdi_dev_name(inode_to_bdi(inode)), 32);
 		__entry->ino		= inode->i_ino;
-		__entry->state		= inode->i_state;
+		__entry->state		= inode_state_read(inode);
 		__entry->dirtied_when	= inode->dirtied_when;
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(inode_to_wb(inode));
 	),
@@ -758,7 +758,7 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
 		strscpy_pad(__entry->name,
 			    bdi_dev_name(inode_to_bdi(inode)), 32);
 		__entry->ino		= inode->i_ino;
-		__entry->state		= inode->i_state;
+		__entry->state		= inode_state_read(inode);
 		__entry->dirtied_when	= inode->dirtied_when;
 		__entry->writeback_index = inode->i_mapping->writeback_index;
 		__entry->nr_to_write	= nr_to_write;
@@ -810,7 +810,7 @@ DECLARE_EVENT_CLASS(writeback_inode_template,
 	TP_fast_assign(
 		__entry->dev	= inode->i_sb->s_dev;
 		__entry->ino	= inode->i_ino;
-		__entry->state	= inode->i_state;
+		__entry->state	= inode_state_read(inode);
 		__entry->mode	= inode->i_mode;
 		__entry->dirtied_when = inode->dirtied_when;
 	),
-- 
2.43.0


