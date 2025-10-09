Return-Path: <linux-btrfs+bounces-17564-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 385EFBC7DDE
	for <lists+linux-btrfs@lfdr.de>; Thu, 09 Oct 2025 10:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B1248351EC5
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Oct 2025 08:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5972B2DC344;
	Thu,  9 Oct 2025 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndcKtsZO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDDD2D640A
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996793; cv=none; b=ceNBr1XaV5piOWFScHniz+qym8eRs34t/XlfKkUaDfpC/nPzNIMhmSR79BRFSvbd3GPx9YEEZznlMvO2ROQhNZyqDA7Sjw0LvqjZy3yckCrq8sduR7n1hwCfXJ2drWQXiE3+pc6tMetVx2WbjGkQARjZc6r99siwVk7EUg7mG+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996793; c=relaxed/simple;
	bh=7xUHKKmfPguOYbqCkSOh/XEzW5J6tLa2ubAsl4Vcfj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+acDLmLlPavhnYUjEMKDZd2+LDMBmOcDp3lgMfciDJdJQS6ah1nP6DvUUWyaevco8chagdvnqPiDHVbvGYpcTL2mz1zw4tk7NLeLNBSLUPB1xgFsM7Xe8W0DbFzZbLrX3G2dFB4aCb5G1iZjYduHS+nJULwAs7jLu9cfuilkUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndcKtsZO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso101447266b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Oct 2025 00:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996788; x=1760601588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h86yzQGyqDxtRbYEe7hZoxXaqK6U2loB60w3ZTrgBuw=;
        b=ndcKtsZODzhUBcZcOMj77B6X9nUieRjAB4YYVPC6grTRDZhCE6odTSRSzMFVQiow2+
         Ru4x4gcxVUPuUoOTLijHst+IAu3fGYEwcG2ibkoYpUqNEFBgDU0mGkAHlM/zTZbg4Roj
         qiFkkYivhMYYjSQ+hMWjCWfyeyVoR5awlkCONOEdIAeTvQXIWiW5VSibxSXCHyIkRRtP
         swaxnvmvVGX13ZuO8jS4BU9JYChwVgKm/z1wzPzZ1P82tN0Rfl54buscSt8U6ewA/i/n
         /n4sjC7QJsq2x+RFOSuQZ3KXPsJ7ymoPpQhmlwvCH3migjhgsrM9f9TTf8r/oNN2DNG9
         f0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996788; x=1760601588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h86yzQGyqDxtRbYEe7hZoxXaqK6U2loB60w3ZTrgBuw=;
        b=ARFfKXoxluljd9/Zw9wgh8LJ/LxjDDIkART6VRGsRYcPC05eBlezkcKjPqf12TUZHk
         s4VxVmjzufPGmYjyvu6rLhWxHww+bLQw8xg6K2dc6SZAB32hT9THL86j7vhnEJf3OGmF
         A3wH83rBRhj3c8e11VZZwIJkCAaQemwP18I4+K/NB2sPib4aD7AjxuQ31dET9BziApZ6
         D/dNrouwcgBftD0ROsNiuOnIJWhkRvi0xNYfpU7/ERUsyTeRSouZRJW0nrGBjAQJV2Fe
         E+cls1vgf+LyUC1oTWCCHeIwq4PhJQxRsJMHCZJhEqYU09CfgDTNim0btQ67gyEHIPK4
         6KaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRotPxSPDk2LCU8sfvZbhTOMlSMMLKRnaAOq1UgjtB9YXOlvJzhby2tP49LNIxFoZ4h893pLOfk9Y/Sg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzE6SSEXbUG1zp6OPt6wHl/VwIPBAN24hPV3fvDE7T6Lcz960Ar
	wWIJHe7j7DprLyZpjcG+5lBSkigbemOHYUd2WVhDJPXVj6BIQnoASjnD
X-Gm-Gg: ASbGncs0t+sZ7Ru+XglR4KdMYXWMFAuw6la0ZlEZA2elxUNN9/R1YM1OguJvxP6tCAQ
	z9EaS9wk3DXgGA4sNPHlCM3igMjsq/ha3csDnh8wogOjOfXYZFJ06hAkHKrABImVW/Mk4M+eYBb
	owo231tZ/cu9bl8yEcgwCRnNv+V7RYnC6jF5T2mhQcMkw7THtT989cEdQ+DMhQzyj+4JrXxw+rP
	bIlADvdy+bDeEVjVOmE0DrRZZUnt1GosyliDBzlkYb3J7xySR/yTX/1nOj4DSkN05L84Rh+pBMo
	nQQlptUanNFWduoCL3P62NgHlHO49yvZ/dtRTgbI226s7Wusk0J/DfPCm/VQGxcAlkASDrwD+rl
	3v6Jmer8NBfQC/FizHiwfUVISLqo7P/XlpOFye/1Hm2iorKVkUR5jsWVcwg9Q3XEYf+mv0uJNtM
	X0+RMBS3hceMZaSJDUxlYM1Q==
X-Google-Smtp-Source: AGHT+IEMoGFLpjykXHBKsokLO0dfoJW2SHYyf9tjQ+WYZKEAvvMAzQ8XfJrGfhly0MkTgczBqDnw7Q==
X-Received: by 2002:a17:907:9486:b0:b2d:a873:38d with SMTP id a640c23a62f3a-b50abed1b44mr757779566b.43.1759996788159;
        Thu, 09 Oct 2025 00:59:48 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm553509366b.48.2025.10.09.00.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:59:47 -0700 (PDT)
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
Subject: [PATCH v7 05/14] Manual conversion to use ->i_state accessors of all places not covered by coccinelle
Date: Thu,  9 Oct 2025 09:59:19 +0200
Message-ID: <20251009075929.1203950-6-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009075929.1203950-1-mjguzik@gmail.com>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nothing to look at apart from iput_final().

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 Documentation/filesystems/porting.rst |  2 +-
 fs/afs/inode.c                        |  2 +-
 fs/ext4/inode.c                       | 10 +++++-----
 fs/ext4/orphan.c                      |  4 ++--
 fs/inode.c                            | 18 ++++++++----------
 include/linux/backing-dev.h           |  2 +-
 include/linux/fs.h                    |  6 +++---
 include/linux/writeback.h             |  2 +-
 include/trace/events/writeback.h      |  8 ++++----
 9 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 7233b04668fc..35f027981b21 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -211,7 +211,7 @@ test and set for you.
 e.g.::
 
 	inode = iget_locked(sb, ino);
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_once(inode) & I_NEW) {
 		err = read_inode_from_disk(inode);
 		if (err < 0) {
 			iget_failed(inode);
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 2fe2ccf59c7a..dde1857fcabb 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -427,7 +427,7 @@ static void afs_fetch_status_success(struct afs_operation *op)
 	struct afs_vnode *vnode = vp->vnode;
 	int ret;
 
-	if (vnode->netfs.inode.i_state & I_NEW) {
+	if (inode_state_read_once(&vnode->netfs.inode) & I_NEW) {
 		ret = afs_inode_init_from_status(op, vp, vnode);
 		afs_op_set_error(op, ret);
 		if (ret == 0)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f9e4ac87211e..b864e9645f85 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -425,7 +425,7 @@ void ext4_check_map_extents_env(struct inode *inode)
 	if (!S_ISREG(inode->i_mode) ||
 	    IS_NOQUOTA(inode) || IS_VERITY(inode) ||
 	    is_special_ino(inode->i_sb, inode->i_ino) ||
-	    (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) ||
+	    (inode_state_read_once(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) ||
 	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
 	    ext4_verity_in_progress(inode))
 		return;
@@ -3473,7 +3473,7 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
 	/* Any metadata buffers to write? */
 	if (!list_empty(&inode->i_mapping->i_private_list))
 		return true;
-	return inode->i_state & I_DIRTY_DATASYNC;
+	return inode_state_read_once(inode) & I_DIRTY_DATASYNC;
 }
 
 static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
@@ -4552,7 +4552,7 @@ int ext4_truncate(struct inode *inode)
 	 * or it's a completely new inode. In those cases we might not
 	 * have i_rwsem locked because it's not necessary.
 	 */
-	if (!(inode->i_state & (I_NEW|I_FREEING)))
+	if (!(inode_state_read_once(inode) & (I_NEW | I_FREEING)))
 		WARN_ON(!inode_is_locked(inode));
 	trace_ext4_truncate_enter(inode);
 
@@ -5210,7 +5210,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW)) {
+	if (!(inode_state_read_once(inode) & I_NEW)) {
 		ret = check_igot_inode(inode, flags, function, line);
 		if (ret) {
 			iput(inode);
@@ -5541,7 +5541,7 @@ static void __ext4_update_other_inode_time(struct super_block *sb,
 	if (inode_is_dirtytime_only(inode)) {
 		struct ext4_inode_info	*ei = EXT4_I(inode);
 
-		inode->i_state &= ~I_DIRTY_TIME;
+		inode_state_clear(inode, I_DIRTY_TIME);
 		spin_unlock(&inode->i_lock);
 
 		spin_lock(&ei->i_raw_lock);
diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index 33c3a89396b1..c4903d98ff81 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -107,7 +107,7 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	if (!sbi->s_journal || is_bad_inode(inode))
 		return 0;
 
-	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
+	WARN_ON_ONCE(!(inode_state_read_once(inode) & (I_NEW | I_FREEING)) &&
 		     !inode_is_locked(inode));
 	if (ext4_inode_orphan_tracked(inode))
 		return 0;
@@ -232,7 +232,7 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 	if (!sbi->s_journal && !(sbi->s_mount_state & EXT4_ORPHAN_FS))
 		return 0;
 
-	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
+	WARN_ON_ONCE(!(inode_state_read_once(inode) & (I_NEW | I_FREEING)) &&
 		     !inode_is_locked(inode));
 	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE))
 		return ext4_orphan_file_del(handle, inode);
diff --git a/fs/inode.c b/fs/inode.c
index f094ed3e6f30..3153d725859c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -829,7 +829,7 @@ static void evict(struct inode *inode)
 	 * This also means we don't need any fences for the call below.
 	 */
 	inode_wake_up_bit(inode, __I_NEW);
-	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
+	BUG_ON(inode_state_read_once(inode) != (I_FREEING | I_CLEAR));
 
 	destroy_inode(inode);
 }
@@ -1883,7 +1883,6 @@ static void iput_final(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	const struct super_operations *op = inode->i_sb->s_op;
-	unsigned long state;
 	int drop;
 
 	WARN_ON(inode_state_read(inode) & I_NEW);
@@ -1908,20 +1907,19 @@ static void iput_final(struct inode *inode)
 	 */
 	VFS_BUG_ON_INODE(atomic_read(&inode->i_count) != 0, inode);
 
-	state = inode_state_read(inode);
-	if (!drop) {
-		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
+	if (drop) {
+		inode_state_set(inode, I_FREEING);
+	} else {
+		inode_state_set(inode, I_WILL_FREE);
 		spin_unlock(&inode->i_lock);
 
 		write_inode_now(inode, 1);
 
 		spin_lock(&inode->i_lock);
-		state = inode_state_read(inode);
-		WARN_ON(state & I_NEW);
-		state &= ~I_WILL_FREE;
+		WARN_ON(inode_state_read(inode) & I_NEW);
+		inode_state_replace(inode, I_WILL_FREE, I_FREEING);
 	}
 
-	WRITE_ONCE(inode->i_state, state | I_FREEING);
 	if (!list_empty(&inode->i_lru))
 		inode_lru_list_del(inode);
 	spin_unlock(&inode->i_lock);
@@ -2985,7 +2983,7 @@ void dump_inode(struct inode *inode, const char *reason)
 	pr_warn("%s encountered for inode %px\n"
 		"fs %s mode %ho opflags 0x%hx flags 0x%x state 0x%x count %d\n",
 		reason, inode, sb->s_type->name, inode->i_mode, inode->i_opflags,
-		inode->i_flags, inode->i_state, atomic_read(&inode->i_count));
+		inode->i_flags, inode_state_read_once(inode), atomic_read(&inode->i_count));
 }
 
 EXPORT_SYMBOL(dump_inode);
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 065cba5dc111..0c8342747cab 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -280,7 +280,7 @@ unlocked_inode_to_wb_begin(struct inode *inode, struct wb_lock_cookie *cookie)
 	 * Paired with a release fence in inode_do_switch_wbs() and
 	 * ensures that we see the new wb if we see cleared I_WB_SWITCH.
 	 */
-	cookie->locked = inode->i_state & I_WB_SWITCH;
+	cookie->locked = inode_state_read_once(inode) & I_WB_SWITCH;
 	smp_rmb();
 
 	if (unlikely(cookie->locked))
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 909eb1e68637..77b6486dcae7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1026,7 +1026,7 @@ static inline void inode_fake_hash(struct inode *inode)
 static inline void wait_on_inode(struct inode *inode)
 {
 	wait_var_event(inode_state_wait_address(inode, __I_NEW),
-		       !(READ_ONCE(inode->i_state) & I_NEW));
+		       !(inode_state_read_once(inode) & I_NEW));
 	/*
 	 * Pairs with routines clearing I_NEW.
 	 */
@@ -2719,8 +2719,8 @@ static inline int icount_read(const struct inode *inode)
  */
 static inline bool inode_is_dirtytime_only(struct inode *inode)
 {
-	return (inode->i_state & (I_DIRTY_TIME | I_NEW |
-				  I_FREEING | I_WILL_FREE)) == I_DIRTY_TIME;
+	return (inode_state_read_once(inode) &
+	       (I_DIRTY_TIME | I_NEW | I_FREEING | I_WILL_FREE)) == I_DIRTY_TIME;
 }
 
 extern void inc_nlink(struct inode *inode);
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 06195c2a535b..102071ffedcb 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -227,7 +227,7 @@ static inline void inode_attach_wb(struct inode *inode, struct folio *folio)
 static inline void inode_detach_wb(struct inode *inode)
 {
 	if (inode->i_wb) {
-		WARN_ON_ONCE(!(inode->i_state & I_CLEAR));
+		WARN_ON_ONCE(!(inode_state_read_once(inode) & I_CLEAR));
 		wb_put(inode->i_wb);
 		inode->i_wb = NULL;
 	}
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index c08aff044e80..311a341e6fe4 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -120,7 +120,7 @@ DECLARE_EVENT_CLASS(writeback_dirty_inode_template,
 		/* may be called for files on pseudo FSes w/ unregistered bdi */
 		strscpy_pad(__entry->name, bdi_dev_name(bdi), 32);
 		__entry->ino		= inode->i_ino;
-		__entry->state		= inode->i_state;
+		__entry->state		= inode_state_read_once(inode);
 		__entry->flags		= flags;
 	),
 
@@ -748,7 +748,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
 		strscpy_pad(__entry->name,
 			    bdi_dev_name(inode_to_bdi(inode)), 32);
 		__entry->ino		= inode->i_ino;
-		__entry->state		= inode->i_state;
+		__entry->state		= inode_state_read_once(inode);
 		__entry->dirtied_when	= inode->dirtied_when;
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(inode_to_wb(inode));
 	),
@@ -787,7 +787,7 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
 		strscpy_pad(__entry->name,
 			    bdi_dev_name(inode_to_bdi(inode)), 32);
 		__entry->ino		= inode->i_ino;
-		__entry->state		= inode->i_state;
+		__entry->state		= inode_state_read_once(inode);
 		__entry->dirtied_when	= inode->dirtied_when;
 		__entry->writeback_index = inode->i_mapping->writeback_index;
 		__entry->nr_to_write	= nr_to_write;
@@ -839,7 +839,7 @@ DECLARE_EVENT_CLASS(writeback_inode_template,
 	TP_fast_assign(
 		__entry->dev	= inode->i_sb->s_dev;
 		__entry->ino	= inode->i_ino;
-		__entry->state	= inode->i_state;
+		__entry->state	= inode_state_read_once(inode);
 		__entry->mode	= inode->i_mode;
 		__entry->dirtied_when = inode->dirtied_when;
 	),
-- 
2.34.1


