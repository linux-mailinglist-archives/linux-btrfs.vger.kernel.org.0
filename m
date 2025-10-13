Return-Path: <linux-btrfs+bounces-17727-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A6DBD58DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 19:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3211C4030B1
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 17:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8118C3093C4;
	Mon, 13 Oct 2025 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mh2rr6Zy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F0C3093AE
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377104; cv=none; b=H0XPRMlcIu4XEJt8loxC0JTB+OSOM4z5rEY9I1gCgQdPa0RKnfIq8bobc7MZzXAMAb/K3ZVX8ZDGTsU0tzyPOYNoAPXhDTBAHiu7Feg3pBTn7CUCNVKEGFX76GUhP0JwIpjDGYcZeXZRI7hSm669gww7glHNIMaT17VTRCaHZrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377104; c=relaxed/simple;
	bh=UA4nPIkeq419lsILAjdl57EiMrJtCfj5W4SRoSKqAmY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bl2fq3i0JSzCV6hSVP2XGdoCM5kOcK7G5G5Q3fqAeb69kh1bqJ0m/cYRrdFaUX0Xkbh53VAi1cFBHSMCsFNmKAAl3zlyCPvFQYALx0R4SpnQIZyAdAzQQ1MllUStJm59Eqex00s3UUKu7dQKRBdiaieKwxzEOVBMgHBPxgiU5Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mh2rr6Zy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81EFC4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377104;
	bh=UA4nPIkeq419lsILAjdl57EiMrJtCfj5W4SRoSKqAmY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Mh2rr6ZyCZ3PxZoWcCVIpHbKFQypCWdM51ZbpKU4sKCKvaDM/Rm27vei/63/wyO1X
	 IFVBSStPWXQLTKJml+QHcA6eILf/d2JDFh+RGsP4MauKQ7SPjNjtBXQkkUF1tS0Pf5
	 7g8aJcc1xk9FeQA5Zm+Y7jwEHWL7NXfvRH2/0E6G8debKqXgfaLl3XIk+D/wfWN9bJ
	 30zhxQrgYWk3qoShxaQ5M+bkIG9nRlCuB4mLcHKGYSr1xeXgJI3qKV+7dqnmhtgpYS
	 RhTkN9mbGc32O909W/k3EOZpNo8ht4F60ySRanS9sItgCAz7Vq+HOPexmri8y0BAp7
	 bqXDaJ3SR0Erg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 10/16] btrfs: remove fs_info argument from need_preemptive_reclaim()
Date: Mon, 13 Oct 2025 18:38:05 +0100
Message-ID: <f44e1c190e4774c968729efd730a8a0715dc4ba8.1760376569.git.fdmanana@suse.com>
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
 fs/btrfs/space-info.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 0f619a588eb3..4249faa94116 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -920,9 +920,9 @@ static u64 btrfs_calc_reclaim_metadata_size(const struct btrfs_space_info *space
 	return to_reclaim;
 }
 
-static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
-				    const struct btrfs_space_info *space_info)
+static bool need_preemptive_reclaim(const struct btrfs_space_info *space_info)
 {
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	const u64 global_rsv_size = btrfs_block_rsv_reserved(&fs_info->global_block_rsv);
 	u64 ordered, delalloc;
 	u64 thresh;
@@ -1249,7 +1249,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 	trans_rsv = &fs_info->trans_block_rsv;
 
 	spin_lock(&space_info->lock);
-	while (need_preemptive_reclaim(fs_info, space_info)) {
+	while (need_preemptive_reclaim(space_info)) {
 		enum btrfs_flush_state flush;
 		u64 delalloc_size = 0;
 		u64 to_reclaim, block_rsv_size;
@@ -1834,7 +1834,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		 */
 		if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags) &&
 		    !work_busy(&fs_info->preempt_reclaim_work) &&
-		    need_preemptive_reclaim(fs_info, space_info)) {
+		    need_preemptive_reclaim(space_info)) {
 			trace_btrfs_trigger_flush(fs_info, space_info->flags,
 						  orig_bytes, flush, "preempt");
 			queue_work(system_unbound_wq,
-- 
2.47.2


