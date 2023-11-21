Return-Path: <linux-btrfs+bounces-241-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9787F2E7D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 14:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06091281788
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 13:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC6C51C5E;
	Tue, 21 Nov 2023 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1It8V+M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0C051C55
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 13:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293CDC433C8
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 13:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700573926;
	bh=jRFgdklcY3i5Qwqq4KpgUszv34f7bSCIkf7WXoWZBU0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=F1It8V+MbhqHk/wP369Q3z3bkGsNVsvvfUmUTttMNg+POZG4XhEO3EF1T1Y/As1p6
	 M5KlEbCARsJWrtA8ekh7MAIyd3Jm08HX9fUK3qulXc3RaXUhPtywDGx8YAZLUoZeYG
	 yCIA4YEIknwymmfhYJ+fd7ed9igRDQBqwiCWejIw0aXqZ6oQAxU6vXWFLRkYtr4Qpi
	 B2XW2d5w0tJwh9oprb0NNYJltfRi+yjt7S6XoIROB2U+0eFvCkBKgiSpvDTuOf2Hek
	 JnZ4ebxGtl9ET+T9GI6WYMbe3d2lKZPKOWOCoy+23+SGLL24ejJubgrvaA+1knnofh
	 /pWvyh8sPHkGg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/8] btrfs: mark sanity checks when getting chunk map as unlikely
Date: Tue, 21 Nov 2023 13:38:34 +0000
Message-Id: <38d4c787bace59d3956c26089f21227db4d32bbd.1700573314.git.fdmanana@suse.com>
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
checks to verify that we found an extent map and that it includes the
requested logical address. These are never expected to fail, so mark
them as unlikely to make it more clear as well as to allow a compiler
to generate more efficient code.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/volumes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3b61c47306c0..9c4b52d29d6b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3002,14 +3002,14 @@ struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 	em = lookup_extent_mapping(em_tree, logical, length);
 	read_unlock(&em_tree->lock);
 
-	if (!em) {
+	if (unlikely(!em)) {
 		btrfs_crit(fs_info,
 			   "unable to find chunk map for logical %llu length %llu",
 			   logical, length);
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (em->start > logical || em->start + em->len <= logical) {
+	if (unlikely(em->start > logical || em->start + em->len <= logical)) {
 		btrfs_crit(fs_info,
 			   "found a bad chunk map, wanted %llu-%llu, found %llu-%llu",
 			   logical, logical + length, em->start, em->start + em->len);
-- 
2.40.1


