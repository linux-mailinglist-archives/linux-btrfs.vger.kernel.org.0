Return-Path: <linux-btrfs+bounces-18196-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED89AC02477
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922CE3A9AE7
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FA3285041;
	Thu, 23 Oct 2025 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wwi/FhRm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4391A274FDC
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235214; cv=none; b=TJr0wVKkeUh+9CVt87gl1G2cc43ea0wpiiqiG463Rdr3Hsm9joBxfh3x4tP/U+TDFkGawufeVCgf89hqRu037vVltp8TnaV64RKsZLns1AcDoihxFb6d03SmFR8UIv36IkPCqmAKovIFRovYA3k4sgTnXpARn5P+d2vP1J+jS5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235214; c=relaxed/simple;
	bh=xSxefI/ESMltLA8oCF1ZmadYO5gXj8WOAzLgWj66kcA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRvEbBMtw7Po2o8/TANDbcjxhgywZLAKadtM7wgkdtQAD0DVhM8/+GDFwZ164YD2fT8piye385ben1tHy/3ADXe6ALhVwU30o8EXkye4TU9q94BX0MA6AhpJrdXkjyBQtY7XQgmUEfgmAG4FFPt9xysjd4zL5ciAqDBLSxxLLE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wwi/FhRm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F01C4CEFF
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235214;
	bh=xSxefI/ESMltLA8oCF1ZmadYO5gXj8WOAzLgWj66kcA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Wwi/FhRmhProRnt+JHEDfQSPi+0882xp1YUMQh9QHDb45fZL2/j+PPIESEyGw6qXJ
	 3QV68GotEPajN+41LpSMDdnJVPBtLDz+PMdeac2cRaYHVBMaZUZ5yjfLmwXN4o8F2k
	 UDjmKGNFNpugbC15Sz52mX15jt93f+/0Z6WwZP8TCuNuSvAwAY1OtIl7W2vn0Mjswo
	 SYhYMaPqal5HL/GDd01gTfnGhefmOWt5kqo6DdlYK2nyJHHxMAlBCsFLfkgMT39QbE
	 DX7Zkvc3sE+vX4yk+hcq8/cj1pIXs0/8lPP7HWzM/hxLsr2lG1EXHwMNyloe6k3T6G
	 VIFkego3h9Kkw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 09/28] btrfs: shorten critical section in btrfs_preempt_reclaim_metadata_space()
Date: Thu, 23 Oct 2025 16:59:42 +0100
Message-ID: <5b51afbff085c633c22d837cc956fd9d88b4e246.1761234581.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1761234580.git.fdmanana@suse.com>
References: <cover.1761234580.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We are doing a lot of small calculations and assignments while holding the
space_info's spinlock, which is a heavily used lock for space reservation
and flushing. There's no point in holding the lock for so long when all we
want is to call need_preemptive_reclaim() and get a consistent value for a
couple of counters from the space_info. Instead, grab the counters into
local variables, release the lock and then use the local variables.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 2dd9d4e5c2c2..9a072009eec8 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1263,7 +1263,10 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 		u64 delalloc_size = 0;
 		u64 to_reclaim, block_rsv_size;
 		const u64 global_rsv_size = btrfs_block_rsv_reserved(global_rsv);
+		const u64 bytes_may_use = space_info->bytes_may_use;
+		const u64 bytes_pinned = space_info->bytes_pinned;
 
+		spin_unlock(&space_info->lock);
 		/*
 		 * We don't have a precise counter for the metadata being
 		 * reserved for delalloc, so we'll approximate it by subtracting
@@ -1275,8 +1278,8 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 			btrfs_block_rsv_reserved(delayed_block_rsv) +
 			btrfs_block_rsv_reserved(delayed_refs_rsv) +
 			btrfs_block_rsv_reserved(trans_rsv);
-		if (block_rsv_size < space_info->bytes_may_use)
-			delalloc_size = space_info->bytes_may_use - block_rsv_size;
+		if (block_rsv_size < bytes_may_use)
+			delalloc_size = bytes_may_use - block_rsv_size;
 
 		/*
 		 * We don't want to include the global_rsv in our calculation,
@@ -1293,10 +1296,10 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 		if (delalloc_size > block_rsv_size) {
 			to_reclaim = delalloc_size;
 			flush = FLUSH_DELALLOC;
-		} else if (space_info->bytes_pinned >
+		} else if (bytes_pinned >
 			   (btrfs_block_rsv_reserved(delayed_block_rsv) +
 			    btrfs_block_rsv_reserved(delayed_refs_rsv))) {
-			to_reclaim = space_info->bytes_pinned;
+			to_reclaim = bytes_pinned;
 			flush = COMMIT_TRANS;
 		} else if (btrfs_block_rsv_reserved(delayed_block_rsv) >
 			   btrfs_block_rsv_reserved(delayed_refs_rsv)) {
@@ -1307,8 +1310,6 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 			flush = FLUSH_DELAYED_REFS_NR;
 		}
 
-		spin_unlock(&space_info->lock);
-
 		loops++;
 
 		/*
-- 
2.47.2


