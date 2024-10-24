Return-Path: <linux-btrfs+bounces-9132-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0AD9AEBDC
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 18:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C031C22219
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 16:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8691F8184;
	Thu, 24 Oct 2024 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onJ61VzK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A411F8182
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787073; cv=none; b=M+SN7vf4Re8i4GJ3anc28wGEjOHiz88HjWb8E5rOzokKa0Yp+6Mp4Kq5lWZjhoJMqJqmm2CyGxSKocBkBsxv+8AnVmBIJgwBze80AxoYhV0EEi9wm3HsoGb3lFH93bAG0sMtVubYmiEN0KU67NmfuDyovug4+yP2K2dDTg4EP9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787073; c=relaxed/simple;
	bh=RCmnZeF3tNkZsxaMOLbjO0zYkvZiDhN0E/39zcGBjQE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kEmBosM6/VcgeB0uv1DRTp8OEy+Oqr4n29P73rYQN+qSNfj+/HnTHFXtX/JAhjh3MuQwHBjBfpPGDRigktnUUg3hmnqdKVB+jow+Kti8/SGtpiKzQX1EBs2S0Gw7WQqd2Kt/Uyzt2QnjWILtfxxN680OQyK+n7xiMew/pl2ihS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onJ61VzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B9BC4CEE4
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787073;
	bh=RCmnZeF3tNkZsxaMOLbjO0zYkvZiDhN0E/39zcGBjQE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=onJ61VzKuz2UCKlvW0T3BI9yX9Jv5ckk9Gtw7P/3tMSyn/Q+zB/izuVm1Oi/NWrpe
	 DJKmEx/bEQKQUbs8SD5KyJqjqBZS/On4OSoxifvNUVPkQtXUWOXDMk5n7jjrnT9OXr
	 +syGp0j+b4TTnzPtGVgkXSvyjFomgwxaQCEGAn7Nj7KBWlvCXWpidGGATciTuRzW6y
	 DtIjJyPSHIAs2VjqF7V9IcxpZ8AHm401Z1KIu+lJnynQHLqbo479cRxIZbAyDrBns8
	 7j8kMHbo3/4TjNFCvshH5PVXDQkcxv1vu31TPTG8yOuib7t6jQVBtlzCbU5dnNU9Xh
	 woLRBvTlTKmyw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 03/18] btrfs: remove fs_info parameter from btrfs_destroy_delayed_refs()
Date: Thu, 24 Oct 2024 17:24:11 +0100
Message-Id: <51b1c025d8ed8c1345b66f67f66d1401dca8bd57.1729784712.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729784712.git.fdmanana@suse.com>
References: <cover.1729784712.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The fs_info parameter is redundant because it can be extracted from the
transaction given as another parameter. So remove it and use the fs_info
accessible from the transaction.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 4 ++--
 fs/btrfs/delayed-ref.h | 3 +--
 fs/btrfs/disk-io.c     | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 3ac2000f394d..4dfb7e44507f 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1239,11 +1239,11 @@ bool btrfs_find_delayed_tree_ref(struct btrfs_delayed_ref_head *head,
 	return found;
 }
 
-void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
-				struct btrfs_fs_info *fs_info)
+void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans)
 {
 	struct rb_node *node;
 	struct btrfs_delayed_ref_root *delayed_refs = &trans->delayed_refs;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 
 	spin_lock(&delayed_refs->lock);
 	while ((node = rb_first_cached(&delayed_refs->href_root)) != NULL) {
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index ccc040f94264..cc78395f2fcd 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -399,8 +399,7 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info);
 bool btrfs_find_delayed_tree_ref(struct btrfs_delayed_ref_head *head,
 				 u64 root, u64 parent);
-void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
-				struct btrfs_fs_info *fs_info);
+void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans);
 
 static inline u64 btrfs_delayed_ref_owner(struct btrfs_delayed_ref_node *node)
 {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f5d30c04ba66..2e15afa9e04c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4748,7 +4748,7 @@ void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans,
 		list_del_init(&dev->post_commit_list);
 	}
 
-	btrfs_destroy_delayed_refs(cur_trans, fs_info);
+	btrfs_destroy_delayed_refs(cur_trans);
 
 	cur_trans->state = TRANS_STATE_COMMIT_START;
 	wake_up(&fs_info->transaction_blocked_wait);
-- 
2.43.0


