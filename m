Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706935768CB
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 23:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiGOVWV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 17:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiGOVWT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 17:22:19 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832C17359D
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 14:22:18 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D9BD25C00CE;
        Fri, 15 Jul 2022 17:22:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 15 Jul 2022 17:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1657920137; x=1658006537; bh=OG
        cj6pi92c+7/MWrwxLT32MNIAclHj9dm+gXu+6GvFU=; b=JfGXhPxL9UP4w5fLDx
        r4hyM1thuTL2FToh3mo2jTUjj/Og5ZXhAkqyZw7ihSOsn36F9qZxrMiEnq5RM9bg
        UWjstgB9GquzxH3C46zbLFpMQANfhPiskCR7Js24cGztqGujgcrpK4Y8DtpZsAjN
        6SmyMFXfC3lDcLGd2MdWzrcHtE4D3VGCMVyvF7+kvmCS/Xq5KGvKfi4pbEM8OMkv
        ECBK/7jdcUuWedveTN55wXBdyyzRXdF7IpCYzG0HQ3GCbrynvqhmgKjcmBuWY3oc
        Cg3YqcntLMqUQ0wBcbigaIXaYYKHYvX89wJ00oCRUS3wGuHVPmcidDqcijfs6nvl
        ZFwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1657920137; x=1658006537; bh=OGcj6pi92c+7/
        MWrwxLT32MNIAclHj9dm+gXu+6GvFU=; b=Co5GGpEKpwUl7uiACJ2VJ6eLDrt9a
        +86PuTCmfCmxoAr9lbubD1/dRvn+88HxG7ABWcuUP1BcL0RXdUnieBCw1dyBFye1
        cta2Pnw1JNy+UE7gGaOVNwym8spUbwoCunXQwhbfigR3L74ILlEkkeKD2Fd1/4h3
        onijBgZBmTdwKnH1QZRiC5C2WvcdHi4YXTss5qA8opRTvmFzxhkjYrZ2RhXaEKLb
        b8lJHDMEREqxrYovE5mGwhj7zY8lDnKACXfAG94wbIm78TmjHRFjMyCoWpFjbnM5
        psaIGRxPyyxXbZu0HpRZU96tmy/TND6j2wObZWf9laMTYiw+xGT2pOvSw==
X-ME-Sender: <xms:idrRYq8tOZdaCvDNx4dephA2FRbp6mQRUJzBeO5eHh6T_FDKR5hftQ>
    <xme:idrRYqvJremQvfolAvnDRGlENs1k80eKWRYNP702CMUo-f2GQvQ6BQ4vu2ctSrtSv
    gKrzQl2KRmtNdjr3ao>
X-ME-Received: <xmr:idrRYgDYMs3CH4rdPtj8GeeUiNDUovm1w2EAhD9yfXQPsqAFkMsjNxeB29X_2QZqrJQdUVtZOPmKMVUeqSN5hstqMXaK3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudekuddgudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:idrRYidkmXHMvFCJM01hEXY5Tz6S5IhcUrV3EDS7GwwrUx3poaqJRg>
    <xmx:idrRYvNygpCmkroSwfKEafmr1RnjAQFrzAPKuPbOpQfG2OLVodWSNA>
    <xmx:idrRYsnfu-0Cj15HNL4TkySbQEl-Wk99WNMGH_Oxw0-tJwkyosVhGQ>
    <xmx:idrRYhX1AmjU54TKUb4hA0iDsuiqZjofTupW4ow4JrqU6eXxJvMWLg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Jul 2022 17:22:17 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/2] btrfs-progs: expand corrupt_file_extent in btrfs-corrupt-block
Date:   Fri, 15 Jul 2022 14:22:12 -0700
Message-Id: <d3e7d721bb98a6643ba243c21013ddfc929ccd12.1657919808.git.boris@bur.io>
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

To corrupt holes/prealloc/inline extents, we need to mess with
extent data items. This patch makes it possible to modify
disk_bytenr with a specific value (useful for hole corruptions)
and to modify the type field (useful for prealloc corruptions)

Signed-off-by: Boris Burkov <boris@bur.io>
---
 btrfs-corrupt-block.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 5c39459db..27844b184 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -307,6 +307,7 @@ enum btrfs_inode_field {
 
 enum btrfs_file_extent_field {
 	BTRFS_FILE_EXTENT_DISK_BYTENR,
+	BTRFS_FILE_EXTENT_TYPE,
 	BTRFS_FILE_EXTENT_BAD,
 };
 
@@ -379,6 +380,8 @@ static enum btrfs_file_extent_field convert_file_extent_field(char *field)
 {
 	if (!strncmp(field, "disk_bytenr", FIELD_BUF_LEN))
 		return BTRFS_FILE_EXTENT_DISK_BYTENR;
+	if (!strncmp(field, "type", FIELD_BUF_LEN))
+		return BTRFS_FILE_EXTENT_TYPE;
 	return BTRFS_FILE_EXTENT_BAD;
 }
 
@@ -752,14 +755,14 @@ out:
 
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
@@ -791,9 +794,18 @@ static int corrupt_file_extent(struct btrfs_trans_handle *trans,
 	switch (corrupt_field) {
 	case BTRFS_FILE_EXTENT_DISK_BYTENR:
 		orig = btrfs_file_extent_disk_bytenr(path->nodes[0], fi);
-		bogus = generate_u64(orig);
+		if (bogus == (u64)-1)
+			bogus = generate_u64(orig);
 		btrfs_set_file_extent_disk_bytenr(path->nodes[0], fi, bogus);
 		break;
+	case BTRFS_FILE_EXTENT_TYPE:
+		if (bogus == (u64)-1) {
+			fprintf(stderr, "Specify a new extent type value (-v)\n");
+			ret = -EINVAL;
+			goto out;
+		}
+		btrfs_set_file_extent_type(path->nodes[0], fi, bogus_type);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -1480,9 +1492,9 @@ int main(int argc, char **argv)
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

