Return-Path: <linux-btrfs+bounces-15001-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB817AEA092
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 16:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96FEB5A4C79
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 14:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0022EAB8A;
	Thu, 26 Jun 2025 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ELzhjQir";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ELzhjQir"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323062EA15B
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948221; cv=none; b=Nc/oa1tsup4WHh/u6JiygEbiqWXehLC60AZ3VRJxHNImjYsPlWBOj1RHVcFAdWcJ0DRSGLD+SgA/iv/LqAESf1fqiNuGpDkxSa+xjWj9zt5n44DmpG52APtASgCGN1jcpN3yjJBhcA+WNDVxgPj+Xcr3Eldia0BxrtJZnH7wVk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948221; c=relaxed/simple;
	bh=pEqGLbmJDPAC3EhLOnmvwlHq4ABj418vqmha9an0qHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXbMUAVkUczSTb+CM+q6QBiFe6qdyy538xf9AOc32rAJZklABdUvEnnsYpbkAuWdb4fOuHdNfL5jyOG0TIpN6frZ9ySSj+Op5zATrnlCyMW6zjr7N4lCBFT7JIBcoqsLVG1RxMDvH7wqwhMoYK1NCspIby1NdHNf8ebh5e/sweU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ELzhjQir; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ELzhjQir; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7AA711F38D;
	Thu, 26 Jun 2025 14:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750948217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pMzs1UpbN12X46LMGO9pfklY4lqmBxE39FgS85/Ajxo=;
	b=ELzhjQiramr9GQOoLKOV2RyemRUaVt5gKeLa1YcJ82ZRc7V2Upm6UxQqIS8FnuxWn8T53h
	/DxOiepUehHBgLVnnj/y1dq8Sca3wbQCHcl8lUaXLjsIKVajWAvrMegREwtdWQV9Ef+eru
	qaSA+eYQOtZQrGV6koHz8CDMSvY5cm0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750948217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pMzs1UpbN12X46LMGO9pfklY4lqmBxE39FgS85/Ajxo=;
	b=ELzhjQiramr9GQOoLKOV2RyemRUaVt5gKeLa1YcJ82ZRc7V2Upm6UxQqIS8FnuxWn8T53h
	/DxOiepUehHBgLVnnj/y1dq8Sca3wbQCHcl8lUaXLjsIKVajWAvrMegREwtdWQV9Ef+eru
	qaSA+eYQOtZQrGV6koHz8CDMSvY5cm0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7321C138A7;
	Thu, 26 Jun 2025 14:30:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jxMXHHlZXWgVLgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 26 Jun 2025 14:30:17 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/4] btrfs: use struct qstr for subvolume ioctl helpers
Date: Thu, 26 Jun 2025 16:30:09 +0200
Message-ID: <1c563ad4f046297d3902b99e6b898d0132a27099.1750948128.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750948128.git.dsterba@suse.com>
References: <cover.1750948128.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

We pass name and length of subvolumes separately to the related
functions, while this can be a struct qstr which is otherwise used for
dentry interfaces.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 5068f1fa86f632..092320cb467ef6 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -894,22 +894,21 @@ static inline int btrfs_may_create(struct mnt_idmap *idmap,
  */
 static noinline int btrfs_mksubvol(const struct path *parent,
 				   struct mnt_idmap *idmap,
-				   const char *name, int namelen,
-				   struct btrfs_root *snap_src,
+				   struct qstr *qname, struct btrfs_root *snap_src,
 				   bool readonly,
 				   struct btrfs_qgroup_inherit *inherit)
 {
 	struct inode *dir = d_inode(parent->dentry);
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(dir);
 	struct dentry *dentry;
-	struct fscrypt_str name_str = FSTR_INIT((char *)name, namelen);
+	struct fscrypt_str name_str = FSTR_INIT((char *)qname->name, qname->len);
 	int ret;
 
 	ret = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
 	if (ret == -EINTR)
 		return ret;
 
-	dentry = lookup_one(idmap, &QSTR_LEN(name, namelen), parent->dentry);
+	dentry = lookup_one(idmap, qname, parent->dentry);
 	ret = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out_unlock;
@@ -949,7 +948,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 
 static noinline int btrfs_mksnapshot(const struct path *parent,
 				   struct mnt_idmap *idmap,
-				   const char *name, int namelen,
+				   struct qstr *qname,
 				   struct btrfs_root *root,
 				   bool readonly,
 				   struct btrfs_qgroup_inherit *inherit)
@@ -976,8 +975,8 @@ static noinline int btrfs_mksnapshot(const struct path *parent,
 
 	btrfs_wait_ordered_extents(root, U64_MAX, NULL);
 
-	ret = btrfs_mksubvol(parent, idmap, name, namelen,
-			     root, readonly, inherit);
+	ret = btrfs_mksubvol(parent, idmap, qname, root, readonly, inherit);
+
 	atomic_dec(&root->snapshot_force_cow);
 out:
 	btrfs_drew_read_unlock(&root->snapshot_lock);
@@ -1187,8 +1186,8 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 				bool readonly,
 				struct btrfs_qgroup_inherit *inherit)
 {
-	int namelen;
 	int ret = 0;
+	struct qstr qname = QSTR_INIT(name, strlen(name));
 
 	if (!S_ISDIR(file_inode(file)->i_mode))
 		return -ENOTDIR;
@@ -1197,21 +1196,20 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 	if (ret)
 		goto out;
 
-	namelen = strlen(name);
 	if (strchr(name, '/')) {
 		ret = -EINVAL;
 		goto out_drop_write;
 	}
 
-	if (name[0] == '.' &&
-	   (namelen == 1 || (name[1] == '.' && namelen == 2))) {
+	if (qname.name[0] == '.' &&
+	   (qname.len == 1 || (qname.name[1] == '.' && qname.len == 2))) {
 		ret = -EEXIST;
 		goto out_drop_write;
 	}
 
 	if (subvol) {
-		ret = btrfs_mksubvol(&file->f_path, idmap, name,
-				     namelen, NULL, readonly, inherit);
+		ret = btrfs_mksubvol(&file->f_path, idmap, &qname, NULL,
+				     readonly, inherit);
 	} else {
 		CLASS(fd, src)(fd);
 		struct inode *src_inode;
@@ -1241,8 +1239,7 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 			 */
 			ret = -EINVAL;
 		} else {
-			ret = btrfs_mksnapshot(&file->f_path, idmap,
-					       name, namelen,
+			ret = btrfs_mksnapshot(&file->f_path, idmap, &qname,
 					       BTRFS_I(src_inode)->root,
 					       readonly, inherit);
 		}
-- 
2.49.0


