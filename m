Return-Path: <linux-btrfs+bounces-7588-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E81961993
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 23:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6B0285097
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 21:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDD61D4145;
	Tue, 27 Aug 2024 21:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="I5q9ulmn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="F3sewc4Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2737C1C8FC4
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 21:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795753; cv=none; b=r3eZra92ngcepAP2iFHcjq9EctLXf1z/wvUG3f/tPINu1bp3GbdI52YgtCOjI2ihSvqj8KfXHd3ZiDjaf1195KQo0D33l7LrKURhvvWYAgav50Wjo0Kdy2n9FgPG6vxxN37ld6/KP8nyQ9L9H1477MeysiCQTs2VHcnNelbm7jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795753; c=relaxed/simple;
	bh=Y7BBeUYlgUcoT6haH6leC9md2m/JQI1Emk0N2tgx9wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTNEmhkZxV5yf/cf7z1MqA55d3T+7NiUgHemoTJ6M8a9a0Yz8eP8D1qSZFJ5p+quQ1pmJyTNZSh6vXErEZKBSmihTTi/1qEv3DKWcjb8qRviy+5B+w2cWCn3F/jnG6hYoxL0tdEMJ5KX0snISbNq1uLXZuMEXJkMoHWoea/N/Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=I5q9ulmn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=F3sewc4Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 77E041FB85;
	Tue, 27 Aug 2024 21:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8E0NHZlWtRquESXLOa+AVkkMojON58g8Xd3ZEtqVgQM=;
	b=I5q9ulmnvvRRa7iOsUVarlz1v0l+8FlhPPAE+9X1IjasQ7Zt7zKcl5jsWv8MJzbuyy96i1
	csbvkTYvC7y033Gxvf1UnjkLFSSdPmlodwjZyAjNkhl//XKsqmoyguEXblwvUQXkd4lJ9b
	ONLIrb9BgTykV9LX03/0EJzHrJBFNvg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8E0NHZlWtRquESXLOa+AVkkMojON58g8Xd3ZEtqVgQM=;
	b=F3sewc4QS5v+OksjILLOg0xs71Lwepk8nlADRF3XIrormE1btZpJ4Zyc55CdnPs6siMIhz
	lb2i7C3/cDyExRbw3Yt5moPbZKqvtqI1UxdtYo2dUZ8+8OSBqA1XXScfMHpn4Vl8jkAy4l
	W+TZIKdjrkmyvRJ677yvAh7aRbx/PTc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7098B13A20;
	Tue, 27 Aug 2024 21:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Add6G2VLzma7GgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 27 Aug 2024 21:55:49 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 10/12] btrfs: return void from btrfs_add_inode_defrag()
Date: Tue, 27 Aug 2024 23:55:45 +0200
Message-ID: <00f7e001c3360658d0b3d7ff058467b7bc51aacc.1724795624.git.dsterba@suse.com>
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
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The potential memory allocation failure is not a fatal error, skipping
autodefrag is fine and the caller inode_should_defrag() does not care
about the errors.  Further writes can attempt to add the inode back to
the defragmentation list again.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/defrag.c | 14 +++++++-------
 fs/btrfs/defrag.h |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index bd1769dd134c..f4c62b6faf3e 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -117,10 +117,11 @@ static inline int need_auto_defrag(struct btrfs_fs_info *fs_info)
 }
 
 /*
- * Insert a defrag record for this inode if auto defrag is enabled.
+ * Insert a defrag record for this inode if auto defrag is enabled. No errors
+ * returned as they're not considered fatal.
  */
-int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
-			   struct btrfs_inode *inode, u32 extent_thresh)
+void btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
+			    struct btrfs_inode *inode, u32 extent_thresh)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -129,10 +130,10 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
 	int ret;
 
 	if (!need_auto_defrag(fs_info))
-		return 0;
+		return;
 
 	if (test_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags))
-		return 0;
+		return;
 
 	if (trans)
 		transid = trans->transid;
@@ -141,7 +142,7 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
 
 	defrag = kmem_cache_zalloc(btrfs_inode_defrag_cachep, GFP_NOFS);
 	if (!defrag)
-		return -ENOMEM;
+		return;
 
 	defrag->ino = btrfs_ino(inode);
 	defrag->transid = transid;
@@ -162,7 +163,6 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
 		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
 	}
 	spin_unlock(&fs_info->defrag_inodes_lock);
-	return 0;
 }
 
 /*
diff --git a/fs/btrfs/defrag.h b/fs/btrfs/defrag.h
index 878528e086fb..97f36ab3f24d 100644
--- a/fs/btrfs/defrag.h
+++ b/fs/btrfs/defrag.h
@@ -18,8 +18,8 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		      u64 newer_than, unsigned long max_to_defrag);
 int __init btrfs_auto_defrag_init(void);
 void __cold btrfs_auto_defrag_exit(void);
-int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
-			   struct btrfs_inode *inode, u32 extent_thresh);
+void btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
+			    struct btrfs_inode *inode, u32 extent_thresh);
 int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info);
 void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info);
 int btrfs_defrag_root(struct btrfs_root *root);
-- 
2.45.0


