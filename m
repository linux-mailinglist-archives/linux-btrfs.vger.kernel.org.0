Return-Path: <linux-btrfs+bounces-10518-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50189F5941
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 23:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097F317033F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 22:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C101FA844;
	Tue, 17 Dec 2024 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EsCWJSmj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EsCWJSmj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4501A1FA179
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734472773; cv=none; b=mPzYVUPjj5GQB+SgBlSBYXDwkhNrOAIPO5HP12yNmBm8y4UIeTKpZjwCHyuaI/+DqGPLfnLSwKrN3/I/jfMjtIL8RLgPNIg1iShGsreG3mVd/h7TZIu3mM7/Tgghxu//hCgp0CdaFAvOJjoTjODummuuIF+4arugUbZ41wWieMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734472773; c=relaxed/simple;
	bh=BKv2OEUcTZefMoKn1HneEYiIgzvF7jR4tj+dwy4m2IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQRjrdywBjAfL1z54viMD8G4Amvo+Ej6obv/PvYfpFbOaeBW/QaLw8NjbOFoT9FX4/tXsHQsIyJv7AOYuGZ3puPLWCEoY41G6kqu4GEG2Q2hT+f7qnwB5I3lzTglgheiJ7bWwP9586ijmwHCBknNUYuiMlz5LqtymEKh+VZVNm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EsCWJSmj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EsCWJSmj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8424C1F397;
	Tue, 17 Dec 2024 21:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734472763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh/UVTKsIv867nz5/WR05EGq4ypthIr4CtwavvPEhEU=;
	b=EsCWJSmjGUJumWU6OAvWDugwytU5cBBuydfbkWI7ZqxQ25+6ASoiORG7tlYOyWBYBDAwYj
	R6GzRbGynw+ILQp/rgRBbkIDibsNpxd+nuMYseRvx621gaexjydn5CX/wYn3G+EGstXuME
	07GCUyKp4OXhbRu8MoL6runH0bba5pY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=EsCWJSmj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734472763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rh/UVTKsIv867nz5/WR05EGq4ypthIr4CtwavvPEhEU=;
	b=EsCWJSmjGUJumWU6OAvWDugwytU5cBBuydfbkWI7ZqxQ25+6ASoiORG7tlYOyWBYBDAwYj
	R6GzRbGynw+ILQp/rgRBbkIDibsNpxd+nuMYseRvx621gaexjydn5CX/wYn3G+EGstXuME
	07GCUyKp4OXhbRu8MoL6runH0bba5pY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C23613A3C;
	Tue, 17 Dec 2024 21:59:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IPhaDzr0YWfFEwAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 17 Dec 2024 21:59:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: [PATCH v3 3/6] btrfs: update prelim_ref_insert() to use rb helpers
Date: Wed, 18 Dec 2024 08:28:52 +1030
Message-ID: <4d26bf1052ec09502e9c41d2575b6ecbc564da9c.1734472236.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734472236.git.wqu@suse.com>
References: <cover.1734472236.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8424C1F397
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>

Update prelim_ref_insert() to use rb_find_add_cached().

There is a special change that the existing prelim_ref_compare() is
called with the first parameter as the existing ref in the rbtree.

But the newer rb_find_add_cached() expects the cmp() function to have
the first parameter as the to-be-added node, thus the new helper
prelim_ref_rb_add_cmp() need to adapt this new order.

Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/backref.c | 79 +++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 40 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 6d9f39c1d89c..3d3923cfc357 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -250,6 +250,21 @@ static int prelim_ref_compare(const struct prelim_ref *ref1,
 	return 0;
 }
 
+static int prelim_ref_rb_add_cmp(const struct rb_node *new,
+				 const struct rb_node *exist)
+{
+	const struct prelim_ref *ref_new =
+		rb_entry(new, struct prelim_ref, rbnode);
+	const struct prelim_ref *ref_exist =
+		rb_entry(exist, struct prelim_ref, rbnode);
+
+	/*
+	 * prelim_ref_compare() expects the first parameter as the existing one,
+	 * different from the rb_find_add_cached() order.
+	 */
+	return prelim_ref_compare(ref_exist, ref_new);
+}
+
 static void update_share_count(struct share_check *sc, int oldcount,
 			       int newcount, const struct prelim_ref *newref)
 {
@@ -278,55 +293,39 @@ static void prelim_ref_insert(const struct btrfs_fs_info *fs_info,
 			      struct share_check *sc)
 {
 	struct rb_root_cached *root;
-	struct rb_node **p;
-	struct rb_node *parent = NULL;
-	struct prelim_ref *ref;
-	int result;
-	bool leftmost = true;
+	struct rb_node *exist;
 
 	root = &preftree->root;
-	p = &root->rb_root.rb_node;
+	exist = rb_find_add_cached(&newref->rbnode, root, prelim_ref_rb_add_cmp);
+	if (exist) {
+		struct prelim_ref *ref = rb_entry(exist, struct prelim_ref, rbnode);
+		/* Identical refs, merge them and free @newref */
+		struct extent_inode_elem *eie = ref->inode_list;
 
-	while (*p) {
-		parent = *p;
-		ref = rb_entry(parent, struct prelim_ref, rbnode);
-		result = prelim_ref_compare(ref, newref);
-		if (result < 0) {
-			p = &(*p)->rb_left;
-		} else if (result > 0) {
-			p = &(*p)->rb_right;
-			leftmost = false;
-		} else {
-			/* Identical refs, merge them and free @newref */
-			struct extent_inode_elem *eie = ref->inode_list;
+		while (eie && eie->next)
+			eie = eie->next;
 
-			while (eie && eie->next)
-				eie = eie->next;
-
-			if (!eie)
-				ref->inode_list = newref->inode_list;
-			else
-				eie->next = newref->inode_list;
-			trace_btrfs_prelim_ref_merge(fs_info, ref, newref,
-						     preftree->count);
-			/*
-			 * A delayed ref can have newref->count < 0.
-			 * The ref->count is updated to follow any
-			 * BTRFS_[ADD|DROP]_DELAYED_REF actions.
-			 */
-			update_share_count(sc, ref->count,
-					   ref->count + newref->count, newref);
-			ref->count += newref->count;
-			free_pref(newref);
-			return;
-		}
+		if (!eie)
+			ref->inode_list = newref->inode_list;
+		else
+			eie->next = newref->inode_list;
+		trace_btrfs_prelim_ref_merge(fs_info, ref, newref,
+							preftree->count);
+		/*
+		 * A delayed ref can have newref->count < 0.
+		 * The ref->count is updated to follow any
+		 * BTRFS_[ADD|DROP]_DELAYED_REF actions.
+		 */
+		update_share_count(sc, ref->count,
+					ref->count + newref->count, newref);
+		ref->count += newref->count;
+		free_pref(newref);
+		return;
 	}
 
 	update_share_count(sc, 0, newref->count, newref);
 	preftree->count++;
 	trace_btrfs_prelim_ref_insert(fs_info, newref, NULL, preftree->count);
-	rb_link_node(&newref->rbnode, parent, p);
-	rb_insert_color_cached(&newref->rbnode, root, leftmost);
 }
 
 /*
-- 
2.47.1


