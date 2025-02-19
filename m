Return-Path: <linux-btrfs+bounces-11581-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7A0A3BD52
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6216D3B0860
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B88E1E0DE5;
	Wed, 19 Feb 2025 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKpkjDRd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31C41EB19D
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965426; cv=none; b=L8Ndy25EhNP5+TkwAgrJRaEqh4yOcE8BA2+5Dzd8yaM4zBv7/WN0MndrSGUiDt3Arb1OUM5TuiHqkuwNm1q4nR0GQ6XoJfJAWoq0eH5M+Vp1CRDHIHWGnr2XTSiGv2jiM+ORLTmLo9klUuMrCH+0Sw0wRCShfpbave6vV3XKOLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965426; c=relaxed/simple;
	bh=THpErzxIZlA7QdlBQjpr5bQsJcE1FHd68W0QxJlpsYI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LEDmKoxZYAzUOupvntQhdngkxKUwx/hdgWuc7eisS7yn270l3o2NPgINVEGsjJzkfRSLZGBBzHlPKOrtxsNZQjDx/3Lg2dnn7mrBD4AVo9M9yPDETAHWrRPoW10gB7AT4/vv+rTopABfYBUACLntfjPKR3AS6wm2c3Hpg/YaZsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKpkjDRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2826BC4CED1
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965426;
	bh=THpErzxIZlA7QdlBQjpr5bQsJcE1FHd68W0QxJlpsYI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MKpkjDRdatSlOMcxFHnCQ6+KSFxFGLnsOXVhgguHw2czUiV5glYmqXUT/xp4qUqYV
	 Z6uKWwJPvmOYDFFT1tSBxMNeWPmF6Ky+fs7QvSJe3iumBb06C6aMns8PtrxK8B1ZCX
	 Rn8ux+Z7Ctg8w5p3Z1K51RL7k/ZakOVvrYHQZnK4COY4eHK2dozCqhPNSJzTpCjziO
	 Jwn2nGYmtgr7sqxClWWvI5SCBsp1z7b42i567pEvWTtBqPksuaLWOgKRXmjyX1gG7I
	 aH0Oi+M/Py3XRBEyRlY5V7bgdrO9WYMRnfPBH/A16m50edBJUmf1bkNQgpfDtf4Let
	 7Qqyzs5YLuyEQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 16/26] btrfs: send: simplify return logic from record_new_ref_if_needed()
Date: Wed, 19 Feb 2025 11:43:16 +0000
Message-Id: <ea0914ce17d666a6cd0e55d09046d2bd92cea7ec.1739965104.git.fdmanana@suse.com>
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
 fs/btrfs/send.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 5fd3deaf14d6..96aa519e791a 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4683,7 +4683,7 @@ static int record_ref_in_tree(struct rb_root *root, struct list_head *refs,
 
 static int record_new_ref_if_needed(u64 dir, struct fs_path *name, void *ctx)
 {
-	int ret = 0;
+	int ret;
 	struct send_ctx *sctx = ctx;
 	struct rb_node *node = NULL;
 	struct recorded_ref data;
@@ -4692,7 +4692,7 @@ static int record_new_ref_if_needed(u64 dir, struct fs_path *name, void *ctx)
 
 	ret = get_inode_gen(sctx->send_root, dir, &dir_gen);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	data.dir = dir;
 	data.dir_gen = dir_gen;
@@ -4706,7 +4706,7 @@ static int record_new_ref_if_needed(u64 dir, struct fs_path *name, void *ctx)
 					 &sctx->new_refs, name, dir, dir_gen,
 					 sctx);
 	}
-out:
+
 	return ret;
 }
 
-- 
2.45.2


