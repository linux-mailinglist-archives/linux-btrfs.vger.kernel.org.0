Return-Path: <linux-btrfs+bounces-14452-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9201ACDB1B
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 11:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333D518946F7
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 09:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02BF28C87A;
	Wed,  4 Jun 2025 09:37:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8540D82864
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749029838; cv=none; b=K7wVzKfSV6AALdy3HD2sgH0dTE4DumObvArhFlkopYurTfeyfWuuhazOpK3zVMgNnRgeBXYjW/AZOkGWah36OcvsNU3MNwahBcNbsj6Ok/jlvbGjydYEW8ECtVfc72tACjh73AMFAHxoiGtJiMKcAGC20aiQ/2no3kCBeIxnSuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749029838; c=relaxed/simple;
	bh=sjMBWVkLbbWXrvt+saV+I9C66EsDiYTKPsdh5ehd/18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnefeE+5kANljLDFaqAYW8EIjWHYdUmC5n5D71PJxq9XVMQH+W/OYbjS0AnchA6k9N8a9N4CbJd18/dlAbsnQYv1lCMnhVca7d2GzOgd3dORXmjr95/BjQ2hODVKr1eRo23ZM9jRIkkc/E3JOmGI/Ezut/6dE7hCtwoeMAuV32c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D7E8834601;
	Wed,  4 Jun 2025 09:29:25 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1B141369A;
	Wed,  4 Jun 2025 09:29:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qMIxM/URQGirEwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 04 Jun 2025 09:29:25 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/3] btrfs: use on-stack variable for block reserve in btrfs_truncate()
Date: Wed,  4 Jun 2025 11:29:25 +0200
Message-ID: <b1fd6998cb6b798cf1fbbc31ed4f08045392b8ed.1749029179.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: D7E8834601
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Score: -4.00

We can avoid potential memory allocation failure in btrfs_truncate() as
the block reserve lifetime is limited to the scope of the function. This
requires +48 bytes on stack.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 496194832166..3976a90e3c3c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7604,7 +7604,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 	};
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_block_rsv *rsv;
+	struct btrfs_block_rsv rsv;
 	int ret;
 	struct btrfs_trans_handle *trans;
 	u64 mask = fs_info->sectorsize - 1;
@@ -7646,11 +7646,9 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 	 * 2) fs_info->trans_block_rsv - this will have 1 items worth left for
 	 * updating the inode.
 	 */
-	rsv = btrfs_alloc_block_rsv(fs_info, BTRFS_BLOCK_RSV_TEMP);
-	if (!rsv)
-		return -ENOMEM;
-	rsv->size = min_size;
-	rsv->failfast = true;
+	btrfs_init_metadata_block_rsv(fs_info, &rsv, BTRFS_BLOCK_RSV_TEMP);
+	rsv.size = min_size;
+	rsv.failfast = true;
 
 	/*
 	 * 1 for the truncate slack space
@@ -7663,7 +7661,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 	}
 
 	/* Migrate the slack space for the truncate to our reserve */
-	ret = btrfs_block_rsv_migrate(&fs_info->trans_block_rsv, rsv,
+	ret = btrfs_block_rsv_migrate(&fs_info->trans_block_rsv, &rsv,
 				      min_size, false);
 	/*
 	 * We have reserved 2 metadata units when we started the transaction and
@@ -7675,7 +7673,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 		goto out;
 	}
 
-	trans->block_rsv = rsv;
+	trans->block_rsv = &rsv;
 
 	while (1) {
 		struct extent_state *cached_state = NULL;
@@ -7718,9 +7716,9 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 			break;
 		}
 
-		btrfs_block_rsv_release(fs_info, rsv, -1, NULL);
+		btrfs_block_rsv_release(fs_info, &rsv, -1, NULL);
 		ret = btrfs_block_rsv_migrate(&fs_info->trans_block_rsv,
-					      rsv, min_size, false);
+					      &rsv, min_size, false);
 		/*
 		 * We have reserved 2 metadata units when we started the
 		 * transaction and min_size matches 1 unit, so this should never
@@ -7729,7 +7727,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 		if (WARN_ON(ret))
 			break;
 
-		trans->block_rsv = rsv;
+		trans->block_rsv = &rsv;
 	}
 
 	/*
@@ -7768,7 +7766,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 		btrfs_btree_balance_dirty(fs_info);
 	}
 out:
-	btrfs_free_block_rsv(fs_info, rsv);
+	btrfs_block_rsv_release(fs_info, &rsv, (u64)-1, NULL);
 	/*
 	 * So if we truncate and then write and fsync we normally would just
 	 * write the extents that changed, which is a problem if we need to
-- 
2.47.1


