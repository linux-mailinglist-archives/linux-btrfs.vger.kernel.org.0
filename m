Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA72B578D5F
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 00:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbiGRWNU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 18:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGRWNR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 18:13:17 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A41313B8
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 15:13:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CA4015C016C;
        Mon, 18 Jul 2022 18:13:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 18 Jul 2022 18:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1658182395; x=1658268795; bh=L4
        eJ/WaMzm7flUldaaApsNiFlTtgq6/eU3AVwU1oxcM=; b=ke5aIr5/VX+W6ELFua
        s/CdO0vHCWSLloICYXdkM71VoSIQI/Mb7HXfI6Yqfs33jMyFifGuwOXDBv2gn92a
        ixElHcwMN8+cw1eu/87Acchjz3D3CNFv8VJApAbtr66SFgEQMdBl/rs4ApJEa0cF
        jTO6HWWzMR2JIOdJAgZ08+v5faTxGlVpdRkBOthY6+CraL7BCVeSJU24X7IYfs5D
        isHTJw1iZ86DhrX2j0K+aBRPb/5LUh67CliJkumsHpRe21fIFp3XPhHWYsC8RNzF
        /gGSk4qGQ+Jm1Z4hKe2k8G6K8H2goAu6TWTvGKRbgwHqJAFckqKYxhgKrCIsxfKD
        XL+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1658182395; x=1658268795; bh=L4eJ/WaMzm7fl
        UldaaApsNiFlTtgq6/eU3AVwU1oxcM=; b=sLVyFHfZXMiDDAgYRRDDcwC692U3J
        b3a+w9Gxw9fMcV+liAzDFi2RiBTMahUbfeRsjW7ceE+5oiClbMlX28QCCDcwv8GD
        1dFHoPb0Ncfo/wwTf6D3nJBTXGt9poRFyBG/BuoHJsVIJXg7XKGF97bJ1cRroZ0V
        A9mkAZ8g5H/CtAGI6FIf0pUUUy04b3Qxvt/viggwlIyIl0ZnbfzF2NaQJk6Rt6C6
        FvV5rQYnJ2rUEAdUVVZrdlaaNme2CCF4auJsUzy6TDwlY6vQ66p8bVWmivPOcj2D
        kObxL+aQytlkWndS9D8UIvYVJoiH9K8iwrC7ZxsCFcyhbZrO3OtcUD5Kw==
X-ME-Sender: <xms:-9rVYoz5vGkTrdTSb_UeIGoP-nM79Fw5kLPJOpQMxU7HZ28VKO1SJw>
    <xme:-9rVYsQksIpxL0ln2lMDILg3peh02Lq94ajafSzMaMySTFEd5uNW65ivzC7TXIe5R
    JH8b2AJEuTtc6L7oBc>
X-ME-Received: <xmr:-9rVYqUXGCJJOnO3NleHEuFFvEq8bIGuFUfN9OqP0FpF8q7cJBK1yFmhRZpDypWQij2arsVOKcg25XcoYuR3SFZJo-iwNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudekledgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:-9rVYmi7f1AD1RRL5ZGVChTPD-LMqWgRGvLrPmFBSARkfGUuudsxAw>
    <xmx:-9rVYqD_5TgHZiNEd0i_e2osU4B8MzueF-q4Ysvyc3Nys0Hi9gzU8Q>
    <xmx:-9rVYnIz_sUIO2GeoxsEn7poYxUDR0lqP37Sesd28s8rF0XxP8jCMQ>
    <xmx:-9rVYlqk8GlHhjInZJVCtXVFVT7jIl3Ksj40AP9d3Jw_PFGO2lKdnA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Jul 2022 18:13:15 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 1/4] btrfs-corrupt-block: define (u64)-1 as UNSET_U64
Date:   Mon, 18 Jul 2022 15:13:08 -0700
Message-Id: <d1957fea4642be76275713c9e0800896f6f6353f.1658182042.git.boris@bur.io>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1658182042.git.boris@bur.io>
References: <cover.1658182042.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

we use this placeholder for many inputs in this script, so give it a
name for clarity.

Signed-off-by: Boris Burkov <boris@bur.io>
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

