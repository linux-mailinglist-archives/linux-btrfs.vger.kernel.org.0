Return-Path: <linux-btrfs+bounces-16709-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C2FB48923
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99B4189CF54
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC112F83B7;
	Mon,  8 Sep 2025 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtgWE4oo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CCC2F8BC0
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325224; cv=none; b=s9/Zl3ejbyXAWzROpECFn3iQwRaFHjICPoabv8ymPRJAc5VQ1HwmcaO4jwArdRtRtgvg3U5rKCijYDaFOt4g3UOLLkbvYf57ucMIi6y5HKxNluHzz2xuh5Fhe7+uFheF3OZ7rsqFxAtLDxLvdko1st3RrZBGiaFrH0alNvU5Dm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325224; c=relaxed/simple;
	bh=69t+w7M5Fb7KViV4yPWb+g/SV8f1HNSKnAXUgUtPalM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYc3jbTldAkVpaw3uKzCh6npUzrNpqek7ySc/5KS3Z6uIKDs55iN70vbTzpuQOGUbKVd+RNuxhjnV2iMYno7O980v1J1eRCEwK5cQMu8/ji1ABh0DYTBpLXrp1qoK9MKeqMGgCTKl8HXRv6GnOo82QxW0jCtkg4mcHqtojVgDQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtgWE4oo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF44C4CEF9
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325223;
	bh=69t+w7M5Fb7KViV4yPWb+g/SV8f1HNSKnAXUgUtPalM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FtgWE4oo9FEwmaly74GZRdM9V4v72bHsIY1+CsdRhLj8Z63V9KyiLzMLRsUAUsh5N
	 V7O9kOIM0elvC9NoE8xqW1LH2FQ8nnsvnB+9WBVWFMQ0NlHft8ftF5R2edkN3GzDRK
	 ZDOi98EumNiroQpOAbov+HICQj5e9VLLW3b4t6tg36KsTJ+lSSXEGir5RM8kOXwbMF
	 5AImCHpv91tRLAGFBCt+No+omqwOBSymBO4WhrGj1bZRkHqhyYr+PP3IFs00O0Uu/5
	 /P7FyXOG8T0aLIxhbE9XjXBMNVMnSqiqNohnGt3YOC2MAZx287WfS+zX1jrWvKal+5
	 gs8sz3V63Dpow==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 14/33] btrfs: pass walk_control structure to replay_one_extent()
Date: Mon,  8 Sep 2025 10:53:08 +0100
Message-ID: <be42d132ae154a3e2fb68568eac556b40ec1eb23.1757271913.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757271913.git.fdmanana@suse.com>
References: <cover.1757271913.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of passing the transaction and subvolume root as arguments to
replay_one_extent(), pass the walk_control structure as we can grab all
of those from the structure. This reduces the number of arguments passed
and it's going to be needed by an incoming change that improves error
reporting for log replay.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index ca0946f947df..aac648ae30fb 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -642,12 +642,13 @@ static int read_alloc_one_name(struct extent_buffer *eb, void *start, int len,
  * The extent is inserted into the file, dropping any existing extents
  * from the file that overlap the new one.
  */
-static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
-				      struct btrfs_root *root,
+static noinline int replay_one_extent(struct walk_control *wc,
 				      struct btrfs_path *path,
 				      struct extent_buffer *eb, int slot,
 				      struct btrfs_key *key)
 {
+	struct btrfs_trans_handle *trans = wc->trans;
+	struct btrfs_root *root = wc->root;
 	struct btrfs_drop_extents_args drop_args = { 0 };
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	int found_type;
@@ -2728,7 +2729,7 @@ static int replay_one_buffer(struct extent_buffer *eb,
 			if (ret)
 				break;
 		} else if (key.type == BTRFS_EXTENT_DATA_KEY) {
-			ret = replay_one_extent(trans, root, path, eb, i, &key);
+			ret = replay_one_extent(wc, path, eb, i, &key);
 			if (ret)
 				break;
 		}
-- 
2.47.2


