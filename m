Return-Path: <linux-btrfs+bounces-5931-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6C5915391
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 18:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D3F5B267F0
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 16:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44A019D8A8;
	Mon, 24 Jun 2024 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u2yWR2fn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u2yWR2fn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3428E19E82C
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246198; cv=none; b=VbAtOCh2VyhgmMWd5RXGOSFKc4aQUH0+ceZK1ijM6l5YFDFAJsXAJ1ivbHbS7CbueuHu0PPOgWj0dfi5pLP5YszI53u8S9gP8ghixdDs/zHO8Y6KIsXXidOBK4wS9wUFwzGAGM01wMyxdx7ab3SFYC5DffAp03FJx9mi/QI/YUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246198; c=relaxed/simple;
	bh=mTRGcrSnxEqPET1TS1DFFV/JBxY603B4410LPM7ul98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOU2XcdyAjormoerrBJR35T4j2KuvKcY4kvBOr10uHihbfrglZDk8S7k1xpPlC7hVFYAZJ6kQGdk6lrnX3id3g8sHQ4jtoEsRlOBJjbpGyU9LamGP36ye9gHI7oR2xbEIVWEoCJkfsWmmaRLGkk2t3wI3gp1WbYZhJRqyJns5M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u2yWR2fn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u2yWR2fn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 67CFC1F7A4;
	Mon, 24 Jun 2024 16:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719246195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VOHeVvTZb2fg5Ii5jhjJpBybvsPF0rfZ5ZY0Ap8iT9g=;
	b=u2yWR2fnZWUzWiMcqRcOVoFRXO75Fho9nqYQ7jggTsuzbkZvA/eg3EBszvXnotbCqVSX33
	4gIB9vIxi3kgzBpuUs6esy/JoKtlEYk8LH+YALN6/ZmSjJG61JCbvFQb2RMnzn1VjzCnJv
	MIMy9JXHucvjCm5+i9+jORn8/Nv4aog=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719246195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VOHeVvTZb2fg5Ii5jhjJpBybvsPF0rfZ5ZY0Ap8iT9g=;
	b=u2yWR2fnZWUzWiMcqRcOVoFRXO75Fho9nqYQ7jggTsuzbkZvA/eg3EBszvXnotbCqVSX33
	4gIB9vIxi3kgzBpuUs6esy/JoKtlEYk8LH+YALN6/ZmSjJG61JCbvFQb2RMnzn1VjzCnJv
	MIMy9JXHucvjCm5+i9+jORn8/Nv4aog=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6196F1384C;
	Mon, 24 Jun 2024 16:23:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p2LRF3OdeWbrLQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 24 Jun 2024 16:23:15 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 06/11] btrfs: switch btrfs_pending_snapshot::dir to btrfs_inode
Date: Mon, 24 Jun 2024 18:23:15 +0200
Message-ID: <ac46abcb232d7856fbe8f8aeb123b364a49ad7c7.1719246104.git.dsterba@suse.com>
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
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]

The structure is internal so we should use struct btrfs_inode for that.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c       | 2 +-
 fs/btrfs/transaction.c | 2 +-
 fs/btrfs/transaction.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d4f0445c4230..f30242066ed2 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -855,7 +855,7 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	pending_snapshot->dentry = dentry;
 	pending_snapshot->root = root;
 	pending_snapshot->readonly = readonly;
-	pending_snapshot->dir = dir;
+	pending_snapshot->dir = BTRFS_I(dir);
 	pending_snapshot->inherit = inherit;
 
 	trans = btrfs_start_transaction(root, 0);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 9590a1899b9d..cb5b5cac55e7 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1637,7 +1637,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	struct btrfs_root *root = pending->root;
 	struct btrfs_root *parent_root;
 	struct btrfs_block_rsv *rsv;
-	struct inode *parent_inode = pending->dir;
+	struct inode *parent_inode = &pending->dir->vfs_inode;
 	struct btrfs_path *path;
 	struct btrfs_dir_item *dir_item;
 	struct extent_buffer *tmp;
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 81da655b5ee7..98c03ddc760b 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -172,7 +172,7 @@ struct btrfs_trans_handle {
 
 struct btrfs_pending_snapshot {
 	struct dentry *dentry;
-	struct inode *dir;
+	struct btrfs_inode *dir;
 	struct btrfs_root *root;
 	struct btrfs_root_item *root_item;
 	struct btrfs_root *snap;
-- 
2.45.0


