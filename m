Return-Path: <linux-btrfs+bounces-17077-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57299B904E0
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 13:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0403B67BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 11:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F13A2F549E;
	Mon, 22 Sep 2025 11:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzhQshrG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A2192B66
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758539358; cv=none; b=VohpCUN9SoKZrVk+bosZ9DYpPPVC2EDZtXSvZAV26GVDNSJFdBoMxaRDQnVikpmB3mQZfkQf1QCIL/YC22gc5MxUdJoCPb5ZzPJNb5VGvjQKRHhPlfwb21vvqmvI5PnHoRjLwNunB30rATSiwsY4v4bUTxnvu23NERqwmJIz0lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758539358; c=relaxed/simple;
	bh=ipMwVn5dfpU4WKGjvpp10fagh8cXOT4ZTdh/sBKtqfw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TYprZTlGup57dLVcQYH2o5OLynMg0/x+K/aPvSiGOvhFBsXt9FU9ZnwW4Y6R0zpkgYv5YD6uZzubPdQILBZMtlWxQql+WSc7ODp9HhehVcs/iipos6gAoCkjUJmPP/XGspiXgzlUyLuX8iReYhXcSMy55yknVT+DozRrlZ+xfZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzhQshrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3ECC4CEF0
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 11:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758539358;
	bh=ipMwVn5dfpU4WKGjvpp10fagh8cXOT4ZTdh/sBKtqfw=;
	h=From:To:Subject:Date:From;
	b=hzhQshrGjewNC8a+YUYr4aKxqImfajhDX+/kiuE7N/VUAGuGYdR2iwjfg2Vii1dpJ
	 msort0gIePzLDlCvivNrdf3VmkIgrtrdGlpWArTwGx9ZRqPLqDudGJZijdANuKnouT
	 zXzjMwljqyzdUD+GHHTNVLuAVkbksSJT+bmrlkUbPwkYiUYXaqaQsc1rFM/pt4TaWg
	 gMIG4GrjkrvkhhLG87zOnymK3aIlQEBUEaSVcoXlui5PClIjj6dWROTkcMvQc01rC/
	 QZqvFKzHuapcmtYdoc4jyjP6O0QYJRW0hH1PXSHeTvuryGeakJ28iQzdCK/ywide+D
	 yQdRH5+kamzqQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use smp_mb__after_atomic() when forcing COW in create_pending_snapshot()
Date: Mon, 22 Sep 2025 12:09:14 +0100
Message-ID: <93f9c23fb920308905ae091cbcccfa01baff4780.1758539345.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

After setting the BTRFS_ROOT_FORCE_COW flag on the root we are doing a
full write barrier, smp_wmb(), but we don't need to, all we need is a
smp_mb__after_atomic().  The use of the smp_wmb() is from the old days
when we didn't use a bit and used instead an int field in the root to
signal if cow is forced. After the int field was changed to a bit in
the root's state (flags field), we forgot to update the memory barrier
in create_pending_snapshot() to smp_mb__after_atomic(), but we did the
change in commit_fs_roots() after clearing BTRFS_ROOT_FORCE_COW. That
happened in commit 27cdeb7096b8 ("Btrfs: use bitfield instead of integer
data type for the some variants in btrfs_root"). On the reader side, in
should_cow_block(), we also use the counterpart smp_mb__before_atomic()
which generates further confusion.

So change the smp_wmb() to smp_mb__after_atomic(). In fact we don't
even need any barrier at all since create_pending_snapshot() is called
in the critical section of a transaction commit and therefore no one
can concurrently join/attach the transaction, or start a new one, until
the transaction is unblocked. By the time someone starts a new transaction
and enters should_cow_block(), a lot of implicit memory barriers already
took place by having acquired several locks such as fs_info->trans_lock
and extent buffer locks on the root node at least. Nevertlheless, for
consistency use smp_mb__after_atomic() after setting the force cow bit
in create_pending_snapshot().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index febf456a9ab0..6707d6ffd80b 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1802,7 +1802,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	}
 	/* see comments in should_cow_block() */
 	set_bit(BTRFS_ROOT_FORCE_COW, &root->state);
-	smp_wmb();
+	smp_mb__after_atomic();
 
 	btrfs_set_root_node(new_root_item, tmp);
 	/* record when the snapshot was created in key.offset */
-- 
2.47.2


