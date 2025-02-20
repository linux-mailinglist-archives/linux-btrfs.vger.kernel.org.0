Return-Path: <linux-btrfs+bounces-11655-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B47F1A3D7C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4346217D039
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8211F463B;
	Thu, 20 Feb 2025 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NexzNJ7Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DE01F4614
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049508; cv=none; b=rgbZqv+HRjekGoXq96T3S7yRnu2tryABLrTVrGVSclKb71Rm2YudNteLQIRC4lY+++gVKGBkH4274UlfStdeBVbhCYTNDre/LX22dN7PqqLRnLT5CAFoSMRSQTcWlnVPXWXr43GKGpgd30sfEO+/9puqTdorQfvQBYV6RoCgzm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049508; c=relaxed/simple;
	bh=wXsAxsgamsNQG+m9lr5ppecgeBVTHoTlfPbVpx8Orsc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FUOaVMqs6if9lWox+iQoW6YEgWNps/CbiDjUoWj/ka5bUNAH9h0gXNDnarwThZvCTHz+tNYXA8AEIuOAWYxdYD3nitC8UM74nLnmpHZNNYGiyqtvwdyMQspZYUZNAycOJAW1m4boSoNDwlv6QmlJioSaKKPzQkBUjZ8ONF6RstE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NexzNJ7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970CEC4CED1
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049508;
	bh=wXsAxsgamsNQG+m9lr5ppecgeBVTHoTlfPbVpx8Orsc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NexzNJ7YwjbIiiW1AqWojJC+aDEmQ96pY4RPHH/yESWbE31tuD9qmc5ED+hlzdiBH
	 yEaAruboIntThsj9CnGquehI/NwhLIIiHL3y4Ly3pMr9pNmYXf9DfnFFXmOSA9Kk4D
	 TShMx4VGYg6B2aLxUZZzvurBLRcjK0XwQi1FYDgzBTTXlz6mJCtELb2ESL+rXuVGR0
	 CjVOXsYE3+5+WggpDWaLBb0ejFrqY+9/adE8dg/Yx1l1Fo6eYxQOpZdtv93qjDGLM0
	 atysAdhxmIDmJ90mRtPkHpp48QxSLICzeDLdks9Y24vFxSSYJm9JZOzRQzqZM8dBrT
	 QPAuB3aDGMyJQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 20/30] btrfs: send: simplify return logic from record_changed_ref()
Date: Thu, 20 Feb 2025 11:04:33 +0000
Message-Id: <0d104fa4a4e8f3a58c93c1179d5c0dae0207ed75.1740049233.git.fdmanana@suse.com>
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
 fs/btrfs/send.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 6e171b504415..01b8b570d6ed 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4766,20 +4766,18 @@ static int record_deleted_ref(struct send_ctx *sctx)
 
 static int record_changed_ref(struct send_ctx *sctx)
 {
-	int ret = 0;
+	int ret;
 
 	ret = iterate_inode_ref(sctx->send_root, sctx->left_path,
 			sctx->cmp_key, 0, record_new_ref_if_needed, sctx);
 	if (ret < 0)
-		goto out;
+		return ret;
 	ret = iterate_inode_ref(sctx->parent_root, sctx->right_path,
 			sctx->cmp_key, 0, record_deleted_ref_if_needed, sctx);
 	if (ret < 0)
-		goto out;
-	ret = 0;
+		return ret;
 
-out:
-	return ret;
+	return 0;
 }
 
 /*
-- 
2.45.2


