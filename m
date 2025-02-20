Return-Path: <linux-btrfs+bounces-11618-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DEAA3D5E4
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92D7D7A1B6F
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D8B1F2C5F;
	Thu, 20 Feb 2025 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sJ5vfKyI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sJ5vfKyI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D461F2B8E
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045673; cv=none; b=EIx2u6UNllG+VqeBlar4l4bufPdQKDWaAORTQB/yGh/RHnIlpc3/EMbDAoJAAISStIOuqy/UIZQtx4whTacVPvgquMSVHFQs68b/BjI/JGelh1WFjkvqoThYcFakO2kr9XH7XG3oHN0IXoUiSpguW5gPwxNa+XvJYAslMNuv0Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045673; c=relaxed/simple;
	bh=kS+xR8IJd2AWUc/Ba0tmLDjcNGcDn9hVHHrmBDfn1Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WB3rtL//xKaR0uspxu4zlk/rBHHYj+mAL++p/orXEbAccW9EmWKqciceUzc3EzaY9ZAgjtk1YbkKRxOzMKlyQFq9WoqIFHD1d5cD5GRNHwBdF/0AsyUWOPCgSwipbuUcj0rAcc31/cCqn03s2j8YhjnaQongiBfU7qsm+8wbYcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sJ5vfKyI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sJ5vfKyI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E79B2117D;
	Thu, 20 Feb 2025 10:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPgTNCImlSbAFCET9bQLf/PJLAYI4hpLA3JmY/ZHtmo=;
	b=sJ5vfKyIaQSd9Xa1/LhBBOw2UzKKpciNFUlmpOylGmDuBtfj2kfGEXrrqOSILxRlEWpzcr
	GZ8uWD0Pivys66J3SfMy5RsacJVcnGabh8/2bn4qgNHEgisV9haaSUzin2zHqUeGnGHGNB
	pNe1sAeuzDAFDoNcsCwMl7+j4TLlWm0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPgTNCImlSbAFCET9bQLf/PJLAYI4hpLA3JmY/ZHtmo=;
	b=sJ5vfKyIaQSd9Xa1/LhBBOw2UzKKpciNFUlmpOylGmDuBtfj2kfGEXrrqOSILxRlEWpzcr
	GZ8uWD0Pivys66J3SfMy5RsacJVcnGabh8/2bn4qgNHEgisV9haaSUzin2zHqUeGnGHGNB
	pNe1sAeuzDAFDoNcsCwMl7+j4TLlWm0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07C4713301;
	Thu, 20 Feb 2025 10:01:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MlPiAVz9tmdefwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Feb 2025 10:01:00 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 05/22] btrfs: pass struct btrfs_inode to new_simple_dir()
Date: Thu, 20 Feb 2025 11:00:59 +0100
Message-ID: <636869fd08d5636669d802e6e2634230698438a9.1740045551.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740045551.git.dsterba@suse.com>
References: <cover.1740045551.git.dsterba@suse.com>
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
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Pass a struct btrfs_inode to new_simple_dir() as it's an internal
interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 55 +++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d726e655974d..ac4dfb896d0f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5672,39 +5672,42 @@ struct inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 	return &inode->vfs_inode;
 }
 
-static struct inode *new_simple_dir(struct inode *dir,
-				    struct btrfs_key *key,
-				    struct btrfs_root *root)
+static struct btrfs_inode *new_simple_dir(struct inode *dir,
+					  struct btrfs_key *key,
+					  struct btrfs_root *root)
 {
 	struct timespec64 ts;
-	struct inode *inode = new_inode(dir->i_sb);
+	struct inode *vfs_inode;
+	struct btrfs_inode *inode;
 
-	if (!inode)
+	vfs_inode = new_inode(dir->i_sb);
+	if (!vfs_inode)
 		return ERR_PTR(-ENOMEM);
 
-	BTRFS_I(inode)->root = btrfs_grab_root(root);
-	BTRFS_I(inode)->ref_root_id = key->objectid;
-	set_bit(BTRFS_INODE_ROOT_STUB, &BTRFS_I(inode)->runtime_flags);
-	set_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags);
+	inode = BTRFS_I(vfs_inode);
+	inode->root = btrfs_grab_root(root);
+	inode->ref_root_id = key->objectid;
+	set_bit(BTRFS_INODE_ROOT_STUB, &inode->runtime_flags);
+	set_bit(BTRFS_INODE_DUMMY, &inode->runtime_flags);
 
-	btrfs_set_inode_number(BTRFS_I(inode), BTRFS_EMPTY_SUBVOL_DIR_OBJECTID);
+	btrfs_set_inode_number(inode, BTRFS_EMPTY_SUBVOL_DIR_OBJECTID);
 	/*
 	 * We only need lookup, the rest is read-only and there's no inode
 	 * associated with the dentry
 	 */
-	inode->i_op = &simple_dir_inode_operations;
-	inode->i_opflags &= ~IOP_XATTR;
-	inode->i_fop = &simple_dir_operations;
-	inode->i_mode = S_IFDIR | S_IRUGO | S_IWUSR | S_IXUGO;
+	vfs_inode->i_op = &simple_dir_inode_operations;
+	vfs_inode->i_opflags &= ~IOP_XATTR;
+	vfs_inode->i_fop = &simple_dir_operations;
+	vfs_inode->i_mode = S_IFDIR | S_IRUGO | S_IWUSR | S_IXUGO;
 
-	ts = inode_set_ctime_current(inode);
-	inode_set_mtime_to_ts(inode, ts);
-	inode_set_atime_to_ts(inode, inode_get_atime(dir));
-	BTRFS_I(inode)->i_otime_sec = ts.tv_sec;
-	BTRFS_I(inode)->i_otime_nsec = ts.tv_nsec;
+	ts = inode_set_ctime_current(vfs_inode);
+	inode_set_mtime_to_ts(vfs_inode, ts);
+	inode_set_atime_to_ts(vfs_inode, inode_get_atime(dir));
+	inode->i_otime_sec = ts.tv_sec;
+	inode->i_otime_nsec = ts.tv_nsec;
 
-	inode->i_uid = dir->i_uid;
-	inode->i_gid = dir->i_gid;
+	vfs_inode->i_uid = dir->i_uid;
+	vfs_inode->i_gid = dir->i_gid;
 
 	return inode;
 }
@@ -5760,10 +5763,14 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 	ret = fixup_tree_root_location(fs_info, BTRFS_I(dir), dentry,
 				       &location, &sub_root);
 	if (ret < 0) {
-		if (ret != -ENOENT)
+		if (ret != -ENOENT) {
 			inode = ERR_PTR(ret);
-		else
-			inode = new_simple_dir(dir, &location, root);
+		} else {
+			struct btrfs_inode *b_inode;
+
+			b_inode = new_simple_dir(dir, &location, root);
+			inode = &b_inode->vfs_inode;
+		}
 	} else {
 		inode = btrfs_iget(location.objectid, sub_root);
 		btrfs_put_root(sub_root);
-- 
2.47.1


