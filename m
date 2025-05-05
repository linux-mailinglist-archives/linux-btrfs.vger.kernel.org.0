Return-Path: <linux-btrfs+bounces-13683-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8102AAA923
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 03:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D451887C30
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 01:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E578357D53;
	Mon,  5 May 2025 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftITrAzv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850362BDC3F;
	Mon,  5 May 2025 22:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484915; cv=none; b=WQi9VxvcupKVNMQjb9LeoETe1nmPKKXUbT8DuZnTFjtncCE8JPJPBrih4igduanT60/qJ53adGLlHvzs1L6YwIvGYJk85TaFaIanc/nVZRjbTsetL4exOjrg8qaoXHTvOKxM0MGLbx+UNfPt7uOTxkXGCV16ty9cBxRW9r96KAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484915; c=relaxed/simple;
	bh=Yu6JyDoqNNpqZpfmB4lS+qekMl3jPhuy5V5nCwPfnic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ins/f+fPmHtkh+SL4mLwju5w/lgFc56qw06mf+WNXaKodwYmnhX5iMCLAnuLQbFl1jDwv3AlSm2exjN56c51Gqp8HqntmrIrKB+OLKB9lWammT1p6yE9x6zUpRzyvSTUFAGNlncd4djFCI6sfpNIhOGgDh4JJh1B04p0NeMQOgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftITrAzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE48CC4CEED;
	Mon,  5 May 2025 22:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484915;
	bh=Yu6JyDoqNNpqZpfmB4lS+qekMl3jPhuy5V5nCwPfnic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ftITrAzv77D54U4fNPwE5QXE1VHkYBwkxqDyPyJAOpKzdhdMTYL5EsgxzIfoM5AOZ
	 PeL8x5vqpJQW316muHjeHfEtVR3BOwX3p/A3ssAK8bqj1oAkeeaPX8tkt+3muxfwo9
	 YX5ktWrcdxNcSkA5ErTcj7NZ97lMeHgaqiGRqYaFoutecz0t3Z7S5jGNFUH/uo/Myz
	 37nEan2BnrTdDNWzZ3FErnB6dZLlHGR6AUjTYMSOVCjn/JDKsl0F2+XyeAgJn5lYSU
	 8mmRXWGdaXFBicQ/uaBIuFfrpOSQtWpDcjS/3c5NpRvronRHvdTh+Cbffz66OXvL8x
	 s2stEMhNEKpxw==
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
Subject: [PATCH AUTOSEL 6.12 073/486] btrfs: avoid linker error in btrfs_find_create_tree_block()
Date: Mon,  5 May 2025 18:32:29 -0400
Message-Id: <20250505223922.2682012-73-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 6551fb003eed2..b134cb324dab8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2826,10 +2826,10 @@ struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 	return eb;
 }
 
-#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 					u64 start)
 {
+#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 	struct extent_buffer *eb, *exists = NULL;
 	int ret;
 
@@ -2865,8 +2865,11 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
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


