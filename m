Return-Path: <linux-btrfs+bounces-14081-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38732ABA0B3
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 18:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEB217B0A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 16:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80B519007D;
	Fri, 16 May 2025 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qne2YjmR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C991FAA
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747412361; cv=none; b=XTWDBVhipLbZJu+wSnX5filwPH9i+fHbY8H0B+7CVSuXjO3y7B5LkXVKci/puXJvxX+BBQwK/m7mxMsv5PJlR/gonWhFWkf/VEJCABYk4UpdAiQhpE94PBsY7oGt8XHm603UtXQ0bAPHw8c7ul889lqqm+Is84E1ZS049XIXRPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747412361; c=relaxed/simple;
	bh=6S55mZUf4AftKadgQbz0wLr8sIA6JGpzHItcAYleiZ4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=RZAvK+lRSsGm3evCnYVAg/iApFYzGc00ctcgcG5Su31o5x6iS7g6EQ1Cnu69Iao2GD5KqTV4omRXeNB7x7MVz8WIbt1gRl/Qn+wZy1V6LTOW1g79Rg6Vrw4YpAAn5H+uvcJ5LmNVUuKY8Fcsv5aEJ93yFaYjqX70iJi4yEVa4wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qne2YjmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5E2C4CEE4
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 16:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747412358;
	bh=6S55mZUf4AftKadgQbz0wLr8sIA6JGpzHItcAYleiZ4=;
	h=From:To:Subject:Date:From;
	b=Qne2YjmRQV+VqEu2G52n6q9znnvKnLy828+OygTasSrbetVrHL/XCS6Y0P0YYIVfW
	 Fafxz0nJ4YOW+K4QJpcqmDzV+Pns95F+2cmejWdScdlCb7vhr9w3wFZA93UXbv2i8o
	 BZdzZ2Ld5Kfy2XndX9fieTT1qR57k1CXhc/stB+4CbT+rig8O9Wzj/vThxNzDrbdBf
	 mSauu3VXOuSr0YZx6zhktbCOTAN/p1GG194WUea06f++vQW3CEylzdzvr6FlJF+IVO
	 roVYmzuFHzjWBia1gKGEno4pUvrCscICxVGUNB9i03ifRP2ErT/gM9Eyxd7uMQ8dti
	 +NrVEzSZXDxtA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: unfold transaction aborts at btrfs_create_new_inode()
Date: Fri, 16 May 2025 17:19:15 +0100
Message-Id: <32127d7f66702d0b80132bea776e214077b42872.1747412285.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of having a common btrfs_transaction_abort() call for when either
btrfs_orphan_add() failed or when btrfs_add_link() failed, move the
btrfs_transaction_abort() to happen immediately after each one of those
calls, so that when analysing a stack trace with a transaction abort we
know which call failed.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c0c778243bf1..7d27875600d6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6610,13 +6610,17 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 
 	if (args->orphan) {
 		ret = btrfs_orphan_add(trans, BTRFS_I(inode));
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto discard;
+		}
 	} else {
 		ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode), name,
 				     0, BTRFS_I(inode)->dir_index);
-	}
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto discard;
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto discard;
+		}
 	}
 
 	return 0;
-- 
2.47.2


