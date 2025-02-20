Return-Path: <linux-btrfs+bounces-11659-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD34FA3D7CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954DE17D91E
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D251F1534;
	Thu, 20 Feb 2025 11:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/MU9iSY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606381F0E31
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049512; cv=none; b=PJPCvor9yHCPWEXGTc+rtb/W5iZdtgi/1VndkgvZV2Z1DCIZy7zHvPJwf4aNFefEXoaHy/eWaVLerNgx3B3sAdwIb6TDmDC4SUAzVsjWTXzSUsanRu/9GMC2xiFpkZhO9ReB5gskfU0ncm0aGEes+w1W8Q90MlZhAc//hnkB3Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049512; c=relaxed/simple;
	bh=No1hRUoq8G5x+5o40hJzJRvS7EauTBPVtearmdchDHY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n7ga6+bZtn0Bi/p9L5pWwZpBG0/3acOOe3VnfrlGmK5C8YKGONR3tZcOztmKYKFvIOyRnauyj2XkO3NnIXVyO26kmZfIdx6L7RKGG0GAWcEgPWmGmNwkZ6IlO+/olV01kuqEOoxFrmOaIRG5rwPI3wVnTfTh3AO4EsyNYZMgKn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/MU9iSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19B2C4CEE3
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049512;
	bh=No1hRUoq8G5x+5o40hJzJRvS7EauTBPVtearmdchDHY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=L/MU9iSYz3G+aizRyhjO7G5bfr5XXvlgHPRdfNFdLa6lkGG6VKrpcf37nOio3G5tU
	 sFE0yqT+CzxgzaxmAFPNhoQTt1eg+HxUeaGQL0FLRWNFQpzGRtsLqCyzcPFsHgiC8E
	 QQmeitTcycIq6KYxhRu5TH1Hipf2ooZkwodg8FWSLsffrsx8t/HKfCFtnkE9cBUO9t
	 bIJlmttLhqJ6kuYNdXXbB6ah1FvMD2AyCWxp9ABPW8dzwWDQBjOeWgPfyV0w6IhaoN
	 sXZRo3zkk5pvM30SmX1ESABktkz6FyJ24ZkMIK9Tcdx4j3ZdeAbOSLp+03rC32pWFR
	 4L2JKQhroM9Zg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 24/30] btrfs: send: simplify return logic from send_rename()
Date: Thu, 20 Feb 2025 11:04:37 +0000
Message-Id: <406a37adace0bfb7a92fec821bafd1ba1e277536.1740049233.git.fdmanana@suse.com>
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
 fs/btrfs/send.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index f161e6a695bd..d5c151651d07 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -809,7 +809,7 @@ static int send_rename(struct send_ctx *sctx,
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_RENAME);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, from);
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH_TO, to);
@@ -817,7 +817,6 @@ static int send_rename(struct send_ctx *sctx,
 	ret = send_cmd(sctx);
 
 tlv_put_failure:
-out:
 	return ret;
 }
 
-- 
2.45.2


