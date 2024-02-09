Return-Path: <linux-btrfs+bounces-2288-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A354084FB6C
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 19:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592A01F28489
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 18:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B680A84A4F;
	Fri,  9 Feb 2024 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlDMv7U+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F2284A45
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501662; cv=none; b=iH7sZ5QrYqLyWI0BYI/y3xC4G2ApxaaPhcg4ALMAcCQvwp6MXAY8LupH/TKwthIfK+GkgtgsYoCX4PEsGGhN/nizhpNdNHkGtSJBxmQe/6TNJusa8pwyTarpVdJJ5WtJPJmKuQpOILdMzpMMVg/5Ic21Cc3BU7BzPf1ehx7o7Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501662; c=relaxed/simple;
	bh=cCM9HbQFEeqEmOjSbadyL9rytYGRTwYc7B8XCs2zzKU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fB6BHneiajPQzQt6lt+FTysI4BP6SJcueeUL73yPo6Csm9XQBqY8iswMoEZyf42CB9bGcxHyc+u3EbLDaWrOkRvjsBNsOq9cf4fHxS/PwiQKKtjOp2FWL6ZJZ4+caGf6xMjINQEZR00r4B9PtPFxR/9B21VZ09MjjY0IMAd0cCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlDMv7U+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FC4C433C7
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 18:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707501661;
	bh=cCM9HbQFEeqEmOjSbadyL9rytYGRTwYc7B8XCs2zzKU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TlDMv7U+3JjtThUj26npldBjWKu/yhV2ncFQlHdEBaQ9D4cGnQgWri6/yYnDjGRlW
	 eSfiLSuagvBKmIfYzX44AeWEc9/x3meL8+kp6OSdMBLP7qMs9Jw8am5uXvIWArjrKt
	 MlkLB/n+/ajsKS1JjJc0BI/EWFr/zRWBIYmJXKz0qVJmLg1eJ7StxETcIJki5hjC2c
	 YoCcXn5mbAV2N4UOu/jkRwzyJWXLNyjn0DloIR/dW2ugzqjr/C8Inyz+94uU22Q0to
	 48+AiEfFVG8oEH24CxiWOHfOmySA2m2GH5i8Sbr0y/BvhWtZbcKlH+xKb4oRzQextg
	 Eo2eHnYXMWhGA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 7/9] btrfs: use assertion instead of BUG_ON when adding/removing to delalloc list
Date: Fri,  9 Feb 2024 18:00:49 +0000
Message-Id: <d5c32d0109f92b848b6a0054571ef48b82bd77ac.1707491248.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707491248.git.fdmanana@suse.com>
References: <cover.1707491248.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When adding or removing and inode to/from the root's delalloc list,
instead of using a BUG_ON() to validate list emptiness, use ASSERT()
since this is to check logic errors rather than real errors.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c7a5fb1f8b3e..fe962a6045fd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2400,7 +2400,7 @@ static void btrfs_add_delalloc_inode(struct btrfs_inode *inode)
 	root->nr_delalloc_inodes++;
 	if (root->nr_delalloc_inodes == 1) {
 		spin_lock(&fs_info->delalloc_root_lock);
-		BUG_ON(!list_empty(&root->delalloc_root));
+		ASSERT(list_empty(&root->delalloc_root));
 		list_add_tail(&root->delalloc_root, &fs_info->delalloc_roots);
 		spin_unlock(&fs_info->delalloc_root_lock);
 	}
@@ -2426,7 +2426,7 @@ void __btrfs_del_delalloc_inode(struct btrfs_inode *inode)
 		if (!root->nr_delalloc_inodes) {
 			ASSERT(list_empty(&root->delalloc_inodes));
 			spin_lock(&fs_info->delalloc_root_lock);
-			BUG_ON(list_empty(&root->delalloc_root));
+			ASSERT(!list_empty(&root->delalloc_root));
 			list_del_init(&root->delalloc_root);
 			spin_unlock(&fs_info->delalloc_root_lock);
 		}
-- 
2.40.1


