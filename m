Return-Path: <linux-btrfs+bounces-5203-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8542C8CC34D
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 16:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CAB81F24020
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 14:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8EA20B34;
	Wed, 22 May 2024 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p36dXBEm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75CD1CD35
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388600; cv=none; b=sfzRxrgOC6iucz5qbUZ9vSCLNpPLuPS15eE2qP6cW0FkGpM3epPyZCf0+yTwm9qQib558//ONVF4sTR8gp9BPLn8k5M2YZUARWDEL7cHdwIORybnE+cPPMuXYSvh1fE740QJEzsNjhwvQBig4CiNFsprORzBjZd2ppa6EOmeKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388600; c=relaxed/simple;
	bh=wngFHCEBILVr6mDg4GFHWtOr/JTDvrtguz47rWx7MqU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ed/4oq2Qx9eyPfTv69Et2DdXgWdjTuuhPyXE4aP8oJHsxdI4gIi1g3ypX052kIJgHeoUi/MDdCgqKApo/WQk592/J05Smkm1s6VdfacXFXxderZidpElzB3u0Cn1y9QfyaCyAudXrS32h1/XV2FasWIobAeSyDciPy4F+CSluG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p36dXBEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B65C32782
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 14:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716388600;
	bh=wngFHCEBILVr6mDg4GFHWtOr/JTDvrtguz47rWx7MqU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=p36dXBEmEtIF3iJZEtzhuN/Rh8IfPcRQuREnSdiEBEgctaIUKwOWaEFMdJZqibcxQ
	 glRgBbGyya48qv24c/U6+YKyrTvJpdY8AypBUEHtruOCqvH7c0Vo79A/lUTTeSIw3h
	 geMK/ZcD5c7HYobQxIBM7ILBN8/nUwmXOqNjU/5XNpA+4BjMfoN3gX8f36uiOnAa0F
	 MuLJ+CB3dgIi341HaiOolQs7ZUHC84sF1f8lWmPgALbf1oKNjqB/Q8ZWM9/QF5sqFu
	 KpzAsvW1YGw6eOVaCQjGq8EYubEYHqEMGHWeLF7ivYEnG8ift79LPanNVebiBL0N0B
	 SJS1MgTPss+Iw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/7] btrfs: qgroup: avoid start/commit empty transaction when flushing reservations
Date: Wed, 22 May 2024 15:36:29 +0100
Message-Id: <64ffcb8d6fe5a406c23d517eecd91436508a6c86.1716386100.git.fdmanana@suse.com>
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

When flushing reservations we are using btrfs_join_transaction() to get a
handle for the current transaction and then commit it to try to release
space. However btrfs_join_transaction() has some undesirable consequences:

1) If there's no running transaction, it will create one, and we will
   commit it right after. This is unncessary because it will not release
   any space, and it will result in unnecessary IO and rotation of backup
   roots in the superblock;

2) If there's a current transaction and that transaction is committing
   (its state is >= TRANS_STATE_COMMIT_DOING), it will wait for that
   transaction to almost finish its commit (for its state to be >=
   TRANS_STATE_UNBLOCKED) and then start and return a new transaction.

   We will then commit that new transaction, which is pointless because
   all we wanted was to wait for the current (previous) transaction to
   fully finish its commit (state == TRANS_STATE_COMPLETED), and by
   starting and committing a new transaction we are wasting IO too and
   causing unnecessary rotation of backup roots in the superblock.

So improve this by using btrfs_attach_transaction_barrier() instead, which
does not create a new transaction if there's none running, and if there's
a current transaction that is committing, it will wait for it to fully
commit and not create a new transaction.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index a2e329710287..391af9e79dd6 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1341,12 +1341,14 @@ static int flush_reservations(struct btrfs_fs_info *fs_info)
 	if (ret)
 		return ret;
 	btrfs_wait_ordered_roots(fs_info, U64_MAX, NULL);
-	trans = btrfs_join_transaction(fs_info->tree_root);
-	if (IS_ERR(trans))
-		return PTR_ERR(trans);
-	ret = btrfs_commit_transaction(trans);
 
-	return ret;
+	trans = btrfs_attach_transaction_barrier(fs_info->tree_root);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		return (ret == -ENOENT) ? 0 : ret;
+	}
+
+	return btrfs_commit_transaction(trans);
 }
 
 int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
-- 
2.43.0


