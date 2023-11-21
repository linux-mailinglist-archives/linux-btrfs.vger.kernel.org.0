Return-Path: <linux-btrfs+bounces-243-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E87FF7F2E7F
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 14:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52833281774
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 13:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165AF524AF;
	Tue, 21 Nov 2023 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvqcsmFt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF1A524A8
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 13:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2455FC433C8
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 13:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700573928;
	bh=9PfWqeEuGXifiQKexmyHEqmuQblrKNM2qMIxMDwPmhU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TvqcsmFtB3JpBe5EDpefcyDDRk49wH2Guka7/ZzUrBYXwOmvaUzbnuTrWWSBy+AeH
	 x2tQU8YmQeDNXZ0fUOdyWp+De03jf7HllU7lJFAoADFulBOQViP6TlT7uJX7SagXE0
	 99OxI4TkAf9ZSEamKXsg26XkOtkLOG2iurF2YhnZvDuq2e0JUhNTnkW8C1plU7TOut
	 aMNV0cc2TcM90mSH1DgwtzR8COltz31/ZpJzhh1hT17xEPSULgLeLuewxDZ1VKrINL
	 pygCKlFOvjbs4vhSgF9j0m9TUr98nOf7HqacX/QEKm1dzMY6g2Wiy/pXiDTWs9aViS
	 jlTOBWUdHrgJA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs: unexport extent_map_block_end()
Date: Tue, 21 Nov 2023 13:38:36 +0000
Message-Id: <49e32c7eee42070db66f7ed7a331686736646b0c.1700573314.git.fdmanana@suse.com>
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

The helper extent_map_block_end() is currently not used anywhere outside
extent_map.c, so move into from extent_map.h into extent_map.c. While at
it, also make the extent map pointer argument as const.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 7 +++++++
 fs/btrfs/extent_map.h | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index a6d8368ed0ed..bced39dc0da8 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -182,6 +182,13 @@ static struct rb_node *__tree_search(struct rb_root *root, u64 offset,
 	return NULL;
 }
 
+static inline u64 extent_map_block_end(const struct extent_map *em)
+{
+	if (em->block_start + em->block_len < em->block_start)
+		return (u64)-1;
+	return em->block_start + em->block_len;
+}
+
 /* Check to see if two extent_map structs are adjacent and safe to merge. */
 static int mergable_maps(struct extent_map *prev, struct extent_map *next)
 {
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 35d27c756e08..d0328127f89c 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -77,13 +77,6 @@ static inline u64 extent_map_end(struct extent_map *em)
 	return em->start + em->len;
 }
 
-static inline u64 extent_map_block_end(struct extent_map *em)
-{
-	if (em->block_start + em->block_len < em->block_start)
-		return (u64)-1;
-	return em->block_start + em->block_len;
-}
-
 void extent_map_tree_init(struct extent_map_tree *tree);
 struct extent_map *lookup_extent_mapping(struct extent_map_tree *tree,
 					 u64 start, u64 len);
-- 
2.40.1


