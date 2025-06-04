Return-Path: <linux-btrfs+bounces-14451-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA3AACDB11
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 11:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE6A189021D
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 09:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF86128C5B7;
	Wed,  4 Jun 2025 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fnu/KHbp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fnu/KHbp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3721D82864
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749029735; cv=none; b=TU932Di41gs++XK38lHpFSM2OjYfMKvfzq0Grdn81ejhCEyewaUtVk7KJFaZhIiwGrSxjNeqv+thBOAForUwESBYA+pnZ9c/mAy0T5PDfCRqwxn9qkUjVZbVlDFgn1CmEHxhixlJUZOfiyyrjjqBfO02LcA7gZbJSiondiUIe9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749029735; c=relaxed/simple;
	bh=pKGVFxdNtBxVxKFS7DxyIZUuV/GlOEV9lbTEwv74Gkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvGiHqcl1M/qkbqgKywje+193xz3QbLZul8FBMalRnJuSa+MT8SxBoCnXBiIDRgNmPSgAHRfZ0uwzmKW6WINIRU8vXpu0mQATFjhpFmzMleg+5BQQSZRRV0BBzPhZH6Y/DmlAZqvO2zzuJRyl0exq+qVnC6SzhjhQrrkgFVyAgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fnu/KHbp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fnu/KHbp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3F5023758A;
	Wed,  4 Jun 2025 09:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749029368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4bZyrz7/Nzd/UYjl5j7qkoR3plQrGPPskgwecVj128=;
	b=fnu/KHbpCKX93QaNAV6N0YVjgL3zkln4gYtxTqWhz6LUxXYshEbSxYzcsuHD7NTpFO7waE
	No/qE8CeWdAZLXfB1smHEZbCBNmG5r+RETcO6lUf5MT5bDN7VpKutXfGOeDAj1f7muXuM1
	YSWahgctT7iOFxL52g4N7kGs7hB6EWk=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749029368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4bZyrz7/Nzd/UYjl5j7qkoR3plQrGPPskgwecVj128=;
	b=fnu/KHbpCKX93QaNAV6N0YVjgL3zkln4gYtxTqWhz6LUxXYshEbSxYzcsuHD7NTpFO7waE
	No/qE8CeWdAZLXfB1smHEZbCBNmG5r+RETcO6lUf5MT5bDN7VpKutXfGOeDAj1f7muXuM1
	YSWahgctT7iOFxL52g4N7kGs7hB6EWk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37CFE1369A;
	Wed,  4 Jun 2025 09:29:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e4GdDfgRQGivEwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 04 Jun 2025 09:29:28 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/3] btrfs: use on-stack variable for block reserve in btrfs_replace_file_extents()
Date: Wed,  4 Jun 2025 11:29:27 +0200
Message-ID: <cb8af6c3e3f2851aade7ed6bbc7acd0969415bd8.1749029179.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749029179.git.dsterba@suse.com>
References: <cover.1749029179.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.80

We can avoid potential memory allocation failure in
btrfs_replace_file_extents() as the block reserve lifetime is limited to
the scope of the function. This requires +48 bytes on stack.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/file.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 8ce6f45f45e0..2902de88dd1b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2341,7 +2341,7 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 	u64 min_size = btrfs_calc_insert_metadata_size(fs_info, 1);
 	u64 ino_size = round_up(inode->vfs_inode.i_size, fs_info->sectorsize);
 	struct btrfs_trans_handle *trans = NULL;
-	struct btrfs_block_rsv *rsv;
+	struct btrfs_block_rsv rsv;
 	unsigned int rsv_count;
 	u64 cur_offset;
 	u64 len = end - start;
@@ -2350,13 +2350,9 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 	if (end <= start)
 		return -EINVAL;
 
-	rsv = btrfs_alloc_block_rsv(fs_info, BTRFS_BLOCK_RSV_TEMP);
-	if (!rsv) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	rsv->size = btrfs_calc_insert_metadata_size(fs_info, 1);
-	rsv->failfast = true;
+	btrfs_init_metadata_block_rsv(fs_info, &rsv, BTRFS_BLOCK_RSV_TEMP);
+	rsv.size = btrfs_calc_insert_metadata_size(fs_info, 1);
+	rsv.failfast = true;
 
 	/*
 	 * 1 - update the inode
@@ -2373,14 +2369,14 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		trans = NULL;
-		goto out_free;
+		goto out_release;
 	}
 
-	ret = btrfs_block_rsv_migrate(&fs_info->trans_block_rsv, rsv,
+	ret = btrfs_block_rsv_migrate(&fs_info->trans_block_rsv, &rsv,
 				      min_size, false);
 	if (WARN_ON(ret))
 		goto out_trans;
-	trans->block_rsv = rsv;
+	trans->block_rsv = &rsv;
 
 	cur_offset = start;
 	drop_args.path = path;
@@ -2496,10 +2492,10 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 		}
 
 		ret = btrfs_block_rsv_migrate(&fs_info->trans_block_rsv,
-					      rsv, min_size, false);
+					      &rsv, min_size, false);
 		if (WARN_ON(ret))
 			break;
-		trans->block_rsv = rsv;
+		trans->block_rsv = &rsv;
 
 		cur_offset = drop_args.drop_end;
 		len = end - cur_offset;
@@ -2576,16 +2572,15 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 
 out_trans:
 	if (!trans)
-		goto out_free;
+		goto out_release;
 
 	trans->block_rsv = &fs_info->trans_block_rsv;
 	if (ret)
 		btrfs_end_transaction(trans);
 	else
 		*trans_out = trans;
-out_free:
-	btrfs_free_block_rsv(fs_info, rsv);
-out:
+out_release:
+	btrfs_block_rsv_release(fs_info, &rsv, (u64)-1, NULL);
 	return ret;
 }
 
-- 
2.47.1


