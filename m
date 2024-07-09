Return-Path: <linux-btrfs+bounces-6323-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFDC92C00F
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 18:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545251F2225E
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 16:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39CE1B0136;
	Tue,  9 Jul 2024 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxwO+Tu9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A511B1215;
	Tue,  9 Jul 2024 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542076; cv=none; b=qsOI1IaksEoUaF7quVJuTY9NYwVxJA1w0PfH9++mBRmFHnYFGfZqoxyNgTdXHcA2X0kfajy0fAKE/XEE6LzaT4MydV2ALwTkSemmEzbA10Vdve1KysUvyduQrm+qNoNFlLP/pfIwK7j8IqoTJfJZkZ7q5KEob+pklTIZfrnPgRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542076; c=relaxed/simple;
	bh=R23LDv+BgMZwnGsoo7WxIRaW0eVrOKkU08bzpE9RakQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcuUreF+N+ODIIxQ3+mZdTMYgmPbkpgfP6bjB8s44nFMmIP91xtcvylu4GHxURtHCsGqtZ1lbrulTQiMhONAZ1eEiLwxftXALn35nMpYuJE946dWIrUpwKxMsRNewFKoV39iBnpjfNqiL9sOAqcqX1S+z/7fdWqslHwZ+LF8cDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxwO+Tu9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51FAC3277B;
	Tue,  9 Jul 2024 16:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542075;
	bh=R23LDv+BgMZwnGsoo7WxIRaW0eVrOKkU08bzpE9RakQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GxwO+Tu9+F2LdXMaGbzJcOYwFqkYx9vta2X0lwv6I6SPW0FRvNa5LtGXptzqDxEKO
	 Zj3PxZjWHESIbHGNXaPsKr+5Nq+MgWyCMyHcwKvIZ/e6FRm/1lZjsvIXuYsw6bej+6
	 a4kV4UQUSXIsFB6pjfNydcgDtEoD8z2I6xoo7m1KNVboyaDsmYxO5RHVld2QAoG5fY
	 8ik8ZDxyk4dPB6u3L0bmG0qbwHxQlBUBS1JY+FfG8PuRU6cpC+n3lx7ZBzHrAFVieD
	 Qw5K86+F1mzPYBMThkUcIzo+myvr+wYRnRnzfFXhtDBLtLCWpNQox/aR336jdmm9Ps
	 OL55g1c2uxciw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 31/40] btrfs: scrub: handle RST lookup error correctly
Date: Tue,  9 Jul 2024 12:19:11 -0400
Message-ID: <20240709162007.30160-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162007.30160-1-sashal@kernel.org>
References: <20240709162007.30160-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.8
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 2c49908634a2b97b1c3abe0589be2739ac5e7fd5 ]

[BUG]
When running btrfs/060 with forced RST feature, it would crash the
following ASSERT() inside scrub_read_endio():

	ASSERT(sector_nr < stripe->nr_sectors);

Before that, we would have tree dump from
btrfs_get_raid_extent_offset(), as we failed to find the RST entry for
the range.

[CAUSE]
Inside scrub_submit_extent_sector_read() every time we allocated a new
bbio we immediately called btrfs_map_block() to make sure there was some
RST range covering the scrub target.

But if btrfs_map_block() fails, we immediately call endio for the bbio,
while the bbio is newly allocated, it's completely empty.

Then inside scrub_read_endio(), we go through the bvecs to find
the sector number (as bi_sector is no longer reliable if the bio is
submitted to lower layers).

And since the bio is empty, such bvecs iteration would not find any
sector matching the sector, and return sector_nr == stripe->nr_sectors,
triggering the ASSERT().

[FIX]
Instead of calling btrfs_map_block() after allocating a new bbio, call
btrfs_map_block() first.

Since our only objective of calling btrfs_map_block() is only to update
stripe_len, there is really no need to do that after btrfs_alloc_bio().

This new timing would avoid the problem of handling empty bbio
completely, and in fact fixes a possible race window for the old code,
where if the submission thread is the only owner of the pending_io, the
scrub would never finish (since we didn't decrease the pending_io
counter).

Although the root cause of RST lookup failure still needs to be
addressed.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/scrub.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 4b22cfe9a98cb..e3e0b8a4c187c 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1688,20 +1688,24 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
 					    (i << fs_info->sectorsize_bits);
 			int err;
 
-			bbio = btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_READ,
-					       fs_info, scrub_read_endio, stripe);
-			bbio->bio.bi_iter.bi_sector = logical >> SECTOR_SHIFT;
-
 			io_stripe.is_scrub = true;
+			stripe_len = (nr_sectors - i) << fs_info->sectorsize_bits;
+			/*
+			 * For RST cases, we need to manually split the bbio to
+			 * follow the RST boundary.
+			 */
 			err = btrfs_map_block(fs_info, BTRFS_MAP_READ, logical,
-					      &stripe_len, &bioc, &io_stripe,
-					      &mirror);
+					      &stripe_len, &bioc, &io_stripe, &mirror);
 			btrfs_put_bioc(bioc);
-			if (err) {
-				btrfs_bio_end_io(bbio,
-						 errno_to_blk_status(err));
-				return;
+			if (err < 0) {
+				set_bit(i, &stripe->io_error_bitmap);
+				set_bit(i, &stripe->error_bitmap);
+				continue;
 			}
+
+			bbio = btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_READ,
+					       fs_info, scrub_read_endio, stripe);
+			bbio->bio.bi_iter.bi_sector = logical >> SECTOR_SHIFT;
 		}
 
 		__bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
-- 
2.43.0


