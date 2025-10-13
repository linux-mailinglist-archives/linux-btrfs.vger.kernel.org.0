Return-Path: <linux-btrfs+bounces-17719-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F1CBD5897
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 19:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 42B5C3433E9
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 17:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327B2308F0A;
	Mon, 13 Oct 2025 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWL4oZ//"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775E63081D1
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377097; cv=none; b=IEiLGy7ExPumzkzXxQHEgGCkT2QxmiRyyl6YDFb8luW6mPnU8IBblWdVrtQkGKWagqWRyU+1Ted2DyLH7j3wVXhNDdRKmNVMCXDMVn3Y/rRisRQ8KhtisPrAmkKiOF4IZW/+CPpupSfafLgPZEZQzohL/+rhjbsUnPuPpWqL7rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377097; c=relaxed/simple;
	bh=3UPaKq39aFrBDp0AwiJR9NI3bwjBO5L+VtfWr247Rgs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0v2Hqfzs7HPCIfWAbQWhUyXFT8aJgS9RsdvXEQhCeJ0pJRxDpL1MccVrIwxOu+r8Qb4TnEDFCWvTnBkWfvd8EjmQIqkTHEIOxw9FOIpuKYqX4j2AuQptV2KO2okipW7yifKTVIw7bChRFovSPLLXnhF+/GrQrX3wUBsDskdfM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWL4oZ//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C31C4CEFE
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377097;
	bh=3UPaKq39aFrBDp0AwiJR9NI3bwjBO5L+VtfWr247Rgs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XWL4oZ//96xO4Fo+IpGS0ftFzGGav77oqNU6+FO2U5P3i0EF+5oNHYCIJTLWYkAwr
	 09dFOL+jrN7mMMHJKEaZuE/n468RMRsk2sJ1Nd51WMOX0URfyFV7eYulh4VvNPUbAB
	 2bmxo4V678yb9DZMs6dfmF34vS9FCPjetuuottUQsfv8JLHZQDACSNirtDS+36i3zC
	 U9/swnEhSRQ5yo0WRDTRnZX6DWXkhSsaXgz77CMLHlVbmpHJ0NuaQQWEJc7nAOeHIM
	 ZCWeP0moWQRn7/2dd+IO2ZiMKfiLFGMq4disY9VG7lUXjb9D+t/Aw/DV3tb4Rv4Ipo
	 FU7igmGurtr/g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 02/16] btrfs: remove fs_info argument from priority_reclaim_data_space()
Date: Mon, 13 Oct 2025 18:37:57 +0100
Message-ID: <e46a3538188a00e0437e8db73575917d36faa5a0.1760376569.git.fdmanana@suse.com>
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
 fs/btrfs/space-info.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 50c7c240bb51..403cfadd7f9d 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1548,10 +1548,11 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 	spin_unlock(&space_info->lock);
 }
 
-static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
-					struct btrfs_space_info *space_info,
+static void priority_reclaim_data_space(struct btrfs_space_info *space_info,
 					struct reserve_ticket *ticket)
 {
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
+
 	spin_lock(&space_info->lock);
 
 	/* We could have been granted before we got here. */
@@ -1647,7 +1648,7 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 						ARRAY_SIZE(evict_flush_states));
 		break;
 	case BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE:
-		priority_reclaim_data_space(fs_info, space_info, ticket);
+		priority_reclaim_data_space(space_info, ticket);
 		break;
 	default:
 		ASSERT(0);
-- 
2.47.2


