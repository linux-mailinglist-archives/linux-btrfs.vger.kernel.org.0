Return-Path: <linux-btrfs+bounces-13702-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A846AAAFD5
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 05:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A16717BAE5
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 03:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947D6289355;
	Mon,  5 May 2025 23:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fR3WYbNL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046F63AC585;
	Mon,  5 May 2025 23:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487140; cv=none; b=i93weLMD10sTjS8LQQPsENMdvxY6L7gt8nh88kmv4/ZCfSD/kHiZbP1M5yls0gtvqq5dFSJHksBrHPBzCTcE7O3xaMJvtiXIC67UYxO7FjNaql7oZW1slAIoxpgGLPHWabWpmo+rsxrDR6DHNSLAPqSFA/1o7FXdprOC3MikeXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487140; c=relaxed/simple;
	bh=Csaowb7NrkN/3ALghE9sDHxNNd924ux/mjY/CqPub6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tJR8YLH1KlbM8HvZ4Ay7HmTyETwlr4w1+XBB2ygO1OWHYmbTcdixKMDTMW/2o4mEBna8IujEsJmkCJ8pS9dHSwOA7mDBQuVi93h/bW0EA9TcN18jbT7XZIbul5GiWIjYk8zhb77WiJnzP+PUIGH5Kk8wkEsB/1aE17VTn9BhwOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fR3WYbNL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00F8C4CEED;
	Mon,  5 May 2025 23:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487138;
	bh=Csaowb7NrkN/3ALghE9sDHxNNd924ux/mjY/CqPub6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fR3WYbNLivl9dWhnig7DVntpwPKxaQlaUPsrbfwdMf6t6/jo65aY3affSrqUVKc95
	 OO67YiZse/fHTg4whx7Z3DEaBJZToEsWHOz8sHI0PdgumuIpcxlsyaMSWP4fWdMON9
	 bR8+oImWyI3dYUQahcy+WyCBbqUHJahwQcSOxat3OOjQQlYJZMl1f8vUlxGSy4H5fN
	 yGitoa4xtP4Ibm9dy1bMTqfy+QEjJhQsuGfzBD7U+e2RmIkGsjZGjJdfXcWRk7cuQT
	 JSmoEXMWrjP7OnV9ENBidQ+ukFsum3h8pzSL9I04c8lTE/dxM7Os7D1S2TUhCJfw47
	 d9VtWTM14xyVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 020/114] btrfs: send: return -ENAMETOOLONG when attempting a path that is too long
Date: Mon,  5 May 2025 19:16:43 -0400
Message-Id: <20250505231817.2697367-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit a77749b3e21813566cea050bbb3414ae74562eba ]

When attempting to build a too long path we are currently returning
-ENOMEM, which is very odd and misleading. So update fs_path_ensure_buf()
to return -ENAMETOOLONG instead. Also, while at it, move the WARN_ON()
into the if statement's expression, as it makes it clear what is being
tested and also has the effect of adding 'unlikely' to the statement,
which allows the compiler to generate better code as this condition is
never expected to happen.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/send.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index a9e72f42e91e0..3e7bb24eb2276 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -390,10 +390,8 @@ static int fs_path_ensure_buf(struct fs_path *p, int len)
 	if (p->buf_len >= len)
 		return 0;
 
-	if (len > PATH_MAX) {
-		WARN_ON(1);
-		return -ENOMEM;
-	}
+	if (WARN_ON(len > PATH_MAX))
+		return -ENAMETOOLONG;
 
 	path_len = p->end - p->start;
 	old_buf_len = p->buf_len;
-- 
2.39.5


