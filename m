Return-Path: <linux-btrfs+bounces-9350-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C1A9BDC20
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 03:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA61D1F2349D
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 02:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4681E1922C6;
	Wed,  6 Nov 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWxI3AU8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B551D88D3;
	Wed,  6 Nov 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859030; cv=none; b=VGegRKQUy/I8uzkzzS5mvskXip6uiwg4CgTnIQZ2OZ2UfpisR6Fulw6rmN5UFD9hwmDq2HGD/xYPCyFvEotbxxt5fmv22pwbN7qIoEUTaIWEwKKVLS879g3RUH6Yiassx/WKuldN35pbDCnr9lJj/bJRVLExxjF/JA1jdtOaRt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859030; c=relaxed/simple;
	bh=g0nY5EQ/sacOgmU77KKLHX0gIJCO2Tf/B9DF4Bubvf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qpKSXMbHSL9S5+jXeZOvEsKx2TpwV2Ac35U/PhaB1033rTVi/6rQWPnWIuQOu1jIJ++Y8ueF/4LGNFYU+AFnRgzh+oCZvcNRPFdHBiM8UNmRQp0WCFF7EJgSjxidslC5Gh7ThsaqLaL8dvARvD840ZwsuJftk73vVgm9XXNApbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWxI3AU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58246C4CECF;
	Wed,  6 Nov 2024 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859030;
	bh=g0nY5EQ/sacOgmU77KKLHX0gIJCO2Tf/B9DF4Bubvf0=;
	h=From:To:Cc:Subject:Date:From;
	b=aWxI3AU8JHe+RFeCeKTfxSnqlpo9KU2e95hH7X9QWf/PRxmlJEaCmWJpaLuj6g1X5
	 cxCErQMIdZqZHg18qelTMP8m/K3/UGbkUk1JqpI613Lu1sLPQR0hQzpqb2T3kRdEal
	 vZ+v+EiMQmtTcqVRvWpUmuFcWLb4IaTuih8ceizeQilZTnXeAOl1I4x9X3r8JzZFV2
	 IVa8bFNm24j3cv4X2Z45XrcVAhMemITGSmLq2a0clN3jMbEslPoa47LAkPa+8ZHd5J
	 I1Le4lkM8JetiZtBbr3G13PPNo1iFkc6AnnfHVorgKKtg7KIyB1za2D2F2W8yrzCPx
	 fvcCC/mINGonA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	fdmanana@suse.com
Cc: Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "btrfs: fix extent map merging not happening for adjacent extents" failed to apply to v6.1-stable tree
Date: Tue,  5 Nov 2024 21:10:27 -0500
Message-ID: <20241106021027.181013-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a0f0625390858321525c2a8d04e174a546bd19b3 Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Mon, 28 Oct 2024 16:23:00 +0000
Subject: [PATCH] btrfs: fix extent map merging not happening for adjacent
 extents

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
   unpin its extent map and attempt to merge it with the previous extent
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
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_map.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 668c617444a50..1d93e1202c339 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -230,7 +230,12 @@ static bool mergeable_maps(const struct extent_map *prev, const struct extent_ma
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
2.43.0





