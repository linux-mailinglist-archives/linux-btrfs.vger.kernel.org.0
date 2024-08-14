Return-Path: <linux-btrfs+bounces-7185-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CE99511F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 04:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D951C20E53
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 02:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE151537FF;
	Wed, 14 Aug 2024 02:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIlub4iX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A05D49650;
	Wed, 14 Aug 2024 02:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601701; cv=none; b=t+Cpu4iDN/sC45zTuuFJDjhUtnEsJqqUFzFmHvhvqfKWgpvxrbMXTTQ8/Fe1dVWJgvgKXfa9f83yLIwgNOrtzXKBtOg3YYnKsdJKRdOxmXw4zlX1w8Ujg5xtFM3SwqhjOHKAdlHXAXvXWH2+LuL1bRFfBBnXBUAENV5wCEXiZaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601701; c=relaxed/simple;
	bh=y8NSSc/okRxOhfopXMk6br5i0eZtIwrLuwuU53JPCjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ehj4CGVIhZ60gU3QRixp+xU6JbHUH5sb79oeRlRLEQXoLx1lr0UcOHVhr9hNNyuAgqepxuXzibM1EBHkoE1nY+NQuC5yqu4xofjtxg0wluf82KkoFN+vyhNBuu6R8wHiDWhdGYzITCb3v/XhnzMOCyjYkDMvYD6ztZXRaWw5y5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIlub4iX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE361C4AF09;
	Wed, 14 Aug 2024 02:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723601700;
	bh=y8NSSc/okRxOhfopXMk6br5i0eZtIwrLuwuU53JPCjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gIlub4iX9jFvELwlhN2aLbvFgQebrXUJDR+UYs0S15xnvucoGy093NmgjMfGHov9N
	 UnQ/HhZ6rbeDW7zBFbb6RtME3JkNXykO+FuU47RROZAUU++vBNIfV1gs7OLr3ZII0s
	 bi4BbEAdPMYd24SR8adaxJdx1BVq8qHB26y2otBo7+2A6jaqJVPvmEEtU0QZJbZjic
	 kAlooo9Ipd+4ghjwEyy3/XF5mr7rogGqC6nx4ztDahyFgelxnMQbyfbjb8ibs42E8B
	 ggIhL0H7lZiBui8hpO5MwzN/75nBV0CzwQ/vB0RvW3fPT8Wob0BXZfhVSEvtpbbA5m
	 TTr1j5IkyTCxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Michel Palleau <michel.palleau@gmail.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 06/13] btrfs: scrub: update last_physical after scrubbing one stripe
Date: Tue, 13 Aug 2024 22:14:37 -0400
Message-ID: <20240814021451.4129952-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814021451.4129952-1-sashal@kernel.org>
References: <20240814021451.4129952-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.4
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 63447b7dd40c6a9ae8d3bb70c11f4c46731823e3 ]

Currently sctx->stat.last_physical only got updated in the following
cases:

- When the last stripe of a non-RAID56 chunk is scrubbed
  This implies a pitfall, if the last stripe is at the chunk boundary,
  and we finished the scrub of the whole chunk, we won't update
  last_physical at all until the next chunk.

- When a P/Q stripe of a RAID56 chunk is scrubbed

This leads the following two problems:

- sctx->stat.last_physical is not updated for a almost full chunk
  This is especially bad, affecting scrub resume, as the resume would
  start from last_physical, causing unnecessary re-scrub.

- "btrfs scrub status" will not report any progress for a long time

Fix the problem by properly updating @last_physical after each stripe is
scrubbed.

And since we're here, for the sake of consistency, use spin lock to
protect the update of @last_physical, just like all the remaining
call sites touching sctx->stat.

Reported-by: Michel Palleau <michel.palleau@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CAMFk-+igFTv2E8svg=cQ6o3e6CrR5QwgQ3Ok9EyRaEvvthpqCQ@mail.gmail.com/
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/scrub.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 9712169593980..731d7d562db1a 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1875,6 +1875,9 @@ static int flush_scrub_stripes(struct scrub_ctx *sctx)
 		stripe = &sctx->stripes[i];
 
 		wait_scrub_stripe_io(stripe);
+		spin_lock(&sctx->stat_lock);
+		sctx->stat.last_physical = stripe->physical + stripe_length(stripe);
+		spin_unlock(&sctx->stat_lock);
 		scrub_reset_stripe(stripe);
 	}
 out:
@@ -2143,7 +2146,9 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 					 cur_physical, &found_logical);
 		if (ret > 0) {
 			/* No more extent, just update the accounting */
+			spin_lock(&sctx->stat_lock);
 			sctx->stat.last_physical = physical + logical_length;
+			spin_unlock(&sctx->stat_lock);
 			ret = 0;
 			break;
 		}
@@ -2340,6 +2345,10 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 			stripe_logical += chunk_logical;
 			ret = scrub_raid56_parity_stripe(sctx, scrub_dev, bg,
 							 map, stripe_logical);
+			spin_lock(&sctx->stat_lock);
+			sctx->stat.last_physical = min(physical + BTRFS_STRIPE_LEN,
+						       physical_end);
+			spin_unlock(&sctx->stat_lock);
 			if (ret)
 				goto out;
 			goto next;
-- 
2.43.0


