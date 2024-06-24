Return-Path: <linux-btrfs+bounces-5927-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58557915389
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 18:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89AB31C22C88
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 16:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147AD19E7EF;
	Mon, 24 Jun 2024 16:23:10 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07B819E7DD
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246189; cv=none; b=blbtQojMmVMHEvv3NFQcY7KyUyPDEHWWi/waYF5azB9bmbcwV7nFQQGzpaOmIbafyP0MBfW4pU02yXttHyi+YpM6eYdNBZb1+YDQgO6z3sp7bDVUA2dY0YI+vNrc2pJcvUJU+AxGUYuowZ1Jlz0EvNREZS2nWdoDsLrsbpXoztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246189; c=relaxed/simple;
	bh=+zvZw8mUYCqNmSENIa+Pw4xB0uRs2TGli2MHSD867xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4JnEQi7zNzcnwBuko9HkYF3NiDh4J7onLkcTDYJFXDryPq48bpgrE/zGpjYxVdiukao9xAcmmv4yUMki7cF3LyBUu6gONUh6NYQpYpQNfKPHzarV9e5mbQMzfRahgNRII8LUuheB492X5nJ+ycwX67LspXsPEUkkmbafE/pnUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 005DF1F7DC;
	Mon, 24 Jun 2024 16:23:06 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDE891384C;
	Mon, 24 Jun 2024 16:23:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LQgTOmmdeWbYLQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 24 Jun 2024 16:23:05 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 02/11] btrfs: pass a btrfs_inode to btrfs_readdir_get_delayed_items()
Date: Mon, 24 Jun 2024 18:23:05 +0200
Message-ID: <1e1d4c3b9788db024c56b4ffc9622aa02988b103.1719246104.git.dsterba@suse.com>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 005DF1F7DC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

Pass a struct btrfs_inode to btrfs_readdir_get_delayed_items() as it's
an internal interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/delayed-inode.c | 8 ++++----
 fs/btrfs/delayed-inode.h | 2 +-
 fs/btrfs/inode.c         | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 3a1b6e120959..508bdbae29a0 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1682,7 +1682,7 @@ int btrfs_inode_delayed_dir_index_count(struct btrfs_inode *inode)
 	return 0;
 }
 
-bool btrfs_readdir_get_delayed_items(struct inode *inode,
+bool btrfs_readdir_get_delayed_items(struct btrfs_inode *inode,
 				     u64 last_index,
 				     struct list_head *ins_list,
 				     struct list_head *del_list)
@@ -1690,7 +1690,7 @@ bool btrfs_readdir_get_delayed_items(struct inode *inode,
 	struct btrfs_delayed_node *delayed_node;
 	struct btrfs_delayed_item *item;
 
-	delayed_node = btrfs_get_delayed_node(BTRFS_I(inode));
+	delayed_node = btrfs_get_delayed_node(inode);
 	if (!delayed_node)
 		return false;
 
@@ -1698,8 +1698,8 @@ bool btrfs_readdir_get_delayed_items(struct inode *inode,
 	 * We can only do one readdir with delayed items at a time because of
 	 * item->readdir_list.
 	 */
-	btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_SHARED);
-	btrfs_inode_lock(BTRFS_I(inode), 0);
+	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
+	btrfs_inode_lock(inode, 0);
 
 	mutex_lock(&delayed_node->mutex);
 	item = __btrfs_first_delayed_insertion_item(delayed_node);
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index e30ba7962d44..7cfefdfe54ea 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -143,7 +143,7 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_root *root);
 void btrfs_destroy_delayed_inodes(struct btrfs_fs_info *fs_info);
 
 /* Used for readdir() */
-bool btrfs_readdir_get_delayed_items(struct inode *inode,
+bool btrfs_readdir_get_delayed_items(struct btrfs_inode *inode,
 				     u64 last_index,
 				     struct list_head *ins_list,
 				     struct list_head *del_list);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6cddc7841238..cd3f1a9415c1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5947,7 +5947,7 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 	addr = private->filldir_buf;
 	path->reada = READA_FORWARD;
 
-	put = btrfs_readdir_get_delayed_items(inode, private->last_index,
+	put = btrfs_readdir_get_delayed_items(BTRFS_I(inode), private->last_index,
 					      &ins_list, &del_list);
 
 again:
-- 
2.45.0


