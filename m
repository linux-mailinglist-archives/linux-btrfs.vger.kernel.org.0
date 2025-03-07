Return-Path: <linux-btrfs+bounces-12094-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DA4A5693F
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 14:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01471762FA
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 13:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AEC21ABA6;
	Fri,  7 Mar 2025 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLbIF1kv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FAE21B1B4
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355077; cv=none; b=dwfb1LogRX25AXeKD6N76n1o7KTEE0Noqiy6OvITiRF+C5a1EiTakzEj5U4UjoQ9qiN5bmtiMnA606sYqBX2widc5Erb8f+FmX46RP1S34nN5X+VaIpp0lfGk8+Sz4ux4HvU4WU6LLDEfUr1bl90QZB1B6sHHO0+RHp40ZAX2ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355077; c=relaxed/simple;
	bh=LoAgfdJOXsIgJ1udVQdQZKtcxY9XkWw1LNBzlFuTMVQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qyrtxN7hbD4qDZ9qJL0CDNaD4XQRGQH8z/lDNpBDRs74QQMhdR2WqLTrTdG1guHYcRI6m+8bNv8SIFmeAFf6Rsb4umwuuVWIo8Vj3X9drfF5/nu/l9S/qqCFhJMFXuvF+C9dCRLLw+C3ZLSpwBm/OuP3yMu8Xvn29a+Ee5XAD90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLbIF1kv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1F9C4CEE5
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 13:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741355077;
	bh=LoAgfdJOXsIgJ1udVQdQZKtcxY9XkWw1LNBzlFuTMVQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GLbIF1kv4f/jYl0oE4aXWTZ/P+/giJ+FQMGCB0IoRcYh9ozrEWaWargl78JeCP94N
	 l8rxcBeNJFCNTw6/ouMaEo0FHh5hCM4UPUQK2M4rQt1vlcA/5KaPrs5qNCIYucz1GM
	 GU0yKDfjXS35E/nExiG9PBmFbJ+C4bLdfuBFEW62IygV6CXA6XDkgcLGdVLe7SuLcl
	 JPi6fhV6IKiNiCq3GJlDdn3ptwR1+z4ORPvuJDdegx5lF7xZoUyrGjXZ1qmUxEv/Hl
	 njiRHNjAjcAC4DDfoE9F2DOaZcqGhWlApdiyzhyVm/0Oda/RDA7zQaxMefhwLiwTPZ
	 AIa7zfX7OeTyA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] btrfs: remove unnecessary fs_info argument from btrfs_add_block_group_cache()
Date: Fri,  7 Mar 2025 13:44:25 +0000
Message-Id: <b27355b20643bcad9744f9985d1f25ceec0e4745.1741354480.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741354476.git.fdmanana@suse.com>
References: <cover.1741354476.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The fs_info can be taken from the given block group, so there is no need
to pass it as an argument. Also rename the local variable from 'info' to
'fs_info' which is more widely used, more clear and to be more consistent.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 64f0268dcf02..4975aa5665ae 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -191,21 +191,21 @@ static int btrfs_bg_start_cmp(const struct rb_node *new,
 /*
  * This adds the block group to the fs_info rb tree for the block group cache
  */
-static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
-				       struct btrfs_block_group *block_group)
+static int btrfs_add_block_group_cache(struct btrfs_block_group *block_group)
 {
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct rb_node *exist;
 	int ret = 0;
 
 	ASSERT(block_group->length != 0);
 
-	write_lock(&info->block_group_cache_lock);
+	write_lock(&fs_info->block_group_cache_lock);
 
 	exist = rb_find_add_cached(&block_group->cache_node,
-			&info->block_group_cache_tree, btrfs_bg_start_cmp);
+			&fs_info->block_group_cache_tree, btrfs_bg_start_cmp);
 	if (exist)
 		ret = -EEXIST;
-	write_unlock(&info->block_group_cache_lock);
+	write_unlock(&fs_info->block_group_cache_lock);
 
 	return ret;
 }
@@ -2438,7 +2438,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 			goto error;
 	}
 
-	ret = btrfs_add_block_group_cache(info, cache);
+	ret = btrfs_add_block_group_cache(cache);
 	if (ret) {
 		btrfs_remove_free_space_cache(cache);
 		goto error;
@@ -2487,7 +2487,7 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
 		bg->cached = BTRFS_CACHE_FINISHED;
 		bg->used = map->chunk_len;
 		bg->flags = map->type;
-		ret = btrfs_add_block_group_cache(fs_info, bg);
+		ret = btrfs_add_block_group_cache(bg);
 		/*
 		 * We may have some valid block group cache added already, in
 		 * that case we skip to the next one.
@@ -2914,7 +2914,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	cache->space_info = btrfs_find_space_info(fs_info, cache->flags);
 	ASSERT(cache->space_info);
 
-	ret = btrfs_add_block_group_cache(fs_info, cache);
+	ret = btrfs_add_block_group_cache(cache);
 	if (ret) {
 		btrfs_remove_free_space_cache(cache);
 		btrfs_put_block_group(cache);
-- 
2.45.2


