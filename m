Return-Path: <linux-btrfs+bounces-18189-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 26100C02471
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 541E84F6DD7
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C396B2727E7;
	Thu, 23 Oct 2025 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvhmyncb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0471D26ED34
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235209; cv=none; b=DBwWD5iEh6oQyZtu55b3XKXXaYvqNUpOr5/9XwOkEuraJDCK/Yf3kAiaNQcFCttJae9Bs4Kf5f6EXp8lmuYPFo4pnNARNroghV2Ew1gRIjHnfL3th9iAxcBI8c04m/X8Gocj0RnPG8fqtk5cx63N3Phs2k1LGUjnMFhGrNuEKFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235209; c=relaxed/simple;
	bh=n1O3XPiuRogY36stlXzb42cRkQoaDd+UXtC4YlPkiyI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2CapWSJ/HwQQ7xbYIkzUT0E+835BBrH9hgN6I6SR2iiSTW7XbUs5Uu4CqyJcANeqP825MoE7AVhnBGbw4XvYge0L24hM6o6vZEgHZ7JhB1q1FUtQuqiIqZiTtD/GocrFdyFf/mgnW5XgvbsK+HdWZy3pcl9y9YPyeiwo0IELwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvhmyncb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B9BC4CEFD
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235208;
	bh=n1O3XPiuRogY36stlXzb42cRkQoaDd+UXtC4YlPkiyI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mvhmyncb5m23sT2pqzP/L5OdyC+Fqh7x5o5BrbiNMZ6RNcXTpjlyO6ep+TiE/QAf9
	 c0aoSogtGgV5GijGZgqXqetM6krJ7UCUOTLDn9ZZYg68OJcKn88kjeUtmkIh1uzdCG
	 LjXNptcc8G/jq2wwfHIC9RkA76Csy3zFfbkONBzgTuE+MxJhjuXH1NpFx9yEAsikg3
	 BnutI4Xk5eTy2tJQwH3ngTCw98Xm2SrFkBjPfaKnUajJ37goZS6CGnApXfG5Hp5urM
	 Bgy/vp6JBoJCPn4BK/UiZK3rkwMruuQBhKUybAf8w0dTFaPfWCZIqXKXChRq+lZ02l
	 Q5g5sehd5E28Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 03/28] btrfs: make btrfs_can_overcommit() return bool instead of int
Date: Thu, 23 Oct 2025 16:59:36 +0100
Message-ID: <ebde92d44e338a12c2a51ab57b9bc3fb471755fe.1761234581.git.fdmanana@suse.com>
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

It's a boolean function, so switch its return type to bool.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 10 ++++------
 fs/btrfs/space-info.h |  4 ++--
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index c0bad6914bb7..0fdf60f05228 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -490,22 +490,20 @@ static u64 calc_available_free_space(const struct btrfs_space_info *space_info,
 	return avail;
 }
 
-int btrfs_can_overcommit(const struct btrfs_space_info *space_info, u64 bytes,
-			 enum btrfs_reserve_flush_enum flush)
+bool btrfs_can_overcommit(const struct btrfs_space_info *space_info, u64 bytes,
+			  enum btrfs_reserve_flush_enum flush)
 {
 	u64 avail;
 	u64 used;
 
 	/* Don't overcommit when in mixed mode */
 	if (space_info->flags & BTRFS_BLOCK_GROUP_DATA)
-		return 0;
+		return false;
 
 	used = btrfs_space_info_used(space_info, true);
 	avail = calc_available_free_space(space_info, flush);
 
-	if (used + bytes < space_info->total_bytes + avail)
-		return 1;
-	return 0;
+	return (used + bytes < space_info->total_bytes + avail);
 }
 
 static void remove_ticket(struct btrfs_space_info *space_info,
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 2fad2e4c2252..d97b0799649f 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -282,8 +282,8 @@ int btrfs_reserve_metadata_bytes(struct btrfs_space_info *space_info,
 				 u64 orig_bytes,
 				 enum btrfs_reserve_flush_enum flush);
 void btrfs_try_granting_tickets(struct btrfs_space_info *space_info);
-int btrfs_can_overcommit(const struct btrfs_space_info *space_info, u64 bytes,
-			 enum btrfs_reserve_flush_enum flush);
+bool btrfs_can_overcommit(const struct btrfs_space_info *space_info, u64 bytes,
+			  enum btrfs_reserve_flush_enum flush);
 
 static inline void btrfs_space_info_free_bytes_may_use(
 				struct btrfs_space_info *space_info,
-- 
2.47.2


