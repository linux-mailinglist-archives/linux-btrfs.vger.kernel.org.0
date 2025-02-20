Return-Path: <linux-btrfs+bounces-11662-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 180C0A3D7C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B901189CFFE
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9AB1F0E4B;
	Thu, 20 Feb 2025 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqSKSxHV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7332A1F4E54
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049515; cv=none; b=cjGpAf9najploo2vkN0H30v0xCWeyUYktUavWjWe/aZ31i+fBROqrTvV+6ZPmnJztRlUDeN1yCiUETqJXUCq6SQreYE99MpSZS+xaCPxg5YJGCwzeDd3zs67KL+0l0ixXdKPYDavexLvA1e9YPVWgeG7864Os07/RLfTrux39Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049515; c=relaxed/simple;
	bh=IDJlvcdhDQQUfwB4RDcgxx9hfHya+TjJhCjWxPMCujg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JPf4U/JJ3NgxgNiYfKxIH+XJ9fgrx5to434lIwn2cRBBxX1Xo0utegBOdysSB7bE9k/Ww0R1YyMd5f690TKzjS1kgjb1a0ivtd0Rz9WbiUEFfeyVTlG5lIsszv/3SoG4AQNsaYRheOrSmci+OkfPJEHbL4f93u6QLYWCfGa4QEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqSKSxHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46AEC4CED1
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049515;
	bh=IDJlvcdhDQQUfwB4RDcgxx9hfHya+TjJhCjWxPMCujg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IqSKSxHVpTUgtm38Gr8mux5c2qtXQIsXEVpdpeLvXqlnkLtxuLcivqUu6nl1We1Sv
	 23aZv/EZl3vUf1VqdzFtiFUtRQJxayk2zMufzURj3r46zQmtPf9wqh869RqMPIpTqd
	 v6gFQErcL04UZReA4srFvhKEtC0sNYKFNWs9kX2/9GMvaTxINNANxUg02w16Dt1rA8
	 1Uze8ODQb2gXASVsLRdRvDMkjUgAipyvHNDWRq4oxcQdmb3PFnH3Y33BGgM+mL4990
	 NeIK4rNuhhX12YP3gQFzu4L4mHtXvKW3tu6O2VW+R2VKr8DK/D4r5HAuVUfhz1Q/H2
	 WaDO1Cp04U99Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 27/30] btrfs: send: simplify return logic from send_rmdir()
Date: Thu, 20 Feb 2025 11:04:40 +0000
Message-Id: <787ca60ae3a756f78ec49ff633ea250f0050d828.1740049233.git.fdmanana@suse.com>
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
index cbc9ca9db062..0c496270e10f 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -878,14 +878,13 @@ static int send_rmdir(struct send_ctx *sctx, struct fs_path *path)
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_RMDIR);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, path);
 
 	ret = send_cmd(sctx);
 
 tlv_put_failure:
-out:
 	return ret;
 }
 
-- 
2.45.2


