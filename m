Return-Path: <linux-btrfs+bounces-7589-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BAC961994
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 23:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69EE02851D4
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 21:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1978B1D4168;
	Tue, 27 Aug 2024 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ExNgX7YT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ExNgX7YT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A641D3652
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795755; cv=none; b=uYxeEnMt6NaKlvk7iNR9WfWObN5KIguqar2waLZNnxBjPqRhSosSP86uIPuSaiJqRjBSw5NRP2+zUYfsYRW3k9iPCqhZVQxLRCit9rRMEGV2m1s9sN+AcSWvudHOsmpmNq9hkkZim1L+14EIZaqPSCEkGVddupiTKKlRt833iRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795755; c=relaxed/simple;
	bh=Z6oI0CKk73sdLXMgEyKnY0MLqAzlBtw7prABoh9cVZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJ3+lYJQ7bNqEZkFDmXO1jl2Kk4GPKOBujM5Si41h2MDv8rM2OtyRiG/zYpy33qAUMJew6QLwQ5qU67pJ1YfazgpkUWrmg0ATIhspz6WX5mnv8OOqAknqSiHJRJGVMpi0/3k8MkGAcanLnS/dmoG+cOq77kgJR64uxR+s8yHrlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ExNgX7YT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ExNgX7YT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D71AA1FB86;
	Tue, 27 Aug 2024 21:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v+lXnYCQ4RSbUbMcAKhuR5f7OQYEHRTNeTmqteG29wU=;
	b=ExNgX7YTJBGdaD0PSKqnzwA8br8VavEAd3MELsJcOiNUmEjTCYcPyOnZQIHfvckcVbz3hq
	H9SDO2E6ClIo5TydcKhWGKIRBxqGEmtjPnf/jJ3PuPovSQMbEL/+tdG60bINCoDmt6rpak
	HNrBAyjuqiac/LWqbB2N4OsEbKSGgmQ=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ExNgX7YT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v+lXnYCQ4RSbUbMcAKhuR5f7OQYEHRTNeTmqteG29wU=;
	b=ExNgX7YTJBGdaD0PSKqnzwA8br8VavEAd3MELsJcOiNUmEjTCYcPyOnZQIHfvckcVbz3hq
	H9SDO2E6ClIo5TydcKhWGKIRBxqGEmtjPnf/jJ3PuPovSQMbEL/+tdG60bINCoDmt6rpak
	HNrBAyjuqiac/LWqbB2N4OsEbKSGgmQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D02F213A20;
	Tue, 27 Aug 2024 21:55:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hFvQMmdLzma/GgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 27 Aug 2024 21:55:51 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 11/12] btrfs: drop transaction parameter from btrfs_add_inode_defrag()
Date: Tue, 27 Aug 2024 23:55:51 +0200
Message-ID: <3eb5f054591b797b05ce1b6e97fb684f28e9a6a1.1724795624.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1724795623.git.dsterba@suse.com>
References: <cover.1724795623.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D71AA1FB86
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

There's only one caller inode_should_defrag() that passes NULL to
btrfs_add_inode_defrag() so we can drop it an simplify the code.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/defrag.c | 11 ++---------
 fs/btrfs/defrag.h |  3 +--
 fs/btrfs/inode.c  |  2 +-
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index f4c62b6faf3e..7333512cc9dd 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -120,13 +120,11 @@ static inline int need_auto_defrag(struct btrfs_fs_info *fs_info)
  * Insert a defrag record for this inode if auto defrag is enabled. No errors
  * returned as they're not considered fatal.
  */
-void btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
-			    struct btrfs_inode *inode, u32 extent_thresh)
+void btrfs_add_inode_defrag(struct btrfs_inode *inode, u32 extent_thresh)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct inode_defrag *defrag;
-	u64 transid;
 	int ret;
 
 	if (!need_auto_defrag(fs_info))
@@ -135,17 +133,12 @@ void btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
 	if (test_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags))
 		return;
 
-	if (trans)
-		transid = trans->transid;
-	else
-		transid = btrfs_get_root_last_trans(root);
-
 	defrag = kmem_cache_zalloc(btrfs_inode_defrag_cachep, GFP_NOFS);
 	if (!defrag)
 		return;
 
 	defrag->ino = btrfs_ino(inode);
-	defrag->transid = transid;
+	defrag->transid = btrfs_get_root_last_trans(root);
 	defrag->root = btrfs_root_id(root);
 	defrag->extent_thresh = extent_thresh;
 
diff --git a/fs/btrfs/defrag.h b/fs/btrfs/defrag.h
index 97f36ab3f24d..6b7596c4f0dc 100644
--- a/fs/btrfs/defrag.h
+++ b/fs/btrfs/defrag.h
@@ -18,8 +18,7 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		      u64 newer_than, unsigned long max_to_defrag);
 int __init btrfs_auto_defrag_init(void);
 void __cold btrfs_auto_defrag_exit(void);
-void btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
-			    struct btrfs_inode *inode, u32 extent_thresh);
+void btrfs_add_inode_defrag(struct btrfs_inode *inode, u32 extent_thresh);
 int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info);
 void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info);
 int btrfs_defrag_root(struct btrfs_root *root);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9a81516e074a..62e1e407626e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -885,7 +885,7 @@ static inline void inode_should_defrag(struct btrfs_inode *inode,
 	/* If this is a small write inside eof, kick off a defrag */
 	if (num_bytes < small_write &&
 	    (start > 0 || end + 1 < inode->disk_i_size))
-		btrfs_add_inode_defrag(NULL, inode, small_write);
+		btrfs_add_inode_defrag(inode, small_write);
 }
 
 static int extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end)
-- 
2.45.0


