Return-Path: <linux-btrfs+bounces-14332-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D79AC9366
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 18:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A696AA607ED
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE331A2C11;
	Fri, 30 May 2025 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HgbDVNGC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HgbDVNGC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB691494A8
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621925; cv=none; b=hz7Cj2RZC+ZC2hQG1F+stq1oTZxnhWcbSh0sWuG/j4K+rqi+hBVbfSeE+Oy/ooBTaZmqfDRFLm2xvwPi1pFLfAuOy7vhOdJaKGOos9CB0J7DRvLUtC1EcsgGXvMLGwVXYioYH7YjoqNw3PYxSkXRwFQCyQBuSVJhQ+yfaYpSf30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621925; c=relaxed/simple;
	bh=epYtDAc7U5JwajaJeqfWSNdy+ahTLWkDTM1/rdhwfm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZkunxMSmxb9p5/SiesbXbKQt7VE5q5g9qXZp3FWlIGFjhkpXH0QQk1I/V841heBGn6QlHvHf47CB4sgLcBlJeIS+FPaSgLK4FwVyuyrxyHdtCvN3Tzcohtisj4xahOu9Budcu5gDdrEXV+8CSap82fySFkkB8AFUPJRkbLM3T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HgbDVNGC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HgbDVNGC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A93E621A53;
	Fri, 30 May 2025 16:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TnXTwov9KWmuxcr0/6SkXhmF4R7znt8oS71gm3jf+ng=;
	b=HgbDVNGCKQUR52/cbAYCuei2e665poK/f9LvQvXt9uQwhXmho8l3Nk9TQHw7Nfz5ivr69F
	XSqPf9DbcooI6Wy/BWCzm5f+r+n5p4ttRlrgcahzkzM80WW6/iEOgJJZV5DVRMyfU4kHUF
	dxZlH0zTyo0U607bDY5n1lmXthD/Dtk=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TnXTwov9KWmuxcr0/6SkXhmF4R7znt8oS71gm3jf+ng=;
	b=HgbDVNGCKQUR52/cbAYCuei2e665poK/f9LvQvXt9uQwhXmho8l3Nk9TQHw7Nfz5ivr69F
	XSqPf9DbcooI6Wy/BWCzm5f+r+n5p4ttRlrgcahzkzM80WW6/iEOgJJZV5DVRMyfU4kHUF
	dxZlH0zTyo0U607bDY5n1lmXthD/Dtk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2AB913889;
	Fri, 30 May 2025 16:18:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AUW1J1faOWjSZwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 30 May 2025 16:18:31 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 14/22] btrfs: rename err to ret in btrfs_link()
Date: Fri, 30 May 2025 18:18:31 +0200
Message-ID: <02baba85dda2ef5fe5e557d5e26d16071ccac846.1748621715.git.dsterba@suse.com>
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
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.80

Unify naming of return value to the preferred way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9d200f4246ba..fd76c551ae57 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6802,7 +6802,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct fscrypt_name fname;
 	u64 index;
-	int err;
+	int ret;
 	int drop_inode = 0;
 
 	/* do not allow sys_link's with other subvols of the same device */
@@ -6812,12 +6812,12 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	if (inode->i_nlink >= BTRFS_LINK_MAX)
 		return -EMLINK;
 
-	err = fscrypt_setup_filename(dir, &dentry->d_name, 0, &fname);
-	if (err)
+	ret = fscrypt_setup_filename(dir, &dentry->d_name, 0, &fname);
+	if (ret)
 		goto fail;
 
-	err = btrfs_set_inode_index(BTRFS_I(dir), &index);
-	if (err)
+	ret = btrfs_set_inode_index(BTRFS_I(dir), &index);
+	if (ret)
 		goto fail;
 
 	/*
@@ -6828,7 +6828,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	 */
 	trans = btrfs_start_transaction(root, inode->i_nlink ? 5 : 6);
 	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
+		ret = PTR_ERR(trans);
 		trans = NULL;
 		goto fail;
 	}
@@ -6841,24 +6841,24 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	ihold(inode);
 	set_bit(BTRFS_INODE_COPY_EVERYTHING, &BTRFS_I(inode)->runtime_flags);
 
-	err = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
+	ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
 			     &fname.disk_name, 1, index);
 
-	if (err) {
+	if (ret) {
 		drop_inode = 1;
 	} else {
 		struct dentry *parent = dentry->d_parent;
 
-		err = btrfs_update_inode(trans, BTRFS_I(inode));
-		if (err)
+		ret = btrfs_update_inode(trans, BTRFS_I(inode));
+		if (ret)
 			goto fail;
 		if (inode->i_nlink == 1) {
 			/*
 			 * If new hard link count is 1, it's a file created
 			 * with open(2) O_TMPFILE flag.
 			 */
-			err = btrfs_orphan_del(trans, BTRFS_I(inode));
-			if (err)
+			ret = btrfs_orphan_del(trans, BTRFS_I(inode));
+			if (ret)
 				goto fail;
 		}
 		d_instantiate(dentry, inode);
@@ -6874,7 +6874,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 		iput(inode);
 	}
 	btrfs_btree_balance_dirty(fs_info);
-	return err;
+	return ret;
 }
 
 static struct dentry *btrfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-- 
2.47.1


