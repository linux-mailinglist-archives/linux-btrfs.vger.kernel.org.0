Return-Path: <linux-btrfs+bounces-20346-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE959D0B945
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 18:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5907A302548E
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 17:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012E5363C51;
	Fri,  9 Jan 2026 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LdONjTBL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LdONjTBL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A61B500966
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979087; cv=none; b=jpZNExLTGGNUA+QoGoFatMkjwHgy0TWI3VUAre9E66zL9uX8fG9iyx5xZj6hpbXR9Ul+TcLfIKad5bBqD7YdcR1QcAgcgflqhgVSQZ9zZOuAEAF15VjLYygLAjDMhc7pLey9g8ywoueX2pySKvb+a7YPFeubjVlDvwKb4eOT5mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979087; c=relaxed/simple;
	bh=41daA41FokzUYaVnbebYTXHznDrJ+L5G1DlW5giIquQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vft+ib9jt4RqcxymiIK7JFyskhUoq1hxGFjCSueBE+bFYUmpYXlW6uiwNZF1DGSkNAMQsRsQMdlu8ibWaGxDHJ9NO0qykci8tQhj06S7mjKrrJWiMghF2v9dqTLmjnzRXwSyFDVm/9DenKDY/VnSIfjsa/H47ugd4+wh3I8mgeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LdONjTBL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LdONjTBL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BFE7C5BFA7;
	Fri,  9 Jan 2026 17:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767979076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJtgtE5LJx4643D1JFALQkXiF5UzIWjGqOPeYw81HI0=;
	b=LdONjTBLxXnkklrdN5hu1ZtCiQ1g5Oqk1xK6x/ZAnGe+Fpi2/VeF2IlyF5guMY6lXk1vEJ
	3VUM9jQF06+vHdZThzamwmFxfBpo1asHK6g4ehGPof7lYdugOSf3b5bSasU5Q1NDr1q2GW
	82OkaU5T8yUnFjgT9ZwwC66iqtCogA4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767979076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJtgtE5LJx4643D1JFALQkXiF5UzIWjGqOPeYw81HI0=;
	b=LdONjTBLxXnkklrdN5hu1ZtCiQ1g5Oqk1xK6x/ZAnGe+Fpi2/VeF2IlyF5guMY6lXk1vEJ
	3VUM9jQF06+vHdZThzamwmFxfBpo1asHK6g4ehGPof7lYdugOSf3b5bSasU5Q1NDr1q2GW
	82OkaU5T8yUnFjgT9ZwwC66iqtCogA4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B99DC3EA63;
	Fri,  9 Jan 2026 17:17:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BgtNLUQ4YWksVAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 09 Jan 2026 17:17:56 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 4/4] btrfs: pass btrfs_fs_info to btrfs_first_delayed_node()
Date: Fri,  9 Jan 2026 18:17:43 +0100
Message-ID: <ab25d3e717db51769ad3169225e767db09028a0b.1767979013.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1767979013.git.dsterba@suse.com>
References: <cover.1767979013.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

As the delayed root is now in the fs_info we can pass it to
btrfs_first_delayed_node().

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/delayed-inode.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index fc5926ecc762ff..1739a0b29c49d7 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -232,19 +232,19 @@ static void btrfs_dequeue_delayed_node(struct btrfs_delayed_root *root,
 }
 
 static struct btrfs_delayed_node *btrfs_first_delayed_node(
-			struct btrfs_delayed_root *delayed_root,
+			struct btrfs_fs_info *fs_info,
 			struct btrfs_ref_tracker *tracker)
 {
 	struct btrfs_delayed_node *node;
 
-	spin_lock(&delayed_root->lock);
-	node = list_first_entry_or_null(&delayed_root->node_list,
+	spin_lock(&fs_info->delayed_root.lock);
+	node = list_first_entry_or_null(&fs_info->delayed_root.node_list,
 					struct btrfs_delayed_node, n_list);
 	if (node) {
 		refcount_inc(&node->refs);
 		btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
 	}
-	spin_unlock(&delayed_root->lock);
+	spin_unlock(&fs_info->delayed_root.lock);
 
 	return node;
 }
@@ -1154,7 +1154,7 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 	block_rsv = trans->block_rsv;
 	trans->block_rsv = &fs_info->delayed_block_rsv;
 
-	curr_node = btrfs_first_delayed_node(&fs_info->delayed_root, &curr_delayed_node_tracker);
+	curr_node = btrfs_first_delayed_node(fs_info, &curr_delayed_node_tracker);
 	while (curr_node && (!count || nr--)) {
 		ret = __btrfs_commit_inode_delayed_items(trans, path,
 							 curr_node);
@@ -1401,7 +1401,7 @@ void btrfs_assert_delayed_root_empty(struct btrfs_fs_info *fs_info)
 	struct btrfs_ref_tracker delayed_node_tracker;
 	struct btrfs_delayed_node *node;
 
-	node = btrfs_first_delayed_node(&fs_info->delayed_root, &delayed_node_tracker);
+	node = btrfs_first_delayed_node(fs_info, &delayed_node_tracker);
 	if (WARN_ON(node)) {
 		btrfs_delayed_node_ref_tracker_free(node,
 						    &delayed_node_tracker);
@@ -2102,8 +2102,7 @@ void btrfs_destroy_delayed_inodes(struct btrfs_fs_info *fs_info)
 	struct btrfs_delayed_node *curr_node, *prev_node;
 	struct btrfs_ref_tracker curr_delayed_node_tracker, prev_delayed_node_tracker;
 
-	curr_node = btrfs_first_delayed_node(&fs_info->delayed_root,
-					     &curr_delayed_node_tracker);
+	curr_node = btrfs_first_delayed_node(fs_info, &curr_delayed_node_tracker);
 	while (curr_node) {
 		__btrfs_kill_delayed_node(curr_node);
 
-- 
2.51.1


