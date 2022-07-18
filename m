Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB7A578D5E
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 00:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbiGRWNV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 18:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiGRWNT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 18:13:19 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A2D313A5
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 15:13:17 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 60BAC5C0179;
        Mon, 18 Jul 2022 18:13:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 18 Jul 2022 18:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1658182397; x=1658268797; bh=rN
        V174Xun5ycsp04TqWRQX0ro8jgxtFYEOTEEv3if0k=; b=F5xx7gcB+HVIxV1Zj9
        Dvx5go1F5EzowPoAXcW0Vv934+byR7gddHAGr2bplM+LK8sNFf/dKP42IDVvlzOa
        kil1KZB9k2FSMUwTQGjlidLH+T15ZKPBJ01pdnudLiCtbwAVg5ZHVda1kQyR3Ee6
        v9vIPPBAhdfZxaTj0uX9IH0ijjM/FFVXx9/fxEC8+OJNL1mDXUP3yTeZprlbJr3/
        ulL5RXk7T4pXRux47Kvnh7LZWdFtRZ77LUEyteAtnB4u1lu/FfzDo4VUPKIjq5da
        kuSplBr/NPvvRrWs0PY2KE7NbMQZ5YIHO4mRznTiB+1u+16M/2AdB5z63wA66g/A
        mZXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1658182397; x=1658268797; bh=rNV174Xun5ycs
        p04TqWRQX0ro8jgxtFYEOTEEv3if0k=; b=nYYuyU+TErj0idJhXD2CK4ZEhAHKa
        wgphH5DZ9BaGaN0ff/ZpVfG8BF9C5e5t9dEHCYMtHSqSTJEaWv77y6kQkX8suPUL
        L18fktGlMy6J/8afd+HNOq0Bq/uXrR1gDqvNGrFyaZDdQWJjzBsrJBU7pK2Kquog
        Zuz06m2zTSm3X/52I85Z1WXYbyyf/vXmlih48NszkaA7BmFgarioZkJ75rXGE3FM
        w0I2gJ5/nc0U+X1Ku6vaY2MgqaNmXNV+ELXfdBngxMZQGimwhMy7JHAKjYGLXfl2
        g2EYxzS4gn0XBOXx2ESpfJhGfKbPbQqFEWeuLyFL2i+uqiD9PU9a4Hj2g==
X-ME-Sender: <xms:_drVYmZfSwN_OozkqoLwsLlDWIAkRxZCLabXQSfMLCxpAoeBfLdfOw>
    <xme:_drVYpZey8w3zMP106jZSp6t8qW6GC-AaJiJmY0nFASD4Ybp9rt6EPapSgbQezTOi
    H58I65oTtQS7r9xYvs>
X-ME-Received: <xmr:_drVYg9iOieazsnBoS5Dmwst6x_-XttVRBlzYkjy2J9uIHMmT8AN1wlfMX4RhpC8MtJvEoRjePfiXJm5YYyAok8T7KVl_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudekledgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:_drVYoqmrNT670Y7cQ8_3JUCYL2hrmFQzoDkiWPzvmjQJ0xx6dHZUQ>
    <xmx:_drVYhqpnhrK-Srrw1yskbFKpZXUWTF7U8tCxbX6T1Cl4skDtkBVyA>
    <xmx:_drVYmT4WdKUPxhuaT_XDMIyZlbOKe6WTdB8NTmzbNzmxL2Z65WlDg>
    <xmx:_drVYgQS5vb4OgARJtF0AJNu_iNGf7rkPbBJ2UJ-zJqgNPWgulN3kA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Jul 2022 18:13:16 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 2/4] btrfs-progs: corrupt generic item data with btrfs-corrupt-block
Date:   Mon, 18 Jul 2022 15:13:09 -0700
Message-Id: <c997560fffbd67ef460876bf9ddb7b33c034a7ff.1658182042.git.boris@bur.io>
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
 btrfs-corrupt-block.c | 77 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 3 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index b826c9c2e..225818817 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -99,12 +99,14 @@ static void print_usage(int ret)
 	printf("\t-m   The metadata block to corrupt (must also specify -f for the field to corrupt)\n");
 	printf("\t-K <u64,u8,u64> Corrupt the given key (must also specify -f for the field and optionally -r for the root)\n");
 	printf("\t-f   The field in the item to corrupt\n");
-	printf("\t-I <u64,u8,u64> Corrupt an item corresponding to the passed key triplet (must also specify the field to corrupt and root for the item)\n");
+	printf("\t-I <u64,u8,u64> Corrupt an item corresponding to the passed key triplet (must also specify the field, or a (bytes, offset, value) tuple to corrupt and root for the item)\n");
 	printf("\t-D <u64,u8,u64> Corrupt a dir item corresponding to the passed key triplet, must also specify a field\n");
 	printf("\t-d <u64,u8,u64> Delete item corresponding to passed key triplet\n");
 	printf("\t-r   Operate on this root\n");
 	printf("\t-C   Delete a csum for the specified bytenr.  When used with -b it'll delete that many bytes, otherwise it's just sectorsize\n");
 	printf("\t--block-group OFFSET  corrupt the given block group\n");
+	printf("\t-v   Value to use for corrupting item data\n");
+	printf("\t-o   Offset to use for corrupting item data\n");
 	exit(ret);
 }
 
@@ -975,6 +977,56 @@ out:
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
+	u32 item_size;
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
+	item_size = btrfs_item_size(leaf, slot);
+	if (bogus_offset + bogus_size > item_size) {
+		fprintf(stderr, "Item corruption past end of item: %llu > %u\n", bogus_offset + bogus_size, item_size);
+		ret = -EINVAL;
+		goto commit_txn;
+	}
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
@@ -1231,6 +1283,8 @@ int main(int argc, char **argv)
 	u64 csum_bytenr = 0;
 	u64 block_group = 0;
 	char field[FIELD_BUF_LEN];
+	u64 bogus_value = UNSET_U64;
+	u64 bogus_offset = UNSET_U64;
 
 	field[0] = '\0';
 	memset(&key, 0, sizeof(key));
@@ -1259,11 +1313,13 @@ int main(int argc, char **argv)
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
@@ -1329,6 +1385,12 @@ int main(int argc, char **argv)
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
@@ -1455,7 +1517,16 @@ int main(int argc, char **argv)
 		if (!root_objectid)
 			print_usage(1);
 
-		ret = corrupt_btrfs_item(target_root, &key, field);
+		if (*field != 0)
+			ret = corrupt_btrfs_item(target_root, &key, field);
+		else if (bogus_offset != UNSET_U64 &&
+			 bytes != UNSET_U64 &&
+			 bogus_value != UNSET_U64)
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

