Return-Path: <linux-btrfs+bounces-14013-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED43AB6C57
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 15:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098F83BE157
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 13:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B0427A450;
	Wed, 14 May 2025 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cfCWt+80";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cfCWt+80"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DB4270ED7
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747228383; cv=none; b=JcpSLzkGNElYnZdq+2FD7zlGqTL4vhnrcn96cR1fX3aAgtI1lnAllLokZr94bPoFvVAou5EtFZxEu0ISQXc28+3gCfz0jhPBhgzjMTPfwogXjUvSDVZ7K//9bMNPNWmePw/V6TurJtUeAlJ3pEHUMvKu6j7ERDyDwl9d38pvBZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747228383; c=relaxed/simple;
	bh=cgk3lI5BViik4USH1dElYdk72LLIyJvWKj0L8/q/APA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lc7RVFKBpG9VJ1TbcvsBEDuxJMi0Z6f1x1W2Yh3BmMp78tPYvvsTH+vu2Kj6YJBDl6asaAdaGqHk7KsLJmsf/i3KsyHixv9r+1UDy6/PFcNItqNJSs7QoeFafEjPDQ91peQaVcII4tzvkYJMrOhSqPLq68OIT+1DLufrvM7E81k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cfCWt+80; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cfCWt+80; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C9421F393;
	Wed, 14 May 2025 13:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747228378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QrC8swdncZjTduKb31A91FhAA5yb6QHNpeU4SC85X3k=;
	b=cfCWt+80uMrF/JVNVn8ary7/x/5nPGv+gKuQOpMyp0ew91bi2ThkTvbOLMIsvuHJM0KJGg
	4Rwi+cojSx6orceZGYv/9ZD27cgqd5BZnsH11pGnHqPj49+DyVIcaGGBB+BWOQ6J/rbxyp
	g3bo/XPYhBr5D3idDqdtcIpLXTkbFpY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=cfCWt+80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747228378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QrC8swdncZjTduKb31A91FhAA5yb6QHNpeU4SC85X3k=;
	b=cfCWt+80uMrF/JVNVn8ary7/x/5nPGv+gKuQOpMyp0ew91bi2ThkTvbOLMIsvuHJM0KJGg
	4Rwi+cojSx6orceZGYv/9ZD27cgqd5BZnsH11pGnHqPj49+DyVIcaGGBB+BWOQ6J/rbxyp
	g3bo/XPYhBr5D3idDqdtcIpLXTkbFpY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43946137E8;
	Wed, 14 May 2025 13:12:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7/XND9qWJGjbdwAAD6G6ig
	(envelope-from <neelx@suse.com>); Wed, 14 May 2025 13:12:58 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: btrfs_backref_link_edge() cleanup
Date: Wed, 14 May 2025 15:12:39 +0200
Message-ID: <20250514131240.3343747-1-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5C9421F393
X-Spam-Flag: NO
X-Spam-Score: -3.01
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action

This function is always called with the LINK_LOWER argument. Thus we can
simplify it and remove the LINK_LOWER and LINK_UPPER macros.

The last call with LINK_UPPER was removed with commit
0097422c0dfe0a ("btrfs: remove clone_backref_node() from relocation")

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 fs/btrfs/backref.c | 16 ++++++----------
 fs/btrfs/backref.h |  7 -------
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index ed497f5f8d1bb..d011c64243c0c 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -3161,18 +3161,14 @@ void btrfs_backref_release_cache(struct btrfs_backref_cache *cache)
 	ASSERT(!cache->nr_edges);
 }
 
-void btrfs_backref_link_edge(struct btrfs_backref_edge *edge,
-			     struct btrfs_backref_node *lower,
-			     struct btrfs_backref_node *upper,
-			     int link_which)
+static void btrfs_backref_link_edge(struct btrfs_backref_edge *edge,
+				    struct btrfs_backref_node *lower,
+				    struct btrfs_backref_node *upper)
 {
 	ASSERT(upper && lower && upper->level == lower->level + 1);
 	edge->node[LOWER] = lower;
 	edge->node[UPPER] = upper;
-	if (link_which & LINK_LOWER)
-		list_add_tail(&edge->list[LOWER], &lower->upper);
-	if (link_which & LINK_UPPER)
-		list_add_tail(&edge->list[UPPER], &upper->lower);
+	list_add_tail(&edge->list[LOWER], &lower->upper);
 }
 /*
  * Handle direct tree backref
@@ -3242,7 +3238,7 @@ static int handle_direct_tree_backref(struct btrfs_backref_cache *cache,
 		ASSERT(upper->checked);
 		INIT_LIST_HEAD(&edge->list[UPPER]);
 	}
-	btrfs_backref_link_edge(edge, cur, upper, LINK_LOWER);
+	btrfs_backref_link_edge(edge, cur, upper);
 	return 0;
 }
 
@@ -3412,7 +3408,7 @@ static int handle_indirect_tree_backref(struct btrfs_trans_handle *trans,
 			if (!upper->owner)
 				upper->owner = btrfs_header_owner(eb);
 		}
-		btrfs_backref_link_edge(edge, lower, upper, LINK_LOWER);
+		btrfs_backref_link_edge(edge, lower, upper);
 
 		if (rb_node) {
 			btrfs_put_root(root);
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 953637115956b..507cfb35a23cd 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -423,13 +423,6 @@ struct btrfs_backref_node *btrfs_backref_alloc_node(
 struct btrfs_backref_edge *btrfs_backref_alloc_edge(
 		struct btrfs_backref_cache *cache);
 
-#define		LINK_LOWER	(1U << 0)
-#define		LINK_UPPER	(1U << 1)
-
-void btrfs_backref_link_edge(struct btrfs_backref_edge *edge,
-			     struct btrfs_backref_node *lower,
-			     struct btrfs_backref_node *upper,
-			     int link_which);
 void btrfs_backref_free_node(struct btrfs_backref_cache *cache,
 			     struct btrfs_backref_node *node);
 void btrfs_backref_free_edge(struct btrfs_backref_cache *cache,
-- 
2.47.2


