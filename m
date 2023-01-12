Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E7C6675EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jan 2023 15:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbjALO1J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Jan 2023 09:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjALO01 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Jan 2023 09:26:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126745C926
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jan 2023 06:17:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A196661F4A
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jan 2023 14:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB17C433D2
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jan 2023 14:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673533044;
        bh=wKyo39owBGCh3hDWcpPZQqzgAM0WI+NG7SMEJPXUM9M=;
        h=From:To:Subject:Date:From;
        b=ASxWjpYe8gO4sar7/tXIjQDg3PgnYaImBVQaYNKmdUMMnrQ3CFWVg/zwq0S8Dwn+5
         2nRc5q0RHHeUUsHNb5p8Or0XkW5x//+q1j6aOh+r1iE1uQUN06VgqG4ABIi6p3nPy3
         v+MU/wUNOR1X25djRSDwohHV/3INtcs93ytXwiN9cJQpA6rN1zfoKYsjO0kVj4OKkt
         q5g9e61GRHmvDckD9HMqRTi9E3WfF970y95KGBKUJol7JK3G5qEKn9R5Nlj8c9PAox
         Ptg1C9zee4nSBvGskLbDt3bJ01JFdYRA0n3NiCwguntkVgsuGpD8PbN729Yfn158Zm
         ZOywdvtkvUOoQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix invalid leaf access due to inline extent during lseek
Date:   Thu, 12 Jan 2023 14:17:20 +0000
Message-Id: <860221a4cf1642689ed17404c12b920d1acf1019.1673532966.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During lseek, for SEEK_DATA and SEEK_HOLE modes, we access the disk_bytenr
of anextent without checking its type. However inline extents have their
data starting the offset of the disk_bytenr field, so accessing that field
when we have an inline extent can result in either of the following:

1) Interpret the inline extent's data as a disk_bytenr value;

2) In case the inline data is less than 8 bytes, we access part of some
   other item in the leaf, or unused space in the leaf;

3) In case the inline data is less than 8 bytes and the extent item is
   the first item in the leaf, we can access beyond the leaf's limit.

So fix this by not accessing the disk_bytenr field if we have an inline
extent.

Fixes: b6e833567ea1 ("btrfs: make hole and data seeking a lot more efficient")
Reported-by: Matthias Schoepfer <matthias.schoepfer@googlemail.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216908
Link: https://lore.kernel.org/linux-btrfs/7f25442f-b121-2a3a-5a3d-22bcaae83cd4@leemhuis.info/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 834bbcb91102..af046d22300e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3541,6 +3541,7 @@ static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 		struct extent_buffer *leaf = path->nodes[0];
 		struct btrfs_file_extent_item *extent;
 		u64 extent_end;
+		u8 type;
 
 		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
 			ret = btrfs_next_leaf(root, path);
@@ -3596,10 +3597,16 @@ static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 
 		extent = btrfs_item_ptr(leaf, path->slots[0],
 					struct btrfs_file_extent_item);
+		type = btrfs_file_extent_type(leaf, extent);
 
-		if (btrfs_file_extent_disk_bytenr(leaf, extent) == 0 ||
-		    btrfs_file_extent_type(leaf, extent) ==
-		    BTRFS_FILE_EXTENT_PREALLOC) {
+		/*
+		 * Can't access the extent's disk_bytenr field if this is an
+		 * inline extent, since at that offset, it's where the extent
+		 * data starts.
+		 */
+		if (type == BTRFS_FILE_EXTENT_PREALLOC ||
+		    (type == BTRFS_FILE_EXTENT_REG &&
+		     btrfs_file_extent_disk_bytenr(leaf, extent) == 0)) {
 			/*
 			 * Explicit hole or prealloc extent, search for delalloc.
 			 * A prealloc extent is treated like a hole.
-- 
2.35.1

