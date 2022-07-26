Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CAD581B3F
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 22:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239967AbiGZUmr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 16:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239707AbiGZUmo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 16:42:44 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE62F37FA0
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 13:42:42 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3C4355C00C0;
        Tue, 26 Jul 2022 16:42:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 26 Jul 2022 16:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1658868162; x=1658954562; bh=5k
        c+7FivKqBvydtDiy4zefYmBasG6z9O8fnbMVBlDhU=; b=XU9OeDOE7x/y7EFVkf
        X4Ilv+wYPl0N/oDRs5fj2BBSL4ycVMx7BIVUi10q/RpT2aE+l7dK5cT8dn89YSGc
        ulgidK+x6wprK/BNZg1QJvSvQO1Szsu4SFp+lXKqSP8yURYI5zh7IA4ZicJJyrjK
        ZwdSkNyCv3VPp1xiQC8/KmbFmbg35/+BXXocwVBPNGCYujRaaMmIakcDA9my6ssv
        7ZrUc9twntMzLsE2oXYgmMOmrzczdjYHqTo9BC+hkf3s0Wg7vI861juwHkLxtPHm
        Swux48HoFfz3XTVSKdY5fbV0U2t5UxkMnmIAIgglhMwXX6Zds0BCIs5sqOWORFAO
        Y7Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1658868162; x=1658954562; bh=5kc+7FivKqBvy
        dtDiy4zefYmBasG6z9O8fnbMVBlDhU=; b=eLoTKHBCsF5CL3tNUbDM+Z9jkj079
        56T6rKVTukVsKvWJDqWhh1nqVhJOvNc2vQkXSgKwFeyVbuP1KByg4OOUdY6z/5Pb
        m/bBsEYtFm69N/g/U/QTvxYKiAqnaxkOX13GTiP97oOI5CV17zlPWFD9BDkgXOjh
        mwk+hBDQwrSj502st1xKiRv1Ep14higBT3ScQD9o/Ffee1ZOr9old+BqSJyDpue8
        8JmcViu1+72lyrDVj60d4zNfg4Aa5+q3Q1axr98bYYlR+cJYcq1VrEP3Fz9qvq/T
        TFgp20MlJQwzvCyJQNcyFMsYdJbI5QNFhqUVkcwZELXsh7Cl0ofUI/coQ==
X-ME-Sender: <xms:wlHgYrPZlLYBSA4r0ceMXe-wgGqYCkiBnbkztA-VduEF_UTYnOS4qA>
    <xme:wlHgYl-f8aumj_T1JHq1xJKexB4kU_8D2hvMSZYGp9ZZtesupqwnnp0CQHIYDDa3l
    DcglwsVwE9OU4zC7jQ>
X-ME-Received: <xmr:wlHgYqSNBJCSfPtMM5GHUdXzvtmyKv1LnzDfR0qnwnKli-CxI2I7CvklC1LSzsHe4YBimjXDP0ocGAOgVr_imLdf6Ae_cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddutddgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:wlHgYvsSRXnsonvytA68Uzp9KmQ6Vw6-UFvyBs72puFugFYYXYEpiw>
    <xmx:wlHgYjdbHhdXlByppuNnd6OrBKocBVYa-OG2-VUkWCyrej2PDaHEDA>
    <xmx:wlHgYr3cemdGyNyEsoYawecl2rVw7U3E1tYDCzyHetR96AimPB-dmA>
    <xmx:wlHgYjk7kOE6Ock4fYvNM69qxiw5oDkjNNWRt52wji_KAE_54Mvqag>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Jul 2022 16:42:41 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 2/4] btrfs-progs: corrupt generic item data with btrfs-corrupt-block
Date:   Tue, 26 Jul 2022 13:43:23 -0700
Message-Id: <28622e4945b9d31ac38367505efb4dbef72113ed.1658867979.git.boris@bur.io>
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
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
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

