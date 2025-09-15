Return-Path: <linux-btrfs+bounces-16835-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D92B5824B
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 18:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6E22A14C9
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 16:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B741287273;
	Mon, 15 Sep 2025 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzRiw28V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C28286D50
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954247; cv=none; b=jVIDrAOHfw+px+zNu211j1bwiGQMJB6WlxVz4Q3aUHT55td3IXwIKozl6sZTL68r8awPrIlqiCRqjDZnn/umPn46xhEuYXK4FFZrHIhBGceHDwNt0reyaMrUa+PNWS1IUcQ1USBaLe1jJVozEsGTUas0TncsSGiWbFIJ/aTlCx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954247; c=relaxed/simple;
	bh=Mj01zekni9Z3NlACw+iOq11MesqDvSqCJxinfqwaK7U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItobyWFA12bvkREjJbWB1S9kSNjfBsbAojN634D+q0iK9A6cxRWd2McpUJuK7ImY4YMZRBspJATe5KeMnupKhT4Sku+N1XxLFxtZGPtyjxzNKKgu+u0qtVznRLyi21vII0sUtj7n9QBkjj2a0jx/vKbA95Nmgz/5KZzmptY4+k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzRiw28V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6003EC4CEF7
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 16:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757954246;
	bh=Mj01zekni9Z3NlACw+iOq11MesqDvSqCJxinfqwaK7U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TzRiw28VMtAnDe0HMRk5Pfu2giA4PMxUBBKkt50EiyA6a1Ij9cCXBx3HJrrQDyrrO
	 /4GKlxn9eOTZDo/hei35iXsynQ47378CGpedutQ6iIc5188Fo/hsOmoqGNCe5h6Rzi
	 Kh2ZDQmGC1RHe9QRlKr4LcBDmI0cZhGTFwob9gbBBCWgqKytksRxe+8wlhCASpagkX
	 kITKw9irscnio6NRDJ90X6hltPJeDCPo0AGrLnjjGUjdmY6YTDm24dYplj2sn5suiw
	 FjWi2tj2xmCRMyuo/kGtceYrdy+Hrx85WhRpF1E+RhPFtRJBCuwUcoXJtNcPL+6dWg
	 P/wX+uXtFVpcQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 10/11] btrfs: print-tree: move code for processing file extent item into helper
Date: Mon, 15 Sep 2025 17:37:12 +0100
Message-ID: <0bd6d7aee59b7496542837e12895c190af6c2658.1757952682.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757952682.git.fdmanana@suse.com>
References: <cover.1757952682.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The code for processing file extent items is quite large and it's better
to have it in a dedicated helper rather than in a huge switch statement,
just like we do in btrfs-progs.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/print-tree.c | 52 ++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 417e3860cd25..02ad18abefb9 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -338,6 +338,34 @@ static void print_extent_csum(const struct extent_buffer *eb, int i)
 		key.offset, key.offset + csum_bytes, csum_bytes);
 }
 
+static void print_file_extent_item(const struct extent_buffer *eb, int i)
+{
+	struct btrfs_file_extent_item *fi;
+
+	fi = btrfs_item_ptr(eb, i, struct btrfs_file_extent_item);
+	pr_info("\t\tgeneration %llu type %hhu\n",
+		btrfs_file_extent_generation(eb, fi),
+		btrfs_file_extent_type(eb, fi));
+
+	if (btrfs_file_extent_type(eb, fi) == BTRFS_FILE_EXTENT_INLINE) {
+		pr_info("\t\tinline extent data size %u ram_bytes %llu compression %hhu\n",
+			btrfs_file_extent_inline_item_len(eb, i),
+			btrfs_file_extent_ram_bytes(eb, fi),
+			btrfs_file_extent_compression(eb, fi));
+		return;
+	}
+
+	pr_info("\t\textent data disk bytenr %llu nr %llu\n",
+		btrfs_file_extent_disk_bytenr(eb, fi),
+		btrfs_file_extent_disk_num_bytes(eb, fi));
+	pr_info("\t\textent data offset %llu nr %llu ram %llu\n",
+		btrfs_file_extent_offset(eb, fi),
+		btrfs_file_extent_num_bytes(eb, fi),
+		btrfs_file_extent_ram_bytes(eb, fi));
+	pr_info("\t\textent compression %hhu\n",
+		btrfs_file_extent_compression(eb, fi));
+}
+
 void btrfs_print_leaf(const struct extent_buffer *l)
 {
 	struct btrfs_fs_info *fs_info;
@@ -345,7 +373,6 @@ void btrfs_print_leaf(const struct extent_buffer *l)
 	u32 type, nr;
 	struct btrfs_root_item *ri;
 	struct btrfs_block_group_item *bi;
-	struct btrfs_file_extent_item *fi;
 	struct btrfs_extent_data_ref *dref;
 	struct btrfs_shared_data_ref *sref;
 	struct btrfs_dev_extent *dev_extent;
@@ -417,28 +444,7 @@ void btrfs_print_leaf(const struct extent_buffer *l)
 			       btrfs_shared_data_ref_count(l, sref));
 			break;
 		case BTRFS_EXTENT_DATA_KEY:
-			fi = btrfs_item_ptr(l, i,
-					    struct btrfs_file_extent_item);
-			pr_info("\t\tgeneration %llu type %hhu\n",
-				btrfs_file_extent_generation(l, fi),
-				btrfs_file_extent_type(l, fi));
-			if (btrfs_file_extent_type(l, fi) ==
-			    BTRFS_FILE_EXTENT_INLINE) {
-				pr_info("\t\tinline extent data size %u ram_bytes %llu compression %hhu\n",
-					btrfs_file_extent_inline_item_len(l, i),
-					btrfs_file_extent_ram_bytes(l, fi),
-					btrfs_file_extent_compression(l, fi));
-				break;
-			}
-			pr_info("\t\textent data disk bytenr %llu nr %llu\n",
-			       btrfs_file_extent_disk_bytenr(l, fi),
-			       btrfs_file_extent_disk_num_bytes(l, fi));
-			pr_info("\t\textent data offset %llu nr %llu ram %llu\n",
-			       btrfs_file_extent_offset(l, fi),
-			       btrfs_file_extent_num_bytes(l, fi),
-			       btrfs_file_extent_ram_bytes(l, fi));
-			pr_info("\t\textent compression %hhu\n",
-				btrfs_file_extent_compression(l, fi));
+			print_file_extent_item(l, i);
 			break;
 		case BTRFS_BLOCK_GROUP_ITEM_KEY:
 			bi = btrfs_item_ptr(l, i,
-- 
2.47.2


