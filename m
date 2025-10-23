Return-Path: <linux-btrfs+bounces-18190-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C86FC0246B
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8003A88CD
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39FE2727F8;
	Thu, 23 Oct 2025 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDMt6ZdV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0478926F2A6
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235209; cv=none; b=Y5bEL0gLqcbhdKRD/dtNAtmzGoZ4lojwV6SDzzFdWhCKuxZ7vZHLG5cYqnJdjAzOvVkDTc1SryMBdACnoevqhgiK9uonO7QE9nNp6qX0jG0vZnWsXY9SSCQ1IV/3zxmHQApp92mO4sfbxyuoVIzuIDAi+y85Qh89/n9iG/iqZ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235209; c=relaxed/simple;
	bh=TJChynZSYVdAMTnLtA1GaEcluKFhzPb6YrASK4GXVL4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRntD3YUGEDB405j/Qa3xnJEM5tWfrHuriPg/HKo+9LAucDGz3aWup+g439snENsxeE4o4g0YQwulAn4Ou+FW7qYsZX680ZcMrLYEQPAwghAWypyrb8kDRqolwbtTWanTsMKXlqVzQWbUqgr15p/Eu+LBc7kHRBtq6z/+DQUUc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDMt6ZdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193F9C113D0
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235207;
	bh=TJChynZSYVdAMTnLtA1GaEcluKFhzPb6YrASK4GXVL4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GDMt6ZdVYEefEUWZ7LSzE71rcfpLiL5hqQkKsM6utascJyiksEQFYbZVInDeJhP3D
	 zDtObT/nN5eD9WMWnsLbho2/QoxXCCVqMYgsyffh6JxhSpaVTkJkvc8LabG26YDucE
	 VWKMZ0Mcsk+FknFO2GGGeBuIbO7lVtbzgexVo/lVAEFm8AmUmm/LR0sP6Pxli9MeqB
	 HAsctdOjy4P270s4sHTq2ORifGnxfx5hD4EuXq2K9J9MEv2RYtQ0Z1gS4fDFhIFjqQ
	 H18bZ0ZS7d8MuVxnz2InVwHhTyNnYD24l6wt5af7hDkMxH1gU7vOysNOcMVkEc/hqZ
	 Afi5MxBMj60dw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 02/28] btrfs: avoid recomputing used space in btrfs_try_granting_tickets()
Date: Thu, 23 Oct 2025 16:59:35 +0100
Message-ID: <1ef999c11909b0472efa0bbf9039acd0b50eb2f1.1761234581.git.fdmanana@suse.com>
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

In every iteration of the loop we call btrfs_space_info_used() which sums
a bunch of fields from a space_info object. This implies doing a function
call besides the sum, and we are holding the space_info's spinlock while
we do this, so we want to keep the critical section as short as possible
since that spinlock is used in all the code for space reservarion and
flushing (therefore it's heavily used).

So call btrfs_try_granting_tickets() only once, before entering the loop,
and then update it as we remove tickets.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 8b1cf7f6c223..c0bad6914bb7 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -526,6 +526,7 @@ void btrfs_try_granting_tickets(struct btrfs_space_info *space_info)
 {
 	struct list_head *head;
 	enum btrfs_reserve_flush_enum flush = BTRFS_RESERVE_NO_FLUSH;
+	u64 used = btrfs_space_info_used(space_info, true);
 
 	lockdep_assert_held(&space_info->lock);
 
@@ -533,18 +534,20 @@ void btrfs_try_granting_tickets(struct btrfs_space_info *space_info)
 again:
 	while (!list_empty(head)) {
 		struct reserve_ticket *ticket;
-		u64 used = btrfs_space_info_used(space_info, true);
+		u64 used_after;
 
 		ticket = list_first_entry(head, struct reserve_ticket, list);
+		used_after = used + ticket->bytes;
 
 		/* Check and see if our ticket can be satisfied now. */
-		if ((used + ticket->bytes <= space_info->total_bytes) ||
+		if (used_after <= space_info->total_bytes ||
 		    btrfs_can_overcommit(space_info, ticket->bytes, flush)) {
 			btrfs_space_info_update_bytes_may_use(space_info, ticket->bytes);
 			remove_ticket(space_info, ticket);
 			ticket->bytes = 0;
 			space_info->tickets_id++;
 			wake_up(&ticket->wait);
+			used = used_after;
 		} else {
 			break;
 		}
-- 
2.47.2


