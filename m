Return-Path: <linux-btrfs+bounces-9206-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CF49B504C
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 18:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45F828509A
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 17:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B261DB372;
	Tue, 29 Oct 2024 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EW0fdiad"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386691DA109
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Oct 2024 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730222576; cv=none; b=uFev1eP4+JcjYrmudNpRXRd9hZbPQ29H7UWHku7+9c46edtNNZ3NMcrnZst7bz+6w07GdSfZpOVYdea96/PPM+pfZuJsIO9GuHIRpCv7BEcARcO34G4D8fEMqHHju+55if1CHRPAZIg5I7ZiLFPVRcjckoFzFHmDBT8NQKFwCTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730222576; c=relaxed/simple;
	bh=vwpTlZB6E+ahDI1g8N36TxRuBa3vQPKcqc0U2HUWAZE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pebu2Kqwqw0u+tWvzcllhe6vDikovIeyZP3EidCSnN/sN0Xeis7o5X1H2vohdzaprj7GHXRhWxS2Sffa3Rcfrm4VNMAyzPR34+9qTChBTweJiAGGqLRhcfvyMgLq+sZZwic6cQkj4z++QSQH6OyJdEtqtgvKOXMyLyPE53zrtow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EW0fdiad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F45FC4CECD
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Oct 2024 17:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730222576;
	bh=vwpTlZB6E+ahDI1g8N36TxRuBa3vQPKcqc0U2HUWAZE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EW0fdiad6y48fJcD2P1S8ScnWxafj/kqshE/Jqrpken+ugnR8EIeKhm80+aG6NRgg
	 OSs2hgsdvtEFXLzw20CfpjfaGVhBb7dkLoDAGZ3hArkY1aaliszn2GFGHrIjpvgxfL
	 HgzbIYPQtDJZ8stU7HMDrN8E3LcQfZ3ubFLV6AHVZtzyUjvG2LIOjgAeabHea6sLcm
	 VHSpERuC1yTBC76t+yJTGAKK+ncf62GuKwlCjOwz9DapqYxNsN3ADFL90MFZgUJCPj
	 9cFhSOQKuMMenQuxBdGPvRCB2ul3y0ZfYj86GX1JIV4ub7LQ6g/yRyUPqRBQb6mJfY
	 c0Od047ivHedw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix extent map merging not happening for adjacent extents
Date: Tue, 29 Oct 2024 17:22:43 +0000
Message-Id: <9243b672972756682e44c7e69a696c9cc08181ff.1730220532.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730220532.git.fdmanana@suse.com>
References: <cover.1730220532.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we have 3 or more adjacent extents in a file, that is, consecutive file
extent items pointing to adjacent extents, within a contiguous file range
and compatible flags, we end up not merging all the extents into a single
extent map.

For example:

  $ mkfs.btrfs -f /dev/sdc
  $ mount /dev/sdc /mnt/sdc

  $ xfs_io -f -d -c "pwrite -b 64K 0 64K" \
                 -c "pwrite -b 64K 64K 64K" \
                 -c "pwrite -b 64K 128K 64K" \
                 -c "pwrite -b 64K 192K 64K" \
                 /mnt/sdc/foo

After all the ordered extents complete we unpin the extent maps and try
to merge them, but instead of getting a single extent map we get two
because:

1) When the first ordered extent completes (file range [0, 64K)) we
   unpin its extent map and attempt to merge it with the extent map for
   the range [64K, 128K), but we can't because that extent map is still
   pinned;

2) When the second ordered extent completes (file range [64K, 128K)), we
   unpin its extent map and merge it with the previous extent map, for
   file range [0, 64K), but we can't merge with the next extent map, for
   the file range [128K, 192K), because this one is still pinned.

   The merged extent map for the file range [0, 128K) gets the flag
   EXTENT_MAP_MERGED set;

3) When the third ordered extent completes (file range [128K, 192K)), we
   unpin its exent map and attempt to merge it with the previous extent
   map, for file range [0, 128K), but we can't because that extent map
   has the flag EXTENT_MAP_MERGED set (mergeable_maps() returns false
   due to different flags) while the extent map for the range [128K, 192K)
   doesn't have that flag set.

   We also can't merge it with the next extent map, for file range
   [192K, 256K), because that one is still pinned.

   At this moment we have 3 extent maps:

   One for file range [0, 128K), with the flag EXTENT_MAP_MERGED set.
   One for file range [128K, 192K).
   One for file range [192K, 256K) which is still pinned;

4) When the fourth and final extent completes (file range [192K, 256K)),
   we unpin its extent map and attempt to merge it with the previous
   extent map, for file range [128K, 192K), which succeeds since none
   of these extent maps have the EXTENT_MAP_MERGED flag set.

   So we end up with 2 extent maps:

   One for file range [0, 128K), with the flag EXTENT_MAP_MERGED set.
   One for file range [128K, 256K), with the flag EXTENT_MAP_MERGED set.

   Since after merging extent maps we don't attempt to merge again, that
   is, merge the resulting extent map with the one that is now preceding
   it (and the one following it), we end up with those two extent maps,
   when we could have had a single extent map to represent the whole file.

Fix this by making mergeable_maps() ignore the EXTENT_MAP_MERGED flag.
While this doesn't present any functional issue, it prevents the merging
of extent maps which allows to save memory, and can make defrag not
merging extents too (that will be addressed in the next patch).

Fixes: 199257a78bb0 ("btrfs: defrag: don't use merged extent map for their generation check")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 1f85b54c8f0c..67ce85ff0ae2 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -233,7 +233,12 @@ static bool mergeable_maps(const struct extent_map *prev, const struct extent_ma
 	if (extent_map_end(prev) != next->start)
 		return false;
 
-	if (prev->flags != next->flags)
+	/*
+	 * The merged flag is not an on-disk flag, it just indicates we had the
+	 * extent maps of 2 (or more) adjacent extents merged, so factor it out.
+	 */
+	if ((prev->flags & ~EXTENT_FLAG_MERGED) !=
+	    (next->flags & ~EXTENT_FLAG_MERGED))
 		return false;
 
 	if (next->disk_bytenr < EXTENT_MAP_LAST_BYTE - 1)
-- 
2.45.2


