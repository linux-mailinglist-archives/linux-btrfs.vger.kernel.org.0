Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314D3578D5D
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 00:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiGRWNW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 18:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbiGRWNU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 18:13:20 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDF531913
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 15:13:19 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 078965C0174;
        Mon, 18 Jul 2022 18:13:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 18 Jul 2022 18:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1658182399; x=1658268799; bh=ww
        cT/havCH3A+wPQ+zCgxMtFb1NLQqhsio4ZZc8u9hY=; b=MxOoyRXKf0aQcf+sxf
        b5D+S15wz6e8G9QQzioNIs3xxgdQJTnlefk8Rz+2jgQuuFNOc2RAB4k/0QAHm3pH
        Ll3swaKFPbKa6S0CjY9jI6c2Ah2SE1EtMbhHUpe6DVSFiDkeonyL9cSEr8uB8nlT
        iLQJvt3QqWOrhrSgHN6bwJSaSvG2wzRlok/SFIuCmTILCrMg0qZ4i3K+jJOVWmAR
        RbtsHn0RPF+wmBhTtvzFpHN7tK+yIPGLePZMjonV7j9vaucLG2RzA78P68XhZDfo
        mGOG2GaH+RwRYf7vlK0pmwdAFxCy6ZzL1KQpR1gmn5mNfEXamk7vzl4XdubxB/K4
        ZXLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1658182399; x=1658268799; bh=wwcT/havCH3A+
        wPQ+zCgxMtFb1NLQqhsio4ZZc8u9hY=; b=VFNcZJkfF+Sg/+uYiAwe700vUBOLW
        TLe+S0Zq07P3MMOqMo2/sRZ+m7Y1T6BaqQtNkIW3TUTRf6SA+hhnhugJJvAmHkcY
        86zQS72NULwK1Wpgm+IIhepNYI6UdTdLdwoE+y+Euo0ufFCZCTGZkOiBrvX6Qq61
        k4vejBOoI9ARsPuACihQ+gHjZD1d7FybPiStjlZN6p7dcLEfib6dkqclx767ACKb
        N+lb1FoXd+rypG4zXhnqfQ9cIJU0DTP1Dz4zfjWVUO67EflzUH1NK09Jt6XwaDov
        L63qnvBoMTZ+8LPiDev0G7jFBVLopwMA62IwXcCG0f+ftJhDlP4qTqG2Q==
X-ME-Sender: <xms:_trVYjpQTpKU4A1h978nBsYJCjfX5dIvvK-140puyELWrRb7TUWowg>
    <xme:_trVYtpg2jDo3i_RmcR5kd0a9z3fIAc0i0pUw81g_baHIGF7TVZK7OHFh4JHsyDOi
    NtE2d3G41PaIDtst7E>
X-ME-Received: <xmr:_trVYgNxV0xL--iBMrdIhMusCj6ppuVw28OH9u0gTMQ4K9ZgPad8fKMOna_I8L6xn0Yk0hE-TMJCBt7lAxhEjuk46F2ylg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudekledgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:_trVYm48ax4a_nw_HGU55-1yEXYMnmfjgaaosWzt2b_10TrE9MPTPg>
    <xmx:_trVYi5Tn6FGeamF5PO0rJnwzeFDM--dWeOgUy-ha0cRzRl-agtokQ>
    <xmx:_trVYuha4AgBixTu8b35ZMOZqRFKO5WlamLDUEN_rhLg9HjORoiUmQ>
    <xmx:_9rVYniLMoFryJhpHAnF5cvLuL2huC3D-usV4Becj2bQvLz3SMVX-w>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Jul 2022 18:13:18 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 3/4] btrfs-progs: expand corrupt_file_extent in btrfs-corrupt-block
Date:   Mon, 18 Jul 2022 15:13:10 -0700
Message-Id: <959164e11c888f87a5def699f4f5ec209b223a4e.1658182042.git.boris@bur.io>
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

To corrupt holes/prealloc/inline extents, we need to mess with
extent data items. This patch makes it possible to modify
disk_bytenr with a specific value (useful for hole corruptions)
and to modify the type field (useful for prealloc corruptions)

Signed-off-by: Boris Burkov <boris@bur.io>
---
 btrfs-corrupt-block.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 225818817..50e2ebcba 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -308,6 +308,7 @@ enum btrfs_inode_field {
 
 enum btrfs_file_extent_field {
 	BTRFS_FILE_EXTENT_DISK_BYTENR,
+	BTRFS_FILE_EXTENT_TYPE,
 	BTRFS_FILE_EXTENT_BAD,
 };
 
@@ -380,6 +381,8 @@ static enum btrfs_file_extent_field convert_file_extent_field(char *field)
 {
 	if (!strncmp(field, "disk_bytenr", FIELD_BUF_LEN))
 		return BTRFS_FILE_EXTENT_DISK_BYTENR;
+	if (!strncmp(field, "type", FIELD_BUF_LEN))
+		return BTRFS_FILE_EXTENT_TYPE;
 	return BTRFS_FILE_EXTENT_BAD;
 }
 
@@ -753,14 +756,14 @@ out:
 
 static int corrupt_file_extent(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root, u64 inode, u64 extent,
-			       char *field)
+			       char *field, u64 bogus)
 {
 	struct btrfs_file_extent_item *fi;
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	enum btrfs_file_extent_field corrupt_field;
-	u64 bogus;
 	u64 orig;
+	u8 bogus_type = bogus;
 	int ret = 0;
 
 	corrupt_field = convert_file_extent_field(field);
@@ -792,9 +795,18 @@ static int corrupt_file_extent(struct btrfs_trans_handle *trans,
 	switch (corrupt_field) {
 	case BTRFS_FILE_EXTENT_DISK_BYTENR:
 		orig = btrfs_file_extent_disk_bytenr(path->nodes[0], fi);
-		bogus = generate_u64(orig);
+		if (bogus == UNSET_U64)
+			bogus = generate_u64(orig);
 		btrfs_set_file_extent_disk_bytenr(path->nodes[0], fi, bogus);
 		break;
+	case BTRFS_FILE_EXTENT_TYPE:
+		if (bogus == UNSET_U64) {
+			fprintf(stderr, "Specify a new extent type value (-v)\n");
+			ret = -EINVAL;
+			goto out;
+		}
+		btrfs_set_file_extent_type(path->nodes[0], fi, bogus_type);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -1487,9 +1499,9 @@ int main(int argc, char **argv)
 			printf("corrupting inode\n");
 			ret = corrupt_inode(trans, root, inode, field);
 		} else {
-			printf("corrupting file extent\n");
 			ret = corrupt_file_extent(trans, root, inode,
-						  file_extent, field);
+						  file_extent, field,
+						  bogus_value);
 		}
 		btrfs_commit_transaction(trans, root);
 		goto out_close;
-- 
2.37.1

