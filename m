Return-Path: <linux-btrfs+bounces-19798-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F03E8CC4513
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 17:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC90D3035C29
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 16:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3E93126BE;
	Tue, 16 Dec 2025 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUMasF7O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1608C2459F7
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765902806; cv=none; b=BL/iHY4VaADwrgMxhu7OIYyC/9s7BA9qeLve7bHlvUR7lvqhl2U78dXq3AhuJxAIGm8OjPAYCJmttBj2jgEPtg+cxCzmso2CXmQTQmC10EfVGC4cScewyX8K7/NVEBo9PJ0+dfB6HvFIrKGeyd5gYLV5xX74e6vCE3Yxp3Xz5p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765902806; c=relaxed/simple;
	bh=VPhd23H5uYVaXrhwEuJ3NoJpPuNMnbavK4pQmKvs/kQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlpiduuHgPSHoVpYl2GK1Z9KFIOOqwGs0T5bettdZJSXsNhae57nXwpuEJZwa9L/NViBtP7ftfI0UKZfVmPbHvHHp8QyuzTxFC/F968gwycAC3A1ARtZdTHqN+0sZouj/nEP9uxoB7juFexL5OOBQiXovzOoLwj47rDBQ2t60QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUMasF7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D685C113D0
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 16:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765902805;
	bh=VPhd23H5uYVaXrhwEuJ3NoJpPuNMnbavK4pQmKvs/kQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SUMasF7OS412j5RL+e4bMwm7lOAMMXnEApW9SB37IGJ9Hw4Zdp97/YaJrCTf6RS8G
	 yAHmcxScJyXh374IBQ9CcOaqoJyd2lXtPP9dX7izMXpm/U6G1uUCGYClJH+wg4iBYA
	 8ICio3NFB9uysCuaTyIlAychwaSQmXCSTBakGI3k5yV3iUZSRbsZ7GOC9m6SfTs2+E
	 MUkVxXewl4+mQ3qQYakuToKqVUtmPA32vlkHAgVSpWj+qO0pOr50y7qQoUm7V5zJe/
	 MJuRfvzQqcPDUnWK5a/bh9Lgu8IfXRnMmtLBjifbd8w+5ck9C6DkFn7plZBXFQe2EW
	 XWlj5KId5E3iA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: don't call btrfs_handle_fs_error() after failure to delete orphan item
Date: Tue, 16 Dec 2025 16:33:19 +0000
Message-ID: <5918993022c59053d125fc4aa6236d3eec4b8907.1765899509.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1765899509.git.fdmanana@suse.com>
References: <cover.1765899509.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

In btrfs_find_orphan_roots() we don't need to call btrfs_handle_fs_error()
if we fail to delete the orphan item for the current root. This is because
we haven't done anything yet regarding the current root and previous
iterations of the loop dealt with other roots, so there's nothing we need
to undo. Instead log an error message and return the error to the caller,
which will result either in a mount failure or remount failure (the only
contextes it's called from).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/root-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index a30c7bc3f0e5..065c3842122a 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -272,8 +272,8 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 			ret = btrfs_del_orphan_item(trans, tree_root, root_objectid);
 			btrfs_end_transaction(trans);
 			if (ret) {
-				btrfs_handle_fs_error(fs_info, ret,
-					    "Failed to delete root orphan item");
+				btrfs_err(fs_info,
+				  "failed to delete root orphan item: %d", ret);
 				return ret;
 			}
 			continue;
-- 
2.47.2


