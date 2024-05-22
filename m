Return-Path: <linux-btrfs+bounces-5205-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4793D8CC34F
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 16:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0E01F2452A
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 14:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FA122EEF;
	Wed, 22 May 2024 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ozavy6C4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374F522331
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388603; cv=none; b=lEJeSAGiEbqXdtnkkxhVAbmK9ZIz1zR+HKac2EI+m2K++U2QCrGvkGsciEya+iIcm8QgS0f30oSCwamcTwvpjdsFnqNA4httD48XlTIUg+QFzWBxYtGaloyM4+a9RfpkzyQe9rZSbL2GQWLxbOVrT67EJVg4T+v5wJTIZXkCaM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388603; c=relaxed/simple;
	bh=I+YKT2VcljiROW1ywzaPYu1sfaKwDF3M7uCRXO4vlNU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rP4Y6THkHQgSK3LFNsxKKxiPl/VxTvLSltZVSGTONensg67/Gk2j97Uo0Flgjp7up4Ccs6LcY/2k2V/7SkFQ0e7RTXNctzrI9tkIREWnCxZoH88v5kaTpLIw2iJRiiswpE9+JtjTpbUdAR6Yv1IujUR5l95J8zY6QOcjKVgBfYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ozavy6C4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314C5C32782
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 14:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716388602;
	bh=I+YKT2VcljiROW1ywzaPYu1sfaKwDF3M7uCRXO4vlNU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ozavy6C41qL3nipg2vCqyNoR5wUhwp4LMV6CGjixIUbygXk4LuZ5sUbUOvjaisvCX
	 zugYWJ3T/9AJM8DmIUm1ck+LcwA3LdBuJLVNfswfsPQTXDOzndfzGrCjx6BRHZ9OZL
	 gCbjEE34m0lMaYnYFG/WV/vCCae98JlJr+JPfTB6yO5qgFbhbWuI1Gt+o5aNnRdSST
	 AwVSyAbmbrFbZcuAcO93RCpS5khAXWb+ww6Hz8k2QS3boVI3hFCKP7wXX6qS+anIU3
	 DsSy/B6R6wQ4XZvckm0cgyMrR9B3AkJNUGX0S9dLuQxOvF8iNLGXOYUWGt2VbAfqyW
	 0wZekkgz2EfeQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/7] btrfs: send: make ensure_commit_roots_uptodate() simpler and more efficient
Date: Wed, 22 May 2024 15:36:31 +0100
Message-Id: <e48d8d6c882b992c69c1cc471b01e53c715486ff.1716386100.git.fdmanana@suse.com>
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

Before starting a send operation we have to make sure that every root has
its commit root matching the regular root, to that send doesn't find stale
inodes in the commit root (inodes that were deleted in the regular root)
and fails the inode lookups with -ESTALE.

Currently we keep looking for roots used by the send operation and as soon
as we find one we commit the current transaction (or a new one since
btrfs_join_transaction() creates one if there isn't any running or the
running one is in a state >= TRANS_STATE_UNBLOCKED). It's pointless to
keep looking until we don't find any, because after the first transaction
commit all the other roots are updated too, as they were already tagged in
the fs_info->fs_roots_radix radix tree when they were modified in order to
have a commit root different from the regular root.

Currently we are also always passing the main send root into
btrfs_join_transaction(), which despite not having any functional issue,
it is not optimal because in case the root wasn't modified we end up
adding it to fs_info->fs_roots_radix and then update its root item in the
root tree when comitting the transaction, causing unnecessary work.

So simplify and make this more efficient by removing the looping and by
passing the first root we found that is modified as the argument to
btrfs_join_transaction().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index c69743233be5..2c46bd1c90d3 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7998,32 +7998,29 @@ static int send_subvol(struct send_ctx *sctx)
  */
 static int ensure_commit_roots_uptodate(struct send_ctx *sctx)
 {
-	int i;
-	struct btrfs_trans_handle *trans = NULL;
+	struct btrfs_trans_handle *trans;
+	struct btrfs_root *root = sctx->parent_root;
 
-again:
-	if (sctx->parent_root &&
-	    sctx->parent_root->node != sctx->parent_root->commit_root)
+	if (root && root->node != root->commit_root)
 		goto commit_trans;
 
-	for (i = 0; i < sctx->clone_roots_cnt; i++)
-		if (sctx->clone_roots[i].root->node !=
-		    sctx->clone_roots[i].root->commit_root)
+	for (int i = 0; i < sctx->clone_roots_cnt; i++) {
+		root = sctx->clone_roots[i].root;
+		if (root->node != root->commit_root)
 			goto commit_trans;
-
-	if (trans)
-		return btrfs_end_transaction(trans);
+	}
 
 	return 0;
 
 commit_trans:
-	/* Use any root, all fs roots will get their commit roots updated. */
-	if (!trans) {
-		trans = btrfs_join_transaction(sctx->send_root);
-		if (IS_ERR(trans))
-			return PTR_ERR(trans);
-		goto again;
-	}
+	/*
+	 * Use the first root we found. We could use any but that would cause
+	 * an unnecessary update of the root's item in the root tree when
+	 * committing the transaction if that root wasn't changed before.
+	 */
+	trans = btrfs_join_transaction(root);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
 
 	return btrfs_commit_transaction(trans);
 }
-- 
2.43.0


