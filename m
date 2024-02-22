Return-Path: <linux-btrfs+bounces-2642-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5C885F7D6
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 13:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF281C226F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 12:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12285FBA6;
	Thu, 22 Feb 2024 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A4OioZpZ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A4OioZpZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0389E60BB9
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604112; cv=none; b=eglLhgT76W08eCN/PP7dUmO2dk3QdKqBfybjip/4ulhbzP8ItqXtGm7JYD+cKPW1JzfU3kWzutYJAo0v/6QP87baTfqBIdFCgV0W6KsTQNJooZHFwJg1aI1nWiwoZY0pXKsdium1Wsn539REgzEabaRqMjeL5nY77CubYD2Nd54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604112; c=relaxed/simple;
	bh=LGttn2b7pUxojetZ+152YmMVt17A4qy65+2a8iupZVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+tV7Xx0TVPTxXuQemVua23RqsCwCxNWyq2PD7cJt2ADCHpNwPzbdbWbn5HZ3ZJx4evcjRgVak28VGPiesQoI9vsmcLc3Qqa2eW5p+Azc5kiJzkDM5CFqSHrPZxUtp/P0maRNYSC4yW/9zZyDcCyWlfZ/s18TbDHCDmy33S//7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A4OioZpZ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A4OioZpZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 42C841F457;
	Thu, 22 Feb 2024 12:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708604108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wU6HovWVowemkHi3HahSEmAISm8wWa1pjoQ12VUUtu8=;
	b=A4OioZpZa4eHYuSJHD8/wchwpZwJq3gmBByYIr2kBzeU050ymXWRadc+LspT5lRXw1FJJ+
	MvqsIGR3DRLgSpKeRpi9CaikQtlWx8mEtV9uyUzvAMvcjUdMGnklr61k05cXH+3FXUESV8
	ME583T6XHUPTmdecG6iyw74wrjXZE+E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708604108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wU6HovWVowemkHi3HahSEmAISm8wWa1pjoQ12VUUtu8=;
	b=A4OioZpZa4eHYuSJHD8/wchwpZwJq3gmBByYIr2kBzeU050ymXWRadc+LspT5lRXw1FJJ+
	MvqsIGR3DRLgSpKeRpi9CaikQtlWx8mEtV9uyUzvAMvcjUdMGnklr61k05cXH+3FXUESV8
	ME583T6XHUPTmdecG6iyw74wrjXZE+E=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D2D513A6B;
	Thu, 22 Feb 2024 12:15:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id e7vtDsw612WfRQAAn2gu4w
	(envelope-from <dsterba@suse.com>); Thu, 22 Feb 2024 12:15:08 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/4] btrfs: merge btrfs_del_delalloc_inode() helpers
Date: Thu, 22 Feb 2024 13:14:27 +0100
Message-ID: <f2f01f7e92da448662e0cb29ee4dc06a748cbeea.1708603965.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1708603965.git.dsterba@suse.com>
References: <cover.1708603965.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

The helpers btrfs_del_delalloc_inode() and __btrfs_del_delalloc_inode()
don't follow the pattern when the "__" helper does a special case and
are in fact reversed regarding the naming. We can merge them into one as
there's only one place that needs to be open coded.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/btrfs_inode.h |  2 +-
 fs/btrfs/disk-io.c     |  2 +-
 fs/btrfs/inode.c       | 14 +++++---------
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index a35adc06ce0c..100020ca4658 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -446,7 +446,7 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			      u64 *orig_start, u64 *orig_block_len,
 			      u64 *ram_bytes, bool nowait, bool strict);
 
-void __btrfs_del_delalloc_inode(struct btrfs_inode *inode);
+void btrfs_del_delalloc_inode(struct btrfs_inode *inode);
 struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry);
 int btrfs_set_inode_index(struct btrfs_inode *dir, u64 *index);
 int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8ab185182c30..a2e45ed6ef14 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4629,7 +4629,7 @@ static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
 		struct inode *inode = NULL;
 		btrfs_inode = list_first_entry(&splice, struct btrfs_inode,
 					       delalloc_inodes);
-		__btrfs_del_delalloc_inode(btrfs_inode);
+		btrfs_del_delalloc_inode(btrfs_inode);
 		spin_unlock(&root->delalloc_lock);
 
 		/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f93cb23ae1ee..d931cb40fb7a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2410,7 +2410,7 @@ static void btrfs_add_delalloc_inode(struct btrfs_inode *inode)
 	spin_unlock(&root->delalloc_lock);
 }
 
-void __btrfs_del_delalloc_inode(struct btrfs_inode *inode)
+void btrfs_del_delalloc_inode(struct btrfs_inode *inode)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -2436,13 +2436,6 @@ void __btrfs_del_delalloc_inode(struct btrfs_inode *inode)
 	}
 }
 
-static void btrfs_del_delalloc_inode(struct btrfs_inode *inode)
-{
-	spin_lock(&inode->root->delalloc_lock);
-	__btrfs_del_delalloc_inode(inode);
-	spin_unlock(&inode->root->delalloc_lock);
-}
-
 /*
  * Properly track delayed allocation bytes in the inode and to maintain the
  * list of inodes that have pending delalloc work to be done.
@@ -2565,8 +2558,11 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 		 * and are therefore protected against concurrent calls of this
 		 * function and btrfs_set_delalloc_extent().
 		 */
-		if (!btrfs_is_free_space_inode(inode) && new_delalloc_bytes == 0)
+		if (!btrfs_is_free_space_inode(inode) && new_delalloc_bytes == 0) {
+			spin_lock(&root->delalloc_lock);
 			btrfs_del_delalloc_inode(inode);
+			spin_unlock(&root->delalloc_lock);
+		}
 	}
 
 	if ((state->state & EXTENT_DELALLOC_NEW) &&
-- 
2.42.1


