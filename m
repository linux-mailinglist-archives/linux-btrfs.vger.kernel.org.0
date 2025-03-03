Return-Path: <linux-btrfs+bounces-11984-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FE9A4C3EC
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 15:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515641894B26
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 14:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A232E213E61;
	Mon,  3 Mar 2025 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LdUDGpaj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LdUDGpaj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A4A20FA9D
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013741; cv=none; b=OLY2gbjt4THIKBaPnSxXlOU401xpyvkyPQy24sDsbLFKZ+kog+bqzYsPwwYxRjaPfq5/mu87n4S0wTjBAagD9nZetYvZSeWWLiVNAzkFcuWfDUD9wSaEr3zHxa2dO5UzMZwSzt/SaC/F10JKOj3vwe8hZuig15xY2QNxcDy876o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013741; c=relaxed/simple;
	bh=2/VAp3In7reDSQax7wasw4SmuBO/Rki1vZaimjUQjQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pb4BjdaorXq8KC4BR4PVHWQpi5RNp7x0nUVaJQxhQAN7sOhULUptXfg1u/Tpug2N4H1qY0BhhsOB6PBxXARYgGFDkQbq1mIxbvKGWGCe5VEeE41wFjdUiGK0Cv1XBfG1BsyfFY8kVYGtC7rgmkvMLMdRa7yZ6KZeSC+zYmMF8Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LdUDGpaj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LdUDGpaj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E352C1F441;
	Mon,  3 Mar 2025 14:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741013732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZB3ZVEcnPoIGTeL4kzANXIcgcKq145snxweNlNy6bNg=;
	b=LdUDGpajewOn3eS5+zm7/7h6eoYleEgwhRur6SqDRsr3SjT0WgO7B87tX2GniyqIMKot5Z
	Jk9SXGXptrRHY91kdH9LZ+F0Wz7k/17S4CiL1eIR51oewhos/cBEZX/J3x+ruyQXVQnL9Y
	ajHlmx3sjyMFUEGOmBHPh736067OGxg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=LdUDGpaj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741013732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZB3ZVEcnPoIGTeL4kzANXIcgcKq145snxweNlNy6bNg=;
	b=LdUDGpajewOn3eS5+zm7/7h6eoYleEgwhRur6SqDRsr3SjT0WgO7B87tX2GniyqIMKot5Z
	Jk9SXGXptrRHY91kdH9LZ+F0Wz7k/17S4CiL1eIR51oewhos/cBEZX/J3x+ruyQXVQnL9Y
	ajHlmx3sjyMFUEGOmBHPh736067OGxg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCB2713939;
	Mon,  3 Mar 2025 14:55:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7VXfNeTCxWdDAwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 03 Mar 2025 14:55:32 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 5/7] btrfs: simplify local variables in btrfs_ioctl_resize()
Date: Mon,  3 Mar 2025 15:55:32 +0100
Message-ID: <7ce9ed585e5e68f9330f7760087eadd3905c9910.1741012265.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: E352C1F441
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Remove some redundant variables and assignments, move variable
declarations to their closest scope.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index b05b81a95fc1..a7aff4769a58 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1033,17 +1033,14 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 					void __user *arg)
 {
 	BTRFS_DEV_LOOKUP_ARGS(args);
-	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
+	struct btrfs_root *root = BTRFS_I(file_inode(file))->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 new_size;
 	u64 old_size;
 	u64 devid = 1;
-	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_ioctl_vol_args *vol_args;
-	struct btrfs_trans_handle *trans;
 	struct btrfs_device *device = NULL;
 	char *sizestr;
-	char *retptr;
 	char *devstr = NULL;
 	int ret = 0;
 	int mod = 0;
@@ -1111,6 +1108,8 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 	if (!strcmp(sizestr, "max"))
 		new_size = bdev_nr_bytes(device->bdev);
 	else {
+		char *retptr;
+
 		if (sizestr[0] == '-') {
 			mod = -1;
 			sizestr++;
@@ -1158,6 +1157,8 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 	new_size = round_down(new_size, fs_info->sectorsize);
 
 	if (new_size > old_size) {
+		struct btrfs_trans_handle *trans;
+
 		trans = btrfs_start_transaction(root, 0);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
-- 
2.47.1


