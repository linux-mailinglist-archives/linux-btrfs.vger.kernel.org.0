Return-Path: <linux-btrfs+bounces-13675-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A98AAA0D8
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 00:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C18D1A83ABA
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 22:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFCE296D26;
	Mon,  5 May 2025 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lc2SVXtw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A12129617D;
	Mon,  5 May 2025 22:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483524; cv=none; b=orASi5fkI26Jy7GFcls8wKhA1al2WoaJxsiy9D9H69ASN5w6RwifSH8or0bb/taf4TEOHgOLib07cOBoNOHCYfj5gt+kuwPbp6j388RtcaDtQUrhT59MZkSvC9GxuF8u13JPYw/H1Z0c4MGRPTGJ4WiJHO4SMQQrwfVUodSjlk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483524; c=relaxed/simple;
	bh=ToHF1cq/p3MTPM+O/p9Wc1zUtzA6buJVgTDYsXAHAYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aFulj8+Ke9TYEeArveN9t9iJXtrfTKaI0EdpkATqPVxzGer1jCfG2+G/Vp8OvksMH86UOfeLcKA/9TJxvjoSSie5FGzgGHOKlb87s/9CYUpRpfZUafTCO3vVw14GUDj/1MQanmvfRCkC8IFoPDWvN8CM9gkaARNQzLVQSNRAm4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lc2SVXtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1319DC4CEE4;
	Mon,  5 May 2025 22:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483523;
	bh=ToHF1cq/p3MTPM+O/p9Wc1zUtzA6buJVgTDYsXAHAYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lc2SVXtw/aBiEIEJDT1xqAkAgjmI6rQm/z3XUolgBJI5GEcJee/U2Q7zta/7OcOwP
	 CRzQE+5Hc0sSCwWB7N4M4Pw82UDCrmHut2kOQniTzeL63HPIa02Jgm6WFGh79IhKg3
	 i/Tl7gFuoFgwWjedOi6Hr+sOdEgxm9I4l6MmuE7tvMegTar1zVOtcrXb9rXFMfbLYO
	 3+pCBKFSAC46vSLAamf6rrnsMERh19mFlkQPGTRwj2Jdqs/F103R3ul0NQ6ekzMWwc
	 vwlmO/rIE5d7yqhgAcMsdTk4LCZzlrqlVS3nqv22vOYR6F5VdoFcQr7jPdjq2yZCNQ
	 JLd+rJM4Jdu6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 097/642] btrfs: properly limit inline data extent according to block size
Date: Mon,  5 May 2025 18:05:13 -0400
Message-Id: <20250505221419.2672473-97-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 23019d3e6617a8ec99a8d2f5947aa3dd8a74a1b8 ]

Btrfs utilizes inline data extent for the following cases:

- Regular small files
- Symlinks

And "btrfs check" detects any file extents that are too large as an
error.

It's not a problem for 4K block size, but for the incoming smaller
block sizes (2K), it can cause problems due to bad limits:

- Non-compressed inline data extents
  We do not allow a non-compressed inline data extent to be as large as
  block size.

- Symlinks
  Currently the only real limit on symlinks are 4K, which can be larger
  than 2K block size.

These will result btrfs-check to report too large file extents.

Fix it by adding proper size checks for the above cases.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 38756f8cef463..3dcf9a428b2b4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -583,6 +583,10 @@ static bool can_cow_file_range_inline(struct btrfs_inode *inode,
 	if (size > fs_info->sectorsize)
 		return false;
 
+	/* We do not allow a non-compressed extent to be as large as block size. */
+	if (data_len >= fs_info->sectorsize)
+		return false;
+
 	/* We cannot exceed the maximum inline data size. */
 	if (data_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info))
 		return false;
@@ -8660,7 +8664,12 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	struct extent_buffer *leaf;
 
 	name_len = strlen(symname);
-	if (name_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info))
+	/*
+	 * Symlinks utilize uncompressed inline extent data, which should not
+	 * reach block size.
+	 */
+	if (name_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info) ||
+	    name_len >= fs_info->sectorsize)
 		return -ENAMETOOLONG;
 
 	inode = new_inode(dir->i_sb);
-- 
2.39.5


