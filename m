Return-Path: <linux-btrfs+bounces-10573-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00B69F6BF3
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FDC3171061
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56821FBE88;
	Wed, 18 Dec 2024 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgRl4au5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE431FA8E9
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541629; cv=none; b=l72UnozKd2z0/lQINvDodNC7QXLimV3sriighB+5hurZ3V6u0ouUQ91kHImwe5vKC7ciMYyAdpujSYesJYnzPpgOzU81g/bmpmGePesmqm+aVZa48g1BY4a0gwVsmmNA6q3At8UFxiY0CKMJYPz0aO2tBp8+luu1qSC1cUH2o5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541629; c=relaxed/simple;
	bh=6Qw7uSRx7Qm4u6q/gEbPWjb6LcI+qospRa/zpff441Q=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qYzpWnVSLpw6C0BY47QKtnitKkUJe9zsQ/yUrfLr7UKqU+1SOpMhsPgSWldhIhdB2G5fSNc/RvcIzrzqdzMGvjQlZceioNA8jNFsLNMkcuFWMrl5K9woUlpG7uwASiZKqQWDSHOPSMIUfgNtXPTJFeudB1F1KR2es/YB/VMdm/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgRl4au5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A66C4CECD
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734541628;
	bh=6Qw7uSRx7Qm4u6q/gEbPWjb6LcI+qospRa/zpff441Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CgRl4au5M9IuKcKynEbchv4IYWiCwR43L4wIK2Rzw689n1jwUlUM9LS/MaCPc2KSq
	 3yuOVCB8UFDl54Qf7MxivMeNf590LvS5U0OF/CHwYW3GX6n0bCosMtUBPeGij4PI+8
	 vtbG8D5sJtK0p/yEJ9I4EVp/+QSjpG4r8GNa8sBRULNjTAU+9fJdIPyA22P0EhSS23
	 fvHpBXzWBNAbj7tFuokgDnmAwJ0Xvw/aylTB95Plk35fpVfYls29Xnw90MypnsjnF2
	 D+cgT47ZnqFP15+J6R9dHQo1k5NcyTgceqoze3I4r7KPWPJ0vWnSBaZaMdvQb/vFtt
	 KXlOvOaL4GQow==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 17/20] btrfs: root-tree: remove unnecessary calls to btrfs_mark_buffer_dirty()
Date: Wed, 18 Dec 2024 17:06:44 +0000
Message-Id: <c57d814d24acb4a29df02fa7de10190d6ff1da35.1734527445.git.fdmanana@suse.com>
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
 fs/btrfs/root-tree.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 33962671a96c..e22e6b06927a 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -197,7 +197,6 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
 	btrfs_set_root_generation_v2(item, btrfs_root_generation(item));
 
 	write_extent_buffer(l, item, ptr, sizeof(*item));
-	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -447,7 +446,6 @@ int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 	btrfs_set_root_ref_name_len(leaf, ref, name->len);
 	ptr = (unsigned long)(ref + 1);
 	write_extent_buffer(leaf, name->name, ptr, name->len);
-	btrfs_mark_buffer_dirty(trans, leaf);
 
 	if (key.type == BTRFS_ROOT_BACKREF_KEY) {
 		btrfs_release_path(path);
-- 
2.45.2


