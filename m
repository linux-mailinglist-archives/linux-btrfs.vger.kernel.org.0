Return-Path: <linux-btrfs+bounces-15002-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0A3AEA093
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 16:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F745A6E93
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 14:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB1A2EA752;
	Thu, 26 Jun 2025 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tJ2btaH6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tJ2btaH6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95202EA484
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948226; cv=none; b=Pbj26lMY/sIbOiidP6yVYEHO7tqBvTR0o648yKHQlnddwyFp6Pn2mx+L6bO/dAcdqr/A6PNFV9uhRQeK23smuXagU/UjLLcUfi7PxO/W1YmW4NwaTwUfnUD+DiJJwSDRAUQZxQ9mjVuPaaHkCorNxeUsL4Tal0GI5QLHjjdlvyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948226; c=relaxed/simple;
	bh=8EnR1BLQeeWm4c8S1lrLEgTLK98DNwXVPYINGJF378w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWSv9TmohC9JRmoEnRcoa40lmEsB5GYxc0xuuYuJj9yHt/eYa1gMRFPgb0xCZg/HxCbfqdabr6c202Q/hCmgfzeizFWA4fYVKEuVStMxHRQIcYYFUeNMBiTQl/Ot+BXTvQ9nbPx3lXuEs/BTw64wq9txWg44quDqv2HnOOYlgho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tJ2btaH6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tJ2btaH6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC0A621172;
	Thu, 26 Jun 2025 14:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750948219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H1D9zvHShvzZE71uCOH/yz4kBYRrKUAeRAwu7ZC17lU=;
	b=tJ2btaH6NWGKuaj4INxCDiMSZwV1z8kY9MVDBe8TyYw/QP8VkaqeAx4gFzFGZsBkVe+RQF
	ngrOnrKRhrnHze79pBIRco62FI4/3K4CXvV7Y4S/lCLT8aUL4VKVs7ZfMrRPF7HUcviRlJ
	YjHsAPYmyHC6u31qzWzkHPP0TqR6pMQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=tJ2btaH6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750948219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H1D9zvHShvzZE71uCOH/yz4kBYRrKUAeRAwu7ZC17lU=;
	b=tJ2btaH6NWGKuaj4INxCDiMSZwV1z8kY9MVDBe8TyYw/QP8VkaqeAx4gFzFGZsBkVe+RQF
	ngrOnrKRhrnHze79pBIRco62FI4/3K4CXvV7Y4S/lCLT8aUL4VKVs7ZfMrRPF7HUcviRlJ
	YjHsAPYmyHC6u31qzWzkHPP0TqR6pMQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B508F138A7;
	Thu, 26 Jun 2025 14:30:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6S0vLHtZXWgYLgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 26 Jun 2025 14:30:19 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/4] btrfs: pass dentry to btrfs_mksubvol() and btrfs_mksnapshot()
Date: Thu, 26 Jun 2025 16:30:10 +0200
Message-ID: <e4a6cbdce516a0e9fb32c3a1b2c9d8a943373841.1750948128.git.dsterba@suse.com>
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
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BC0A621172
X-Rspamd-Action: no action
X-Spam-Flag: NO
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim,suse.com:email];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01
X-Spam-Level: 

There's no reason to pass 'struct path' to btrfs_mksubvol(), though it's
been like the since the first commit 76dda93c6ae2c1 ("Btrfs: add
snapshot/subvolume destroy ioctl").  We only use the dentry so we should
pass it directly.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 092320cb467ef6..225fc00311a4c4 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -892,13 +892,13 @@ static inline int btrfs_may_create(struct mnt_idmap *idmap,
  * sys_mkdirat and vfs_mkdir, but we only do a single component lookup
  * inside this filesystem so it's quite a bit simpler.
  */
-static noinline int btrfs_mksubvol(const struct path *parent,
+static noinline int btrfs_mksubvol(struct dentry *parent,
 				   struct mnt_idmap *idmap,
 				   struct qstr *qname, struct btrfs_root *snap_src,
 				   bool readonly,
 				   struct btrfs_qgroup_inherit *inherit)
 {
-	struct inode *dir = d_inode(parent->dentry);
+	struct inode *dir = d_inode(parent);
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(dir);
 	struct dentry *dentry;
 	struct fscrypt_str name_str = FSTR_INIT((char *)qname->name, qname->len);
@@ -908,7 +908,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	if (ret == -EINTR)
 		return ret;
 
-	dentry = lookup_one(idmap, qname, parent->dentry);
+	dentry = lookup_one(idmap, qname, parent);
 	ret = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out_unlock;
@@ -946,7 +946,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	return ret;
 }
 
-static noinline int btrfs_mksnapshot(const struct path *parent,
+static noinline int btrfs_mksnapshot(struct dentry *parent,
 				   struct mnt_idmap *idmap,
 				   struct qstr *qname,
 				   struct btrfs_root *root,
@@ -1208,7 +1208,7 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 	}
 
 	if (subvol) {
-		ret = btrfs_mksubvol(&file->f_path, idmap, &qname, NULL,
+		ret = btrfs_mksubvol(file_dentry(file), idmap, &qname, NULL,
 				     readonly, inherit);
 	} else {
 		CLASS(fd, src)(fd);
@@ -1239,7 +1239,7 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 			 */
 			ret = -EINVAL;
 		} else {
-			ret = btrfs_mksnapshot(&file->f_path, idmap, &qname,
+			ret = btrfs_mksnapshot(file_dentry(file), idmap, &qname,
 					       BTRFS_I(src_inode)->root,
 					       readonly, inherit);
 		}
-- 
2.49.0


