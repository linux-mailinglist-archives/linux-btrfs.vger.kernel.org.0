Return-Path: <linux-btrfs+bounces-14180-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A17E3AC0FCA
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 May 2025 17:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE8016D543
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 May 2025 15:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90363298268;
	Thu, 22 May 2025 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrJOisZf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D413729825D
	for <linux-btrfs@vger.kernel.org>; Thu, 22 May 2025 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747927173; cv=none; b=Ei2C8gNBdY9i8GRD/N5FYB5qpyKka5XEa3G2TN4fbbOkdBsz8lwYx9rbEuZ9yfyFB2MQXMJpFKjL6EfaWQIIuiul5wa8nkYBrkqJqcevxgBDYE3DfSSPre9Etp7e+dgvUhefoJV1dTP3XHtsOxGPrs8qc8a60POrb8qIzXKa/8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747927173; c=relaxed/simple;
	bh=uv97w1etZ5c2sU4XxPZfXAbYCL3Sx/DUULfmt8vl09Y=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Hfc2HVdNuqbHvxoRyRI9sw/6ppyd5ji2uf4p5umLgbNg0qPfxLrspyQgBGOLp85MxS65twWtmJHzegyz1dw9udTPRFBo+fdBYQAfnWmTTKIyKkSWrLNEYINZuHTC56jFJLfAqHLd9TT7v/tblvLKsUGKHIJlxmlTHo/39QUXjqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrJOisZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E85C4CEE4
	for <linux-btrfs@vger.kernel.org>; Thu, 22 May 2025 15:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747927173;
	bh=uv97w1etZ5c2sU4XxPZfXAbYCL3Sx/DUULfmt8vl09Y=;
	h=From:To:Subject:Date:From;
	b=PrJOisZfSCXh/Ym9ZCI6dPo1zLFrB5uCn7P2W0AdK+Be9EuuUETMVujoey86R9tg7
	 R3Lgg5falPoZ1NFrI73dtiOkbhG3j5besVakvSMLgH1vE83imlo7mdfwuvcwi2ZGKA
	 XXFiSeMpVQ6IHDmJ8/MwumMyvd4GnNXGcPgj1X5avTOY0oivYxpQYuf4NMfxqWt/K7
	 qX2eMpFicIyoG8FefpLFSpTk54NkjPrY+LsiQDhUeyr4210bQ/ij1xl6d4O/DmZdSy
	 i+cRZK6hddvmLQJXPFWTF36qtUSDmSCojxzGPRn/lQ39CcjwhxiJrMWi4KsRhfWv/q
	 TB6Ne7tMIoA1Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: include root in error message when unlinking inode
Date: Thu, 22 May 2025 16:19:30 +0100
Message-Id: <a5d6ade388b810520d18ea92fce0d94c33e72768.1747926978.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

To help debugging include the root number in the error message, and since
this is a critical error that implies a metadata inconsistency and results
in a transaction abort change the log message level from "info" to
"critical", which is a much better fit.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7d27875600d6..161a19316dfa 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4250,9 +4250,9 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_del_inode_ref(trans, root, name, ino, dir_ino, &index);
 	if (ret) {
-		btrfs_info(fs_info,
-			"failed to delete reference to %.*s, inode %llu parent %llu",
-			name->len, name->name, ino, dir_ino);
+		btrfs_crit(fs_info,
+	   "failed to delete reference to %.*s, inode %llu parent %llu root %llu",
+			   name->len, name->name, ino, dir_ino, btrfs_root_id(root));
 		btrfs_abort_transaction(trans, ret);
 		goto err;
 	}
-- 
2.47.2


