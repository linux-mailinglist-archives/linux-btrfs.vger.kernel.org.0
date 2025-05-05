Return-Path: <linux-btrfs+bounces-13706-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B6DAAB3DC
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 06:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B314C3E49
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 04:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF972EC877;
	Tue,  6 May 2025 00:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLr3d4Cw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813DC3984B5;
	Mon,  5 May 2025 23:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486449; cv=none; b=qS5L4tj/Mh73YWb3Vp6H9N+/DejwCOZh0CJN+QFi/Y3AUId4MJN2lUxtn37Ozgnpzgy+JrwTn6xfyZx+iYUZ2KFC37E53wa+EXKG0C6oKMoYADeAfIEV8bZshfwlNI07tDiCYsrfHAk21J3P3GUoRCsiSQaAF/5XZuSo891Zny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486449; c=relaxed/simple;
	bh=MPF6wWBKzM1USUfhyPEyr7DIB2q8BE1AbSadFY40MF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YSaZ6yLHXbLqXrfCUV2etrLErEOSsWMuZ2m4qJcc4b04uy99shdl2x++YUEIq4uDCPn6kzSK0ORzEiM8zz1jy5dm4kBRCbRQmHYQFxX5RyYeFhQBHswfbjaDwOHI7AxPI/Y2OwC7SoLQCgEJtpepSYN3Fwl9qlLIIRUx9NpEyXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLr3d4Cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AB8C4CEF1;
	Mon,  5 May 2025 23:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486449;
	bh=MPF6wWBKzM1USUfhyPEyr7DIB2q8BE1AbSadFY40MF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZLr3d4CwULH4QzVD7PZzzu906PVHSg7P9dHgTuebpxXGtFOJdTOsHcLXFz/bc9jUP
	 XoB/GWTUiMnrr7w9pLORAcJFkq3jG6JvYj8RnhNwVMK1yzZ/LIjPiY43hEpFJ6Yw/4
	 cwx0SH8ahXaZ+D1IfyUdJlHIwBjh0XVyqL1cniEmvly4dq9ZJQXxOucvBKYhfum2OZ
	 CcnCaGLdnQptbeXsFETGUAtASK52zpu+M66GG2KvhlDZzr70IRRJvlo7cGxtGGFR5T
	 Fv9yiplBolj5e5tvJ0jr8NyrISa+Hn5GrBUQZnyfDvuFQwKBXtzmH9FijCtE2aZrFz
	 LGDU35o/iI42g==
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
Subject: [PATCH AUTOSEL 6.1 035/212] btrfs: avoid linker error in btrfs_find_create_tree_block()
Date: Mon,  5 May 2025 19:03:27 -0400
Message-Id: <20250505230624.2692522-35-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 72227c0b4b5a1..d5552875f872a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4459,10 +4459,10 @@ struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 	return eb;
 }
 
-#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 					u64 start)
 {
+#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 	struct extent_buffer *eb, *exists = NULL;
 	int ret;
 
@@ -4498,8 +4498,11 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
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


