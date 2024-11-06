Return-Path: <linux-btrfs+bounces-9351-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 811039BDC2D
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 03:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF9C1F21316
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 02:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5031DB360;
	Wed,  6 Nov 2024 02:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlSYetc3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7774D18F2E2;
	Wed,  6 Nov 2024 02:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859051; cv=none; b=dO5wrYzZyjLSiCnCrFfqe8ud36GHNRcBnjNokweeUSd1dIU908cJlDKm+Z20kZSefG/pNd3Dh4VpaJHU+D429bgNzourf+F4RnKWevq5ROACz9jgonWLhwalisJDiZLUoxf/YP0j4MoNXa1SYrAHHmP7HtGGlNLMGDNFnqgNwPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859051; c=relaxed/simple;
	bh=qEHx27j6nvFxieAMiepcTQ4sdeoT6gt2/pwsSv3HzxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tez6QcImLTHFUu80jzhilKtldsSnlrTt+i0ih5EnPrCQhxUw45iFuctUG7DTgIimiH5uV+pJssrc1aZbbD5Hv2QQrgMXqyah9RbiQdP6xhDUGPy+2MlfXd8vqVQg933XM1XlRarlMV0v+WzcatldJNfexDp9sno8NMMyt+z4erI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlSYetc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36A2C4CECF;
	Wed,  6 Nov 2024 02:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859051;
	bh=qEHx27j6nvFxieAMiepcTQ4sdeoT6gt2/pwsSv3HzxI=;
	h=From:To:Cc:Subject:Date:From;
	b=PlSYetc3GP/dpyPIcGneMeUkxnZdz4WnvQd13ZUmNa/BMilg5N5tabPCOXJIeTnWI
	 uQd2Tvo26Ofq2eSLFtOV9+w+80F5yk+YA8t+dIS2PQxWL1AMeaaErqgUlU6nA0MpAp
	 sd7j7QL3XZsd5a7cO+wLtS5ZTlIG4qn4SAOZueCnddy1MTXDjTSFffWzUfYrrOlXWT
	 RWhPCAWIdULzo9RmrCrCnBObGJAOBnkogQtYZYMS654kV88lom65lg3SWlYUUIOUR7
	 GVupxLRzYKVvPMFvTsnoHdM4rtuQ1erBl5X0wI0HE9lfiqr3RlU69GZ/6e5Iv84rAc
	 wCdZghJC1hT6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	fdmanana@suse.com
Cc: Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "btrfs: fix defrag not merging contiguous extents due to merged extent maps" failed to apply to v6.1-stable tree
Date: Tue,  5 Nov 2024 21:10:47 -0500
Message-ID: <20241106021048.181812-1-sashal@kernel.org>
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

From 77b0d113eec49a7390ff1a08ca1923e89f5f86c6 Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Tue, 29 Oct 2024 15:18:45 +0000
Subject: [PATCH] btrfs: fix defrag not merging contiguous extents due to
 merged extent maps

When running defrag (manual defrag) against a file that has extents that
are contiguous and we already have the respective extent maps loaded and
merged, we end up not defragging the range covered by those contiguous
extents. This happens when we have an extent map that was the result of
merging multiple extent maps for contiguous extents and the length of the
merged extent map is greater than or equals to the defrag threshold
length.

The script below reproduces this scenario:

   $ cat test.sh
   #!/bin/bash

   DEV=/dev/sdi
   MNT=/mnt/sdi

   mkfs.btrfs -f $DEV
   mount $DEV $MNT

   # Create a 256K file with 4 extents of 64K each.
   xfs_io -f -c "falloc 0 64K" \
             -c "pwrite 0 64K" \
             -c "falloc 64K 64K" \
             -c "pwrite 64K 64K" \
             -c "falloc 128K 64K" \
             -c "pwrite 128K 64K" \
             -c "falloc 192K 64K" \
             -c "pwrite 192K 64K" \
             $MNT/foo

   umount $MNT
   echo -n "Initial number of file extent items: "
   btrfs inspect-internal dump-tree -t 5 $DEV | grep EXTENT_DATA | wc -l

   mount $DEV $MNT
   # Read the whole file in order to load and merge extent maps.
   cat $MNT/foo > /dev/null

   btrfs filesystem defragment -t 128K $MNT/foo
   umount $MNT
   echo -n "Number of file extent items after defrag with 128K threshold: "
   btrfs inspect-internal dump-tree -t 5 $DEV | grep EXTENT_DATA | wc -l

   mount $DEV $MNT
   # Read the whole file in order to load and merge extent maps.
   cat $MNT/foo > /dev/null

   btrfs filesystem defragment -t 256K $MNT/foo
   umount $MNT
   echo -n "Number of file extent items after defrag with 256K threshold: "
   btrfs inspect-internal dump-tree -t 5 $DEV | grep EXTENT_DATA | wc -l

Running it:

   $ ./test.sh
   Initial number of file extent items: 4
   Number of file extent items after defrag with 128K threshold: 4
   Number of file extent items after defrag with 256K threshold: 4

The 4 extents don't get merged because we have an extent map with a size
of 256K that is the result of merging the individual extent maps for each
of the four 64K extents and at defrag_lookup_extent() we have a value of
zero for the generation threshold ('newer_than' argument) since this is a
manual defrag. As a consequence we don't call defrag_get_extent() to get
an extent map representing a single file extent item in the inode's
subvolume tree, so we end up using the merged extent map at
defrag_collect_targets() and decide not to defrag.

Fix this by updating defrag_lookup_extent() to always discard extent maps
that were merged and call defrag_get_extent() regardless of the minimum
generation threshold ('newer_than' argument).

A test case for fstests will be sent along soon.

CC: stable@vger.kernel.org # 6.1+
Fixes: 199257a78bb0 ("btrfs: defrag: don't use merged extent map for their generation check")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/defrag.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index b95ef44c326bd..968dae9539482 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -763,12 +763,12 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
 	 * We can get a merged extent, in that case, we need to re-search
 	 * tree to get the original em for defrag.
 	 *
-	 * If @newer_than is 0 or em::generation < newer_than, we can trust
-	 * this em, as either we don't care about the generation, or the
-	 * merged extent map will be rejected anyway.
+	 * This is because even if we have adjacent extents that are contiguous
+	 * and compatible (same type and flags), we still want to defrag them
+	 * so that we use less metadata (extent items in the extent tree and
+	 * file extent items in the inode's subvolume tree).
 	 */
-	if (em && (em->flags & EXTENT_FLAG_MERGED) &&
-	    newer_than && em->generation >= newer_than) {
+	if (em && (em->flags & EXTENT_FLAG_MERGED)) {
 		free_extent_map(em);
 		em = NULL;
 	}
-- 
2.43.0





