Return-Path: <linux-btrfs+bounces-11986-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D45B7A4C3EE
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 15:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59DE1894A7B
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 14:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9402D213E61;
	Mon,  3 Mar 2025 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="j+Y6Gubb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NpfOEwKA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0751F3BA3
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013754; cv=none; b=MiEyo2VC28IGCvwMpz4ay1p8PH6qSttmovt29uB8RuafpUtWGf2EBijZoZbX3R0mxNFQ053unLj3ch8aXm6dKGtbJucG31NgAlvZfn+1SYi9yHwx1etFSNyxShu2ULtWLcYPg9D8ZH90GvSveDU4B+wZIbrjWaeh+YdfssjsI6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013754; c=relaxed/simple;
	bh=6tDgNpN22bX+DNsalY3HKe78MfHCahl2KUDjdnq2+ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kw7ImRzWUToH7v//QCZ3KBa7/pszX21vMwH67HbsSeiI71Rz4J66O/+XSqBSuuSHF+VQviCsX719XSeSms9/+GfL4Ss+YdOMNX+wNSMNFWphFrwODQkqst1+OUkcSaMU/QUZ+3USgHY7/hFzOlk0/3ksgpyf6XicUL9kNAqkf7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=j+Y6Gubb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NpfOEwKA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B378C21182;
	Mon,  3 Mar 2025 14:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741013751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZ9cFrav+7RO4ZgPErCIcn/Viou+jj7hwA3X9397/WA=;
	b=j+Y6Gubbx7xGxwpRxwb+Nj0pHQMmck8+9OLVHYifXwd0l4sXDau2Ikb+vhfhbxMqWPhhjv
	Z2FXrF+Vkcdi8o6B1c7T9zz4xz/iIbC2QfLeXuLu7+ZkQcfm6fOX5Ff8i/KTm4PG16q0NU
	kyogp1GorKZ7aBEA/LhTQUgKkWKsZnY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=NpfOEwKA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741013749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZ9cFrav+7RO4ZgPErCIcn/Viou+jj7hwA3X9397/WA=;
	b=NpfOEwKA/kEZgF99nyTgeft7NBH5WnTOUyRDR5rV9a0llOdcksugRPwD/+h/6wPkO8o1PO
	ZJkeEPR+wXG8wEz1hTVyq1x75bMP/W+27q4+Gpl+GhN4hCPR7Evne1hhymc9I/lGZFhlMn
	N0uScaOysFQ+V3hRCzI2lGA2l+cfebg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD22213939;
	Mon,  3 Mar 2025 14:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S4c+KvXCxWdpAwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 03 Mar 2025 14:55:49 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 7/7] btrfs: unify inode variable naming
Date: Mon,  3 Mar 2025 15:55:41 +0100
Message-ID: <519e92296c6c961613c52fd47c41f4e367e0f1a0.1741012265.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: B378C21182
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Rename binode to inode in local variables or parameters so it's more
unified with the rest of the code.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 28 +++++++-------
 fs/btrfs/ioctl.c | 98 ++++++++++++++++++++++++------------------------
 2 files changed, 61 insertions(+), 65 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 63148b40b74a..2edc798efde3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8528,8 +8528,6 @@ static int start_delalloc_inodes(struct btrfs_root *root,
 				 struct writeback_control *wbc, bool snapshot,
 				 bool in_reclaim_context)
 {
-	struct btrfs_inode *binode;
-	struct inode *inode;
 	struct btrfs_delalloc_work *work, *next;
 	LIST_HEAD(works);
 	LIST_HEAD(splice);
@@ -8540,30 +8538,30 @@ static int start_delalloc_inodes(struct btrfs_root *root,
 	spin_lock(&root->delalloc_lock);
 	list_splice_init(&root->delalloc_inodes, &splice);
 	while (!list_empty(&splice)) {
-		binode = list_entry(splice.next, struct btrfs_inode,
-				    delalloc_inodes);
+		struct btrfs_inode *inode;
+		struct inode *tmp_inode;
 
-		list_move_tail(&binode->delalloc_inodes,
-			       &root->delalloc_inodes);
+		inode = list_entry(splice.next, struct btrfs_inode, delalloc_inodes);
+
+		list_move_tail(&inode->delalloc_inodes, &root->delalloc_inodes);
 
 		if (in_reclaim_context &&
-		    test_bit(BTRFS_INODE_NO_DELALLOC_FLUSH, &binode->runtime_flags))
+		    test_bit(BTRFS_INODE_NO_DELALLOC_FLUSH, &inode->runtime_flags))
 			continue;
 
-		inode = igrab(&binode->vfs_inode);
-		if (!inode) {
+		tmp_inode = igrab(&inode->vfs_inode);
+		if (!tmp_inode) {
 			cond_resched_lock(&root->delalloc_lock);
 			continue;
 		}
 		spin_unlock(&root->delalloc_lock);
 
 		if (snapshot)
-			set_bit(BTRFS_INODE_SNAPSHOT_FLUSH,
-				&binode->runtime_flags);
+			set_bit(BTRFS_INODE_SNAPSHOT_FLUSH, &inode->runtime_flags);
 		if (full_flush) {
-			work = btrfs_alloc_delalloc_work(inode);
+			work = btrfs_alloc_delalloc_work(&inode->vfs_inode);
 			if (!work) {
-				iput(inode);
+				iput(&inode->vfs_inode);
 				ret = -ENOMEM;
 				goto out;
 			}
@@ -8571,8 +8569,8 @@ static int start_delalloc_inodes(struct btrfs_root *root,
 			btrfs_queue_work(root->fs_info->flush_workers,
 					 &work->work);
 		} else {
-			ret = filemap_fdatawrite_wbc(inode->i_mapping, wbc);
-			btrfs_add_delayed_iput(BTRFS_I(inode));
+			ret = filemap_fdatawrite_wbc(inode->vfs_inode.i_mapping, wbc);
+			btrfs_add_delayed_iput(inode);
 			if (ret || wbc->nr_to_write <= 0)
 				goto out;
 		}
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 188fb7ec32d1..fffa2868f329 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -133,11 +133,11 @@ static unsigned int btrfs_mask_fsflags_for_type(const struct inode *inode,
  * Export internal inode flags to the format expected by the FS_IOC_GETFLAGS
  * ioctl.
  */
-static unsigned int btrfs_inode_flags_to_fsflags(const struct btrfs_inode *binode)
+static unsigned int btrfs_inode_flags_to_fsflags(const struct btrfs_inode *inode)
 {
 	unsigned int iflags = 0;
-	u32 flags = binode->flags;
-	u32 ro_flags = binode->ro_flags;
+	u32 flags = inode->flags;
+	u32 ro_flags = inode->ro_flags;
 
 	if (flags & BTRFS_INODE_SYNC)
 		iflags |= FS_SYNC_FL;
@@ -247,24 +247,23 @@ static int btrfs_check_ioctl_vol_args2_subvol_name(const struct btrfs_ioctl_vol_
  */
 int btrfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
-	const struct btrfs_inode *binode = BTRFS_I(d_inode(dentry));
+	const struct btrfs_inode *inode = BTRFS_I(d_inode(dentry));
 
-	fileattr_fill_flags(fa, btrfs_inode_flags_to_fsflags(binode));
+	fileattr_fill_flags(fa, btrfs_inode_flags_to_fsflags(inode));
 	return 0;
 }
 
 int btrfs_fileattr_set(struct mnt_idmap *idmap,
 		       struct dentry *dentry, struct fileattr *fa)
 {
-	struct inode *inode = d_inode(dentry);
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
-	struct btrfs_inode *binode = BTRFS_I(inode);
-	struct btrfs_root *root = binode->root;
+	struct btrfs_inode *inode = BTRFS_I(d_inode(dentry));
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *trans;
 	unsigned int fsflags, old_fsflags;
 	int ret;
 	const char *comp = NULL;
-	u32 binode_flags;
+	u32 inode_flags;
 
 	if (btrfs_root_readonly(root))
 		return -EROFS;
@@ -272,8 +271,8 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 	if (fileattr_has_fsx(fa))
 		return -EOPNOTSUPP;
 
-	fsflags = btrfs_mask_fsflags_for_type(inode, fa->flags);
-	old_fsflags = btrfs_inode_flags_to_fsflags(binode);
+	fsflags = btrfs_mask_fsflags_for_type(&inode->vfs_inode, fa->flags);
+	old_fsflags = btrfs_inode_flags_to_fsflags(inode);
 	ret = check_fsflags(old_fsflags, fsflags);
 	if (ret)
 		return ret;
@@ -282,27 +281,27 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 	if (ret)
 		return ret;
 
-	binode_flags = binode->flags;
+	inode_flags = inode->flags;
 	if (fsflags & FS_SYNC_FL)
-		binode_flags |= BTRFS_INODE_SYNC;
+		inode_flags |= BTRFS_INODE_SYNC;
 	else
-		binode_flags &= ~BTRFS_INODE_SYNC;
+		inode_flags &= ~BTRFS_INODE_SYNC;
 	if (fsflags & FS_IMMUTABLE_FL)
-		binode_flags |= BTRFS_INODE_IMMUTABLE;
+		inode_flags |= BTRFS_INODE_IMMUTABLE;
 	else
-		binode_flags &= ~BTRFS_INODE_IMMUTABLE;
+		inode_flags &= ~BTRFS_INODE_IMMUTABLE;
 	if (fsflags & FS_APPEND_FL)
-		binode_flags |= BTRFS_INODE_APPEND;
+		inode_flags |= BTRFS_INODE_APPEND;
 	else
-		binode_flags &= ~BTRFS_INODE_APPEND;
+		inode_flags &= ~BTRFS_INODE_APPEND;
 	if (fsflags & FS_NODUMP_FL)
-		binode_flags |= BTRFS_INODE_NODUMP;
+		inode_flags |= BTRFS_INODE_NODUMP;
 	else
-		binode_flags &= ~BTRFS_INODE_NODUMP;
+		inode_flags &= ~BTRFS_INODE_NODUMP;
 	if (fsflags & FS_NOATIME_FL)
-		binode_flags |= BTRFS_INODE_NOATIME;
+		inode_flags |= BTRFS_INODE_NOATIME;
 	else
-		binode_flags &= ~BTRFS_INODE_NOATIME;
+		inode_flags &= ~BTRFS_INODE_NOATIME;
 
 	/* If coming from FS_IOC_FSSETXATTR then skip unconverted flags */
 	if (!fa->flags_valid) {
@@ -314,32 +313,32 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 	}
 
 	if (fsflags & FS_DIRSYNC_FL)
-		binode_flags |= BTRFS_INODE_DIRSYNC;
+		inode_flags |= BTRFS_INODE_DIRSYNC;
 	else
-		binode_flags &= ~BTRFS_INODE_DIRSYNC;
+		inode_flags &= ~BTRFS_INODE_DIRSYNC;
 	if (fsflags & FS_NOCOW_FL) {
-		if (S_ISREG(inode->i_mode)) {
+		if (S_ISREG(inode->vfs_inode.i_mode)) {
 			/*
 			 * It's safe to turn csums off here, no extents exist.
 			 * Otherwise we want the flag to reflect the real COW
 			 * status of the file and will not set it.
 			 */
-			if (inode->i_size == 0)
-				binode_flags |= BTRFS_INODE_NODATACOW |
-						BTRFS_INODE_NODATASUM;
+			if (inode->vfs_inode.i_size == 0)
+				inode_flags |= BTRFS_INODE_NODATACOW |
+					       BTRFS_INODE_NODATASUM;
 		} else {
-			binode_flags |= BTRFS_INODE_NODATACOW;
+			inode_flags |= BTRFS_INODE_NODATACOW;
 		}
 	} else {
 		/*
 		 * Revert back under same assumptions as above
 		 */
-		if (S_ISREG(inode->i_mode)) {
-			if (inode->i_size == 0)
-				binode_flags &= ~(BTRFS_INODE_NODATACOW |
-						  BTRFS_INODE_NODATASUM);
+		if (S_ISREG(inode->vfs_inode.i_mode)) {
+			if (inode->vfs_inode.i_size == 0)
+				inode_flags &= ~(BTRFS_INODE_NODATACOW |
+						 BTRFS_INODE_NODATASUM);
 		} else {
-			binode_flags &= ~BTRFS_INODE_NODATACOW;
+			inode_flags &= ~BTRFS_INODE_NODATACOW;
 		}
 	}
 
@@ -349,21 +348,21 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 	 * things smaller.
 	 */
 	if (fsflags & FS_NOCOMP_FL) {
-		binode_flags &= ~BTRFS_INODE_COMPRESS;
-		binode_flags |= BTRFS_INODE_NOCOMPRESS;
+		inode_flags &= ~BTRFS_INODE_COMPRESS;
+		inode_flags |= BTRFS_INODE_NOCOMPRESS;
 	} else if (fsflags & FS_COMPR_FL) {
 
-		if (IS_SWAPFILE(inode))
+		if (IS_SWAPFILE(&inode->vfs_inode))
 			return -ETXTBSY;
 
-		binode_flags |= BTRFS_INODE_COMPRESS;
-		binode_flags &= ~BTRFS_INODE_NOCOMPRESS;
+		inode_flags |= BTRFS_INODE_COMPRESS;
+		inode_flags &= ~BTRFS_INODE_NOCOMPRESS;
 
 		comp = btrfs_compress_type2str(fs_info->compress_type);
 		if (!comp || comp[0] == 0)
 			comp = btrfs_compress_type2str(BTRFS_COMPRESS_ZLIB);
 	} else {
-		binode_flags &= ~(BTRFS_INODE_COMPRESS | BTRFS_INODE_NOCOMPRESS);
+		inode_flags &= ~(BTRFS_INODE_COMPRESS | BTRFS_INODE_NOCOMPRESS);
 	}
 
 	/*
@@ -375,15 +374,14 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 		return PTR_ERR(trans);
 
 	if (comp) {
-		ret = btrfs_set_prop(trans, BTRFS_I(inode), "btrfs.compression",
+		ret = btrfs_set_prop(trans, inode, "btrfs.compression",
 				     comp, strlen(comp), 0);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto out_end_trans;
 		}
 	} else {
-		ret = btrfs_set_prop(trans, BTRFS_I(inode), "btrfs.compression",
-				     NULL, 0, 0);
+		ret = btrfs_set_prop(trans, inode, "btrfs.compression", NULL, 0, 0);
 		if (ret && ret != -ENODATA) {
 			btrfs_abort_transaction(trans, ret);
 			goto out_end_trans;
@@ -391,12 +389,12 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 	}
 
 update_flags:
-	binode->flags = binode_flags;
-	btrfs_update_inode_mapping_flags(binode);
-	btrfs_sync_inode_flags_to_i_flags(binode);
-	inode_inc_iversion(inode);
-	inode_set_ctime_current(inode);
-	ret = btrfs_update_inode(trans, BTRFS_I(inode));
+	inode->flags = inode_flags;
+	btrfs_update_inode_mapping_flags(inode);
+	btrfs_sync_inode_flags_to_i_flags(inode);
+	inode_inc_iversion(&inode->vfs_inode);
+	inode_set_ctime_current(&inode->vfs_inode);
+	ret = btrfs_update_inode(trans, inode);
 
  out_end_trans:
 	btrfs_end_transaction(trans);
-- 
2.47.1


