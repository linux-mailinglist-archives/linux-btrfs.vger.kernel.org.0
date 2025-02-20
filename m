Return-Path: <linux-btrfs+bounces-11624-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6DCA3D5E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB3B3BC0E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDF71F3FC1;
	Thu, 20 Feb 2025 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZlxQItG5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZlxQItG5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787901F3D59
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045692; cv=none; b=QbCUGMmXnSM+9BWPy8zI+Pbjjnm0mwULQAJgUwx7U240LhJQIjRi2a0JFpd+duyTwgerqoZDf5MXid6jwnjQUHjSP7nEllVWvolA+lFDV51rrzorjunXFzYI9ievXhkK0eNsGHdZRaENLxnOQeYOPSGi4yD7AuX8BIdLCweyLJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045692; c=relaxed/simple;
	bh=Mb7PWOHePadHQiIAyQWaimzmHX/yvlOHxri3YkK8q1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2K0+iRaDBKhla6X4/a7LfiuoeuKeyhP8g8fRilb40caWk0t2LZsyYGJz5EtOg5+KeZWZnUOupQZFtHBkxCCZwj7phGUfTZbylJRSaD6rOjNfijxQWhsxk1fJy1iftaDHhDeSpfyEt/vLbIJKvduL/Zb/n2GLo6XlHTTQGH6Ygg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZlxQItG5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZlxQItG5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A9B172117C;
	Thu, 20 Feb 2025 10:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VSZDS6ucxl8xTcoR2TkRABqO/DtZ25lRHio2pn3jOAQ=;
	b=ZlxQItG5f1vPQdwS0oMKMebU4w+L88a8vh+viGa3jDmCWAIYayqQO7OdnyWfhJMDgSJbxi
	Sd3wtOF/xpoxsMcfu/ZauVgMEoGVAkfC0lkhjOe02khtTuLZfZ41eFhO4sOMIt0vj+wLPl
	n7BZoVKVHbBCu5Bj6v1aUsy1efvQy+U=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VSZDS6ucxl8xTcoR2TkRABqO/DtZ25lRHio2pn3jOAQ=;
	b=ZlxQItG5f1vPQdwS0oMKMebU4w+L88a8vh+viGa3jDmCWAIYayqQO7OdnyWfhJMDgSJbxi
	Sd3wtOF/xpoxsMcfu/ZauVgMEoGVAkfC0lkhjOe02khtTuLZfZ41eFhO4sOMIt0vj+wLPl
	n7BZoVKVHbBCu5Bj6v1aUsy1efvQy+U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A252C13301;
	Thu, 20 Feb 2025 10:01:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bxyfJ3j9tmeJfwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Feb 2025 10:01:28 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 12/22] btrfs: pass struct btrfs_inode to btrfs_inode_inherit_props()
Date: Thu, 20 Feb 2025 11:01:24 +0100
Message-ID: <539e9071bdc7c268eeddf0c9d3ed21a7cb8ec185.1740045551.git.dsterba@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

Pass a struct btrfs_inode to btrfs_inherit_props() as it's an internal
interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c |  6 ++++--
 fs/btrfs/props.c | 23 +++++++++++------------
 fs/btrfs/props.h |  5 ++---
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8be41aec8dc6..a1ea93bad80e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6451,11 +6451,13 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		if (IS_ERR(parent)) {
 			ret = PTR_ERR(parent);
 		} else {
-			ret = btrfs_inode_inherit_props(trans, inode, parent);
+			ret = btrfs_inode_inherit_props(trans, BTRFS_I(inode),
+							BTRFS_I(parent));
 			iput(parent);
 		}
 	} else {
-		ret = btrfs_inode_inherit_props(trans, inode, dir);
+		ret = btrfs_inode_inherit_props(trans, BTRFS_I(inode),
+						BTRFS_I(dir));
 	}
 	if (ret) {
 		btrfs_err(fs_info,
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index 74d3217fc686..16e84a2e24f4 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -386,16 +386,16 @@ static struct prop_handler prop_handlers[] = {
 };
 
 int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
-			      struct inode *inode, const struct inode *parent)
+			      struct btrfs_inode *inode,
+			      const struct btrfs_inode *parent)
 {
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret;
 	int i;
 	bool need_reserve = false;
 
-	if (!test_bit(BTRFS_INODE_HAS_PROPS,
-		      &BTRFS_I(parent)->runtime_flags))
+	if (!test_bit(BTRFS_INODE_HAS_PROPS, &parent->runtime_flags))
 		return 0;
 
 	for (i = 0; i < ARRAY_SIZE(prop_handlers); i++) {
@@ -406,10 +406,10 @@ int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
 		if (!h->inheritable)
 			continue;
 
-		if (h->ignore(BTRFS_I(inode)))
+		if (h->ignore(inode))
 			continue;
 
-		value = h->extract(parent);
+		value = h->extract(&parent->vfs_inode);
 		if (!value)
 			continue;
 
@@ -417,7 +417,7 @@ int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
 		 * This is not strictly necessary as the property should be
 		 * valid, but in case it isn't, don't propagate it further.
 		 */
-		ret = h->validate(BTRFS_I(inode), value, strlen(value));
+		ret = h->validate(inode, value, strlen(value));
 		if (ret)
 			continue;
 
@@ -437,16 +437,15 @@ int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
 				return ret;
 		}
 
-		ret = btrfs_setxattr(trans, inode, h->xattr_name, value,
+		ret = btrfs_setxattr(trans, &inode->vfs_inode, h->xattr_name, value,
 				     strlen(value), 0);
 		if (!ret) {
-			ret = h->apply(inode, value, strlen(value));
+			ret = h->apply(&inode->vfs_inode, value, strlen(value));
 			if (ret)
-				btrfs_setxattr(trans, inode, h->xattr_name,
+				btrfs_setxattr(trans, &inode->vfs_inode, h->xattr_name,
 					       NULL, 0, 0);
 			else
-				set_bit(BTRFS_INODE_HAS_PROPS,
-					&BTRFS_I(inode)->runtime_flags);
+				set_bit(BTRFS_INODE_HAS_PROPS, &inode->runtime_flags);
 		}
 
 		if (need_reserve) {
diff --git a/fs/btrfs/props.h b/fs/btrfs/props.h
index a0cc2a7a1e2e..15d9a025c923 100644
--- a/fs/btrfs/props.h
+++ b/fs/btrfs/props.h
@@ -9,7 +9,6 @@
 #include <linux/types.h>
 #include <linux/compiler_types.h>
 
-struct inode;
 struct btrfs_inode;
 struct btrfs_path;
 struct btrfs_trans_handle;
@@ -26,7 +25,7 @@ bool btrfs_ignore_prop(const struct btrfs_inode *inode, const char *name);
 int btrfs_load_inode_props(struct btrfs_inode *inode, struct btrfs_path *path);
 
 int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
-			      struct inode *inode,
-			      const struct inode *dir);
+			      struct btrfs_inode *inode,
+			      const struct btrfs_inode *dir);
 
 #endif
-- 
2.47.1


