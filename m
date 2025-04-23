Return-Path: <linux-btrfs+bounces-13317-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB4FA98CCA
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189F75A3ACE
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 14:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15751280CFC;
	Wed, 23 Apr 2025 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVBoK6Wc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D20727E1BC
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418028; cv=none; b=U2HD8EGvDPmbRLUMKZ2iPE+bUHEZwTrBR/TzHxoSR4G+y2fZT5Q9mYLK7dypZLXS8oaBfkbr7jQU5U1AkO7pzMi2lzOtUbPcTkw+6jXA93z3MBaYzyTAObFqm7XhySUdh20afpcY+CNJ9LBBNJ4WHBOMVJzmHCn0bhF7+K+jbNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418028; c=relaxed/simple;
	bh=X93AhfjI88ExbE3DqSfXl7O2ZXMpeSjDYw1NVO5YbOg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MpzVYGNROz5mkzZiiAuL/qvQP47OK92NFik72BsU9TaLzRmrNw+RftGGrhdfLkspKnXu+pZ7M/9+W/2XjVC33OcVymIqrolMSZs4wT2VkVcPf4GcGXDgQx5PR/NM4sQ8XlKU8n6uBeteAtWp+GY39Ey+TKYNyoNeIWX46tZJOv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVBoK6Wc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAE7C4CEE2
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745418027;
	bh=X93AhfjI88ExbE3DqSfXl7O2ZXMpeSjDYw1NVO5YbOg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GVBoK6WcR0kxzZFZLLgHwx2SogJrCobCbxgD/IReGir/x2n67TnJ8b9cYPFWAUG1b
	 6+iI+Pv/j8feXGTZS9GouVNs1xoV5bm/0KAHPvolt1P9kvPwxKLCxJlQXIa9YIlz4f
	 IfdB/szeq7g4k3Nx/B4iNW3AKXU4nvwkN3LHH1bnrmRkgHsoKFeXi10xxLmYTol9lm
	 2lTmDLs28a1EKSbvFHLKP7WSVS5qNC60m2cTiwlpEjjoyZsALlntNrDGaEv+GAb83u
	 N1xa6YgH9NcKLMEq7hH3J0DW6IgeHrM7BI+8HSW94P3HHJxOwvA4+EADRCeTWX/DnO
	 hmjc12PHZryxg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 21/22] btrfs: remove variable to track trimmed bytes at btrfs_finish_extent_commit()
Date: Wed, 23 Apr 2025 15:20:01 +0100
Message-Id: <b64fd149d6916a93db7fe1b0f1a1014d5322d667.1745401628.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745401627.git.fdmanana@suse.com>
References: <cover.1745401627.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We don't need to keep track of discarded (trimmed) bytes at
btrfs_finish_extent_commit() but we are declaring a local variable for
that and passing a reference to the btrfs_discard_extent() calls when we
are processing delete block groups. So instead pass NULL to
btrfs_discard_extent() and remove that variable.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 190bde099ee8..36a29739eac2 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2875,14 +2875,10 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 	 */
 	deleted_bgs = &trans->transaction->deleted_bgs;
 	list_for_each_entry_safe(block_group, tmp, deleted_bgs, bg_list) {
-		u64 trimmed = 0;
-
 		ret = -EROFS;
 		if (!TRANS_ABORTED(trans))
-			ret = btrfs_discard_extent(fs_info,
-						   block_group->start,
-						   block_group->length,
-						   &trimmed);
+			ret = btrfs_discard_extent(fs_info, block_group->start,
+						   block_group->length, NULL);
 
 		/*
 		 * Not strictly necessary to lock, as the block_group should be
-- 
2.47.2


