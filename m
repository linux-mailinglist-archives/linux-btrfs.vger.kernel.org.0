Return-Path: <linux-btrfs+bounces-11582-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B46A3BD4B
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826DF173DD0
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC241EB1AF;
	Wed, 19 Feb 2025 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foURemAt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3493A1DF27F
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965428; cv=none; b=bsOz0J0WhYA+XTMuG9aO51luys86M4lFDvPkVdJpzMP29WfAmT1BPHaCWiKrhuCJc4nj0oefjst84gr66AX26W/0MpkJ4X6J8yY7FPsfdv0anMm/MwNJvm8AMTPm1P7lq8/0hFOkTRfMKfJ5PQ4n4NxZMqWP1fln6DScCUJoqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965428; c=relaxed/simple;
	bh=1JCUCDDhbrBpj9klUlZfnrC0vS8NJuYV+O9hY/74lBc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HKVOojgfLuTc3yHB+t0NOZC8peacXW2CHO88qIJ3Xg+rTTdyztFIMmeIN/pl+BQcHfUH748A3JqhOaNJ1w0JyV4C6YGdyKEcEGXjZjTf7/KOdqbP1WYERwdMJQhI39JOsX3kM+A94stZ0QtrezF4eNGURfR4MUCEGJgqMALmRHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foURemAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA7FC4CEE6
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965427;
	bh=1JCUCDDhbrBpj9klUlZfnrC0vS8NJuYV+O9hY/74lBc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=foURemAtUaXjtHZSudH4wdFVsljLGca+BZsiRI5UTyQa8jw/LJqM4hBt5h341yTY+
	 FAivAuPW7Opkwmo8m5UIit6pJ/argrWe29l79284BMtcQ4Qpf+mOBMG/quPiqaS5xG
	 Rz/IdcO8UgCKC7fJujj2tFM1PN9KPPR9/a0ZZppksD8z2EMDLI1ngrqeojO/pgSlwK
	 S8NxSJQ4ux78f8ON08tQlMXnTlam/pL2eiwDfMZ7zs/cZbDEcfrKQOa0UievAZU3F3
	 L790LJichsC1cdx61GO5mLj2BHWve+0uEsAPlbrSzBATX4s1uy1bGLRRs/FUfCiWeZ
	 9jDxsuhx4yOuQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 17/26] btrfs: send: simplify return logic from record_deleted_ref_if_needed()
Date: Wed, 19 Feb 2025 11:43:17 +0000
Message-Id: <ad6325433112c151e9f8d9eef01901b3c08f1007.1739965104.git.fdmanana@suse.com>
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
index 96aa519e791a..b715557ec720 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4712,7 +4712,7 @@ static int record_new_ref_if_needed(u64 dir, struct fs_path *name, void *ctx)
 
 static int record_deleted_ref_if_needed(u64 dir, struct fs_path *name, void *ctx)
 {
-	int ret = 0;
+	int ret;
 	struct send_ctx *sctx = ctx;
 	struct rb_node *node = NULL;
 	struct recorded_ref data;
@@ -4721,7 +4721,7 @@ static int record_deleted_ref_if_needed(u64 dir, struct fs_path *name, void *ctx
 
 	ret = get_inode_gen(sctx->parent_root, dir, &dir_gen);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	data.dir = dir;
 	data.dir_gen = dir_gen;
@@ -4735,7 +4735,7 @@ static int record_deleted_ref_if_needed(u64 dir, struct fs_path *name, void *ctx
 					 &sctx->deleted_refs, name, dir,
 					 dir_gen, sctx);
 	}
-out:
+
 	return ret;
 }
 
-- 
2.45.2


