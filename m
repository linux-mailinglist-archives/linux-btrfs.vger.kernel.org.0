Return-Path: <linux-btrfs+bounces-240-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403067F2E7B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 14:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9F82821A8
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 13:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A7751C52;
	Tue, 21 Nov 2023 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kknu15tX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D526251C47
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 13:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2C6C433C9
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 13:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700573925;
	bh=70Ghu2n6gxKOcEZYvOm6b3rSa/xdqsjBUeZLzMHvqvk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kknu15tXHQnPxD8NzEtmxGLTdTf+URLd69pHi4ilWWweIeScrjT9ozJYxm1aE3JNr
	 Ak9e1pPcs5VtTd7CPVu/Kh/1y/A1hkdvqBaGj3NCGCSfrId4ri63BT+APKUimkqalZ
	 7/CgSPDFHKo85FsYQqoX+ekTkY1NImMnIQXmrJ52pCVKPvn5seSeQpl4DFS0BJtZ4o
	 ijTVOtqfWbu0Mixe8NTmLBFi8nwucRpARKjygNqj+Qkxo7UZriqswoLinMiD/Ul6DF
	 9VuOWPiE12vD5SBtLAN0Xi2lNOoJ/gwCVkM5vtBfI0Rn7WD1XLe9JYIPe6MNPXehUv
	 bOEy3ghab37Ww==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/8] btrfs: make error messages more clear when getting a chunk map
Date: Tue, 21 Nov 2023 13:38:33 +0000
Message-Id: <ed4292387f7c43f70f29e1a375dce5235d3be26e.1700573313.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1700573313.git.fdmanana@suse.com>
References: <cover.1700573313.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When getting a chunk map, at btrfs_get_chunk_map(), we do some sanity
checks to verify we found a chunk map and that map found covers the
logical address the caller passed in. However the messages aren't very
clear in the sense that don't mention the issue is with a chunk map and
one of them prints the 'length' argument as if it were the end offset of
the requested range (while the in the string format we use %llu-%llu
which suggests a range, and the second %llu-%llu is actually a range for
the chunk map). So improve these two details in the error messages.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/volumes.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1775ae0998b0..3b61c47306c0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3003,15 +3003,16 @@ struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 	read_unlock(&em_tree->lock);
 
 	if (!em) {
-		btrfs_crit(fs_info, "unable to find logical %llu length %llu",
+		btrfs_crit(fs_info,
+			   "unable to find chunk map for logical %llu length %llu",
 			   logical, length);
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (em->start > logical || em->start + em->len <= logical) {
 		btrfs_crit(fs_info,
-			   "found a bad mapping, wanted %llu-%llu, found %llu-%llu",
-			   logical, length, em->start, em->start + em->len);
+			   "found a bad chunk map, wanted %llu-%llu, found %llu-%llu",
+			   logical, logical + length, em->start, em->start + em->len);
 		free_extent_map(em);
 		return ERR_PTR(-EINVAL);
 	}
-- 
2.40.1


