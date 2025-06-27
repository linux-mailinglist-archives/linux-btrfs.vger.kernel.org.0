Return-Path: <linux-btrfs+bounces-15052-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636D5AEB96C
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 16:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38803641F90
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 14:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE7E2DCC09;
	Fri, 27 Jun 2025 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Flt66i+7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Flt66i+7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCE92DAFBA
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751033046; cv=none; b=f1uLl4Rzp/kioeFcZLbaSgxqYU8Edb+GOo4ZHfaD+TRR8imgfEiVQKHlhVlHxdk4y+BjmhzOQT0Uh4ISCJjQIgYobFzvisAeL5NkFoul4TEU6c4CtaYjDTqtBqlz1h7RxjR7uv+NEc0qGxbmN3P9FX2xs7USs0RNACKLaUH1tzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751033046; c=relaxed/simple;
	bh=hvO/V4QCkuay4HJ/XbMyBtuLCXG1qvbOqiWREA+trLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iahO4Cj88ahKKOiezyeXW6o4tIIuqKBPvuZ3dh78mzt4lY8YJ+a0CUcEieq9SjJUr0hcpWyTQd0ipIrgnb4CeGgv6Usm7BG6y76fGutMiK/iFnM1TJ+C51pcCYGA4ZQdc5d71rsGS7curZ5R4D7tuVDHtGNNZairG+IVeQfAygM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Flt66i+7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Flt66i+7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0A6221F394;
	Fri, 27 Jun 2025 14:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751033043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+a8ZSzRbvfDLJPJM9gBTCJwSCyQ0ztrGAQHQ89dmx4=;
	b=Flt66i+7HzGqN3EK++s7e9cGm2Q8ijHGXchcJzkGK+RNNCYwgxfxEz4KTxR3+jOt2DeQEv
	LV36c8vlkhAuV4tkOXCDLezz3sn+te7kAPmSaw2ipPhaBVdrv62BydxksXncfwyYxpuzJ7
	vs/mzB2RVmnUTeA4JnCln0PslgFIvSQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751033043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+a8ZSzRbvfDLJPJM9gBTCJwSCyQ0ztrGAQHQ89dmx4=;
	b=Flt66i+7HzGqN3EK++s7e9cGm2Q8ijHGXchcJzkGK+RNNCYwgxfxEz4KTxR3+jOt2DeQEv
	LV36c8vlkhAuV4tkOXCDLezz3sn+te7kAPmSaw2ipPhaBVdrv62BydxksXncfwyYxpuzJ7
	vs/mzB2RVmnUTeA4JnCln0PslgFIvSQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0437913786;
	Fri, 27 Jun 2025 14:04:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KC0FAdOkXmj5RwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 27 Jun 2025 14:04:03 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/4] btrfs: don't use token set/get accessors in inode.c:fill_inode_item()
Date: Fri, 27 Jun 2025 16:03:51 +0200
Message-ID: <80c0f5eea9503b655e11125fdaab4d7cd62c40a9.1751032655.git.dsterba@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

The token versions of set/get accessors will be removed, use the normal
helpers.

There's additional overhead of the token helpers that update the cached
address in case it moves to another page/folio. The normal versions
don't need to do that.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 50 +++++++++++++++++++-----------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6df7ef1b869b2e..508fb69a976dda 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4078,45 +4078,35 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 			    struct btrfs_inode_item *item,
 			    struct inode *inode)
 {
-	struct btrfs_map_token token;
 	u64 flags;
 
-	btrfs_init_map_token(&token, leaf);
+	btrfs_set_inode_uid(leaf, item, i_uid_read(inode));
+	btrfs_set_inode_gid(leaf, item, i_gid_read(inode));
+	btrfs_set_inode_size(leaf, item, BTRFS_I(inode)->disk_i_size);
+	btrfs_set_inode_mode(leaf, item, inode->i_mode);
+	btrfs_set_inode_nlink(leaf, item, inode->i_nlink);
 
-	btrfs_set_token_inode_uid(&token, item, i_uid_read(inode));
-	btrfs_set_token_inode_gid(&token, item, i_gid_read(inode));
-	btrfs_set_token_inode_size(&token, item, BTRFS_I(inode)->disk_i_size);
-	btrfs_set_token_inode_mode(&token, item, inode->i_mode);
-	btrfs_set_token_inode_nlink(&token, item, inode->i_nlink);
+	btrfs_set_timespec_sec(leaf, &item->atime, inode_get_atime_sec(inode));
+	btrfs_set_timespec_nsec(leaf, &item->atime, inode_get_atime_nsec(inode));
 
-	btrfs_set_token_timespec_sec(&token, &item->atime,
-				     inode_get_atime_sec(inode));
-	btrfs_set_token_timespec_nsec(&token, &item->atime,
-				      inode_get_atime_nsec(inode));
+	btrfs_set_timespec_sec(leaf, &item->mtime, inode_get_mtime_sec(inode));
+	btrfs_set_timespec_nsec(leaf, &item->mtime, inode_get_mtime_nsec(inode));
 
-	btrfs_set_token_timespec_sec(&token, &item->mtime,
-				     inode_get_mtime_sec(inode));
-	btrfs_set_token_timespec_nsec(&token, &item->mtime,
-				      inode_get_mtime_nsec(inode));
+	btrfs_set_timespec_sec(leaf, &item->ctime, inode_get_ctime_sec(inode));
+	btrfs_set_timespec_nsec(leaf, &item->ctime, inode_get_ctime_nsec(inode));
 
-	btrfs_set_token_timespec_sec(&token, &item->ctime,
-				     inode_get_ctime_sec(inode));
-	btrfs_set_token_timespec_nsec(&token, &item->ctime,
-				      inode_get_ctime_nsec(inode));
+	btrfs_set_timespec_sec(leaf, &item->otime, BTRFS_I(inode)->i_otime_sec);
+	btrfs_set_timespec_nsec(leaf, &item->otime, BTRFS_I(inode)->i_otime_nsec);
 
-	btrfs_set_token_timespec_sec(&token, &item->otime, BTRFS_I(inode)->i_otime_sec);
-	btrfs_set_token_timespec_nsec(&token, &item->otime, BTRFS_I(inode)->i_otime_nsec);
-
-	btrfs_set_token_inode_nbytes(&token, item, inode_get_bytes(inode));
-	btrfs_set_token_inode_generation(&token, item,
-					 BTRFS_I(inode)->generation);
-	btrfs_set_token_inode_sequence(&token, item, inode_peek_iversion(inode));
-	btrfs_set_token_inode_transid(&token, item, trans->transid);
-	btrfs_set_token_inode_rdev(&token, item, inode->i_rdev);
+	btrfs_set_inode_nbytes(leaf, item, inode_get_bytes(inode));
+	btrfs_set_inode_generation(leaf, item, BTRFS_I(inode)->generation);
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
 
 /*
-- 
2.49.0


