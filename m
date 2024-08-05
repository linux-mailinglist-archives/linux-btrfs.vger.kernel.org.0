Return-Path: <linux-btrfs+bounces-6991-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C38159480D2
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 19:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517611F23B9A
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 17:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EAB166F31;
	Mon,  5 Aug 2024 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJgcxwiI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0832165F1B;
	Mon,  5 Aug 2024 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880598; cv=none; b=H8WZuQP/k0VELKBzoKvLoKyeUnLIpCtLreIoLpZ/j+rs6OBpsX+jT+T5wpPrYpO2LdhzpFi4+PEprsS+UJXd7IQus80DYdRRdPd4fT6t+ZdozDF8daBsWw4dtO6iCaSOG0zNzGAYA4murzx9MsEf/Rx//yRioVX1PxXxR0Tl1tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880598; c=relaxed/simple;
	bh=0F0QgHB2YiF6bWo8/KG5Ql3yKbh041fqDCliB1Gf5Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h732tridX7iSvOK7jBg2WS6Ug0gvyP0NrHj2GSudgRI1S7p3jawzaxLDTHsOi5q5Yrea55jEBzt98pHChaRqRHDMgbK/PrPbFXYOU7ttDnDL8a2KHSwHDwB6uqfF6g2HdINOcEhAT6OM9fh8XC6R7KRWJpGxJDsFSpA4RAMYNUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJgcxwiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35343C4AF0E;
	Mon,  5 Aug 2024 17:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880597;
	bh=0F0QgHB2YiF6bWo8/KG5Ql3yKbh041fqDCliB1Gf5Ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SJgcxwiImqoNBDzAF++CnuXDGseAQYk2ocZZ8+Zxnn35E1eOBP+xoESw06OczUyIz
	 vRP9aNIu+CzOoEw6UwHOBAeNtDlMzbCR+KohwKMUuASH2wW7DH5TyKiAJ4Q8hly3Lc
	 g7TRNQp7mRuxWe6WXEkZKrZM8fQYTESbe8Q4YKYSWXU5/uP2CrD3fu5fIvQeDY/4Vu
	 hw3Dt5MbO7SlKUgooxwv+39FKQxQPJY8OTJcAaPV4bzRlsOv4ePO3ZjGJmYjuZ6T94
	 7weEaiYbf79eXp3iUoxsqJvXWuVmO7ywOy1NJ0s7Uz1gAozOrO0lPfT4kI2NzJRUfP
	 eBLTGqImhzsDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Kai Krakow <hurikhan77@gmail.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 05/16] btrfs: tree-checker: validate dref root and objectid
Date: Mon,  5 Aug 2024 13:55:37 -0400
Message-ID: <20240805175618.3249561-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805175618.3249561-1-sashal@kernel.org>
References: <20240805175618.3249561-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.3
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit f333a3c7e8323499aa65038e77fe8f3199d4e283 ]

[CORRUPTION]
There is a bug report that btrfs flips RO due to a corruption in the
extent tree, the involved dumps looks like this:

 	item 188 key (402811572224 168 4096) itemoff 14598 itemsize 79
 		extent refs 3 gen 3678544 flags 1
 		ref#0: extent data backref root 13835058055282163977 objectid 281473384125923 offset 81432576 count 1
 		ref#1: shared data backref parent 1947073626112 count 1
 		ref#2: shared data backref parent 1156030103552 count 1
 BTRFS critical (device vdc1: state EA): unable to find ref byte nr 402811572224 parent 0 root 265 owner 28703026 offset 81432576 slot 189
 BTRFS error (device vdc1: state EA): failed to run delayed ref for logical 402811572224 num_bytes 4096 type 178 action 2 ref_mod 1: -2

[CAUSE]
The corrupted entry is ref#0 of item 188.
The root number 13835058055282163977 is beyond the upper limit for root
items (the current limit is 1 << 48), and the objectid also looks
suspicious.

Only the offset and count is correct.

[ENHANCEMENT]
Although it's still unknown why we have such many bytes corrupted
randomly, we can still enhance the tree-checker for data backrefs by:

- Validate the root value
  For now there should only be 3 types of roots can have data backref:
  * subvolume trees
  * data reloc trees
  * root tree
    Only for v1 space cache

- validate the objectid value
  The objectid should be a valid inode number.

Hopefully we can catch such problem in the future with the new checkers.

Reported-by: Kai Krakow <hurikhan77@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CAMthOuPjg5RDT-G_LXeBBUUtzt3cq=JywF+D1_h+JYxe=WKp-Q@mail.gmail.com/#t
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-checker.c | 47 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index a2c3651a3d8fc..04d18721885d2 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1271,6 +1271,19 @@ static void extent_err(const struct extent_buffer *eb, int slot,
 	va_end(args);
 }
 
+static bool is_valid_dref_root(u64 rootid)
+{
+	/*
+	 * The following tree root objectids are allowed to have a data backref:
+	 * - subvolume trees
+	 * - data reloc tree
+	 * - tree root
+	 *   For v1 space cache
+	 */
+	return is_fstree(rootid) || rootid == BTRFS_DATA_RELOC_TREE_OBJECTID ||
+	       rootid == BTRFS_ROOT_TREE_OBJECTID;
+}
+
 static int check_extent_item(struct extent_buffer *leaf,
 			     struct btrfs_key *key, int slot,
 			     struct btrfs_key *prev_key)
@@ -1423,6 +1436,8 @@ static int check_extent_item(struct extent_buffer *leaf,
 		struct btrfs_extent_data_ref *dref;
 		struct btrfs_shared_data_ref *sref;
 		u64 seq;
+		u64 dref_root;
+		u64 dref_objectid;
 		u64 dref_offset;
 		u64 inline_offset;
 		u8 inline_type;
@@ -1466,11 +1481,26 @@ static int check_extent_item(struct extent_buffer *leaf,
 		 */
 		case BTRFS_EXTENT_DATA_REF_KEY:
 			dref = (struct btrfs_extent_data_ref *)(&iref->offset);
+			dref_root = btrfs_extent_data_ref_root(leaf, dref);
+			dref_objectid = btrfs_extent_data_ref_objectid(leaf, dref);
 			dref_offset = btrfs_extent_data_ref_offset(leaf, dref);
 			seq = hash_extent_data_ref(
 					btrfs_extent_data_ref_root(leaf, dref),
 					btrfs_extent_data_ref_objectid(leaf, dref),
 					btrfs_extent_data_ref_offset(leaf, dref));
+			if (unlikely(!is_valid_dref_root(dref_root))) {
+				extent_err(leaf, slot,
+					   "invalid data ref root value %llu",
+					   dref_root);
+				return -EUCLEAN;
+			}
+			if (unlikely(dref_objectid < BTRFS_FIRST_FREE_OBJECTID ||
+				     dref_objectid > BTRFS_LAST_FREE_OBJECTID)) {
+				extent_err(leaf, slot,
+					   "invalid data ref objectid value %llu",
+					   dref_root);
+				return -EUCLEAN;
+			}
 			if (unlikely(!IS_ALIGNED(dref_offset,
 						 fs_info->sectorsize))) {
 				extent_err(leaf, slot,
@@ -1609,6 +1639,8 @@ static int check_extent_data_ref(struct extent_buffer *leaf,
 		return -EUCLEAN;
 	}
 	for (; ptr < end; ptr += sizeof(*dref)) {
+		u64 root;
+		u64 objectid;
 		u64 offset;
 
 		/*
@@ -1616,7 +1648,22 @@ static int check_extent_data_ref(struct extent_buffer *leaf,
 		 * overflow from the leaf due to hash collisions.
 		 */
 		dref = (struct btrfs_extent_data_ref *)ptr;
+		root = btrfs_extent_data_ref_root(leaf, dref);
+		objectid = btrfs_extent_data_ref_objectid(leaf, dref);
 		offset = btrfs_extent_data_ref_offset(leaf, dref);
+		if (unlikely(!is_valid_dref_root(root))) {
+			extent_err(leaf, slot,
+				   "invalid extent data backref root value %llu",
+				   root);
+			return -EUCLEAN;
+		}
+		if (unlikely(objectid < BTRFS_FIRST_FREE_OBJECTID ||
+			     objectid > BTRFS_LAST_FREE_OBJECTID)) {
+			extent_err(leaf, slot,
+				   "invalid extent data backref objectid value %llu",
+				   root);
+			return -EUCLEAN;
+		}
 		if (unlikely(!IS_ALIGNED(offset, leaf->fs_info->sectorsize))) {
 			extent_err(leaf, slot,
 	"invalid extent data backref offset, have %llu expect aligned to %u",
-- 
2.43.0


