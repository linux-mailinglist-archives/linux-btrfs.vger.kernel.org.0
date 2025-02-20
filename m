Return-Path: <linux-btrfs+bounces-11649-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20FAA3D7BE
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C9E17E909
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ED61F3FF5;
	Thu, 20 Feb 2025 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adpuROAK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0F81F3FD3
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049502; cv=none; b=gFbpcxIqQ6B1pDbJm8aobj4oNHMld2kv/Dow1WVCPBblWrW7DbBvqyndIf7maDNz2JXT1IBPFpZIZ4NhUxjm6dfeq+mWFkna5jIxxyOL9CrQkpU7xE7qnIfICmlWezShnHvdYRGYxv28R00UmSKiHzXcqr+BF6u9gx+kbjYDprg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049502; c=relaxed/simple;
	bh=rKG84Dm+qgA2a8K8nJHKowtWopfIOurS1J8H/BWnAXQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UGXgpINsyGPORMLftkwQ1vAe9TGcN3Mc+1eTk6Khi3m2fATxw8PlAQSJB9DTtnE6wGS6ELLSEYCeZn0r0C++aFCyNhHVnB8XG0nMGvxnBVZrZcuzZwNSInSAHn7/nyCIfjbJyprOiPcl+NM3S5vyWF3qWtuYwv0HXr+nnnSAAfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adpuROAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB3DC4CEE4
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049502;
	bh=rKG84Dm+qgA2a8K8nJHKowtWopfIOurS1J8H/BWnAXQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=adpuROAKSnCJ8WljcCtoxfH80EFLfSAUQxdkqQp3gA+VcZCBJz3nYL9VCcK2yNgRu
	 GtWacV29vqVTLx7BKmBPZa/A0A9UPpPCBBkQPh2w3vWRu+TF3AlRYM6ev3+pRr119a
	 l4G75rl879IoWsY1hPoshTzUt+2NrdBqCKHsoQkdezTBGTStmLwrl+DwBYNzn91enS
	 9Vuq+HHDygxuz3ND7Opiw7YEhlZRRYmbwBLae0DwsMvNhZt+2c5I81OnLaWyOVfJzH
	 ZRAHSv/cqM6QKSZaQL0s4nDIj9RmqRQIf2fTaWNt9YDM/nu3kyq3afOj8rPu2EUjrL
	 84vinWrS7JZpQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 14/30] btrfs: send: add and use helper to rename current inode when processing refs
Date: Thu, 20 Feb 2025 11:04:27 +0000
Message-Id: <0ad5ae9dee056f6b70b70e9175ba80cfab69c63c.1740049233.git.fdmanana@suse.com>
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

Extract the logic to rename the current inode at process_recorded_refs()
into a helper function and use it, therefore removing duplicated logic
and making it easier for an upcoming patch by avoiding yet more duplicated
logic.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 6e27a7d77b25..653e0b9a94ca 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4133,6 +4133,19 @@ static int refresh_ref_path(struct send_ctx *sctx, struct recorded_ref *ref)
 	return ret;
 }
 
+static int rename_current_inode(struct send_ctx *sctx,
+				struct fs_path *current_path,
+				struct fs_path *new_path)
+{
+	int ret;
+
+	ret = send_rename(sctx, current_path, new_path);
+	if (ret < 0)
+		return ret;
+
+	return fs_path_copy(current_path, new_path);
+}
+
 /*
  * This does all the move/link/unlink/rmdir magic.
  */
@@ -4418,13 +4431,10 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 		 * it depending on the inode mode.
 		 */
 		if (is_orphan && can_rename) {
-			ret = send_rename(sctx, valid_path, cur->full_path);
+			ret = rename_current_inode(sctx, valid_path, cur->full_path);
 			if (ret < 0)
 				goto out;
 			is_orphan = false;
-			ret = fs_path_copy(valid_path, cur->full_path);
-			if (ret < 0)
-				goto out;
 		} else if (can_rename) {
 			if (S_ISDIR(sctx->cur_inode_mode)) {
 				/*
@@ -4432,10 +4442,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 				 * dirs, we always have one new and one deleted
 				 * ref. The deleted ref is ignored later.
 				 */
-				ret = send_rename(sctx, valid_path,
-						  cur->full_path);
-				if (!ret)
-					ret = fs_path_copy(valid_path,
+				ret = rename_current_inode(sctx, valid_path,
 							   cur->full_path);
 				if (ret < 0)
 					goto out;
-- 
2.45.2


