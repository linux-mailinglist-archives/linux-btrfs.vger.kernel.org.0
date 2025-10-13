Return-Path: <linux-btrfs+bounces-17721-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A342BD589A
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 19:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 057AD4E4BDB
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 17:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5E03090D6;
	Mon, 13 Oct 2025 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gM69koAU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476A4308F32
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377099; cv=none; b=mYqj4lUeSG18fdrIyEaPG8bFUYueryp2mw8A09Q4CYPSp+JeSEM5EvrkcbfPpHm/84a0fVzL65HolbfLpKj5RLtbvuxNzyvLJXGHBzYqqHXsNO6JdpkcETPrpwFiAgqb8IZd0i+O56f/xhJIxbImachR2+O8PTW/QZpG6sI0TIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377099; c=relaxed/simple;
	bh=dVQ81D/ul4a4oQSV3uKjUq3bC9tswoKT9drj/bmIYlY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTKOUNaAqWsLR+j78ZrhcnzOZLAvQ/HCcwdXRR8iUoufvnh51l3gyn81Qf73RUvmgKW0fWu9IrnSnxKkDQOSaLKWr8qaUZW7RM7WY+Qu/zaLKLxNqid4+dxqY8hASIAtxQOTXnguOcSrJpPFbwklB2maFTeTDS09n7pfz/TQCSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gM69koAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1CBC4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377098;
	bh=dVQ81D/ul4a4oQSV3uKjUq3bC9tswoKT9drj/bmIYlY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gM69koAUvCff0urFxAPnj7C2zKIc2pSVres40wSRZBxyc4Ms8ZbwQYAz41JI39JY5
	 ItktqiM33s870so3Q1VCuXymJoYPah66j3J1/ZPYqla1fg6V0j+3LZKwzxL5N2bZ7w
	 hAMgfu6t+ytwkXcqud7IVMUMUJSN6TfnqVeb3KAKsd0Kn00BTsSxTuOHZKzoEJ2L/H
	 n79rWUzlh5owGD2EaHFjv74qRw8qNsWUly8xEF67xz+yj27P/n51attkmkTS3YjAX7
	 BS4Yd7ORNZHzM1Lo9fWAPRuzvjEMPDwa7TNLu4VWzDWpXjV6mxSpdNKMN/oOmTB4h+
	 DjdA8NHFeEYsw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 04/16] btrfs: remove fs_info argument from maybe_fail_all_tickets()
Date: Mon, 13 Oct 2025 18:37:59 +0100
Message-ID: <bac374a61703df7de660f8ce7a63561cea9b62f9.1760376569.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1760376569.git.fdmanana@suse.com>
References: <cover.1760376569.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We don't need it since we can grab fs_info from the given space_info.
So remove the fs_info argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 73ee2c63f3ef..1a2566676284 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1071,7 +1071,6 @@ static bool steal_from_global_rsv(struct btrfs_fs_info *fs_info,
 /*
  * We've exhausted our flushing, start failing tickets.
  *
- * @fs_info - fs_info for this fs
  * @space_info - the space info we were flushing
  *
  * We call this when we've exhausted our flushing ability and haven't made
@@ -1084,9 +1083,9 @@ static bool steal_from_global_rsv(struct btrfs_fs_info *fs_info,
  * other tickets, or if it stumbles across a ticket that was smaller than the
  * first ticket.
  */
-static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
-				   struct btrfs_space_info *space_info)
+static bool maybe_fail_all_tickets(struct btrfs_space_info *space_info)
 {
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	struct reserve_ticket *ticket;
 	u64 tickets_id = space_info->tickets_id;
 	const bool aborted = BTRFS_FS_ERROR(fs_info);
@@ -1197,7 +1196,7 @@ static void do_async_reclaim_metadata_space(struct btrfs_space_info *space_info)
 		if (flush_state > final_state) {
 			commit_cycles++;
 			if (commit_cycles > 2) {
-				if (maybe_fail_all_tickets(fs_info, space_info)) {
+				if (maybe_fail_all_tickets(space_info)) {
 					flush_state = FLUSH_DELAYED_ITEMS_NR;
 					commit_cycles--;
 				} else {
@@ -1425,7 +1424,7 @@ static void do_async_reclaim_data_space(struct btrfs_space_info *space_info)
 
 		if (flush_state >= ARRAY_SIZE(data_flush_states)) {
 			if (space_info->full) {
-				if (maybe_fail_all_tickets(fs_info, space_info))
+				if (maybe_fail_all_tickets(space_info))
 					flush_state = 0;
 				else
 					space_info->flush = false;
@@ -1443,7 +1442,7 @@ static void do_async_reclaim_data_space(struct btrfs_space_info *space_info)
 	return;
 
 aborted_fs:
-	maybe_fail_all_tickets(fs_info, space_info);
+	maybe_fail_all_tickets(space_info);
 	space_info->flush = false;
 	spin_unlock(&space_info->lock);
 }
-- 
2.47.2


