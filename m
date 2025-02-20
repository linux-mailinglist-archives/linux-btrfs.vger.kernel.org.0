Return-Path: <linux-btrfs+bounces-11621-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 293B9A3D5DF
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C613BBC8B
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425681F3BAC;
	Thu, 20 Feb 2025 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Y7lAjvqv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Y7lAjvqv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31011F237C
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045683; cv=none; b=DhuKoAd0MWrM9aTn4+ieDZM2qf0ZPCL7Sf2nh9Uwnk0F48pgkPebWAm5ZzLZ524h2hybyhCSPQ9I6T/G9kDDkcgDMWp7fh/hXLl8f0/fHWwp2YftTRUAkAis36zogsIGCQv8foD6HUzoTi+Hv05MxPktCvm7S9dPLNP1kAbBee4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045683; c=relaxed/simple;
	bh=kFSCZKfNMU/Y2PvTY1yvmkSqhwfjpUFX/Cny9RqpCTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uThMQk7jZlxLcMpFP4a37uK4Ntbr+SUjllt7rIxABklJhkDAIjxvgnQ9w1iYggK/Run5TBZyKjnh2FfkA8eNC0F7tLgaepXofPJ5cNyZHkTzZ6hsit+NXWnv8ikMkL2yFb/+Q7tCYy9qnFeeKEMasPp3SszXwZduGSGRwHV3L8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Y7lAjvqv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Y7lAjvqv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2AB451F387;
	Thu, 20 Feb 2025 10:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptV3t0XoUoO74IICy/cby2/tqkymQ3uaJrlkh+204RA=;
	b=Y7lAjvqv90UucBlUQPqIz1/6qhIEm1qmR/qH2FsfGb1t++MlO701Xt9wHx7RhlqKc4zXVz
	UouWAZCvDIcWlCrUduUhHoddoquylNRYiw6G7iDwEamqIGbLEZlYNIt5n/meUgZnPpdPVy
	k7m9Dbmggp20m07VNNZz3gPKyTx9KNo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptV3t0XoUoO74IICy/cby2/tqkymQ3uaJrlkh+204RA=;
	b=Y7lAjvqv90UucBlUQPqIz1/6qhIEm1qmR/qH2FsfGb1t++MlO701Xt9wHx7RhlqKc4zXVz
	UouWAZCvDIcWlCrUduUhHoddoquylNRYiw6G7iDwEamqIGbLEZlYNIt5n/meUgZnPpdPVy
	k7m9Dbmggp20m07VNNZz3gPKyTx9KNo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23BB213301;
	Thu, 20 Feb 2025 10:01:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v3m5CGf9tmdwfwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Feb 2025 10:01:11 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 08/22] btrfs: use struct btrfs_inode inside create_pending_snapshot()
Date: Thu, 20 Feb 2025 11:01:10 +0100
Message-ID: <4f9fb98bd8895615e46cccc39e7779b0e7a8d18b.1740045551.git.dsterba@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Use a struct btrfs_inode in create_pending_snapshot() as it's an
internal helper, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/transaction.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 47b2f7172374..db8fe291d010 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1635,7 +1635,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	struct btrfs_root *root = pending->root;
 	struct btrfs_root *parent_root;
 	struct btrfs_block_rsv *rsv;
-	struct inode *parent_inode = &pending->dir->vfs_inode;
+	struct btrfs_inode *parent_inode = pending->dir;
 	struct btrfs_path *path;
 	struct btrfs_dir_item *dir_item;
 	struct extent_buffer *tmp;
@@ -1661,7 +1661,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	 * filesystem.
 	 */
 	nofs_flags = memalloc_nofs_save();
-	pending->error = fscrypt_setup_filename(parent_inode,
+	pending->error = fscrypt_setup_filename(&parent_inode->vfs_inode,
 						&pending->dentry->d_name, 0,
 						&fname);
 	memalloc_nofs_restore(nofs_flags);
@@ -1699,16 +1699,16 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	trace_btrfs_space_reservation(fs_info, "transaction",
 				      trans->transid,
 				      trans->bytes_reserved, 1);
-	parent_root = BTRFS_I(parent_inode)->root;
+	parent_root = parent_inode->root;
 	ret = record_root_in_trans(trans, parent_root, 0);
 	if (ret)
 		goto fail;
-	cur_time = current_time(parent_inode);
+	cur_time = current_time(&parent_inode->vfs_inode);
 
 	/*
 	 * insert the directory item
 	 */
-	ret = btrfs_set_inode_index(BTRFS_I(parent_inode), &index);
+	ret = btrfs_set_inode_index(parent_inode, &index);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
@@ -1716,7 +1716,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 
 	/* check if there is a file/dir which has the same name. */
 	dir_item = btrfs_lookup_dir_item(NULL, parent_root, path,
-					 btrfs_ino(BTRFS_I(parent_inode)),
+					 btrfs_ino(parent_inode),
 					 &fname.disk_name, 0);
 	if (dir_item != NULL && !IS_ERR(dir_item)) {
 		pending->error = -EEXIST;
@@ -1817,7 +1817,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	 */
 	ret = btrfs_add_root_ref(trans, objectid,
 				 btrfs_root_id(parent_root),
-				 btrfs_ino(BTRFS_I(parent_inode)), index,
+				 btrfs_ino(parent_inode), index,
 				 &fname.disk_name);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
@@ -1855,18 +1855,18 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		goto fail;
 
 	ret = btrfs_insert_dir_item(trans, &fname.disk_name,
-				    BTRFS_I(parent_inode), &key, BTRFS_FT_DIR,
+				    parent_inode, &key, BTRFS_FT_DIR,
 				    index);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
 	}
 
-	btrfs_i_size_write(BTRFS_I(parent_inode), parent_inode->i_size +
+	btrfs_i_size_write(parent_inode, parent_inode->vfs_inode.i_size +
 						  fname.disk_name.len * 2);
-	inode_set_mtime_to_ts(parent_inode,
-			      inode_set_ctime_current(parent_inode));
-	ret = btrfs_update_inode_fallback(trans, BTRFS_I(parent_inode));
+	inode_set_mtime_to_ts(&parent_inode->vfs_inode,
+			      inode_set_ctime_current(&parent_inode->vfs_inode));
+	ret = btrfs_update_inode_fallback(trans, parent_inode);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
-- 
2.47.1


