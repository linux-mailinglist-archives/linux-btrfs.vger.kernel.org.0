Return-Path: <linux-btrfs+bounces-14735-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6A1ADD5D5
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 18:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E01A2C3F20
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 16:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44332EE286;
	Tue, 17 Jun 2025 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcbKWCMA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F042EE27D
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176797; cv=none; b=XFCerxVlQG9V5wOzY7Eel2lAEQ7YDCfs4HqAvijccXs5z+CVNvDZop0Hv4dX9wQgdSvRhG2Z5VYSj+vxVZVPFh8XnUsagVONbti33pPJ5SGLjkJP4w4NyXvSGOSJ2jQ1btksT3MB9tER/l6hg3vqRpwNBYFSdsijGLDScrccu5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176797; c=relaxed/simple;
	bh=QMkLra88lHbPRAqzCHBo4+2RRoH9PABpUS+CNjldjXw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fK/uNa/GuHu+7HWfuwkpws+izcr0Jy1SWECITyq6khGAsEyK9v4IsO1y2SGRp6642SNpd1MD/0Mq2I496UsmcOk7q9lKkHWCeCdg5JS4m5ePlGS3pRSvrw9cZ83P4dTWBMlUAl1QldqyT8yAQRE5Q7Cc9erfjng72RI1/NxSkic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcbKWCMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36170C4CEE7
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750176797;
	bh=QMkLra88lHbPRAqzCHBo4+2RRoH9PABpUS+CNjldjXw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dcbKWCMAfUTAV+wudLWEC2YCXe5BtC/8xq2mOCIu3HFDKDJ/ygil3aTPe+UFWMlLo
	 PHzC5NuF3g6VTPkCFAVTZI+MJRFiaGEdExEOTLDzQETPNshWyRqqX48Z0YDHNhjvSC
	 bIq2lOLwH+JSavL3IJq+TW29h1JlEzTM458oghRufPqMHbCheqRn4M5AGCsjJeBz8Q
	 Q8NwN1ilGuqG2a3Ugg0SnoRN8iWBOS2XOhpvxOdD/l0+NSAOjRJVGEMsmsUWFrrSQV
	 E6I4bcFg7M1ZlpYuBWuWhYCNrMhyn5y967GZj+0EDwf0VwlMt5NtGL8IMpMdvNTzEG
	 lgTehF74R1xsg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 06/16] btrfs: remove pointless out label from remove_free_space_extent()
Date: Tue, 17 Jun 2025 17:13:01 +0100
Message-ID: <1150f2a5c103e7db1dc1e26c2e1f84eff660c54f.1750075579.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1750075579.git.fdmanana@suse.com>
References: <cover.1750075579.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

All we do under the label is to return, so there's no point in having it,
just return directly whenever we get an error.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-tree.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index a4909393840a..cba097dbdebb 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -727,7 +727,7 @@ static int remove_free_space_extent(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_search_prev_slot(trans, root, &key, path, -1, 1);
 	if (ret)
-		goto out;
+		return ret;
 
 	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 
@@ -759,7 +759,7 @@ static int remove_free_space_extent(struct btrfs_trans_handle *trans,
 	/* Delete the existing key (cases 1-4). */
 	ret = btrfs_del_item(trans, root, path);
 	if (ret)
-		goto out;
+		return ret;
 
 	/* Add a key for leftovers at the beginning (cases 3 and 4). */
 	if (start > found_start) {
@@ -770,7 +770,7 @@ static int remove_free_space_extent(struct btrfs_trans_handle *trans,
 		btrfs_release_path(path);
 		ret = btrfs_insert_empty_item(trans, root, path, &key, 0);
 		if (ret)
-			goto out;
+			return ret;
 		new_extents++;
 	}
 
@@ -783,16 +783,12 @@ static int remove_free_space_extent(struct btrfs_trans_handle *trans,
 		btrfs_release_path(path);
 		ret = btrfs_insert_empty_item(trans, root, path, &key, 0);
 		if (ret)
-			goto out;
+			return ret;
 		new_extents++;
 	}
 
 	btrfs_release_path(path);
-	ret = update_free_space_extent_count(trans, block_group, path,
-					     new_extents);
-
-out:
-	return ret;
+	return update_free_space_extent_count(trans, block_group, path, new_extents);
 }
 
 EXPORT_FOR_TESTS
-- 
2.47.2


