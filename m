Return-Path: <linux-btrfs+bounces-17700-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5E5BD2E6E
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 14:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 893CB34B77A
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 12:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B7A26E16E;
	Mon, 13 Oct 2025 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFMjYN9O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC2A26D4F1
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760357138; cv=none; b=h7OZcgXpv6QWlfYLBWlPpqhVCwKvWa3RHFTrwdN+wx+D8DDhfZAUSny+5EiG7JhqiyMtcrwAmvJfz3eG/lyRVlblpU9aWbQ2MjMQ7sS7y2cwye3nMGEPvP17viuy1kmmwE/42NDPySM8wIdLGxtgmKDqaAwAo5L/gm/GvajpFaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760357138; c=relaxed/simple;
	bh=v1mI50sUzsMOpUQJT/mGgjr/4RviU3x5sGtbEjVbG1k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6YLDWpZllhvjPVbHGrpkGcfGC89s2ik9vskuyeeffZbTtdp9ENdDOHYMMQu87h7Cx8T0bEI6/B54ySHYbAxTgxJtrpPVlhNArhsivTJDP4tytzFDtpt7WD/CkD6W4Q7o+QuwODkkzJUnPXOxRzPuvQ2EbHQUuD02hF6C3CJ4zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFMjYN9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5CEC116C6
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 12:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760357138;
	bh=v1mI50sUzsMOpUQJT/mGgjr/4RviU3x5sGtbEjVbG1k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GFMjYN9OCfqd1JHJaK78Ue82ZEWwhGVrHVOPkAcMzL/R6inkSf3pWkTdcaEt+fzmJ
	 5Kv1pV5kpeaIUpfoVAlSw0mVx/tRLaPcocJN9A8LisrmQngPSvzyKBqvTcBht/Z3Zk
	 9PeySkR4HZxjY4CSCmLKxOz92RSzuB5ROacjTSfjrzqOGSIoaaExakf6/lYI1sMt8r
	 4p3lu0B+d1QbkeZ4YekB2/MiRwwh3vVxzL+RcyHKso2EWCAL9O+w2NE4BjGLDCrC/M
	 GyNb68q/WbDg4+AC0/3IeEPpLsTgZC2oq7z3pPjSvG3HiJnTVkLFk8Q5KTGlBICGWU
	 MnBjaAhe2iPUA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/7] btrfs: use variable for end offset in extent_writepage_io()
Date: Mon, 13 Oct 2025 13:05:27 +0100
Message-ID: <6b9b4740fe8b138175b0e0e0b36408a93338c9cc.1760356778.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1760356778.git.fdmanana@suse.com>
References: <cover.1760356778.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of repeating the expression "start + len" multiple times, store it
in a variable and use it where needed.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 67706c1efa88..c641eb50d0ee 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1690,6 +1690,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	unsigned long range_bitmap = 0;
 	bool submitted_io = false;
 	int found_error = 0;
+	const u64 end = start + len;
 	const u64 folio_start = folio_pos(folio);
 	const u64 folio_end = folio_start + folio_size(folio);
 	const unsigned int blocks_per_folio = btrfs_blocks_per_folio(fs_info, folio);
@@ -1697,7 +1698,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	int bit;
 	int ret = 0;
 
-	ASSERT(start >= folio_start && start + len <= folio_end);
+	ASSERT(start >= folio_start && end <= folio_end);
 
 	ret = btrfs_writepage_cow_fixup(folio);
 	if (ret == -EAGAIN) {
@@ -1713,7 +1714,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 		return ret;
 	}
 
-	for (cur = start; cur < start + len; cur += fs_info->sectorsize)
+	for (cur = start; cur < end; cur += fs_info->sectorsize)
 		set_bit((cur - folio_start) >> fs_info->sectorsize_bits, &range_bitmap);
 	bitmap_and(&bio_ctrl->submit_bitmap, &bio_ctrl->submit_bitmap, &range_bitmap,
 		   blocks_per_folio);
@@ -1742,7 +1743,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			btrfs_put_ordered_extent(ordered);
 
 			btrfs_mark_ordered_io_finished(inode, folio, cur,
-						       start + len - cur, true);
+						       end - cur, true);
 			/*
 			 * This range is beyond i_size, thus we don't need to
 			 * bother writing back.
@@ -1751,8 +1752,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			 * writeback the sectors with subpage dirty bits,
 			 * causing writeback without ordered extent.
 			 */
-			btrfs_folio_clear_dirty(fs_info, folio, cur,
-						start + len - cur);
+			btrfs_folio_clear_dirty(fs_info, folio, cur, end - cur);
 			break;
 		}
 		ret = submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
-- 
2.47.2


