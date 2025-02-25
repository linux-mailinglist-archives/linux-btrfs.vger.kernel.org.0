Return-Path: <linux-btrfs+bounces-11762-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E11A43C6E
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 11:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC1F161A14
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 10:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F19267F4D;
	Tue, 25 Feb 2025 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WibkTWfs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27297267B95
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481037; cv=none; b=SjpPY0PL2ka5pb/0pIJ8Qer9GH0P2F0gXA4YYzRT/egg27WXrrsAWCGAkxZqaKR+xiAjETah9JLPU8IrOJau+/FsamSpgn8CbmtFYM6UUlD2HVLrBRJ63mcZF1rFUKBCepOYRvw6jk2A5/BUb6XXA0LqKg0y06Tv4/MdTdLmLJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481037; c=relaxed/simple;
	bh=X5P0Y2CBY6pwJ6RBDUxBbkURSWw55q0QZ35SxpAX2b8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h0FbcjsFQ2TjYq6cnhDN1VhzvTLgmLFsLCPNmAPbHdkID2kE02JdR5IGu1ijMX2bbHjgcaRfCNdbJq8tVUXRITkECDKPhArjZOp1RywTqFNPpA9Tc+4GjgeF1ikL+H5pE8pVcodTCX7VeTzkFfEBxonEodFyrhFyFaAdLHpBA8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WibkTWfs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19068C4CEE9
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 10:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740481035;
	bh=X5P0Y2CBY6pwJ6RBDUxBbkURSWw55q0QZ35SxpAX2b8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WibkTWfsS5uL1kN7OMKJSPnZpqZGX0/CvlNu9CNNXkMJ7IBNp+fDH0ykgez5U717d
	 NUqRG6lEgfGCpILvdv+LADI6hKYLB8hy8xEqGO4JZLlOYCWRyugAnKIn2POTdMBbTh
	 kNoeCtOFQg5szBE9hzFGX7p05GFDPfCo0MPJBuEoZsvAJBZ86WgBRnBFXhVvJwRN6U
	 N+c0K2qVO+WEF8FCLiojIA+Ca2dGrPD0GhCJie8+A7MxCnF9QpB4MW7fTfNNZZLnea
	 mNXir85IJYfnMxBkpGI+8U+JW9d0owTz3R0Lz0ydCI4oz0lNKvEJmwgDpyPd88Mtai
	 t9FXfuBHG20LQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: get used bytes while holding lock at btrfs_reclaim_bgs_work()
Date: Tue, 25 Feb 2025 10:57:08 +0000
Message-Id: <e56294d5e3797b3946909f23657c667cda54de4f.1740427964.git.fdmanana@suse.com>
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

At btrfs_reclaim_bgs_work(), we are grabbing twice the used bytes counter
of the block group while not holding the block group's spinlock. This can
result in races, reported by KCSAN and similar tools, since a concurrent
task can be updating that counter while at btrfs_update_block_group().

So avoid these races by grabbing the counter in the critical section right
above that is delimited by the block group's spinlock. This also avoids
using two different values of the counter in case it changes in between
each read. This silences KCSAN and is required for the next patch in the
series too.

Fixes: 243192b67649 ("btrfs: report reclaim stats in sysfs")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 2e174c14ca0a..1200c5efeb3d 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1823,7 +1823,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	list_sort(NULL, &fs_info->reclaim_bgs, reclaim_bgs_cmp);
 	while (!list_empty(&fs_info->reclaim_bgs)) {
 		u64 zone_unusable;
-		u64 reclaimed;
+		u64 used;
 		int ret = 0;
 
 		bg = list_first_entry(&fs_info->reclaim_bgs,
@@ -1919,19 +1919,30 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		if (ret < 0)
 			goto next;
 
+		/*
+		 * Grab the used bytes counter while holding the block groups's
+		 * spinlock to prevent races with tasks concurrently updating it
+		 * due to extent allocation and deallocation (running
+		 * btrfs_update_block_group()) - we have set the block group to
+		 * RO but that only prevents extent reservation, allocation
+		 * happens after reservation.
+		 */
+		spin_lock(&bg->lock);
+		used = bg->used;
+		spin_unlock(&bg->lock);
+
 		btrfs_info(fs_info,
 			"reclaiming chunk %llu with %llu%% used %llu%% unusable",
 				bg->start,
-				div64_u64(bg->used * 100, bg->length),
+				div64_u64(used * 100, bg->length),
 				div64_u64(zone_unusable * 100, bg->length));
 		trace_btrfs_reclaim_block_group(bg);
-		reclaimed = bg->used;
 		ret = btrfs_relocate_chunk(fs_info, bg->start);
 		if (ret) {
 			btrfs_dec_block_group_ro(bg);
 			btrfs_err(fs_info, "error relocating chunk %llu",
 				  bg->start);
-			reclaimed = 0;
+			used = 0;
 			spin_lock(&space_info->lock);
 			space_info->reclaim_errors++;
 			if (READ_ONCE(space_info->periodic_reclaim))
@@ -1940,7 +1951,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		}
 		spin_lock(&space_info->lock);
 		space_info->reclaim_count++;
-		space_info->reclaim_bytes += reclaimed;
+		space_info->reclaim_bytes += used;
 		spin_unlock(&space_info->lock);
 
 next:
-- 
2.45.2


