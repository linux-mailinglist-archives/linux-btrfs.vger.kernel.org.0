Return-Path: <linux-btrfs+bounces-10515-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DBD9F593D
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 23:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DDD516F139
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 21:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03001FA241;
	Tue, 17 Dec 2024 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S5Yq9OrY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S5Yq9OrY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E126C1F7580
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734472770; cv=none; b=dTyC/9bo5jIF9fyZ/gKhpEmjQfROM7oO0RZ3AJ63Bhz9csUWTzALqOMwz7ePHxUiK/L36YnZ0gs8o+MzUNDXiGqzAlJrYI2t4eTZNJqo9ohgqOZ/iOBqxq+7g2zh10Qga+il1/wRkQGTIIBZD1kfIqSh9Zh48yX/YkTro2ol40s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734472770; c=relaxed/simple;
	bh=wgS20EItgZxOaVPYS87J/7zoVPn94Jb2Df3QY0HAZRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvUylXh/Q/6alRccAG49ZtE7PBZ/e9UXY56DXW3I913kqr5rygUk2Mn57hb4t+apH6FKcTHlxVQmjkAzfxytEsCAfimXcSrq9AQGgFuqwVx5696vcTKVGc+O2h6UCh7WkTGWJjPBrl4G0nQqbUIFrBkMqkRjeVxulEN4FgXvOTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S5Yq9OrY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S5Yq9OrY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0CC9021162;
	Tue, 17 Dec 2024 21:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734472765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wOqj5R8dJpQiw2kwNNGcGHkCt3yny+pIXyrUMmerU0s=;
	b=S5Yq9OrY0xKnHvy0aE+W7Qm2tWE4DAUmQlIpXFX9snk82CqyYH1RBvz37XLGQ/ndmVUVER
	BbV1Iz8ygekYa67P9N0SeXxCQj+41NzgWgOsEUXG6z5NQKTR1Fv2LAnlNZIJU+pAz+EkTg
	IgELMxUOS0dBGlmeu4a8NuHAkCyY1SM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=S5Yq9OrY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734472765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wOqj5R8dJpQiw2kwNNGcGHkCt3yny+pIXyrUMmerU0s=;
	b=S5Yq9OrY0xKnHvy0aE+W7Qm2tWE4DAUmQlIpXFX9snk82CqyYH1RBvz37XLGQ/ndmVUVER
	BbV1Iz8ygekYa67P9N0SeXxCQj+41NzgWgOsEUXG6z5NQKTR1Fv2LAnlNZIJU+pAz+EkTg
	IgELMxUOS0dBGlmeu4a8NuHAkCyY1SM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04FA013A3C;
	Tue, 17 Dec 2024 21:59:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4EHOLTv0YWfFEwAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 17 Dec 2024 21:59:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: [PATCH v3 4/6] btrfs: update __btrfs_add_delayed_item() to use rb helper
Date: Wed, 18 Dec 2024 08:28:53 +1030
Message-ID: <5c17e8235ca9e64dece4cf2a3c745f793d3eafad.1734472236.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 0CC9021162
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
	RCVD_TLS_ALL(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>

Update __btrfs_add_delayed_item() to use rb_find_add_cached().

Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/delayed-inode.c | 43 ++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 508bdbae29a0..60a6866a6cd9 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -366,40 +366,35 @@ static struct btrfs_delayed_item *__btrfs_lookup_delayed_item(
 	return NULL;
 }
 
+static int btrfs_delayed_item_cmp(const struct rb_node *new,
+				  const struct rb_node *exist)
+{
+	const struct btrfs_delayed_item *new_item =
+		rb_entry(new, struct btrfs_delayed_item, rb_node);
+	const struct btrfs_delayed_item *exist_item =
+		rb_entry(exist, struct btrfs_delayed_item, rb_node);
+
+	if (new_item->index < exist_item->index)
+		return -1;
+	if (new_item->index > exist_item->index)
+		return 1;
+	return 0;
+}
+
 static int __btrfs_add_delayed_item(struct btrfs_delayed_node *delayed_node,
 				    struct btrfs_delayed_item *ins)
 {
-	struct rb_node **p, *node;
-	struct rb_node *parent_node = NULL;
 	struct rb_root_cached *root;
-	struct btrfs_delayed_item *item;
-	bool leftmost = true;
+	struct rb_node *exist;
 
 	if (ins->type == BTRFS_DELAYED_INSERTION_ITEM)
 		root = &delayed_node->ins_root;
 	else
 		root = &delayed_node->del_root;
 
-	p = &root->rb_root.rb_node;
-	node = &ins->rb_node;
-
-	while (*p) {
-		parent_node = *p;
-		item = rb_entry(parent_node, struct btrfs_delayed_item,
-				 rb_node);
-
-		if (item->index < ins->index) {
-			p = &(*p)->rb_right;
-			leftmost = false;
-		} else if (item->index > ins->index) {
-			p = &(*p)->rb_left;
-		} else {
-			return -EEXIST;
-		}
-	}
-
-	rb_link_node(node, parent_node, p);
-	rb_insert_color_cached(node, root, leftmost);
+	exist = rb_find_add_cached(&ins->rb_node, root, btrfs_delayed_item_cmp);
+	if (exist)
+		return -EEXIST;
 
 	if (ins->type == BTRFS_DELAYED_INSERTION_ITEM &&
 	    ins->index >= delayed_node->index_cnt)
-- 
2.47.1


