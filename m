Return-Path: <linux-btrfs+bounces-18954-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8E3C590EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 18:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02C345076A2
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 17:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B59B352934;
	Thu, 13 Nov 2025 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3eMtNdk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A786835F8BA
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053007; cv=none; b=K9oTGhrYLBDR3R10zJ86yHZcVuB/V1x3wiD3TGkZSFlQRHBeQG9Q22NHt1KnjGi1eAvw2fTNFa6Dn+Udrij2SfCI3WGBBevxq9OCPTl50EmI7l8FOzcu4Z23LgzrxypiD2d6uY1REcjWH2yQKWpJlua6oQtoJW1fRRweo3hPSSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053007; c=relaxed/simple;
	bh=zuzo8jxijw2XOFqxr4nGMJXBFn+jpRNUaWY4a5zw6n4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVFi0nJ1TQHzOJLPo341UaQj4B+9FsqEb4DFHSQDwDdSna8WaHwaPOxf2HGMajB5aaL0Ki+OGRPqbRbf6MUcv5NyMKsyP1hjyvAt/AvI23dtzsEsbRsWLYU+d7ODqx9sq4QJfSmp2unSjZrVqeH0AyECLNvFzNBJ8jUAD49ekug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3eMtNdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BACEC19424
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 16:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763053007;
	bh=zuzo8jxijw2XOFqxr4nGMJXBFn+jpRNUaWY4a5zw6n4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=k3eMtNdkQhskMX576Mv9stC6txA6nPNd0FEiKlZhjwPyBYEFyB/8Zpj9tuw5SWAgf
	 2857hQergkrnURRBvBu54ydY58BnYdFRS0K8EzwSoZcFNCng6JWR8V4wMrCsnx5u8M
	 ZV7vmwEvG3CZL/BMNc5SPQYVtsTgTNhLCIUeELdFUongFKp+KM07amr1YRcvSMrzW5
	 F8i0gKSNqFLGrk2yKffCm11KgCKqiCdAGwnReRow/mcZJlKMSarq01Uu8WCy9mgHOH
	 uTiTFcNJ+PIghz70KEgZpv8oVTrYrz978YpFkudBFHmGnR1Loafo0pZde9B7wqKPrV
	 2GFapt5b/AudA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/8] btrfs: always use left leaf variable in __push_leaf_right()
Date: Thu, 13 Nov 2025 16:56:35 +0000
Message-ID: <5e46cd4c1e62517bb788d9bdabb75aa91cf6960f.1763052647.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1763052647.git.fdmanana@suse.com>
References: <cover.1763052647.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The 'left' variable points to path->nodes[0] and path->nodes[0] is never
changed, but some places use 'left' while others refer to path->nodes[0].
Update all sites to use 'left' as not only it's shorter it's also easier
to reason since it means the left leaf and avoids any confusion with the
sibling right leaf.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index b5cf1b6f5adc..dada50d86731 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3214,10 +3214,10 @@ static noinline int __push_leaf_right(struct btrfs_trans_handle *trans,
 	/* then fixup the leaf pointer in the path */
 	if (path->slots[0] >= left_nritems) {
 		path->slots[0] -= left_nritems;
-		if (btrfs_header_nritems(path->nodes[0]) == 0)
-			btrfs_clear_buffer_dirty(trans, path->nodes[0]);
-		btrfs_tree_unlock(path->nodes[0]);
-		free_extent_buffer(path->nodes[0]);
+		if (btrfs_header_nritems(left) == 0)
+			btrfs_clear_buffer_dirty(trans, left);
+		btrfs_tree_unlock(left);
+		free_extent_buffer(left);
 		path->nodes[0] = right;
 		path->slots[1] += 1;
 	} else {
-- 
2.47.2


