Return-Path: <linux-btrfs+bounces-11983-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9D5A4C3EB
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 15:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7031895B0F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 14:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94DA213E8E;
	Mon,  3 Mar 2025 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Vo2ALmRV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Vo2ALmRV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFFA213E62
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013734; cv=none; b=cgM7/MPR3WfNQ7a+i6JAk9Glz+WKaAmU+86l0REJnAJrJodGqLpdFXFA6K8ihNIeXD2LASBJ3ycRRCRrwWYWuF99pmB4CwWm8yIEZGc9Kw9Xl2rQ/ygBVo6Tw82LBR+ySUClh7XYtGhFNeXYb3LSQFvJgfoTLUAp/Xszis/MgJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013734; c=relaxed/simple;
	bh=CANA33Lp6sgR+WlYVbVp7SivFxDhtjLO0NQGcgf5QJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7DQkihfSmGXt4zZP/ZfPdmdN9ZRoiBTW4VJqUDhPYgOyepQHbrLzkR3A75NxezxQ++uKee36bInkdVqTMfFqo3sZiXB+Kj0dzDNNvqYlUigBGBGPJNTnDDSVoLVB9bIlywRq0qAzzI8hUmepYYT8nc2XCqk9d7moA7cZ5F0seo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Vo2ALmRV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Vo2ALmRV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8935D1F383;
	Mon,  3 Mar 2025 14:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741013730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fGo0Sa4y/VTFojzcdlJPTQuXhEGy9mcFAzy8LfkGfJk=;
	b=Vo2ALmRVZQTSwrEPu/glq6Peay7AgWoZVVqqp5Z2uU1agUYReAIvt4vL4SIRrqDU5wedI5
	jgK5ER/FlqZ7OjglWmfa0cDQp2qBhHAXOIAWK5DKCZIHBbkOdZeWtT++Ytv+B/H3D1m0Ah
	0ZuYEM+cgrLzc1OC98SiALO/iG7DQSg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741013730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fGo0Sa4y/VTFojzcdlJPTQuXhEGy9mcFAzy8LfkGfJk=;
	b=Vo2ALmRVZQTSwrEPu/glq6Peay7AgWoZVVqqp5Z2uU1agUYReAIvt4vL4SIRrqDU5wedI5
	jgK5ER/FlqZ7OjglWmfa0cDQp2qBhHAXOIAWK5DKCZIHBbkOdZeWtT++Ytv+B/H3D1m0Ah
	0ZuYEM+cgrLzc1OC98SiALO/iG7DQSg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81BF813939;
	Mon,  3 Mar 2025 14:55:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s0mrH+LCxWc8AwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 03 Mar 2025 14:55:30 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 4/7] btrfs: pass struct btrfs_inode to btrfs_sync_inode_flags_to_i_flags()
Date: Mon,  3 Mar 2025 15:55:26 +0100
Message-ID: <ec71dbe1dc7a6d4cde2a722662498e0c16972694.1741012265.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1741012265.git.dsterba@suse.com>
References: <cover.1741012265.git.dsterba@suse.com>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Pass a struct btrfs_inode to btrfs_sync_inode_flags_to_i_flags() as it's
an internal interface.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c  |  4 ++--
 fs/btrfs/ioctl.c  | 19 +++++++++----------
 fs/btrfs/ioctl.h  |  4 ++--
 fs/btrfs/verity.c |  4 ++--
 4 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ae1405b49a9f..63148b40b74a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4056,7 +4056,7 @@ static int btrfs_read_locked_inode(struct btrfs_inode *inode, struct btrfs_path
 		break;
 	}
 
-	btrfs_sync_inode_flags_to_i_flags(vfs_inode);
+	btrfs_sync_inode_flags_to_i_flags(inode);
 
 	ret = btrfs_add_inode_to_root(inode, true);
 	if (ret)
@@ -6279,7 +6279,7 @@ static void btrfs_inherit_iflags(struct btrfs_inode *inode, struct btrfs_inode *
 			inode->flags |= BTRFS_INODE_NODATASUM;
 	}
 
-	btrfs_sync_inode_flags_to_i_flags(&inode->vfs_inode);
+	btrfs_sync_inode_flags_to_i_flags(inode);
 }
 
 int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 74de458b6496..b05b81a95fc1 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -167,25 +167,24 @@ static unsigned int btrfs_inode_flags_to_fsflags(const struct btrfs_inode *binod
 /*
  * Update inode->i_flags based on the btrfs internal flags.
  */
-void btrfs_sync_inode_flags_to_i_flags(struct inode *inode)
+void btrfs_sync_inode_flags_to_i_flags(struct btrfs_inode *inode)
 {
-	struct btrfs_inode *binode = BTRFS_I(inode);
 	unsigned int new_fl = 0;
 
-	if (binode->flags & BTRFS_INODE_SYNC)
+	if (inode->flags & BTRFS_INODE_SYNC)
 		new_fl |= S_SYNC;
-	if (binode->flags & BTRFS_INODE_IMMUTABLE)
+	if (inode->flags & BTRFS_INODE_IMMUTABLE)
 		new_fl |= S_IMMUTABLE;
-	if (binode->flags & BTRFS_INODE_APPEND)
+	if (inode->flags & BTRFS_INODE_APPEND)
 		new_fl |= S_APPEND;
-	if (binode->flags & BTRFS_INODE_NOATIME)
+	if (inode->flags & BTRFS_INODE_NOATIME)
 		new_fl |= S_NOATIME;
-	if (binode->flags & BTRFS_INODE_DIRSYNC)
+	if (inode->flags & BTRFS_INODE_DIRSYNC)
 		new_fl |= S_DIRSYNC;
-	if (binode->ro_flags & BTRFS_INODE_RO_VERITY)
+	if (inode->ro_flags & BTRFS_INODE_RO_VERITY)
 		new_fl |= S_VERITY;
 
-	set_mask_bits(&inode->i_flags,
+	set_mask_bits(&inode->vfs_inode.i_flags,
 		      S_SYNC | S_APPEND | S_IMMUTABLE | S_NOATIME | S_DIRSYNC |
 		      S_VERITY, new_fl);
 }
@@ -394,7 +393,7 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 update_flags:
 	binode->flags = binode_flags;
 	btrfs_update_inode_mapping_flags(binode);
-	btrfs_sync_inode_flags_to_i_flags(inode);
+	btrfs_sync_inode_flags_to_i_flags(binode);
 	inode_inc_iversion(inode);
 	inode_set_ctime_current(inode);
 	ret = btrfs_update_inode(trans, BTRFS_I(inode));
diff --git a/fs/btrfs/ioctl.h b/fs/btrfs/ioctl.h
index 18c45851e0b6..e08ea446cf48 100644
--- a/fs/btrfs/ioctl.h
+++ b/fs/btrfs/ioctl.h
@@ -9,8 +9,8 @@ struct file;
 struct dentry;
 struct mnt_idmap;
 struct fileattr;
-struct inode;
 struct io_uring_cmd;
+struct btrfs_inode;
 struct btrfs_fs_info;
 struct btrfs_ioctl_balance_args;
 
@@ -20,7 +20,7 @@ int btrfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
 int btrfs_fileattr_set(struct mnt_idmap *idmap,
 		       struct dentry *dentry, struct fileattr *fa);
 int btrfs_ioctl_get_supported_features(void __user *arg);
-void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
+void btrfs_sync_inode_flags_to_i_flags(struct btrfs_inode *inode);
 void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
 				     struct btrfs_ioctl_balance_args *bargs);
 int btrfs_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index e97ad824ae16..b7a96a005487 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -485,7 +485,7 @@ static int rollback_verity(struct btrfs_inode *inode)
 		goto out;
 	}
 	inode->ro_flags &= ~BTRFS_INODE_RO_VERITY;
-	btrfs_sync_inode_flags_to_i_flags(&inode->vfs_inode);
+	btrfs_sync_inode_flags_to_i_flags(inode);
 	ret = btrfs_update_inode(trans, inode);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
@@ -552,7 +552,7 @@ static int finish_verity(struct btrfs_inode *inode, const void *desc,
 		goto out;
 	}
 	inode->ro_flags |= BTRFS_INODE_RO_VERITY;
-	btrfs_sync_inode_flags_to_i_flags(&inode->vfs_inode);
+	btrfs_sync_inode_flags_to_i_flags(inode);
 	ret = btrfs_update_inode(trans, inode);
 	if (ret)
 		goto end_trans;
-- 
2.47.1


