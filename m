Return-Path: <linux-btrfs+bounces-18904-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1B9C5411F
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 20:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB3F83475DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 19:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF2534D38A;
	Wed, 12 Nov 2025 19:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b="hVpXgeiu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="FdSY0h7F";
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="QhRV8soy";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="IbfBZsk3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sender5.mail.selcloud.ru (sender5.mail.selcloud.ru [5.8.75.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3788934CFBA;
	Wed, 12 Nov 2025 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.8.75.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974485; cv=none; b=B25Rb8NwPzlgQBFMzrsg5NfZhLIaplukz+9IMvsPFxMw15dtU7Yv3+eo92SMfyQgAs6p4I/3/zoGVd1Jy2pg6HhQQVR0uCyTOODvyPLE8s9cw6weh+zZuCfy26PrCTci5c7nDvfh6celthEA5rRyGpCIfyCximlBNJn6lgHKWog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974485; c=relaxed/simple;
	bh=H3JOqqmt+1fG3hT7keMlacoJDCKNtISkT/vLwvm69+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yn/oYq2h1Mpzra6Z12BP8gF1VPcZ/gTTXNp6NfUog8abxIrau8avUjl+WmeSxfgvkSTP1Zl0P9aaBRnZp9dQdHxf+WgbQC7yCCOqGsDOXmXmhs+KxghE0vA9K1wLoa5RIOan/BbZ525JWVZ/6ZDqO/OGPQPZ5Pzp7O/Xw5ZwDCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=mail.selcloud.ru; dkim=pass (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b=hVpXgeiu; dkim=pass (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=FdSY0h7F; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=QhRV8soy; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=IbfBZsk3; arc=none smtp.client-ip=5.8.75.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.selcloud.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.selcloud.ru; s=selcloud; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:List-id:
	List-Unsubscribe:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Help:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QG2I65kYf3DvIF6rGWtUyx74i3yvRyAiTrmBUA2bRsE=; t=1762974483; x=1763147283;
	 b=hVpXgeiuJCSIpRFOOlCwvwsaj7RZ+Uko1X9+aaJzqfKcVLcwFd0nLTlRyLAv9AwXCL2GgrqAip
	pl+bNEV7UeqwJUje/wERBzZ77dRYC94jL8HyCewLPQl3bFvpZZ2+7Zp0doF5KcXNJ1oh65a+WZrAs
	xCLcLxVQ8b0WroO4bBtg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=foxido.dev;
	 s=selcloud; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=QG2I65kYf3DvIF6rGWtUyx74i3yvRyAiTrmBUA2bRsE=; t=1762974483; x=1763147283;
	 b=FdSY0h7FedZNVREYoGsKCHhA6HRsfxS+Oc3HkTyrA4qsGWFWfAWP8ENu70/e+ep0bMGZN10j4Z
	787Fam65wK51Ia2zdFrA+tPd3k3AiBfMN6R3dQ2M79F5F8kgk83hspMHkSSB0eBxaMbUooU65Q8R6
	hD8fOwOnq/63ceJ+A1oQ=;
Precedence: bulk
X-Issuen: 1428244
X-User: 149890965
X-Postmaster-Msgtype: 3849
Feedback-ID: 1428244:15965:3849:samotpravil
X-From: foxido.dev
X-from-id: 15965
X-MSG-TYPE: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-blist-id: 3849
X-Gungo: 20251107.120132
X-SMTPUID: mlgnr59
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1762973419; bh=QG2I65kYf3DvIF6rGWtUyx7
	4i3yvRyAiTrmBUA2bRsE=; b=QhRV8soydkWEbXUaDKh6KEdhaPSfd3/IetrX58pw02dbuF7kh5
	uwjNdg9sfGR8InfnnO7dz+5tJcBFeRc5YV5bU1WTCy2bKMOBf/8XSkDZQ5UTJodqW8YCjPUy8mL
	b1sj7NH6MOpm/CUthe4XInU1kRGmWXeKfBK76rSzdZt0Og0vW+0RdbQJaJsoVv7YETcH3Qj9GCT
	/IWfkEhLHxjK7GanXkeA2XNbX5yS/IGNIjcv9eHYB96mMlhMza5k+Ybj85VNbEzMxGIfkKZIDPt
	0O9WPUmxXqz/K2kOPGWEkrB2/EwWutt7DeWvNXNBomz8CmkArYOb5IDLInGIINURLHA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1762973419; bh=QG2I65kYf3DvIF6rGWtUyx7
	4i3yvRyAiTrmBUA2bRsE=; b=IbfBZsk30duP3rbRi7vY0NSWbijiAeabgULamR9ddya4+MfW6e
	8H7kOiKwLSisdZdWyUyb0xDKcX5u9Vxf5WAg==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: foxido@foxido.dev
Cc: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/8] btrfs: simplify control flow in scrub_simple_mirror
Date: Wed, 12 Nov 2025 21:49:39 +0300
Message-ID: <b0a5361d2b5f98836283c0f38261933e52182a1e.1762972845.git.foxido@foxido.dev>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <cover.1762972845.git.foxido@foxido.dev>
References: <cover.1762972845.git.foxido@foxido.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace 'ret = VAL; break;' pattern with direct return statements
to reduce indirection and improve code clarity.

Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
---
 fs/btrfs/scrub.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ba20d9286a34..dd4e6d20e35f 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2253,7 +2253,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	const u64 logical_end = logical_start + logical_length;
 	u64 cur_logical = logical_start;
-	int ret = 0;
+	int ret;
 
 	/* The range must be inside the bg */
 	ASSERT(logical_start >= bg->start && logical_end <= bg->start + bg->length);
@@ -2265,10 +2265,9 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 
 		/* Canceled? */
 		if (atomic_read(&fs_info->scrub_cancel_req) ||
-		    atomic_read(&sctx->cancel_req)) {
-			ret = -ECANCELED;
-			break;
-		}
+		    atomic_read(&sctx->cancel_req))
+			return -ECANCELED;
+
 		/* Paused? */
 		if (atomic_read(&fs_info->scrub_pause_req)) {
 			/* Push queued extents */
@@ -2278,8 +2277,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 		spin_lock(&bg->lock);
 		if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &bg->runtime_flags)) {
 			spin_unlock(&bg->lock);
-			ret = 0;
-			break;
+			return 0;
 		}
 		spin_unlock(&bg->lock);
 
@@ -2291,11 +2289,10 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 			spin_lock(&sctx->stat_lock);
 			sctx->stat.last_physical = physical + logical_length;
 			spin_unlock(&sctx->stat_lock);
-			ret = 0;
-			break;
+			return 0;
 		}
 		if (ret < 0)
-			break;
+			return ret;
 
 		/* queue_scrub_stripe() returned 0, @found_logical must be updated. */
 		ASSERT(found_logical != U64_MAX);
@@ -2304,7 +2301,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 		/* Don't hold CPU for too long time */
 		cond_resched();
 	}
-	return ret;
+	return 0;
 }
 
 /* Calculate the full stripe length for simple stripe based profiles */
-- 
2.51.1.dirty


