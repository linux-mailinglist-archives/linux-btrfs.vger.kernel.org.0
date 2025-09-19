Return-Path: <linux-btrfs+bounces-16957-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A09B88C51
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 12:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1B9581A1C
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 10:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285522F6178;
	Fri, 19 Sep 2025 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zp5mqJUm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4F12F4A1F
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Sep 2025 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276706; cv=none; b=YTvx/cTQsN/g+1om8FZTQ7HY617Xk0Vt9Bgsk4Nn+vZ9+ON97KVRpxKaKrm/IN4dR6j+2xLkLcdeS+TzK4Bo3MjyeRqDXmvODewgpD8FjYHkaFriBJ8Kd6Rvfmmv4L2RzYulInxW4P/49AESxs8jM1xNQT6JaBRV5kW8aJpJ5MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276706; c=relaxed/simple;
	bh=harBXWIwtnGJGQDgA0ON08XxcaqpKr3K/ZiJMJ/4G2k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jy66o0/pl7Y0zsEHa6kvN3hS6qeM1yDr4joblTFGD5LOPOtO2n+TQIsEZoUtUV8HVxbBgjgdXuw3XIRrcIGsKq+RZ/nY0yz5JH49DiTlVOx5JWbI4sFZiP/li8mOz6vqFhTZm09nzqVz8oabMtyFCd/RGT++WpMfzSN5qLC7DiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zp5mqJUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6B0C4CEF0
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Sep 2025 10:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758276705;
	bh=harBXWIwtnGJGQDgA0ON08XxcaqpKr3K/ZiJMJ/4G2k=;
	h=From:To:Subject:Date:From;
	b=Zp5mqJUmjPMpWXtONJjj3Kfj/yyBxOQkcxuIld9U3sYEEEAQv5mKfdHvdZTShfVpa
	 9Ehnh9jQxgEvGCvHwvfnmPp8EBaa/eC3sGbUlRC/a9GyRYanXEttIzZvWO0du1cyDP
	 Zn7lbGHIxsOE8Q+xCfIbOhGVE/TFZJPheDEJavoQxuKpQM5oLwevT56kwBz9e532o2
	 e2jV50Hhs2peI8tFP06Z3hVLoZ/PXRY9X3cI/i/ProivIiUUmZ0SXyDR24BjfdePA5
	 mD5DrxrowUj1ced+TtRkRwAwc4HLgAvAPwZtou1k2s2RQmgmkWPKCrjetNm8uXq1bh
	 ZXSrJpETy2HBQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: make the rule checking more readable for should_cow_block()
Date: Fri, 19 Sep 2025 11:11:37 +0100
Message-ID: <430201af947578096cabe79fc4a1eaea731e8ef4.1758272660.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's quite hard and unreadable the way the rule checks are organized in
should_cow_block(). We have a single if statement that returns 0 (false)
and it checks several conditions, with one them being a negated compound
condition which is particularly hard to reason immediately.

Improve on this by using multiple if statements, each checking a single
condition and returning immediately. Also change the return type from an
integer to a boolean, since all we need is to return true or false.

At least on x86_64 with Debian's gcc 14.2.0-19, this also reduces the
object code size by 64 bytes.

Before this change:

   $ size fs/btrfs/btrfs.ko
      text	   data	    bss	    dec	    hex	filename
   1913327	 161567	  15592	2090486	 1fe5f6	fs/btrfs/btrfs.ko

After this change:

   $ size fs/btrfs/btrfs.ko
      text	   data	    bss	    dec	    hex	filename
   1913263	 161567	  15592	2090422	 1fe5b6	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index dc185322362b..13dc44e90762 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -613,15 +613,12 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static inline int should_cow_block(const struct btrfs_trans_handle *trans,
-				   const struct btrfs_root *root,
-				   const struct extent_buffer *buf)
+static inline bool should_cow_block(const struct btrfs_trans_handle *trans,
+				    const struct btrfs_root *root,
+				    const struct extent_buffer *buf)
 {
 	if (btrfs_is_testing(root->fs_info))
-		return 0;
-
-	/* Ensure we can see the FORCE_COW bit */
-	smp_mb__before_atomic();
+		return false;
 
 	/*
 	 * We do not need to cow a block if
@@ -634,13 +631,25 @@ static inline int should_cow_block(const struct btrfs_trans_handle *trans,
 	 *    after we've finished copying src root, we must COW the shared
 	 *    block to ensure the metadata consistency.
 	 */
-	if (btrfs_header_generation(buf) == trans->transid &&
-	    !btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN) &&
-	    !(btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID &&
-	      btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC)) &&
-	    !test_bit(BTRFS_ROOT_FORCE_COW, &root->state))
-		return 0;
-	return 1;
+
+	if (btrfs_header_generation(buf) != trans->transid)
+		return true;
+
+	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN))
+		return true;
+
+	/* Ensure we can see the FORCE_COW bit. */
+	smp_mb__before_atomic();
+	if (test_bit(BTRFS_ROOT_FORCE_COW, &root->state))
+		return true;
+
+	if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
+		return false;
+
+	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC))
+		return true;
+
+	return false;
 }
 
 /*
-- 
2.47.2


