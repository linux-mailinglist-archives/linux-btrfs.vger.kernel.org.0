Return-Path: <linux-btrfs+bounces-14008-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 879C6AB6A58
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 13:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665B43ADDDB
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 11:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477BD2741BC;
	Wed, 14 May 2025 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMs+UuyK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5D02749FD
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 11:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747222722; cv=none; b=mUqLfGrq/716RoF4ee2haKyNtcHQOc9wH6p0zm7f6hCsKNkXfBah2j4G//Q0WPYiCAbacepC78D67OmpnOO0rStNNSwW8HR3Dri2J3kHBEAk1LnwHhzc2xq/P3nbRpOuC61TYLFjT82JbZUfMnumNsVSold1m7rhkyvgJP/+NCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747222722; c=relaxed/simple;
	bh=pKgx489txPUJRyo2t1Um2a10BH79VrBM7l1TLFtB3tE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=COvmAHsRJ7/FGNYgKxRnlKyw/o9fqSauBs5hCQ6TjRUy8fH+QeQGJM+um1qqVJRg7q6uFPJqNu2dBeAzZzDUAo/ChAlq1rcDlDGOj6oerVB/zKwIgY/it+SKveG1qLuzbXsEqx0sUeL34fGrYE0ZPKIk87lQyqrlvIN0e0y+st4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMs+UuyK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B1BC4CEF1
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 11:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747222722;
	bh=pKgx489txPUJRyo2t1Um2a10BH79VrBM7l1TLFtB3tE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aMs+UuyKjk2ro6GoHfutfRkJlhnxeJE8tr1egeil6/GRq4apF6kk72KnMa590yuyE
	 IWmTOMhQ9QPloYtqnWh4JLqbNh4ZB7ODSG9Lkzrj9nnQBzIZLX9T18vppPTwrvypPm
	 fFm1svQ9TAVhv6cSySvXV1nBxsg55yiVSegpT8FoyluUjnjBv8MlzM58n/RTH0i4Oa
	 kJaBkt9Acj4PR9akZCjHkWO5gBdMKY/17GsQWWW1zBtA3B/MzHgNJ6wSniQ1e2rB3b
	 lW8NqJsPgSJbPg0lHhEFJiRCanoBxoG+gYurq/2frYkCI78jXzAoVa1Ewsw2fSucmV
	 LMW90B1G5oBdQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/5] btrfs: pass true to btrfs_delalloc_release_space() at btrfs_page_mkwrite()
Date: Wed, 14 May 2025 12:38:34 +0100
Message-Id: <94106377f5976fe256efd8adf58eb5d62580ad20.1747222631.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747222631.git.fdmanana@suse.com>
References: <cover.1747222631.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

In the last call to btrfs_delalloc_release_space() where the value of the
variable 'ret' is never zero, we pass the expression 'ret != 0' as the
value for the argument 'qgroup_free', which always evaluates to true.
Make this less confusing and more clear by explicitly passing true
instead.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 32aad1b02b01..a2b1fc536fdd 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1971,7 +1971,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 out:
 	btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
 	btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved, page_start,
-				     reserved_space, (ret != 0));
+				     reserved_space, true);
 out_noreserve:
 	sb_end_pagefault(inode->i_sb);
 	extent_changeset_free(data_reserved);
-- 
2.47.2


