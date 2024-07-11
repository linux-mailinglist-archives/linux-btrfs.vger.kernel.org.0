Return-Path: <linux-btrfs+bounces-6400-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB9992F104
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 23:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956221F2279E
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 21:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5185A19FA6B;
	Thu, 11 Jul 2024 21:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="OG8lgtN5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tpqsKY43"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363E616D9C1
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2024 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732779; cv=none; b=bh33Nz/jBjV3R417fnzpbei8LTXvrSHuxGmYfWSUE0zpksm8LFPaCORgWvCBalwPIV8XnJveWgHYcJyOH13Li5+iY4jrX6Sbe32scyZNWrKn1ouyNT4RiinZJc9voXiq3i5Ny5Zl0hB+VYjnFnyv1ZK7lcmHqwKjrwlGIEzW8qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732779; c=relaxed/simple;
	bh=qA8PoOtHvpDcrUbZyazAJbAXrSVCt6xE8iSBF+bJ3GE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fiwzu5uxpEy+JPldXnLaWL0x4wDI9U/kaUTZk8nH2Bx650jvAYoCJLNeD2nGqxbsntyxIVBzMPylOv39wKOr9Dg+2m2CiT6PjFhfTGXIxi7QPU6X2ElIcND3auwr9a9s5CdW7ZZbj4zbnaCbWW6GvXfPKipkLo+zQODjthA8O3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=OG8lgtN5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tpqsKY43; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5026E1388300;
	Thu, 11 Jul 2024 17:19:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 11 Jul 2024 17:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1720732776; x=
	1720819176; bh=SEj+tTUMpjirO0+L2vTts8CmXi85Vbrh+0HawX1WQSw=; b=O
	G8lgtN5fBgzkydrI9/iE7X8giMMlLyMp2senynmAvaraH5Mnr3Cf5MoKGQhgzTZp
	9kJOlkVftpGvAZHCdiB6Rs4rcZIGhZasuDsIVvjbA0C7R8Id+h9I7j5HGs6UwGQg
	/GcGVL4S7NoVCtdDvDPP8sXXcnNKS0XP7vMbiyj8CrfqfM9Tqf3XMOscXu7OXldr
	XssfbheCGF3ZoeF7Kkw8h6OxnLHUI25xz4Tmclhi+vUhcyyKYHIZMlJHxSLLq1Cy
	zYXLAjB8oozMUB+Y7ZfIkIvN/3Ff63W9G9uzyObCI9KsUsfYr0yGlctVQxQhP7wp
	goynGpTGHC+vU/aHoXdQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1720732776; x=1720819176; bh=SEj+tTUMpjirO
	0+L2vTts8CmXi85Vbrh+0HawX1WQSw=; b=tpqsKY43HH9ARcZMSxGGEnjkxmVF7
	7RFTcXihRVrMWQ31kI1i4N1HURA1VeFvqGvIIJO5U85AQpJ1WoQJ+bQyCo/WLVNR
	HXMebAZyfIjq4z2Jh0Dd3MsrXVm4mvnYG3UlF82Mgz9cfpJ8w/vUqB1bMmZyZqib
	DNEA9uUOKX+tV3LpBDuBp8DaKJUDXKT+yBOqxG4XYGbmpBAAi3xLovlBfKoBywzq
	u5EpPbsI8ooy0Cc68kaq/NYvNV1bkJOHYOgcb0pGXgO8AmDSBsPx5wsnj+9KrlHs
	nhe9rRqsoOl7piejFHkI9me4n4d1AcvqYC4IbGSXtDkAE+pTRDmaw33XQ==
X-ME-Sender: <xms:Z0yQZvAZUz_tbZIv3vsMXJ_jkAgD525wLhsBsGutQnD4UWQDTeF2Sg>
    <xme:Z0yQZljH5fDAv0gGybIKWvKLiCcPDmURR5ZzmDfDSWJs1D9KjmK622TevHtF_D3Ar
    r6ur7MIXdsDw2PG6Vs>
X-ME-Received: <xmr:Z0yQZqlIbw9N5l8-E_sqTuFfI8QEUT8oHS9P_wMgeXPfhTHsmpEegPgCOZOQ5PNi_wqCTMz6ZiuH8lue8unBgCv_-lQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeggdduieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:Z0yQZhwyWVx03CJKzV4m3Eeu5sx4FhVoeJQ1DII7CE03D8QzcQU0uA>
    <xmx:Z0yQZkRCEyvTzaSiUpcc6IQZbmeQpfpUCfi7gBWOpLlh7mdhuW32eQ>
    <xmx:Z0yQZkbrUjTefHzdw5x1WnptrRzraSudbG6IirZaq5LezpdIm6OoFA>
    <xmx:Z0yQZlSi1NGe0Yj0V1fv0mRG2b3_12evM4gGbldqi6KGlnefM4JotQ>
    <xmx:aEyQZvfTQhCO4F5IsMP57oHoMoOnhfhWa-yKTnjguCxtlvbeaI9TTDWZ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 17:19:35 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/3] btrfs-progs: add a helper for clearing all the items in a tree
Date: Thu, 11 Jul 2024 14:18:22 -0700
Message-ID: <628cc8e20d7cf460ffdf50f3916860556d6ce3e1.1720732480.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720732480.git.boris@bur.io>
References: <cover.1720732480.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Used in clear_free_space_tree, this is a totally generic operation.
It will also be used for clearing the qgroup tree from btrfstune.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 kernel-shared/disk-io.c         | 39 ++++++++++++++++++++++++++++++
 kernel-shared/disk-io.h         |  2 ++
 kernel-shared/free-space-tree.c | 42 ++-------------------------------
 3 files changed, 43 insertions(+), 40 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 295bd50ad..1e4c46aa0 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2342,6 +2342,45 @@ static bool is_global_root(struct btrfs_root *root)
 		return true;
 	return false;
 }
+
+int btrfs_clear_tree(struct btrfs_trans_handle *trans,
+		     struct btrfs_root *root)
+{
+	struct btrfs_path *path;
+	struct btrfs_key key;
+	struct extent_buffer *leaf = NULL;
+	int ret;
+	int nr = 0;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	key.objectid = 0;
+	key.offset = 0;
+	key.type = 0;
+
+	while (1) {
+		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
+		if (ret < 0)
+			goto out;
+		leaf = path->nodes[0];
+		nr = btrfs_header_nritems(leaf);
+		if (!nr)
+			break;
+		path->slots[0] = 0;
+		ret = btrfs_del_items(trans, root, path, 0, nr);
+		if (ret)
+			goto out;
+
+		btrfs_release_path(path);
+	}
+	ret = 0;
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
 int btrfs_delete_and_free_root(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root)
 {
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index 9f848635f..702a5e274 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -241,6 +241,8 @@ int btrfs_fs_roots_compare_roots(const struct rb_node *node1, const struct rb_no
 struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 				     struct btrfs_fs_info *fs_info,
 				     struct btrfs_key *key);
+int btrfs_clear_tree(struct btrfs_trans_handle *trans,
+		     struct btrfs_root *root);
 int btrfs_delete_and_free_root(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root);
 struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 bytenr);
diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 93806ca01..08b220740 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -1228,44 +1228,6 @@ out:
 		btrfs_abort_transaction(trans, ret);
 	return ret;
 }
-static int clear_free_space_tree(struct btrfs_trans_handle *trans,
-				 struct btrfs_root *root)
-{
-	struct btrfs_path *path;
-	struct btrfs_key key;
-	int nr;
-	int ret;
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	key.objectid = 0;
-	key.type = 0;
-	key.offset = 0;
-
-	while (1) {
-		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
-		if (ret < 0)
-			goto out;
-
-		nr = btrfs_header_nritems(path->nodes[0]);
-		if (!nr)
-			break;
-
-		path->slots[0] = 0;
-		ret = btrfs_del_items(trans, root, path, 0, nr);
-		if (ret)
-			goto out;
-
-		btrfs_release_path(path);
-	}
-
-	ret = 0;
-out:
-	btrfs_free_path(path);
-	return ret;
-}
 
 int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 {
@@ -1288,7 +1250,7 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 
 		while (key.offset < fs_info->nr_global_roots) {
 			free_space_root = btrfs_global_root(fs_info, &key);
-			ret = clear_free_space_tree(trans, free_space_root);
+			ret = btrfs_clear_tree(trans, free_space_root);
 			if (ret)
 				goto abort;
 			key.offset++;
@@ -1299,7 +1261,7 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 			      BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE);
 		btrfs_set_super_compat_ro_flags(fs_info->super_copy, features);
 
-		ret = clear_free_space_tree(trans, free_space_root);
+		ret = btrfs_clear_tree(trans, free_space_root);
 		if (ret)
 			goto abort;
 
-- 
2.45.2


