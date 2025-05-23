Return-Path: <linux-btrfs+bounces-14193-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E157FAC2873
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 May 2025 19:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5D51B683B7
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 May 2025 17:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3012980D7;
	Fri, 23 May 2025 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTL55mJv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8551297B69;
	Fri, 23 May 2025 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020858; cv=none; b=g+7Tbieb/nwsf7fZUmxcOrtJl0OskMXAmTcr7QbVLCCWT3l2aHsXk2Pvlh3mKDz5aPr+PI4rTIJkQeA2JNXew9hfi+u2ocHDtmVXgJqxoXU9AK1DV0iXoiX87yfD5qMfrv5/OkTDXRFRzFAd5lMSPpvKOVwe9Y3wZGUu3qmaQcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020858; c=relaxed/simple;
	bh=729jARVbnpHMLy+n+lw/zvWqBUl+xDMCGY6E1Y6MZ0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OlBnPrHGgaT/4d47fqrouMOKdEwWWUNHvQMoh9RItKP37Vy+M+PLh2INvRdgfPn45BcxBCE9okkbzWRzbdgghXfpC+D9Ay0FUQqb6fWDhsZoPBama2k6glHs8VnA9N8iyyU1Xsg/AHS2L7ETGLgsCHPfDaFZD36n4SBQM41lfzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTL55mJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F52AC4CEE9;
	Fri, 23 May 2025 17:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748020857;
	bh=729jARVbnpHMLy+n+lw/zvWqBUl+xDMCGY6E1Y6MZ0g=;
	h=From:To:Cc:Subject:Date:From;
	b=PTL55mJvn25g6kTTgzlv2NvWmRfBt8MW8BjipHilZL7mrlxn0TnpAz2PxcgwTni0R
	 I/9MfoS1oneuiAdWhG9ixW4vmMFJPrFOq9AWb+Rv/5yq78RXj61jN+J2Y7w7N6kYiJ
	 iyyVElQhXx5dXdqeyMW47V7ws3XZz6Lz0YAKZwN2Jr9D5J7QtXveRWdp42s50AmUKM
	 lm/PTFRtdu2EcntNS51F1WxbFXoD3Qh7vFPVlwRdOG/38vYScAnkZ/o/r3FVp9Dp1Q
	 EABT6UM5ikusDgzvEsmrDEmVd19btTk3it4Al/es4LukpW7s0srpnGcoSH7v4+lYfl
	 cb0efhQTYTYNw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] fsstress: print syncfs() return value in verbose mode
Date: Fri, 23 May 2025 18:20:50 +0100
Message-ID: <ef67a4bf8d93109a0493155252c9a3c903478388.1748020773.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We aren't logging the syncfs() return value in case we are running in
verbose mode, which is useful and it would help me immediately figuring
out it was failing in a problem I was debugging with btrfs.

So log its return value, just like we do for every other fsstress command.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 ltp/fsstress.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index ed9d5fa1..8dbfb81f 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -5326,14 +5326,15 @@ void
 sync_f(opnum_t opno, long r)
 {
 	int	fd;
+	int	e;
 
 	fd = open(homedir, O_RDONLY|O_DIRECTORY);
 	if (fd < 0)
 		goto use_sync;
-	syncfs(fd);
+	e = syncfs(fd) < 0 ? errno : 0;
 	close(fd);
 	if (verbose)
-		printf("%d/%lld: syncfs\n", procid, opno);
+		printf("%d/%lld: syncfs %d\n", procid, opno, e);
 	return;
 
 use_sync:
-- 
2.47.2


