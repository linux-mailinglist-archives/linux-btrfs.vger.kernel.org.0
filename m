Return-Path: <linux-btrfs+bounces-16858-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF94EB598BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 16:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDE4E7A776E
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 14:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3C2350D49;
	Tue, 16 Sep 2025 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWGzCbAD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B5D34AB0C
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031194; cv=none; b=Q7kmPawd8J1qqxExkMOECh9ZyAhiHulBDma3NPduTAyTUYQze4GlQBTb8HpsB1jIAE3vwi4z46fG3fKsjxqFK+tirqfzZ2+CA/za2/c9beZjrm/mwlzvrmSid8AToRq1K+FXwWzRqIqR1pdTglxUFTV1QBT15EQ51VWlkSIVzwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031194; c=relaxed/simple;
	bh=67CCxoskkGrnlUlHhCX2YKbkGpmxVzicQpN51RR/ZoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1JPokvMwnP6eOaj9l/ln98fYttAsZ0PupIahLIx3vHHx6PyKPynebG1zfhzfItgNlxhgRkYA0FNezaE6EVYZJlcbNXJodTSOaJUmU7wFyrz/NSX/69aaLUgfPHcxC+xy/x55xunwrz44EpSUXPW8dSjEb9vm5o8Jw6SwCWkNHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWGzCbAD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3eb08d8d9e7so1588010f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758031189; x=1758635989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29JSURtnbb1RZIccpZPbCOQkUUAEjI4J83C/88taCJc=;
        b=GWGzCbADEW3VzjUgNqLj4SAOxmXYChxKAq25VCNCe2AJuoXDONt8UqftEbl9+WmgPd
         y3MPTYzAH1TNoPNuK5R5+sWMewJwRpxU+Rq6V2rwY+AQINbE1dgMVkdS/rNi8GEZl/i3
         EnQoWClY1USpxmh+7xKrheqXmx/LI5sgh4FECMhQcXt201ANOGKBdeZUr+MjBFnziHd6
         V8hZ3q0rm4zkX4fnNDSkn07jVElHgfFRz0O9zhNZqtzYnpioDsnI+FHOILrUZUAxRjOJ
         hy4OT14lx+bu7nGGW8Y5uibHiAaAbHUhvW6WKVzORQkflkY/wWI4IC96w/pyXUSAEDy9
         cQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031189; x=1758635989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29JSURtnbb1RZIccpZPbCOQkUUAEjI4J83C/88taCJc=;
        b=rKad2Hv3+xjjetsN+A0hZqLejbROQ7FLTIUvmumU4f72iJ0jHiFX916PGVyER/rBih
         NXXEdCGnQtusHzto19NsrT7tVGtAbY2xsU4dd4+gH7xDhxwC9yvN+Xxv3eSqokyAY4tG
         sHxs9pUi2z/QE2mE7a8/vqxId7M+6Run7FfayOjeairj9a8zCu4u57dpFIHwOTG6tkpP
         dKpRQW7EnZmLNN7hnQg6SE5+SE1yeLGMiLGUpowI4dny7JoXSOomGP1D4qsypF+6w8Zf
         T1bsq4nuVUvcnrHdNH5+RpCZ4+xXfXj3B4etd28JAVF7THzTUG/hDkXCMNCgSn3qN/FT
         zpVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9L0t58yXN62QeWimx/7GQu9quaJp+pHWUcgEdGIrN0vXGUE8Md4I8Qnwp8CHRg1TqW6eB3CfeSsnYsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDY3B0qYYaSs/aF6Ou3CRRC/qUXewS05rgJ89Feh3xF12cy7a7
	Bcad4HC2ZZ00d5LxqmJ821d9Ca2GUjOyMVuFCoXxdDtaCZfrNazr92oD5fTluRCA
X-Gm-Gg: ASbGncu4zf3fwW86oxJ4Rp1p/H4H6Ko6rxKtFuY24gNe4HBVc9BEsoHKxhz6PL2kKlr
	lB1T7oTqd2gye0lgimhkbFcqLz2szQjzu3WUBiDFPIVAFN6RxFUrkvVMwDf989yJUn7BbOFGdCA
	VZmyUtiOWpVRgaqWJAGgiB1Q/niVDLpS0SmNTn0UuLsZ9Ai143UNdJm8cOG6R7u+Bp2E5XWQ0S+
	5ox/n83myTuQLTUTLh37ao5bU96cYvLN68OaBTkENc4Fu3BikE6K03Cb359EOObrwUrG8WLBgWc
	VuIW5PutobFun4yVYrUs6kiauzBr+L6/Rmm3N2sECMMSJcKvKhsUCD5UgX8RAxAdcLCIgcZVTwN
	sVF4rScCgFkwoW733usE7qnpkV8MJEniK10sP3f7YS2VC52wHSjT22oF+e8Vew8NqiBgy/AdHgC
	bFoX3py3Q=
X-Google-Smtp-Source: AGHT+IHcXAIc1sXbMc5v7hDSGRfrit2oYOb7A0GAgCY3ykOcZbinoBfJfezyLCAk8DhCdfrCgCQQPw==
X-Received: by 2002:a05:6000:2510:b0:3ec:db87:ff53 with SMTP id ffacd0b85a97d-3ecdb8813b6mr1168621f8f.12.1758031188900;
        Tue, 16 Sep 2025 06:59:48 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm16557991f8f.42.2025.09.16.06.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:59:48 -0700 (PDT)
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
Subject: [PATCH v4 07/12] xfs: use the new ->i_state accessors
Date: Tue, 16 Sep 2025 15:58:55 +0200
Message-ID: <20250916135900.2170346-8-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916135900.2170346-1-mjguzik@gmail.com>
References: <20250916135900.2170346-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

cheat sheet:
Suppose flags I_A and I_B are to be handled, then if ->i_lock is held:

state = inode->i_state          => state = inode_state_read(inode)
inode->i_state |= (I_A | I_B)   => inode_state_add(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_del(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_set(inode, I_A | I_B)

If ->i_lock is not held or only held conditionally, add "_once"
suffix for the read routine or "_raw" for the rest:

state = inode->i_state          => state = inode_state_read_once(inode)
inode->i_state |= (I_A | I_B)   => inode_state_add_raw(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_del_raw(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_set_raw(inode, I_A | I_B)

 fs/xfs/scrub/common.c       | 2 +-
 fs/xfs/scrub/inode_repair.c | 2 +-
 fs/xfs/scrub/parent.c       | 2 +-
 fs/xfs/xfs_bmap_util.c      | 2 +-
 fs/xfs/xfs_health.c         | 4 ++--
 fs/xfs/xfs_icache.c         | 6 +++---
 fs/xfs/xfs_inode.c          | 6 +++---
 fs/xfs/xfs_inode_item.c     | 4 ++--
 fs/xfs/xfs_iops.c           | 2 +-
 fs/xfs/xfs_reflink.h        | 2 +-
 10 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index 2ef7742be7d3..e27cfbcfc5c9 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -1249,7 +1249,7 @@ xchk_irele(
 		 * hits do not clear DONTCACHE, so we must do it here.
 		 */
 		spin_lock(&VFS_I(ip)->i_lock);
-		VFS_I(ip)->i_state &= ~I_DONTCACHE;
+		inode_state_del(VFS_I(ip), I_DONTCACHE);
 		spin_unlock(&VFS_I(ip)->i_lock);
 	}
 
diff --git a/fs/xfs/scrub/inode_repair.c b/fs/xfs/scrub/inode_repair.c
index a90a011c7e5f..4f7040c9ddf0 100644
--- a/fs/xfs/scrub/inode_repair.c
+++ b/fs/xfs/scrub/inode_repair.c
@@ -1933,7 +1933,7 @@ xrep_inode_pptr(
 	 * Unlinked inodes that cannot be added to the directory tree will not
 	 * have a parent pointer.
 	 */
-	if (inode->i_nlink == 0 && !(inode->i_state & I_LINKABLE))
+	if (inode->i_nlink == 0 && !(inode_state_read_once(inode) & I_LINKABLE))
 		return 0;
 
 	/* Children of the superblock do not have parent pointers. */
diff --git a/fs/xfs/scrub/parent.c b/fs/xfs/scrub/parent.c
index 3b692c4acc1e..11d5de10fd56 100644
--- a/fs/xfs/scrub/parent.c
+++ b/fs/xfs/scrub/parent.c
@@ -915,7 +915,7 @@ xchk_pptr_looks_zapped(
 	 * Temporary files that cannot be linked into the directory tree do not
 	 * have attr forks because they cannot ever have parents.
 	 */
-	if (inode->i_nlink == 0 && !(inode->i_state & I_LINKABLE))
+	if (inode->i_nlink == 0 && !(inode_state_read_once(inode) & I_LINKABLE))
 		return false;
 
 	/*
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 06ca11731e43..2208a720ec3f 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -514,7 +514,7 @@ xfs_can_free_eofblocks(
 	 * Caller must either hold the exclusive io lock; or be inactivating
 	 * the inode, which guarantees there are no other users of the inode.
 	 */
-	if (!(VFS_I(ip)->i_state & I_FREEING))
+	if (!(inode_state_read_once(VFS_I(ip)) & I_FREEING))
 		xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
 
 	/* prealloc/delalloc exists only on regular files */
diff --git a/fs/xfs/xfs_health.c b/fs/xfs/xfs_health.c
index 7c541fb373d5..c765a28b4556 100644
--- a/fs/xfs/xfs_health.c
+++ b/fs/xfs/xfs_health.c
@@ -285,7 +285,7 @@ xfs_inode_mark_sick(
 	 * is not the case here.
 	 */
 	spin_lock(&VFS_I(ip)->i_lock);
-	VFS_I(ip)->i_state &= ~I_DONTCACHE;
+	inode_state_del(VFS_I(ip), I_DONTCACHE);
 	spin_unlock(&VFS_I(ip)->i_lock);
 }
 
@@ -309,7 +309,7 @@ xfs_inode_mark_corrupt(
 	 * is not the case here.
 	 */
 	spin_lock(&VFS_I(ip)->i_lock);
-	VFS_I(ip)->i_state &= ~I_DONTCACHE;
+	inode_state_del(VFS_I(ip), I_DONTCACHE);
 	spin_unlock(&VFS_I(ip)->i_lock);
 }
 
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 4cf7abe50143..0023bd449573 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -334,7 +334,7 @@ xfs_reinit_inode(
 	dev_t			dev = inode->i_rdev;
 	kuid_t			uid = inode->i_uid;
 	kgid_t			gid = inode->i_gid;
-	unsigned long		state = inode->i_state;
+	unsigned long		state = inode_state_read_once(inode);
 
 	error = inode_init_always(mp->m_super, inode);
 
@@ -345,7 +345,7 @@ xfs_reinit_inode(
 	inode->i_rdev = dev;
 	inode->i_uid = uid;
 	inode->i_gid = gid;
-	inode->i_state = state;
+	inode_state_set_raw(inode, state);
 	mapping_set_folio_min_order(inode->i_mapping,
 				    M_IGEO(mp)->min_folio_order);
 	return error;
@@ -411,7 +411,7 @@ xfs_iget_recycle(
 	ip->i_flags |= XFS_INEW;
 	xfs_perag_clear_inode_tag(pag, XFS_INO_TO_AGINO(mp, ip->i_ino),
 			XFS_ICI_RECLAIM_TAG);
-	inode->i_state = I_NEW;
+	inode_state_set_raw(inode, I_NEW);
 	spin_unlock(&ip->i_flags_lock);
 	spin_unlock(&pag->pag_ici_lock);
 
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index df8eab11dc48..ed141f818e8d 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1569,7 +1569,7 @@ xfs_iunlink_reload_next(
 	next_ip->i_prev_unlinked = prev_agino;
 	trace_xfs_iunlink_reload_next(next_ip);
 rele:
-	ASSERT(!(VFS_I(next_ip)->i_state & I_DONTCACHE));
+	ASSERT(!(inode_state_read_once(VFS_I(next_ip)) & I_DONTCACHE));
 	if (xfs_is_quotacheck_running(mp) && next_ip)
 		xfs_iflags_set(next_ip, XFS_IQUOTAUNCHECKED);
 	xfs_irele(next_ip);
@@ -2093,7 +2093,7 @@ xfs_rename_alloc_whiteout(
 	 */
 	xfs_setup_iops(tmpfile);
 	xfs_finish_inode_setup(tmpfile);
-	VFS_I(tmpfile)->i_state |= I_LINKABLE;
+	inode_state_add_raw(VFS_I(tmpfile), I_LINKABLE);
 
 	*wip = tmpfile;
 	return 0;
@@ -2319,7 +2319,7 @@ xfs_rename(
 		 * flag from the inode so it doesn't accidentally get misused in
 		 * future.
 		 */
-		VFS_I(du_wip.ip)->i_state &= ~I_LINKABLE;
+		inode_state_del_raw(VFS_I(du_wip.ip), I_LINKABLE);
 	}
 
 out_commit:
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index 829675700fcd..a98fb2696d08 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -113,9 +113,9 @@ xfs_inode_item_precommit(
 	 * to log the timestamps, or will clear already cleared fields in the
 	 * worst case.
 	 */
-	if (inode->i_state & I_DIRTY_TIME) {
+	if (inode_state_read_once(inode) & I_DIRTY_TIME) {
 		spin_lock(&inode->i_lock);
-		inode->i_state &= ~I_DIRTY_TIME;
+		inode_state_del(inode, I_DIRTY_TIME);
 		spin_unlock(&inode->i_lock);
 	}
 
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 149b5460fbfd..7a05d0ac7ed8 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1419,7 +1419,7 @@ xfs_setup_inode(
 	bool			is_meta = xfs_is_internal_inode(ip);
 
 	inode->i_ino = ip->i_ino;
-	inode->i_state |= I_NEW;
+	inode_state_add_raw(inode, I_NEW);
 
 	inode_sb_list_add(inode);
 	/* make the inode look hashed for the writeback code */
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 36cda724da89..9d1ed9bb0bee 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -17,7 +17,7 @@ xfs_can_free_cowblocks(struct xfs_inode *ip)
 {
 	struct inode *inode = VFS_I(ip);
 
-	if ((inode->i_state & I_DIRTY_PAGES) ||
+	if ((inode_state_read_once(inode) & I_DIRTY_PAGES) ||
 	    mapping_tagged(inode->i_mapping, PAGECACHE_TAG_DIRTY) ||
 	    mapping_tagged(inode->i_mapping, PAGECACHE_TAG_WRITEBACK) ||
 	    atomic_read(&inode->i_dio_count))
-- 
2.43.0


