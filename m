Return-Path: <linux-btrfs+bounces-13672-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF885AAA0C9
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 00:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C99E1A83B0B
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 22:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3447727CB3E;
	Mon,  5 May 2025 22:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abRJUEul"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFB1277016;
	Mon,  5 May 2025 22:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483520; cv=none; b=Y8v3wmeEwepV4hlkAYWaFCJsoubMOhpV+CE92YFVqnSMUXgp8Z8NH8x2rPL8Bj8YnCK1xrCw3stKMe0exUmoYG++OWRjlKAJ/fYboWdgREsa7PXlFvrC5S275Jh4fcUH02WFTB/P3LpnXPU5Tf1DVlojeoBNgn18RYTykW+cDBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483520; c=relaxed/simple;
	bh=dWHIcRRoe5GGlX+3qUK0a+1fQjWFHJ9VNaoh5l1/ujY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rMiHIUhzBMmvjFCQhgepPmjaODRM4Ujscbx5q93ILex1iwGanaD4MIOv7KqshHPOslDgrtCYYFdN5256sXNXKcJqcfB/EcSUY0F6kiUgysVyKDQ18ZEenWGaWszC2pbl0kEbqGTwtp7jk1WqKEQzxyZBTJXjUgx6Q8hrXnSgf0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abRJUEul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E384EC4CEF2;
	Mon,  5 May 2025 22:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483519;
	bh=dWHIcRRoe5GGlX+3qUK0a+1fQjWFHJ9VNaoh5l1/ujY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=abRJUEul2HNKot5F9Lfv4vE2/e77bis6fJq4UNz0senWc+VLwFYnM/+7AmB4ZNaRn
	 NXyAUX+b/FRU5JV++wVDlmQakpuI15ttch/99z/VpBTrqK5WENb5tdM5kadJTtaEMY
	 DvR4Lol2Ou630jkpF/wimQp8sCoKhBlPVlhedQCIBhj9qWWTgle2ZwFPaTBh/SvRG7
	 BBNioLIiO5y8tzJmTc2wgWwwbHPkiJHaor26hVZL/mf8H0Vf+K4M+0wnwwXdRWwaDy
	 jt7AA7k9buXWsB8U/dltA+mcvmriNOka79Wr4dYN6YloAuJW7Ds+z2Fv6V6p6TbEDa
	 9MkwgJkqySiIQ==
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
Subject: [PATCH AUTOSEL 6.14 094/642] btrfs: avoid linker error in btrfs_find_create_tree_block()
Date: Mon,  5 May 2025 18:05:10 -0400
Message-Id: <20250505221419.2672473-94-sashal@kernel.org>
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
index b2fae67f8fa34..039a0c36164e9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2842,10 +2842,10 @@ struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 	return eb;
 }
 
-#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 					u64 start)
 {
+#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 	struct extent_buffer *eb, *exists = NULL;
 	int ret;
 
@@ -2881,8 +2881,11 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 free_eb:
 	btrfs_release_extent_buffer(eb);
 	return exists;
-}
+#else
+	/* Stub to avoid linker error when compiled with optimizations turned off. */
+	return NULL;
 #endif
+}
 
 static struct extent_buffer *grab_extent_buffer(struct btrfs_fs_info *fs_info,
 						struct folio *folio)
-- 
2.39.5


