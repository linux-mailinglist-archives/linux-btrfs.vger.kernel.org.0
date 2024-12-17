Return-Path: <linux-btrfs+bounces-10516-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AA19F593F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 23:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3747C1615A9
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 21:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737061FA276;
	Tue, 17 Dec 2024 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KMz3dvo7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KMz3dvo7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774761E0DF5
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734472771; cv=none; b=jQZiP/dF1IgHuwzCCoaNrcjfwnK8Pz8PYThUwb5aCLP5tCe6sCs849Xj0de9tMY2KzbrgdDjlYk0+2dMQh5PC5NG7F7dBvUuY70FYQqCj8AzB+6HTRvtG/1fYJBMqqOaY9ZzcGzZK4Vg7trFnAYmXfBz2MnfczwvRZBw7Z0FGew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734472771; c=relaxed/simple;
	bh=pPU0fIKnbjKcVi77AqbGY9Fm9OVJkzUzYtBAaJUoyjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdxCRIzZBh62CyFr0uSGm//MCvSfRGVD5ZpuVBhK0cDT0hmiF7t6hg+/5F4xq7DvZmnTVGcmcVyAA0lrz+R23nxRAu8dkBVgX/2004SXiTjPoXM2rjZfiv3GUnfoJgRblINwQJ5Kl3h66b+UBVYD5wHqTRRuGis18lDAf8I9t8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KMz3dvo7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KMz3dvo7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0662E1F396;
	Tue, 17 Dec 2024 21:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734472762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OO8B4D4PM/he5xDqrD0A4JdBrurC2NtPXZ2pUzmd3vM=;
	b=KMz3dvo7lW9cvFK/fr8Fj42yvaVvobJQ/rz5XJo1RWKuZvwfRKGmMbA+/cDGXL53DUR2Jh
	zfpPBL9l9/P6gVEWMXCLym7r7Ot3N8OOYuSe/g2Y6nqRlNKExHdemH+zH5O+O3uN5MEhgx
	DfuiA+MpQbSWQsnoUAOck1Mm8R7RS80=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734472762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OO8B4D4PM/he5xDqrD0A4JdBrurC2NtPXZ2pUzmd3vM=;
	b=KMz3dvo7lW9cvFK/fr8Fj42yvaVvobJQ/rz5XJo1RWKuZvwfRKGmMbA+/cDGXL53DUR2Jh
	zfpPBL9l9/P6gVEWMXCLym7r7Ot3N8OOYuSe/g2Y6nqRlNKExHdemH+zH5O+O3uN5MEhgx
	DfuiA+MpQbSWQsnoUAOck1Mm8R7RS80=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B679313A3C;
	Tue, 17 Dec 2024 21:59:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OLiNHTj0YWfFEwAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 17 Dec 2024 21:59:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v3 2/6] btrfs: update btrfs_add_block_group_cache() to use rb helper
Date: Wed, 18 Dec 2024 08:28:51 +1030
Message-ID: <0f71809f99c7930252ae424ce92a9ff91b8a05b8.1734472236.git.wqu@suse.com>
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
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,toxicpanda.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>

Update fs/btrfs/block-group.c to use rb_find_add_cached().

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c | 46 ++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5be029734cfa..39881d66cfa0 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -173,43 +173,41 @@ void btrfs_put_block_group(struct btrfs_block_group *cache)
 	}
 }
 
+static int btrfs_bg_start_cmp(const struct rb_node *new,
+			      const struct rb_node *exist)
+{
+	const struct btrfs_block_group *new_bg =
+		rb_entry(new, struct btrfs_block_group, cache_node);
+	const struct btrfs_block_group *exist_bg =
+		rb_entry(exist, struct btrfs_block_group, cache_node);
+
+	if (new_bg->start < exist_bg->start)
+		return -1;
+	if (new_bg->start > exist_bg->start)
+		return 1;
+	return 0;
+}
+
 /*
  * This adds the block group to the fs_info rb tree for the block group cache
  */
 static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
 				       struct btrfs_block_group *block_group)
 {
-	struct rb_node **p;
-	struct rb_node *parent = NULL;
-	struct btrfs_block_group *cache;
-	bool leftmost = true;
+	struct rb_node *exist;
+	int ret = 0;
 
 	ASSERT(block_group->length != 0);
 
 	write_lock(&info->block_group_cache_lock);
-	p = &info->block_group_cache_tree.rb_root.rb_node;
-
-	while (*p) {
-		parent = *p;
-		cache = rb_entry(parent, struct btrfs_block_group, cache_node);
-		if (block_group->start < cache->start) {
-			p = &(*p)->rb_left;
-		} else if (block_group->start > cache->start) {
-			p = &(*p)->rb_right;
-			leftmost = false;
-		} else {
-			write_unlock(&info->block_group_cache_lock);
-			return -EEXIST;
-		}
-	}
-
-	rb_link_node(&block_group->cache_node, parent, p);
-	rb_insert_color_cached(&block_group->cache_node,
-			       &info->block_group_cache_tree, leftmost);
 
+	exist = rb_find_add_cached(&block_group->cache_node,
+			&info->block_group_cache_tree, btrfs_bg_start_cmp);
+	if (exist)
+		ret = -EEXIST;
 	write_unlock(&info->block_group_cache_lock);
 
-	return 0;
+	return ret;
 }
 
 /*
-- 
2.47.1


