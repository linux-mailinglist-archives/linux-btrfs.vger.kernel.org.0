Return-Path: <linux-btrfs+bounces-2076-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DC1847528
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 17:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B951F2C0FB
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 16:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08961487D6;
	Fri,  2 Feb 2024 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrPZFJjM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAD4148309
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892157; cv=none; b=AwbuNr7onbWpRRK12BDrrXWzWpq9NY3kcUPQ28FbW567o1Objureebs0PT/+z59EzUmT85dPBog4TzAFdV3ViB13R78H6a+YkFsq4+r2dPuJlvSb+l3fYhrGgvmLkObKGxQavI/Sc9QNuuH8L5w5JrWvQVEMcuDmX07AZ/OWVF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892157; c=relaxed/simple;
	bh=YKCKMxVFHMIPuu2bJjH9MEmdIGbKecLfMqM1qpjtGEw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=sxgiSXVs+OWQeIkXKPgiEBAsS3IEYA8bCB3lG799PZMmeP6He+Vg3krJyF21DGLI6UyCqaGgSkQrj/j8qqRkFiL6uXaaF4pM1POq466Slfx6cp17t+fbi15/k9tAxByp+keBnxIi3nonjyUB7lvtmgogzU6wqxcMjdjlwzubKBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrPZFJjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E3FC433F1
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 16:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706892157;
	bh=YKCKMxVFHMIPuu2bJjH9MEmdIGbKecLfMqM1qpjtGEw=;
	h=From:To:Subject:Date:From;
	b=TrPZFJjM2CyyaNqILs2FmsXK5z7e92832Z6j3V6nRjxWwzJYiBTTCuoq2Kv20PlTa
	 PysvDqke2NNqjglvzHVvL/cflaI6kg7LNzhWTZRpSXrCYo3kU2Ng0Emz/qMzVi3xLR
	 G1YCAGStn16Bsq3359tj0sOIS2acZ8i4d4cbOZoaIps2tjee7L9gKWVG2jMcQXY1T0
	 ztzHxzHk2WoWWNeZQcT0z+5SeO9bHX/WSokAoeK12KrHycFkVK8iD1EfSG+bilpREI
	 1WZKEfVX6W2MzT1Q4mpS4L3BiX2zKzcBHV0IbBg2hYZRQSFQjeBUnOTMdCCgzvZJDo
	 aAeeGV1ZX9eig==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: don't refill whole delayed refs block reserve when starting transaction
Date: Fri,  2 Feb 2024 16:42:32 +0000
Message-Id: <eba624e8cef9a1e84c9e1ba0c8f32347aa487e63.1706892030.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Since commit 28270e25c69a ("btrfs: always reserve space for delayed refs
when starting transaction") we started not only to reserve metadata space
for the delayed refs a caller of btrfs_start_transaction() might generate
but also to try to fully refill the delayed refs block reserve, because
there are several case where we generate delayed refs and haven't reserved
space for them, relying on the global block reserve. Relying too much on
the global block reserve is not always safe, and can result in hitting
-ENOSPC during transaction commits or worst, in rare cases, being unable
to mount a filesystem that needs to do orphan cleanup or anything that
requires modifying the filesystem during mount, and has no more
unallocated space and the metadata space is nearly full. This was
explained in detail in that commit's change log.

However the gap between the reserved amount and the size of the delayed
refs block reserve can be huge, so attempting to reserve space for such
a gap can result in allocating many metadata block groups that end up
not being used. After a recent patch, with the subject:

  "btrfs: add new unused block groups to the list of unused block groups"

We started to add new block groups that are unused to the list of unused
block groups, to avoid having them around for a very long time in case
they are never used, because a block group is only added to the list of
unused block groups when we deallocate the last extent or when mounting
the filesystem and the block group has 0 bytes used. This is not a problem
introduced by the commit mentioned earlier, it always existed as our
metadata space reservations are, most of the time, pessimistic and end up
not using all the space they reserved, so we can occasionally end up with
one or two unused metadata block groups for a long period. However after
that commit mentioned earlier, we are just more pessimistic in the
metadata space reservations when starting a transaction and therefore the
issue is more likely to happen.

This however is not always enough because we might create unused metadata
block groups when reserving metadata space at a high rate if there's
always a gap in the delayed refs block reserve and the cleaner kthread
isn't triggered often enough or is busy with other work (running delayed
iputs, cleaning deleted roots, etc), not to mention the block group's
allocated space is only usable for a new block group after the transaction
used to remove it is committed.

A user reported that he's getting a lot of allocated metadata block groups
but the usage percentage of metadata space was very low compared to the
total allocated space, specially after running a series of block group
relocations.

So for now stop trying to refill the gap in the delayed refs block reserve
and reserve space only for the delayed refs we are expected to generate
when starting a transaction.

CC: stable@vger.kernel.org # 6.7+
Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
Link: https://lore.kernel.org/linux-btrfs/9cdbf0ca9cdda1b4c84e15e548af7d7f9f926382.camel@intelfx.name/
Link: https://lore.kernel.org/linux-btrfs/CAL3q7H6802ayLHUJFztzZAVzBLJAGdFx=6FHNNy87+obZXXZpQ@mail.gmail.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 38 ++------------------------------------
 1 file changed, 2 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 70d7abd1f772..3575b2bf3042 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -562,56 +562,22 @@ static int btrfs_reserve_trans_metadata(struct btrfs_fs_info *fs_info,
 					u64 num_bytes,
 					u64 *delayed_refs_bytes)
 {
-	struct btrfs_block_rsv *delayed_refs_rsv = &fs_info->delayed_refs_rsv;
 	struct btrfs_space_info *si = fs_info->trans_block_rsv.space_info;
-	u64 extra_delayed_refs_bytes = 0;
-	u64 bytes;
+	u64 bytes = num_bytes + *delayed_refs_bytes;
 	int ret;
 
-	/*
-	 * If there's a gap between the size of the delayed refs reserve and
-	 * its reserved space, than some tasks have added delayed refs or bumped
-	 * its size otherwise (due to block group creation or removal, or block
-	 * group item update). Also try to allocate that gap in order to prevent
-	 * using (and possibly abusing) the global reserve when committing the
-	 * transaction.
-	 */
-	if (flush == BTRFS_RESERVE_FLUSH_ALL &&
-	    !btrfs_block_rsv_full(delayed_refs_rsv)) {
-		spin_lock(&delayed_refs_rsv->lock);
-		if (delayed_refs_rsv->size > delayed_refs_rsv->reserved)
-			extra_delayed_refs_bytes = delayed_refs_rsv->size -
-				delayed_refs_rsv->reserved;
-		spin_unlock(&delayed_refs_rsv->lock);
-	}
-
-	bytes = num_bytes + *delayed_refs_bytes + extra_delayed_refs_bytes;
-
 	/*
 	 * We want to reserve all the bytes we may need all at once, so we only
 	 * do 1 enospc flushing cycle per transaction start.
 	 */
 	ret = btrfs_reserve_metadata_bytes(fs_info, si, bytes, flush);
-	if (ret == 0) {
-		if (extra_delayed_refs_bytes > 0)
-			btrfs_migrate_to_delayed_refs_rsv(fs_info,
-							  extra_delayed_refs_bytes);
-		return 0;
-	}
-
-	if (extra_delayed_refs_bytes > 0) {
-		bytes -= extra_delayed_refs_bytes;
-		ret = btrfs_reserve_metadata_bytes(fs_info, si, bytes, flush);
-		if (ret == 0)
-			return 0;
-	}
 
 	/*
 	 * If we are an emergency flush, which can steal from the global block
 	 * reserve, then attempt to not reserve space for the delayed refs, as
 	 * we will consume space for them from the global block reserve.
 	 */
-	if (flush == BTRFS_RESERVE_FLUSH_ALL_STEAL) {
+	if (ret && flush == BTRFS_RESERVE_FLUSH_ALL_STEAL) {
 		bytes -= *delayed_refs_bytes;
 		*delayed_refs_bytes = 0;
 		ret = btrfs_reserve_metadata_bytes(fs_info, si, bytes, flush);
-- 
2.40.1


