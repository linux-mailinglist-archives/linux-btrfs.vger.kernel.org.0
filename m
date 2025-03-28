Return-Path: <linux-btrfs+bounces-12648-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A88DFA74C7E
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 15:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B1C1891E75
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 14:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D301C5486;
	Fri, 28 Mar 2025 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ED59C6OR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9811C3BE6
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743171850; cv=none; b=sZaiTaMxrFlbo+20LEP8xXurUxiZcQ5BjsbikRrOeRqeTV1TfaeLK6pu6Hm5b/nXGGe0Gaty235bYMjq7lDxf2NNgMu+VoqV+qVeh5OJ/qe+dKOSqFEdu4sh9CCs7+nawZ3Je1Ft4T9RX7bQsRVy9dXpbQ+89MFDHH8uWkOZTEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743171850; c=relaxed/simple;
	bh=tuvugG7qQ+JweFTru5TE8UFqT+VL4/eovAI1gyn/PJU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FBRudy9Ls9fveJ3DAe3aWJ4vOcZHRHP6d/DTcTf55Y/MwwnuPUvKXFOcYZbcKgxux1Z0V5Br1xeo5ABnd+pnhe8FeZ4ki4qLS2Pt9s6X09S9wnWH7W5XsN0CZ41JaJ2fGQc8QmW5H/lIpNgBda6teHh4OFuaioRHqJ39KM+JRzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ED59C6OR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E116C4CEE4
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 14:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743171849;
	bh=tuvugG7qQ+JweFTru5TE8UFqT+VL4/eovAI1gyn/PJU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ED59C6ORghKwQOLf4dt7Fm9Eg0ODdBV/UzUSUkMRwwzlMg3gWDwIFGeQfshDs1EXz
	 aSQLbhoNt1D0nyB5oxZZmFIVt/kafhxC1wXJ5/phfliBmlsCi4BHVQcTcDG3HhY6+a
	 TyJL6L2i8Zc+INApm5YM5ybbACZRnkhTw4mrso5RSHoGaqHa4NBJEFWOKL6X07E50m
	 V3vTq2LQkD9LBgeALBTLKUPhz2iuZ0amVR3bK48yWffeF26G3RZRzyx0i3l2LnnKVl
	 M0HTwurUeIm8S3A7uHaVRYRuTJFJlhXnmUJxQDB7l5yOGh5NgLm/Ey29rAUFNo104N
	 MLbisCtTGPePw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: stop searching for EXTENT_DIRTY bit in the excluded extents io tree
Date: Fri, 28 Mar 2025 14:24:03 +0000
Message-Id: <c1a1c0a13d53a86121dde3eb97ba0d62de3a9e68.1743166248.git.fdmanana@suse.com>
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

At btrfs_add_new_free_space() we keep searching for ranges in the excluded
extents io tree that have the EXTENT_DIRTY bit set, however we never ever
set that bit for ranges in that tree. That is a leftover from when that
function used the global freed extents trees (fs_info->freed_extents[2]),
where we used both the EXTENT_DIRTY and EXTENT_UPTODATE bits, but those
trees are gone with commit fe119a6eeb67 ("btrfs: switch to per-transaction
pinned extents"), which introduced the fs_info->excluded_extents io tree,
where only EXTENT_UPTODATE is set.

So remove the EXTENT_DIRTY bit search at btrfs_add_new_free_space().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index a8129f1ce78c..8a02375f27e8 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -527,8 +527,7 @@ int btrfs_add_new_free_space(struct btrfs_block_group *block_group, u64 start,
 	while (start < end) {
 		if (!find_first_extent_bit(&info->excluded_extents, start,
 					   &extent_start, &extent_end,
-					   EXTENT_DIRTY | EXTENT_UPTODATE,
-					   NULL))
+					   EXTENT_UPTODATE, NULL))
 			break;
 
 		if (extent_start <= start) {
-- 
2.45.2


