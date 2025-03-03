Return-Path: <linux-btrfs+bounces-11980-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E826A4C3E8
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 15:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40BA33A5161
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 14:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85124213E61;
	Mon,  3 Mar 2025 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aBrxZGTO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aBrxZGTO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A601F3BA3
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013724; cv=none; b=DfiC4HuL5PrKLFPHEJlfLcvY9uht9w8WL9A7rfF3JHPX4nQ0Nj2QWV4ejVbPMr6Pq6bI3yYMQSmRd3KHE0U8LrtQ82+zbDxq9tuE19HZgXovFxKAQZEWUwmOvbABzdIknOEwb3PbrJc8MbEmOt7vyVUJaNGo7N9fN5Ygc1pgkMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013724; c=relaxed/simple;
	bh=qPcbjV0UiEZ3Ky/KnhbulGPlbDfSY0setXHg7nhjQMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNqcaZ3ImPBPmdZL5rj3Nz5EfyzNjGqe6UrZROPv/7A3lsFkCBxd1aHbeQ4lETIQl4xXIgpjNtGWISwGoWWFxSu4IGBKbFVnDCqBRPfS8OLt2wj0kCh2QItdP3HrpYq94ZlSlojgEomMn6R1R7JkU7tM6L2Dq+/qGXKp0wOwp3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aBrxZGTO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aBrxZGTO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5CDE42118F;
	Mon,  3 Mar 2025 14:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741013715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ueTFowaQNhwB30gbecTU9GiB5fCMKqt3kSphdXFCYfw=;
	b=aBrxZGTOiKYC28oqCnuC+j9t/uOvOi72Fa+mBVUI82SFwT1n+FHDEvyeE1jZWJBI1zlM6h
	sxZE+leKworaJXZhenn1ttFZ+4Oh5hod31lAH/cJQ8JHpfh6hTQ2t0A2YdDhOKL14rI3aw
	DuMIYFv/5Qk6KmR+UTBd5FgjBE/lMpQ=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741013715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ueTFowaQNhwB30gbecTU9GiB5fCMKqt3kSphdXFCYfw=;
	b=aBrxZGTOiKYC28oqCnuC+j9t/uOvOi72Fa+mBVUI82SFwT1n+FHDEvyeE1jZWJBI1zlM6h
	sxZE+leKworaJXZhenn1ttFZ+4Oh5hod31lAH/cJQ8JHpfh6hTQ2t0A2YdDhOKL14rI3aw
	DuMIYFv/5Qk6KmR+UTBd5FgjBE/lMpQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55B6313939;
	Mon,  3 Mar 2025 14:55:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hYTrFNPCxWcpAwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 03 Mar 2025 14:55:15 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/7] btrfs: parameter constification in ioctl.c
Date: Mon,  3 Mar 2025 15:55:15 +0100
Message-ID: <a9777237bd6f9d0a8930919219305c426ff370d2.1741012265.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1741012265.git.dsterba@suse.com>
References: <cover.1741012265.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index f3ce82d113be..5c26788f7e4f 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -118,8 +118,8 @@ struct btrfs_ioctl_encoded_io_args_32 {
 #endif
 
 /* Mask out flags that are inappropriate for the given type of inode. */
-static unsigned int btrfs_mask_fsflags_for_type(struct inode *inode,
-		unsigned int flags)
+static unsigned int btrfs_mask_fsflags_for_type(const struct inode *inode,
+						unsigned int flags)
 {
 	if (S_ISDIR(inode->i_mode))
 		return flags;
@@ -133,7 +133,7 @@ static unsigned int btrfs_mask_fsflags_for_type(struct inode *inode,
  * Export internal inode flags to the format expected by the FS_IOC_GETFLAGS
  * ioctl.
  */
-static unsigned int btrfs_inode_flags_to_fsflags(struct btrfs_inode *binode)
+static unsigned int btrfs_inode_flags_to_fsflags(const struct btrfs_inode *binode)
 {
 	unsigned int iflags = 0;
 	u32 flags = binode->flags;
@@ -219,7 +219,7 @@ static int check_fsflags(unsigned int old_flags, unsigned int flags)
 	return 0;
 }
 
-static int check_fsflags_compatible(struct btrfs_fs_info *fs_info,
+static int check_fsflags_compatible(const struct btrfs_fs_info *fs_info,
 				    unsigned int flags)
 {
 	if (btrfs_is_zoned(fs_info) && (flags & FS_NOCOW_FL))
@@ -248,7 +248,7 @@ static int btrfs_check_ioctl_vol_args2_subvol_name(const struct btrfs_ioctl_vol_
  */
 int btrfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
-	struct btrfs_inode *binode = BTRFS_I(d_inode(dentry));
+	const struct btrfs_inode *binode = BTRFS_I(d_inode(dentry));
 
 	fileattr_fill_flags(fa, btrfs_inode_flags_to_fsflags(binode));
 	return 0;
@@ -404,7 +404,7 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 	return ret;
 }
 
-static int btrfs_ioctl_getversion(struct inode *inode, int __user *arg)
+static int btrfs_ioctl_getversion(const struct inode *inode, int __user *arg)
 {
 	return put_user(inode->i_generation, arg);
 }
@@ -476,7 +476,7 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
  * Calculate the number of transaction items to reserve for creating a subvolume
  * or snapshot, not including the inode, directory entries, or parent directory.
  */
-static unsigned int create_subvol_num_items(struct btrfs_qgroup_inherit *inherit)
+static unsigned int create_subvol_num_items(const struct btrfs_qgroup_inherit *inherit)
 {
 	/*
 	 * 1 to add root block
@@ -879,7 +879,7 @@ static int btrfs_may_delete(struct mnt_idmap *idmap,
 
 /* copy of may_create in fs/namei.c() */
 static inline int btrfs_may_create(struct mnt_idmap *idmap,
-				   struct inode *dir, struct dentry *child)
+				   struct inode *dir, const struct dentry *child)
 {
 	if (d_really_is_positive(child))
 		return -EEXIST;
@@ -1448,8 +1448,8 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 	return ret;
 }
 
-static noinline int key_in_sk(struct btrfs_key *key,
-			      struct btrfs_ioctl_search_key *sk)
+static noinline int key_in_sk(const struct btrfs_key *key,
+			      const struct btrfs_ioctl_search_key *sk)
 {
 	struct btrfs_key test;
 	int ret;
@@ -1474,7 +1474,7 @@ static noinline int key_in_sk(struct btrfs_key *key,
 
 static noinline int copy_to_sk(struct btrfs_path *path,
 			       struct btrfs_key *key,
-			       struct btrfs_ioctl_search_key *sk,
+			       const struct btrfs_ioctl_search_key *sk,
 			       u64 *buf_size,
 			       char __user *ubuf,
 			       unsigned long *sk_offset,
@@ -2764,7 +2764,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	return ret;
 }
 
-static long btrfs_ioctl_fs_info(struct btrfs_fs_info *fs_info,
+static long btrfs_ioctl_fs_info(const struct btrfs_fs_info *fs_info,
 				void __user *arg)
 {
 	struct btrfs_ioctl_fs_info_args *fi_args;
@@ -2818,7 +2818,7 @@ static long btrfs_ioctl_fs_info(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
-static long btrfs_ioctl_dev_info(struct btrfs_fs_info *fs_info,
+static long btrfs_ioctl_dev_info(const struct btrfs_fs_info *fs_info,
 				 void __user *arg)
 {
 	BTRFS_DEV_LOOKUP_ARGS(args);
@@ -4249,7 +4249,7 @@ static int btrfs_ioctl_get_features(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-static int check_feature_bits(struct btrfs_fs_info *fs_info,
+static int check_feature_bits(const struct btrfs_fs_info *fs_info,
 			      enum btrfs_feature_set set,
 			      u64 change_mask, u64 flags, u64 supported_flags,
 			      u64 safe_set, u64 safe_clear)
-- 
2.47.1


