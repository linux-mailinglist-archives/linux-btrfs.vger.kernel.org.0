Return-Path: <linux-btrfs+bounces-11852-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 295D6A45AB8
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AA818954EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CB72459CA;
	Wed, 26 Feb 2025 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CYX0U+x4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CYX0U+x4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1CA26E64D
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563493; cv=none; b=JOqUIRh/bvF/L0X8IKmcl0nMjuf0Z5yZs5vFRaLkd61cOJA7dZKrI/KnwDIeImxOVENteqwzZyfo4AefxqNLmH+9dj5UwLBfZBEYsO3Ec8QfXIo89r4NqrJ7Rmdrn4oBM2xOtqLBjMPoTVALSxqZdhzqjDP914546yVTXHuiKTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563493; c=relaxed/simple;
	bh=41/blW30hjCzlalQLuEhKfCWuIwjkoarHnp7hfLcNpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buXngSQbbZFsAAGpJn4RejOaquJpZD07cdMHC1aOF4++eDS6oCqzpJCzXukU8XSqNV/HIwWTIAdo5R81x8K8qZxEf/9MWw+/tZynLiPC+wz3FVhLuSTU7F9LaLB9aEJX4p7skvA+JLSgmpcGBU9dxw9vm/rKEqTiAKQL4Kem2mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CYX0U+x4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CYX0U+x4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DEEA51F387;
	Wed, 26 Feb 2025 09:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4NzLrRkJyMuLPDPqcJOYl6O/pXn2lW0dClL48Xb5H0=;
	b=CYX0U+x45GDK1Rf7A1ZBFj+jEJo06sqGVH8yQBACgQ+ZBWMW48mKQyPBXwL80zkZpezuab
	Df1aL18agBy92U7a+0DbQEru0NZMKy/VUNDnLQlmZRsK+4az1dimlgAcb+kYWsd5+b+Z3h
	9jxHni+JOyYxzQ2ShwBmLz7U35rwYs4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4NzLrRkJyMuLPDPqcJOYl6O/pXn2lW0dClL48Xb5H0=;
	b=CYX0U+x45GDK1Rf7A1ZBFj+jEJo06sqGVH8yQBACgQ+ZBWMW48mKQyPBXwL80zkZpezuab
	Df1aL18agBy92U7a+0DbQEru0NZMKy/VUNDnLQlmZRsK+4az1dimlgAcb+kYWsd5+b+Z3h
	9jxHni+JOyYxzQ2ShwBmLz7U35rwYs4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D87D713A53;
	Wed, 26 Feb 2025 09:51:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /nrYNAXkvmcYYgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:51:01 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 07/27] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_commit_inode_delayed_items()
Date: Wed, 26 Feb 2025 10:51:01 +0100
Message-ID: <c0f71453c5298531b2ed7f0e2b0d51ccfedec382.1740562070.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740562070.git.dsterba@suse.com>
References: <cover.1740562070.git.dsterba@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/delayed-inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 1a65f209339b..3f1551d8a5c6 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1211,7 +1211,7 @@ int btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
 				     struct btrfs_inode *inode)
 {
 	struct btrfs_delayed_node *delayed_node = btrfs_get_delayed_node(inode);
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_block_rsv *block_rsv;
 	int ret;
 
@@ -1238,7 +1238,6 @@ int btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
 	ret = __btrfs_commit_inode_delayed_items(trans, path, delayed_node);
 
 	btrfs_release_delayed_node(delayed_node);
-	btrfs_free_path(path);
 	trans->block_rsv = block_rsv;
 
 	return ret;
-- 
2.47.1


