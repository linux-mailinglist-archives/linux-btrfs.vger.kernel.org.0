Return-Path: <linux-btrfs+bounces-18203-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B64C024AD
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAD50504CEE
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA9528C874;
	Thu, 23 Oct 2025 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JT3sCp0j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354222882D3
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235221; cv=none; b=ZKQ+r0Do2cNQnvY5ICgLljZ13ARhOWpUu1PrzpJ+w63xaj/HXr9yPfKwHXhaniIlbokh1OLFyRotG698WW7LIonJ5Kt//Me7tR3Wu3p9HBZT3+6wGTUEH3hkNHa/SMQbyrPCAoFKlPxU1v9nmiuvJH87bEGqrL8WRdgGmjGwHFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235221; c=relaxed/simple;
	bh=Ci7cRgGQOtKz74GzvbEJxfWpB1FzAAMy4SBlI9ZTPVI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgfNFZL8Bw3tIIcuoqmZ2xgfKn8eO5xjHdzzpLnpW7QJpRKAv+zUzAleZCVIWeDno7VmHUfPfOHzzSmUoAcx90fN+iPFuAthxOsP7DO5ZQzh8jkAcH6gOgw5ghWop7k9NWgZBi6BiA0OvRTHwLbv29c2E/yWCAEDzyOnxGcZ9qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JT3sCp0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFFAC4CEFD
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235220;
	bh=Ci7cRgGQOtKz74GzvbEJxfWpB1FzAAMy4SBlI9ZTPVI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JT3sCp0jQ3OThquJ/NmMQCMnLijArvekZSdS9n/lLj4I9TbGXEs/RM4bXWWOvFeB8
	 c5HQMx9+O6MOwPiIvw7mZUSQ6/xCVa44Ve8INOaTsJm52wisaC5KXBgzgOqSNuWD9p
	 re3cJYEgryPcjq4O5gGA7A/HKvv5WSwn7mNlmM/WZcXclcpTQhm/3KussjjlWJ9QA0
	 pBGruL8ufyQgymoF3TpF4LSVTtvqx/1J70U4GY8g+fgBOY513aebnu9wK42CEg6O8t
	 faP8D6Xxx5Jrl59tqO2/B9/ZbRxLbcIZt/jfP15owwrfiy+ZhDKvzTOfgRTmzgFwx4
	 X2WQT8ZnVsqzw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 16/28] btrfs: reduce block group critical section in btrfs_free_reserved_bytes()
Date: Thu, 23 Oct 2025 16:59:49 +0100
Message-ID: <b57e9237ebc2dd8c987b846575210a0d8412e7bc.1761234581.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1761234580.git.fdmanana@suse.com>
References: <cover.1761234580.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to update the space_info fields (bytes_reserved,
max_extent_size, bytes_readonly, bytes_zone_unusable) while holding the
block group's spinlock. So move those updates to happen after we unlock
the block group (and while holding the space_info locked of course), so
that all we do under the block group's critical section is to update the
block group itself.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index ebd4c514c2c8..856bda9c99d9 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3858,21 +3858,24 @@ void btrfs_free_reserved_bytes(struct btrfs_block_group *cache, u64 num_bytes,
 			       bool is_delalloc)
 {
 	struct btrfs_space_info *space_info = cache->space_info;
+	bool bg_ro;
 
 	spin_lock(&space_info->lock);
 	spin_lock(&cache->lock);
-	if (cache->ro)
+	bg_ro = cache->ro;
+	cache->reserved -= num_bytes;
+	if (is_delalloc)
+		cache->delalloc_bytes -= num_bytes;
+	spin_unlock(&cache->lock);
+
+	if (bg_ro)
 		space_info->bytes_readonly += num_bytes;
 	else if (btrfs_is_zoned(cache->fs_info))
 		space_info->bytes_zone_unusable += num_bytes;
-	cache->reserved -= num_bytes;
+
 	space_info->bytes_reserved -= num_bytes;
 	space_info->max_extent_size = 0;
 
-	if (is_delalloc)
-		cache->delalloc_bytes -= num_bytes;
-	spin_unlock(&cache->lock);
-
 	btrfs_try_granting_tickets(space_info);
 	spin_unlock(&space_info->lock);
 }
-- 
2.47.2


