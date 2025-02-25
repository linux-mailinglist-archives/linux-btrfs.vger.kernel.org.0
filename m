Return-Path: <linux-btrfs+bounces-11763-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EDAA43C6B
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 11:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1031620D1
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 10:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A4826772F;
	Tue, 25 Feb 2025 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DP2AwMv3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272F9267B97
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481037; cv=none; b=IKrbtYeMDmik8VN0bpkov/+Med/mqlMcnGuqOWxgNvYxZS32s+H92KXRwttNOGd/Nyzxv57JaZKeLkdCXB0ABsWb2oz7pVHQyC7HmrgDnLZwFeGY75sodaCdMBve4Mq1ApTjX5lGIRn49gePsF+O+4pxgr1uf7TKcsZAuAxLVF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481037; c=relaxed/simple;
	bh=nvmRoddYwCo9VnpYjEOMMVhKKNithGCmf3o/eCXIyb4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nQNoNJZpV0FiytjJv1yEPP+A9WEO0l9nZXH3A1fxb+PW+djHp/7s7brzHdSzSkldVGadORjz4vleBwfmdvTuYeeXpPVc4WJpnfZzQwKgeNDzi2uX7RtP/oVFpbRd23uVVQmixgyYPUFGA7CP1sHPVOx5U/S9/OTn/9E1SZkIea8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DP2AwMv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F791C4AF09
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 10:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740481036;
	bh=nvmRoddYwCo9VnpYjEOMMVhKKNithGCmf3o/eCXIyb4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DP2AwMv3n407U7Ju/QG7CjwIRB/J9YkiYXzZ6vK4QKttCC41GETJJ/5q2znzGyliv
	 QwCsBqYz+fPSDSHJFLBIuDezhM8A7azuDNB1khyIUSHhMk7yTaHWalwamNlDx9qr+Z
	 ebQuAM7F0zM668LoSYUsD75R9iWQ21NN+7SrOC/0T7GiMgDU4Esx4BOcM/Uh1XaTWY
	 r6M+2LujKB7hvRw34wE7YWPXtz7PzxuwWxGGRgUIYWjn4YGoPd5VcikyqXIXP6Hpe6
	 Pz+xIChAT1lxwXn0Hs30sDzIrEOuGsMFHWYgEyIkZEtY1dvdmy6gKLq+3r7BQ7KbIR
	 fhs3JTbNOI3cA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: fix reclaimed bytes accounting after automatic block group reclaim
Date: Tue, 25 Feb 2025 10:57:09 +0000
Message-Id: <1890b9fc004d4c889f5b8b10a61ccc1395ded318.1740427964.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740427964.git.fdmanana@suse.com>
References: <cover.1740427964.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We are considering the used bytes counter of a block group as the amount
to update the space info's reclaim bytes counter after relocating the
block group, but this value alone is often not enough. This is because we
may have a reserved extent (or more) and in that case its size is
reflected in the reserved counter of the block group - the size of the
extent is only transferred from the reserved counter to the used counter
of the block group when the delayed ref for the extent is run - typically
when committing the transaction (or when flushing delayed refs due to
ENOSPC on space reservation). Such call chain for data extents is:

   btrfs_run_delayed_refs_for_head()
       run_one_delayed_ref()
           run_delayed_data_ref()
               alloc_reserved_file_extent()
                   alloc_reserved_extent()
                       btrfs_update_block_group()
                          -> transfers the extent size from the reserved
                             counter to the used counter

For metadata extents:

   btrfs_run_delayed_refs_for_head()
       run_one_delayed_ref()
           run_delayed_tree_ref()
               alloc_reserved_tree_block()
                   alloc_reserved_extent()
                       btrfs_update_block_group()
                           -> transfers the extent size from the reserved
                              counter to the used counter

Since relocation flushes delalloc, waits for ordered extent completion
and commits the current transaction before doing the actual relocation
work, the correct amount of reclaimed space is therefore the sum of the
"used" and "reserved" counters of the block group before we call
btrfs_relocate_chunk() at btrfs_reclaim_bgs_work().

So fix this by taking the "reserved" counter into consideration.

Fixes: 243192b67649 ("btrfs: report reclaim stats in sysfs")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 1200c5efeb3d..c0c247ecbe9a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1824,6 +1824,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	while (!list_empty(&fs_info->reclaim_bgs)) {
 		u64 zone_unusable;
 		u64 used;
+		u64 reserved;
 		int ret = 0;
 
 		bg = list_first_entry(&fs_info->reclaim_bgs,
@@ -1920,21 +1921,32 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 			goto next;
 
 		/*
-		 * Grab the used bytes counter while holding the block groups's
-		 * spinlock to prevent races with tasks concurrently updating it
-		 * due to extent allocation and deallocation (running
-		 * btrfs_update_block_group()) - we have set the block group to
-		 * RO but that only prevents extent reservation, allocation
-		 * happens after reservation.
+		 * The amount of bytes reclaimed corresponds to the sum of the
+		 * "used" and "reserved" counters. We have set the block group
+		 * to RO above, which prevents reservations from happening but
+		 * we may have existing reservations for which allocation has
+		 * not yet been done - btrfs_update_block_group() was not yet
+		 * called, which is where we will transfer a reserved extent's
+		 * size from the "reserved" counter to the "used" counter - this
+		 * happens when running delayed references. When we relocate the
+		 * chunk below, relocation first flushes dellaloc, waits for
+		 * ordered extent completion (which is where we create delayed
+		 * references for data extents) and commits the current
+		 * transaction (which runs delayed references), and only after
+		 * it does the actual work to move extents out of the block
+		 * group. So the reported amount of reclaimed bytes is
+		 * effectively the sum of the 'used' and 'reserved' counters.
 		 */
 		spin_lock(&bg->lock);
 		used = bg->used;
+		reserved = bg->reserved;
 		spin_unlock(&bg->lock);
 
 		btrfs_info(fs_info,
-			"reclaiming chunk %llu with %llu%% used %llu%% unusable",
+	"reclaiming chunk %llu with %llu%% used %llu%% reserved %llu%% unusable",
 				bg->start,
 				div64_u64(used * 100, bg->length),
+				div64_u64(reserved * 100, bg->length),
 				div64_u64(zone_unusable * 100, bg->length));
 		trace_btrfs_reclaim_block_group(bg);
 		ret = btrfs_relocate_chunk(fs_info, bg->start);
@@ -1943,6 +1955,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 			btrfs_err(fs_info, "error relocating chunk %llu",
 				  bg->start);
 			used = 0;
+			reserved = 0;
 			spin_lock(&space_info->lock);
 			space_info->reclaim_errors++;
 			if (READ_ONCE(space_info->periodic_reclaim))
@@ -1952,6 +1965,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		spin_lock(&space_info->lock);
 		space_info->reclaim_count++;
 		space_info->reclaim_bytes += used;
+		space_info->reclaim_bytes += reserved;
 		spin_unlock(&space_info->lock);
 
 next:
-- 
2.45.2


