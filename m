Return-Path: <linux-btrfs+bounces-18199-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1A6C024A1
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF7CE540139
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31085273D6C;
	Thu, 23 Oct 2025 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlTUo45h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7487B2798F3
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235217; cv=none; b=CFQwWh8dUlotB1sRJhb/DcCY4Xox+3MZIkvYe3Ms+kzr32UOPugtHqK3fMNcFPAUhQtEcLHZCW0vEsqNyd4UJIObZckXrQDvuHu/11mutyipmkLEhjry2Ia58pO6YQJGTqYc+oZFS252b2YaNf6dDAv21YYU4/uatvZcvOqTzAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235217; c=relaxed/simple;
	bh=1ME1ybADntn4fXsvnvC8dPSniRb4N6cCffdElJPfyo4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEmwQepWcEssb6dMkTZHzsXdzL/kdSPG4hSq/h1fpgfrUxrj3Te6Z21zz/soXmfy4WZ0oybTq7ZfVDuGHmED4OFpsSMSOn8D6UeBmAVULceOpxz1jDiWK8s0eOlpRX+yXdqwQW8hoHdsosH60/p67RJT6GMvO5IJBQADfkMb4Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlTUo45h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1B8C4CEE7
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235217;
	bh=1ME1ybADntn4fXsvnvC8dPSniRb4N6cCffdElJPfyo4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jlTUo45h7u4GNrh2mCYdyP6Q1wgRj4hVQdmTBttn+rx+jhotN86TuqoIPoZe8c/B+
	 v8wo012QXYPmkALhefQNIhzllNLErNcr3H2YLht7uz6JsB+Dz7jEpH8+4ZZuyiBGR4
	 7dyRo0M5k8+kZAD3EhiCcnmFES2R5WLVPHymj4Ok1weijI+Ma5xSLNHGk47uFWczaa
	 BYpoznv3MSu2rAS8h75X3zGKkk0uOL72crdb2l/bFKuF2z0o+2/wPDbcL4cv7hwCee
	 YVfdYYoezlk1g9iuTCkYYqU5MPWD9xlKOxkiyuCImbqeU1pTmXjiO8zvnpQsRwZqcF
	 +7EuWUVOqthxw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 12/28] btrfs: assign booleans to global reserve's full field
Date: Thu, 23 Oct 2025 16:59:45 +0100
Message-ID: <d0e1511b511d201aad6c35a25e523ec1ac9adc1d.1761234581.git.fdmanana@suse.com>
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

We have a couple places that are assigning 0 and 1 to the full field of
the global reserve. This is harmless since 0 is converted to false and
1 converted to true, but for better readability, replace these with true
and false since the field is of type bool.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index a2af55178c69..62e1ba7f09c0 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1067,7 +1067,7 @@ static bool steal_from_global_rsv(struct btrfs_space_info *space_info,
 	wake_up(&ticket->wait);
 	space_info->tickets_id++;
 	if (global_rsv->reserved < global_rsv->size)
-		global_rsv->full = 0;
+		global_rsv->full = false;
 	spin_unlock(&global_rsv->lock);
 
 	return true;
@@ -2186,7 +2186,7 @@ void btrfs_return_free_space(struct btrfs_space_info *space_info, u64 len)
 		global_rsv->reserved += to_add;
 		btrfs_space_info_update_bytes_may_use(space_info, to_add);
 		if (global_rsv->reserved >= global_rsv->size)
-			global_rsv->full = 1;
+			global_rsv->full = true;
 		len -= to_add;
 	}
 	spin_unlock(&global_rsv->lock);
-- 
2.47.2


