Return-Path: <linux-btrfs+bounces-11648-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D57A3D7BC
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8FC317E7C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1521F3FD1;
	Thu, 20 Feb 2025 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hy8y5qmR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6771F3D54
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049501; cv=none; b=qTX0q0PEx+QnQSNqV6X7+knS8UpWtnWr0mq4jaCfY7iB2Rla+JSJBAHERAIbLACakYI6QUH1mcPZSgPlvQrf5RnTm7aedgla9AyaJ2GoN/MFbEHnM39ZLqddj4IR7bfAen5JYdlSrKWE/xJ25pNzkS6ghAQJU9YDqJZRofio5YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049501; c=relaxed/simple;
	bh=9hxk+7ErPnp6CkqDnLiQhSsA+nXDmhR3kp3A7y4ud6c=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lfNjyB8jEtHY8m470NQSFbqqp+x731LBgB8YzRuEcdpqqM/BLkA0F3qwKdeHNIsCUQquHfzfQMN/v00fZhGgjk6+lq1i2D5dR1z/PKoW/zopcaXkIuuNdMYKWrtMgAEFFqL+tNwl0u0oPgET3wLHvgZuralwZ/9z3oK+FlUd624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hy8y5qmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662A0C4CEE3
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049501;
	bh=9hxk+7ErPnp6CkqDnLiQhSsA+nXDmhR3kp3A7y4ud6c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hy8y5qmRUOK1P6c+hf0nix9aseLMS3YLBSBm9a+D82tvp8tOZ/DrKjKXHwEYpKRV4
	 eq0DKMpEhm5ZztkKn0PM70vd06wEC/I9MDYLsJMislbo/SQ2MwJ70XdrGS8oBVmBCu
	 KzuGCgZ1x8mV265x4ALTgaIJfkfcNpRAXlwpfTR6ZoG9SKQuwZ5hHal0HPuvGbi3tH
	 sacJR9JVRL4f30H8b1bpjtipSqElBjz+omkcLmVeI23JCD8MJpLWzP2jdu/YC6Il+5
	 ChaYgZwPcZbuOJFLX/FWFEccTKrU4oNENcJiNrVgSsgAF3fU5RmOvO4Ap+eUjwDxIR
	 wY0lS0P9IWAcA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 13/30] btrfs: send: only use booleans variables at process_recorded_refs()
Date: Thu, 20 Feb 2025 11:04:26 +0000
Message-Id: <11df18fd97e1723b2d0135b0912f64f739dc215d.1740049233.git.fdmanana@suse.com>
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


