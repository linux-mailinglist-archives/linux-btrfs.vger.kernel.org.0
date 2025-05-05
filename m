Return-Path: <linux-btrfs+bounces-13703-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515D0AAB04F
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 05:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C44B4C65CA
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 03:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593A828B51D;
	Mon,  5 May 2025 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zqrypqhn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CC62FA100;
	Mon,  5 May 2025 23:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487338; cv=none; b=k0iMqZVVl17UXgfPac4SQ0aQK5uYje+qdmZETarAEWDLwOp04zj2OE+is6diiSxngqyK42UjzL/dwW7gnhsyqMwzBYLXBXwSve651Qqnd2K0Je/3/BGJUPPJUSGXf/g2MQbEDht1wMbklP+775sEm2uP3hOru4DeSR8OemAknmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487338; c=relaxed/simple;
	bh=iGR/zZ+vHKPqohPSHU9sFA3QVASc8jKfflvcI/g/eUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tVwSZlm9e+PNlbMplvNQiR3w20KOEa+qxCLHjwpgNmQzE3Uka0j8YaskHOX5tUcWnNTo3+aDbGqeHKLwPMph0kO+K3LAer2uU8u6Wnj2DIWqH88P8PRYp/hGnz7jWlTJOxe/vSmLO2cZN8RJs01NqEAeuIp8QBSNrOhnrzRZdqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zqrypqhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2969C4CEE4;
	Mon,  5 May 2025 23:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487336;
	bh=iGR/zZ+vHKPqohPSHU9sFA3QVASc8jKfflvcI/g/eUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZqrypqhndepzTXHAwRysf8JlfeOE38ZVvc4+MhLJy+AdhaZqy6XhhjGigjPpG/GRD
	 FAPLb56DwRqZM6tSlblLn0Pq2ND1RIAsVhIkI9R8NQ9MsvxawgTl2vu4v/pw1RPKqr
	 PofUFz7OBD8rFxxIgKdHfYTO6uVd8y+BdzZQNRrzba+W3jmGSL2JyrOyu6b5hES3pb
	 YPRUTHpoxyMilECoJDVgy3aKRsU8t1LqnSBcndeoRf14LQUL5KpwLN5TR/UMVQVNo6
	 hf/j+JrXWtJ95HuV871NF1/8lknm0/zYeyALOwJZTwp+TZcM0432HAPBFUpfQV0vdO
	 Z+VrVSbNYkgNA==
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
Subject: [PATCH AUTOSEL 5.4 14/79] btrfs: avoid linker error in btrfs_find_create_tree_block()
Date: Mon,  5 May 2025 19:20:46 -0400
Message-Id: <20250505232151.2698893-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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
index 04788940afafc..64af1c7f95c24 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5134,10 +5134,10 @@ struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 	return NULL;
 }
 
-#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 					u64 start)
 {
+#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 	struct extent_buffer *eb, *exists = NULL;
 	int ret;
 
@@ -5173,8 +5173,11 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 free_eb:
 	btrfs_release_extent_buffer(eb);
 	return exists;
-}
+#else
+	/* Stub to avoid linker error when compiled with optimizations turned off. */
+	return NULL;
 #endif
+}
 
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 start)
-- 
2.39.5


