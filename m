Return-Path: <linux-btrfs+bounces-12275-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73200A5FEAB
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 18:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E6917D180
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 17:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CDE1EEA30;
	Thu, 13 Mar 2025 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI0BWCSV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70E31EE7BD
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741888546; cv=none; b=RmP0BYD8VvrCq8VIs30GyCQUHIqPJKZLKU/bdWpanKQLP6cwGUyhP5GUavNYBeDvrzqRCu9EiEXupUFAAa3RZdeL6NyWLX2A43WgdTza5pcqupSLZAggK+1ziG39JEWy4iBhZHPUHK4g4XzUhQLzDOJfRZ1fWWbHRUfsrkhUvkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741888546; c=relaxed/simple;
	bh=uvF883+DhDkzjuxc4oFklMlYzQduJC7RnEBIjsm1TY0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y07J1UnH8QNJhxBELJh5Ye6i98MaedocOXgZ3YIJHUQ0wFu5vd926DV2MKL37aNsuTmdYn2z5vSdn5ST61vZDBRbPOxoTHleL3EvsvZK/MuPEm5RxEA3s3ltJOHrf0Yev/b1tqc2hWakmuuUFyaxgzqr9N9IorTkxs32/208nwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jI0BWCSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3515CC4CEEB
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 17:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741888546;
	bh=uvF883+DhDkzjuxc4oFklMlYzQduJC7RnEBIjsm1TY0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jI0BWCSVqtv4QnEjvH5yKyR8A4Jls+3e01iD3EAVFo0fmkKSs1DlT5tftZjvC2hZt
	 YcTa8CFc/Du8Xmg8OYfz0oC3qu6wMRDrpTclproNH//CWUUb8A6gFmXwONicUdXnAp
	 JcYgVAXAYfulakl0ioBc+bDTmSovVZzCrs08OSHt/6nc72P4A98L2EVr4Y2QcRQP2P
	 nAjbKkQlwEpPvjzjFIO3wE9a4yUCP2XpYK268wGDy74YGIh5o0jUECTzB/WPQicN4d
	 eWdNVpnegB/sswqQtQICM6gQHBrgo0YUnSO39EnTuLgs6PY9/Gkw4GERUiIu4Frk70
	 DTA/WchmSjsIA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/7] btrfs: simplify condition for logging new dentries at btrfs_log_inode_parent()
Date: Thu, 13 Mar 2025 17:55:36 +0000
Message-Id: <d8cd47d2c6dcfc06951900cf7ce400d947bf49cc.1741887950.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741887949.git.fdmanana@suse.com>
References: <cover.1741887949.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no point in checking if the inode is a directory as
ctx->log_new_dentries is only set in case we are logging a directory down
the call chain of btrfs_log_inode(). So remove that check making the logic
more simple and while at it add a comment about why use a local variable
to track if we later need to log new dentries.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6c59c581ebe4..6bc9f5f32393 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7036,7 +7036,7 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret = 0;
-	bool log_dentries = false;
+	bool log_dentries;
 
 	if (btrfs_test_opt(fs_info, NOTREELOG)) {
 		ret = BTRFS_LOG_FORCE_COMMIT;
@@ -7090,8 +7090,11 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
 		goto end_trans;
 	}
 
-	if (S_ISDIR(inode->vfs_inode.i_mode) && ctx->log_new_dentries)
-		log_dentries = true;
+	/*
+	 * Track if we need to log dentries because ctx->log_new_dentries can
+	 * be modified in the call chains below.
+	 */
+	log_dentries = ctx->log_new_dentries;
 
 	/*
 	 * On unlink we must make sure all our current and old parent directory
-- 
2.45.2


