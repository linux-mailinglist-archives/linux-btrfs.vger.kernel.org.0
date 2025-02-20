Return-Path: <linux-btrfs+bounces-11625-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E4EA3D5D2
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40ED417CD31
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DD51F4276;
	Thu, 20 Feb 2025 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eOwZLu+j";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eOwZLu+j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA671F3FF4
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045696; cv=none; b=GyjW7n8qDXmZtm2EwHUM4I2JQf/OUxowcGUNysILloDw9JGYe4aLF+C26S65yZ4UTWlNc+m7qcT2RAZY3nf4AQEEOA/QUT/e1FV1KHMz5Y8rkewrR+RuuhYaThhlOdOwxyEg+mmUEnUQK8jzEQIpMAklw60UcSOgfwfivUjYdz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045696; c=relaxed/simple;
	bh=JwjVdIPu6IQPigIBoj9JcH9l1pkIco6rJvZA+zhtUsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnteMP4zyr6mWGQaWm53jd27lTQfym2+W2JeONWhY4VKMVITFV3owgvfW/MpnUevyel2LRMBx86YOIz6ZWaYRF62OCYjSsnyH1NNsgJ4mbU+lVfGDfeiA/xQ61xH+9wrn3lt1IIcVa3hIMoQ1p9o18hbTq5bfQoKrhkjCsb+By8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eOwZLu+j; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eOwZLu+j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 10B331F387;
	Thu, 20 Feb 2025 10:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pxda3IXiG3cfY6VpR8mIGWHDEngI/vjAp78C7+MVgyY=;
	b=eOwZLu+jKzMA0EI7B0DUrKHVhtS52EAasvEBGga1iz4nl9cMgHbTSJe8h5cV6xG2O8rLwv
	3sP6K71s2ollBmy+iVvZX/27W141XidtQcMaRzYOok3almqj8ZpF8JO7H85DvnGMe0Z0lo
	KiuddV23ckAiXLxaEKdkLPue4fvDN/U=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=eOwZLu+j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pxda3IXiG3cfY6VpR8mIGWHDEngI/vjAp78C7+MVgyY=;
	b=eOwZLu+jKzMA0EI7B0DUrKHVhtS52EAasvEBGga1iz4nl9cMgHbTSJe8h5cV6xG2O8rLwv
	3sP6K71s2ollBmy+iVvZX/27W141XidtQcMaRzYOok3almqj8ZpF8JO7H85DvnGMe0Z0lo
	KiuddV23ckAiXLxaEKdkLPue4fvDN/U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08A8C13301;
	Thu, 20 Feb 2025 10:01:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w3MbAnv9tmeNfwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Feb 2025 10:01:31 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 13/22] btrfs: props: switch prop_handler::apply to struct btrfs_inode
Date: Thu, 20 Feb 2025 11:01:30 +0100
Message-ID: <3ef322d952c45d85fc269d21d1f60fa8edc7e0e9.1740045551.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: 10B331F387
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

Pass a struct btrfs_inode to the apply() callback as it's an internal
interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/props.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index 16e84a2e24f4..10af7088e7ab 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -26,7 +26,7 @@ struct prop_handler {
 	const char *xattr_name;
 	int (*validate)(const struct btrfs_inode *inode, const char *value,
 			size_t len);
-	int (*apply)(struct inode *inode, const char *value, size_t len);
+	int (*apply)(struct btrfs_inode *inode, const char *value, size_t len);
 	const char *(*extract)(const struct inode *inode);
 	bool (*ignore)(const struct btrfs_inode *inode);
 	int inheritable;
@@ -121,7 +121,7 @@ int btrfs_set_prop(struct btrfs_trans_handle *trans, struct btrfs_inode *inode,
 		if (ret)
 			return ret;
 
-		ret = handler->apply(&inode->vfs_inode, NULL, 0);
+		ret = handler->apply(inode, NULL, 0);
 		ASSERT(ret == 0);
 
 		return ret;
@@ -131,7 +131,7 @@ int btrfs_set_prop(struct btrfs_trans_handle *trans, struct btrfs_inode *inode,
 			     value_len, flags);
 	if (ret)
 		return ret;
-	ret = handler->apply(&inode->vfs_inode, value, value_len);
+	ret = handler->apply(inode, value, value_len);
 	if (ret) {
 		btrfs_setxattr(trans, &inode->vfs_inode, handler->xattr_name, NULL,
 			       0, flags);
@@ -263,7 +263,7 @@ static void inode_prop_iterator(void *ctx,
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	int ret;
 
-	ret = handler->apply(inode, value, len);
+	ret = handler->apply(BTRFS_I(inode), value, len);
 	if (unlikely(ret))
 		btrfs_warn(root->fs_info,
 			   "error applying prop %s to ino %llu (root %llu): %d",
@@ -301,26 +301,26 @@ static int prop_compression_validate(const struct btrfs_inode *inode,
 	return -EINVAL;
 }
 
-static int prop_compression_apply(struct inode *inode, const char *value,
+static int prop_compression_apply(struct btrfs_inode *inode, const char *value,
 				  size_t len)
 {
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	int type;
 
 	/* Reset to defaults */
 	if (len == 0) {
-		BTRFS_I(inode)->flags &= ~BTRFS_INODE_COMPRESS;
-		BTRFS_I(inode)->flags &= ~BTRFS_INODE_NOCOMPRESS;
-		BTRFS_I(inode)->prop_compress = BTRFS_COMPRESS_NONE;
+		inode->flags &= ~BTRFS_INODE_COMPRESS;
+		inode->flags &= ~BTRFS_INODE_NOCOMPRESS;
+		inode->prop_compress = BTRFS_COMPRESS_NONE;
 		return 0;
 	}
 
 	/* Set NOCOMPRESS flag */
 	if ((len == 2 && strncmp("no", value, 2) == 0) ||
 	    (len == 4 && strncmp("none", value, 4) == 0)) {
-		BTRFS_I(inode)->flags |= BTRFS_INODE_NOCOMPRESS;
-		BTRFS_I(inode)->flags &= ~BTRFS_INODE_COMPRESS;
-		BTRFS_I(inode)->prop_compress = BTRFS_COMPRESS_NONE;
+		inode->flags |= BTRFS_INODE_NOCOMPRESS;
+		inode->flags &= ~BTRFS_INODE_COMPRESS;
+		inode->prop_compress = BTRFS_COMPRESS_NONE;
 
 		return 0;
 	}
@@ -337,9 +337,9 @@ static int prop_compression_apply(struct inode *inode, const char *value,
 		return -EINVAL;
 	}
 
-	BTRFS_I(inode)->flags &= ~BTRFS_INODE_NOCOMPRESS;
-	BTRFS_I(inode)->flags |= BTRFS_INODE_COMPRESS;
-	BTRFS_I(inode)->prop_compress = type;
+	inode->flags &= ~BTRFS_INODE_NOCOMPRESS;
+	inode->flags |= BTRFS_INODE_COMPRESS;
+	inode->prop_compress = type;
 
 	return 0;
 }
@@ -440,7 +440,7 @@ int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
 		ret = btrfs_setxattr(trans, &inode->vfs_inode, h->xattr_name, value,
 				     strlen(value), 0);
 		if (!ret) {
-			ret = h->apply(&inode->vfs_inode, value, strlen(value));
+			ret = h->apply(inode, value, strlen(value));
 			if (ret)
 				btrfs_setxattr(trans, &inode->vfs_inode, h->xattr_name,
 					       NULL, 0, 0);
-- 
2.47.1


