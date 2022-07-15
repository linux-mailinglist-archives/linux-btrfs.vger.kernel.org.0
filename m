Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA675768CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 23:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiGOVWX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 17:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiGOVWT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 17:22:19 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A71372EF1
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 14:22:17 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C198C5C00C6;
        Fri, 15 Jul 2022 17:22:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 15 Jul 2022 17:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1657920135; x=1658006535; bh=An
        j/K/yAX9qAALqiNBOl88TcJ4kgt8AcX5R3qXUrs5E=; b=Z+Hi6ocQyWC+mny6fK
        YixfKkbHJ5EV7qQgWGwBgKXroDgeHn54vxmm8hwpM5ETp5mSM58Q1JDK9Bgru5H9
        vauNFQJkFHxdK67V8oWY9ccuMUfRpVkvMo8A5eQRwTnK851iigd4gUIMkvYdLV/4
        y5Lw2HMkgu55omapCbDBo9Jdc8EUyTXVn/EUOfhb+cCy4zdXW/VRUj/TViIbTOqB
        PWpmcGrWP+zbi5Z807s/EgjgTv3ESnLiIL4Ko4BK3ZsDN1Jp8G8pofEQuzLnT6dH
        A6y6Sv+/psRIj2IAiu9Ls3ed2KcGcoBrrQ1su8R+HPdZ2gmJVRDlusbJRY/4VtHW
        2YnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1657920135; x=1658006535; bh=Anj/K/yAX9qAA
        LqiNBOl88TcJ4kgt8AcX5R3qXUrs5E=; b=1XyWPQehGcltAO3/sh2tcnsDOgaOH
        ZMgCSbTB9UEEXCqjUScmvxLcAt4Wic+zXh2ldnLM0sIqo69L/BdFriYjoVjrFEhL
        ARMFX/bsi1G2Mb6hnVR7VnsnNtdfGaa4uGmJx/HbDNogb6cY8YhLIhuEudY1dX+M
        b+fwEmJ3cJZdUlz6BmLCbU8RIddyzhL2pSwijOKLoUfCQMbeJCV0Y6so/TwV0ABy
        o7oXGTq6w0bFamfD1vAKtQt1WHLeQzIx7CPq6s3muaVHnNnQdsicOnR8dW0PmwN8
        mBx5vahhJzs/aOQzV6W2EsIqg/6QbvqwyEWq9S86i1IQwIi313qQEOfmw==
X-ME-Sender: <xms:h9rRYoOG-oCD8wK3Y9YYUhJ0P891qEyQTS5guV5M-mXhGPo0fiRsVA>
    <xme:h9rRYu8TP-IXKIK1_lcniWk48psI9Zox_Jf5DpOJoxvLKaX4cFLVfFcnfDcAZCg_z
    tvhpyiyQV66fv-Psas>
X-ME-Received: <xmr:h9rRYvSOeJp_NgwEeH4-COkIAtk8T_fm45LtnD-ss2IHzEPUKBcjqp49mPGCdEAyP-ZXnVq_Tf7vNT1haXnP5ok8S7rpHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudekuddgudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:h9rRYguCl7sp3y-WIQWVUnsnP3NwPHLUxyOGgcmhLqcHSY19Viw5VQ>
    <xmx:h9rRYgcFwKYjVfe7jIIoKA0Yc4eoyPfpKv2scYyNmr3YWSs7xpY5Ug>
    <xmx:h9rRYk0Kobm6D-pauDD7NgXyGTnwKPG2ga5Q4nyZcPmLgU2ka3yJqw>
    <xmx:h9rRYokW5SeDYLmYyBNTQ7RohLIDiI7tvAWY7Yt76Xur7RwBf8Ao7w>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Jul 2022 17:22:15 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 1/2] btrfs-progs: corrupt generic item data with btrfs-corrupt-block
Date:   Fri, 15 Jul 2022 14:22:11 -0700
Message-Id: <4c0d4b0003c31f1c1ee1d7a475f70f25663b98f6.1657919808.git.boris@bur.io>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1657919808.git.boris@bur.io>
References: <cover.1657919808.git.boris@bur.io>
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

btrfs-corrupt-block already has a mix of generic and specific corruption
options, but currently lacks the capacity for totally arbitrary
corruption in item data.

There is already a flag for corruption size (bytes/-b), so add a flag
for an offset and a value to memset the item with. Exercise the new
flags with a new variant for -I (item) corruption. Look up the item as
before, but instead of corrupting a field in the item struct, corrupt an
offset/size in the item data.

The motivating example for this is that in testing fsverity with btrfs,
we need to corrupt the generated Merkle tree--metadata item data which
is an opaque blob to btrfs.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 btrfs-corrupt-block.c | 71 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index e961255d5..5c39459db 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -98,12 +98,14 @@ static void print_usage(int ret)
 	printf("\t-m   The metadata block to corrupt (must also specify -f for the field to corrupt)\n");
 	printf("\t-K <u64,u8,u64> Corrupt the given key (must also specify -f for the field and optionally -r for the root)\n");
 	printf("\t-f   The field in the item to corrupt\n");
-	printf("\t-I <u64,u8,u64> Corrupt an item corresponding to the passed key triplet (must also specify the field to corrupt and root for the item)\n");
+	printf("\t-I <u64,u8,u64> Corrupt an item corresponding to the passed key triplet (must also specify the field, or bytes, offset, and value to corrupt and root for the item)\n");
 	printf("\t-D <u64,u8,u64> Corrupt a dir item corresponding to the passed key triplet, must also specify a field\n");
 	printf("\t-d <u64,u8,u64> Delete item corresponding to passed key triplet\n");
 	printf("\t-r   Operate on this root\n");
 	printf("\t-C   Delete a csum for the specified bytenr.  When used with -b it'll delete that many bytes, otherwise it's just sectorsize\n");
 	printf("\t--block-group OFFSET  corrupt the given block group\n");
+	printf("\t-v   Value to use for corrupting item data\n");
+	printf("\t-o   Offset to use for corrupting item data\n");
 	exit(ret);
 }
 
@@ -974,6 +976,50 @@ out:
 	return ret;
 }
 
+static int corrupt_btrfs_item_data(struct btrfs_root *root,
+				   struct btrfs_key *key,
+				   u64 bogus_offset, u64 bogus_size,
+				   char bogus_value)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_path *path;
+	int ret;
+	void *data;
+	struct extent_buffer *leaf;
+	int slot;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	trans = btrfs_start_transaction(root, 1);
+	if (IS_ERR(trans)) {
+		fprintf(stderr, "Couldn't start transaction %ld\n",
+			PTR_ERR(trans));
+		ret = PTR_ERR(trans);
+		goto free_path;
+	}
+
+	ret = btrfs_search_slot(trans, root, key, path, 0, 1);
+	if (ret != 0) {
+		fprintf(stderr, "Error searching to node %d\n", ret);
+		goto commit_txn;
+	}
+	leaf = path->nodes[0];
+	slot = path->slots[0];
+	data = btrfs_item_ptr(leaf, slot, void);
+	// TODO: check offset/size legitimacy
+	data += bogus_offset;
+	memset_extent_buffer(leaf, bogus_value, (unsigned long)data, bogus_size);
+	btrfs_mark_buffer_dirty(leaf);
+
+commit_txn:
+	btrfs_commit_transaction(trans, root);
+free_path:
+	btrfs_free_path(path);
+	return ret;
+}
+
 static int delete_item(struct btrfs_root *root, struct btrfs_key *key)
 {
 	struct btrfs_trans_handle *trans;
@@ -1230,6 +1276,8 @@ int main(int argc, char **argv)
 	u64 csum_bytenr = 0;
 	u64 block_group = 0;
 	char field[FIELD_BUF_LEN];
+	u64 bogus_value = (u64)-1;
+	u64 bogus_offset = (u64)-1;
 
 	field[0] = '\0';
 	memset(&key, 0, sizeof(key));
@@ -1258,11 +1306,13 @@ int main(int argc, char **argv)
 			{ "root", no_argument, NULL, 'r'},
 			{ "csum", required_argument, NULL, 'C'},
 			{ "block-group", required_argument, NULL, GETOPT_VAL_BLOCK_GROUP},
+			{ "value", required_argument, NULL, 'v'},
+			{ "offset", required_argument, NULL, 'o'},
 			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
 			{ NULL, 0, NULL, 0 }
 		};
 
-		c = getopt_long(argc, argv, "l:c:b:eEkuUi:f:x:m:K:I:D:d:r:C:",
+		c = getopt_long(argc, argv, "l:c:b:eEkuUi:f:x:m:K:I:D:d:r:C:v:o:",
 				long_options, NULL);
 		if (c < 0)
 			break;
@@ -1328,6 +1378,12 @@ int main(int argc, char **argv)
 			case GETOPT_VAL_BLOCK_GROUP:
 				block_group = arg_strtou64(optarg);
 				break;
+			case 'v':
+				bogus_value = arg_strtou64(optarg);
+				break;
+			case 'o':
+				bogus_offset = arg_strtou64(optarg);
+				break;
 			case GETOPT_VAL_HELP:
 			default:
 				print_usage(c != GETOPT_VAL_HELP);
@@ -1454,7 +1510,16 @@ int main(int argc, char **argv)
 		if (!root_objectid)
 			print_usage(1);
 
-		ret = corrupt_btrfs_item(target_root, &key, field);
+		if (*field != 0)
+			ret = corrupt_btrfs_item(target_root, &key, field);
+		else if (bogus_offset != (u64)-1 &&
+			 bytes != (u64)-1 &&
+			 bogus_value != (u64)-1)
+			ret = corrupt_btrfs_item_data(target_root, &key,
+						      bogus_offset, bytes,
+						      bogus_value);
+		else
+			print_usage(1);
 		goto out_close;
 	}
 	if (delete) {
-- 
2.37.1

