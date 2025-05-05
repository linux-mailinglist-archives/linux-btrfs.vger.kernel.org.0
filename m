Return-Path: <linux-btrfs+bounces-13710-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DA4AAB4BD
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 07:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA1FF7A4A02
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 05:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF61344FFF;
	Tue,  6 May 2025 00:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkhWJ/ua"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811B12DDD0A;
	Mon,  5 May 2025 23:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486853; cv=none; b=NBIVhAhAU2NKn0wAtfmvS8SWTGAMcbx15bwE2a3w870Us6dYtlgXaMZ8g0X1LPmaP2ZWsT30Glel7Rr9Pegjqij94UladxyZoW7siAFzNfNFOFWRKDZqR0x7TF1e8nP2Gp7IJ+wlpfKDwtQSz+BAzxmFYXm4iaDTfA6S6Y4GjT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486853; c=relaxed/simple;
	bh=mox9aB0Kz4Li3+c90BVamrOjGfGgywkLLWJt+B5tPgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tJaXQpjJz3HzR3cadWyx1YOS2GdlBRvk4qaP1yynxxjbb5WwYZa+ovIZRg2slaysxGiD0E8/1ejUcyKGVpSRtufEGXa2iZHMgXL5+g9SU8PVhNWCf8ID6x75KpkYfoSZQ/Ps/m52L3ZWkagMgKR4ru5ppAVIITaadFHCdzDoAT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkhWJ/ua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7F9C4CEEE;
	Mon,  5 May 2025 23:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486853;
	bh=mox9aB0Kz4Li3+c90BVamrOjGfGgywkLLWJt+B5tPgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OkhWJ/uaht+CNVb+X9gD5V/7bWjndWabM3nlqvx2xB7LhfenTgz20Q82vNSSh2c6U
	 rETrPJakxWp2n1CIgUvUwMQ4/UcbBewrD69Y9ua2JQBA+V39lJkOzEEsYWS6C/YgFg
	 /DJ5QkB9XPbgKjx8jeNKYWDzrOxNGESBMQZVnkT3Ez0FwmY7WlsQCkW3eLe/GZIkXT
	 5odF3DGXSfU5i/t1PrLR72OLs3kKksq0l6jZ3JxrxXie2m0FiovG6XbP9gJvy1MBwB
	 7kkXEZO3c6kDHxKtQG4tdFCXocJWxwRbvRbm+NGPCiSFLE1mrTawQHiGECydgjr766
	 VXx6gfCM2oJIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Harmstone <maharmstone@fb.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 025/153] btrfs: avoid linker error in btrfs_find_create_tree_block()
Date: Mon,  5 May 2025 19:11:12 -0400
Message-Id: <20250505231320.2695319-25-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

From: Mark Harmstone <maharmstone@fb.com>

[ Upstream commit 7ef3cbf17d2734ca66c4ed8573be45f4e461e7ee ]

The inline function btrfs_is_testing() is hardcoded to return 0 if
CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set. Currently we're relying on
the compiler optimizing out the call to alloc_test_extent_buffer() in
btrfs_find_create_tree_block(), as it's not been defined (it's behind an
 #ifdef).

Add a stub version of alloc_test_extent_buffer() to avoid linker errors
on non-standard optimization levels. This problem was seen on GCC 14
with -O0 and is helps to see symbols that would be otherwise optimized
out.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Mark Harmstone <maharmstone@fb.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 346fc46d019bf..c98558588884e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6025,10 +6025,10 @@ struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 	return eb;
 }
 
-#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 					u64 start)
 {
+#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 	struct extent_buffer *eb, *exists = NULL;
 	int ret;
 
@@ -6064,8 +6064,11 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 free_eb:
 	btrfs_release_extent_buffer(eb);
 	return exists;
-}
+#else
+	/* Stub to avoid linker error when compiled with optimizations turned off. */
+	return NULL;
 #endif
+}
 
 static struct extent_buffer *grab_extent_buffer(
 		struct btrfs_fs_info *fs_info, struct page *page)
-- 
2.39.5


