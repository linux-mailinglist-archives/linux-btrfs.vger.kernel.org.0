Return-Path: <linux-btrfs+bounces-14450-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB546ACDB02
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 11:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649F4189908B
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 09:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C60A28CF74;
	Wed,  4 Jun 2025 09:29:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DEF28CF6F
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749029371; cv=none; b=ccvsrh/01ucGwjpvy9tOJ8JuEvATHjo37q7rBvBFggODT/MVLf20oBWR9khWNGAm+od1E1/pGq/QZi0U5FT0k+NCcM0XdJZWckClTOM9jva8t6urinMY17l3IUVMX1uuwKuVsRE1oT4WRgnGEM3ep8xCpl8RK0STFBRagti7pNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749029371; c=relaxed/simple;
	bh=MGvKQ10wA4Adc3EnD5mTeFSu5/yHLHNqf9JHeVcBdb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfJJUT+JXWAveCFmo1MEDKh1KtwAWgq1Usw8Anp9fMdvGc16kw7Z4oG3Bple9p0Dn6Cu9JLzkBSRP8Wlu9qEIs40S1xM/0jhtAgDFF8WOwOWWw1LhORa9vzFUP57li6BU6FcxrV90+KdiOabDHZzF0Lj9fv0wXHQsFLAS8IVY6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8554E5CBBA;
	Wed,  4 Jun 2025 09:29:23 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B71E13AD9;
	Wed,  4 Jun 2025 09:29:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M50iHvMRQGijEwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 04 Jun 2025 09:29:23 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/3] btrfs: use on-stack variable for block reserve in btrfs_evict_inode()
Date: Wed,  4 Jun 2025 11:29:23 +0200
Message-ID: <c78be5be3cd43a383aeca69add0c259c812275d7.1749029179.git.dsterba@suse.com>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8554E5CBBA
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Score: -4.00

We can avoid potential memory allocation failure in btrfs_evict_inode()
as the block reserve lifetime is limited to the scope of the function.
This requires +48 bytes on stack.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c297963f56bd..496194832166 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5434,7 +5434,7 @@ void btrfs_evict_inode(struct inode *inode)
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct btrfs_block_rsv *rsv = NULL;
+	struct btrfs_block_rsv rsv;
 	int ret;
 
 	trace_btrfs_inode_evict(inode);
@@ -5482,11 +5482,9 @@ void btrfs_evict_inode(struct inode *inode)
 	 */
 	btrfs_kill_delayed_inode_items(BTRFS_I(inode));
 
-	rsv = btrfs_alloc_block_rsv(fs_info, BTRFS_BLOCK_RSV_TEMP);
-	if (!rsv)
-		goto out;
-	rsv->size = btrfs_calc_metadata_size(fs_info, 1);
-	rsv->failfast = true;
+	btrfs_init_metadata_block_rsv(fs_info, &rsv, BTRFS_BLOCK_RSV_TEMP);
+	rsv.size = btrfs_calc_metadata_size(fs_info, 1);
+	rsv.failfast = true;
 
 	btrfs_i_size_write(BTRFS_I(inode), 0);
 
@@ -5498,11 +5496,11 @@ void btrfs_evict_inode(struct inode *inode)
 			.min_type = 0,
 		};
 
-		trans = evict_refill_and_join(root, rsv);
+		trans = evict_refill_and_join(root, &rsv);
 		if (IS_ERR(trans))
-			goto out;
+			goto out_release;
 
-		trans->block_rsv = rsv;
+		trans->block_rsv = &rsv;
 
 		ret = btrfs_truncate_inode_items(trans, root, &control);
 		trans->block_rsv = &fs_info->trans_block_rsv;
@@ -5514,7 +5512,7 @@ void btrfs_evict_inode(struct inode *inode)
 		 */
 		btrfs_btree_balance_dirty_nodelay(fs_info);
 		if (ret && ret != -ENOSPC && ret != -EAGAIN)
-			goto out;
+			goto out_release;
 		else if (!ret)
 			break;
 	}
@@ -5528,16 +5526,17 @@ void btrfs_evict_inode(struct inode *inode)
 	 * If it turns out that we are dropping too many of these, we might want
 	 * to add a mechanism for retrying these after a commit.
 	 */
-	trans = evict_refill_and_join(root, rsv);
+	trans = evict_refill_and_join(root, &rsv);
 	if (!IS_ERR(trans)) {
-		trans->block_rsv = rsv;
+		trans->block_rsv = &rsv;
 		btrfs_orphan_del(trans, BTRFS_I(inode));
 		trans->block_rsv = &fs_info->trans_block_rsv;
 		btrfs_end_transaction(trans);
 	}
 
+out_release:
+	btrfs_block_rsv_release(fs_info, &rsv, (u64)-1, NULL);
 out:
-	btrfs_free_block_rsv(fs_info, rsv);
 	/*
 	 * If we didn't successfully delete, the orphan item will still be in
 	 * the tree and we'll retry on the next mount. Again, we might also want
-- 
2.47.1


