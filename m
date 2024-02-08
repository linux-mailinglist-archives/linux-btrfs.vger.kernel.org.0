Return-Path: <linux-btrfs+bounces-2238-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A30184DC3E
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 10:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E31B1F21E80
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 09:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD206BFBA;
	Thu,  8 Feb 2024 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KQP9+zQi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KQP9+zQi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E6E6BFAB
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382845; cv=none; b=n30w80AYYxPZeL405NX73n3mQPqzbeTyHYRA6HbL9ZkLekcNwQn9a7u+NUvSbIkuT0Rh7EyRYpFg07r8M/+Jk57Kjq6YLI05SF035CgPhPaBJYdt1wn0hQDlUQ8nJek4uJmS2dJEL4ExBuWzQ1h3D2pLB71+G4J5dyTpQb/cWmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382845; c=relaxed/simple;
	bh=IY3Dkrkswuk1H7TJCTzi9fv1K7X3TZmGI8UpoW1cBQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+7VceDSXodbvJPfgVv9IgKLN6tc3vpZlE/1u6w8R0idwYy7XhmzlIAsHOTn2tj4yaRZaOenqn15+iSmTd1Kcsmr7LMp4taNs/xqP0trQKqd3bJFdJspzoBTrXP4QFW4/ZFCokigRyBiVpUBh0tspaTJc/wZCBuVQB/6bU0b0pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KQP9+zQi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KQP9+zQi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 131071FD4F;
	Thu,  8 Feb 2024 09:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707382842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5yyr3+9zdtU3F9hkizAZQPs9PeNcynm3z5utlilt8IU=;
	b=KQP9+zQigyltSRzr6w/3Zotdw1VMEg9r+XoQcA0POANJcAM6yUbmhHxNrfLwI9hTf7iUvQ
	+7WLakNVPyh33wbnvHrNYt3mJ1EDgLfAO7jp5qQ0nMueeTBRguKKz3GPKwDQ3ywfCk5ll2
	IEJmHknoblwNMpYply6bqlPPz6bDI8M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707382842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5yyr3+9zdtU3F9hkizAZQPs9PeNcynm3z5utlilt8IU=;
	b=KQP9+zQigyltSRzr6w/3Zotdw1VMEg9r+XoQcA0POANJcAM6yUbmhHxNrfLwI9hTf7iUvQ
	+7WLakNVPyh33wbnvHrNYt3mJ1EDgLfAO7jp5qQ0nMueeTBRguKKz3GPKwDQ3ywfCk5ll2
	IEJmHknoblwNMpYply6bqlPPz6bDI8M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B77813984;
	Thu,  8 Feb 2024 09:00:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sN7KAjqYxGWxDgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 08 Feb 2024 09:00:42 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 14/14] btrfs: delete BUG_ON in btrfs_init_locked_inode()
Date: Thu,  8 Feb 2024 10:00:13 +0100
Message-ID: <c5a8743f3f71912ab38c945143884910c7ed9439.1707382595.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1707382595.git.dsterba@suse.com>
References: <cover.1707382595.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
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
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

The purpose of the BUG_ON is not clear. The helper btrfs_grab_root()
could return a NULL in case args->root would be a NULL or if there are
zero references. Then we check if the root pointer stored in the inode
still exists.

The whole call chain is for iget:

btrfs_iget
  btrfs_iget_path
    btrfs_iget_locked
      iget5_locked
	btrfs_init_locked_inode

which is called from many contexts where we the root pointer is used and
we can safely assume has enough references.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0b36dfb6754b..459ec9ba06e0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5548,7 +5548,6 @@ static int btrfs_init_locked_inode(struct inode *inode, void *p)
 	BTRFS_I(inode)->location.type = BTRFS_INODE_ITEM_KEY;
 	BTRFS_I(inode)->location.offset = 0;
 	BTRFS_I(inode)->root = btrfs_grab_root(args->root);
-	BUG_ON(args->root && !BTRFS_I(inode)->root);
 
 	if (args->root && args->root == args->root->fs_info->tree_root &&
 	    args->ino != BTRFS_BTREE_INODE_OBJECTID)
-- 
2.42.1


