Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7BD581B42
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 22:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239907AbiGZUms (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 16:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239825AbiGZUmo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 16:42:44 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C24A37FA5
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 13:42:41 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3E3E75C00DD;
        Tue, 26 Jul 2022 16:42:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 26 Jul 2022 16:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1658868160; x=1658954560; bh=vT
        lLWDs28Pz5+Fv8nHZ/ylT5+60PvoCzY/gL1UfAH3U=; b=Ip+CXG9/lHLrH3Vdf8
        JbPmEThfmAsYFECIa4s51CLMfqTFFar5MVjKG4X/Qyq+kI/fkWTpkKyAlRaDEIZm
        +VQNi2EuDfWiw9OV9jEAvdER5Gs3Gk6rqy7/M1XZeFOspi1bMltLwuuUNpaAqTYJ
        hwPKp3fpkQZa81idHB7196aPew+c354j/vA0gLVeMaidr4BV6aRWlL9AJRMavmjB
        KZRC/ruw4GdVjPy5h2QfVzZ7paGfW5P88ygbkNr/+vaSu+/UtjFhajnNxbe0m3es
        L2OE4jzdnY79nkRPblT4uNQRNFOFHbNviXdAIP1px1ycJLoTvw3xF2EuATifRLH9
        MmxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1658868160; x=1658954560; bh=vTlLWDs28Pz5+
        Fv8nHZ/ylT5+60PvoCzY/gL1UfAH3U=; b=QWc3maXFX1irIPFzBiAdTKKNGQILt
        uTbuVZ1tINoIFlx+ptXVIdc6xt30fgmURB4b8+lmIXT1VZ06XPavMQWz3gK/HSWR
        4mZmrZJzpcdHOnowvCxJgWyXCm3fl8AA4myiBl+TVf7QiZNgRBEl2M3Glckvn8vU
        nsIrFuXQmV5CeDRPfKQoOd1dEgHgwKMpD4HALCDCxVRnUz64BvQP8xN0IkGY+uqP
        UyVKBcsrm7OiO6xcBZ35dZRU58PnoTL7/Q2sHr87FjhcTFVaW/e33YoNnQ94o5BV
        nntEm0WT84QTNdM93kSnUcB3cBQNMjXgyLIpcNN4n7HAQRx+PbqwPUhbA==
X-ME-Sender: <xms:wFHgYhk8lIOzMtq3P_vrz6hRjexcur-cXPv_RrQ9DHPqJ7XMP4nkaw>
    <xme:wFHgYs0oHpHQZk4xYtfw6XB-VXvICIcx4psYJodp8xl0WfvBnEJRscv3joD3PVb0X
    43uf4avRJ4nwi2OCSY>
X-ME-Received: <xmr:wFHgYnrl2zxUcR1XwY-hgOaBEYbPHgNglRAIX8uGQOccDjA68dWqxmVAL1o06RSV_6PPVZfsZmDw26sPpO5S5MpsS0QCAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddutddgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:wFHgYhm9JxdDNwKadgQh0P5zP2rU6VD00aXBRwSxWKH5jqsiAyLwPw>
    <xmx:wFHgYv29H80GUcWV3b6MBvfYt8TPyN727objLgaLQ9mLuyG-oBCj2w>
    <xmx:wFHgYgvPV-fXq39qNLJ6B_5g1LB4aycAPJps_QFyTiaw9ixg9KQXuA>
    <xmx:wFHgYs93zoRhQhS3NAL7ObY8DLZDIuFvN78ky6EdZ_9CAbX8jJ5XGA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Jul 2022 16:42:39 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 1/4] btrfs-corrupt-block: define (u64)-1 as UNSET_U64
Date:   Tue, 26 Jul 2022 13:43:22 -0700
Message-Id: <d2ddc9d1cae29816a103c4c623398bbf4d23e4dc.1658867979.git.boris@bur.io>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1658867979.git.boris@bur.io>
References: <cover.1658867979.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

we use this placeholder for many inputs in this script, so give it a
name for clarity.

Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 btrfs-corrupt-block.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index e961255d5..b826c9c2e 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -35,6 +35,7 @@
 #include "common/help.h"
 
 #define FIELD_BUF_LEN 80
+#define UNSET_U64 ((u64)-1)
 
 static int debug_corrupt_block(struct extent_buffer *eb,
 		struct btrfs_root *root, u64 bytenr, u32 blocksize, u64 copy)
@@ -180,7 +181,7 @@ static int corrupt_extent(struct btrfs_trans_handle *trans,
 
 	key.objectid = bytenr;
 	key.type = (u8)-1;
-	key.offset = (u64)-1;
+	key.offset = UNSET_U64;
 
 	extent_root = btrfs_extent_root(trans->fs_info, bytenr);
 	while(1) {
@@ -664,7 +665,7 @@ static int corrupt_inode(struct btrfs_trans_handle *trans,
 
 	key.objectid = inode;
 	key.type = BTRFS_INODE_ITEM_KEY;
-	key.offset = (u64)-1;
+	key.offset = UNSET_U64;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -880,7 +881,7 @@ static int corrupt_metadata_block(struct btrfs_fs_info *fs_info, u64 block,
 
 		root_key.objectid = root_objectid;
 		root_key.type = BTRFS_ROOT_ITEM_KEY;
-		root_key.offset = (u64)-1;
+		root_key.offset = UNSET_U64;
 
 		root = btrfs_read_fs_root(fs_info, &root_key);
 		if (IS_ERR(root)) {
@@ -1084,8 +1085,8 @@ static int corrupt_chunk_tree(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	key.objectid = (u64)-1;
-	key.offset = (u64)-1;
+	key.objectid = UNSET_U64;
+	key.offset = UNSET_U64;
 	key.type = (u8)-1;
 
 	/* Here, cow and ins_len must equals 0 for the following reasons:
@@ -1193,7 +1194,7 @@ static struct btrfs_root *open_root(struct btrfs_fs_info *fs_info,
 
 	root_key.objectid = root_objectid;
 	root_key.type = BTRFS_ROOT_ITEM_KEY;
-	root_key.offset = (u64)-1;
+	root_key.offset = UNSET_U64;
 
 	root = btrfs_read_fs_root(fs_info, &root_key);
 	if (IS_ERR(root)) {
@@ -1209,8 +1210,8 @@ int main(int argc, char **argv)
 	struct btrfs_key key;
 	struct btrfs_root *root, *target_root;
 	char *dev;
-	/* chunk offset can be 0,so change to (u64)-1 */
-	u64 logical = (u64)-1;
+	/* chunk offset can be 0,so change to UNSET_U64 */
+	u64 logical = UNSET_U64;
 	int ret = 0;
 	u64 copy = 0;
 	u64 bytes = 4096;
@@ -1225,7 +1226,7 @@ int main(int argc, char **argv)
 	int should_corrupt_key = 0;
 	u64 metadata_block = 0;
 	u64 inode = 0;
-	u64 file_extent = (u64)-1;
+	u64 file_extent = UNSET_U64;
 	u64 root_objectid = 0;
 	u64 csum_bytenr = 0;
 	u64 block_group = 0;
@@ -1353,7 +1354,7 @@ int main(int argc, char **argv)
 	if (extent_rec) {
 		struct btrfs_trans_handle *trans;
 
-		if (logical == (u64)-1)
+		if (logical == UNSET_U64)
 			print_usage(1);
 		trans = btrfs_start_transaction(root, 1);
 		BUG_ON(IS_ERR(trans));
@@ -1378,7 +1379,7 @@ int main(int argc, char **argv)
 		struct btrfs_path *path;
 		int del;
 
-		if (logical == (u64)-1)
+		if (logical == UNSET_U64)
 			print_usage(1);
 		del = rand_range(3);
 		path = btrfs_alloc_path();
@@ -1420,7 +1421,7 @@ int main(int argc, char **argv)
 
 		trans = btrfs_start_transaction(root, 1);
 		BUG_ON(IS_ERR(trans));
-		if (file_extent == (u64)-1) {
+		if (file_extent == UNSET_U64) {
 			printf("corrupting inode\n");
 			ret = corrupt_inode(trans, root, inode, field);
 		} else {
@@ -1481,10 +1482,10 @@ int main(int argc, char **argv)
 	 * If we made it here and we have extent set then we didn't specify
 	 * inode and we're screwed.
 	 */
-	if (file_extent != (u64)-1)
+	if (file_extent != UNSET_U64)
 		print_usage(1);
 
-	if (logical == (u64)-1)
+	if (logical == UNSET_U64)
 		print_usage(1);
 
 	if (bytes == 0)
-- 
2.37.1

