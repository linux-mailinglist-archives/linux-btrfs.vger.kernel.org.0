Return-Path: <linux-btrfs+bounces-18195-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C265C0248C
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94EA84FFF94
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FE427B354;
	Thu, 23 Oct 2025 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aX0nVtN0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C582798F3
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235213; cv=none; b=pqO6XAmxQ808FcBfjj5nJYeQq+TaSWEOPJsitWeWmtjTXuMqACfozRySRQrhrB/KEkun0I7AoLIM1xzko/29PjBqZEVsNIkqOCbygVAAmc0vaN9pCUmhlEbwx3unc9nt67mp5juSSCw2jegFElgU+i09LogrgKGP1OnSm7QBOos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235213; c=relaxed/simple;
	bh=fFzJ3PPzfVi6WvZxyx1mtppcsFgTJGR3QRS9xy2uf18=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGKiFKeHwjBJXHjCZwjSRkDssuULdURm6wSL8h1fywhzajzyLUYDm0oHZoQMNILT1MVkADB2yQ/JCs8sgCegnAP2WyNhTJXAh1sc+vyl5mnUDsF0LTF4hH9UWE4OFYuGxoFyARFF5B5/Je5MiUY61ejS7VFuG8f1OlMEWVO4ynk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aX0nVtN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11B5C4CEE7
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235213;
	bh=fFzJ3PPzfVi6WvZxyx1mtppcsFgTJGR3QRS9xy2uf18=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aX0nVtN0IojO3nxgXpE920pu1p++V51afLlIdZHgrAnSd+AvWDR6XSTxcFnKcBlQn
	 p44Gn/CxfJj8mceFQoWHjd7CI9ZChLcCr66zkuewUemizwCU4jJ6yU4ZvpzrLA4xli
	 GELx1oFck8NRsZ6onkQ+sAQkNiL/92Dc2AdKZfB7yblc+s+vrD4lnKqO4UK5MEf63x
	 M6y17M1BUApxDsOOjNcP0TO1CnWhWJd6Ma30pYvBhOxzPX8nJjbnK3xm3bZjoMW2EI
	 fcC5J+cKWop0loHXADA3Vf60Pjusje8KWLvE7eDWTROiNhcyx5vtegprlMCQU5euPB
	 Qe2fRutRczD/g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 08/28] btrfs: increment loop count outside critical section during metadata reclaim
Date: Thu, 23 Oct 2025 16:59:41 +0100
Message-ID: <826154558baaae6e1b1b58eb2920430664392e8a.1761234581.git.fdmanana@suse.com>
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

In btrfs_preempt_reclaim_metadata_space() there's no need to increment the
local variable that tracks the number of iterations of the while loop
while inside the critical section delimited by the space_info's spinlock.
That spinlock is heavily used by space reservation and flushing code, so
it's desirable to have its critical sections as short as possible.
So move the loop count incremented outside the critical section.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index bd206fc300e7..2dd9d4e5c2c2 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1264,8 +1264,6 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 		u64 to_reclaim, block_rsv_size;
 		const u64 global_rsv_size = btrfs_block_rsv_reserved(global_rsv);
 
-		loops++;
-
 		/*
 		 * We don't have a precise counter for the metadata being
 		 * reserved for delalloc, so we'll approximate it by subtracting
@@ -1311,6 +1309,8 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 
 		spin_unlock(&space_info->lock);
 
+		loops++;
+
 		/*
 		 * We don't want to reclaim everything, just a portion, so scale
 		 * down the to_reclaim by 1/4.  If it takes us down to 0,
-- 
2.47.2


