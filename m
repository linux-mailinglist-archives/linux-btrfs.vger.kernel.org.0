Return-Path: <linux-btrfs+bounces-17002-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E47DFB8AA3A
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 18:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02775621E2
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 16:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DAD272805;
	Fri, 19 Sep 2025 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khdK4821"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095461F099C
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Sep 2025 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300534; cv=none; b=ExkhqYklbX+7CWEG3E1v57VPyS2ra8VhF3HpxbgeCUwIfSKWdE+H2MDzOhAhm7kdiZVNkzHIkWDbDCNYDJolb4N7ij6wYa3/K4ezByAcjBRVwMdx2qCqMZpxevCYwbyHDO8yEZMWmuTyku3W9H045ZeJf0xQUxy36CJD1QoMueY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300534; c=relaxed/simple;
	bh=3qm4/xhYzluJsgb8gcM04aHDk4cFNbFXWaoSs3bQdYg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QKtXckOIwaZqDZn2VScc3SWpMPI2wLeqUQJetDFUlkLqRN/IPb1v6ma3CofLydR4IrVUNKwjgLPaste4R33nw3k8TdoI0zMTmmAHIj5GzXqpG9EGV15UpOjXpZmgLJysP3NsAY6+Z0E6pTBZ7wnDNTn7wyrI6yEl/xpxJIwDGJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khdK4821; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17DFC4CEF0
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Sep 2025 16:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758300533;
	bh=3qm4/xhYzluJsgb8gcM04aHDk4cFNbFXWaoSs3bQdYg=;
	h=From:To:Subject:Date:From;
	b=khdK4821C0ACz0ugL/br+FPW7Hv8YsolCLpCUB6V4n9nnatCyLSNZ231bA7nfmY42
	 QFuZnEUh5hWQxrLM7ojTBi9LJJbaSWqW3V8RHAXB/UyJ/DahW8BE9LCcpQXqHNWa05
	 jT9MCFem6Im4Qe2AzwqePN3ftHAyXSM1elxO3X9d08rUEZ3WL9Yqf3GxHB8XeOG7ym
	 gFKFtCqUcx+HLIVhAjZ5qgAX3tZsmM4vm9hZvbvmDfwulRjtq3TE002yX7xj5IAkE3
	 q8NZSieqVIYaOBGzTHXwjqvJ6Aq3zTiDiFyQUYlbPmZJlzLhnAqtQqN0/36x+mGoNq
	 h0DAKJ0DBNYAQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove pointless key offset setup in create_pending_snapshot()
Date: Fri, 19 Sep 2025 17:48:50 +0100
Message-ID: <4083805be692c64632388cef096ab43ff77932dc.1758300462.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no point in setting the key's offset to (u64)-1 since we never
use it before setting it to the current transaction's ID. So remove the
assignment of (u64)-1 to the key's offset and move the remainder of the
key initialization close to where it's used.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index d04fa6ce8390..febf456a9ab0 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1694,10 +1694,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 			goto clear_skip_qgroup;
 	}
 
-	key.objectid = objectid;
-	key.type = BTRFS_ROOT_ITEM_KEY;
-	key.offset = (u64)-1;
-
 	rsv = trans->block_rsv;
 	trans->block_rsv = &pending->block_rsv;
 	trans->bytes_reserved = trans->block_rsv->reserved;
@@ -1810,6 +1806,8 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 
 	btrfs_set_root_node(new_root_item, tmp);
 	/* record when the snapshot was created in key.offset */
+	key.objectid = objectid;
+	key.type = BTRFS_ROOT_ITEM_KEY;
 	key.offset = trans->transid;
 	ret = btrfs_insert_root(trans, tree_root, &key, new_root_item);
 	btrfs_tree_unlock(tmp);
-- 
2.47.2


