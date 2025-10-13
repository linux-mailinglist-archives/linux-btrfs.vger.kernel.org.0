Return-Path: <linux-btrfs+bounces-17720-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19029BD58D3
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 19:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0463E7EA1
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 17:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301B7308F26;
	Mon, 13 Oct 2025 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCIT6OA0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEF2308F15
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377098; cv=none; b=sqwcsB57D9DcDPkmS1ndpf+fi9EqXf7ztMWIQCZhbId1xXBBXFKF9EIm9j+augvEK036nWZnEvKPucYBPyWuMS8CJFVCVO3TYqu7xODQQ8Q62Xc1Sj+CIIcTs/AQihVzQKIE0w3UINhqCxCtnts7cittauSdcsAMOrD01FLz4ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377098; c=relaxed/simple;
	bh=TCDQ95B0im558i5klunXaCyqDLplRmjmVTdsYtYk1Lo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2wbHqkd0phqxtBQw2SY8SFfwuNoHXI28723W9P0TQi7+IDPe/Sh4kpbBhuMWIi+OP0Z0nWdi8rpFSszPR3nSexcWLCYnX6rSW3hPUajRyogW5Q2LGg+JovM1tJBjMzJ14we6yK7P7bheexSY6yhlyaDdMLdQjy8ovwpM69Mu44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCIT6OA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715C6C116B1
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377097;
	bh=TCDQ95B0im558i5klunXaCyqDLplRmjmVTdsYtYk1Lo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bCIT6OA0aWIVzArIGqK6UoSCzjEYMOyfLxpkXa5iCIhL41/c0TCgFXTlrOoUUXRiy
	 ZoQtwv/3sYtMavh0B2v3oHHs0T+UeOOukSkzq9TyaivygPTPN1qBvETzmrg4E0G8xD
	 /dOwVnUTN8f5GxN4E/1Y/hhTPfV4g4rMlhq4Txng7T7j+WCfP00ErEFpt7Oe7vaFKf
	 DPjkcJaFA+LEEdaxzEAv6CgzgTgpkzbg9dea9XnW2RTCUtKgsgs50Hrg7762Oi1gSB
	 xFLYZCpEnuwHbg83kJgIvWJmeqMqh61XNttD7Gd+KhKRlcD5adw+gwSXH6OuINlUz4
	 7npfwQTq4bsAA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 03/16] btrfs: remove fs_info argument from priority_reclaim_metadata_space()
Date: Mon, 13 Oct 2025 18:37:58 +0100
Message-ID: <94fae30ce2172179947a2a19c5502cd537a0c619.1760376569.git.fdmanana@suse.com>
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
 fs/btrfs/space-info.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 403cfadd7f9d..73ee2c63f3ef 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1489,12 +1489,12 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 	RESET_ZONES,
 };
 
-static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
-				struct btrfs_space_info *space_info,
-				struct reserve_ticket *ticket,
-				const enum btrfs_flush_state *states,
-				int states_nr)
+static void priority_reclaim_metadata_space(struct btrfs_space_info *space_info,
+					    struct reserve_ticket *ticket,
+					    const enum btrfs_flush_state *states,
+					    int states_nr)
 {
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	u64 to_reclaim;
 	int flush_state = 0;
 
@@ -1638,12 +1638,12 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 		wait_reserve_ticket(space_info, ticket);
 		break;
 	case BTRFS_RESERVE_FLUSH_LIMIT:
-		priority_reclaim_metadata_space(fs_info, space_info, ticket,
+		priority_reclaim_metadata_space(space_info, ticket,
 						priority_flush_states,
 						ARRAY_SIZE(priority_flush_states));
 		break;
 	case BTRFS_RESERVE_FLUSH_EVICT:
-		priority_reclaim_metadata_space(fs_info, space_info, ticket,
+		priority_reclaim_metadata_space(space_info, ticket,
 						evict_flush_states,
 						ARRAY_SIZE(evict_flush_states));
 		break;
-- 
2.47.2


