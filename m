Return-Path: <linux-btrfs+bounces-10572-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F969F6BEF
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47F507A222C
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AA01F8EF8;
	Wed, 18 Dec 2024 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAtENVPN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31681FBCB0
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541628; cv=none; b=SwmmlZLaQ3h4vfJAC1FzIPoEhTw1HKzYaqQwBLCqezYHfGEIrr57X3iGXNDoNgkINJTo/lExXdh0LFu+wa6ceZks3oqDLiLACpneuzOSml9JFYSnvKwKg2ye8jCbehpStRSzjXk20OeuUgfLMcqg/Q3u6me1RVqgR14RCLxJIPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541628; c=relaxed/simple;
	bh=+/Jfnfa9pF0R8Q8+6kfAj1m+yM6g+Iiyo2D4CYIJib8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g/evGOAOl6nCcTIr0MAI/PTVjnzZwKBHCF57j2w0InptIy60G50rAyxm0K2YVBLvQoo2zIxVd328iFR/cp9YbMQeSmEwImQpCJY1HGuylHUjqJCEBzeSTe5wz/A5JksWiaJjikYXEr1H1Nk1FK5x91b590RvshQqE+Awe3I471Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAtENVPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8AAC4CED0
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734541627;
	bh=+/Jfnfa9pF0R8Q8+6kfAj1m+yM6g+Iiyo2D4CYIJib8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tAtENVPNS+wJ41X2G2Ws1bqRHRUP+U/JFrYJh6w5ko1ezyBB5GDXqMNQBjl6SfAHz
	 cTvmTXpiGndutpOH309ykPmFoaw8zEnn4pt+1b+6V1HuB7vU2IZvqbxjk14U43nCrR
	 8+4TTjQZydg6nqHu4ZC+Iv/sO252lg4+D1ELFbNje06NF3e0ciCqZltiSY+BozTfIQ
	 cWBP3J1OtV9Vz690U7epd2lDevlg6yepcB6rivfXmk7caxT1gnVvLsB+Ri3NibVJMI
	 auZlen89/rezbavI/o9kU9DmK/ZGaS66n/4/dfRXmswgL6YI3hT43nRzqEADtz3OTq
	 QdNoc4o928Fpw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 16/20] btrfs: relocation: remove unnecessary calls to btrfs_mark_buffer_dirty()
Date: Wed, 18 Dec 2024 17:06:43 +0000
Message-Id: <e9e0b2e377aa364faefc7d4d0607ffe38881981e.1734527445.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734527445.git.fdmanana@suse.com>
References: <cover.1734527445.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have several places explicitly calling btrfs_mark_buffer_dirty() but
that is not necessarily since the target leaf came from a path that was
obtained for a btree search function that modifies the btree, something
like btrfs_insert_empty_item() or anything else that ends up calling
btrfs_search_slot() with a value of 1 for its 'cow' argument.

These just make the code more verbose, confusing and add a little extra
overhead and well as increase the module's text size, so remove them.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/relocation.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index cdd9a7b15a11..d4100e58172f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -856,7 +856,6 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 	u32 i;
 	int ret = 0;
 	int first = 1;
-	int dirty = 0;
 
 	if (rc->stage != UPDATE_DATA_PTRS)
 		return 0;
@@ -936,7 +935,6 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 		}
 
 		btrfs_set_file_extent_disk_bytenr(leaf, fi, new_bytenr);
-		dirty = 1;
 
 		key.offset -= btrfs_file_extent_offset(leaf, fi);
 		ref.action = BTRFS_ADD_DELAYED_REF;
@@ -967,8 +965,6 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 			break;
 		}
 	}
-	if (dirty)
-		btrfs_mark_buffer_dirty(trans, leaf);
 	if (inode)
 		btrfs_add_delayed_iput(inode);
 	return ret;
@@ -1161,13 +1157,11 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		 */
 		btrfs_set_node_blockptr(parent, slot, new_bytenr);
 		btrfs_set_node_ptr_generation(parent, slot, new_ptr_gen);
-		btrfs_mark_buffer_dirty(trans, parent);
 
 		btrfs_set_node_blockptr(path->nodes[level],
 					path->slots[level], old_bytenr);
 		btrfs_set_node_ptr_generation(path->nodes[level],
 					      path->slots[level], old_ptr_gen);
-		btrfs_mark_buffer_dirty(trans, path->nodes[level]);
 
 		ref.action = BTRFS_ADD_DELAYED_REF;
 		ref.bytenr = old_bytenr;
@@ -3728,7 +3722,6 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
 	btrfs_set_inode_mode(leaf, item, S_IFREG | 0600);
 	btrfs_set_inode_flags(leaf, item, BTRFS_INODE_NOCOMPRESS |
 					  BTRFS_INODE_PREALLOC);
-	btrfs_mark_buffer_dirty(trans, leaf);
 out:
 	btrfs_free_path(path);
 	return ret;
-- 
2.45.2


