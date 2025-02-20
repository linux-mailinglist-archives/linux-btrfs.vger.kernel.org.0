Return-Path: <linux-btrfs+bounces-11634-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D6CA3D602
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 722937ACA51
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24751F130E;
	Thu, 20 Feb 2025 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Wq2Fqt8s";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Wq2Fqt8s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8FA1F12EA
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045731; cv=none; b=GwqDAEpaexLs6r5grQxOS6CzGn3l3P1fT8AfFfv92Qp1OzHLCEPFHLoHYVRHObSoHqLAYy+IMhdBBj29nEFGXo1REjKRpUsSRinvtI4anU8TeEQ8R2cb/Yj/eYqS6NetLU8V0JmmzEQ1gOR1XDi+wrkybZmwDc1Hp2cDaxPX6CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045731; c=relaxed/simple;
	bh=38LuLIQIWBcWCSRtWW8kMVDGGDXRyOD1hlWoaPLMaGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPFHL9JSAVEXddg3IWqskcu+lyw9zdA2qdRhEhqPlSi2XoCn3sg7zijirPghho7BRwIJEhtZ3FRpOmNRhRvKcywuMZagBqerVeTfE0HRqBKE6mB3ZzJ0TGXKSU9fjYjasA81zAM4lR0bR5BkCBXzHNS53efP0CmrbWx4/BuC+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Wq2Fqt8s; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Wq2Fqt8s; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 80BD12117D;
	Thu, 20 Feb 2025 10:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjfJcJ/7RdzHadjqUxRck+2/LwKNyqFT3FjkEQzsLPM=;
	b=Wq2Fqt8seV3bs9HMFVTbXdZrd/ItWKKccILu5AmTmiWi2y0ppcdhduvVjKeWJDsUoz77Hv
	kf6cNDTndYKwxCPJ4H9yYBDPIgFCZ6DQhRazAx3IX8f7Cfb1FAgMq6FKD4g/ri1RUdJ5IK
	UV+HDXfZ6zsGlWaGWgk2THW9wntLUzs=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Wq2Fqt8s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjfJcJ/7RdzHadjqUxRck+2/LwKNyqFT3FjkEQzsLPM=;
	b=Wq2Fqt8seV3bs9HMFVTbXdZrd/ItWKKccILu5AmTmiWi2y0ppcdhduvVjKeWJDsUoz77Hv
	kf6cNDTndYKwxCPJ4H9yYBDPIgFCZ6DQhRazAx3IX8f7Cfb1FAgMq6FKD4g/ri1RUdJ5IK
	UV+HDXfZ6zsGlWaGWgk2THW9wntLUzs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A72313301;
	Thu, 20 Feb 2025 10:02:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AdPiHZz9tmfRfwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Feb 2025 10:02:04 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 22/22] btrfs: use struct btrfs_inode inside btrfs_get_name()
Date: Thu, 20 Feb 2025 11:02:04 +0100
Message-ID: <21b7a1d2f6a7c471cdd30ba161a39e1fe456f0bf.1740045551.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: 80BD12117D
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
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

Use a struct btrfs_inode in btrfs_get_name() as it's an internal
helper, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/export.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index ab4d8625ad55..0c0b8db82df6 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -219,11 +219,11 @@ struct dentry *btrfs_get_parent(struct dentry *child)
 static int btrfs_get_name(struct dentry *parent, char *name,
 			  struct dentry *child)
 {
-	struct inode *inode = d_inode(child);
-	struct inode *dir = d_inode(parent);
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
+	struct btrfs_inode *inode = BTRFS_I(d_inode(child));
+	struct btrfs_inode *dir = BTRFS_I(d_inode(parent));
+	struct btrfs_root *root = dir->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_path *path;
-	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_inode_ref *iref;
 	struct btrfs_root_ref *rref;
 	struct extent_buffer *leaf;
@@ -233,24 +233,24 @@ static int btrfs_get_name(struct dentry *parent, char *name,
 	int ret;
 	u64 ino;
 
-	if (!S_ISDIR(dir->i_mode))
+	if (!S_ISDIR(dir->vfs_inode.i_mode))
 		return -EINVAL;
 
-	ino = btrfs_ino(BTRFS_I(inode));
+	ino = btrfs_ino(inode);
 
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
 	if (ino == BTRFS_FIRST_FREE_OBJECTID) {
-		key.objectid = btrfs_root_id(BTRFS_I(inode)->root);
+		key.objectid = btrfs_root_id(inode->root);
 		key.type = BTRFS_ROOT_BACKREF_KEY;
 		key.offset = (u64)-1;
 		root = fs_info->tree_root;
 	} else {
 		key.objectid = ino;
 		key.type = BTRFS_INODE_REF_KEY;
-		key.offset = btrfs_ino(BTRFS_I(dir));
+		key.offset = btrfs_ino(dir);
 	}
 
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-- 
2.47.1


