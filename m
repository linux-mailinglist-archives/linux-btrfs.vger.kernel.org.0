Return-Path: <linux-btrfs+bounces-4331-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9559A8A819B
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 13:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F333CB21A60
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 11:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CDC13C81F;
	Wed, 17 Apr 2024 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAibfdNW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C2F13D8AE
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351832; cv=none; b=WD3xnd96WX5LXV2i4j9HiN0waC2f72pGkB0jUi5TEORfd8zbXjr8uv3bUr9hTrkElYHkgnEYYcoapuPQmc+ACSNoAYX6Is2TTvhTEOP8+g9wjHAYrMbgrESu96DMga4cRdXwbJXRgHhPTIVRQUD9r0yYTLq0d6vT61ZGrUsjsmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351832; c=relaxed/simple;
	bh=1fhIyN2mqG+pYHEEhMcJF7Xs9wjC3Uiwlev1Usgn9tM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OaX3DlynPkEa8KEc2CC3TsrvqknA7wv+ZZBnKIfGzwxW10zcqq4bI9/3xTfILWs/S2wPSeN2bGIi1WH4tGfEUqfRA78C0YVk5yvHiWJVPstTaWayYE/9lNCQwBlQ5BFPN8+lXxKeuk7l6sju/z1JQsJBIsyhKhWdOY5Ej+BVC/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAibfdNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0791BC4AF07
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 11:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713351831;
	bh=1fhIyN2mqG+pYHEEhMcJF7Xs9wjC3Uiwlev1Usgn9tM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=vAibfdNWY7SI+b2EQCKaO7tCkeSmpbiEQ3o44adZmKNL9MvE2DWcwOYjPAhlD+fV7
	 XB91ICwkgbRqZ2htgPGtqHonYaJDVQ8UQ8NQtKmwNG4xBJU39uf0EzCCwIgQjvSESP
	 ySrs8z6E8HttZC/DG/xZOq3s4VZu8EdI7Z5d1DRoA8pz77kHxMBh3ugMIpx/cQhSDz
	 r7FbAmQrm0AJg3Y7z8TZC6T+R4L/8wHh2+cFNt/ds2CepFXxN2avEEVPqdTA3BNSse
	 sCONYnlWBeOjm5hC4jGR6EasvglN/gj+oT//eI4px84CC7wyLSXJgqOPVP6SegeHjT
	 tjbYbFhd+mdtw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs: remove i_size restriction at try_release_extent_mapping()
Date: Wed, 17 Apr 2024 12:03:33 +0100
Message-Id: <c9c03b39687c2cc599725c508b354e40898d9844.1713302470.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713302470.git.fdmanana@suse.com>
References: <cover.1713302470.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently we don't attempt to release extent maps if the inode has an
i_size that is not greater than 16M. This condition was added way back
in 2008 by commit 70dec8079d78 ("Btrfs: extent_io and extent_state
optimizations"), without any explanation about it. A quick chat with
Chris on slack revealed that the goal was probably to release the extent
maps for small files only when closing the inode. This however can be
harmful in case we have tons of such files being kept open for very long
periods of time, since we will consume more and more pages for extent
maps.

So remove the condition.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f689c53553e3..ff9132b897e3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2402,8 +2402,7 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 	struct extent_io_tree *io_tree = &inode->io_tree;
 	struct extent_map_tree *extent_tree = &inode->extent_tree;
 
-	if (gfpflags_allow_blocking(mask) &&
-	    page->mapping->host->i_size > SZ_16M) {
+	if (gfpflags_allow_blocking(mask)) {
 		u64 len;
 		while (start <= end) {
 			const u64 cur_gen = btrfs_get_fs_generation(inode->root->fs_info);
-- 
2.43.0


