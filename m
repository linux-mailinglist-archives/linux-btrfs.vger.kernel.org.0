Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942F830FE18
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 21:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240032AbhBDUWc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 15:22:32 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40355 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240036AbhBDUWL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Feb 2021 15:22:11 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 9CA915C0163;
        Thu,  4 Feb 2021 15:09:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 04 Feb 2021 15:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm3; bh=LTToNkOpjFm9Xd5yT3X8+0nSvr
        ox77c+IewNNUOJa8M=; b=C9dyACAJ5K0g0sWptbRmOK0ph71gmjjthWdZCzWoe7
        Fsj56Oo+hoCmCtyHgdbH3Dn0iGgDY25AXMmYC27m+G/lf9H+qu4G3erk8gsoYDnm
        cU9TntC5fHN00rOdDsQUVQ6p/J93ZErv/at3/74Y66+a2GMv43A1oJZIcFM6QCDf
        DMx8zkx/BBWNBnQ+4K3A24aJqVpK9xFTnt9dDju4h5nYerIkHp916WHRQG9ioimW
        ulbnxAPtWnDxRJEPk4BmsbOw6Tpn1cSJsYnN/g+HKD84z9M3jHIz4dxcR8Vu8chO
        0jzxl/b0rD5qnIM7oKt3leHyNT2TPB3oq1fX0GTdzrHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=LTToNkOpjFm9Xd5yT3X8+0nSvrox77c+IewNNUOJa8M=; b=XgFr608N
        VWhPPE1qifCBgQpo0fSrGf6fSsvqmZg41h7dTBMT9DLm8gSaCLxsn7eTM9efUTpn
        XQtnC8hnp8aSqytqoaKqV92/Ie6yWpbdkwV20kQn2Ybq9cCNVd8kprzyTrq3iI53
        y9Q/h/BYsEeuDQsed43e+sJj0oMSGb4/95qUB1KyB06cDo1O0ehIWLu0DZycpdMg
        /pSkcB6SLfRCTi5WBd3MMN98/hBobAZ2oF5GBS20agcdfoDFe8DS1TvTEuptK7Gw
        hwBvWL6+Z4l5nzW3NaSdihZklE/Lrk4v20TRlsdwJsxRHlEKF8jhVAj4SEzhk7jD
        jjhcqeSlOFKDtw==
X-ME-Sender: <xms:hVQcYG1pzkmuWZRsj0zXoMABr-nPxoZl4KeoqwkL8dlhzdOZ8v6hKg>
    <xme:hVQcYJHtDN7pxuCM_yRXYD5bNwA3-7C3mwUQ6BdYax4t8JWAOWF94H560El8pUvCf
    OdkKWWJALKa-Tu9UPo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgeeggdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucfkphepudeifedruddugedrudefvddrfeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:hVQcYO7E_d8tcr8m2JeC516LNG1IB28YSLSZa_Pu6fhCputAfRBasA>
    <xmx:hVQcYH0ZRpK7-cqO6GNMIMkiMdvBHOCtw8BVQlVhZ770RagcpsJyWg>
    <xmx:hVQcYJHsPmTKGPlcDGCJYDMyi2igtVxnCSUDdJN2-3_H-rM3gao0ag>
    <xmx:hVQcYIzh8HtRWOhCFDEBdSK_QZpbQI5HLRgJLeSIPmVSHd2e_C7Xkw>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2DADA24005A;
        Thu,  4 Feb 2021 15:09:41 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] btrfs-progs: corrupt generic item data with btrfs-corrupt-block
Date:   Thu,  4 Feb 2021 12:09:31 -0800
Message-Id: <039c272f2bd6e8e0bb428c8f0b794e61d491aeef.1612468824.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1612468824.git.boris@bur.io>
References: <cover.1612468824.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 0c022a8e..bf1ce9c5 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -116,11 +116,13 @@ static void print_usage(int ret)
 	printf("\t-m   The metadata block to corrupt (must also specify -f for the field to corrupt)\n");
 	printf("\t-K <u64,u8,u64> Corrupt the given key (must also specify -f for the field and optionally -r for the root)\n");
 	printf("\t-f   The field in the item to corrupt\n");
-	printf("\t-I <u64,u8,u64> Corrupt an item corresponding to the passed key triplet (must also specify the field to corrupt and root for the item)\n");
+	printf("\t-I <u64,u8,u64> Corrupt an item corresponding to the passed key triplet (must also specify the field, or bytes, offset, and value to corrupt and root for the item)\n");
 	printf("\t-D <u64,u8,u64> Corrupt a dir item corresponding to the passed key triplet, must also specify a field\n");
 	printf("\t-d <u64,u8,u64> Delete item corresponding to passed key triplet\n");
 	printf("\t-r   Operate on this root\n");
 	printf("\t-C   Delete a csum for the specified bytenr.  When used with -b it'll delete that many bytes, otherwise it's just sectorsize\n");
+	printf("\t-v   Value to use for corrupting item data\n");
+	printf("\t-o   Offset to use for corrupting item data\n");
 	exit(ret);
 }
 
@@ -896,6 +898,50 @@ out:
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
@@ -1151,6 +1197,8 @@ int main(int argc, char **argv)
 	u64 root_objectid = 0;
 	u64 csum_bytenr = 0;
 	char field[FIELD_BUF_LEN];
+	u64 bogus_value = (u64)-1;
+	u64 bogus_offset = (u64)-1;
 
 	field[0] = '\0';
 	memset(&key, 0, sizeof(key));
@@ -1177,11 +1225,13 @@ int main(int argc, char **argv)
 			{ "delete", no_argument, NULL, 'd'},
 			{ "root", no_argument, NULL, 'r'},
 			{ "csum", required_argument, NULL, 'C'},
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
@@ -1244,6 +1294,12 @@ int main(int argc, char **argv)
 			case 'C':
 				csum_bytenr = arg_strtou64(optarg);
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
@@ -1368,7 +1424,16 @@ int main(int argc, char **argv)
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
2.24.1

