Return-Path: <linux-btrfs+bounces-10514-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D28B09F5954
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 23:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0307E188216C
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 21:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E761FA14D;
	Tue, 17 Dec 2024 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uyejygH9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uyejygH9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EA51E0DF5
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 21:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734472764; cv=none; b=b65ritvqdEbI1VwXIXcXpHsUeK1HdW2Mq9bobl4E7W7DNHE9RLbtOso1liA9HkRijsV2n2WAGT1RXIxe0DQncpOrjQhjbd3TH8+hukrwGhGW90Kh+3A69yEHjVSRL9ZMhcXe6V0QPg26cxVuWJM3VtiPxwDlu1Mx5YHg7njnqw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734472764; c=relaxed/simple;
	bh=wJj62jj+eBe9phUToA70tDjObzZNRs523hBR9xaHmqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQgtxE6RhcA66tcOT4yZB8eOvrWqYDg22qLHYx7QuHwbie55LyvGThSuFd5oX+C7maGFHBUiVCxUds2f/rc0ehBxh+RW9+sMPF9A45LxMMsrzoxJAAatjcVAhTMKJK15l3sKeC4DPY40PJfkCZZjvm8zPDDw4LkKQbX+T4LNGo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uyejygH9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uyejygH9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4031021163;
	Tue, 17 Dec 2024 21:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734472760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F4nZowy5Bb3XV4QJCQ4sJVeJ1VJwUCpfC5AFm5vqnzU=;
	b=uyejygH9qDQeF/5h6ioGUhbq3XDtZxUTuTRTG79o74iI8c0AyvwMmvMjbbl8ClI/NXWft7
	sPHb2xwJuMWiL2mtxtqSgEsfJf4heO3XFe5xIAhruAto3r0KxCK1BEj/3uR25YmTYwbqj/
	wec3L2yBnIzGEIklunSJ31Nf5RRRBvE=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=uyejygH9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734472760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F4nZowy5Bb3XV4QJCQ4sJVeJ1VJwUCpfC5AFm5vqnzU=;
	b=uyejygH9qDQeF/5h6ioGUhbq3XDtZxUTuTRTG79o74iI8c0AyvwMmvMjbbl8ClI/NXWft7
	sPHb2xwJuMWiL2mtxtqSgEsfJf4heO3XFe5xIAhruAto3r0KxCK1BEj/3uR25YmTYwbqj/
	wec3L2yBnIzGEIklunSJ31Nf5RRRBvE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0D9D13A3C;
	Tue, 17 Dec 2024 21:59:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oCMlHDb0YWfFEwAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 17 Dec 2024 21:59:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH v3 1/6] rbtree: add rb_find_add_cached() to rbtree.h
Date: Wed, 18 Dec 2024 08:28:50 +1030
Message-ID: <a4951de7451f83eef24bd2faf7f31d2ab19d1965.1734472236.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 4031021163
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	FREEMAIL_CC(0.00)[gmail.com,toxicpanda.com,infradead.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>

Adds rb_find_add_cached() as a helper function for use with
red-black trees. Used in btrfs to reduce boilerplate code.

And since it's a new helper, the cmp() function will require both
parameter to be const rb_node pointers.

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 include/linux/rbtree.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index 7c173aa64e1e..8d2ba3749866 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -210,6 +210,43 @@ rb_add(struct rb_node *node, struct rb_root *tree,
 	rb_insert_color(node, tree);
 }
 
+/**
+ * rb_find_add_cached() - find equivalent @node in @tree, or add @node
+ * @node: node to look-for / insert
+ * @tree: tree to search / modify
+ * @cmp: operator defining the node order
+ *
+ * Returns the rb_node matching @node, or NULL when no match is found and @node
+ * is inserted.
+ */
+static __always_inline struct rb_node *
+rb_find_add_cached(struct rb_node *node, struct rb_root_cached *tree,
+	    int (*cmp)(const struct rb_node *new, const struct rb_node *exist))
+{
+	bool leftmost = true;
+	struct rb_node **link = &tree->rb_root.rb_node;
+	struct rb_node *parent = NULL;
+	int c;
+
+	while (*link) {
+		parent = *link;
+		c = cmp(node, parent);
+
+		if (c < 0) {
+			link = &parent->rb_left;
+		} else if (c > 0) {
+			link = &parent->rb_right;
+			leftmost = false;
+		} else {
+			return parent;
+		}
+	}
+
+	rb_link_node(node, parent, link);
+	rb_insert_color_cached(node, tree, leftmost);
+	return NULL;
+}
+
 /**
  * rb_find_add() - find equivalent @node in @tree, or add @node
  * @node: node to look-for / insert
-- 
2.47.1


