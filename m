Return-Path: <linux-btrfs+bounces-14731-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CE3ADD60F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 18:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D012C5A3C
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 16:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D422F3626;
	Tue, 17 Jun 2025 16:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXa9cxvS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F432F3625
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176794; cv=none; b=KfBIvm1J/PcS7eUVCCetd2FoSrACgBSiueZFwb6m+EtCJfc0YkSSZQRMaWfuos6K6jlsBlajeccfHhQjSYidNQNLoooI/jx0MvpncugGMFPQ0ux11bVQ+VRzJaxxr9zmnydlsdyAy1r4uZPH4qeue6lnqT6ChW7nnRl0RyX9TVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176794; c=relaxed/simple;
	bh=qxl3Lt4v0CHsyCWuY3LdmCvuhtI/0kh065tlUY7KsMk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEyzG6+7AXIOBP6I+RD/jAF516QKiKqHg48Rtb93icIK6Yv4TDLClTgfoasBGj5T9fGP9ZttoLAxWz6XDeY4r84R8l2hv8sJcc2e2RlPjOar9a5rV5RLeV6o5RNIG9vAFpBda5arXSEyiKACzZjo5cdDWSFuren27RGhNFD+h8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXa9cxvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2889AC4CEE3
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750176793;
	bh=qxl3Lt4v0CHsyCWuY3LdmCvuhtI/0kh065tlUY7KsMk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SXa9cxvSghJKbMvfEzb8B/ORJXxrxKIeaXwDLzx4niYe9EUTaOvVi3k1MdzqSlxtV
	 yhtfncqt70zX5WWqfzIS91LyYoKx5ARlJAkkitv5l3jSp8N3LNZvcpRt36lVmEV2u6
	 w+If2F6xX53QcfQmwg8DvcP947SZAsFqMFUqb2N5HDONjsVY4L2hTYrbYPfZpAf83Y
	 Mj2HhvZysNIA6zq3GC5S1ZhSOmP1AeIerefvonpaRby9Y74in3bvt6aBOLTCp0ffEb
	 ASgw740nrEB37c9jC/5ct/QzkqrC3St+WXhNysQj4jNpr4LPseUrqPTd+Il71gjMrt
	 HyPdHiBgHdEjw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 02/16] btrfs: remove pointless out label from update_free_space_extent_count()
Date: Tue, 17 Jun 2025 17:12:57 +0100
Message-ID: <44c3fb3b1c25b4aeab82595f6d64460e2aa76b2d.1750075579.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1750075579.git.fdmanana@suse.com>
References: <cover.1750075579.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Just return directly, we don't need the label since all we do under it is
to return.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-tree.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 6418b3b5d16a..29fada10158c 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -491,10 +491,9 @@ static int update_free_space_extent_count(struct btrfs_trans_handle *trans,
 		return 0;
 
 	info = search_free_space_info(trans, block_group, path, 1);
-	if (IS_ERR(info)) {
-		ret = PTR_ERR(info);
-		goto out;
-	}
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
 	flags = btrfs_free_space_flags(path->nodes[0], info);
 	extent_count = btrfs_free_space_extent_count(path->nodes[0], info);
 
@@ -510,7 +509,6 @@ static int update_free_space_extent_count(struct btrfs_trans_handle *trans,
 		ret = convert_free_space_to_extents(trans, block_group, path);
 	}
 
-out:
 	return ret;
 }
 
-- 
2.47.2


