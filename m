Return-Path: <linux-btrfs+bounces-18197-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B410BC02498
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 153775089C3
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1749426ED5F;
	Thu, 23 Oct 2025 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaJ7zwH2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DDF26B765
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235215; cv=none; b=ju+fF7rNj6dlZTafCQ842dtf5ieYVbSRSsh9v0QnyJOvakdEaA9QePbPTys9k7V9yf80MDF/msSi5SrJmto+GoWpOpfM+8B0wRyy7RwnzJIPwXEU2OT7ydb/wFpHKSpmrkuxfVTHETA0QPCOT9nacAnXcyYjUR70Krgmvx2ht9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235215; c=relaxed/simple;
	bh=8rlgQ26BdgzGUhsZ/FKMh2QzJUHqB2n1G8ELPMMIeB8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsM9bjtV1+dLVDXCDqN2Amco4xUMnL+c82rUkCaS6hv6BvCR0xKPIoqGrRXv4mEWjpCyXAhke4lrS3JQtFz2YE7WOkrVPmOuleH2RLxrdNmek5m74X+XXeC0girypGYv4PWIbunAe2qWI9PVlZAgcnjUcXarccI9y9N1ajhStoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaJ7zwH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9194FC4CEFF
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235215;
	bh=8rlgQ26BdgzGUhsZ/FKMh2QzJUHqB2n1G8ELPMMIeB8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iaJ7zwH2+CG0o2BteWxQAQBNgr2bM5MbDeq21Hm/OgnBaZgmI3JXt70zMHG+qLwKd
	 yC5UkvLgdgh8VKqzDyJoGyV9va1jE0rX4UPwj7z96SzYFyPz9AljlY7yHF8TjYMp3j
	 +kAHNa16N6EG10+1KMR4koUtl0M3VP4MsF+VnwCzaKYl7+3PkkrgeFegFA/3jCK0JC
	 pMGN5i9TDRdOoPhdb2HXgEGsm1HogWl9f9ja+WhuhLKdMt2Xiic08t/HlZY53yvSRb
	 XMvbTD3b+2acIMrYiJ0VGRGmo794u/0eiEYnNLn8EhnXuW0BvgZ3LxVkCP28FygEoX
	 ODj49e0Wpdayw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 10/28] btrfs: avoid unnecessary reclaim calculation in priority_reclaim_metadata_space()
Date: Thu, 23 Oct 2025 16:59:43 +0100
Message-ID: <80186103f5b1185fbec7bc6e6b478bd61a221522.1761234581.git.fdmanana@suse.com>
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

If the given ticket was already served (its ->bytes is 0), then we wasted
time calculating the metadata reclaim size. So calculate it only after we
checked the ticket was not yet served.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 9a072009eec8..b03c015d5d51 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1501,7 +1501,6 @@ static void priority_reclaim_metadata_space(struct btrfs_space_info *space_info,
 	int flush_state = 0;
 
 	spin_lock(&space_info->lock);
-	to_reclaim = btrfs_calc_reclaim_metadata_size(space_info);
 	/*
 	 * This is the priority reclaim path, so to_reclaim could be >0 still
 	 * because we may have only satisfied the priority tickets and still
@@ -1513,6 +1512,8 @@ static void priority_reclaim_metadata_space(struct btrfs_space_info *space_info,
 		return;
 	}
 
+	to_reclaim = btrfs_calc_reclaim_metadata_size(space_info);
+
 	while (flush_state < states_nr) {
 		spin_unlock(&space_info->lock);
 		flush_space(space_info, to_reclaim, states[flush_state], false);
-- 
2.47.2


