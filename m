Return-Path: <linux-btrfs+bounces-10517-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 696FF9F5956
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 23:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC0A1896756
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 22:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7291FA27C;
	Tue, 17 Dec 2024 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Dd1muVw2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Dd1muVw2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4B11F8699
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734472771; cv=none; b=rhKcvxftRMXw/Iy64lWLpNL3vvlIVzbvD7XYacXJm0dep5xp3nEj1vvJDib/pqA9HOScXv9XK+iNYUsb/cJE2asTnW9P2d3cy2F0hLa0BBnusvOSzlBQtksnza+bNuqObJ/P7PJXEhWdEP7szJuliUFXJZUWZdbZj77yeVuVDZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734472771; c=relaxed/simple;
	bh=bGrc48eD5wtyg9WZ63+oyFawXegXhoqT/tsp1Uqz0Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hC+zGV1bQP8wtP2QHyoKil7r2zPcKRdmUPb3H+XKqz9m1dNMKLcT1fcOfPtuN1d5bq2mh1tD1Un33kGBPkoBILic3NcfH3pbiZuj8FVW4Bs9pbXHs5Y7X0wOwiOoMDaSeTi0dJ11WRHY0Q66IwFOJ3MxFa8mB3G5edwJAcZ0oFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Dd1muVw2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Dd1muVw2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 143F021164;
	Tue, 17 Dec 2024 21:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734472768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TuUerEEOXw+Aia1I4nFFTIZQEp+Zf5NcckxDAGMuCsY=;
	b=Dd1muVw2Jr4hwTxWePoL0dStyta1GOtlzlRZmncwp/9roahWnlm5SUVGa4CQ8pwzJNQzqp
	cSSM9aAXafF4yLMC2r8AJx/kHReRr5FHHSg706I9g6TMZOZn7QbC0vSmFMxDasfFGqcRju
	LDygvEhBZPvbPQ+Gc4/yvnrICkTTrRI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734472768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TuUerEEOXw+Aia1I4nFFTIZQEp+Zf5NcckxDAGMuCsY=;
	b=Dd1muVw2Jr4hwTxWePoL0dStyta1GOtlzlRZmncwp/9roahWnlm5SUVGa4CQ8pwzJNQzqp
	cSSM9aAXafF4yLMC2r8AJx/kHReRr5FHHSg706I9g6TMZOZn7QbC0vSmFMxDasfFGqcRju
	LDygvEhBZPvbPQ+Gc4/yvnrICkTTrRI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CFF713A3C;
	Tue, 17 Dec 2024 21:59:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YPHELz70YWfFEwAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 17 Dec 2024 21:59:26 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: [PATCH v3 6/6] btrfs: update tree_insert() to use rb helpers
Date: Wed, 18 Dec 2024 08:28:55 +1030
Message-ID: <5c9077d703082c50b978666a8dab0d4836d7995b.1734472236.git.wqu@suse.com>
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
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>

Update tree_insert() to use rb_find_add_cached().
add cmp_refs_node in rb_find_add_cached() to compare.

Since we're here, also make comp_data_refs() and comp_refs() accept
both parameters as const.

Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/delayed-ref.c | 45 +++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 30f7079fa28e..98c5b61dabe8 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -268,8 +268,8 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 /*
  * compare two delayed data backrefs with same bytenr and type
  */
-static int comp_data_refs(struct btrfs_delayed_ref_node *ref1,
-			  struct btrfs_delayed_ref_node *ref2)
+static int comp_data_refs(const struct btrfs_delayed_ref_node *ref1,
+			  const struct btrfs_delayed_ref_node *ref2)
 {
 	if (ref1->data_ref.objectid < ref2->data_ref.objectid)
 		return -1;
@@ -282,8 +282,8 @@ static int comp_data_refs(struct btrfs_delayed_ref_node *ref1,
 	return 0;
 }
 
-static int comp_refs(struct btrfs_delayed_ref_node *ref1,
-		     struct btrfs_delayed_ref_node *ref2,
+static int comp_refs(const struct btrfs_delayed_ref_node *ref1,
+		     const struct btrfs_delayed_ref_node *ref2,
 		     bool check_seq)
 {
 	int ret = 0;
@@ -317,34 +317,25 @@ static int comp_refs(struct btrfs_delayed_ref_node *ref1,
 	return 0;
 }
 
+static int cmp_refs_node(const struct rb_node *new, const struct rb_node *exist)
+{
+	const struct btrfs_delayed_ref_node *new_node =
+		rb_entry(new, struct btrfs_delayed_ref_node, ref_node);
+	const struct btrfs_delayed_ref_node *exist_node =
+		rb_entry(exist, struct btrfs_delayed_ref_node, ref_node);
+
+	return comp_refs(new_node, exist_node, true);
+}
+
 static struct btrfs_delayed_ref_node* tree_insert(struct rb_root_cached *root,
 		struct btrfs_delayed_ref_node *ins)
 {
-	struct rb_node **p = &root->rb_root.rb_node;
 	struct rb_node *node = &ins->ref_node;
-	struct rb_node *parent_node = NULL;
-	struct btrfs_delayed_ref_node *entry;
-	bool leftmost = true;
+	struct rb_node *exist;
 
-	while (*p) {
-		int comp;
-
-		parent_node = *p;
-		entry = rb_entry(parent_node, struct btrfs_delayed_ref_node,
-				 ref_node);
-		comp = comp_refs(ins, entry, true);
-		if (comp < 0) {
-			p = &(*p)->rb_left;
-		} else if (comp > 0) {
-			p = &(*p)->rb_right;
-			leftmost = false;
-		} else {
-			return entry;
-		}
-	}
-
-	rb_link_node(node, parent_node, p);
-	rb_insert_color_cached(node, root, leftmost);
+	exist = rb_find_add_cached(node, root, cmp_refs_node);
+	if (exist)
+		return rb_entry(exist, struct btrfs_delayed_ref_node, ref_node);
 	return NULL;
 }
 
-- 
2.47.1


