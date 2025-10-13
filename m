Return-Path: <linux-btrfs+bounces-17730-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B43BD58E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 19:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689FA403F70
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 17:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5934B309DC0;
	Mon, 13 Oct 2025 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAw4qKRa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991F2308F1E
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377107; cv=none; b=g0jbFEqztwywM9tg3lVoV3P4/lOMIBlHWuIdD5NUL4w5fzuqK5lgC1fffGI3e7BGopyzaF2e5JGvjwgiUuCfAbA5jxrhw+Gk2vdGBkP373wQuX5j8i5OycrbG1373Y7obx99y6fplPkmvyRm3LgRSqj6l8zIFRau+N0LLdV5GcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377107; c=relaxed/simple;
	bh=MV7ZRxGLJ5wHuxehAzo+BllKB/nqfb3CDJ3mOc7yebQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTDdpcYmbHTgp46WsTC2bvXbnogUxMOk6xcylmO/tOseU6ypysi06QLOa8RXAPkAjwlQMsXmMyxyjM4WcyyFaCf+2unZfaxoFlj4KVh67oZQSAUXze9GBeX8qsEMad+b4pLJUw/QMzyE8XX5qu6OzFi8ygZEi2CqZqLLXIMJ6EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAw4qKRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BA5C116B1
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377105;
	bh=MV7ZRxGLJ5wHuxehAzo+BllKB/nqfb3CDJ3mOc7yebQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KAw4qKRa0DjYZJDH7Bx1cjgsywrCE3j9T+oQoDBJmwExRYtR6IIDvIDkZWvX0f48L
	 RDQQ8buFN3+X9rVrkxmpBiY9J0p0vub67owidr4yQjyzBzGCKnL5VDTPd2qAZVt6Gm
	 E1F2DVvDglCIIxb2M2PVrqKe+Z0QLT2INmf4EsEQttS3ttWib+fxDdd1Kf3/CZITEV
	 +JCmok+Nw7CvutFf/e/47FBb6yuYIgI9skHIHIki6aYAB0nfHVhGe46S4NJq+Y7yPG
	 6iU9KJshHS7zCoa1g2jNUVvOYlCdXzsLITgo4bfkCE4/8koGGB4SEi+y8GtswLdjyF
	 Z1X5ys48J319A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 11/16] btrfs: remove fs_info argument from steal_from_global_rsv()
Date: Mon, 13 Oct 2025 18:38:06 +0100
Message-ID: <0474fc3cc1da20783d6472906f8221fb983d57fc.1760376569.git.fdmanana@suse.com>
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
index 4249faa94116..5c17f5234ef5 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1031,10 +1031,10 @@ static bool need_preemptive_reclaim(const struct btrfs_space_info *space_info)
 		!test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state));
 }
 
-static bool steal_from_global_rsv(struct btrfs_fs_info *fs_info,
-				  struct btrfs_space_info *space_info,
+static bool steal_from_global_rsv(struct btrfs_space_info *space_info,
 				  struct reserve_ticket *ticket)
 {
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	u64 min_bytes;
 
@@ -1096,7 +1096,7 @@ static bool maybe_fail_all_tickets(struct btrfs_space_info *space_info)
 		ticket = list_first_entry(&space_info->tickets,
 					  struct reserve_ticket, list);
 
-		if (!aborted && steal_from_global_rsv(fs_info, space_info, ticket))
+		if (!aborted && steal_from_global_rsv(space_info, ticket))
 			return true;
 
 		if (!aborted && btrfs_test_opt(fs_info, ENOSPC_DEBUG))
@@ -1525,7 +1525,7 @@ static void priority_reclaim_metadata_space(struct btrfs_space_info *space_info,
 	if (BTRFS_FS_ERROR(fs_info)) {
 		ticket->error = BTRFS_FS_ERROR(fs_info);
 		remove_ticket(space_info, ticket);
-	} else if (!steal_from_global_rsv(fs_info, space_info, ticket)) {
+	} else if (!steal_from_global_rsv(space_info, ticket)) {
 		ticket->error = -ENOSPC;
 		remove_ticket(space_info, ticket);
 	}
-- 
2.47.2


