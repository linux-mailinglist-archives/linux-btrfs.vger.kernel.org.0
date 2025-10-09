Return-Path: <linux-btrfs+bounces-17588-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E948BC8D4F
	for <lists+linux-btrfs@lfdr.de>; Thu, 09 Oct 2025 13:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C951D1A611C9
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Oct 2025 11:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91142DFF12;
	Thu,  9 Oct 2025 11:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="oH/GaxJb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (unknown [62.3.69.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991861F3FE2
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.3.69.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009647; cv=none; b=lTanmFVzbuRD9kdbH5qXwcaTmW6w4SaONkRYKSDpE7hGOxbv95u1to/0oX/VX4uS/916OMaxCdEam2hYtejzaiIzPiWu+frIsSOLZMu1jxAhDjt6/z3ypay5j8ueDs8g4gksfEwo7TZvW9+cIC8PXfAJDleAqz7nN9iAVigxv9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009647; c=relaxed/simple;
	bh=hH3rXcUc15/4bbE8V5NLF4JQQqOVWYA8/9C9lYMvKZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=YYWQOhrSsCJLCFr8OOWR92OOdsbSRp5/+4AFm6LU0E/ToYp+M+/9qpkQee1biHfP9IjEnFH7JAljuM+gwIJglxSxDau4FizQE9aXPQvQgq8sEd7dIPeNVoTnXtV3ijeRnqG2oNmjkKgVg2x1igPA4ahFxBsugpz8i5R+k6TwXMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=fail smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=oH/GaxJb; arc=none smtp.client-ip=62.3.69.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 6B1302C5651;
	Thu,  9 Oct 2025 12:28:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1760009288;
	bh=8px3gnevfYETj9bqjXMmGShYx8bSq8vGmab5rhmEnSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oH/GaxJbeKjUMWLKQPGJriTOMEVZZ3/uMZriO6b+3JjCp6QSjAtraYmjVTaUdn6fF
	 0RvqchaEbddZtieiB3s12uYET3GlZALpc7zAdpzWjMNQL2YjhmCSwEqXbfMXM0reXf
	 DtdILjdH287CvglNNU0XkPpZwLW6oFvV0yZwjE5A=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v3 04/17] btrfs: remove remapped block groups from the free-space tree
Date: Thu,  9 Oct 2025 12:27:59 +0100
Message-ID: <20251009112814.13942-5-mark@harmstone.com>
In-Reply-To: <20251009112814.13942-1-mark@harmstone.com>
References: <20251009112814.13942-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

No new allocations can be done from block groups that have the REMAPPED flag
set, so there's no value in their having entries in the free-space tree.

Prevent a search through the free-space tree being scheduled for such a
block group, and prevent discard being run for a fully-remapped block
group.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/block-group.c | 21 ++++++++++++++++-----
 fs/btrfs/discard.c     |  9 +++++++++
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index cd51f50a7c8b..19a129c54200 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -933,6 +933,13 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, bool wait)
 	if (btrfs_is_zoned(fs_info))
 		return 0;
 
+	/*
+	 * No allocations can be done from remapped block groups, so they have
+	 * no entries in the free-space tree.
+	 */
+	if (cache->flags & BTRFS_BLOCK_GROUP_REMAPPED)
+		return 0;
+
 	caching_ctl = kzalloc(sizeof(*caching_ctl), GFP_NOFS);
 	if (!caching_ctl)
 		return -ENOMEM;
@@ -1248,9 +1255,11 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	 * another task to attempt to create another block group with the same
 	 * item key (and failing with -EEXIST and a transaction abort).
 	 */
-	ret = btrfs_remove_block_group_free_space(trans, block_group);
-	if (ret)
-		goto out;
+	if (!(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)) {
+		ret = btrfs_remove_block_group_free_space(trans, block_group);
+		if (ret)
+			goto out;
+	}
 
 	ret = remove_block_group_item(trans, path, block_group);
 	if (ret < 0)
@@ -2472,10 +2481,12 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	if (btrfs_chunk_writeable(info, cache->start)) {
 		if (cache->used == 0) {
 			ASSERT(list_empty(&cache->bg_list));
-			if (btrfs_test_opt(info, DISCARD_ASYNC))
+			if (btrfs_test_opt(info, DISCARD_ASYNC) &&
+			    !(cache->flags & BTRFS_BLOCK_GROUP_REMAPPED)) {
 				btrfs_discard_queue_work(&info->discard_ctl, cache);
-			else
+			} else {
 				btrfs_mark_bg_unused(cache);
+			}
 		}
 	} else {
 		inc_block_group_ro(cache, 1);
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 89fe85778115..1015a4d37fb2 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -698,6 +698,15 @@ void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info)
 	/* We enabled async discard, so punt all to the queue */
 	list_for_each_entry_safe(block_group, next, &fs_info->unused_bgs,
 				 bg_list) {
+		/* Fully remapped BGs have nothing to discard */
+		spin_lock(&block_group->lock);
+		if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
+		    !btrfs_is_block_group_used(block_group)) {
+			spin_unlock(&block_group->lock);
+			continue;
+		}
+		spin_unlock(&block_group->lock);
+
 		list_del_init(&block_group->bg_list);
 		btrfs_discard_queue_work(&fs_info->discard_ctl, block_group);
 		/*
-- 
2.49.1


