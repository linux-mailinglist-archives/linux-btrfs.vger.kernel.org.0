Return-Path: <linux-btrfs+bounces-1761-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C3783B3C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 22:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE111F27203
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 21:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867A9135A4C;
	Wed, 24 Jan 2024 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YL/GWlgI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YL/GWlgI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7B01353E3
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 21:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131157; cv=none; b=i3hYqVu6BAjVGdQH3cpw+U/Iol+1RJKHwcayd2pEZBqaJq2F3pqG6Uds52EAQ2gK8rZFoaLy0rkJj3Z0SURoBI0+tvAMJ1o0pcQZEc9g3gnB2wGaUDqOWKK1WSK4BLlFuGM9iCn5qRNn9jhA+dz5VpG2sMOc20lfJyC74uQel2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131157; c=relaxed/simple;
	bh=JN5QG6XxSVbwMEWeyBRU0j/8O2KXJ5Q3r/kJxfCpeQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i071iUj+WFsFr1JWfchxyCbaFuVxgrrJfBQacjazJvhigurOQr/+gYCeG+noh8wlSCnwodcDOO3xtV/KbXBNPHmCy6GmVsaB+8BoKshmAQZODW0RACkRyHB7lPt72IqfE5wp1gT5rTh8qX9HS01KoJpxnAf/QFxKdudf9W5wItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YL/GWlgI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YL/GWlgI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9F3C221F87;
	Wed, 24 Jan 2024 21:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhCfMhN6tJbKT9+sOxn+ehxfvcSJfJuTS9YtXqVh7Uw=;
	b=YL/GWlgI2gBocjpg5TXZ/lHA0KRYTOX4IekLpMUUz9EnbZvfut7YfHv6WF822qGJRfk//E
	GdISANx/CB/FE+kEm+Bzfm9DqNkQROjm9UeU2o3pTtGjFtgp3p48svNcGGeudURfugmARp
	F/NjnwbAGc4P5+GyE4Ixl7l6LHXTnQY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706131152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhCfMhN6tJbKT9+sOxn+ehxfvcSJfJuTS9YtXqVh7Uw=;
	b=YL/GWlgI2gBocjpg5TXZ/lHA0KRYTOX4IekLpMUUz9EnbZvfut7YfHv6WF822qGJRfk//E
	GdISANx/CB/FE+kEm+Bzfm9DqNkQROjm9UeU2o3pTtGjFtgp3p48svNcGGeudURfugmARp
	F/NjnwbAGc4P5+GyE4Ixl7l6LHXTnQY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9726513786;
	Wed, 24 Jan 2024 21:19:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NFTlJNB+sWX5dwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Jan 2024 21:19:12 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 19/20] btrfs: move transaction abort to the error site in btrfs_create_free_space_tree()
Date: Wed, 24 Jan 2024 22:18:51 +0100
Message-ID: <633cbee03887a6eaac3f9cfbc32a40298a578e13.1706130791.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1706130791.git.dsterba@suse.com>
References: <cover.1706130791.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
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

The recommended pattern for transaction abort after error is to place it
right after the error is handled. That way it's easier to locate where
it failed and help debugging.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/free-space-tree.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 888185265f4b..bdc2341c43e4 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1176,12 +1176,16 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 					    BTRFS_FREE_SPACE_TREE_OBJECTID);
 	if (IS_ERR(free_space_root)) {
 		ret = PTR_ERR(free_space_root);
-		goto abort;
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
+		goto out_clear;
 	}
 	ret = btrfs_global_root_insert(free_space_root);
 	if (ret) {
 		btrfs_put_root(free_space_root);
-		goto abort;
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
+		goto out_clear;
 	}
 
 	node = rb_first_cached(&fs_info->block_group_cache_tree);
@@ -1189,8 +1193,11 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 		block_group = rb_entry(node, struct btrfs_block_group,
 				       cache_node);
 		ret = populate_free_space_tree(trans, block_group);
-		if (ret)
-			goto abort;
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			btrfs_end_transaction(trans);
+			goto out_clear;
+		}
 		node = rb_next(node);
 	}
 
@@ -1206,11 +1213,9 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 	clear_bit(BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED, &fs_info->flags);
 	return ret;
 
-abort:
+out_clear:
 	clear_bit(BTRFS_FS_CREATING_FREE_SPACE_TREE, &fs_info->flags);
 	clear_bit(BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED, &fs_info->flags);
-	btrfs_abort_transaction(trans, ret);
-	btrfs_end_transaction(trans);
 	return ret;
 }
 
-- 
2.42.1


