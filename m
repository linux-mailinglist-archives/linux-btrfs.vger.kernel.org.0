Return-Path: <linux-btrfs+bounces-11578-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1B9A3BD48
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3BA17348B
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4611EA7FB;
	Wed, 19 Feb 2025 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcoCYo73"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C238D1E9B0B
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965423; cv=none; b=c3n4byCtqMEXcAOpyHgV7OLlXaFmvuC5qk+hw//n6HpIFQ7Ru66xQO+hd1aMQp7AHbU9HUbpUfDanwfcHwK7qmcwqcYOFHm4YjGTECPQV9vIAmIfcKOL9VycjFRmxv4vXNk5l3Np/aCnL/7hBYk3odr7P36vz0Ivl3ZV5OAOldg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965423; c=relaxed/simple;
	bh=9hxk+7ErPnp6CkqDnLiQhSsA+nXDmhR3kp3A7y4ud6c=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mausvHOxqQQo8JN4KMF4iMn3d7cSv8yOPAVuBR16jleQhO21HITgrKJ8k9gkbeuu+MHF1jyTknyUKJbDH3ChMfd5S/LUwijVbzymTSj936JetB31U61R5ytf9aD/LyH2PEAoVN4ulqQwOvFuB9DrHJWG8N0MZGItKXa6xNOcFTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcoCYo73; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1731BC4CEE7
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965423;
	bh=9hxk+7ErPnp6CkqDnLiQhSsA+nXDmhR3kp3A7y4ud6c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DcoCYo73a3gOaoSgo19b216VcPlT7/YvK8QcNvdOZ9QbHbTLpKsx5Y4BRGT//Y78z
	 yJtrSmmCInr68Rdx5airjahUXA0bud2LXiQOMcQhRj26SSXvl/2ekNNP/OV3ESRptD
	 IedzLgaG7prIjYXDhLQF4XmqG6Njwd2xV87SB+9k84S6C3++DnyEaioNNTnb55QqCq
	 xqG1tllnzvz4+rqe3WXGZNyv36kajXl1JPHd6+8z42keyZDYVvuvrPrTQQVGQawHVb
	 /ZS8M2mVepO5mbCvJHprINkuMIqqNOSiIIrESomw+TX1/R844+GuruJ18P+TlAJwoz
	 dRPI/EfEuOKXg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 13/26] btrfs: send: only use booleans variables at process_recorded_refs()
Date: Wed, 19 Feb 2025 11:43:13 +0000
Message-Id: <9569f7e861f4f3fcb793a0752aaddfaaadb6a03a.1739965104.git.fdmanana@suse.com>
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

We have several local variables at process_recorded_refs() that are used
as booleans, with some of them having a 'bool' type while two of them
having an 'int' type. Change this to make them all use the 'bool' type
which is more clear and to make everything more consistent.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 3aa2877f8c80..6e27a7d77b25 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4147,9 +4147,9 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 	u64 ow_inode = 0;
 	u64 ow_gen;
 	u64 ow_mode;
-	int did_overwrite = 0;
-	int is_orphan = 0;
 	u64 last_dir_ino_rm = 0;
+	bool did_overwrite = false;
+	bool is_orphan = false;
 	bool can_rename = true;
 	bool orphanized_dir = false;
 	bool orphanized_ancestor = false;
@@ -4191,14 +4191,14 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 		if (ret < 0)
 			goto out;
 		if (ret)
-			did_overwrite = 1;
+			did_overwrite = true;
 	}
 	if (sctx->cur_inode_new || did_overwrite) {
 		ret = gen_unique_name(sctx, sctx->cur_ino,
 				sctx->cur_inode_gen, valid_path);
 		if (ret < 0)
 			goto out;
-		is_orphan = 1;
+		is_orphan = true;
 	} else {
 		ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen,
 				valid_path);
@@ -4421,7 +4421,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 			ret = send_rename(sctx, valid_path, cur->full_path);
 			if (ret < 0)
 				goto out;
-			is_orphan = 0;
+			is_orphan = false;
 			ret = fs_path_copy(valid_path, cur->full_path);
 			if (ret < 0)
 				goto out;
@@ -4482,7 +4482,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 					sctx->cur_inode_gen, valid_path);
 			if (ret < 0)
 				goto out;
-			is_orphan = 1;
+			is_orphan = true;
 		}
 
 		list_for_each_entry(cur, &sctx->deleted_refs, list) {
-- 
2.45.2


