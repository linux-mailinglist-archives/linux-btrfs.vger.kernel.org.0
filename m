Return-Path: <linux-btrfs+bounces-10559-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E47029F6BE9
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546B11894228
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4A31F9ED2;
	Wed, 18 Dec 2024 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9ybb2M+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126B51F9431
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541615; cv=none; b=J2oTDm49HY6Q6A3wil4uxQAKr95TMwWpfvDxyTv+Gt4xbEnHM/On4lvMNAeA+6VJJBQpRxrJX8PzC2stUWbCD5Pqt9FVcoAOiNRtYyiR6BDHjRysS0+d0phbXgAd0K8xFIkZzOBPKUyUcObcWjDZyjfXWkPrHKlyLfNy8Zd+FOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541615; c=relaxed/simple;
	bh=Rukjv3M03rmzKqL8fNWdJ3XVf4IjTqjdDemasCPtgjs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M5sRUemYp289Y9sQd7ZyHn6RnKzRWAOJBGawZxbZZldfg6yDSDbFYAhYP23v/cHfXRgHjUNTznQiSODAfQ1Cqq0VZYFm88S9KzfVSx5IaG5hFcU4NYh5emhtGzhznDCt0RMxOVXnR3IPbrgWVqsD+M/ElKigakXRZnyKTsiHfxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9ybb2M+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA7BC4CEDD
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734541614;
	bh=Rukjv3M03rmzKqL8fNWdJ3XVf4IjTqjdDemasCPtgjs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=l9ybb2M+pIFQ2/BGg+r/Ixw7XwYfLACbrIHOSSSxsC+b/Zjc3+CIMiNbCVIdUz8qZ
	 wI8McWLWQS2Q76MA9Q4jMeU+RuoePxctTb5WDXoaSb2I8JDbSTuqqkEMvXap5w5SjG
	 lWc0jEBnTsUHLaVY5TGeMFIZW4W/x8Y2WuDuz6Cq/oLk0Ln9Aeh2BWyeim0VEElXWc
	 4IHqQ7sO068tJuGm95//eKj/zONGS0IUWB29n2FrebynyiLZixq32OT0iHqVk1n1x5
	 RmtzniAREibIvLsNalIJJ5wKdFHH2Zv5qFwojgaqW6BKGJmLTuRlOHxv02PQ2feaCL
	 RZv15mZkWdy1w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 03/20] btrfs: extent-tree: remove unnecessary calls to btrfs_mark_buffer_dirty()
Date: Wed, 18 Dec 2024 17:06:30 +0000
Message-Id: <e83b5e64ce77dcb1082be206abf164047ec1a9bc.1734527445.git.fdmanana@suse.com>
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
 fs/btrfs/extent-tree.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e849fc34d8d9..14889b62ef59 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -570,7 +570,6 @@ static noinline int insert_extent_data_ref(struct btrfs_trans_handle *trans,
 			btrfs_set_extent_data_ref_count(leaf, ref, num_refs);
 		}
 	}
-	btrfs_mark_buffer_dirty(trans, leaf);
 	ret = 0;
 fail:
 	btrfs_release_path(path);
@@ -618,7 +617,6 @@ static noinline int remove_extent_data_ref(struct btrfs_trans_handle *trans,
 			btrfs_set_extent_data_ref_count(leaf, ref1, num_refs);
 		else if (key.type == BTRFS_SHARED_DATA_REF_KEY)
 			btrfs_set_shared_data_ref_count(leaf, ref2, num_refs);
-		btrfs_mark_buffer_dirty(trans, leaf);
 	}
 	return ret;
 }
@@ -1050,7 +1048,6 @@ void setup_inline_extent_backref(struct btrfs_trans_handle *trans,
 	} else {
 		btrfs_set_extent_inline_ref_offset(leaf, iref, root_objectid);
 	}
-	btrfs_mark_buffer_dirty(trans, leaf);
 }
 
 static int lookup_extent_backref(struct btrfs_trans_handle *trans,
@@ -1195,7 +1192,6 @@ static noinline_for_stack int update_inline_extent_backref(
 		item_size -= size;
 		btrfs_truncate_item(trans, path, item_size, 1);
 	}
-	btrfs_mark_buffer_dirty(trans, leaf);
 	return 0;
 }
 
@@ -1527,7 +1523,6 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 	if (extent_op)
 		__run_delayed_extent_op(extent_op, leaf, item);
 
-	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
 
 	/* now insert the actual backref */
@@ -1711,8 +1706,6 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
 	__run_delayed_extent_op(extent_op, leaf, ei);
-
-	btrfs_mark_buffer_dirty(trans, leaf);
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -3268,7 +3261,6 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 			}
 		} else {
 			btrfs_set_extent_refs(leaf, ei, refs);
-			btrfs_mark_buffer_dirty(trans, leaf);
 		}
 		if (found_extent) {
 			ret = remove_extent_backref(trans, extent_root, path,
@@ -4836,7 +4828,6 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 		btrfs_set_extent_data_ref_count(leaf, ref, ref_mod);
 	}
 
-	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
 	btrfs_free_path(path);
 
 	return alloc_reserved_extent(trans, ins->objectid, ins->offset);
@@ -4911,7 +4902,6 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 		btrfs_set_extent_inline_ref_offset(leaf, iref, node->ref_root);
 	}
 
-	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_free_path(path);
 
 	return alloc_reserved_extent(trans, node->bytenr, fs_info->nodesize);
-- 
2.45.2


