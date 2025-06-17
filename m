Return-Path: <linux-btrfs+bounces-14738-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA238ADD5DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 18:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F0957AE5D4
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 16:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BEB2F7407;
	Tue, 17 Jun 2025 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJY4rCoA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8F2ECE87
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176801; cv=none; b=s2cspVsS9WoiiEOIECm/HuyyLvl3KTqudrWIt5vIU/cfO2Q9IqEzOxptiQRA7la4DbbhG6hMl0Osr5SyNP6LAU+ChPjmTlZZ8HSR3+iBWtTtmt7dZPVQbD/0U40h/TbhxwoCcCZJ8Cv6c6dJj/Zaov2/NhwkkEcs4FS8IvTN5v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176801; c=relaxed/simple;
	bh=Q9hQJb6hyCzdXEk5cTAgg3g387V1e8AKDF9wPKcRdok=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a80lgJl2wubOnuYifOOUYCU1cYeqDUeQpjYCiLD6aMCXPnRuG39hFN7+3h1UMj1n4yieofM+uIpiUVZNSbIScb26tPmm8RLknv3viWjuOPHKYnTsi53e+fucccPOhv+R8zkQM0Wlvse4DeTQT8JTrGdKEV1END/sQEOjVwkhL2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJY4rCoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4005EC4CEE3
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750176800;
	bh=Q9hQJb6hyCzdXEk5cTAgg3g387V1e8AKDF9wPKcRdok=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DJY4rCoAZ6r28jo6wZc+/8ItcKXYj8zC8e7JzOTisw+CPmKzWW9Oasi4miyVAvKpl
	 DZslfWqIMrtn70t4llIsd51ntSdBn1pjVKy87lAkogeqnoIApl8b1rATXLqHtjmYbI
	 u8EbM+EKepUoWubjgyaDyaj687DKXGCKUGZQp74QIycHnXonTAXRvNj+7DV9il6J2D
	 uMiHrLJ5lF5lJPfWLiL+1Q1Q0mbcWnTLUsWAMs9R39tx1y7B+H3mh0WJxJ7hVoPpAG
	 c45uUWxsHQNyR2xLnzGcbw4T0fy9NyIVVhoWxw16CYlCI8rY2TpX4EkofHrBx6/TMn
	 78cMsLqs+75bQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 09/16] btrfs: remove pointless out label from load_free_space_extents()
Date: Tue, 17 Jun 2025 17:13:04 +0100
Message-ID: <ca314f0e5343cadbd60e5a15e02cbd919950ff53.1750075579.git.fdmanana@suse.com>
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
 fs/btrfs/free-space-tree.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 0514b0a04572..d98a927ca079 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1636,7 +1636,7 @@ static int load_free_space_extents(struct btrfs_caching_control *caching_ctl,
 
 		ret = btrfs_next_item(root, path);
 		if (ret < 0)
-			goto out;
+			return ret;
 		if (ret)
 			break;
 
@@ -1652,7 +1652,7 @@ static int load_free_space_extents(struct btrfs_caching_control *caching_ctl,
 					       key.objectid + key.offset,
 					       &space_added);
 		if (ret)
-			goto out;
+			return ret;
 		total_found += space_added;
 		if (total_found > CACHING_CTL_WAKE_UP) {
 			total_found = 0;
@@ -1667,13 +1667,10 @@ static int load_free_space_extents(struct btrfs_caching_control *caching_ctl,
 			  block_group->start, extent_count,
 			  expected_extent_count);
 		DEBUG_WARN();
-		ret = -EIO;
-		goto out;
+		return -EIO;
 	}
 
-	ret = 0;
-out:
-	return ret;
+	return 0;
 }
 
 int load_free_space_tree(struct btrfs_caching_control *caching_ctl)
-- 
2.47.2


