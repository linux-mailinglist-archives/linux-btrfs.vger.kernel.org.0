Return-Path: <linux-btrfs+bounces-18192-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58647C0247D
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A4A5504660
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B222749E6;
	Thu, 23 Oct 2025 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgVaZDuv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CD62737E0
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235210; cv=none; b=BIk4mIGKKPhi6+u/BkHq4s4aqeFWvsfOY3F0YxNppq3q/GCireds7UYVssEOqZIr2KM6OpzBPJF8OAvHWsBol4rI67/6bauV2gTOijFHVcVsnDEQ9QjYVhb9lx+4YF7gIgcuQy/tom+Lhl2lmCACidzULmGqQjxJ1Okb0gEWD70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235210; c=relaxed/simple;
	bh=54MCYZd5FGnkoFGbH+LybFCYB8DHW2jcbPsHh+jpf8I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZMxe6SxTtryPXkYWM9oU5ggFJ2YFRHwssyXP5b9ByBrWlmHgFb1g1P1gY2mJUTcYlXDP+vLoPK61udv1mqZjUJZ9DLYlHcC8MuQ2iKitPLpA07p5JiYMF6YDoZ6gWj0fiNRtiwJ+zA8prT5cMocQlY2Aux7FSLVNXL25pHapw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgVaZDuv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF29AC4CEFD
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235210;
	bh=54MCYZd5FGnkoFGbH+LybFCYB8DHW2jcbPsHh+jpf8I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SgVaZDuvTvznG/iPzyTpDWgKTxVbMTr+CbbBxtKnuNTkwN16jvFibDLWsRmQelSdg
	 /oukA3GNCq9LA1mRkNlIGiOtmDs9SXHWVnkmE05MZEbLv2oREhJQYmud/Vb3HvjBH9
	 /Qt2nrCbMc2T4fXuy/bPopnwcN6m5nK0UotKPOMtdmUR/koQyTiBIYSJn6ILRHYhyt
	 A5iHdFO1JXfT6E3q+s+cAMJb0pVZKqoXxf/2SV8/EdRuuwEW/9xoAESA4WitzH0Bjb
	 185RozeVses8ZABwE2TAf+ntWtW33bXFv3eg+a5LlN3NiaQ6qBctb3VOYQ4Ts6M2CJ
	 E4WwMkleQg9eQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 05/28] btrfs: avoid used space computation when reserving space
Date: Thu, 23 Oct 2025 16:59:38 +0100
Message-ID: <cad54f8feb7d97121bb4dd815de043fd73b0f392.1761234581.git.fdmanana@suse.com>
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

In __reserve_bytes() we have 3 repeated calls to btrfs_space_info_used(),
one early on as soon as take the space_info's spinlock, another one when
we call btrfs_can_overcommit(), which calls btrfs_space_info_used() again,
and a final one when we are reserving for a flush emergency.

During all these calls we are holding the space_info's spinlock, which is
heavily used by the space reservation and flushing code, so it's desirable
to make the critical sections as short as possible.

So make this more efficient by:

1) Instead of calling btrfs_can_overcommit() call the new variant
   can_overcommit() which takes the space_info's used space as an argument
   and pass the value we already computed and have in the 'used' variable;

2) Instead of calling btrfs_space_info_used() with its second argument as
   false when we are doing a flush emergency, decrement the space_info's
   bytes_may_use counter from the 'used' variable, as the difference
   between passing true or false as the second argument to
   btrfs_space_info_used() is whether or not to include the space_info's
   bytes_may_use counter in the computation.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index f5ff51680f41..6c2769044b55 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1783,7 +1783,7 @@ static int __reserve_bytes(struct btrfs_space_info *space_info, u64 orig_bytes,
 	 */
 	if (!pending_tickets &&
 	    ((used + orig_bytes <= space_info->total_bytes) ||
-	     btrfs_can_overcommit(space_info, orig_bytes, flush))) {
+	     can_overcommit(space_info, used, orig_bytes, flush))) {
 		btrfs_space_info_update_bytes_may_use(space_info, orig_bytes);
 		ret = 0;
 	}
@@ -1794,7 +1794,7 @@ static int __reserve_bytes(struct btrfs_space_info *space_info, u64 orig_bytes,
 	 * left to allocate for the block.
 	 */
 	if (ret && unlikely(flush == BTRFS_RESERVE_FLUSH_EMERGENCY)) {
-		used = btrfs_space_info_used(space_info, false);
+		used -= space_info->bytes_may_use;
 		if (used + orig_bytes <= space_info->total_bytes) {
 			btrfs_space_info_update_bytes_may_use(space_info, orig_bytes);
 			ret = 0;
-- 
2.47.2


