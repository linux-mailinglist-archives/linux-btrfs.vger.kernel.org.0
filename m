Return-Path: <linux-btrfs+bounces-13701-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DB8AAAD14
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 04:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471CD1A823A1
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 02:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BDD302711;
	Mon,  5 May 2025 23:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGR+3vSR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD66C3ABD1B;
	Mon,  5 May 2025 23:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487138; cv=none; b=pKfYemSVikg5sLI57sWkKXIwNinJ0ukWFKAQ2g8GaQhg/mPGiXj+1p0v0QFJZI1cWjBw5ZmqDIeB8CDjcS1Reinxo9O4WPfV/oV5PQEN6LpBaL2oc3QOiFrYK7Rh52EzNxcWBPbWRtm/m6K9+mEWs26fq0daJ2QCwxAUo01E/K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487138; c=relaxed/simple;
	bh=WjjG5iZEJ/0bu7a9/eg4sO45fEiAW7w4TwiFfNZRZns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pPfcjcQ7gvXVjvQs9oSirW/aR5aukjwPiy+JLStT1nSJidEuwg1RTjadzfCy0re9ooMefZUfBIiG99aL37w0VNcLnE1dm3NK/rvEeevA9umV7EC5ZmwkKVoQm64jFkfUsaeNf5GntVfXIJUYxUUHrATzy8TJvote3r23gh44Emg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGR+3vSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0B6C4CEEF;
	Mon,  5 May 2025 23:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487137;
	bh=WjjG5iZEJ/0bu7a9/eg4sO45fEiAW7w4TwiFfNZRZns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PGR+3vSRdCT0Bt4SXbe063mU3Aqe1XmyqV69rgDke9oOZ4MtA03wzkpNZe0d8AJ10
	 /hwI6PB2O6VAbqnynIKJRuHapr5OAgZETaVSL30DE+d5EfBh9IBkmmnoh7d302hdxi
	 NKYIrSc6rDRkY4y56f+3cOF2bjOsBTRucOKCNb2Rw7GFjpEBi7j4zmtuCH3ucKHLew
	 RFYPHqptW/lEa+tjuXdPXdlgnMBVGKvPxta76nIYOLbYdV3CaJAd/18hSGcCEeU4pX
	 0tkKo1NM1D82858WE8cY8d6EkF1V7dlM4upAM73KXMrLtDGAjsKqOIuHYeQT2HPJmO
	 xqoKIXmAYgqwg==
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
Subject: [PATCH AUTOSEL 5.10 019/114] btrfs: avoid linker error in btrfs_find_create_tree_block()
Date: Mon,  5 May 2025 19:16:42 -0400
Message-Id: <20250505231817.2697367-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index 9cef930c4ecfb..8498994ef5c6d 100644
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


