Return-Path: <linux-btrfs+bounces-333-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A22BE7F6999
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 00:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33FD4B20EFE
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Nov 2023 23:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A014B5BF;
	Thu, 23 Nov 2023 23:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8SWw7l0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F65D4AF60
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Nov 2023 23:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1E6C433C7
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Nov 2023 23:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700783635;
	bh=s5EctTiJlckUJIYinvedj37AQ4PBzkjy54rIgM73yP4=;
	h=From:To:Subject:Date:From;
	b=e8SWw7l0cnkZ+wUtLWgY0CuiNeqBTJERKuyCAgY1UtLrhogl0fprcA8QDHeJ3xEKV
	 syXHfniHPGfyOgYP83reVG5niCmFdhv68Sr4BirVAhB5iELkp86kDPOQUfsHpZawDX
	 St3dih+NywG2+88VqDEN0O3fKrc1aj44klnJMYtJ1Aa1CtYGJbd4VHSc/53J/Rm0ip
	 VEUOKH2OxocZfeC4lrTlh3wby1LP5euQc3j97mlPZ/BnIP4jevsVD0RCFTYCKqMWVs
	 WDQ+2/CDlSYxdiKdmrYEg5MkCTdjhEy3PzRYnF/JuZb0GiN0UOKifmsTGIAZuJdOAp
	 tD1rgPmRYPDxg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove no longer used EXTENT_MAP_DELALLOC block start value
Date: Thu, 23 Nov 2023 23:53:51 +0000
Message-Id: <29f711318957b5efb2005d5cf9a50fd7755cc4a9.1700783554.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

After commit ac3c0d36a2a2 ("btrfs: make fiemap more efficient and accurate
reporting extent sharedness") we no longer need to create special extent
maps during fiemap that have a block start with the EXTENT_MAP_DELALLOC
value. So this block start value for extent maps is no longer used since
then, therefore remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/defrag.c            | 3 +--
 fs/btrfs/extent_map.c        | 3 ---
 fs/btrfs/extent_map.h        | 2 --
 include/trace/events/btrfs.h | 3 +--
 4 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 5244561e2016..9bcb60c68c58 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -996,9 +996,8 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		    em->len <= inode->root->fs_info->max_inline)
 			goto next;
 
-		/* Skip hole/delalloc/preallocated extents */
+		/* Skip holes and preallocated extents. */
 		if (em->block_start == EXTENT_MAP_HOLE ||
-		    em->block_start == EXTENT_MAP_DELALLOC ||
 		    test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
 			goto next;
 
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index c956b1ced69f..80f86503a5cd 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -212,9 +212,6 @@ static int mergable_maps(struct extent_map *prev, struct extent_map *next)
 	if (!list_empty(&prev->list) || !list_empty(&next->list))
 		return 0;
 
-	ASSERT(next->block_start != EXTENT_MAP_DELALLOC &&
-	       prev->block_start != EXTENT_MAP_DELALLOC);
-
 	if (extent_map_end(prev) == next->start &&
 	    prev->flags == next->flags &&
 	    ((next->block_start == EXTENT_MAP_HOLE &&
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index bae14af197ef..66f8dd26487b 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -9,8 +9,6 @@
 #define EXTENT_MAP_LAST_BYTE ((u64)-4)
 #define EXTENT_MAP_HOLE ((u64)-3)
 #define EXTENT_MAP_INLINE ((u64)-2)
-/* used only during fiemap calls */
-#define EXTENT_MAP_DELALLOC ((u64)-1)
 
 /* bits for the extent_map::flags field */
 enum {
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 856109048999..31da1456f953 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -265,8 +265,7 @@ DEFINE_EVENT(btrfs__inode, btrfs_inode_evict,
 	__print_symbolic_u64(type,					\
 		{ EXTENT_MAP_LAST_BYTE, "LAST_BYTE" 	},		\
 		{ EXTENT_MAP_HOLE, 	"HOLE" 		},		\
-		{ EXTENT_MAP_INLINE, 	"INLINE" 	},		\
-		{ EXTENT_MAP_DELALLOC,	"DELALLOC" 	})
+		{ EXTENT_MAP_INLINE,	"INLINE"	})
 
 #define show_map_type(type)			\
 	type, (type >= EXTENT_MAP_LAST_BYTE) ? "-" :  __show_map_type(type)
-- 
2.40.1


