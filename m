Return-Path: <linux-btrfs+bounces-5206-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F1C8CC350
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 16:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A37B1B239E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 14:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA0A26AD8;
	Wed, 22 May 2024 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3qZIQx3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FC52374C
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388604; cv=none; b=B1YRb8RPi8Js9yyl0LMreyzOLgs5UbEw+PF6e5Sfd2bFLrVBC9y1d/Pa1ulbPvRSxwOR2bvv7kzmsfoA7OGzssnJnB/x/zrvFpcgJJT5YTEsFfq+FgoInVUt64gUap2Oj/YNqVGzlOPQ8aP5F/GshuoVFLTUDK+/rT0KgFR9LMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388604; c=relaxed/simple;
	bh=6IRuYllH1yzVZnG8MNZ9EDWBPfbdUX234D3tFclU5oc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JYfGv/UAdQ8AV7nEg4+wBSdIsHk0IMFsASgpMhXjoO9sDksDPBWnOBxmAOsC7PBQGuUJtJiSquw+vLZZHn8dzjbB3GYNdvP6P7wYAOx632jGdgoyJv0xp/wkL2veyglWt4TJqYr/5i9xY9c85NcojhoFpmc4WZkEa5z/w/piifA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3qZIQx3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356C4C2BBFC
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 14:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716388603;
	bh=6IRuYllH1yzVZnG8MNZ9EDWBPfbdUX234D3tFclU5oc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=l3qZIQx3bcOGwojSrwahf/3mH5rWxTu4Ro9UUoQIN0Rt4qCJyrc96D5MoZq+ZOiqz
	 OtFLaHlOvcpwWkjNMBkxEFU9o6M76VnGliGIyEX8nN+/BxNFDCWaSkd+/HADRfWc9L
	 QoO4fRk1qkmA5KDjrbqGCS7pJdmbRLiIH/e4xsV2S04PApsRyQJm41sOro370Pu1m8
	 1MpWqZOD45TUkKSvX+26M4cTK4Oc7UM+jUPoJQ70EZZvZzZHhteXJealOJecxYK0Tg
	 50B4En2vqWGoQFjnwODfpAsPHu+jqiLQVSHPhgcmSlxqoXpAtBvm/nEHDXH64fMcOK
	 BMD1/Hz6Rzogw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/7] btrfs: send: avoid create/commit empty transaction at ensure_commit_roots_uptodate()
Date: Wed, 22 May 2024 15:36:32 +0100
Message-Id: <a2695c7c931501cce57045455749f83f457f9f22.1716386100.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716386100.git.fdmanana@suse.com>
References: <cover.1716386100.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At ensure_commit_roots_uptodate() we use btrfs_join_transaction() to
catch any running transaction and then commit it. This will however create
a new and empty transaction in case there's no running transaction anymore
(got committed by the transaction kthread or other task for example) or
there's a running transaction finishing its commit and with a state >=
TRANS_STATE_UNBLOCKED. In the former case we don't need to do anything
while in the second case we just need to wait for the transaction to
complete its commit.

So improve this by using btrfs_attach_transaction_barrier() instead, which
does not create a new transaction if there's none running, and if there's
a current transaction that is committing, it will wait for it to fully
commit and not create a new transaction. This helps avoiding creating and
committing empty transactions, saving IO, time and unnecessary rotation of
the backup roots in the super block.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 2c46bd1c90d3..289e5e6a6c56 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -8018,9 +8018,12 @@ static int ensure_commit_roots_uptodate(struct send_ctx *sctx)
 	 * an unnecessary update of the root's item in the root tree when
 	 * committing the transaction if that root wasn't changed before.
 	 */
-	trans = btrfs_join_transaction(root);
-	if (IS_ERR(trans))
-		return PTR_ERR(trans);
+	trans = btrfs_attach_transaction_barrier(root);
+	if (IS_ERR(trans)) {
+		int ret = PTR_ERR(trans);
+
+		return (ret == -ENOENT) ? 0 : ret;
+	}
 
 	return btrfs_commit_transaction(trans);
 }
-- 
2.43.0


