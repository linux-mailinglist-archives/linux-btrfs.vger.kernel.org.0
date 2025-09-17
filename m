Return-Path: <linux-btrfs+bounces-16880-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8B0B7E0D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 14:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DAA580DCE
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 07:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEC93054D8;
	Wed, 17 Sep 2025 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l326jd7m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC2B3054C6
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095567; cv=none; b=R5bhLxJ3wR5ErlFnG4v7GVFmaPMXdg2zTH/S9TspONYXwmTRczGNTd9XDp5T0W9+NZXznb2QEz+/3uYrxOgAXBMivBZAtNrYZBvpxKeS7BITuTBGHCY0Mpbm8DUm3E6nTG/iMm5UrDALip9n328cBYmxrIGu/lRU33RsHrMDXwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095567; c=relaxed/simple;
	bh=8C3oFvQRIYsErTVf51RK/2UXiI1zIwZOPLvdCE2dUO0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTd4NJRjgqNE5Untgys6HoEwC45f4ZaM+nt4kUxfTRfsI+qqVR7lJk6AVfWL/lqyO5abdxvZ3+oTXWf/9Y2q7rrCTrvK2C0W97vuWrUelmYBBkILbUEUu556Pvo5Jf7Z92lfczrw7hyQqm5RVQX7wakM9T2/EQHqGv/2mA86t8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l326jd7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7B5C4CEF5
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 07:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758095566;
	bh=8C3oFvQRIYsErTVf51RK/2UXiI1zIwZOPLvdCE2dUO0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=l326jd7mxONLtru4yiAKHuj27pIcbW+cPaPhCcIskSa9WPLy4myeF7KuSWS6SFKlC
	 +KYGabd/zmVBGJ02rxfoUqOcZ7CNsCvbetewOjA3o7uts2SLIqqCGzc/NV/I1pFHrt
	 psgRZKOr8BuUnGmb/tdEPn7VJW0nDrO4zO4Q/TyV4LEN9qrbtCNgKUp+SVHaviuMEB
	 Ts65f+g2xMGl/K1WAi5myD2i13lEyTcfFvs06XKTW7chnHFIYAg6WrQ5bTegAf1qCx
	 XlRqGoLH4Tz8EZ8ZuaLZv3hF/A1B3rqCqJEk1KTr3K1Vneee5qG6rrmhxWqXeaUl5/
	 x17X5NW93nGZg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs: store and use node size in local variable in check_eb_alignment()
Date: Wed, 17 Sep 2025 08:52:38 +0100
Message-ID: <68361e4cd090b73eaada7df77d5a402d8fbfcf88.1758095164.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1758095164.git.fdmanana@suse.com>
References: <cover.1758095164.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of dereferencing fs_info every time we need to access the node
size, store in a local variable to make the code less verbose and avoid
a line split too.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ca7174fa0240..681f4f2e4419 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3226,29 +3226,30 @@ static struct extent_buffer *grab_extent_buffer(struct btrfs_fs_info *fs_info,
  */
 static bool check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
 {
+	const u32 nodesize = fs_info->nodesize;
+
 	if (!IS_ALIGNED(start, fs_info->sectorsize)) {
 		btrfs_err(fs_info, "bad tree block start %llu", start);
 		return true;
 	}
 
-	if (fs_info->nodesize < PAGE_SIZE && !IS_ALIGNED(start, fs_info->nodesize)) {
+	if (nodesize < PAGE_SIZE && !IS_ALIGNED(start, nodesize)) {
 		btrfs_err(fs_info,
 		"tree block is not nodesize aligned, start %llu nodesize %u",
-			  start, fs_info->nodesize);
+			  start, nodesize);
 		return true;
 	}
-	if (fs_info->nodesize >= PAGE_SIZE &&
-	    !PAGE_ALIGNED(start)) {
+	if (nodesize >= PAGE_SIZE && !PAGE_ALIGNED(start)) {
 		btrfs_err(fs_info,
 		"tree block is not page aligned, start %llu nodesize %u",
-			  start, fs_info->nodesize);
+			  start, nodesize);
 		return true;
 	}
-	if (!IS_ALIGNED(start, fs_info->nodesize) &&
+	if (!IS_ALIGNED(start, nodesize) &&
 	    !test_and_set_bit(BTRFS_FS_UNALIGNED_TREE_BLOCK, &fs_info->flags)) {
 		btrfs_warn(fs_info,
 "tree block not nodesize aligned, start %llu nodesize %u, can be resolved by a full metadata balance",
-			      start, fs_info->nodesize);
+			      start, nodesize);
 	}
 	return false;
 }
-- 
2.47.2


