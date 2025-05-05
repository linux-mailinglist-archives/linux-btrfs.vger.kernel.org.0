Return-Path: <linux-btrfs+bounces-13691-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85929AAAA87
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 03:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE1A188A233
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 01:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C3F390CB1;
	Mon,  5 May 2025 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/XJtHUE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5AC36F8A9;
	Mon,  5 May 2025 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485883; cv=none; b=p6tQvD8YkJLd1qlRkw9aF9YgNXdwQut9tKy4r5LYYebIPyJS1kLGtlwc5ACEJRDssf0nDTegZ3AWRhLqkmKg+1C8v1awyIVDQ3OkVIJ5/BWVb1Gkk/1WmMYO9pqmO8pB9C7nMb2dyoOOdzMqqjbMi43uuHddP/mIE9pYrXT723k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485883; c=relaxed/simple;
	bh=f5/B2Mfzq5P2YwMNlv/oDxj8SYgk9gI+Ms84kCduhPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cITcgbvh/9v1ovcBxcrVVnnGaWgMOc0cfpHPFjZlVNYC6Upu0jSrhJcTMLOUYcXHdbwefJnXi769kod4YFG4RAEIzp4/ZNIgWA7pF0jFzeDVWkufR2i/oFBBDr8461pxLDEQdmjRHEnHwQp2JTZOgmoFrithb4qJ0TkoHWn19fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/XJtHUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8F9C4CEEE;
	Mon,  5 May 2025 22:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485882;
	bh=f5/B2Mfzq5P2YwMNlv/oDxj8SYgk9gI+Ms84kCduhPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l/XJtHUE44XsxRYtN6rEzRGPYPJWUeIKlQDpG+iCSnhqhMPkZb8cho7MQF2+xxQWl
	 OcPRhxCBAyCm6SiH9pB8mLhiNjloCrG362IXm3xJZfKFWBglQ+d9q28clnfCLXWOE8
	 QahmIcLzK6VR6rHBQDmKIHTvKEH4aiBApkpn50Mkz4iXfwhiuKziC5MI9luSDQur7m
	 h5VpHdPURGLhXrG1/xAJYP2yVtuEJQHdh2Dn29fbqKURHBOJMC0XHV7JQTt3JDJPn0
	 84P/U5Z58N4tr0l5A+dcEhpQg1YBTcsFMm9FJRScF22HQJRyWxYVketO4P/xyyTJRf
	 1yiILIT4dNHcw==
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
Subject: [PATCH AUTOSEL 6.6 045/294] btrfs: avoid linker error in btrfs_find_create_tree_block()
Date: Mon,  5 May 2025 18:52:25 -0400
Message-Id: <20250505225634.2688578-45-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index b2ae50dcca0fe..ed08d8e5639f5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3565,10 +3565,10 @@ struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 	return eb;
 }
 
-#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 					u64 start)
 {
+#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 	struct extent_buffer *eb, *exists = NULL;
 	int ret;
 
@@ -3604,8 +3604,11 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
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


