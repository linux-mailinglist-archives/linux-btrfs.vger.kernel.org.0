Return-Path: <linux-btrfs+bounces-10519-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2DD9F5963
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 23:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6861894C2A
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 22:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83761F8699;
	Tue, 17 Dec 2024 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="G4K2V+nP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="G4K2V+nP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB081F9F5D
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734472775; cv=none; b=Rti7+jpqzjvII/RaetvYzar8jNjtcfDzA18K8cev8gxzMLOqz621SHfYh/Yw4Hbt3ySQEM92f6YFN4BTxFHATfDNlF2hqg/OdCbCm4b+YNtzqMDisOj33OESohucuyp499zfMlatmhQnga3mh6QiTDiSQXstNalstmpRcL/2Flg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734472775; c=relaxed/simple;
	bh=PGf4iA/1f/AuiLfW7p5srIhURo/hurXLtym3qyYtCxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LerKv119GLoRpGhv5pIzDRe7cTrb32Ygisdi7d3etXqPyhMKSGbEEidf6Cpow9dAuYc+aN9E5afOPLwcbDipj7hI32iJCyjkH23TzOUC+F1KnGTTxzWwcyU+cc49XR8ZAiK1I5qmCODnyy94yCNDWMhShvy9CZVKpXXlSM2lpX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=G4K2V+nP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=G4K2V+nP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8AA221F399;
	Tue, 17 Dec 2024 21:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734472766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCf58F0ZzIIkHV21UoldPMzI9oA/MNUebolxIF8qWws=;
	b=G4K2V+nPnXK3Tdyh5NVOpu1U91FnVFsFGgHWtqsQcxdBUAdgj4n1GaJIPtadvPJemCO28K
	cLICSE/WnLoI5+zZtbnH3vLjKNYihMlz/0TeqTwq30DE56U2Gon9oW0kZo52I58C/ID+9n
	EhzfS9phygIOV06S4l8o2MIfkjqEtdk=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=G4K2V+nP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734472766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCf58F0ZzIIkHV21UoldPMzI9oA/MNUebolxIF8qWws=;
	b=G4K2V+nPnXK3Tdyh5NVOpu1U91FnVFsFGgHWtqsQcxdBUAdgj4n1GaJIPtadvPJemCO28K
	cLICSE/WnLoI5+zZtbnH3vLjKNYihMlz/0TeqTwq30DE56U2Gon9oW0kZo52I58C/ID+9n
	EhzfS9phygIOV06S4l8o2MIfkjqEtdk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 832B813A3C;
	Tue, 17 Dec 2024 21:59:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sJ3xED30YWfFEwAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 17 Dec 2024 21:59:25 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: [PATCH v3 5/6] btrfs: update btrfs_add_chunk_map() to use rb helpers
Date: Wed, 18 Dec 2024 08:28:54 +1030
Message-ID: <45b2ef8879fe598ea0fd207c52c0ddd87980afac.1734472236.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 8AA221F399
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

Update btrfs_add_chunk_map() to use rb_find_add_cached().

Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d32913c51d69..c8b079ad1dfa 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5514,33 +5514,34 @@ void btrfs_remove_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_ma
 	btrfs_free_chunk_map(map);
 }
 
+static int btrfs_chunk_map_cmp(const struct rb_node *new,
+			       const struct rb_node *exist)
+{
+	const struct btrfs_chunk_map *new_map =
+		rb_entry(new, struct btrfs_chunk_map, rb_node);
+	const struct btrfs_chunk_map *exist_map =
+		rb_entry(exist, struct btrfs_chunk_map, rb_node);
+
+	if (new_map->start == exist_map->start)
+		return 0;
+	if (new_map->start < exist_map->start)
+		return -1;
+	return 1;
+}
+
 EXPORT_FOR_TESTS
 int btrfs_add_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *map)
 {
-	struct rb_node **p;
-	struct rb_node *parent = NULL;
-	bool leftmost = true;
+	struct rb_node *exist;
 
 	write_lock(&fs_info->mapping_tree_lock);
-	p = &fs_info->mapping_tree.rb_root.rb_node;
-	while (*p) {
-		struct btrfs_chunk_map *entry;
+	exist = rb_find_add_cached(&map->rb_node, &fs_info->mapping_tree,
+				   btrfs_chunk_map_cmp);
 
-		parent = *p;
-		entry = rb_entry(parent, struct btrfs_chunk_map, rb_node);
-
-		if (map->start < entry->start) {
-			p = &(*p)->rb_left;
-		} else if (map->start > entry->start) {
-			p = &(*p)->rb_right;
-			leftmost = false;
-		} else {
-			write_unlock(&fs_info->mapping_tree_lock);
-			return -EEXIST;
-		}
+	if (exist) {
+		write_unlock(&fs_info->mapping_tree_lock);
+		return -EEXIST;
 	}
-	rb_link_node(&map->rb_node, parent, p);
-	rb_insert_color_cached(&map->rb_node, &fs_info->mapping_tree, leftmost);
 	chunk_map_device_set_bits(map, CHUNK_ALLOCATED);
 	chunk_map_device_clear_bits(map, CHUNK_TRIMMED);
 	write_unlock(&fs_info->mapping_tree_lock);
-- 
2.47.1


