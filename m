Return-Path: <linux-btrfs+bounces-9133-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D52879AEBDD
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 18:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102431C22B41
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 16:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F75F1F8192;
	Thu, 24 Oct 2024 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIG2zkOl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F1B1F8187
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787074; cv=none; b=pKly9+0V5FOP7hIjnOWXbxXQMWCRP3u6CQLrH/0XjBTx+1k8eVOk6yVNBKTCvW9owsvK6OhVDM78/GR6sRHeNGxD8usQeOS0enS6wtQA+9ENt4prMzVRzM6j2wB5/ypx91a/T06vRve2FodXmVKGnxUGam//cKyE1orm88IJXPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787074; c=relaxed/simple;
	bh=lnxB6peBfbimE9wUYFhIHUtsFMrfwuXHvlaUqfWJvfQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T4ExPIir2E3jXnOzMWQDpQbGvOCIb+ezfpRatrBT7yhmzk1OP0m1NLX0wMSDGW5UMhI4R4IZ1EEBIAAahecgUipeNpD97pCQ7+sVXPLHpLKtEEqHoIEdrJT15T6hfIuB4VuTAngf6tZRxq2Y+dIiF88wwmov2niJmuf8zLHgkoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIG2zkOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE3FC4CEE3
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787074;
	bh=lnxB6peBfbimE9wUYFhIHUtsFMrfwuXHvlaUqfWJvfQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XIG2zkOlncMa2rJJMhcpK1i9Zp7qPBPv9vwgJrCtn/RYiq9xKAxkW8ujL7rNLHjKJ
	 1qXl8XJu0UUJwrneHt1p3CxUKQSZ6X8JgfghokgGKokogsxtrEgcnxOhL1sr0UCxmx
	 LS4DWECRrQHicsVuIg0rHkJjM3rMujKHASGHV4y/wCm3wUXrHklpIJnzzzUdEwVkSU
	 ax7VCVpokT2TASlrC/BTDctzNZMIOWJ6Ws0nkSIhdsxjuKNZpwQWliJLGvHZkIrbMv
	 yLLwzQ2Q31yggORX5CWQq7NzXfYjyIHE6jh27k+bIjA6/9Nz7cUhY8ByRBEem5AhQi
	 kr0neBPhwErBg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 04/18] btrfs: remove fs_info parameter from btrfs_cleanup_one_transaction()
Date: Thu, 24 Oct 2024 17:24:12 +0100
Message-Id: <df701ca122531a3748e336c95b375f86ff8e19a2.1729784713.git.fdmanana@suse.com>
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
 fs/btrfs/disk-io.c     | 8 ++++----
 fs/btrfs/disk-io.h     | 3 +--
 fs/btrfs/transaction.c | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2e15afa9e04c..814320948645 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4183,7 +4183,7 @@ static void warn_about_uncommitted_trans(struct btrfs_fs_info *fs_info)
 		btrfs_warn(fs_info,
 	"transaction %llu (with %llu dirty metadata bytes) is not committed",
 			   trans->transid, dirty_bytes);
-		btrfs_cleanup_one_transaction(trans, fs_info);
+		btrfs_cleanup_one_transaction(trans);
 
 		if (trans == fs_info->running_transaction)
 			fs_info->running_transaction = NULL;
@@ -4734,9 +4734,9 @@ static void btrfs_free_all_qgroup_pertrans(struct btrfs_fs_info *fs_info)
 	spin_unlock(&fs_info->fs_roots_radix_lock);
 }
 
-void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans,
-				   struct btrfs_fs_info *fs_info)
+void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans)
 {
+	struct btrfs_fs_info *fs_info = cur_trans->fs_info;
 	struct btrfs_device *dev, *tmp;
 
 	btrfs_cleanup_dirty_bgs(cur_trans, fs_info);
@@ -4794,7 +4794,7 @@ static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)
 		} else {
 			spin_unlock(&fs_info->trans_lock);
 		}
-		btrfs_cleanup_one_transaction(t, fs_info);
+		btrfs_cleanup_one_transaction(t);
 
 		spin_lock(&fs_info->trans_lock);
 		if (t == fs_info->running_transaction)
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 127e31e08347..a7051e2570c1 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -126,8 +126,7 @@ int btrfs_add_log_tree(struct btrfs_trans_handle *trans,
 		       struct btrfs_root *root);
 void btrfs_cleanup_dirty_bgs(struct btrfs_transaction *trans,
 			     struct btrfs_fs_info *fs_info);
-void btrfs_cleanup_one_transaction(struct btrfs_transaction *trans,
-				  struct btrfs_fs_info *fs_info);
+void btrfs_cleanup_one_transaction(struct btrfs_transaction *trans);
 struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 				     u64 objectid);
 int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 0fc873af891f..e580c566f033 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2052,7 +2052,7 @@ static void cleanup_transaction(struct btrfs_trans_handle *trans, int err)
 
 	spin_unlock(&fs_info->trans_lock);
 
-	btrfs_cleanup_one_transaction(trans->transaction, fs_info);
+	btrfs_cleanup_one_transaction(trans->transaction);
 
 	spin_lock(&fs_info->trans_lock);
 	if (cur_trans == fs_info->running_transaction)
-- 
2.43.0


