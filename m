Return-Path: <linux-btrfs+bounces-10570-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2859F6BF9
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C10189057C
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192191FBC96;
	Wed, 18 Dec 2024 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KI8YpkIn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441FE1FAC4D
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541626; cv=none; b=svZ+sVuqPpKJaWy7+c+j+SysKydclF62r/2lQf4icg4YIX5YFI5s8b3cSaf3b/CHZcii+J/3V2VPMN9DqRGnyBvbVmEZG1IobE+5FOnczchA6Dt1CrIaKBjNm4Di34Yk/YB0pPn0rWlk6mpJietJ3EiBK+1w3QhlcB1OcRF8S9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541626; c=relaxed/simple;
	bh=jRvaotzJxwRPIdyOkRuyOELpjHMauo8ht482e1Qx97I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S1/OQYiZoAaEi5uyhxwvHMZQrCSod513ERtDNgrWyHAIJbAqaB+ohW6gX8JGycJhJm5HrtV7IcuGS26KHWGj0KQIAr+3BlK9Pmw3D20WPzuBwjE8T6auxjhUFYIjPeoPYESZ/YwA6lDTSHRblflVAwY+gYJkXv6+zWSyZQVj1a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KI8YpkIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E48C4CED0
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734541625;
	bh=jRvaotzJxwRPIdyOkRuyOELpjHMauo8ht482e1Qx97I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KI8YpkInDoUIpj+l2D7NbHrEgPTTi4Its3+fUPAcCktg5aJUkHP7q2sa0AsEhtgB0
	 wg9LitRKusrjv3SYVtR9JC2Gs5rPXfOpScBhB48vpXbmZG6s/DPelQ9lbVGIXpJK+V
	 04JU8CQpjHBwv0uA8dYBtmUcWNJvXiqiwzFl037j+n4kArp1eu7AitqwJvo28mpUcK
	 WL7z9ncSbvqudyNFtf9iW82mBF/0FNTcfIOHaqLo5PaxCCkY7ChcUe6BCBUA7HFnQC
	 AH02hrik9Q1NTRaYT/DFvAOK+4YB4e7/ESLFMlESLIB/boIArxbD7s94CgNn2RARS5
	 3ziGlbVMSaGPw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 14/20] btrfs: qgroup: remove unnecessary calls to btrfs_mark_buffer_dirty()
Date: Wed, 18 Dec 2024 17:06:41 +0000
Message-Id: <f6417ec82197b7566c3375d7edf2c4a7f756c139.1734527445.git.fdmanana@suse.com>
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
 fs/btrfs/qgroup.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 993b5e803699..b90fabe302e6 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -673,9 +673,6 @@ static int add_qgroup_relation_item(struct btrfs_trans_handle *trans, u64 src,
 	key.offset = dst;
 
 	ret = btrfs_insert_empty_item(trans, quota_root, path, &key, 0);
-
-	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
-
 	btrfs_free_path(path);
 	return ret;
 }
@@ -752,8 +749,6 @@ static int add_qgroup_item(struct btrfs_trans_handle *trans,
 	btrfs_set_qgroup_info_excl(leaf, qgroup_info, 0);
 	btrfs_set_qgroup_info_excl_cmpr(leaf, qgroup_info, 0);
 
-	btrfs_mark_buffer_dirty(trans, leaf);
-
 	btrfs_release_path(path);
 
 	key.type = BTRFS_QGROUP_LIMIT_KEY;
@@ -771,8 +766,6 @@ static int add_qgroup_item(struct btrfs_trans_handle *trans,
 	btrfs_set_qgroup_limit_rsv_rfer(leaf, qgroup_limit, 0);
 	btrfs_set_qgroup_limit_rsv_excl(leaf, qgroup_limit, 0);
 
-	btrfs_mark_buffer_dirty(trans, leaf);
-
 	ret = 0;
 out:
 	btrfs_free_path(path);
@@ -859,9 +852,6 @@ static int update_qgroup_limit_item(struct btrfs_trans_handle *trans,
 	btrfs_set_qgroup_limit_max_excl(l, qgroup_limit, qgroup->max_excl);
 	btrfs_set_qgroup_limit_rsv_rfer(l, qgroup_limit, qgroup->rsv_rfer);
 	btrfs_set_qgroup_limit_rsv_excl(l, qgroup_limit, qgroup->rsv_excl);
-
-	btrfs_mark_buffer_dirty(trans, l);
-
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -905,9 +895,6 @@ static int update_qgroup_info_item(struct btrfs_trans_handle *trans,
 	btrfs_set_qgroup_info_rfer_cmpr(l, qgroup_info, qgroup->rfer_cmpr);
 	btrfs_set_qgroup_info_excl(l, qgroup_info, qgroup->excl);
 	btrfs_set_qgroup_info_excl_cmpr(l, qgroup_info, qgroup->excl_cmpr);
-
-	btrfs_mark_buffer_dirty(trans, l);
-
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -947,9 +934,6 @@ static int update_qgroup_status_item(struct btrfs_trans_handle *trans)
 	btrfs_set_qgroup_status_generation(l, ptr, trans->transid);
 	btrfs_set_qgroup_status_rescan(l, ptr,
 				fs_info->qgroup_rescan_progress.objectid);
-
-	btrfs_mark_buffer_dirty(trans, l);
-
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -1130,8 +1114,6 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 				      BTRFS_QGROUP_STATUS_FLAGS_MASK);
 	btrfs_set_qgroup_status_rescan(leaf, ptr, 0);
 
-	btrfs_mark_buffer_dirty(trans, leaf);
-
 	key.objectid = 0;
 	key.type = BTRFS_ROOT_REF_KEY;
 	key.offset = 0;
-- 
2.45.2


