Return-Path: <linux-btrfs+bounces-18209-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D20C024C2
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C05F541EE4
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3452B29A309;
	Thu, 23 Oct 2025 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYcOAFOm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7561129993D
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235226; cv=none; b=hlg5eozWVpTSW2lgSIT5AAtRPZzzV1Ki7AqEkS3wQyaEe9vfeK8Oht1Rg5Fz743+R/Hw8S3YN5LEzy4+MnbmS874us6jHAL1eSGV+Wo76VNFSwLFuT5nmLUrYvXrizJCkApGs6oK3+HL9upR1zRhdwszEVfuCKXx11LVioy50nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235226; c=relaxed/simple;
	bh=+KBKnpkqd0jIFVArU/5JNQ3kqXaa1c+jP2S/UBfJuU0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYbztbSuQuo0v7ZRkYGx/fD6X/bnEDJFqHF+7SFT1YQZNakR26GC3obj1h1jRai320FeokCjcDgP4T+wNMWjZinVeBCqpe8nclmU0Q6JAzPlAn3zimCsadc6KGoCcqt9BofJFuEEGmqbI4Vz3sgHA+3NBGtJ61zeNIhC52XEMEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYcOAFOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2419C4CEFD
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235226;
	bh=+KBKnpkqd0jIFVArU/5JNQ3kqXaa1c+jP2S/UBfJuU0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WYcOAFOmSGh6/xCl1sRzqguLnawMWka73R2yWnsr+/PQpP5JbZ9sG+QerzXd30xeJ
	 n/MZXVr20r3jb6zKTkPr4BuQZ/gExVp/h3W4NrVSEz1/WLspGjFh18KAowerqYqNpr
	 i2L2Rkw6uUzUzZRq0R8Q7dLdMxK4jarjEI6s2RlHuVxp0FlV53HXWCTjZ92HwieUZk
	 19bvSGwKUM/PvhGt/vsHPqXXdwl/zE5jskMVmlRnjzRZ18nZ8EPFUt4UPU/NE+zf1A
	 Yaqdf6cHmeT4UsE25+bt+irw/B3Zpu+hztc2CKEdRONNWf4JgiyHIiprp8t2/zR3OX
	 fA/wdb3Z0mRtA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 22/28] btrfs: change 'reserved' argument from pin_down_extent() to bool
Date: Thu, 23 Oct 2025 16:59:55 +0100
Message-ID: <08dfad79ac22cd9acc3542cf5a9e591349d8579d.1761234581.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1761234580.git.fdmanana@suse.com>
References: <cover.1761234580.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's used as a boolean, so convert it from int type to bool type.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 21420dc26a50..36963b4a6303 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2592,7 +2592,7 @@ static u64 first_logical_byte(struct btrfs_fs_info *fs_info)
 
 static int pin_down_extent(struct btrfs_trans_handle *trans,
 			   struct btrfs_block_group *bg,
-			   u64 bytenr, u64 num_bytes, int reserved)
+			   u64 bytenr, u64 num_bytes, bool reserved)
 {
 	struct btrfs_space_info *space_info = bg->space_info;
 	const u64 reserved_bytes = (reserved ? num_bytes : 0);
@@ -2618,7 +2618,7 @@ int btrfs_pin_extent(struct btrfs_trans_handle *trans, u64 bytenr, u64 num_bytes
 	cache = btrfs_lookup_block_group(trans->fs_info, bytenr);
 	BUG_ON(!cache); /* Logic error */
 
-	pin_down_extent(trans, cache, bytenr, num_bytes, 1);
+	pin_down_extent(trans, cache, bytenr, num_bytes, true);
 
 	btrfs_put_block_group(cache);
 	return 0;
@@ -2642,7 +2642,7 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	pin_down_extent(trans, cache, eb->start, eb->len, 0);
+	pin_down_extent(trans, cache, eb->start, eb->len, false);
 
 	/* remove us from the free space cache (if we're there at all) */
 	ret = btrfs_remove_free_space(cache, eb->start, eb->len);
@@ -3483,7 +3483,7 @@ int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 	bg = btrfs_lookup_block_group(fs_info, buf->start);
 
 	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
-		pin_down_extent(trans, bg, buf->start, buf->len, 1);
+		pin_down_extent(trans, bg, buf->start, buf->len, true);
 		btrfs_put_block_group(bg);
 		goto out;
 	}
@@ -3507,7 +3507,7 @@ int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 
 	if (test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags)
 		     || btrfs_is_zoned(fs_info)) {
-		pin_down_extent(trans, bg, buf->start, buf->len, 1);
+		pin_down_extent(trans, bg, buf->start, buf->len, true);
 		btrfs_put_block_group(bg);
 		goto out;
 	}
@@ -4775,7 +4775,7 @@ int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans,
 		return -ENOSPC;
 	}
 
-	ret = pin_down_extent(trans, cache, eb->start, eb->len, 1);
+	ret = pin_down_extent(trans, cache, eb->start, eb->len, true);
 	btrfs_put_block_group(cache);
 	return ret;
 }
-- 
2.47.2


