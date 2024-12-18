Return-Path: <linux-btrfs+bounces-10568-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAB19F6BF4
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6453B188486C
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF841FAC49;
	Wed, 18 Dec 2024 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsBrM1KX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10511FAC3B
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541624; cv=none; b=m1gEvBKV652351BJ0O1l6B+ezxInHmug0y6pJNm0B+DzYTnRe84Nfkc1kUCj5eEjC3g46F7CcomLeqObpvBO1Z7ktIl88nfyX834AWtpIelP+RxxILmhgH+0xvPIZ0vDYJ6hea5UHn4Ap8wgMR2X3xd8oXZ3qCvp8QxTvohoSgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541624; c=relaxed/simple;
	bh=1ldsaUaU0aBmFrIKv5tTaxtRnhhdUHQE9Pddq04DA0o=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sLaeiQ0CkqCL+Hc9D9aiGntOGf0JumLEYjzXyjVGGJ8yU9wquKqqmJncQssZAkxfpkWoVK3P5PPEpTG7dI6F0PKt0FuT3UwE8jW28WwIJgaxHLT0AI8aMtIMg3+PD6HaAp29TAIN8yCnSImjE0OXnDD6DtYsM0KtFWG3ayeN2wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsBrM1KX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D9DC4CED0
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734541623;
	bh=1ldsaUaU0aBmFrIKv5tTaxtRnhhdUHQE9Pddq04DA0o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PsBrM1KXSYJ61mDcMl1apBySD9WZe2EU+Wads3ogOPl5a2ipYOMLIOBPPtjOmVtwE
	 MxsWCv1zP10YY84+hTIcfSEuig8AoxVSdCI9h7NM+EwnQS0rboYwetbexZie8kZUP1
	 Pd5CX0KV2ItaFnQ2I+y7svgAYfmO0vKZxZy4YmQi6K/svKN7nzJke9p9QHzY8+74MU
	 nxZEKOVJuHqk7bbAh6H57UwBAYeBYQesCE2f6fVCuGVxTSB3yZxqR1Q6/XyZSarjZI
	 laUW0gSyb/HWtV2hEHGk0Q1xGhVMxXk4FUD+Wer+gawzo+B0s8ZD+09rmIY0SjTBXl
	 7Z8C7s/N7JcGA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 12/20] btrfs: inode-item: remove unnecessary calls to btrfs_mark_buffer_dirty()
Date: Wed, 18 Dec 2024 17:06:39 +0000
Message-Id: <805b065b840df48c8b2e95c06f2851178d865e2b.1734527445.git.fdmanana@suse.com>
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
 fs/btrfs/inode-item.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 29572dfaf878..448aa1a682d6 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -298,8 +298,6 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 
 	ptr = (unsigned long)&extref->name;
 	write_extent_buffer(path->nodes[0], name->name, ptr, name->len);
-	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
-
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -363,8 +361,6 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 		ptr = (unsigned long)(ref + 1);
 	}
 	write_extent_buffer(path->nodes[0], name->name, ptr, name->len);
-	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
-
 out:
 	btrfs_free_path(path);
 
@@ -590,7 +586,6 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 				num_dec = (orig_num_bytes - extent_num_bytes);
 				if (extent_start != 0)
 					control->sub_bytes += num_dec;
-				btrfs_mark_buffer_dirty(trans, leaf);
 			} else {
 				extent_num_bytes =
 					btrfs_file_extent_disk_num_bytes(leaf, fi);
-- 
2.45.2


