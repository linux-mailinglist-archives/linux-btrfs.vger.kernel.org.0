Return-Path: <linux-btrfs+bounces-18211-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89907C024C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE7A5507E90
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667AB274FFD;
	Thu, 23 Oct 2025 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coILX1SN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC9326F2A0
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235228; cv=none; b=DRGkkwjRbhH65B/Lr990c7kHJGTynb+HlZZw8XEOVxxQpbiZ/gE6/OAnqLcTGjmI7KrnmpSft022iOrN12w7vx3nQIhWlHoCTYcA03Ql2RhB+ld9zemZpO8qCMDkiiBwajX9VfBRutRWR1B1RT1hnWvU2kx99AN+Scpnz4hdRts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235228; c=relaxed/simple;
	bh=E4ylvxG5Vlj64S03+0DND4R0mN2O6zWF3QyrtgsoxQg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Up6eD8swIq4xmXmWOehze33wee7kQCnAsOYO2YB6DstMUufW7SgJQ5wCWRAaKcmViggdYO/+tRpdQu9zVOG9EucnRizx+EUbIFS9tYI+s65lBsST31pN75mUzX7rR+iPOsY4Rk2npTllwV7Aetf0MCukDVzFGapJhp/TFuC7fUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coILX1SN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4121C113D0
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235228;
	bh=E4ylvxG5Vlj64S03+0DND4R0mN2O6zWF3QyrtgsoxQg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=coILX1SNhDpIw1PY4Y6gN7Tyft+C72VgWHn0vb8NFHcK0yCulAFX8vBjObYonpGy9
	 jjOZzo4fkMWsfRuxPXWuj3gVaouzTnRlaWYHg1GLQugRFRpYTM3pYCvLQb2DtRjJVM
	 i5mk34SCwSpfCBuTg4IbE9rfkST6qt7zWH6xGgp6oNeSAhgMlq8YIBoHJ7SkwuMwZK
	 Et668LsagRPtjL28b/9twQT5ZAwpLY+hOfuOvZKujKBmH5p0culeYpu49F1Z8FtdzO
	 0KnWot1BywwPVm73YHNCIghSxWuBjbhu+GrZVH2ZGsYGwdF1eTCNXbKzMXzhmiHusK
	 uDmLA2/frP2zg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 24/28] btrfs: remove pointless label and goto from unpin_extent_range()
Date: Thu, 23 Oct 2025 16:59:57 +0100
Message-ID: <7e1a90b064447bf411df4eddb163ec3743901ea5.1761234581.git.fdmanana@suse.com>
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

There's no need to have an 'out' label and jump there in case we can
not find a block group. We can simply return directly since there are no
resources to release, removing the need for the label and the 'ret'
variable.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d839d8d32412..f981ff72fb98 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2747,7 +2747,6 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 	struct btrfs_free_cluster *cluster = NULL;
 	u64 total_unpinned = 0;
 	u64 empty_cluster = 0;
-	int ret = 0;
 
 	while (start <= end) {
 		u64 len;
@@ -2761,8 +2760,7 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 			cache = btrfs_lookup_block_group(fs_info, start);
 			if (unlikely(cache == NULL)) {
 				/* Logic error, something removed the block group. */
-				ret = -EUCLEAN;
-				goto out;
+				return -EUCLEAN;
 			}
 
 			cluster = fetch_cluster_info(fs_info,
@@ -2816,8 +2814,8 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 
 	if (cache)
 		btrfs_put_block_group(cache);
-out:
-	return ret;
+
+	return 0;
 }
 
 int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
-- 
2.47.2


