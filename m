Return-Path: <linux-btrfs+bounces-11576-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 197C9A3BD4D
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC3B3AF357
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEED1DFE36;
	Wed, 19 Feb 2025 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyVcf5+J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27031E0DCC
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965421; cv=none; b=U4R16SUnURWZ214sYtopE3BurMW+IY+N8uj/k7mWwvJ5JyNa44jRw7MhWHs+LERKDjaqbvN6unnhb16hjs1o36E/xtVfcmeUg8R3f+ikNj6iGJhXyR+mszk7joHFBwCNy+BKgnSP35eLh2/v2sh/PJUd9o0OJB7WqEXxY32L2j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965421; c=relaxed/simple;
	bh=yGG6Cy9K8ygG2fE8rIJTVP2uEfYv8gX0Yf3gDRp25FY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tt0K5cZ+b0l46DEWUz6EvSARhr8dgXGJK8qRyuwK412CNJaLNo2USTELTUhqFAa1Pw3rX7BhdDRERpYh4AZ1wCHcX50MTCZoEj4OeR6KWXgrxrH9jF1Ksu+s1n9JATNT+VMI57Ts+NSbX/PjOVoEwkiFiGrRLd0kF9ToVBjMD4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyVcf5+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C51FC4CEE8
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965421;
	bh=yGG6Cy9K8ygG2fE8rIJTVP2uEfYv8gX0Yf3gDRp25FY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kyVcf5+JVEuOYDTH+VrQfx/rLrzHmAfnQ6VKCGLlL355Jz/P5GqYfvQHxBl0MLdxV
	 kyi5Kb2QYyzJN+u3iOGqDpszYN+OXq/Ie9YBZcYBIS7PB0utN5RyVaVttVdIU83cEV
	 Xo6WtWKZ0MWbeWRU4J0cbJeiPN3cLD6rKdChjI7sb0AmNSh2j2OeYDSXylt+6oFbrB
	 jQ3zJx78CdSVKd4YqhgeI8gwItNjNLBAkBXPUfa3xmByxVLnjlbcaGW2Q5BfHMKQfA
	 Bht+F9qh3jJOdljBK1fZ2HXnhVivIlYI09r1VtANtntvOq1UBpk5J9mQLwrMuqovDa
	 +yIAMo9c7edvw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 11/26] btrfs: send: simplify return logic from get_cur_inode_state()
Date: Wed, 19 Feb 2025 11:43:11 +0000
Message-Id: <7a0324782e68e96229c2bc37943dc398aa14d4b5.1739965104.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739965104.git.fdmanana@suse.com>
References: <cover.1739965104.git.fdmanana@suse.com>
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
 fs/btrfs/send.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 0a908e1066a6..e0e24ac94aac 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1880,7 +1880,7 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen,
 
 	ret = get_inode_info(sctx->send_root, ino, &info);
 	if (ret < 0 && ret != -ENOENT)
-		goto out;
+		return ret;
 	left_ret = (info.nlink == 0) ? -ENOENT : ret;
 	left_gen = info.gen;
 	if (send_gen)
@@ -1891,7 +1891,7 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen,
 	} else {
 		ret = get_inode_info(sctx->parent_root, ino, &info);
 		if (ret < 0 && ret != -ENOENT)
-			goto out;
+			return ret;
 		right_ret = (info.nlink == 0) ? -ENOENT : ret;
 		right_gen = info.gen;
 		if (parent_gen)
@@ -1936,7 +1936,6 @@ static int get_cur_inode_state(struct send_ctx *sctx, u64 ino, u64 gen,
 		ret = -ENOENT;
 	}
 
-out:
 	return ret;
 }
 
-- 
2.45.2


