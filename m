Return-Path: <linux-btrfs+bounces-11620-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93921A3D5E6
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58BC67ABF1E
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC461F3B98;
	Thu, 20 Feb 2025 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Owhf4UY0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Owhf4UY0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F601F37BC
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045679; cv=none; b=rXPKbjc21vAmC6KiFb/c1K0TLJ0LCYBgxF7lc3W68d4rOtYmJ++3MXdnN6WzstJTna01bJWJtS1WxGjFj3u93TFWDtPdR+FclGXB3MC9ryrWhAZyRug14GYZDWUzIcx4qY2SIGLIFZVCwJPoJEc0sTXDSSt25GlJklR/JQ9G52M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045679; c=relaxed/simple;
	bh=gfDPc1dd/wAHl2doVMXGLkduDQA25HXLE0RJDxBeB1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYcaq0pib27eshhT0RJyKwD0B/OCfTKfGbNmf8bBAG88puggXgATIzcOWfdMl8YS8HppXuL8XojWesb8cbZhr5PswQCMHM9mkEat7aDJgfq79xdNtIWNxMqeY9JqxT33EfsPLJepHHoIN15V3lZUjFafLXrfK6I94Qh0O0Gdmhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Owhf4UY0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Owhf4UY0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8E6802117C;
	Thu, 20 Feb 2025 10:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f5A0sal/rBH9FzYuYZYM1zH9lotASb8WWACIEBOJyBM=;
	b=Owhf4UY0WiN2z42oY7jBi9zCqJBLWBpswmPearQ3DEW+npk6f4ayuGEWCcmBzXqi7q2FWq
	tL1Dn5sXXwVkkFyQFSIM74oXoivjL7leXj7gKX8XBiFmzLe5ezyM7oU6gf4PuC0WJQa2G0
	brrUg6ZYWoJRM6SHQSlDSLib4qdQzlY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Owhf4UY0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f5A0sal/rBH9FzYuYZYM1zH9lotASb8WWACIEBOJyBM=;
	b=Owhf4UY0WiN2z42oY7jBi9zCqJBLWBpswmPearQ3DEW+npk6f4ayuGEWCcmBzXqi7q2FWq
	tL1Dn5sXXwVkkFyQFSIM74oXoivjL7leXj7gKX8XBiFmzLe5ezyM7oU6gf4PuC0WJQa2G0
	brrUg6ZYWoJRM6SHQSlDSLib4qdQzlY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DE1813301;
	Thu, 20 Feb 2025 10:01:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Tgm6Hmn9tmd2fwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Feb 2025 10:01:13 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 09/22] btrfs: pass struct btrfs_inode to fill_stack_inode_item()
Date: Thu, 20 Feb 2025 11:01:13 +0100
Message-ID: <ea5f1c12f6bc82cd8715375ccc20d2015d7c0d6e.1740045551.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: 8E6802117C
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Pass a struct btrfs_inode to fill_stack_inode_item() as it's an internal
interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/delayed-inode.c | 46 +++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 0b4933c6a889..bcafbb5ba61d 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1817,44 +1817,43 @@ int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
 
 static void fill_stack_inode_item(struct btrfs_trans_handle *trans,
 				  struct btrfs_inode_item *inode_item,
-				  struct inode *inode)
+				  struct btrfs_inode *inode)
 {
+	struct inode *vfs_inode = &inode->vfs_inode;
 	u64 flags;
 
-	btrfs_set_stack_inode_uid(inode_item, i_uid_read(inode));
-	btrfs_set_stack_inode_gid(inode_item, i_gid_read(inode));
-	btrfs_set_stack_inode_size(inode_item, BTRFS_I(inode)->disk_i_size);
-	btrfs_set_stack_inode_mode(inode_item, inode->i_mode);
-	btrfs_set_stack_inode_nlink(inode_item, inode->i_nlink);
-	btrfs_set_stack_inode_nbytes(inode_item, inode_get_bytes(inode));
-	btrfs_set_stack_inode_generation(inode_item,
-					 BTRFS_I(inode)->generation);
+	btrfs_set_stack_inode_uid(inode_item, i_uid_read(vfs_inode));
+	btrfs_set_stack_inode_gid(inode_item, i_gid_read(vfs_inode));
+	btrfs_set_stack_inode_size(inode_item, inode->disk_i_size);
+	btrfs_set_stack_inode_mode(inode_item, vfs_inode->i_mode);
+	btrfs_set_stack_inode_nlink(inode_item, vfs_inode->i_nlink);
+	btrfs_set_stack_inode_nbytes(inode_item, inode_get_bytes(vfs_inode));
+	btrfs_set_stack_inode_generation(inode_item, inode->generation);
 	btrfs_set_stack_inode_sequence(inode_item,
-				       inode_peek_iversion(inode));
+				       inode_peek_iversion(vfs_inode));
 	btrfs_set_stack_inode_transid(inode_item, trans->transid);
-	btrfs_set_stack_inode_rdev(inode_item, inode->i_rdev);
-	flags = btrfs_inode_combine_flags(BTRFS_I(inode)->flags,
-					  BTRFS_I(inode)->ro_flags);
+	btrfs_set_stack_inode_rdev(inode_item, vfs_inode->i_rdev);
+	flags = btrfs_inode_combine_flags(inode->flags, inode->ro_flags);
 	btrfs_set_stack_inode_flags(inode_item, flags);
 	btrfs_set_stack_inode_block_group(inode_item, 0);
 
 	btrfs_set_stack_timespec_sec(&inode_item->atime,
-				     inode_get_atime_sec(inode));
+				     inode_get_atime_sec(vfs_inode));
 	btrfs_set_stack_timespec_nsec(&inode_item->atime,
-				      inode_get_atime_nsec(inode));
+				      inode_get_atime_nsec(vfs_inode));
 
 	btrfs_set_stack_timespec_sec(&inode_item->mtime,
-				     inode_get_mtime_sec(inode));
+				     inode_get_mtime_sec(vfs_inode));
 	btrfs_set_stack_timespec_nsec(&inode_item->mtime,
-				      inode_get_mtime_nsec(inode));
+				      inode_get_mtime_nsec(vfs_inode));
 
 	btrfs_set_stack_timespec_sec(&inode_item->ctime,
-				     inode_get_ctime_sec(inode));
+				     inode_get_ctime_sec(vfs_inode));
 	btrfs_set_stack_timespec_nsec(&inode_item->ctime,
-				      inode_get_ctime_nsec(inode));
+				      inode_get_ctime_nsec(vfs_inode));
 
-	btrfs_set_stack_timespec_sec(&inode_item->otime, BTRFS_I(inode)->i_otime_sec);
-	btrfs_set_stack_timespec_nsec(&inode_item->otime, BTRFS_I(inode)->i_otime_nsec);
+	btrfs_set_stack_timespec_sec(&inode_item->otime, inode->i_otime_sec);
+	btrfs_set_stack_timespec_nsec(&inode_item->otime, inode->i_otime_nsec);
 }
 
 int btrfs_fill_inode(struct inode *inode, u32 *rdev)
@@ -1928,8 +1927,7 @@ int btrfs_delayed_update_inode(struct btrfs_trans_handle *trans,
 
 	mutex_lock(&delayed_node->mutex);
 	if (test_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags)) {
-		fill_stack_inode_item(trans, &delayed_node->inode_item,
-				      &inode->vfs_inode);
+		fill_stack_inode_item(trans, &delayed_node->inode_item, inode);
 		goto release_node;
 	}
 
@@ -1937,7 +1935,7 @@ int btrfs_delayed_update_inode(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto release_node;
 
-	fill_stack_inode_item(trans, &delayed_node->inode_item, &inode->vfs_inode);
+	fill_stack_inode_item(trans, &delayed_node->inode_item, inode);
 	set_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags);
 	delayed_node->count++;
 	atomic_inc(&root->fs_info->delayed_root->items);
-- 
2.47.1


