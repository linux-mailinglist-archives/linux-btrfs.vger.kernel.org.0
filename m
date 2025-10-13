Return-Path: <linux-btrfs+bounces-17724-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAD2BD58A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 19:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B3218A5D25
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 17:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9895E3090FF;
	Mon, 13 Oct 2025 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tk1QhKLP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98693081B1
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377101; cv=none; b=VV1nyUEozXX62+ApQuVcjmBntDSxjkixou9yyFuKzGwssP+5Km9V3hFTT4ornEch0nH1n4fr1HoKz8AesfAY/fppXANM1+WizJMamAM3+UqidWfKlXdn+Bg1FosSX4ZvtBGWeuCEp5MAnWhErwK47dQ0VRM14+nNXyzuxPgmjew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377101; c=relaxed/simple;
	bh=pnU1yi2UbC2WAz74kVVfdjmfBaXOgP5yewy7acmwIts=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b91Z4DY9Q2ZaagokkZSEuSRJLXaqhTIOydM+S3kEeKRDqvSwMSxDNmuhEmXgmvHpcJ1tqd0awcAeJ6Ou+XRuMcXcQfME7+/uNET8FcYfzZGf9i57LkRkwY9nXmgeYgq6EIzQuc595b6Yf8VwSm+lai2p6H0SsiMpLl0IDUihHSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tk1QhKLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B60C4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377101;
	bh=pnU1yi2UbC2WAz74kVVfdjmfBaXOgP5yewy7acmwIts=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tk1QhKLPgdyLL5ahRKrQm9imjZXHTDrnIavzuVqOkopfimp5YBwWhaAzIeEK43mge
	 KHwZ0xS6Dy0iwe4KlmxaibgmlLIFTXftMxWCHNikBWWOqo/IVblJzAD+cYOIO+utkB
	 /0mYqiF5N8WRMrpfz5wLRopKYoc2QIibL3P9JfIDvBgPTIajdbtV1JmvptvSu4MS9s
	 VAva9E0aOs9lniu77aZJlJhuXzHU5IJ7OD76/UyiI36gzbYhJanGS6rVeCWqdPpbgV
	 wk2s1PRW8rbamm8FBfLSKz50nDetZoj5JPowXwi5kQfHOMQAdgk02LFuAdlqek31qu
	 tzzRu9O2T37Sg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 07/16] btrfs: remove fs_info argument from btrfs_dump_space_info()
Date: Mon, 13 Oct 2025 18:38:02 +0100
Message-ID: <2135dea473f2b96a4af88d3b7ed5d242d81e795f.1760376569.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1760376569.git.fdmanana@suse.com>
References: <cover.1760376569.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We don't need it since we can grab fs_info from the given space_info.
So remove the fs_info argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c |  8 ++++----
 fs/btrfs/extent-tree.c |  3 +--
 fs/btrfs/space-info.c  | 18 +++++++++---------
 fs/btrfs/space-info.h  |  3 +--
 4 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 0a72056fd065..6220ecba4f43 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1424,7 +1424,7 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, bool force)
 	if (ret == -ENOSPC && btrfs_test_opt(cache->fs_info, ENOSPC_DEBUG)) {
 		btrfs_info(cache->fs_info,
 			"unable to make block group %llu ro", cache->start);
-		btrfs_dump_space_info(cache->fs_info, cache->space_info, 0, false);
+		btrfs_dump_space_info(cache->space_info, 0, false);
 	}
 	return ret;
 }
@@ -4314,7 +4314,7 @@ static void reserve_chunk_space(struct btrfs_trans_handle *trans,
 	if (left < bytes && btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
 		btrfs_info(fs_info, "left=%llu, need=%llu, flags=%llu",
 			   left, bytes, type);
-		btrfs_dump_space_info(fs_info, info, 0, false);
+		btrfs_dump_space_info(info, 0, false);
 	}
 
 	if (left < bytes) {
@@ -4459,7 +4459,7 @@ static void check_removing_space_info(struct btrfs_space_info *space_info)
 	 * indicates a real bug if this happens.
 	 */
 	if (WARN_ON(space_info->bytes_pinned > 0 || space_info->bytes_may_use > 0))
-		btrfs_dump_space_info(info, space_info, 0, false);
+		btrfs_dump_space_info(space_info, 0, false);
 
 	/*
 	 * If there was a failure to cleanup a log tree, very likely due to an
@@ -4470,7 +4470,7 @@ static void check_removing_space_info(struct btrfs_space_info *space_info)
 	if (!(space_info->flags & BTRFS_BLOCK_GROUP_METADATA) ||
 	    !BTRFS_FS_LOG_CLEANUP_ERROR(info)) {
 		if (WARN_ON(space_info->bytes_reserved > 0))
-			btrfs_dump_space_info(info, space_info, 0, false);
+			btrfs_dump_space_info(space_info, 0, false);
 	}
 
 	WARN_ON(space_info->reclaim_size > 0);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index dc4ca98c3780..d1e75da97f58 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4735,8 +4735,7 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 	"allocation failed flags %llu, wanted %llu tree-log %d, relocation: %d",
 				  flags, num_bytes, for_treelog, for_data_reloc);
 			if (sinfo)
-				btrfs_dump_space_info(fs_info, sinfo,
-						      num_bytes, 1);
+				btrfs_dump_space_info(sinfo, num_bytes, 1);
 		}
 	}
 
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index c473160d6e36..55ecb6eac242 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -591,9 +591,9 @@ static void dump_global_block_rsv(struct btrfs_fs_info *fs_info)
 	DUMP_BLOCK_RSV(fs_info, delayed_refs_rsv);
 }
 
-static void __btrfs_dump_space_info(const struct btrfs_fs_info *fs_info,
-				    const struct btrfs_space_info *info)
+static void __btrfs_dump_space_info(const struct btrfs_space_info *info)
 {
+	const struct btrfs_fs_info *fs_info = info->fs_info;
 	const char *flag_str = space_info_flag_to_str(info);
 	lockdep_assert_held(&info->lock);
 
@@ -610,16 +610,16 @@ static void __btrfs_dump_space_info(const struct btrfs_fs_info *fs_info,
 		info->bytes_readonly, info->bytes_zone_unusable);
 }
 
-void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
-			   struct btrfs_space_info *info, u64 bytes,
+void btrfs_dump_space_info(struct btrfs_space_info *info, u64 bytes,
 			   bool dump_block_groups)
 {
+	struct btrfs_fs_info *fs_info = info->fs_info;
 	struct btrfs_block_group *cache;
 	u64 total_avail = 0;
 	int index = 0;
 
 	spin_lock(&info->lock);
-	__btrfs_dump_space_info(fs_info, info);
+	__btrfs_dump_space_info(info);
 	dump_global_block_rsv(fs_info);
 	spin_unlock(&info->lock);
 
@@ -1089,7 +1089,7 @@ static bool maybe_fail_all_tickets(struct btrfs_space_info *space_info)
 
 	if (btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
 		btrfs_info(fs_info, "cannot satisfy tickets, dumping space info");
-		__btrfs_dump_space_info(fs_info, space_info);
+		__btrfs_dump_space_info(space_info);
 	}
 
 	while (!list_empty(&space_info->tickets) &&
@@ -1882,7 +1882,7 @@ int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 					      space_info->flags, orig_bytes, 1);
 
 		if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
-			btrfs_dump_space_info(fs_info, space_info, orig_bytes, false);
+			btrfs_dump_space_info(space_info, orig_bytes, false);
 	}
 	return ret;
 }
@@ -1913,7 +1913,7 @@ int btrfs_reserve_data_bytes(struct btrfs_space_info *space_info, u64 bytes,
 		trace_btrfs_space_reservation(fs_info, "space_info:enospc",
 					      space_info->flags, bytes, 1);
 		if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
-			btrfs_dump_space_info(fs_info, space_info, bytes, false);
+			btrfs_dump_space_info(space_info, bytes, false);
 	}
 	return ret;
 }
@@ -1926,7 +1926,7 @@ __cold void btrfs_dump_space_info_for_trans_abort(struct btrfs_fs_info *fs_info)
 	btrfs_info(fs_info, "dumping space info:");
 	list_for_each_entry(space_info, &fs_info->space_info, list) {
 		spin_lock(&space_info->lock);
-		__btrfs_dump_space_info(fs_info, space_info);
+		__btrfs_dump_space_info(space_info);
 		spin_unlock(&space_info->lock);
 	}
 	dump_global_block_rsv(fs_info);
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 737e874a8c34..a88cf71b3d3a 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -276,8 +276,7 @@ struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
 u64 __pure btrfs_space_info_used(const struct btrfs_space_info *s_info,
 			  bool may_use_included);
 void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
-void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
-			   struct btrfs_space_info *info, u64 bytes,
+void btrfs_dump_space_info(struct btrfs_space_info *info, u64 bytes,
 			   bool dump_block_groups);
 int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 				 struct btrfs_space_info *space_info,
-- 
2.47.2


