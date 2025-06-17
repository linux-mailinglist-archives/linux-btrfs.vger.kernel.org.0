Return-Path: <linux-btrfs+bounces-14737-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2C6ADD659
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 18:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FBB0189E10E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 16:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03BA2EE29A;
	Tue, 17 Jun 2025 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5MCKTr7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60022EE291
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176800; cv=none; b=T6F6u3b4GLVYuVBYwII7OxwOd44EEJFL9YXel63jLh//uqhAJDfWkvAQM6ZjBqV+nRIq8zg8ReDOWzgsR0uvga9o0gAIyklFzC3s0BBwMnU4pDDN39IbWS+mamFPZfROMt83vjWSZixNcfT4FhJZlVdu3OS+wEFT6iSeogOrCoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176800; c=relaxed/simple;
	bh=IECastDFsU8uaJLLcm5MgaYBZFULvWcENiNswhNY7FE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vATifejBfRgltrpDjxA7+UYC7wT/EuOBKiYEeRt5soSa91goa6jNLcyDOdL4dcKVU/1FDK2KjQbNE6IM/7l/E7iINqLCgzvGTruYtAueSTtYXw/f3A1hLetpkxlwrrEzpV9BoBVbBEae0wcW22RcbnE3Z7J5vssceHwt5VqLTog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5MCKTr7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C848C4CEF1
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750176799;
	bh=IECastDFsU8uaJLLcm5MgaYBZFULvWcENiNswhNY7FE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=R5MCKTr7IUKTHzudqWJ6UdW5TrYIv9vDELJEBy98opmcJtmEqskSfxnFhSilDl+F/
	 viUBdKwpIwcbZKseKrd3VRRyGPVA4WF1TiVbzPXXuqmERoCfDKUAa8uBzkWOXQl2PB
	 RZ+hT6ee3BbPVq8BrzMrgqROyBY6UYa8Baa+CX/caMtJiG8Sq/GFwQsftAPpq1GQ3M
	 j8lXRigxR0Otg15IZoetBshfuG4stNZxg574bcmKfya4RCjQHz2tCpSKnZ5O/2cmdF
	 VLzwyk/SyKUEMTBIeDAYyF/7moBHOPVj525YogDr6kS9EE+G9Iej0cisTYbKFJPvux
	 bMwrw0jajP+JQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 08/16] btrfs: remove pointless out label from load_free_space_bitmaps()
Date: Tue, 17 Jun 2025 17:13:03 +0100
Message-ID: <390449c96bbf76e4a361b53ff1376ef07afbbed5.1750075579.git.fdmanana@suse.com>
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
 fs/btrfs/free-space-tree.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 1f76860ec61e..0514b0a04572 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1554,7 +1554,7 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
 	while (1) {
 		ret = btrfs_next_item(root, path);
 		if (ret < 0)
-			goto out;
+			return ret;
 		if (ret)
 			break;
 
@@ -1581,7 +1581,7 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
 							       offset,
 							       &space_added);
 				if (ret)
-					goto out;
+					return ret;
 				total_found += space_added;
 				if (total_found > CACHING_CTL_WAKE_UP) {
 					total_found = 0;
@@ -1596,7 +1596,7 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
 	if (prev_bit_set) {
 		ret = btrfs_add_new_free_space(block_group, extent_start, end, NULL);
 		if (ret)
-			goto out;
+			return ret;
 		extent_count++;
 	}
 
@@ -1606,13 +1606,10 @@ static int load_free_space_bitmaps(struct btrfs_caching_control *caching_ctl,
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
 
 static int load_free_space_extents(struct btrfs_caching_control *caching_ctl,
-- 
2.47.2


