Return-Path: <linux-btrfs+bounces-12649-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E566CA74C7A
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 15:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A31A16B8A8
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 14:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E527C1C2443;
	Fri, 28 Mar 2025 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QND5upp0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F171BE86E
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743171851; cv=none; b=B/IVmwRE+GXmzUy4rQMTUvhyxUbR066pKm1SX+Pn1H9Lu/1th57F943T3MG7BgqcnCeKwSTz4y0QyDVTUS74zGPS7BOTtwzCIiMqVYpscv/XvuhqyBW9E+6mT5zA+Mq51MfUnO29dVhrdyCUFp/7TW2pMsqe0CMuroN2V+1TO5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743171851; c=relaxed/simple;
	bh=53dGBWT4MXLOQ6tfkNr7SS6HiwxJfe/+b/mKJNy9zxU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ouQFYl/XflcjtamPogRaMkg11Z6OhGIdetcJdL5LGJNMJWDRloXG0FIFKD3NOdYO4WUgjBlQ/K+JOjFrvx8qpMZObd78kKTQ6EwkYyXn5Fg2/Fak5pP81wuvkOKrlufL3bl652GmyJeVuTcs2fXeLd34P8qve+vbEQ2YJB4fhMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QND5upp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117E5C4CEEA
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 14:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743171850;
	bh=53dGBWT4MXLOQ6tfkNr7SS6HiwxJfe/+b/mKJNy9zxU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QND5upp0R9AzqOmpE8/GLBqMCxuHEUl/zzsOBYYTuzVNCpePJe4f5YR+rRgxYNY29
	 8X/jN/rNzU3SwPXr7zOAjQMcpWSgwqo0KRY5KTPrjo84jFaGH3jKuWurNSmDrxAy3I
	 w9IHo+qqtaO/2wnp2U8AqYLTx9bsKzWpFbTkztvQ6MCb/Yn4mqtZ96iMpJFM2R4J9B
	 x6s+YHhTPxCsTLvbpY0N+VhA4v+ofeNeDsST8WBluNt8UWmg//eirdydjEfoTg9I01
	 15I3TterJ9S/5/RFwPordeqNK86zCPlVMq/vDJuSxawb5X/+cOEU12ZbGc+fGgWVXC
	 AUpEhBUY8mBag==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: remove EXTENT_UPTODATE io tree flag
Date: Fri, 28 Mar 2025 14:24:04 +0000
Message-Id: <698231f2fb51a7c578f575ef4c1539d7b340acdd.1743166248.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743166248.git.fdmanana@suse.com>
References: <cover.1743166248.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The EXTENT_UPTODATE io tree flag is now used only to mark ranges in the
fs_info->excluded_extents as used by super blocks and not available for
extent allocation (to prevent adding those ranges as free space in the
in memory space caches). As we can use any flag for that purpose, and
we are using EXTENT_DIRTY for the pinned extents io tree for example,
remove the EXTENT_UPTODATE flag and use instead EXTENT_DIRTY for the
excluded extents io tree.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c           | 8 ++++----
 fs/btrfs/extent-io-tree.h        | 1 -
 fs/btrfs/tests/extent-io-tests.c | 1 -
 include/trace/events/btrfs.h     | 1 -
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 8a02375f27e8..a38578c60f34 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -527,7 +527,7 @@ int btrfs_add_new_free_space(struct btrfs_block_group *block_group, u64 start,
 	while (start < end) {
 		if (!find_first_extent_bit(&info->excluded_extents, start,
 					   &extent_start, &extent_end,
-					   EXTENT_UPTODATE, NULL))
+					   EXTENT_DIRTY, NULL))
 			break;
 
 		if (extent_start <= start) {
@@ -834,7 +834,7 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
 static inline void btrfs_free_excluded_extents(const struct btrfs_block_group *bg)
 {
 	clear_extent_bits(&bg->fs_info->excluded_extents, bg->start,
-			  bg->start + bg->length - 1, EXTENT_UPTODATE);
+			  bg->start + bg->length - 1, EXTENT_DIRTY);
 }
 
 static noinline void caching_thread(struct btrfs_work *work)
@@ -2219,7 +2219,7 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 		cache->bytes_super += stripe_len;
 		ret = set_extent_bit(&fs_info->excluded_extents, cache->start,
 				     cache->start + stripe_len - 1,
-				     EXTENT_UPTODATE, NULL);
+				     EXTENT_DIRTY, NULL);
 		if (ret)
 			return ret;
 	}
@@ -2247,7 +2247,7 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 			cache->bytes_super += len;
 			ret = set_extent_bit(&fs_info->excluded_extents, logical[nr],
 					     logical[nr] + len - 1,
-					     EXTENT_UPTODATE, NULL);
+					     EXTENT_DIRTY, NULL);
 			if (ret) {
 				kfree(logical);
 				return ret;
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index ac1a59bd2f95..6dfe8b097d93 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -17,7 +17,6 @@ struct btrfs_inode;
 /* Bits for the extent state */
 enum {
 	ENUM_BIT(EXTENT_DIRTY),
-	ENUM_BIT(EXTENT_UPTODATE),
 	ENUM_BIT(EXTENT_LOCKED),
 	ENUM_BIT(EXTENT_DIO_LOCKED),
 	ENUM_BIT(EXTENT_NEW),
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 74aca7180a5a..8773758a8cc7 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -74,7 +74,6 @@ static void extent_flag_to_str(const struct extent_state *state, char *dest)
 
 	dest[0] = 0;
 	PRINT_ONE_FLAG(state, dest, cur, DIRTY);
-	PRINT_ONE_FLAG(state, dest, cur, UPTODATE);
 	PRINT_ONE_FLAG(state, dest, cur, LOCKED);
 	PRINT_ONE_FLAG(state, dest, cur, NEW);
 	PRINT_ONE_FLAG(state, dest, cur, DELALLOC);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 549ab3b41961..60f279181ae2 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -143,7 +143,6 @@ FLUSH_STATES
 
 #define EXTENT_FLAGS						\
 	{ EXTENT_DIRTY,			"DIRTY"},		\
-	{ EXTENT_UPTODATE,		"UPTODATE"},		\
 	{ EXTENT_LOCKED,		"LOCKED"},		\
 	{ EXTENT_NEW,			"NEW"},			\
 	{ EXTENT_DELALLOC,		"DELALLOC"},		\
-- 
2.45.2


