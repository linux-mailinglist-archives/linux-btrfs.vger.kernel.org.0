Return-Path: <linux-btrfs+bounces-14083-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF730ABA0D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 18:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC02D3A8A94
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 16:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AE01C9EB1;
	Fri, 16 May 2025 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8KnFJY2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E02224F6
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747413301; cv=none; b=dRjm4Iehwu119wjNC0i3jmTdq40CuBqcXLSDM3yp0uh3nikzeoT9UjeN3pTlhXRey5WtvJR3oTnhRcgk0Uotddm6E0mxoVXnxdqBvs37NL5sWfI9y1SJE/47n6ulqxkwUA47CuFrgoZS/xOjenMU3gf1F+Vz5go5shT573iKTMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747413301; c=relaxed/simple;
	bh=nDeKzr+RtD4BMVMIAd4f39wfhyGVANBzAn29cckAMF4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=hiHT8crJ5qZMAVhrUhTnaeFyp9uStH/MLBK+tDoKC3JRJ4LAdGOKGhD9SRMEeUtB2Iv2KycRuMmm1wECXP0mZZklqnVDMJekQ3fjvfOHpwTJtMyBJmSW8TQxcqnrr/JVm8kg0ITu4h3mLl5tEQL8CZ+pT16qRM8qkhM+5UgtsCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8KnFJY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FD2C4CEE4
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 16:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747413301;
	bh=nDeKzr+RtD4BMVMIAd4f39wfhyGVANBzAn29cckAMF4=;
	h=From:To:Subject:Date:From;
	b=K8KnFJY2FyalwoqaOX430fyqD/SRPJa0f1Oo7CuwLtBIP69TYXzyUfTWTGcpOJgLv
	 5xVDFzz87YnZE5qc6MW7QKR36ojb2mxeUX70/fmuHGsPXqIUGODkj1+mLpktH6oLEU
	 sAeltCaGvnDMc3KHcbOgaXBzlXhX8QzgsvYSB5yeXKA632q9m/DGZoEftya6rqhrqn
	 O0M8cmJVfbrzKVjhSxE7tIl0soDVLVmon1uMu/oL+yv74Nx3jRJqDt2/FkXOCsgAJ4
	 h/0YLxd8ek6i+rda99WfnKVD2JCGEL1c9BHaY1oNsqMuL6jCL6S7Hj/olN9Z7jULdZ
	 mRgROhIBOjCLQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: unfold transaction abort at __btrfs_inc_extent_ref()
Date: Fri, 16 May 2025 17:34:58 +0100
Message-Id: <56bea892fbeb023b89ac362c3882c80181372f7a.1747412853.git.fdmanana@suse.com>
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
insert_tree_block_ref() failed or when insert_extent_data_ref() failed,
move the btrfs_transaction_abort() to happen immediately after each one of
those calls, so that when analysing a stack trace with a transaction abort
we know which call failed.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index cb6128778a83..678989a5931d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1522,13 +1522,15 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 	btrfs_release_path(path);
 
 	/* now insert the actual backref */
-	if (owner < BTRFS_FIRST_FREE_OBJECTID)
+	if (owner < BTRFS_FIRST_FREE_OBJECTID) {
 		ret = insert_tree_block_ref(trans, path, node, bytenr);
-	else
+		if (ret)
+			btrfs_abort_transaction(trans, ret);
+	} else {
 		ret = insert_extent_data_ref(trans, path, node, bytenr);
-
-	if (ret)
-		btrfs_abort_transaction(trans, ret);
+		if (ret)
+			btrfs_abort_transaction(trans, ret);
+	}
 
 	return ret;
 }
-- 
2.47.2


