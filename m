Return-Path: <linux-btrfs+bounces-12613-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B613EA73697
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 17:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D187A1896710
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 16:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EE42AF1C;
	Thu, 27 Mar 2025 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GlC3IfgY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GlC3IfgY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A93C4C6E
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743092365; cv=none; b=XsYyTe7VhA8m+Td50MJiWxsMUS2e3v4EOR0dsXaQb0ntvX8WeC/vxtWGEMlchKRcInchWbQiI3iisBuRShzGEpjlLHsoVZ4SMgMJSCvx3kcG4LwuqJ/JeOwl4Is/GFlQZJ7ihJeggT5opKdpBQFGV2TlAFY7Qq8UlEkjUdhnfIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743092365; c=relaxed/simple;
	bh=UUWt/8IC7UKjgNFgfEdPHNDLGtsN8G3Wh4k0tPnABVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J6uSlBscAeKbwPmmrGvngYJHmO8q4qDuteVACsAxud3maS93bbsTwdAMn2HqcGT/3IL8qQklnqlU4kNJxcIAkfxuRiu65ghXHqiGMRVjfZxAwNOxzLNoJRDwhayIUiRbjyPp0b5jpiuV2fF/7vXSzKdxbzz0FfM1FowTsGAFAfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GlC3IfgY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GlC3IfgY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7FE93211B1;
	Thu, 27 Mar 2025 16:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743092361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CBtlf7pUannc3oE0AgaGm4FgOou8MMWLuTqnCaXG3mA=;
	b=GlC3IfgYQb2jXcadHn2Val/OCiJwf147M6mz58nYL5Q8Rr9tdQUgpMY77On5SrmVRZ8Zkq
	Sy/KveyywNIqLTbOftEzaqC6VGtUHKSzv+oo73WgsV+tS58CU0dL12entpo4HYLJ8p6J3X
	Qrbq8r4EF/sovmOvow94SBdJRZ8Uq7g=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743092361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CBtlf7pUannc3oE0AgaGm4FgOou8MMWLuTqnCaXG3mA=;
	b=GlC3IfgYQb2jXcadHn2Val/OCiJwf147M6mz58nYL5Q8Rr9tdQUgpMY77On5SrmVRZ8Zkq
	Sy/KveyywNIqLTbOftEzaqC6VGtUHKSzv+oo73WgsV+tS58CU0dL12entpo4HYLJ8p6J3X
	Qrbq8r4EF/sovmOvow94SBdJRZ8Uq7g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7947D139D4;
	Thu, 27 Mar 2025 16:19:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XFGWHYl65WfKBgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 27 Mar 2025 16:19:21 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: use rb_entry_safe() where possible to simplify code
Date: Thu, 27 Mar 2025 17:19:18 +0100
Message-ID: <20250327161918.1406913-1-dsterba@suse.com>
X-Mailer: git-send-email 2.48.1
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
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

Simplify conditionally reading an rb_entry(), there's the
rb_entry_safe() helper that checks the node pointer for NULL so we don't
have to write it explicitly.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/defrag.c         |  5 +----
 fs/btrfs/delayed-inode.c  | 27 ++++++---------------------
 fs/btrfs/delayed-ref.c    |  7 ++-----
 fs/btrfs/extent-io-tree.c | 10 ++--------
 fs/btrfs/extent_map.c     |  8 ++++----
 5 files changed, 15 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 8195e5fe355b00..11d27a9c5bd34d 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -191,10 +191,7 @@ static struct inode_defrag *btrfs_pick_defrag_inode(
 
 	if (parent && compare_inode_defrag(&tmp, entry) > 0) {
 		parent = rb_next(parent);
-		if (parent)
-			entry = rb_entry(parent, struct inode_defrag, rb_node);
-		else
-			entry = NULL;
+		entry = rb_entry_safe(parent, struct inode_defrag, rb_node);
 	}
 out:
 	if (entry)
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 3f1551d8a5c68b..c49bf8f2889dda 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -454,40 +454,25 @@ static void btrfs_release_delayed_item(struct btrfs_delayed_item *item)
 static struct btrfs_delayed_item *__btrfs_first_delayed_insertion_item(
 					struct btrfs_delayed_node *delayed_node)
 {
-	struct rb_node *p;
-	struct btrfs_delayed_item *item = NULL;
+	struct rb_node *p = rb_first_cached(&delayed_node->ins_root);
 
-	p = rb_first_cached(&delayed_node->ins_root);
-	if (p)
-		item = rb_entry(p, struct btrfs_delayed_item, rb_node);
-
-	return item;
+	return rb_entry_safe(p, struct btrfs_delayed_item, rb_node);
 }
 
 static struct btrfs_delayed_item *__btrfs_first_delayed_deletion_item(
 					struct btrfs_delayed_node *delayed_node)
 {
-	struct rb_node *p;
-	struct btrfs_delayed_item *item = NULL;
+	struct rb_node *p = rb_first_cached(&delayed_node->del_root);
 
-	p = rb_first_cached(&delayed_node->del_root);
-	if (p)
-		item = rb_entry(p, struct btrfs_delayed_item, rb_node);
-
-	return item;
+	return rb_entry_safe(p, struct btrfs_delayed_item, rb_node);
 }
 
 static struct btrfs_delayed_item *__btrfs_next_delayed_item(
 						struct btrfs_delayed_item *item)
 {
-	struct rb_node *p;
-	struct btrfs_delayed_item *next = NULL;
+	struct rb_node *p = rb_next(&item->rb_node);
 
-	p = rb_next(&item->rb_node);
-	if (p)
-		next = rb_entry(p, struct btrfs_delayed_item, rb_node);
-
-	return next;
+	return rb_entry_safe(p, struct btrfs_delayed_item, rb_node);
 }
 
 static int btrfs_delayed_item_reserve_metadata(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 98c5b61dabe88c..343a452a9f9fa5 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -331,12 +331,9 @@ static struct btrfs_delayed_ref_node* tree_insert(struct rb_root_cached *root,
 		struct btrfs_delayed_ref_node *ins)
 {
 	struct rb_node *node = &ins->ref_node;
-	struct rb_node *exist;
+	struct rb_node *exist = rb_find_add_cached(node, root, cmp_refs_node);
 
-	exist = rb_find_add_cached(node, root, cmp_refs_node);
-	if (exist)
-		return rb_entry(exist, struct btrfs_delayed_ref_node, ref_node);
-	return NULL;
+	return rb_entry_safe(exist, struct btrfs_delayed_ref_node, ref_node);
 }
 
 static struct btrfs_delayed_ref_head *find_first_ref_head(
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 13de6af279e526..db7503a91b3151 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -222,20 +222,14 @@ static inline struct extent_state *next_state(struct extent_state *state)
 {
 	struct rb_node *next = rb_next(&state->rb_node);
 
-	if (next)
-		return rb_entry(next, struct extent_state, rb_node);
-	else
-		return NULL;
+	return rb_entry_safe(next, struct extent_state, rb_node);
 }
 
 static inline struct extent_state *prev_state(struct extent_state *state)
 {
 	struct rb_node *next = rb_prev(&state->rb_node);
 
-	if (next)
-		return rb_entry(next, struct extent_state, rb_node);
-	else
-		return NULL;
+	return rb_entry_safe(next, struct extent_state, rb_node);
 }
 
 /*
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 7f46abbd6311b2..d62c36a0b7ba41 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -361,8 +361,8 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 
 	if (em->start != 0) {
 		rb = rb_prev(&em->rb_node);
-		if (rb)
-			merge = rb_entry(rb, struct extent_map, rb_node);
+		merge = rb_entry_safe(rb, struct extent_map, rb_node);
+
 		if (rb && can_merge_extent_map(merge) && mergeable_maps(merge, em)) {
 			em->start = merge->start;
 			em->len += merge->len;
@@ -379,8 +379,8 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 	}
 
 	rb = rb_next(&em->rb_node);
-	if (rb)
-		merge = rb_entry(rb, struct extent_map, rb_node);
+	merge = rb_entry_safe(rb, struct extent_map, rb_node);
+
 	if (rb && can_merge_extent_map(merge) && mergeable_maps(em, merge)) {
 		em->len += merge->len;
 		if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
-- 
2.48.1


