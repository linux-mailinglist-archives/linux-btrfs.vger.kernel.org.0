Return-Path: <linux-btrfs+bounces-19799-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2369CCC459A
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 17:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 451A93088614
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 16:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFC629E109;
	Tue, 16 Dec 2025 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g82jE3VN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80C22C1786
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765902941; cv=none; b=gAcCmft7Gvt9awoCSJvvUGxRaV9L5/kF+4aLFsnqCJ7ma1JLRzrTNwDnrvj2WNdPIkCGUailgL+8Howx1NgWzH6bApKid7hyLmv2iSEshPdtIoXN9Eqxv91Fw/ZhIogPTC6Ni+/hadocTNMjqB2AbSujajIKJIBbCt+48LxZ4j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765902941; c=relaxed/simple;
	bh=3/AOcKQ4ul15dEOQCsASn/NxB6Bi2l96GiLGLYfRA5Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=o0RN9cRJLWf0y1Bl7rf/u4W3DHv50FBNPvtPsWczo+96sDhwEc7TbhxqJ+miDym70VX6IPuVYrHafWl04kDq1fUhabKiacarhZ2ZYDH2ZVgpt0pO9eQizqQP8iVZX2/+gvhFXMs4p/2sm00p2+O2rrC5RSt0yVtVgWUln/g8/jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g82jE3VN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF88C4CEF1
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 16:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765902941;
	bh=3/AOcKQ4ul15dEOQCsASn/NxB6Bi2l96GiLGLYfRA5Q=;
	h=From:To:Subject:Date:From;
	b=g82jE3VNJ8ZZnCcHOb3GUvaRyzKP5wbBJ0cMJMj8/JVfZeC4tyD3AvFYnpIsKURne
	 dkDwJzF0QvxtNVfJql4JV7Pj0R9STVFSE4FTU+0UQnnSq/tEh7oMeCy45mPD9fIhb+
	 1FTRhNmv+fttxlt2fx3wv820W31Sv55bw1U20oSctys8B60RKz+yFbG9uFTIh3oc/x
	 7ze1w23jQrQlYm28vW/ZRZ+UEQ/9rlPtj9JQP6pnFPyYCDHtJS+vBuABTgFOd90n+g
	 HX+t/rvXynnMo81BKY2mJWcuden8D/dSymWe2bZGcYFqtczgGCeK9QpW9L9tFq+ZoB
	 ub5nPv/IBZI3A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: don't call btrfs_handle_fs_error() in qgroup_account_snapshot()
Date: Tue, 16 Dec 2025 16:35:38 +0000
Message-ID: <3f4e9ac4d131ffec15e9fadfd97365569aad8a42.1765902874.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to call btrfs_handle_fs_error() as we are inside a
transaction and we propagate the error returned from
btrfs_write_and_wait_transaction() to the caller and it ends going up the
call chain to btrfs_commit_transaction() (returned by the call to
create_pending_snapshots()), where we jump to the 'unlock_reloc' label
and end up calling cleanup_transaction(), which aborts the transaction.

This is odd given that we have a transaction handle and that in the
transaction commit path any error makes us abort the transaction and,
besides another place inside btrfs_commit_transaction(), it's the only
place that calls btrfs_handle_fs_error().

Remove the btrfs_handle_fs_error() call and replace it with an error
message so that if it happens we know what went wrong during the
transaction commit. Also annotate the condition in the if statement
with 'unlikely' since this is not expected to happen.

We've been wanting to remove btrfs_handle_fs_error(), so this removes
one user that does not even needs it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index bd03f465e2d3..e82ca3f724db 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1621,9 +1621,9 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 		goto out;
 	switch_commit_roots(trans);
 	ret = btrfs_write_and_wait_transaction(trans);
-	if (ret)
-		btrfs_handle_fs_error(fs_info, ret,
-			"Error while writing out transaction for qgroup");
+	if (unlikely(ret))
+		btrfs_err(fs_info,
+"error while writing out transaction duing qgroup snapshot accounting: %d", ret);
 
 out:
 	/*
-- 
2.47.2


