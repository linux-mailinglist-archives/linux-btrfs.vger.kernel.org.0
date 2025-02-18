Return-Path: <linux-btrfs+bounces-11538-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCA0A3A8E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 21:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F5C174DEE
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 20:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1441DE4E7;
	Tue, 18 Feb 2025 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2kGhfgr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D551DE4C4;
	Tue, 18 Feb 2025 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910324; cv=none; b=TQ1DxJN8uXLAZKXkzKQeGRa0G6yyUmbxuoczur5nNasbLDJLnEyF51PIIsFTvrtKgAn/+ITq4j4qErJJmXsy6E5RZszCFvb4ZS4wkuLKh2uBq4kMEVd2LDR6n6QlHDiRbOo4pkrn7zmrAGxrSEyssgZKphaer7u0UcpXk5waiAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910324; c=relaxed/simple;
	bh=HROdbV+kk+u6RGloJduTxq5OXpiJcjPK977WpqtXzxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=juTkkR2GUp5E4oU95WOeJOyMDot2x3L5HhfkX/Lprk9Frc946Z+Vgml3i+tMlNFTpqw/wvEtkTMdFRAAxM2RL3kfGiuByQ1PtkxY2lUrzd0viSKfpDpQ8X61cinI7QRtJ5puhZNnPct6ASjfk8waN4SFzINsctvsHY8TAAG5R00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2kGhfgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF76C4CEE8;
	Tue, 18 Feb 2025 20:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910323;
	bh=HROdbV+kk+u6RGloJduTxq5OXpiJcjPK977WpqtXzxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p2kGhfgrsxwej5tadK3dTVJkJAWVO7t4bIYs/A1+eYULmLRKbNNczhdqDGfcKgC6O
	 dEyN9mEOBYsoZe+gvFYfipzwWc4dscFYYxx3UsamzaI2BZuxXC0/SrZ5Oyz5n3EPqZ
	 x3klsEuuV+mJ8q5pOY9CZW+i+Ej4nxwfkBWitRz03ziiY0RdhR6QoCwd0BKcC+St/L
	 htQWwn552aMkvxdsK4eVXxJCpHw/TZUKQqmh65+JN75iCQeSNlEqFJuqvoc55q8ZQs
	 JpB3tzx4WGQdjhBlDlvOHoVoaXyEs25Y4SNYfajjtImabO2cZRrdkCoE3dOVyMP+9p
	 LM/tzVrAIj00A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 12/31] btrfs: fix two misuses of folio_shift()
Date: Tue, 18 Feb 2025 15:24:32 -0500
Message-Id: <20250218202455.3592096-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202455.3592096-1-sashal@kernel.org>
References: <20250218202455.3592096-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.3
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit 01af106a076352182b2916b143fc50272600bd81 ]

It is meaningless to shift a byte count by folio_shift().  The folio index
is in units of PAGE_SIZE, not folio_size().  We can use folio_contains()
to make this work for arbitrary-order folios, so remove the assertion
that the folios are of order 0.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b923d0cec61c7..a8e0076d44c72 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -526,8 +526,6 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 		u64 end;
 		u32 len;
 
-		/* For now only order 0 folios are supported for data. */
-		ASSERT(folio_order(folio) == 0);
 		btrfs_debug(fs_info,
 			"%s: bi_sector=%llu, err=%d, mirror=%u",
 			__func__, bio->bi_iter.bi_sector, bio->bi_status,
@@ -555,7 +553,6 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 
 		if (likely(uptodate)) {
 			loff_t i_size = i_size_read(inode);
-			pgoff_t end_index = i_size >> folio_shift(folio);
 
 			/*
 			 * Zero out the remaining part if this range straddles
@@ -564,9 +561,11 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 			 * Here we should only zero the range inside the folio,
 			 * not touch anything else.
 			 *
-			 * NOTE: i_size is exclusive while end is inclusive.
+			 * NOTE: i_size is exclusive while end is inclusive and
+			 * folio_contains() takes PAGE_SIZE units.
 			 */
-			if (folio_index(folio) == end_index && i_size <= end) {
+			if (folio_contains(folio, i_size >> PAGE_SHIFT) &&
+			    i_size <= end) {
 				u32 zero_start = max(offset_in_folio(folio, i_size),
 						     offset_in_folio(folio, start));
 				u32 zero_len = offset_in_folio(folio, end) + 1 -
@@ -963,7 +962,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		return ret;
 	}
 
-	if (folio->index == last_byte >> folio_shift(folio)) {
+	if (folio_contains(folio, last_byte >> PAGE_SHIFT)) {
 		size_t zero_offset = offset_in_folio(folio, last_byte);
 
 		if (zero_offset) {
-- 
2.39.5


