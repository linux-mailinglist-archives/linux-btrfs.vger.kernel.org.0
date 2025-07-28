Return-Path: <linux-btrfs+bounces-15709-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81859B137A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 11:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20FB3BB04A
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 09:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7A125392D;
	Mon, 28 Jul 2025 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVN9XRq7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A471F0E34
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695593; cv=none; b=txNV9Lb/gJBVbVCSsHL9nNkGFQHLpq8iZsgehYmPS5Q5r91PJpNx26xu5F5SUUklg8/o9dAw4+uc92YvK5eZdIRdJqEPqf4fwqqdTZVpAnS85qZttcSn/DByKN7W4Fit1e954AiPYetg61MN+PmlPyMH0Xf0Vb8XhqtUHSX9TJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695593; c=relaxed/simple;
	bh=wfSZmIlOUjKkqE/u3HGnNKiyelTM4gQuT8cKG6TIJBw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvIbd6oLj3KnhS46BsRcd/1psI1aXfUvNDb2ravXRg2CZy/lF9p72GBvkD00Zb+8G+KIKHdY1G/8YG9XMoXIoXM+eY5OE/XAsob82Optn/errR6T47UCvct9nInTx4IccUZBMD+pj3THDKONxAfUfaGbtd4X+xUzZdrnE/wJm5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVN9XRq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AD7C4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 09:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753695592;
	bh=wfSZmIlOUjKkqE/u3HGnNKiyelTM4gQuT8cKG6TIJBw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BVN9XRq7U2QMgr9jXhbdK3LjsXhDqg5XGG/YlT4v3WOmId1kjiBGPh3Y9Ht2HWAms
	 dX97aWCdAoshux5HROBYOAK8ZjoIap9E5DdgXtcpTZslTX2+JhmbXcCSUKims/ke1s
	 ppivoOIderghBsMGlVmgy7fUHefn5sCnTP6iVK9dCRJwdVcYYzWL2Zjp3mQa396s18
	 b72eF5IAhlxgW/MY+hkLPM1Hi9LvbU62OuqdT5x0yCJTsHZtL87tlHMlSPNKcq1FMU
	 +n6ZGL2jx3vqevdrd/VYdlrXQaYjUCxD6I9DEA5Fu0fmJBhiv3Zy7MVSTdvr2ALkYH
	 xOO+gQnjbllFA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: abort transaction on failure to add link to inode
Date: Mon, 28 Jul 2025 10:39:46 +0100
Message-ID: <dfa19dadfcb0df1f5ec2ec0a1b4f8d48b67c962a.1753469763.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1753469762.git.fdmanana@suse.com>
References: <cover.1753469762.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we fail to update the inode or delete the orphan item, we must abort
the transaction to prevent persisting an inconsistent state. For example
if we fail to update the inode item, we have the inconsistency of having
a persisted inode item with a link count of N but we have N + 1 inode ref
items and N + 1 directory entries pointing to our inode in case the
transaction gets committed.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6d9a8d8bea4c..f2b43b1e90de 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6845,16 +6845,20 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 		struct dentry *parent = dentry->d_parent;
 
 		ret = btrfs_update_inode(trans, BTRFS_I(inode));
-		if (ret)
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
 			goto fail;
+		}
 		if (inode->i_nlink == 1) {
 			/*
 			 * If new hard link count is 1, it's a file created
 			 * with open(2) O_TMPFILE flag.
 			 */
 			ret = btrfs_orphan_del(trans, BTRFS_I(inode));
-			if (ret)
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
 				goto fail;
+			}
 		}
 		d_instantiate(dentry, inode);
 		btrfs_log_new_name(trans, old_dentry, NULL, 0, parent);
-- 
2.47.2


