Return-Path: <linux-btrfs+bounces-15054-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F331FAEB971
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 16:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98941894992
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 14:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AD82DD5E1;
	Fri, 27 Jun 2025 14:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ErqwRSvD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ErqwRSvD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9D22C15AA
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751033053; cv=none; b=i3pBVgJXXNdIXvmle6RYgCwMBRMXXRNyiEUCJtOt1PU56vycM/Z9urjDmrN1tlx9alNayxprynToAV0yMM9agNWzC8FMuUU5eeukHlFeWSfq6u9tANdA+NSckSFUESleH8X6GG7AWumTFb89K3HxLmAjH2Q1zz88CCAI9NSrcvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751033053; c=relaxed/simple;
	bh=6Al4jst64rIrOGhO86L9XPiDDXUPVNQmF39Ip9sXJXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRKdWXktqIhwZ2wblZg5Te60Sl7AN9FaG3pg6GIKQPzmNHQyxDVSqTmiA4dsgGlPw8l5ej4oDppJu6IqOUDnKIY/c9UltlS6OjxdRRKHkncrLsKSnnai/h2T4xZxFtwx/osTfEYeMvmvYghU8USfP1Ei68iSboqhSW+fvASX5BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ErqwRSvD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ErqwRSvD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 419861F395;
	Fri, 27 Jun 2025 14:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751033045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGp+W7aoUAP5QyC8EATLchTzjdLE1gVA2Q8DojTH8xQ=;
	b=ErqwRSvD4t5CBlLJUqko6VHi9Hikcff2Pc5OZ1D4lREPBhqr7tAkBTL/a8Tmdpl+w6UePZ
	ua2iqdOy3Y+kalrC/xHEQ+mOV7WVH/tiTxTBX3IpG4x5BtPzpuaK8Mu/1rKlIwf1F72mvd
	W8q5rwDp/Umx1/GQK4JMu2+tCb0d/OA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751033045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGp+W7aoUAP5QyC8EATLchTzjdLE1gVA2Q8DojTH8xQ=;
	b=ErqwRSvD4t5CBlLJUqko6VHi9Hikcff2Pc5OZ1D4lREPBhqr7tAkBTL/a8Tmdpl+w6UePZ
	ua2iqdOy3Y+kalrC/xHEQ+mOV7WVH/tiTxTBX3IpG4x5BtPzpuaK8Mu/1rKlIwf1F72mvd
	W8q5rwDp/Umx1/GQK4JMu2+tCb0d/OA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 394E813786;
	Fri, 27 Jun 2025 14:04:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6/P6DdWkXmj/RwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 27 Jun 2025 14:04:05 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/4] btrfs: tree-log: don't use token set/get accessors in fill_inode_item()
Date: Fri, 27 Jun 2025 16:03:52 +0200
Message-ID: <1fd497bfde9c606dbd749650d9274dbba7599dfe.1751032655.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751032655.git.dsterba@suse.com>
References: <cover.1751032655.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

The token versions of set/get accessors will be removed, use the normal
helpers.

There's additional overhead of the token helpers that update the cached
address in case it moves to another page/folio. The normal versions
don't need to do that.

Note this is similar to fill_inode_item() in inode.c but with slight
differences. The two functions could be deduplicated eventually.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/tree-log.c | 48 ++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 97ed11788b470f..7e52d8f92e5bad 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4204,44 +4204,34 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 			    struct inode *inode, int log_inode_only,
 			    u64 logged_isize)
 {
-	struct btrfs_map_token token;
 	u64 flags;
 
-	btrfs_init_map_token(&token, leaf);
-
 	if (log_inode_only) {
 		/* set the generation to zero so the recover code
 		 * can tell the difference between an logging
 		 * just to say 'this inode exists' and a logging
 		 * to say 'update this inode with these values'
 		 */
-		btrfs_set_token_inode_generation(&token, item, 0);
-		btrfs_set_token_inode_size(&token, item, logged_isize);
+		btrfs_set_inode_generation(leaf, item, 0);
+		btrfs_set_inode_size(leaf, item, logged_isize);
 	} else {
-		btrfs_set_token_inode_generation(&token, item,
-						 BTRFS_I(inode)->generation);
-		btrfs_set_token_inode_size(&token, item, inode->i_size);
+		btrfs_set_inode_generation(leaf, item, BTRFS_I(inode)->generation);
+		btrfs_set_inode_size(leaf, item, inode->i_size);
 	}
 
-	btrfs_set_token_inode_uid(&token, item, i_uid_read(inode));
-	btrfs_set_token_inode_gid(&token, item, i_gid_read(inode));
-	btrfs_set_token_inode_mode(&token, item, inode->i_mode);
-	btrfs_set_token_inode_nlink(&token, item, inode->i_nlink);
+	btrfs_set_inode_uid(leaf, item, i_uid_read(inode));
+	btrfs_set_inode_gid(leaf, item, i_gid_read(inode));
+	btrfs_set_inode_mode(leaf, item, inode->i_mode);
+	btrfs_set_inode_nlink(leaf, item, inode->i_nlink);
 
-	btrfs_set_token_timespec_sec(&token, &item->atime,
-				     inode_get_atime_sec(inode));
-	btrfs_set_token_timespec_nsec(&token, &item->atime,
-				      inode_get_atime_nsec(inode));
+	btrfs_set_timespec_sec(leaf, &item->atime, inode_get_atime_sec(inode));
+	btrfs_set_timespec_nsec(leaf, &item->atime, inode_get_atime_nsec(inode));
 
-	btrfs_set_token_timespec_sec(&token, &item->mtime,
-				     inode_get_mtime_sec(inode));
-	btrfs_set_token_timespec_nsec(&token, &item->mtime,
-				      inode_get_mtime_nsec(inode));
+	btrfs_set_timespec_sec(leaf, &item->mtime, inode_get_mtime_sec(inode));
+	btrfs_set_timespec_nsec(leaf, &item->mtime, inode_get_mtime_nsec(inode));
 
-	btrfs_set_token_timespec_sec(&token, &item->ctime,
-				     inode_get_ctime_sec(inode));
-	btrfs_set_token_timespec_nsec(&token, &item->ctime,
-				      inode_get_ctime_nsec(inode));
+	btrfs_set_timespec_sec(leaf, &item->ctime, inode_get_ctime_sec(inode));
+	btrfs_set_timespec_nsec(leaf, &item->ctime, inode_get_ctime_nsec(inode));
 
 	/*
 	 * We do not need to set the nbytes field, in fact during a fast fsync
@@ -4252,13 +4242,13 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 	 * inode item in subvolume tree as needed (see overwrite_item()).
 	 */
 
-	btrfs_set_token_inode_sequence(&token, item, inode_peek_iversion(inode));
-	btrfs_set_token_inode_transid(&token, item, trans->transid);
-	btrfs_set_token_inode_rdev(&token, item, inode->i_rdev);
+	btrfs_set_inode_sequence(leaf, item, inode_peek_iversion(inode));
+	btrfs_set_inode_transid(leaf, item, trans->transid);
+	btrfs_set_inode_rdev(leaf, item, inode->i_rdev);
 	flags = btrfs_inode_combine_flags(BTRFS_I(inode)->flags,
 					  BTRFS_I(inode)->ro_flags);
-	btrfs_set_token_inode_flags(&token, item, flags);
-	btrfs_set_token_inode_block_group(&token, item, 0);
+	btrfs_set_inode_flags(leaf, item, flags);
+	btrfs_set_inode_block_group(leaf, item, 0);
 }
 
 static int log_inode_item(struct btrfs_trans_handle *trans,
-- 
2.49.0


