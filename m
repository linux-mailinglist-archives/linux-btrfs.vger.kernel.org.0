Return-Path: <linux-btrfs+bounces-9207-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619B99B504D
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 18:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D106AB2236C
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 17:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6FC1DB958;
	Tue, 29 Oct 2024 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPib+1tB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FD3197A92
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Oct 2024 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730222580; cv=none; b=BAAVP0XMS02V+UoiFEwk/djB3UJvjI666PGTY0UC7VBzF9CcFJBHwsJWIL1Kg08yj5pcUWnmZ8HlfF7SGoSf930x3uj65s9d9wDDOmHXLqXMH6s40ddO245xI+x6wuq54NaG7Ts5cw28IrnMeu4Mnw+Mi2EZbrOt7sUaOiNH2t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730222580; c=relaxed/simple;
	bh=wl/HwXd9Ug/aMg6PMSa/09YcE8QiZ0DWWXgD0cF4h+A=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q4xuV3UvFeeGNBbnaARRlel32tGAtrh3nvGSSAE5N/hovrHQzEO3mzccnCOUoGzA3LZJKsS8yqTy9NX2M52gkhfJyLS4AEabj3bT42Y1Nu1bcjARc6HVZrLXBpkLBib50KE0r9ea0JGlde/XigQoxZEn3VYc90UhrAwy0QNQiQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPib+1tB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFE1C4CECD
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Oct 2024 17:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730222579;
	bh=wl/HwXd9Ug/aMg6PMSa/09YcE8QiZ0DWWXgD0cF4h+A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TPib+1tBD6lpZhj9Re+iUZj+NLNDijX+w5Fpmoh1jwW0j4DEmZANnzM/klr19hfCg
	 pLb7BABFOXdxsIJT32EeVu8FsYyAHPRQ0U+Mup3+tL29wU7IeD93F5UfW0/Ky4/zwP
	 qaEChJmfOMwnAxWljCqnaANuZiWdlXCVQ3v5tJUG7J8yfyTCDq52KCUsPTJ4YNvuOZ
	 R5860Ohu2/VlNyZiWjseo9i8RmQlKOCLRZYgMcJMbRQeWGRMXXEjUCFyRc5eiP8/5p
	 dBULc/mOtiTF50K5WulxATblRqBQ6WGjC7pmtvsre7hEN0zsXYKUdmBu6SyEZbowtm
	 ZF5lrf8V8mohw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: fix defrag not merging contiguous extents due to merged extent maps
Date: Tue, 29 Oct 2024 17:22:44 +0000
Message-Id: <413c27a335b97d53f01171d23165a0f86e6c843a.1730220532.git.fdmanana@suse.com>
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
of 256K that is the result of merging the indiviual extent maps for each
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

Fixes: 199257a78bb0 ("btrfs: defrag: don't use merged extent map for their generation check")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/defrag.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index b95ef44c326b..968dae953948 100644
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
2.45.2


