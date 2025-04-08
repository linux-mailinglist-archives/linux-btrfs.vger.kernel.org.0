Return-Path: <linux-btrfs+bounces-12883-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFE8A813BC
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 19:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A893B1BA82AC
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 17:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D922356CC;
	Tue,  8 Apr 2025 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0v1gQaH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03984235377
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133588; cv=none; b=jlB6aKBmAP0SZEU2EdfQf8FfkYWaa0Dbj2P5PBCCXfafcT/6izwFQoLHMrny1b1BG1xFRmN5PaT0MWuJYaPPGT75pR3KAbYcV9k9s71UEaKtEYNH6HBWKTCLzG1aG+2Z1xF4CVD2nz35peVqqyrVV2KFS5s9b7K9KDsEGfORKd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133588; c=relaxed/simple;
	bh=q/ESc7WaIBJHjUkMwH2IpndXzM6tMI3pkVGCKULoMQc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OE+/N2fMtWmT+FRRMvqqPKuzKw9nzNbEtAGspuNc8ftBm57ggwrlLjw6BZXeJJWWqBokfhGxjhLOfmanixX0ZTGIBDcvhdZqbr51Tf9JXF2Z3xjm3Mdl0Sm8Rw8GBeO0jF9CpWHpzX13zsIM6kx98tbN8Z2YW77R/87C7cIUGwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0v1gQaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F351AC4CEE9
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 17:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744133587;
	bh=q/ESc7WaIBJHjUkMwH2IpndXzM6tMI3pkVGCKULoMQc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=p0v1gQaHRCHLTwYhFXVYxjYDRRg6YrVZ/LHqt2JupRd+qhjz+btUgMP4FHe1Ws0Hq
	 bYQw8H5xYg116qAmI0FqD5xNbRMaWjMkb5TeHbK/G4ecegX1KhbFYCJ8hZZEwymOY8
	 mac9qLkLYdVvuH6tdtrZjpSmlOuOn2LM1cX6eGWXwmaq9PAGLWnIvn8njQmALeGVDZ
	 EqI7eRjXd0oYe9nKnsTBIf1rAG2c3cVQe5q+N/3zO0y00I3u1IdW1MfFqxE0XPQ4WT
	 wh45jQj+M/ABQFQRnlOLSdFTYg6ypMwhRLD7n7Wv2q7XJnOvKHQgL3idLXpT3C5efs
	 alK9g8+YBfV5Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/6] btrfs: rename __lookup_extent_mapping() to remove double underscore prefix
Date: Tue,  8 Apr 2025 18:32:58 +0100
Message-Id: <5ada176ee93dd28a68964fbbafc496106a28a5e1.1744130413.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744130413.git.fdmanana@suse.com>
References: <cover.1744130413.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to have a double underscore prefix as there's no variant
of the function without it anymore.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 042b8b2e8b52..974163ed0c27 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -508,9 +508,8 @@ static int add_extent_mapping(struct btrfs_inode *inode,
 	return 0;
 }
 
-static struct extent_map *
-__lookup_extent_mapping(struct extent_map_tree *tree,
-			u64 start, u64 len, int strict)
+static struct extent_map *lookup_extent_mapping(struct extent_map_tree *tree,
+						u64 start, u64 len, int strict)
 {
 	struct extent_map *em;
 	struct rb_node *rb_node;
@@ -549,7 +548,7 @@ __lookup_extent_mapping(struct extent_map_tree *tree,
 struct extent_map *btrfs_lookup_extent_mapping(struct extent_map_tree *tree,
 					       u64 start, u64 len)
 {
-	return __lookup_extent_mapping(tree, start, len, 1);
+	return lookup_extent_mapping(tree, start, len, 1);
 }
 
 /*
@@ -567,7 +566,7 @@ struct extent_map *btrfs_lookup_extent_mapping(struct extent_map_tree *tree,
 struct extent_map *btrfs_search_extent_mapping(struct extent_map_tree *tree,
 					       u64 start, u64 len)
 {
-	return __lookup_extent_mapping(tree, start, len, 0);
+	return lookup_extent_mapping(tree, start, len, 0);
 }
 
 /*
-- 
2.45.2


