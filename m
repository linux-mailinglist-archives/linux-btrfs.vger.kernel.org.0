Return-Path: <linux-btrfs+bounces-11587-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045B3A3BD54
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1B5189A85F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37201E0E08;
	Wed, 19 Feb 2025 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCi8TOdt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBED81EB9EF
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965433; cv=none; b=gvA724B0rVgqXyPhOnOFhlkRV/3XooisUoPtkwI3XHB3iWo7+A94fPK0LnQTjCBDux1lg3dlZe7cqC5hFTw66api+XaCUcZmRW9I9/ypwfIQCEsXlIX319iilve2KFR4OEO7BehDRFwSUAD8ch5rr6ZFwzxPuJdKjUPc+6gR758=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965433; c=relaxed/simple;
	bh=NJ2JgutmmQTjMHYytZ3fYMdgpi7FupvrNgUYg/RUnPg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ldOjUCsjGvWCgeASMTASeToPUSzO3MQXq4518F5XrDxEOX+WtQFUr3NSb9N8X9CCcEpVSgx5fFFgU0fdzuTcKjpAKR/rTJgu89TBccVM4rEuhtLazhhJHQCoASQhmPHIyXgBfoh2m999tYcv9BVIklH3e5hkPhCdl9hXbv4RJg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCi8TOdt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F74C4CEE6
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965432;
	bh=NJ2JgutmmQTjMHYytZ3fYMdgpi7FupvrNgUYg/RUnPg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eCi8TOdtyqjaO2Sgs2Jm1KbymkSje09Wj62EWpvHpp4OL1o9ZR2Om73E2yoYjL1xx
	 p/5VEhbvGStKHqPtCHWNaXasXg3j5YFdTmLSWV5L6Y5Jt0OXwSpwCkvPpaN4DH5E2C
	 2eJEKKhbY9oO/TT8tC5j9/yE4w3TmFSxApulL+LxqwEm6zpQzicqGNN0gM/JN5M3Qd
	 VE8usr3lrkkw2C9WxKZbsrzA/WfdeKDczjEXzh/scvIoHM/Xi6iueK8jjMXGD+Bv4x
	 eNmrYXisp9tHEn2lpVzPx2LajmHtnrghxX1UF/MnMQNhlDinIcFEwtBm92wGIKldHP
	 1pV5lBJwMORXw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 22/26] btrfs: send: simplify return logic from process_changed_xattr()
Date: Wed, 19 Feb 2025 11:43:22 +0000
Message-Id: <4f86d440ff6e3975d86df4e119259d2bc4f3301d.1739965104.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739965104.git.fdmanana@suse.com>
References: <cover.1739965104.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There is no need to have an 'out' label and jump into it since there are
no resource cleanups to perform (release locks, free memory, etc), so
make this simpler by removing the label and goto and instead return
directly.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index e29b5a5ccdd6..0cbc8b5b6fab 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5067,17 +5067,15 @@ static int __process_changed_deleted_xattr(int num, struct btrfs_key *di_key,
 
 static int process_changed_xattr(struct send_ctx *sctx)
 {
-	int ret = 0;
+	int ret;
 
 	ret = iterate_dir_item(sctx->send_root, sctx->left_path,
 			__process_changed_new_xattr, sctx);
 	if (ret < 0)
-		goto out;
-	ret = iterate_dir_item(sctx->parent_root, sctx->right_path,
-			__process_changed_deleted_xattr, sctx);
+		return ret;
 
-out:
-	return ret;
+	return iterate_dir_item(sctx->parent_root, sctx->right_path,
+				__process_changed_deleted_xattr, sctx);
 }
 
 static int process_all_new_xattrs(struct send_ctx *sctx)
-- 
2.45.2


