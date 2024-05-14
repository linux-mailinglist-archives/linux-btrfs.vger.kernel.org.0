Return-Path: <linux-btrfs+bounces-4965-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BC28C57D6
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 16:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2971A1C21A00
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 14:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1AE14532B;
	Tue, 14 May 2024 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2pCgXx+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5691A14533C
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715696629; cv=none; b=mqxxfwvAM+b8JSqrMxjRG020E2lUD+1FKCcAhctoo7g7u64DhWqbgecfNPicLC5K/JbOqYgxq4zBtEcYWzHm2+YrY4W57e80A+bmb5RUWJKZyxVvDVszMjGzFHYR4+8WbqrtrTJLvWmTy0R/69IjrTHVxYr94SHlkYQSf3Re1EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715696629; c=relaxed/simple;
	bh=USDRt6PiVX+vGbg87zJ2nDNBBcrNaJiEct1f4eruWZ0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dNoyY6f/VIf0750v6rGICohY2nH3xIiYZk5WjsuTfTlIFzS1+Uzpd2yrpxsgvI/0zXLhJ8fxNtjIVkFTFyry3Z5iPwKvC+XCCBq3p1WYtHL4uOtQ9QA82zyKLd0R7niIM4tVrOSlVjIgNU2ifD2wkSOzMI9p/A4ABkVoj0CIv/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2pCgXx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FCEC32782
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 14:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715696628;
	bh=USDRt6PiVX+vGbg87zJ2nDNBBcrNaJiEct1f4eruWZ0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=J2pCgXx+wgUaVt8bYGaXv3iNIhXkt1f5WQtZ0vESyqBavSDbzX1T/XN8e3WBvSC/R
	 lbhNcF+EvtBmV/CgLbVDOdQ3wT4GA4kWNaJWADrxw3V6MB2U+dMVCAN4BPXxMuSN1O
	 C3Of9zskxeZKiGHL4i6gz5IVHeO4WE05NVYJ7eClqneueDaxa+kUYyegLAAk1KIAVZ
	 uMWhMQSrV9T5bIjwBdrJECsFfrf+bZ3mn5H33LkAfMZDLrpgMsL1NDJFTa5FPICVmo
	 tMlXnxd49/T6gGcf3FWcjwmgJRxDSj8O1DMg7z1AodHthBE4gUY/Y4GQt2ae5X1/lS
	 k7ymS+uutx8BQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: drop extent maps after failed COW dio write
Date: Tue, 14 May 2024 15:23:39 +0100
Message-Id: <affef2b4ccd4d0f9a0272cd5883a5922d36bac31.1715688057.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715688057.git.fdmanana@suse.com>
References: <cover.1715688057.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

During a COW direct IO write if the call to btrfs_extract_ordered_extent()
fails, we don't submit any bios, cleanup the ordered extent but we leave
the extent maps we created for the write around.

These extent maps point to locations on disk that were not written to,
since we haven't submitted a bio for them, and they are new an in the list
of modified extents.

This means that if we fsync the file after, we log file extent items based
on those extent maps, which are invalid since they point to unwritten
locations. If a power failure happens after the fsync, on log replay we
get a corrupted file range.

Fix this by dropping the extent maps if btrfs_extract_ordered_extent()
failed.

Fixes: b73a6fd1b1ef ("btrfs: split partial dio bios before submit")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5a1014122088..f04852e44123 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7888,11 +7888,28 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 	 * remaining pages is blocked on the outstanding ordered extent.
 	 */
 	if (iter->flags & IOMAP_WRITE) {
+		struct btrfs_ordered_extent *oe = dio_data->ordered;
 		int ret;
 
-		ret = btrfs_extract_ordered_extent(bbio, dio_data->ordered);
+		ret = btrfs_extract_ordered_extent(bbio, oe);
 		if (ret) {
-			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
+			/*
+			 * If this is a COW write it means we created new extent
+			 * maps for the range and they point to an unwritten
+			 * location since we got an error and we don't submit
+			 * a bio. We must drop any extent maps within the range,
+			 * otherwise a fast fsync would log them and after a
+			 * crash and log replay we would have file extent items
+			 * that point to unwritten locations (garbage).
+			 */
+			if (!test_bit(BTRFS_ORDERED_NOCOW, &oe->flags)) {
+				const u64 start = oe->file_offset;
+				const u64 end = start + oe->num_bytes - 1;
+
+				btrfs_drop_extent_map_range(bbio->inode, start, end, false);
+			}
+
+			btrfs_finish_ordered_extent(oe, NULL,
 						    file_offset, dip->bytes,
 						    !ret);
 			bio->bi_status = errno_to_blk_status(ret);
-- 
2.43.0


