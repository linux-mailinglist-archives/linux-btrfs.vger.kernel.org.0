Return-Path: <linux-btrfs+bounces-13299-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CE2A98CB1
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89AEF1B64EBC
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 14:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8122027E1AC;
	Wed, 23 Apr 2025 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mB7GH9SD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5832155316
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418010; cv=none; b=oXyRpZkCKkdi7zQq4vltPPJ/jxt0/Nrv87pUc8gk7sDlgaT/BvKZQXIMusDSsNa/e2bANkrJiDuCDiy2IVDdAY23qisjsCICN16j1a5J12RHvsomQwOH254XneRu6YKIMiMC7Jlhcd32ZLqU0hSSAKJgzeZvn0s4yj611mux5lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418010; c=relaxed/simple;
	bh=jEq7gcoKvkHOS2SEAlYKVJNqTERxASB4Eb06GPd27Wc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HVY9Wb6bF6+ZMcakK2zXhhCG36aqaFldDMDciBBOZaFUUJct2bPD1RD5tGdUef/dz3CcRwJwPCHeX/2R1P1gPr93nrc8S6cmz09Y8Ijq1yo6ZPN2XS4HP3Yf5kV0SR5pJRYoP7CIVUbWacxFAT80sCwAtdbeTM8bzETyIqZAUGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mB7GH9SD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDD4C4CEE2
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745418010;
	bh=jEq7gcoKvkHOS2SEAlYKVJNqTERxASB4Eb06GPd27Wc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mB7GH9SDemsC9n90kfVUZnYb2CnPVjJzObgWa5ZBsy7FAKXmoCctakTXKdhfjEQJY
	 iqwzwdmDAIL/xIVmZJ81IogXxOAt7KMm8ZHtbh8od80OTXUXrQfQb/oOlt3+9p9pf7
	 YB3aNgl9cPdFL2LyOLyUS5+HJ3DEomstHljZP3h4sLurgoTvEq8aEkWrbkvxtDJQ+S
	 Zky57N6kw28KGjurwO02V8yGfX93FAW3AqHkrovHtDqZr2GM7g+6Qwq7YZW3IjWFBx
	 ImU6BJjvYEVpWgXZt8r56Hzn5E3DgCHefy3400ICLwiXMlueqxezzebwfm3AxN0GXq
	 kdQyfI4i9xK7w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 04/22] btrfs: use bools for local variables at btrfs_clear_extent_bit_changeset()
Date: Wed, 23 Apr 2025 15:19:44 +0100
Message-Id: <3bf524e58a5dfc2faa52a9440332ff34bbf36a62.1745401628.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745401627.git.fdmanana@suse.com>
References: <cover.1745401627.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Several variables are defined as integers but used as booleans, and the
'delete' variable can be made const since it's not changed after being
declared. So change them to proper booleans and simplify setting their
value.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 35c8824add34..b56046c55097 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -605,9 +605,9 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
 	struct extent_state *prealloc = NULL;
 	u64 last_end;
 	int ret = 0;
-	int clear = 0;
-	int wake;
-	int delete = (bits & EXTENT_CLEAR_ALL_BITS);
+	bool clear;
+	bool wake;
+	const bool delete = (bits & EXTENT_CLEAR_ALL_BITS);
 	gfp_t mask;
 
 	set_gfp_mask_from_bits(&bits, &mask);
@@ -620,9 +620,8 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
 	if (bits & EXTENT_DELALLOC)
 		bits |= EXTENT_NORESERVE;
 
-	wake = ((bits & EXTENT_LOCK_BITS) ? 1 : 0);
-	if (bits & (EXTENT_LOCK_BITS | EXTENT_BOUNDARY))
-		clear = 1;
+	wake = (bits & EXTENT_LOCK_BITS);
+	clear = (bits & (EXTENT_LOCK_BITS | EXTENT_BOUNDARY));
 again:
 	if (!prealloc) {
 		/*
-- 
2.47.2


