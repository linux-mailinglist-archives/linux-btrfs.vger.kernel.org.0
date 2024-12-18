Return-Path: <linux-btrfs+bounces-10564-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2509F6BEA
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E99967A505D
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001901F8926;
	Wed, 18 Dec 2024 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vo5AOnpJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2657E1FA831
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541620; cv=none; b=hTXuuGv/nQIhsLg9/Y8DmSPHJ9ZYSwAahrpldGxAidieIOrmxN2yRgxMJpUcDfyxl7ayMes1yBPEtMgPZmVc3vvO6TsSIgUa//nmGaoM3+hxUoj6eI96R5ULTIa8uMJ+Ru+mXqhZTmYoxKNyIaENTCM5dicUFznYS+WGgQUGZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541620; c=relaxed/simple;
	bh=hO3/lCVsOMYZaWkyEkvySjGZGa44wyQLwuC6FyXho7s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZXwE/6RS/6o7z6rD6BxlDwxoEuEaft+eq1On93vU1dV0PwZing+WC9SlZ7vectcqOuW+7VEbaNljZRIIs2ahaRp2PeKUApXpF3whlm/Z3+HmnKugkGvaRokdPe0XuKnDN7Dylo2h2aGCmjvnfpMO2c9dGx+y7eENsNil8xcLqXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vo5AOnpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB6CC4CED7
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734541619;
	bh=hO3/lCVsOMYZaWkyEkvySjGZGa44wyQLwuC6FyXho7s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Vo5AOnpJIM4Q3JZ23mPEUpYC5VIvCooIkFHJFLUesu4MUoDBj8FAZOYZi/zHoxdye
	 FruEseXiKUTRtpnLdMOzkg2lm174evcEM1L95jDzafkRPFpDGUf0XvdtAAX+59sysE
	 OZJvdNh2phcf2gtIIPqSQ8VetenX6a00rOg4flLvrvgJIm9lLnaPOtF76I3LTOHXKB
	 NM8RMFRZOJvWLV5Eqe88rHty31Ptov3OpciQdFTAiWyc78ic1EPGN/AYzpY8hr3ilS
	 NsuknamMODSAFB9dYq103lgOdvYNXkkpr0M6dgJImclbeSlJlKGny6VGPunKG65+wB
	 IpQFoYXbLgJ7Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 08/20] btrfs: file: remove unnecessary calls to btrfs_mark_buffer_dirty()
Date: Wed, 18 Dec 2024 17:06:35 +0000
Message-Id: <a2515e0572bf113d6e6edd95b35d8543caafbc07.1734527445.git.fdmanana@suse.com>
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
 fs/btrfs/file.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 4775a17c4ee1..36f51c311bb1 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -314,7 +314,6 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 			btrfs_set_file_extent_offset(leaf, fi, extent_offset);
 			btrfs_set_file_extent_num_bytes(leaf, fi,
 							extent_end - args->start);
-			btrfs_mark_buffer_dirty(trans, leaf);
 
 			if (update_refs && disk_bytenr > 0) {
 				struct btrfs_ref ref = {
@@ -360,7 +359,6 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 			btrfs_set_file_extent_offset(leaf, fi, extent_offset);
 			btrfs_set_file_extent_num_bytes(leaf, fi,
 							extent_end - args->end);
-			btrfs_mark_buffer_dirty(trans, leaf);
 			if (update_refs && disk_bytenr > 0)
 				args->bytes_found += args->end - key.offset;
 			break;
@@ -384,7 +382,6 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 
 			btrfs_set_file_extent_num_bytes(leaf, fi,
 							args->start - key.offset);
-			btrfs_mark_buffer_dirty(trans, leaf);
 			if (update_refs && disk_bytenr > 0)
 				args->bytes_found += extent_end - args->start;
 			if (args->end == extent_end)
@@ -639,7 +636,6 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 							 trans->transid);
 			btrfs_set_file_extent_num_bytes(leaf, fi,
 							end - other_start);
-			btrfs_mark_buffer_dirty(trans, leaf);
 			goto out;
 		}
 	}
@@ -668,7 +664,6 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 							other_end - start);
 			btrfs_set_file_extent_offset(leaf, fi,
 						     start - orig_offset);
-			btrfs_mark_buffer_dirty(trans, leaf);
 			goto out;
 		}
 	}
@@ -702,7 +697,6 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 		btrfs_set_file_extent_offset(leaf, fi, split - orig_offset);
 		btrfs_set_file_extent_num_bytes(leaf, fi,
 						extent_end - split);
-		btrfs_mark_buffer_dirty(trans, leaf);
 
 		ref.action = BTRFS_ADD_DELAYED_REF;
 		ref.bytenr = bytenr;
@@ -781,7 +775,6 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 		btrfs_set_file_extent_type(leaf, fi,
 					   BTRFS_FILE_EXTENT_REG);
 		btrfs_set_file_extent_generation(leaf, fi, trans->transid);
-		btrfs_mark_buffer_dirty(trans, leaf);
 	} else {
 		fi = btrfs_item_ptr(leaf, del_slot - 1,
 			   struct btrfs_file_extent_item);
@@ -790,7 +783,6 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 		btrfs_set_file_extent_generation(leaf, fi, trans->transid);
 		btrfs_set_file_extent_num_bytes(leaf, fi,
 						extent_end - key.offset);
-		btrfs_mark_buffer_dirty(trans, leaf);
 
 		ret = btrfs_del_items(trans, root, path, del_slot, del_nr);
 		if (ret < 0) {
@@ -2016,7 +2008,6 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 		btrfs_set_file_extent_ram_bytes(leaf, fi, num_bytes);
 		btrfs_set_file_extent_offset(leaf, fi, 0);
 		btrfs_set_file_extent_generation(leaf, fi, trans->transid);
-		btrfs_mark_buffer_dirty(trans, leaf);
 		goto out;
 	}
 
@@ -2033,7 +2024,6 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 		btrfs_set_file_extent_ram_bytes(leaf, fi, num_bytes);
 		btrfs_set_file_extent_offset(leaf, fi, 0);
 		btrfs_set_file_extent_generation(leaf, fi, trans->transid);
-		btrfs_mark_buffer_dirty(trans, leaf);
 		goto out;
 	}
 	btrfs_release_path(path);
@@ -2181,7 +2171,6 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_file_extent_num_bytes(leaf, extent, replace_len);
 	if (extent_info->is_new_extent)
 		btrfs_set_file_extent_generation(leaf, extent, trans->transid);
-	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
 
 	ret = btrfs_inode_set_file_extent_range(inode, extent_info->file_offset,
-- 
2.45.2


