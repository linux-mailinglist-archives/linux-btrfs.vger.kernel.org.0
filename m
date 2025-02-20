Return-Path: <linux-btrfs+bounces-11654-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 743DFA3D7C2
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B542F17FA07
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D2A1F4626;
	Thu, 20 Feb 2025 11:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2/x0EcV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D18C1F4614
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049507; cv=none; b=ZDb6nUwp8KyGks2f27qfpPWlC0m9Op/N6ZFpwVOJ2Ir1JN8KmWxaDhyCa48CDwMy+v0X1n7mNq6zaroKJOMZv+iA51nmAPv1YLiqydKeddmxWwe8DMdoa5NDjV2XGg7ljjZiCokLLj69TOBez+0Qso6u17l+DP/F16BvYDfrx54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049507; c=relaxed/simple;
	bh=bo65LBflfD+3mpw0tdqCeliFgx2TqnU6QVvpvc7mI6U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lvi/v5bOimWR69cYdR8lJrb1XsjBdJ57FfLicTam6wsiOUPHCOJpDJABe6mllo6h2N0j824slyW6c5YRtgZ6ePIM6YSFCWGEmo97uFZmtUicxlbCAaWcPUV2p+KaVPrOUXIGxWwre3BkpQnbM6Hf/i7DIUOmKLy8aQlzwq+f6bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2/x0EcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91239C4CEDD
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049507;
	bh=bo65LBflfD+3mpw0tdqCeliFgx2TqnU6QVvpvc7mI6U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=B2/x0EcVSTgVR1a4ROmcXLqeAQcAX9c/D8h65Eq9j1NpGDFLse9vZtlHt9jZT3paI
	 r0LXYpEHwgJVs5mkOnKhEYPoNUfu0cTQsRnnTioAOM9bmCYjACPrlL26vmRnnl7GJM
	 rZEkjppWMHX1JGbM17JpAJf37n+Y/RIKPSX7njAk+hwqBytdfNHQA6HjHzPwunZZzM
	 kfHg6B2LF6mY2SlAN6YgUHTXMMYR2PTiymH1cJpCl8ErUseiJVyhZ9/80HC4P40d7y
	 Ed0fkud5WpGqMzndmao+PkOif3ONFJ04MmXZ1y/CFlPqYslMCER6jlAnpdZDswMLqF
	 k00KVWaPrhaaw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 19/30] btrfs: send: simplify return logic from record_deleted_ref()
Date: Thu, 20 Feb 2025 11:04:32 +0000
Message-Id: <bbf45a361117dcc21929c0f434615d217e2696b3.1740049233.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740049233.git.fdmanana@suse.com>
References: <cover.1740049233.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There is no need to have an 'out' label and jump into it since there are
no resource cleanups to perform (release locks, free memory, etc), so
make this simpler by removing the label and goto and instead return
directly.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 181a234e3a5e..6e171b504415 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4759,11 +4759,9 @@ static int record_deleted_ref(struct send_ctx *sctx)
 				sctx->cmp_key, 0, record_deleted_ref_if_needed,
 				sctx);
 	if (ret < 0)
-		goto out;
-	ret = 0;
+		return ret;
 
-out:
-	return ret;
+	return 0;
 }
 
 static int record_changed_ref(struct send_ctx *sctx)
-- 
2.45.2


