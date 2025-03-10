Return-Path: <linux-btrfs+bounces-12151-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E526A5A3CF
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 20:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF09716C16D
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 19:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2309236420;
	Mon, 10 Mar 2025 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Lrm2VZT8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w7JC7BwT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Lrm2VZT8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w7JC7BwT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F41C18FDAB
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 19:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741634962; cv=none; b=F/wOG4TlGhPjwXHj41tcHZ3wNjkizRtRbN4lyHvYjUniXoRqyd6SP2nRxIFmb5q/AP0TCsK+JWdBVvIyyudrSbrF/qRUfUWgiOgHQF02+TkfIEk8JDAR66S+/qP4+GiV1k7JgqNbC2t7LMXU+jOTKqYa7VcLlj1odg47XsArOAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741634962; c=relaxed/simple;
	bh=Tjc0lsXpEC2t0oFDAU4aWTPoiTleJI8Jyqp9fGWBj3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kY6bcC6xqzkVWcoirsyc82N5FInebaOYZA37kj7+ylgll4mu7wlzh51c8eNSVSDrttz+NUcK8c62CqQvo+3E0MLbcO4S3Y5oqd4lvsOjoSJAw0u3E9HTL/ejCx3SgWVPA5UQPyqRHBJQl5spkqfqB767Dt+gENa9Ik94QxSeT0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Lrm2VZT8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w7JC7BwT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Lrm2VZT8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w7JC7BwT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 877CD21169;
	Mon, 10 Mar 2025 19:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741634958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=siPtEEzc5kO9o7BXJzCUhZ/42IE3PCvAvIdpAPVAPUM=;
	b=Lrm2VZT8X2BG5av5bOcOkhr91buuQ8hPvZkbii12egQfrgIhDsBPIDWbxZd4vXd0ivMfnv
	ySp+52GeFtShR/XA2pDeU0MEtyYAkMfjGHVHtsuR5fvpE++oi+Uo8Em/u82iRILjWWyhXk
	kPkb3xxlaffyN7caagYBl3y6sN80CNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741634958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=siPtEEzc5kO9o7BXJzCUhZ/42IE3PCvAvIdpAPVAPUM=;
	b=w7JC7BwTNe08aDgA8ZLrUuIipYGQXfGrwKBPVmhYg7FPbuUJetGO9ZYSUYM3eo1EFbpJnq
	puiETFvVnwaqluAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Lrm2VZT8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=w7JC7BwT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741634958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=siPtEEzc5kO9o7BXJzCUhZ/42IE3PCvAvIdpAPVAPUM=;
	b=Lrm2VZT8X2BG5av5bOcOkhr91buuQ8hPvZkbii12egQfrgIhDsBPIDWbxZd4vXd0ivMfnv
	ySp+52GeFtShR/XA2pDeU0MEtyYAkMfjGHVHtsuR5fvpE++oi+Uo8Em/u82iRILjWWyhXk
	kPkb3xxlaffyN7caagYBl3y6sN80CNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741634958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=siPtEEzc5kO9o7BXJzCUhZ/42IE3PCvAvIdpAPVAPUM=;
	b=w7JC7BwTNe08aDgA8ZLrUuIipYGQXfGrwKBPVmhYg7FPbuUJetGO9ZYSUYM3eo1EFbpJnq
	puiETFvVnwaqluAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 430DD1399F;
	Mon, 10 Mar 2025 19:29:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sWzxCY49z2ezFAAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Mon, 10 Mar 2025 19:29:18 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 1/2] btrfs: add mapping_set_release_always to inode's mapping
Date: Mon, 10 Mar 2025 15:29:06 -0400
Message-ID: <443ee47643ddd60d6bd6bfede4a73beec5798695.1741631234.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741631234.git.rgoldwyn@suse.com>
References: <cover.1741631234.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 877CD21169
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email,suse.de:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

BTRFS has been setting folio->private in order to get a callback to
release_folio() before a folio is released. This can also be performed
by the AS_RELEASE_ALWAYS flags set in the mapping->flags.
Calling mapping_set_release_always() on inode's address_space during
inode initialization will make unnecessary to setup folio->private for
every folio.

Setting the flag will call release_folio() for every folio
under the mapping without the need of setting folio->private. This will
eventually help btrfs move to iomap since iomap also uses folio->private
for iomap_folio_state.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent_io.c | 2 +-
 fs/btrfs/file.c      | 2 +-
 fs/btrfs/inode.c     | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a78ff093ea37..297b7168a7d6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -491,7 +491,7 @@ static void begin_folio_read(struct btrfs_fs_info *fs_info, struct folio *folio)
 	if (!btrfs_is_subpage(fs_info, folio->mapping))
 		return;
 
-	ASSERT(folio_test_private(folio));
+	ASSERT(mapping_release_always(folio->mapping));
 	btrfs_folio_set_lock(fs_info, folio, folio_pos(folio), PAGE_SIZE);
 }
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 643f101c7340..160e4030ca60 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -833,7 +833,7 @@ static int prepare_uptodate_folio(struct inode *inode, struct folio *folio, u64
 	 * The private flag check is essential for subpage as we need to store
 	 * extra bitmap using folio private.
 	 */
-	if (folio->mapping != inode->i_mapping || !folio_test_private(folio)) {
+	if (folio->mapping != inode->i_mapping || !mapping_release_always(folio->mapping)) {
 		folio_unlock(folio);
 		return -EAGAIN;
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e7e6accbaf6c..02ff9c449b35 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5616,6 +5616,8 @@ static int btrfs_init_locked_inode(struct inode *inode, void *p)
 	btrfs_set_inode_number(BTRFS_I(inode), args->ino);
 	BTRFS_I(inode)->root = btrfs_grab_root(args->root);
 
+	mapping_set_release_always(inode->i_mapping);
+
 	if (args->root && args->root == args->root->fs_info->tree_root &&
 	    args->ino != BTRFS_BTREE_INODE_OBJECTID)
 		set_bit(BTRFS_INODE_FREE_SPACE_INODE,
@@ -6698,6 +6700,7 @@ static int btrfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	inode->i_fop = &btrfs_file_operations;
 	inode->i_op = &btrfs_file_inode_operations;
 	inode->i_mapping->a_ops = &btrfs_aops;
+	mapping_set_release_always(inode->i_mapping);
 	return btrfs_create_common(dir, dentry, inode);
 }
 
-- 
2.48.1


