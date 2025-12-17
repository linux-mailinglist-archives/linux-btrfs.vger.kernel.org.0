Return-Path: <linux-btrfs+bounces-19844-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 445E6CC8BA6
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 17:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B324C312D49C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 16:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815C4328B4C;
	Wed, 17 Dec 2025 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rezrexzi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7756E32254E
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765987876; cv=none; b=La05aJ5P52owTSVd13cxTCiM473mDaLWQ452tCnhDR9xG6WPM/56L6VIStFGRDz+EPbDBSuXZir7t9FIiP81gdZiiFIYWOk4nQLPnvo2cFiWyvo54lpWqAsCfHsfkMjUKGC+EV4z3czM/voit5PFghAaI60XZD9e3BoQai+1+Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765987876; c=relaxed/simple;
	bh=CIkAeU1mpEtsX7FKf7lmh4hfOGPwRSe307l6aeK5MFg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hFW9XEfPPluswCXKcuHYBNnxatIHm98ALhlLefkVcRJhVdq98cjCwuIx5Q9x+9NMsmpYQ2A1biB8Mv/+71qlUu0ejNda7uO5AcHndiXDzFbW6eH2+ZGk+AWWwvMXFXqJpFJF8dOr11dbqtJTGdlDKOYbUv3OzcO8QWHBMTUaGD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rezrexzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66210C4CEF5
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 16:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765987875;
	bh=CIkAeU1mpEtsX7FKf7lmh4hfOGPwRSe307l6aeK5MFg=;
	h=From:To:Subject:Date:From;
	b=rezrexzi/k2FJFxAGOhpkeiL0TUA9HBoAsaW+wmDgkI3CYXepQtVH9NP7Ma59R1Ff
	 NPnK9J6jgqJtfkF8WF6u5/QOshLHbCLPkzj/Xk3nGfcX8bvIe0xU1Tq0oUCLzlHgIX
	 Ye1c3cyJb4Kw+wbQ9X+od7ZcDm+MnK3JmYP0UxHxiIePPqaEEuZiv0fpGgFNKAGmeT
	 fKOm0peQKzjYbzoAmRPRYCYhWqc4Ik0gysPbVFd5pNAjre8s+4UikrfkWx2uKv22rp
	 jgPXteNPKtO/sv+Jt3gmZTz2GXdHt0N6CYY/xnrCjOBMbyn1GTR/50JWob6qX1QsB9
	 Sp0nYp8AXfwqw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: avoid transaction commit on error in insert_balance_item()
Date: Wed, 17 Dec 2025 16:11:13 +0000
Message-ID: <d5f264d5a8be85998a6b65c5be122e56dbea5647.1765987488.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no point in committing the transaction if we failed to insert the
balance item, since we haven't done anything else after we started/joined
the transaction. Also stop using two variables for tracking the return
value and use only 'ret'.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/volumes.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 072f01b973a1..ce0535c0264d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3642,7 +3642,7 @@ static int insert_balance_item(struct btrfs_fs_info *fs_info,
 	struct btrfs_path *path;
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
-	int ret, err;
+	int ret;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -3677,9 +3677,11 @@ static int insert_balance_item(struct btrfs_fs_info *fs_info,
 	btrfs_set_balance_flags(leaf, item, bctl->flags);
 out:
 	btrfs_free_path(path);
-	err = btrfs_commit_transaction(trans);
-	if (err && !ret)
-		ret = err;
+	if (ret == 0)
+		ret = btrfs_commit_transaction(trans);
+	else
+		btrfs_end_transaction(trans);
+
 	return ret;
 }
 
-- 
2.47.2


