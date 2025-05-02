Return-Path: <linux-btrfs+bounces-13613-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A132FAA6FA5
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 12:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EFB94A80A2
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 10:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D83242D72;
	Fri,  2 May 2025 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRI5T4s4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA09B6EB79
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181835; cv=none; b=LhVpYgzVfweAfEDuW8jzzPplexbb+zQQ7UMjuUmwF1LWTy9WEbHhFgmr1kEqEseCorTHMWp/Ao1OlcWK8y1zlL1bQhAPfd9H8qoirvoJLaonV2EtJLpD3+Xzf61OwSY0SzfLyI/OQZU+CNGHjdLZAgDGoFH7QxGwi47Gw+SxsfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181835; c=relaxed/simple;
	bh=pFwxwkxUf3orjm1ngapiN5fQbcZSUFRDqWYBeQOU5hY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SxRhlBeGCZ4vdgY1lLMJPy2Ukp8V2MNddduPqpHnBeLpwDhLHpYfZMU5oTjMnX1GwU9eWsK1lWVosMY7A6Mj3+nvlm5XjtTGwJX8yhYqL51jVLBeyyN/u1hkNJIEuG77oh6CwJI8bI4f5M9P52vGyIHLXo1UFCw8U6+BCWYyFLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRI5T4s4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01D0C4CEE4
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746181835;
	bh=pFwxwkxUf3orjm1ngapiN5fQbcZSUFRDqWYBeQOU5hY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dRI5T4s4hI6EDUdeioNtzAraDIrBZCupUQU/h7v+3MZbHIeLFdseUAkPe+G41fNyO
	 tJQkCX4lKBNBZsJyeuQQdoPGFx0IjaxWCFMH+0uRfuSFvUc5NMqMPmYoo4RBqtFAJK
	 OxN7XWU7SHzj+3HiDwexJ7vDKvBFhfCgpPzuvtdLZcPyZGTiQmS1uYQlN8pg1A8CJZ
	 qIFnvm2CZ/NEuinpQUGXIgjigsG123CT84aPQJF8+eaXBjFkW/EcTDdKWQ9vwD3D3t
	 K2gYiay9dG3Hsc7Ghr2KYtYzPVRHa2HHVdMiY2HcWYEwQ3Wj9wkxto+cEWz9K7OWdT
	 v98092QDLz/ig==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/8] btrfs: simplify cow only root list extraction during transaction commit
Date: Fri,  2 May 2025 11:30:23 +0100
Message-Id: <58cf31b722e6ac42934f886b8a9d53138692b8e6.1746181528.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746181528.git.fdmanana@suse.com>
References: <cover.1746181528.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to keep a local variable to extract the first member of
the list and then do a list_entry() call, we can use list_first_entry()
instead, removing the need for the temporary variable and extracting the
first element in a single step.

Also, there's no need to do a list_del_init() followed by list_add_tail(),
instead we can use list_move_tail(). We are in transaction commit critical
section where we don't need to worry about concurrency and that's why we
don't take any locks and can use list_move_tail() (we do assert early at
commit_cowonly_roots() that we are in the critical section, that the
transaction's state is TRANS_STATE_COMMIT_DOING).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index fe79d65c8635..e0256eecf176 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1326,7 +1326,6 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct list_head *dirty_bgs = &trans->transaction->dirty_bgs;
 	struct list_head *io_bgs = &trans->transaction->io_bgs;
-	struct list_head *next;
 	struct extent_buffer *eb;
 	int ret;
 
@@ -1362,13 +1361,13 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 again:
 	while (!list_empty(&fs_info->dirty_cowonly_roots)) {
 		struct btrfs_root *root;
-		next = fs_info->dirty_cowonly_roots.next;
-		list_del_init(next);
-		root = list_entry(next, struct btrfs_root, dirty_list);
+
+		root = list_first_entry(&fs_info->dirty_cowonly_roots,
+					struct btrfs_root, dirty_list);
 		clear_bit(BTRFS_ROOT_DIRTY, &root->state);
+		list_move_tail(&root->dirty_list,
+			       &trans->transaction->switch_commits);
 
-		list_add_tail(&root->dirty_list,
-			      &trans->transaction->switch_commits);
 		ret = update_cowonly_root(trans, root);
 		if (ret)
 			return ret;
-- 
2.47.2


