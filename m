Return-Path: <linux-btrfs+bounces-10455-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC8E9F4521
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 08:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647E2167C91
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 07:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0F416EC19;
	Tue, 17 Dec 2024 07:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="e9dDG+gK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="e9dDG+gK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58E6179A7
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734420679; cv=none; b=LRIryiBODCHY/eWbiW9CZTUDQwvfpHI0QUNFAYS/ZpAHvBsnL50c34jXeILSAd3Myc2qqMjm5UoXEQpxADTnvF6qEnPH7Ey3X9jZeWTaePSWaVrqMpT5t4r0J+PpTjsGIxv3ehnIuNSA78oYmws7eg//eQmk9wvhdmiNqwba2mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734420679; c=relaxed/simple;
	bh=s3QpolYAVtYazZazTfhEc1tdPv7uCP1axb0HgI/agtU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rB3YYHeeVfkqQq6JIVJ1A1CJZ7WyrXeYGvUiIcW/qe0v0SrunkwHq2jXDt8s7womaORFC2sQ+eII/l1AWDFIEpWmIL4Hnc+UdSRN3fgmx9SIkUl1HCFhDRtTbZpF91iNp8Bbxgy51F9AFNNeEYT8TJk811DjfIIV1u8p/nYt0KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=e9dDG+gK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=e9dDG+gK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 920E32111F
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 07:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734420675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SV9IfzNFeEqyTAdDvGrezufCMustiuJlOnvTWyp83Ag=;
	b=e9dDG+gKcGd3zCPuKjSZzcCnh4NkN5Yzcbj7HbEch/EHr8niDLYLKyVbvQDzrYqpPKkgkd
	YPOyCbuSv9B2VYaRbmg03yDjoX0NkIY+mZZfrGFTKLpKnDSAan1OHOhS31DgNJn9F5QhL1
	nFE5cljvTgSjSfo9M7mYHk4LQGeM3EY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=e9dDG+gK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734420675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SV9IfzNFeEqyTAdDvGrezufCMustiuJlOnvTWyp83Ag=;
	b=e9dDG+gKcGd3zCPuKjSZzcCnh4NkN5Yzcbj7HbEch/EHr8niDLYLKyVbvQDzrYqpPKkgkd
	YPOyCbuSv9B2VYaRbmg03yDjoX0NkIY+mZZfrGFTKLpKnDSAan1OHOhS31DgNJn9F5QhL1
	nFE5cljvTgSjSfo9M7mYHk4LQGeM3EY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD44613A3C
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 07:31:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vyblGcIoYWczCgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 07:31:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: handle free space tree rebuild in multiple transactions
Date: Tue, 17 Dec 2024 18:00:56 +1030
Message-ID: <58dac27acbab72124549718201bec971491b5b1a.1734420572.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 920E32111F
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

During free space tree rebuild, we're holding on transaction handler for
the whole rebuild process.

This will cause blocked task warning for btrfs-transaction kernel
thread, as during the rebuild, btrfs-transaction kthread has to wait for
the running transaction we're holding for free space tree rebuild.

On a large enough btrfs, we have thousands of block groups to go
through, thus it will definitely take over 120s and trigger the blocked
task warning.

Fix the problem by handling 32 block groups in one transaction, and end
the transaction when we hit the 32 block groups threshold.

This will allow the btrfs-transaction kthread to commit the transaction
when needed.

And even if during the rebuild the system lost its power, we are still
fine as we didn't set FREE_SPACE_TREE_VALID flag, thus on next RW mount
we will still rebuild the tree, without utilizing the half built one.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/free-space-tree.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 7ba50e133921..d8f334724092 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1312,6 +1312,8 @@ int btrfs_delete_free_space_tree(struct btrfs_fs_info *fs_info)
 	return btrfs_commit_transaction(trans);
 }
 
+/* How many block groups can be handled in one transaction. */
+#define FREE_SPACE_TREE_REBUILD_BATCH	(32)
 int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_trans_handle *trans;
@@ -1322,6 +1324,7 @@ int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info)
 	};
 	struct btrfs_root *free_space_root = btrfs_global_root(fs_info, &key);
 	struct rb_node *node;
+	unsigned int handled = 0;
 	int ret;
 
 	trans = btrfs_start_transaction(free_space_root, 1);
@@ -1350,6 +1353,15 @@ int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info)
 			btrfs_end_transaction(trans);
 			return ret;
 		}
+		handled++;
+		handled %= FREE_SPACE_TREE_REBUILD_BATCH;
+		if (!handled) {
+			btrfs_end_transaction(trans);
+			trans = btrfs_start_transaction(free_space_root,
+					FREE_SPACE_TREE_REBUILD_BATCH);
+			if (IS_ERR(trans))
+				return PTR_ERR(trans);
+		}
 		node = rb_next(node);
 	}
 
-- 
2.47.1


