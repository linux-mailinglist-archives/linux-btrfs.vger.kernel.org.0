Return-Path: <linux-btrfs+bounces-5934-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6F2915394
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 18:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5A41C22DCB
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 16:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465F819E829;
	Mon, 24 Jun 2024 16:23:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2AE19DF72
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246209; cv=none; b=UKTXIDA38nqrztilF1gRCArg7QmZmjgDAAc7ppUxTXjdteNbE8m63Oii+vNiLNPvYdUD6CR3qcWsQ3/3npnQs+H1PicBxMALIGdLEql80qNMFtqnqbtHQEHWuongunCbTXNbishxj8jyyO8OrvAvzVaIMltElh9uAVj29BNgPwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246209; c=relaxed/simple;
	bh=EdxctajvaH66EJCOHTD6PCKb+j5AEBDxMkiqA9QuCPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPz/phoLQfpkQQe/npcuBzkoZfToStsWtkZlcXoqpgg6cjPe5Y2bbJZvwxIP+uf1R7jVoZrNV7EVk4jrJPTQkdBykZnLh6eD9bqNeu8wUmGDdCM+EINcu6O8B0akyxNnDnCgfB900D7pSoLGucTJ7MBtlkk3ES1HbVo/olePnkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8509E219BE;
	Mon, 24 Jun 2024 16:23:26 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E8D01384C;
	Mon, 24 Jun 2024 16:23:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TaXjHn6deWb4LQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 24 Jun 2024 16:23:26 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 09/11] btrfs: pass a btrfs_inode to btrfs_set_prop()
Date: Mon, 24 Jun 2024 18:23:22 +0200
Message-ID: <78792470bbfd5e8964f9fd29fe5dd8f3f103a09b.1719246104.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1719246104.git.dsterba@suse.com>
References: <cover.1719246104.git.dsterba@suse.com>
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
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 8509E219BE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

Pass a struct btrfs_inode to btrfs_set_prop() as it's an
internal interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c |  8 ++++----
 fs/btrfs/props.c | 14 +++++++-------
 fs/btrfs/props.h |  2 +-
 fs/btrfs/xattr.c |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index f30242066ed2..83f773fe429d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -375,15 +375,15 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 		return PTR_ERR(trans);
 
 	if (comp) {
-		ret = btrfs_set_prop(trans, inode, "btrfs.compression", comp,
-				     strlen(comp), 0);
+		ret = btrfs_set_prop(trans, BTRFS_I(inode), "btrfs.compression",
+				     comp, strlen(comp), 0);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto out_end_trans;
 		}
 	} else {
-		ret = btrfs_set_prop(trans, inode, "btrfs.compression", NULL,
-				     0, 0);
+		ret = btrfs_set_prop(trans, BTRFS_I(inode), "btrfs.compression",
+				     NULL, 0, 0);
 		if (ret && ret != -ENODATA) {
 			btrfs_abort_transaction(trans, ret);
 			goto out_end_trans;
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index 5c8e64eaf48b..b8fa34e16abb 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -104,7 +104,7 @@ bool btrfs_ignore_prop(const struct btrfs_inode *inode, const char *name)
 	return handler->ignore(inode);
 }
 
-int btrfs_set_prop(struct btrfs_trans_handle *trans, struct inode *inode,
+int btrfs_set_prop(struct btrfs_trans_handle *trans, struct btrfs_inode *inode,
 		   const char *name, const char *value, size_t value_len,
 		   int flags)
 {
@@ -116,29 +116,29 @@ int btrfs_set_prop(struct btrfs_trans_handle *trans, struct inode *inode,
 		return -EINVAL;
 
 	if (value_len == 0) {
-		ret = btrfs_setxattr(trans, inode, handler->xattr_name,
+		ret = btrfs_setxattr(trans, &inode->vfs_inode, handler->xattr_name,
 				     NULL, 0, flags);
 		if (ret)
 			return ret;
 
-		ret = handler->apply(inode, NULL, 0);
+		ret = handler->apply(&inode->vfs_inode, NULL, 0);
 		ASSERT(ret == 0);
 
 		return ret;
 	}
 
-	ret = btrfs_setxattr(trans, inode, handler->xattr_name, value,
+	ret = btrfs_setxattr(trans, &inode->vfs_inode, handler->xattr_name, value,
 			     value_len, flags);
 	if (ret)
 		return ret;
-	ret = handler->apply(inode, value, value_len);
+	ret = handler->apply(&inode->vfs_inode, value, value_len);
 	if (ret) {
-		btrfs_setxattr(trans, inode, handler->xattr_name, NULL,
+		btrfs_setxattr(trans, &inode->vfs_inode, handler->xattr_name, NULL,
 			       0, flags);
 		return ret;
 	}
 
-	set_bit(BTRFS_INODE_HAS_PROPS, &BTRFS_I(inode)->runtime_flags);
+	set_bit(BTRFS_INODE_HAS_PROPS, &inode->runtime_flags);
 
 	return 0;
 }
diff --git a/fs/btrfs/props.h b/fs/btrfs/props.h
index 24131b29d842..63546d0a9444 100644
--- a/fs/btrfs/props.h
+++ b/fs/btrfs/props.h
@@ -15,7 +15,7 @@ struct btrfs_trans_handle;
 
 int __init btrfs_props_init(void);
 
-int btrfs_set_prop(struct btrfs_trans_handle *trans, struct inode *inode,
+int btrfs_set_prop(struct btrfs_trans_handle *trans, struct btrfs_inode *inode,
 		   const char *name, const char *value, size_t value_len,
 		   int flags);
 int btrfs_validate_prop(const struct btrfs_inode *inode, const char *name,
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 0288fe541dca..738c7bb8ea7c 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -451,7 +451,7 @@ static int btrfs_xattr_handler_set_prop(const struct xattr_handler *handler,
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	ret = btrfs_set_prop(trans, inode, name, value, size, flags);
+	ret = btrfs_set_prop(trans, BTRFS_I(inode), name, value, size, flags);
 	if (!ret) {
 		inode_inc_iversion(inode);
 		inode_set_ctime_current(inode);
-- 
2.45.0


