Return-Path: <linux-btrfs+bounces-11633-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618E5A3D5E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5495117C9BA
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251811F540C;
	Thu, 20 Feb 2025 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="s4eUhgJP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="s4eUhgJP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D701F12EA
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045725; cv=none; b=KqAH5BjAX3YtHgI9cDMjYIdM7RqjedOMwxdWTXOkxN1qCwxfQfrrtl8Fl+wcOqE2/VbHfBVxe4NrZRP2kHu3cavQg/Xs19/k9T14oS01sIOJrWUEQ52TRgAZuj1RlwTXgwVa5PhNKeRgXfL/mSxw6QlxDUNm+tKAkiOg7hlr1YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045725; c=relaxed/simple;
	bh=wdKKAC/+NhQI2Ufhi0koXWDnpR8rMJm98x27djP1uVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4tlfIRX15uMFoMBaVOVHzb1lRR8vPRELq9L8pttgpKrSdKpoeeCneZZF8OxAFSVwSCZjSMe12pq+MStOLGqh2TLYd55dS0qRQSH69TBbTEiFQWcU9J3GG9rOXyTnnEDJ96H2t6VhRGaqYtlLoQdezODJRo0x1HVLhoI01EaBDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=s4eUhgJP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=s4eUhgJP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 338F92117C;
	Thu, 20 Feb 2025 10:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KhCeEfXhaKd9+Lpocrf6UD93REJSjjoLOWLVwMTPmsY=;
	b=s4eUhgJP6qHY88B1/wqZxiUscjzQ68Ps3FLEWZyE8JiAVIbn8B4E0StI1WFPlp60QrWMv9
	q8lQBekawc7fNeWwSGeOx3fEeJgT7psE5Iss/rk5VjSmXVSIhkIAM+dGccLXE2GMQbXjlE
	PpHGKlRLMyWzsER+b2MJLJV1TmdALD8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KhCeEfXhaKd9+Lpocrf6UD93REJSjjoLOWLVwMTPmsY=;
	b=s4eUhgJP6qHY88B1/wqZxiUscjzQ68Ps3FLEWZyE8JiAVIbn8B4E0StI1WFPlp60QrWMv9
	q8lQBekawc7fNeWwSGeOx3fEeJgT7psE5Iss/rk5VjSmXVSIhkIAM+dGccLXE2GMQbXjlE
	PpHGKlRLMyWzsER+b2MJLJV1TmdALD8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21CF813301;
	Thu, 20 Feb 2025 10:02:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +11HCJr9tmfJfwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Feb 2025 10:02:02 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 21/22] btrfs: use struct btrfs_inode inside btrfs_get_parent()
Date: Thu, 20 Feb 2025 11:01:57 +0100
Message-ID: <6a73a27071d5ca306529198259f45fadd50fd79a.1740045551.git.dsterba@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Use a struct btrfs_inode to btrfs_get_parent() as it's an internal
helper, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/export.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index c087424ac067..ab4d8625ad55 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -145,9 +145,9 @@ static struct dentry *btrfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 
 struct dentry *btrfs_get_parent(struct dentry *child)
 {
-	struct inode *dir = d_inode(child);
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
-	struct btrfs_root *root = BTRFS_I(dir)->root;
+	struct btrfs_inode *dir = BTRFS_I(d_inode(child));
+	struct btrfs_root *root = dir->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_path *path;
 	struct extent_buffer *leaf;
 	struct btrfs_root_ref *ref;
@@ -159,13 +159,13 @@ struct dentry *btrfs_get_parent(struct dentry *child)
 	if (!path)
 		return ERR_PTR(-ENOMEM);
 
-	if (btrfs_ino(BTRFS_I(dir)) == BTRFS_FIRST_FREE_OBJECTID) {
+	if (btrfs_ino(dir) == BTRFS_FIRST_FREE_OBJECTID) {
 		key.objectid = btrfs_root_id(root);
 		key.type = BTRFS_ROOT_BACKREF_KEY;
 		key.offset = (u64)-1;
 		root = fs_info->tree_root;
 	} else {
-		key.objectid = btrfs_ino(BTRFS_I(dir));
+		key.objectid = btrfs_ino(dir);
 		key.type = BTRFS_INODE_REF_KEY;
 		key.offset = (u64)-1;
 	}
-- 
2.47.1


