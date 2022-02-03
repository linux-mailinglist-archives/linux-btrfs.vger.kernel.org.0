Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9EB4A870E
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 15:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351560AbiBCO4D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 09:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351554AbiBCOz7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 09:55:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED72C06173D
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 06:55:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD2ACB83477
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 14:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C793C340E4
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 14:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643900156;
        bh=1IFl5mb+tmmYFtrSRyccD7Ue1HgGOpJx0+oCMCNw2EI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=h/l6bRLsX1+dn98jbBCmob6XWb3jMDCjV5aTwZy1/0mBGxEs/u7FOAnIu4OU+w0mo
         b9Zp4xHSxUSpHFrL2KZsxSwOKtS6jGNPzYtgNC6vdL5IpvkB2EL5LJU81h+belffZg
         BCoU70HpI4/rOLnjVXEnVW5RcNTyBLOFHIa4C8miwfAT5lZHOEbGp4PUpi0QF0EDJu
         1qRPF3uzIoAXldpeqlh3LfwNzVpVXMMR4V79CczregZLyWSw6lpznkevGATGt8FMW1
         9fcULP27EoT3E4AMv1bpc4yc8ldDliJ73XVb5FgW35M/PfeAnreftwcO/SZQIzsM5w
         x9pmstzW2swMQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs: avoid unnecessary computation when deleting items from a leaf
Date:   Thu,  3 Feb 2022 14:55:47 +0000
Message-Id: <37c4e38c13e87a266fc99d62a1465c7ff5eb2e01.1643898314.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643898312.git.fdmanana@suse.com>
References: <cover.1643898312.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When deleting items from a leaf, we always compute the sum of the data
sizes of the items that are going to be deleted. However we only use
that sum when the last item to delete is behind the last item in the
leaf. This unnecessarily wastes CPU time when we are deleting either
the whole leaf or from some slot > 0 up to the last item in the leaf,
and both of these cases are common (e.g. truncation operation, either
as a result of truncate(2) or when logging inodes, deleting checksums
after removing a large enough extent, etc).

So compute only the sum of the data sizes if the last item to be
deleted does not match the last item in the leaf.

This change if part of a patchset that is comprised of the following
patches:

  1/6 btrfs: remove unnecessary leaf free space checks when pushing items
  2/6 btrfs: avoid unnecessary COW of leaves when deleting items from a leaf
  3/6 btrfs: avoid unnecessary computation when deleting items from a leaf
  4/6 btrfs: remove constraint on number of visited leaves when replacing extents
  5/6 btrfs: remove useless path release in the fast fsync path
  6/6 btrfs: prepare extents to be logged before locking a log tree path

The last patch in the series has some performance test result in its
changelog.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 5322140f4d22..1bb5335c6d75 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4158,24 +4158,22 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *leaf;
-	u32 last_off;
-	u32 dsize = 0;
 	int ret = 0;
 	int wret;
-	int i;
 	u32 nritems;
 
 	leaf = path->nodes[0];
-	last_off = btrfs_item_offset(leaf, slot + nr - 1);
-
-	for (i = 0; i < nr; i++)
-		dsize += btrfs_item_size(leaf, slot + i);
-
 	nritems = btrfs_header_nritems(leaf);
 
 	if (slot + nr != nritems) {
-		int data_end = leaf_data_end(leaf);
+		const u32 last_off = btrfs_item_offset(leaf, slot + nr - 1);
+		const int data_end = leaf_data_end(leaf);
 		struct btrfs_map_token token;
+		u32 dsize = 0;
+		int i;
+
+		for (i = 0; i < nr; i++)
+			dsize += btrfs_item_size(leaf, slot + i);
 
 		memmove_extent_buffer(leaf, BTRFS_LEAF_DATA_OFFSET +
 			      data_end + dsize,
-- 
2.33.0

