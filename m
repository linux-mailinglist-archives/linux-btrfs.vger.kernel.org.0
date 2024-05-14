Return-Path: <linux-btrfs+bounces-4966-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 412E68C57D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 16:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728461C21AAB
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 14:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C62E145359;
	Tue, 14 May 2024 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajE8YerZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4827A14534B
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715696630; cv=none; b=jzS4S275JvXNq2aIPlV+EmexmZAV7HUZs4o1xZI4207ToZx/myIdsxlb9bEKsvDAXzUf8Xdt6956+NoUTVOiDytEoEjDKKRZHDSP3/ij6jmMqLzdoNkX+TDckw06AzEyiz07Rbti65q5QLyIxc9myv0E8yXMjbhzdKDUDBQS1bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715696630; c=relaxed/simple;
	bh=DHi4Q5Nv9tXUOoNMhALdEBK8GOyE+4wXbp+ASqi7ziw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FlKRhyCtFDuNGE32+eLamDiEmE7YnMPfJL/1+4XyFdFjGnNlW1tAoDD4/8wzjsEuMWow21hvUSkLOwCYbiQhT6TK6Nu+8xDiPoae4VQw+XNMCDyHbMlWYx7IXs1UwaTmQ6uo2S47eNZNOnEGqpmpS6/NsQ+DXeQuSLmrc7k62hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajE8YerZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7CAC32786
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 14:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715696629;
	bh=DHi4Q5Nv9tXUOoNMhALdEBK8GOyE+4wXbp+ASqi7ziw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ajE8YerZRcNO1a+6pNONu1tgEzu+bOrVYOpCI73U5FwKTA5G1mNB7KF6XYFFuQAqe
	 Ch7/5M7gx+xvwQjQ6LWR2il504EE0fGBtdVdgbzoJLdkAFpuGMoFT0eXwGD8CFfA8t
	 2xAd+rVOCZaC7kH6kLq/qCSLneDpX2VzgOEkLduyGD1u2Zclkf0B68qKpDQ9ZZ1cGg
	 giGARhRQIrsmBjQ3nCj7d7dpC+vLWxNeNLLl8wI9Ksw8r6oskqFwhWsxQojmFfR9rW
	 fYlQEb+so/Jisux1uUhbUUjABaVtXAazFFAxpoY08Fy6plNXt3HxKYh8txX+grzHdE
	 f5GDvssc0DZEA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: refactor btrfs_dio_submit_io() for less nesting and indentation
Date: Tue, 14 May 2024 15:23:40 +0100
Message-Id: <69a34ba773dd14f59b6220587029a09dbba3e104.1715688057.git.fdmanana@suse.com>
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

Refactor btrfs_dio_submit_io() to avoid so much nesting and the need to
split long lines, making it a bit easier to read.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 52 +++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f04852e44123..c7f0239c3b68 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7869,6 +7869,8 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 	struct btrfs_dio_private *dip =
 		container_of(bbio, struct btrfs_dio_private, bbio);
 	struct btrfs_dio_data *dio_data = iter->private;
+	struct btrfs_ordered_extent *oe = dio_data->ordered;
+	int ret;
 
 	btrfs_bio_init(bbio, BTRFS_I(iter->inode)->root->fs_info,
 		       btrfs_dio_end_io, bio->bi_private);
@@ -7880,6 +7882,8 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 
 	dio_data->submitted += bio->bi_iter.bi_size;
 
+	if (!(iter->flags & IOMAP_WRITE))
+		goto submit_bio;
 	/*
 	 * Check if we are doing a partial write.  If we are, we need to split
 	 * the ordered extent to match the submitted bio.  Hang on to the
@@ -7887,37 +7891,31 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 	 * cancelled in iomap_end to avoid a deadlock wherein faulting the
 	 * remaining pages is blocked on the outstanding ordered extent.
 	 */
-	if (iter->flags & IOMAP_WRITE) {
-		struct btrfs_ordered_extent *oe = dio_data->ordered;
-		int ret;
-
-		ret = btrfs_extract_ordered_extent(bbio, oe);
-		if (ret) {
-			/*
-			 * If this is a COW write it means we created new extent
-			 * maps for the range and they point to an unwritten
-			 * location since we got an error and we don't submit
-			 * a bio. We must drop any extent maps within the range,
-			 * otherwise a fast fsync would log them and after a
-			 * crash and log replay we would have file extent items
-			 * that point to unwritten locations (garbage).
-			 */
-			if (!test_bit(BTRFS_ORDERED_NOCOW, &oe->flags)) {
-				const u64 start = oe->file_offset;
-				const u64 end = start + oe->num_bytes - 1;
+	ret = btrfs_extract_ordered_extent(bbio, oe);
+	if (!ret)
+		goto submit_bio;
 
-				btrfs_drop_extent_map_range(bbio->inode, start, end, false);
-			}
+	/*
+	 * If this is a COW write it means we created new extent maps for the
+	 * range and they point to an unwritten location since we got an error
+	 * and we don't submit a bio. We must drop any extent maps within the
+	 * range, otherwise a fast fsync would log them and after a crash and
+	 * log replay we would have file extent items that point to unwritten
+	 * locations (garbage).
+	 */
+	if (!test_bit(BTRFS_ORDERED_NOCOW, &oe->flags)) {
+		const u64 start = oe->file_offset;
+		const u64 end = start + oe->num_bytes - 1;
 
-			btrfs_finish_ordered_extent(oe, NULL,
-						    file_offset, dip->bytes,
-						    !ret);
-			bio->bi_status = errno_to_blk_status(ret);
-			iomap_dio_bio_end_io(bio);
-			return;
-		}
+		btrfs_drop_extent_map_range(bbio->inode, start, end, false);
 	}
 
+	btrfs_finish_ordered_extent(oe, NULL, file_offset, dip->bytes, false);
+	bio->bi_status = errno_to_blk_status(ret);
+	iomap_dio_bio_end_io(bio);
+	return;
+
+submit_bio:
 	btrfs_submit_bio(bbio, 0);
 }
 
-- 
2.43.0


