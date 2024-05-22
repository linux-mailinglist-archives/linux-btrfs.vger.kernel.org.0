Return-Path: <linux-btrfs+bounces-5208-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDE98CC353
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 16:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16632B23609
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 14:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83BD2D058;
	Wed, 22 May 2024 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0/Amg1p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D4F2B9B7
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388607; cv=none; b=hz42c+GP7My8QgA573ZsQXJfnVbLZ1xD9re1fbrPLO8Di6hahgDeGy7u/jtSs2oFpqYV0Rahg/IxW9/A6WnZ7yoD6xyiQ0q6geNT7rirhrRIigkRNYxv8iOgZeYhmYfLrlD4SQU6vjQs3a9CgZHFAugIxM1lpCJgCYtjByszLyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388607; c=relaxed/simple;
	bh=jSUaWv3D26Gc994bf/+m3KCGYKcbSM+Rx1fog0KmeIY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n6ZJdWwWjqRxJFV6VJKq6DLFajMFt+yrM68Gv0qcEieyjVJBboc+CgM6FvTuj/wrHahZSWNX/sAB6yKKaf8T89u6ni45Z0G5OTwrdJF9D4hVWYx8R9SnccLw7pedsz8c17hKz0g09xKFnRP2Pszf4cSoVB4PkLXJeOMrFANQSYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0/Amg1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401E7C2BBFC
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 14:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716388606;
	bh=jSUaWv3D26Gc994bf/+m3KCGYKcbSM+Rx1fog0KmeIY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=h0/Amg1pyy7Z+Makil1hg/z3D68e3+tWzpz4HUtiuJNXjY8lsIT8jmOZihCpjFEYz
	 1VtkiFZIQR0QvXGMIJlHL8O7huLf5J0PP+iOMXjJYTBm8jZ0FEsETx+q+Mh0BOsLjd
	 l5fYoIbsEjoM3pINaKwMTZOY9sIC9nZuw5uOP4t2l7i9QhQRuV32cFwrBef7h9m8iX
	 8bdvaCfaOPnoUl/+h23jPLWPqgZcTUswSsRT9F5WuEuC81SdtSC5UJW/jdh8h1ZkJA
	 Sy8zwDtrGnh4eecC29NdT0LreN6K94ZPDD7BBPHPGPwe0mzh0PH/0WMJOgTatZ8ZXe
	 zYInhANq6tUIg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 7/7] btrfs: send: get rid of the label and gotos at ensure_commit_roots_uptodate()
Date: Wed, 22 May 2024 15:36:35 +0100
Message-Id: <11d9f5813524b2b2d1164fe921464f8427c18620.1716386100.git.fdmanana@suse.com>
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

Now that there is a helper to commit the current transaction and we are
using it, there's no need for the label and goto statements at
ensure_commit_roots_uptodate(). So replace them with direct return
statements that call btrfs_commit_current_transaction().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7a82132500a8..2099b5f8c022 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -8001,23 +8001,15 @@ static int ensure_commit_roots_uptodate(struct send_ctx *sctx)
 	struct btrfs_root *root = sctx->parent_root;
 
 	if (root && root->node != root->commit_root)
-		goto commit_trans;
+		return btrfs_commit_current_transaction(root);
 
 	for (int i = 0; i < sctx->clone_roots_cnt; i++) {
 		root = sctx->clone_roots[i].root;
 		if (root->node != root->commit_root)
-			goto commit_trans;
+			return btrfs_commit_current_transaction(root);
 	}
 
 	return 0;
-
-commit_trans:
-	/*
-	 * Use the first root we found. We could use any but that would cause
-	 * an unnecessary update of the root's item in the root tree when
-	 * committing the transaction if that root wasn't changed before.
-	 */
-	return btrfs_commit_current_transaction(root);
 }
 
 /*
-- 
2.43.0


