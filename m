Return-Path: <linux-btrfs+bounces-11626-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EA1A3D5D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7C017D06D
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFDD1F428C;
	Thu, 20 Feb 2025 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gGBwLG+i";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gGBwLG+i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A611D1F3FF5
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045699; cv=none; b=H6kM/TNVIYhZEiWjT6IDvXIaoEgub9pRlATDNWvBnsoSCsiTp9TKvdh9KbOG8dTR213uptZ+dHhlEVnFluUhSTvCQ/uMsFXPtVcCMmyyPhyr5NII2Nk0kYHcFml+um0Xc7CfCnpsNgtOUGZRZzkpwAWectXxB/Qk6Ejn23Q6yqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045699; c=relaxed/simple;
	bh=SdeElVA0EJ0XgMHFsLTwTOida2/6CVhPCHLP7W7NFbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouwuDrTeJaxLoSSZHUwUL/zkHvaTQpHYTyDKyp+82+du1HzyXCfA5ftsRITMcpgDC+RFAomi5ybLJVBho6fnXBFxSjCXY2SsPUasLGmawhwr9J48QTe1FvtpRI844JVX4PO6TbKrdC6sdc1ZLKWghL02mRPrYjSrTnRzp2uczIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gGBwLG+i; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gGBwLG+i; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C5D7E2117C;
	Thu, 20 Feb 2025 10:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKwcZWjNDOJM0nyvIp4DkCMfXUUGil+8LsKcqObMo48=;
	b=gGBwLG+ip86/y1B3GmckMutkimMnZrqulB6FDf6YvwHsFwNinsRsHAcCbJSwrCwdrm3A8e
	qVX4xbcmNShOBqL4cjI581VjfUPankYpSYOfkLRKrLbbdDaC3B2yPDX4VM5i9sLzKUKj8k
	Nfzb/amW2S897YzuODqzHMzAqsCuAsQ=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SKwcZWjNDOJM0nyvIp4DkCMfXUUGil+8LsKcqObMo48=;
	b=gGBwLG+ip86/y1B3GmckMutkimMnZrqulB6FDf6YvwHsFwNinsRsHAcCbJSwrCwdrm3A8e
	qVX4xbcmNShOBqL4cjI581VjfUPankYpSYOfkLRKrLbbdDaC3B2yPDX4VM5i9sLzKUKj8k
	Nfzb/amW2S897YzuODqzHMzAqsCuAsQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C01A613301;
	Thu, 20 Feb 2025 10:01:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5E7mLn/9tmeXfwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Feb 2025 10:01:35 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 15/22] btrfs: pass struct btrfs_inode to clone_copy_inline_extent()
Date: Thu, 20 Feb 2025 11:01:35 +0100
Message-ID: <2ccba43b21a35d7d7c7d218ac0adef0ae9079b0a.1740045551.git.dsterba@suse.com>
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

Pass a struct btrfs_inode to clone_copy_inline_extent() as it's an
internal interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/reflink.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index f0824c948cb7..8640dbf1aefa 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -165,7 +165,7 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
  * the source inode to destination inode when possible. When not possible we
  * copy the inline extent's data into the respective page of the inode.
  */
-static int clone_copy_inline_extent(struct inode *dst,
+static int clone_copy_inline_extent(struct btrfs_inode *inode,
 				    struct btrfs_path *path,
 				    struct btrfs_key *new_key,
 				    const u64 drop_start,
@@ -175,8 +175,8 @@ static int clone_copy_inline_extent(struct inode *dst,
 				    char *inline_data,
 				    struct btrfs_trans_handle **trans_out)
 {
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(dst);
-	struct btrfs_root *root = BTRFS_I(dst)->root;
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	const u64 aligned_end = ALIGN(new_key->offset + datal,
 				      fs_info->sectorsize);
 	struct btrfs_trans_handle *trans = NULL;
@@ -185,12 +185,12 @@ static int clone_copy_inline_extent(struct inode *dst,
 	struct btrfs_key key;
 
 	if (new_key->offset > 0) {
-		ret = copy_inline_to_page(BTRFS_I(dst), new_key->offset,
+		ret = copy_inline_to_page(inode, new_key->offset,
 					  inline_data, size, datal, comp_type);
 		goto out;
 	}
 
-	key.objectid = btrfs_ino(BTRFS_I(dst));
+	key.objectid = btrfs_ino(inode);
 	key.type = BTRFS_EXTENT_DATA_KEY;
 	key.offset = 0;
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
@@ -205,7 +205,7 @@ static int clone_copy_inline_extent(struct inode *dst,
 				goto copy_inline_extent;
 		}
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-		if (key.objectid == btrfs_ino(BTRFS_I(dst)) &&
+		if (key.objectid == btrfs_ino(inode) &&
 		    key.type == BTRFS_EXTENT_DATA_KEY) {
 			/*
 			 * There's an implicit hole at file offset 0, copy the
@@ -214,7 +214,7 @@ static int clone_copy_inline_extent(struct inode *dst,
 			ASSERT(key.offset > 0);
 			goto copy_to_page;
 		}
-	} else if (i_size_read(dst) <= datal) {
+	} else if (i_size_read(&inode->vfs_inode) <= datal) {
 		struct btrfs_file_extent_item *ei;
 
 		ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
@@ -236,7 +236,7 @@ static int clone_copy_inline_extent(struct inode *dst,
 	 * We have no extent items, or we have an extent at offset 0 which may
 	 * or may not be inlined. All these cases are dealt the same way.
 	 */
-	if (i_size_read(dst) > datal) {
+	if (i_size_read(&inode->vfs_inode) > datal) {
 		/*
 		 * At the destination offset 0 we have either a hole, a regular
 		 * extent or an inline extent larger then the one we want to
@@ -270,7 +270,7 @@ static int clone_copy_inline_extent(struct inode *dst,
 	drop_args.start = drop_start;
 	drop_args.end = aligned_end;
 	drop_args.drop_cache = true;
-	ret = btrfs_drop_extents(trans, root, BTRFS_I(dst), &drop_args);
+	ret = btrfs_drop_extents(trans, root, inode, &drop_args);
 	if (ret)
 		goto out;
 	ret = btrfs_insert_empty_item(trans, root, path, new_key, size);
@@ -281,9 +281,9 @@ static int clone_copy_inline_extent(struct inode *dst,
 			    btrfs_item_ptr_offset(path->nodes[0],
 						  path->slots[0]),
 			    size);
-	btrfs_update_inode_bytes(BTRFS_I(dst), datal, drop_args.bytes_found);
-	btrfs_set_inode_full_sync(BTRFS_I(dst));
-	ret = btrfs_inode_set_file_extent_range(BTRFS_I(dst), 0, aligned_end);
+	btrfs_update_inode_bytes(inode, datal, drop_args.bytes_found);
+	btrfs_set_inode_full_sync(inode);
+	ret = btrfs_inode_set_file_extent_range(inode, 0, aligned_end);
 out:
 	if (!ret && !trans) {
 		/*
@@ -318,7 +318,7 @@ static int clone_copy_inline_extent(struct inode *dst,
 	 */
 	btrfs_release_path(path);
 
-	ret = copy_inline_to_page(BTRFS_I(dst), new_key->offset,
+	ret = copy_inline_to_page(inode, new_key->offset,
 				  inline_data, size, datal, comp_type);
 	goto out;
 }
@@ -526,7 +526,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 				goto out;
 			}
 
-			ret = clone_copy_inline_extent(inode, path, &new_key,
+			ret = clone_copy_inline_extent(BTRFS_I(inode), path, &new_key,
 						       drop_start, datal, size,
 						       comp, buf, &trans);
 			if (ret)
-- 
2.47.1


