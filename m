Return-Path: <linux-btrfs+bounces-11616-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1B5A3D5D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646A43BB31F
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492781F2382;
	Thu, 20 Feb 2025 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="K+GE+yVj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="K+GE+yVj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B001EB188
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045666; cv=none; b=Q7Q8yUDN0JC7UbwMbSDcaeeaEjT8cG+1AWcfLDrjMhou25iYG7RzbXmKGwYKJJwfnoqNwns8RR7qjvsZh/cgytZyrIVBL/VmUiM3OlWx1HsWMV0iRE4hNLidoSHv1kawr97n7XFUjZAWSPHG+OdtNwwhqNet8f/KCJJbGkx6xF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045666; c=relaxed/simple;
	bh=vTpECHuMnF8bm1s8YtCHi4N/UX5rMIPwgpcSxF/XQRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vv4sj9/mB+/35XaJY3HcoQH7CDXap5pR4DeW0+63P7cp1noG1YoiO6QZYZVelllDsr0vpfb4jkthcEwXeO3Xd0ACUIz0mQzd/GxOpQoCI3quvq+j7gMSb5tFH+bRUNNaZHHhYI3G6PHV1zggWf9ygRyJ0R7zM7fRoeDFm08lmfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=K+GE+yVj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=K+GE+yVj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A89DE2117C;
	Thu, 20 Feb 2025 10:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JlYimhwUXfeFypaO1lc0fETCWRdH5ax+wrBJyuTLwsM=;
	b=K+GE+yVj0G8tW5TFsfuR6o+fy+0SEHN3IRoRzpwx0osHGgx7nHzR6xZLLIAKRSPbrtRJpb
	otFHAWxneb+5SoM662RgV+j9T1X3FcMdM4e9R/8olawjSuH+i3OQLXECXeQsGSnOgrPwtV
	IE2Eb0j9Q4W0PLW/661u97A+GiP96f0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JlYimhwUXfeFypaO1lc0fETCWRdH5ax+wrBJyuTLwsM=;
	b=K+GE+yVj0G8tW5TFsfuR6o+fy+0SEHN3IRoRzpwx0osHGgx7nHzR6xZLLIAKRSPbrtRJpb
	otFHAWxneb+5SoM662RgV+j9T1X3FcMdM4e9R/8olawjSuH+i3OQLXECXeQsGSnOgrPwtV
	IE2Eb0j9Q4W0PLW/661u97A+GiP96f0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A207913301;
	Thu, 20 Feb 2025 10:00:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rJyNJ1n9tmdcfwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Feb 2025 10:00:57 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 04/22] btrfs: pass struct btrfs_inode to btrfs_iget_locked()
Date: Thu, 20 Feb 2025 11:00:53 +0100
Message-ID: <044b80889a285638605117907bbab5935b402bc0.1740045551.git.dsterba@suse.com>
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
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Pass a struct btrfs_inode to btrfs_inode() as it's an internal
interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 01fd8a5fc21c..d726e655974d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5601,7 +5601,7 @@ static int btrfs_find_actor(struct inode *inode, void *opaque)
 		args->root == BTRFS_I(inode)->root;
 }
 
-static struct inode *btrfs_iget_locked(u64 ino, struct btrfs_root *root)
+static struct btrfs_inode *btrfs_iget_locked(u64 ino, struct btrfs_root *root)
 {
 	struct inode *inode;
 	struct btrfs_iget_args args;
@@ -5613,7 +5613,9 @@ static struct inode *btrfs_iget_locked(u64 ino, struct btrfs_root *root)
 	inode = iget5_locked_rcu(root->fs_info->sb, hashval, btrfs_find_actor,
 			     btrfs_init_locked_inode,
 			     (void *)&args);
-	return inode;
+	if (!inode)
+		return NULL;
+	return BTRFS_I(inode);
 }
 
 /*
@@ -5623,22 +5625,22 @@ static struct inode *btrfs_iget_locked(u64 ino, struct btrfs_root *root)
 struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
 			      struct btrfs_path *path)
 {
-	struct inode *inode;
+	struct btrfs_inode *inode;
 	int ret;
 
 	inode = btrfs_iget_locked(ino, root);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->i_state & I_NEW))
-		return inode;
+	if (!(inode->vfs_inode.i_state & I_NEW))
+		return &inode->vfs_inode;
 
-	ret = btrfs_read_locked_inode(BTRFS_I(inode), path);
+	ret = btrfs_read_locked_inode(inode, path);
 	if (ret)
 		return ERR_PTR(ret);
 
-	unlock_new_inode(inode);
-	return inode;
+	unlock_new_inode(&inode->vfs_inode);
+	return &inode->vfs_inode;
 }
 
 /*
@@ -5646,7 +5648,7 @@ struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
  */
 struct inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 {
-	struct inode *inode;
+	struct btrfs_inode *inode;
 	struct btrfs_path *path;
 	int ret;
 
@@ -5654,20 +5656,20 @@ struct inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->i_state & I_NEW))
-		return inode;
+	if (!(inode->vfs_inode.i_state & I_NEW))
+		return &inode->vfs_inode;
 
 	path = btrfs_alloc_path();
 	if (!path)
 		return ERR_PTR(-ENOMEM);
 
-	ret = btrfs_read_locked_inode(BTRFS_I(inode), path);
+	ret = btrfs_read_locked_inode(inode, path);
 	btrfs_free_path(path);
 	if (ret)
 		return ERR_PTR(ret);
 
-	unlock_new_inode(inode);
-	return inode;
+	unlock_new_inode(&inode->vfs_inode);
+	return &inode->vfs_inode;
 }
 
 static struct inode *new_simple_dir(struct inode *dir,
-- 
2.47.1


