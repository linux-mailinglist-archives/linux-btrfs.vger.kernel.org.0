Return-Path: <linux-btrfs+bounces-2501-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 391CD85A2A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 12:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A791E1F2255C
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 11:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA652D047;
	Mon, 19 Feb 2024 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5HyeKyw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA6D2CCDF
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343976; cv=none; b=biif0d3eNgjYXm3okIKE7aeXHxD+l2DNkAtJYDXck40U8tBgqW/Ihie8XGOkfstsyP6dn75+KlLN+GKT5un5bPIg4JTOHCmF2ipbqx76z0iKpGLKOxYQst2HZv2tFtclOlkSuLG9hyATt/Aqs/VgRGsYeePE08EjH+yeGixZOaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343976; c=relaxed/simple;
	bh=xkVkDbRborDgx2ZoswrDyTMd2ApI7wIv8jYPFaIJXl8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O4l9AJhb005yHo/4UIkQ24EtV5JlVp+RNNn1v5KupzAcGpN1Whna8BV2scfztWqZPR1cic8SoWVNJn5qskqW3W/I8X/08EqRUoZuSMAWH4qpT+G4jOOin0kVrm9ZqUkzPJOV6PZo4HZdSg1h0kv9TPJgn6qTGFCASG5JYgErKOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5HyeKyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39349C43390
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 11:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708343975;
	bh=xkVkDbRborDgx2ZoswrDyTMd2ApI7wIv8jYPFaIJXl8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f5HyeKywGG68k4RyLTUHkgmbvOZFzXbw/08tSu1uNLsPrzub466cNz6xriSw/UrYS
	 NgGg9BsQ5Id/k1P/zdqiqWYqgZQ68X0zPqdEhXdRRfyqFeFI9yeon4fSZqyYemeiG0
	 fJ/AGw27Yd0/K6OgBmczU0uRPts+714KZarWzkNaIJ8dGpOXiFTJ02jeqKyUBvxFzz
	 9TMj5bgB1zEqMMlgNRwRAcFEH5L8XSIRN4E7cX5EcycCvZaWV1+5llkGXkv+fS8OOh
	 x2f9EPOF85lupQJDKHtwcrQ0N1zF37AkS8SEEZa26m2Yx7JCodYeqHIdKzu9oOoNvJ
	 ZGpQ9PWYe3Pww==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: send: don't issue unnecessary zero writes for trailing hole
Date: Mon, 19 Feb 2024 11:59:30 +0000
Message-Id: <2888e22ef71003ad9dff455c7f4fb990b8077548.1708260967.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1708260967.git.fdmanana@suse.com>
References: <cover.1708260967.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we have a sparse file with a trailing hole (from the last extent's end
to i_size) and then create an extent in the file that ends before the
file's i_size, then when doing an incremental send we will issue a write
full of zeroes for the range that starts immediately after the new extent
ends up to i_size. While this isn't incorrect because the file ends up
with exactly the same data, it unnecessarily results in using extra space
at the destination with one or more extents full of zeroes instead of
having a hole. In same cases this results in using megabytes or even
gigabytes of unnecessary space.

Example, reproducer:

   $ cat test.sh
   #!/bin/bash

   DEV=/dev/sdh
   MNT=/mnt/sdh

   mkfs.btrfs -f $DEV
   mount $DEV $MNT

   # Create 1G sparse file.
   xfs_io -f -c "truncate 1G" $MNT/foobar

   # Create base snapshot.
   btrfs subvolume snapshot -r $MNT $MNT/mysnap1

   # Create send stream (full send) for the base snapshot.
   btrfs send -f /tmp/1.snap $MNT/mysnap1

   # Now write one extent at the beginning of the file and one somewhere
   # in the middle, leaving a gap between the end of this second extent
   # and the file's size.
   xfs_io -c "pwrite -S 0xab 0 128K" \
          -c "pwrite -S 0xcd 512M 128K" \
          $MNT/foobar

   # Now create a second snapshot which is going to be used for an
   # incremental send operation.
   btrfs subvolume snapshot -r $MNT $MNT/mysnap2

   # Create send stream (incremental send) for the second snapshot.
   btrfs send -p $MNT/mysnap1 -f /tmp/2.snap $MNT/mysnap2

   # Now recreate the filesystem by receiving both send streams and
   # verify we get the same content that the original filesystem had
   # and file foobar has only two extents with a size of 128K each.
   umount $MNT
   mkfs.btrfs -f $DEV
   mount $DEV $MNT

   btrfs receive -f /tmp/1.snap $MNT
   btrfs receive -f /tmp/2.snap $MNT

   echo -e "\nFile fiemap in the second snapshot:"
   # Should have:
   #
   # 128K extent at file range [0, 128K[
   # hole at file range [128K, 512M[
   # 128K extent file range [512M, 512M + 128K[
   # hole at file range [512M + 128K, 1G[
   xfs_io -r -c "fiemap -v" $MNT/mysnap2/foobar

   # File should be using 256K of data (two 128K extents).
   echo -e "\nSpace used by the file: $(du -h $MNT/mysnap2/foobar | cut -f 1)"

   umount $MNT

Running the test, we can see with fiemap that we get an extent for the
range [512M, 1G[, while in the source filesystem we have an extent for
the range [512M, 512M + 128K[ and a hole for the rest of the file (the
range [512M + 128K, 1G[):

   $ ./test.sh
   (...)
   File fiemap in the second snapshot:
   /mnt/sdh/mysnap2/foobar:
    EXT: FILE-OFFSET        BLOCK-RANGE        TOTAL FLAGS
      0: [0..255]:          26624..26879         256   0x0
      1: [256..1048575]:    hole             1048320
      2: [1048576..2097151]: 2156544..3205119 1048576   0x1

   Space used by the file: 513M

This happens because once we finish processing an inode, at
finish_inode_if_needed(), we always issue a hole (write operations full
of zeros) if there's a gap between the end of the last processed extent
and the file's size, even if that range is already a hole in the parent
snapshot. Fix this by issuing the hole only if the range is not already
a hole.

After this change, running the test above, we get the expected layout:

   $ ./test.sh
   (...)
   File fiemap in the second snapshot:
   /mnt/sdh/mysnap2/foobar:
    EXT: FILE-OFFSET        BLOCK-RANGE      TOTAL FLAGS
      0: [0..255]:          26624..26879       256   0x0
      1: [256..1048575]:    hole             1048320
      2: [1048576..1048831]: 26880..27135       256   0x1
      3: [1048832..2097151]: hole             1048320

   Space used by the file: 256K

A test case for fstests will follow soon.

CC: stable@vger.kernel.org # 6.1+
Reported-by: Dorai Ashok S A <dash.btrfs@inix.me>
Link: https://lore.kernel.org/linux-btrfs/c0bf7818-9c45-46a8-b3d3-513230d0c86e@inix.me/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index e96d511f9dd9..dc18d5624ec7 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6723,11 +6723,20 @@ static int finish_inode_if_needed(struct send_ctx *sctx, int at_end)
 				if (ret)
 					goto out;
 			}
-			if (sctx->cur_inode_last_extent <
-			    sctx->cur_inode_size) {
-				ret = send_hole(sctx, sctx->cur_inode_size);
-				if (ret)
+			if (sctx->cur_inode_last_extent < sctx->cur_inode_size) {
+				ret = range_is_hole_in_parent(sctx,
+						      sctx->cur_inode_last_extent,
+						      sctx->cur_inode_size);
+				if (ret < 0) {
 					goto out;
+				} else if (ret == 0) {
+					ret = send_hole(sctx, sctx->cur_inode_size);
+					if (ret < 0)
+						goto out;
+				} else {
+					/* Range is already a hole, skip. */
+					ret = 0;
+				}
 			}
 		}
 		if (need_truncate) {
-- 
2.40.1


