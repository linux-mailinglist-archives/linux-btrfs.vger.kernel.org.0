Return-Path: <linux-btrfs+bounces-14333-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7543AC935E
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 18:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D621C017EF
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254C71A5B91;
	Fri, 30 May 2025 16:18:52 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2B81494A8
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621931; cv=none; b=Y6ZflCu2KL3xUfqZw9vt+YbOzhUkgZf3vCVVhJpCRxSiquG/RERdp/0TqFn4aQd/jdAFTJ/kTW0CEk4t2/DH7kdi2CaygRWvQ5KFmVtDYWrizaodTDd00bydyySRgmW102+BJSXWus3DihThq2GwrKWvcAtinOewbondhXWFBvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621931; c=relaxed/simple;
	bh=/eH5xJT+9gCJjpN7TrnPhG76yDmpjoXIZupcjaCIDSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxryV1zfg/DZpbZZmcXKnrNkpfVOKrlHsApkF9auam2vlf5UxfEd1WUsk6MyJU7vT1BrQTg5bZvkb49Qf7HaJjismh0ynpEsJ7UeCag5TmFtwIxFiuSN6VYs4HL5giODU7NQiWnmlz7BOx6iFnL//5NuaLY0F0y6AVwoel5jjBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 127DD21A4F;
	Fri, 30 May 2025 16:18:38 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C24313889;
	Fri, 30 May 2025 16:18:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +m7zAl7aOWjhZwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 30 May 2025 16:18:38 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 15/22] btrfs: rename err to ret in btrfs_symlink()
Date: Fri, 30 May 2025 18:18:33 +0200
Message-ID: <f900b7c51bdd5f0563524a0230a9b7b59ad51035.1748621715.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748621715.git.dsterba@suse.com>
References: <cover.1748621715.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 127DD21A4F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Score: -4.00

Unify naming of return value to the preferred way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fd76c551ae57..a91ee8155376 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8779,7 +8779,7 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		.dentry = dentry,
 	};
 	unsigned int trans_num_items;
-	int err;
+	int ret;
 	int name_len;
 	int datasize;
 	unsigned long ptr;
@@ -8806,26 +8806,26 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	inode_set_bytes(inode, name_len);
 
 	new_inode_args.inode = inode;
-	err = btrfs_new_inode_prepare(&new_inode_args, &trans_num_items);
-	if (err)
+	ret = btrfs_new_inode_prepare(&new_inode_args, &trans_num_items);
+	if (ret)
 		goto out_inode;
 	/* 1 additional item for the inline extent */
 	trans_num_items++;
 
 	trans = btrfs_start_transaction(root, trans_num_items);
 	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
+		ret = PTR_ERR(trans);
 		goto out_new_inode_args;
 	}
 
-	err = btrfs_create_new_inode(trans, &new_inode_args);
-	if (err)
+	ret = btrfs_create_new_inode(trans, &new_inode_args);
+	if (ret)
 		goto out;
 
 	path = btrfs_alloc_path();
 	if (!path) {
-		err = -ENOMEM;
-		btrfs_abort_transaction(trans, err);
+		ret = -ENOMEM;
+		btrfs_abort_transaction(trans, ret);
 		discard_new_inode(inode);
 		inode = NULL;
 		goto out;
@@ -8834,10 +8834,9 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	key.type = BTRFS_EXTENT_DATA_KEY;
 	key.offset = 0;
 	datasize = btrfs_file_extent_calc_inline_size(name_len);
-	err = btrfs_insert_empty_item(trans, root, path, &key,
-				      datasize);
-	if (err) {
-		btrfs_abort_transaction(trans, err);
+	ret = btrfs_insert_empty_item(trans, root, path, &key, datasize);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
 		btrfs_free_path(path);
 		discard_new_inode(inode);
 		inode = NULL;
@@ -8859,16 +8858,16 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	btrfs_free_path(path);
 
 	d_instantiate_new(dentry, inode);
-	err = 0;
+	ret = 0;
 out:
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
 out_new_inode_args:
 	btrfs_new_inode_args_destroy(&new_inode_args);
 out_inode:
-	if (err)
+	if (ret)
 		iput(inode);
-	return err;
+	return ret;
 }
 
 static struct btrfs_trans_handle *insert_prealloc_file_extent(
-- 
2.47.1


