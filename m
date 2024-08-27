Return-Path: <linux-btrfs+bounces-7587-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE71B961992
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 23:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2FE0285207
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 21:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120261D416F;
	Tue, 27 Aug 2024 21:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BBw/KSS6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BBw/KSS6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6681D416A
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 21:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795746; cv=none; b=WuYK95AARCqurXdjxtXchy9Vq731W1Kdo6bz7B37lQZDm+ZFHN+xre1JTTyVK7QptkgOPtQiEG38v2w2r5aQLad8F3OGViHHM+cQRvUJcsGPQC/jT3Z4QJLlnsC3/fpNw5XyoFPV+P4NbNsfnt+tDIrtW+wqBNZXDmuhDnYupPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795746; c=relaxed/simple;
	bh=9xeAGoQ6BT0uhzhCg8OwDdcQNCZhisFxw6Y2jGgUUoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnQcJ9lS0lCiSCW54LzQYW+fQkw+j1Q5GriT1xmtFW2JiEox4Ntt0yiksEZZhxOoLo+R4SffrCFUljishOLcxA1HfktKyNQV8NO0H4GrcEgKTuL5QL47JjYwUtS0bCBgq39JwvJBZ2VOW4mnbYNz6vRx2/g3U3OkvBxqNsEKvzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BBw/KSS6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BBw/KSS6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 17D7D21B2E;
	Tue, 27 Aug 2024 21:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTaFevpAwrF/YX2bqMT9sceX5CHVhhi7aP3dBLZOuss=;
	b=BBw/KSS686ndWMhod+vLhqOog5vFw31xzz4CYQicN+lInrrYc+kQcWVTw5shf6LkfFGn34
	96n60f4jVbejhKYPodzYRGO3npgrLhqoHVC4UmeECXK8Al/SGE1uqKyhwF81txFK9+5yRQ
	/xFCkMVzUcCiVSAfYiBjS/CKA9gcQ1w=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="BBw/KSS6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTaFevpAwrF/YX2bqMT9sceX5CHVhhi7aP3dBLZOuss=;
	b=BBw/KSS686ndWMhod+vLhqOog5vFw31xzz4CYQicN+lInrrYc+kQcWVTw5shf6LkfFGn34
	96n60f4jVbejhKYPodzYRGO3npgrLhqoHVC4UmeECXK8Al/SGE1uqKyhwF81txFK9+5yRQ
	/xFCkMVzUcCiVSAfYiBjS/CKA9gcQ1w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10BD913A20;
	Tue, 27 Aug 2024 21:55:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vIwRBF9Lzma3GgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 27 Aug 2024 21:55:43 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 09/12] btrfs: clear defragmented inodes using postorder in btrfs_cleanup_defrag_inodes()
Date: Tue, 27 Aug 2024 23:55:42 +0200
Message-ID: <e4ad6d8e46f084001770fb9dad6ac8df38cd3e2e.1724795624.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: 17D7D21B2E
X-Spam-Score: -3.01
X-Rspamd-Action: no action
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

btrfs_cleanup_defrag_inodes() is not called frequently, only in remount
or unmount, but the way it frees the inodes in fs_info->defrag_inodes
is inefficient. Each time it needs to locate first node, remove it,
potentially rebalance tree until it's done. This allows to do a
conditional reschedule.

For cleanups the rbtree_postorder_for_each_entry_safe() iterator is
convenient but if the reschedule happens and unlocks fs_info->defrag_inodes_lock
we can't be sure that the tree is in the same state. If that happens,
restart the iteration from the beginning.

The cleanup operation is kmem_cache_free() which will likely take the
fast path for most objects.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/defrag.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 41d67065d02b..bd1769dd134c 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -212,19 +212,18 @@ static struct inode_defrag *btrfs_pick_defrag_inode(
 
 void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info)
 {
-	struct inode_defrag *defrag;
-	struct rb_node *node;
+	struct inode_defrag *defrag, *next;
 
 	spin_lock(&fs_info->defrag_inodes_lock);
-	node = rb_first(&fs_info->defrag_inodes);
-	while (node) {
-		rb_erase(node, &fs_info->defrag_inodes);
-		defrag = rb_entry(node, struct inode_defrag, rb_node);
+again:
+	rbtree_postorder_for_each_entry_safe(defrag, next, &fs_info->defrag_inodes,
+					     rb_node) {
 		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
 
-		cond_resched_lock(&fs_info->defrag_inodes_lock);
-
-		node = rb_first(&fs_info->defrag_inodes);
+		if (cond_resched_lock(&fs_info->defrag_inodes_lock)) {
+			/* Rescheduled and unlocked. */
+			goto again;
+		}
 	}
 	spin_unlock(&fs_info->defrag_inodes_lock);
 }
-- 
2.45.0


