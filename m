Return-Path: <linux-btrfs+bounces-14759-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E115BADE300
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 07:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952533B7579
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 05:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E971F8744;
	Wed, 18 Jun 2025 05:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="H97qKNhI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KRPw/c7C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03121E5702
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 05:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750224259; cv=none; b=MEQAePoh0GceRSG/S+OtiwjwDJ7WJEmGodQehr7yv1LZloglYlh9QLuM7h/SE0GW9iB0+WWD+EGcSU+XlM5XkSX01+cqfAbyKfk7uGcQvSHdgO0mLRpA7xrGSAHHCe9od5RjDopZbH0BQNiw7etWsoanmXnHiGTwOA8Nx7ZKmMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750224259; c=relaxed/simple;
	bh=uH4gedTgaNZCbinuBmj71SnjQ2QL4wrtCHwltSJIvr4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgmke+KsB0TCv6TzXnhAARwVraTYEr9hbj0YQJPz4z97qjOYDBsB8FfhyqeHZUlMxuYxLElbKk7ykSUB1nf798x4J0az9bLWpTjVJdBWWGgZPWrgmMMfTx97g+Oolxh/K5539Kc0ZF7/X7fNrtfSavebjyFtVN0v1LRMXfEIHZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=H97qKNhI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KRPw/c7C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E73C61F7B8
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 05:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750224243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OWKxFEwDQcw7X75SAEkRbM5jOuMU5fjL1bwfNgGtsg=;
	b=H97qKNhI+fSYcorb+OqklstrQUqQHucSj/tgixdTvLl4FkyxKJ7j5WMN7kVLb8g5NvCOb4
	ETPQs+Gp3w79q51Hohuz8fe//tHA9I23aHSb4cGHmZK4TJGLSI4c8RkdgctasB3j0grBkt
	50v9Ew93emjOApgx8xqgWMuOhkU7Xso=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="KRPw/c7C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750224242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OWKxFEwDQcw7X75SAEkRbM5jOuMU5fjL1bwfNgGtsg=;
	b=KRPw/c7Cv1O8zg72FWXwlwjG5tHpWe12eiOjn6yNZkQARDVc7zA/+0PbB+4oFR+0sHKbCu
	kIjzxsoINamGbMcs0s62iaqab0mk0GIeJgo5YXIUH1CT7/9njTrUCfVgJsYGko7hwM0ebr
	MU6QPDERIp7ST+235u0S1RNQKV3FC1s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EC6013A99
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 05:24:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uPt8OHFNUmgbVAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 05:24:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: optimize the block group item load for half converted fs
Date: Wed, 18 Jun 2025 14:53:40 +0930
Message-ID: <feb161d70dea100edb6f50d1004eda697bc0c0b8.1750223785.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750223785.git.wqu@suse.com>
References: <cover.1750223785.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E73C61F7B8
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01
X-Spam-Level: 

[PROBLEM]
If there is an fs which is half converted to block group tree, then the
block group item loading will still go through all the tree blocks in
the old extent tree.

Even if the extent tree may only contain one block group item.

[CAUSE]
We rely on the function find_first_block_group() to find a block group
after certain bytenr.

But there is no stopper on where the search should end, thus it will go
the next slot until there is no more leaves.

Meaning even if we have found the last block group item in the old
extent tree, find_first_block_group() will still search the whole extent
tree.

We had a check after find_first_block_group(), but that's useless as
it's already too late.

[ENHANCEMENT]
Add an extra parameter, @max_bytenr, that if we found a key whose
objectid >= @max_bytenr, then we stop the search immediately.

This will skip the time consuming full tree iteration and make resuming
faster.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/extent-tree.c | 45 ++++++++-----------------------------
 1 file changed, 9 insertions(+), 36 deletions(-)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 46f4eecb760a..fa11803346fa 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -2643,14 +2643,15 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 }
 
 /*
- * Find a block group which starts >= @key->objectid in extent tree.
+ * Find a block group which starts >= @key->objectid and ends < max_bytenr.
  *
  * Return 0 for found
  * Return >0 for not found
  * Return <0 for error
  */
 static int find_first_block_group(struct btrfs_root *root,
-		struct btrfs_path *path, struct btrfs_key *key)
+		struct btrfs_path *path, struct btrfs_key *key,
+		u64 max_bytenr)
 {
 	int ret;
 	struct btrfs_key found_key;
@@ -2676,6 +2677,8 @@ static int find_first_block_group(struct btrfs_root *root,
 		if (found_key.objectid >= key->objectid &&
 		    found_key.type == BTRFS_BLOCK_GROUP_ITEM_KEY)
 			return 0;
+		if (found_key.objectid >= max_bytenr)
+			break;
 		path->slots[0]++;
 	}
 	ret = 1;
@@ -2792,7 +2795,7 @@ static int get_last_converted_bg(struct btrfs_fs_info *fs_info)
 		/* Empty bg tree, all converted, then grab the first bg. */
 		if (btrfs_header_nritems(path.nodes[0]) == 0) {
 			btrfs_release_path(&path);
-			ret = find_first_block_group(extent_root, &path, &key);
+			ret = find_first_block_group(extent_root, &path, &key, (u64)-1);
 			/* We should have at least one bg item in extent tree. */
 			ASSERT(ret == 0);
 
@@ -2861,39 +2864,13 @@ static int read_old_block_groups_from_root(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_path path = {0};
 	struct btrfs_key key = { 0 };
-	struct cache_extent *ce;
-	/* The last block group bytenr in the old root. */
-	u64 last_bg_in_old_root;
 	int ret;
 
-	if (fs_info->last_converted_bg_bytenr != (u64)-1) {
-		/*
-		 * We know the last converted bg in the other tree, load the chunk
-		 * before that last converted as our last bg in the tree.
-		 */
-		ce = search_cache_extent(&fs_info->mapping_tree.cache_tree,
-			         fs_info->last_converted_bg_bytenr);
-		if (!ce || ce->start != fs_info->last_converted_bg_bytenr) {
-			error("no chunk found for bytenr %llu",
-			      fs_info->last_converted_bg_bytenr);
-			return -ENOENT;
-		}
-		ce = prev_cache_extent(ce);
-		/*
-		 * We should have previous unconverted chunk, or we have
-		 * already finished the convert.
-		 */
-		ASSERT(ce);
-
-		last_bg_in_old_root = ce->start;
-	} else {
-		last_bg_in_old_root = (u64)-1;
-	}
-
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 
 	while (true) {
-		ret = find_first_block_group(root, &path, &key);
+		ret = find_first_block_group(root, &path, &key,
+					     fs_info->last_converted_bg_bytenr);
 		if (ret > 0) {
 			ret = 0;
 			goto out;
@@ -2907,10 +2884,6 @@ static int read_old_block_groups_from_root(struct btrfs_fs_info *fs_info,
 		if (ret < 0 && ret != -ENOENT)
 			goto out;
 
-		/* We have reached last bg in the old root, no need to continue */
-		if (key.objectid >= last_bg_in_old_root)
-			break;
-
 		if (key.offset == 0)
 			key.objectid++;
 		else
@@ -2935,7 +2908,7 @@ static int read_block_groups_from_root(struct btrfs_fs_info *fs_info,
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 
 	while (true) {
-		ret = find_first_block_group(root, &path, &key);
+		ret = find_first_block_group(root, &path, &key, (u64)-1);
 		if (ret > 0) {
 			ret = 0;
 			goto out;
-- 
2.49.0


