Return-Path: <linux-btrfs+bounces-7973-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE861976B8B
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 16:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B63DB24689
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 14:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FE01B12E6;
	Thu, 12 Sep 2024 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kj7LimdB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E031A2844
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149948; cv=none; b=fZN84k61s1qGCAcOlN/Nik2vD26nrtCEmEA4lpSh4OvgQcdqHIHxLiFcOQDp27hLwlCfmncITwFVgcEmfRX5xUMlc+spU0RH1G1OziSdc4BfHcw22iBAw+oLOGs0TFkPDIkFXLLWGt1tzBfyQC9nnxzu8aeT/I5JjOUtvh5Xbok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149948; c=relaxed/simple;
	bh=SiHLqOZqSLjoGG/nfNYXNEhtfLVb/Z5jxZfIs8MwYRw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=RJIHzMqDvs0OsUZfyN7Z0gciVpOoyg7QxNIwkCFfaDWTzPemmJmXKMSEZQpojzaej/YYIo0IjPmIqfYoAk46phTOCkJTskICx7QdFUerFx0Dau4bjrQbFAKAj8nSRHcjmvLjDwpKrvwsjTeF8RdXDAWdHQf5M2RAQ2Fw2vllT7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kj7LimdB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1BAC4CEC5
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 14:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726149948;
	bh=SiHLqOZqSLjoGG/nfNYXNEhtfLVb/Z5jxZfIs8MwYRw=;
	h=From:To:Subject:Date:From;
	b=kj7LimdBqk68yUQZyBrSLPO6wur/ukT9CzyYjpH1onyzKZQOGvSSxpwoNEHBFJBsy
	 Y8XStCDvNYfgqyakTn3BdcSgq6SU4EGexDGWUs2/f8xW4bomtqYw7AAE9BybBkK4fZ
	 vb2kflmjCIc+AlSrtYzrPIdIkxARnA8iSpzjsPQNbZOWHOMVuNshyj6XWu40ThssR6
	 4T7o0e6Pt6aso+eNJfY7OvaU9T6/nuSqzkyK3QwC8mX0yf55MP04PTZIPC7S8h+RNo
	 biPQRPX2nE2n2GykfuRKBTrLaY/JzI7ADgQOv3T8csC6/H7moY7jpO1evISICegpxK
	 BaTgvX4uoLvCQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: map-logical: fix search miss when extent is the first in a leaf
Date: Thu, 12 Sep 2024 15:05:44 +0100
Message-Id: <dd34707ffd1cd5a458980a209cfcc06a1817b848.1726149878.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When searching the extent tree for the target extent item, we can miss it
if the extent item is the first item in a leaf and if there is a previous
leaf in the extent tree.

For example, if we call btrfs-map-logical like this:

   $ btrfs-map-logical -l 5382144 /dev/sdc

And we have the following extent tree layout:

   leaf 5386240 items 26 free space 2505 generation 7 owner EXTENT_TREE
   leaf 5386240 flags 0x1(WRITTEN) backref revision 1
   (...)
           item 25 key (5373952 METADATA_ITEM 0) itemoff 3155 itemsize 33
                   refs 1 gen 7 flags TREE_BLOCK
                   tree block skinny level 0
                   (176 0x5) tree block backref root FS_TREE

   leaf 5480448 items 56 free space 276 generation 7 owner EXTENT_TREE
   leaf 5480448 flags 0x1(WRITTEN) backref revision 1
   (...)
           item 0 key (5382144 METADATA_ITEM 0) itemoff 3962 itemsize 33
                   refs 1 gen 7 flags TREE_BLOCK
                   tree block skinny level 0
                   (176 0x7) tree block backref root CSUM_TREE
   (...)

Then the following happens:

1) We enter map_one_extent() with search_forward == 0 and
   *logical_ret == 5382144;

2) We search for the key (5382144 0 0) which leaves us with a path
   pointing to leaf 5386240 at slot 26 - one slot beyond the last item;

3) We then call:

     btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0])

   Which is not valid since there's no item at that slot, but since the
   area of the leaf where an item at that slot should be is zeroed out,
   we end up getting a key of (0 0 0);

4) We then enter the "if" statement bellow, since key.type is 0, and call
   btrfs_previous_extent_item(), which leaves at slot 25 of leaf 5386240,
   point to the extent item of the extent 5373952.

   The requested extent, 5382144, is the first item of the next leaf
   (5480448), but we totally miss it;

5) We return to the caller, the main() function, with 'cur_logical'
   pointing to the metadata extent at 5373952, and not to the requested
   one at 5382144.

   In the last while loop of main() we have 'cur_logical' == 5373952,
   which makes the loop have no iterations and therefore the local
   variable 'found' remans with a value of 0, and then the program fails
   like this:

   $ btrfs-map-logical -l 5382144 /dev/sdc
   ERROR: no extent found at range [5382144,5386240)

Fix this by never accessing beyond the last slot of a leaf. If we ever end
up at a slot beyond the last item in a leaf, just call btrfs_next_leaf()
and process the first item in the returned path.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 btrfs-map-logical.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/btrfs-map-logical.c b/btrfs-map-logical.c
index 2984e645..a97afea4 100644
--- a/btrfs-map-logical.c
+++ b/btrfs-map-logical.c
@@ -74,6 +74,11 @@ static int map_one_extent(struct btrfs_fs_info *fs_info,
 	BUG_ON(ret == 0);
 	ret = 0;
 
+	if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
+		ret = btrfs_next_leaf(extent_root, path);
+		if (ret)
+			goto out;
+	}
 again:
 	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 	if ((search_forward && key.objectid < logical) ||
-- 
2.43.0


