Return-Path: <linux-btrfs+bounces-11857-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 652DBA45AC2
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EDB918932D8
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57820270ECE;
	Wed, 26 Feb 2025 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d+4HOUNe";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d+4HOUNe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1424D26FDB4
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563509; cv=none; b=MCmemyaqiTZ5n6AdP/1Am48eZgYvN+NZjyCAbsIo7iKIP3Di6feP5Jjdna9N3DIceMRXAD2gVE+nUiuhtcUDY0powo2mpvgrDZgPgwG+7Syrzjwmut6/NlYOebxtk0zcjLDLtP4yBoygrmFIpczPZq6+kIgawpMKi9F/arO0uKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563509; c=relaxed/simple;
	bh=YwLwno+k3aETq7mLm/4cTav6ohAPrmAVCCag+49e4rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1eXxOB3vxghpBrnob3mOTjeMQ6RYv13qA4T/cxy5oF4beQt2RPXJjQy5D0UaHyuLrf0rzMH6pkvNyLBv++6vXMqBg7nj0CCuJeJmH64jimNZur+v/z67bX0m1xy9PEhx0sSYx7R6ON4zh5wqdjXMuQZ9pdm3eLtxP3Uh6X5Gpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=d+4HOUNe; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=d+4HOUNe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E55721163;
	Wed, 26 Feb 2025 09:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ccDbrjwcZ429SZUtyK/dBJcpxQX70KUFv1gvuPqwgvU=;
	b=d+4HOUNemCtzkmiJpXCv8ykQ21iChOJk0hohLgHiVu6VUf5rQuw5A1N8EPPYyzsZywXDBr
	pUwdcRx8xfBOHUiAos9Lb4UHdDUPfGGExNHf6FMSYKDl9Z3BPzWWDcoEsBdpIsC/9roRWl
	/atraobFMjJ//mdoNnX2Pp6WskKWPm8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=d+4HOUNe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ccDbrjwcZ429SZUtyK/dBJcpxQX70KUFv1gvuPqwgvU=;
	b=d+4HOUNemCtzkmiJpXCv8ykQ21iChOJk0hohLgHiVu6VUf5rQuw5A1N8EPPYyzsZywXDBr
	pUwdcRx8xfBOHUiAos9Lb4UHdDUPfGGExNHf6FMSYKDl9Z3BPzWWDcoEsBdpIsC/9roRWl
	/atraobFMjJ//mdoNnX2Pp6WskKWPm8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 782B113A53;
	Wed, 26 Feb 2025 09:51:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vwxVHTLkvmdyYgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:51:46 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 24/27] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_remove_free_space_inode()
Date: Wed, 26 Feb 2025 10:51:46 +0100
Message-ID: <9bcb54d38aaee1f94d45ffa6adb949c1a839fb96.1740562070.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740562070.git.dsterba@suse.com>
References: <cover.1740562070.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7E55721163
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end with simple goto -> return conversions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/free-space-cache.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 056546bf9abd..3095cce904b5 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -244,7 +244,7 @@ int btrfs_remove_free_space_inode(struct btrfs_trans_handle *trans,
 				  struct inode *inode,
 				  struct btrfs_block_group *block_group)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	int ret = 0;
 
@@ -257,12 +257,12 @@ int btrfs_remove_free_space_inode(struct btrfs_trans_handle *trans,
 	if (IS_ERR(inode)) {
 		if (PTR_ERR(inode) != -ENOENT)
 			ret = PTR_ERR(inode);
-		goto out;
+		return ret;
 	}
 	ret = btrfs_orphan_add(trans, BTRFS_I(inode));
 	if (ret) {
 		btrfs_add_delayed_iput(BTRFS_I(inode));
-		goto out;
+		return ret;
 	}
 	clear_nlink(inode);
 	/* One for the block groups ref */
@@ -285,12 +285,9 @@ int btrfs_remove_free_space_inode(struct btrfs_trans_handle *trans,
 	if (ret) {
 		if (ret > 0)
 			ret = 0;
-		goto out;
+		return ret;
 	}
-	ret = btrfs_del_item(trans, trans->fs_info->tree_root, path);
-out:
-	btrfs_free_path(path);
-	return ret;
+	return btrfs_del_item(trans, trans->fs_info->tree_root, path);
 }
 
 int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
-- 
2.47.1


