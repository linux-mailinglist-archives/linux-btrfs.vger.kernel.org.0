Return-Path: <linux-btrfs+bounces-11657-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56A0A3D7C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E43516A657
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9141F4E27;
	Thu, 20 Feb 2025 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcbmybAP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E1C1F472E
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049510; cv=none; b=nhTSmoWeSuGlrrztcrAi7p0ulza19RCNSjnCjE20FpRm/IKvZebtBQLAIDwtrVoyO1CegFs7EPwG5DiNrAiHdQpOp1ibzPbcp7aQpFNWsMOPvtdZqPc7C67cUok4twWNL/0rjkvessbuYT4/75BT2eP+aXMg1PAHOU3FOacY7/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049510; c=relaxed/simple;
	bh=NJ2JgutmmQTjMHYytZ3fYMdgpi7FupvrNgUYg/RUnPg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eEU8eOlCseeYZO7hhVP92aqLXNE6cSBs9AcMJCpwh8nykANmKC4wzUgcKPB3qwpoWsW3lFcXf+DTKeFTBR/Z4e7Z48pn/+esvg4RVF9XEF9WXmT/0pGLWhrcETy9oPwmvNko7NcAalLasFPp+UYOJOyE9kJw+dy+CeA2hwIi9I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcbmybAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A6AC4CEE4
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049510;
	bh=NJ2JgutmmQTjMHYytZ3fYMdgpi7FupvrNgUYg/RUnPg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dcbmybAPm2pFoCq8R2NkSqIkTicZll0itp2zZA2hJxCYKP7nB0UMOh0M/ZcCKHFRH
	 24rkOEziJk9m/Li8lcxXexGMQoPwInkC/ujPQGUOtCyc4EAiloAemxG+oVxpe3Ff1X
	 EWXv1d4N16TJTGM+vPxk/Z0GsEyFrKDiGv741SVygG0SVwreQsGWZ82pkzvuDvn4a3
	 VSxdamuPPcRCJa8igu2GfJJRS7DUCN/z5DBt6EA6fHexLvnSifDhLPBfaKJ3divFB3
	 M5CDxZgRZRM1tE3gR3cZR8O7IhSdGVb5UbTyP9ei5oaUDBEpU0Ji6R9u+gCS4BUFFX
	 tHUe4drwNvAMQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 22/30] btrfs: send: simplify return logic from process_changed_xattr()
Date: Thu, 20 Feb 2025 11:04:35 +0000
Message-Id: <2bfe8c0be41bc9d7443bef179b798c34a1152ee1.1740049233.git.fdmanana@suse.com>
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
index e29b5a5ccdd6..0cbc8b5b6fab 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5067,17 +5067,15 @@ static int __process_changed_deleted_xattr(int num, struct btrfs_key *di_key,
 
 static int process_changed_xattr(struct send_ctx *sctx)
 {
-	int ret = 0;
+	int ret;
 
 	ret = iterate_dir_item(sctx->send_root, sctx->left_path,
 			__process_changed_new_xattr, sctx);
 	if (ret < 0)
-		goto out;
-	ret = iterate_dir_item(sctx->parent_root, sctx->right_path,
-			__process_changed_deleted_xattr, sctx);
+		return ret;
 
-out:
-	return ret;
+	return iterate_dir_item(sctx->parent_root, sctx->right_path,
+				__process_changed_deleted_xattr, sctx);
 }
 
 static int process_all_new_xattrs(struct send_ctx *sctx)
-- 
2.45.2


