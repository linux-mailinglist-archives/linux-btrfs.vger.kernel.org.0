Return-Path: <linux-btrfs+bounces-11622-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE345A3D5E0
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B193BBE02
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B94C1F3D2C;
	Thu, 20 Feb 2025 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CCQ742cB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CCQ742cB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000591F3BA4
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045685; cv=none; b=RyoT13UaDdj37nf3Mfc4CBEmQC6pCR74mBxjIZTV0HOuBbpEqYTdMRMuKOPHH/bC1qaWz3sEHBj60zQDecgnDjhFAFyFHp+LqUBQCnQvzqvH0PM9OF3ag63YOutOgQtSYYEZEoR56qFBUTu+9zBQNVMYD0M/vn+5CajW+/Smmg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045685; c=relaxed/simple;
	bh=u6wCe3NA0KN0hW2xJfjbIVWW4/AhOET9IG/PTmOQSpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qX8f2vsP2EfaPK0zqXsoGjPXmnVzCuP9iXvvkQhbaKeWvDPE039pHFmQTr8LXy+gB1GcEafh2TFxidd0jeGpzWUykIz7Gv3r+pB2PlaxD9+hSAfCXdmFYm4YNX8+wzI1A9y9Sgiijb9Wt0ACJhcrr9wNdPenjugpPuV0Rt9egOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CCQ742cB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CCQ742cB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47F7E2117C;
	Thu, 20 Feb 2025 10:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3qyuGQ1OIWa0Hgb2O3dvN4k1Ww3neC09LljEtKnimo=;
	b=CCQ742cB8TrOT0POGLa/vOBmCDko5+wMml0w9UMVhbJLtdf0sxC4ibdo04vlYEbLK340o/
	XZkR8QwgSarAv/XQPJKu6xaCQ2xrKfUI5B22rPUYWAYlUIAf7cmgxXi++PvYZRmMzH1Vdh
	Q+wf68/FcFUdMiWNFojOjElU8kXf/rM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=CCQ742cB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3qyuGQ1OIWa0Hgb2O3dvN4k1Ww3neC09LljEtKnimo=;
	b=CCQ742cB8TrOT0POGLa/vOBmCDko5+wMml0w9UMVhbJLtdf0sxC4ibdo04vlYEbLK340o/
	XZkR8QwgSarAv/XQPJKu6xaCQ2xrKfUI5B22rPUYWAYlUIAf7cmgxXi++PvYZRmMzH1Vdh
	Q+wf68/FcFUdMiWNFojOjElU8kXf/rM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 417E813301;
	Thu, 20 Feb 2025 10:01:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F//7D3L9tmeDfwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Feb 2025 10:01:22 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 11/22] btrfs: pass struct btrfs_inode to btrfs_load_inode_props()
Date: Thu, 20 Feb 2025 11:01:21 +0100
Message-ID: <61f432ef67d88adcd7ce8bba68d7bcfac959283f.1740045551.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: 47F7E2117C
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

Pass a struct btrfs_inode to btrfs_load_inode_props() as it's an
internal interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 fs/btrfs/props.c | 9 +++++----
 fs/btrfs/props.h | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c21d60de936d..8be41aec8dc6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4007,7 +4007,7 @@ static int btrfs_read_locked_inode(struct btrfs_inode *inode, struct btrfs_path
 					   btrfs_ino(inode), &first_xattr_slot);
 	if (first_xattr_slot != -1) {
 		path->slots[0] = first_xattr_slot;
-		ret = btrfs_load_inode_props(vfs_inode, path);
+		ret = btrfs_load_inode_props(inode, path);
 		if (ret)
 			btrfs_err(fs_info,
 				  "error loading props for ino %llu (root %llu): %d",
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index b8fa34e16abb..74d3217fc686 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -273,12 +273,13 @@ static void inode_prop_iterator(void *ctx,
 		set_bit(BTRFS_INODE_HAS_PROPS, &BTRFS_I(inode)->runtime_flags);
 }
 
-int btrfs_load_inode_props(struct inode *inode, struct btrfs_path *path)
+int btrfs_load_inode_props(struct btrfs_inode *inode, struct btrfs_path *path)
 {
-	struct btrfs_root *root = BTRFS_I(inode)->root;
-	u64 ino = btrfs_ino(BTRFS_I(inode));
+	struct btrfs_root *root = inode->root;
+	u64 ino = btrfs_ino(inode);
 
-	return iterate_object_props(root, path, ino, inode_prop_iterator, inode);
+	return iterate_object_props(root, path, ino, inode_prop_iterator,
+				    &inode->vfs_inode);
 }
 
 static int prop_compression_validate(const struct btrfs_inode *inode,
diff --git a/fs/btrfs/props.h b/fs/btrfs/props.h
index 86849d4e7938..a0cc2a7a1e2e 100644
--- a/fs/btrfs/props.h
+++ b/fs/btrfs/props.h
@@ -23,7 +23,7 @@ int btrfs_validate_prop(const struct btrfs_inode *inode, const char *name,
 			const char *value, size_t value_len);
 bool btrfs_ignore_prop(const struct btrfs_inode *inode, const char *name);
 
-int btrfs_load_inode_props(struct inode *inode, struct btrfs_path *path);
+int btrfs_load_inode_props(struct btrfs_inode *inode, struct btrfs_path *path);
 
 int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
 			      struct inode *inode,
-- 
2.47.1


