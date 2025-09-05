Return-Path: <linux-btrfs+bounces-16676-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4268BB45DB3
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A51C6B62402
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF06735FC13;
	Fri,  5 Sep 2025 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kucZihQK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1009A35CEB8
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088670; cv=none; b=Tu5V/bvOZtRglRdnzohk63d+VZV5IuNCf+INnRB4LOVJyQga9NGIv88IRi2v8Vdy4Gg2PaxszZP0T/U64TdVt10IQY7e50hz0TZ/Hj6tnLGbIyCguGOjpbHxW8B0XOeN4+jf6D3uVHzDX0AewIL+sp6aOW1BvnR1W8Rm3xAPkWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088670; c=relaxed/simple;
	bh=z1Wm5/NS3NW7g9LMvShAz/oMhfgugdrmSuz9zwLv4PQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAp7oh89taKyptMWVEqWW2SVuPKDPQDqS37pgU+/Nx5ZOPYXDxqWZYE6kDf4GujxkbE8cq/GcIwV/JWc7b6VtbbFjKhXYA/kWXxMZhey8qix/uElaG9CWOdjT47eAro0qGgGoV0cmtqPOyJZYR4IQEyEz7hQDykH5voY/8zRG3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kucZihQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8C4C4CEF4
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088669;
	bh=z1Wm5/NS3NW7g9LMvShAz/oMhfgugdrmSuz9zwLv4PQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kucZihQKDsNZSLsuLL4w93sUy/G0injkIjcZtPkw7sO2XtCcGDdQW4gyGwgoAt3aa
	 +4s7OZePD3GtCcZvTKH5O02wEHgxyQTthJS/rLvlesD7JX1cYztayeU3fHLiut7N+c
	 sj3/m3HfVdPFP+AGeXlh8pxggVibqKttzhIFBAI6KBmtcm1bR1qE1QE0HbSVW6eqQb
	 nHLSuh5rI5Z2ETmrlu3Rpofsnxs/pqBZW6mLIYaOUaQNLkbLmxNwN32Ok/br4VEE31
	 77LhPcb+vc02lQX17B/7oNkRjYIM09YqlfKUvH9xm+c6Z1zAOZDq51x2Ee4a9UyF+R
	 QMmioZBNv+plQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 32/33] btrfs: abort transaction if we fail to update inode in log replay dir fixup
Date: Fri,  5 Sep 2025 17:10:20 +0100
Message-ID: <3a8905ce55499ad65ca68e6294affffe55f450bb.1757075118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757075118.git.fdmanana@suse.com>
References: <cover.1757075118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we fail to update the inode at link_to_fixup_dir(), we don't abort the
transaction and propagate the error up the call chain, which makes it hard
to pinpoint the error to the inode update. So abort the transaction if the
inode update call fails, so that if it happens we known immediately.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 7b91248b38dc..83b79023baae 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1849,6 +1849,8 @@ static noinline int link_to_fixup_dir(struct walk_control *wc, u64 objectid)
 		else
 			inc_nlink(vfs_inode);
 		ret = btrfs_update_inode(trans, inode);
+		if (ret)
+			btrfs_abort_transaction(trans, ret);
 	} else if (ret == -EEXIST) {
 		ret = 0;
 	} else {
-- 
2.47.2


