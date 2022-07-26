Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEE7581B41
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 22:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbiGZUmt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 16:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239950AbiGZUmp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 16:42:45 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8128137FB2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 13:42:44 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id DD2F25C00E9;
        Tue, 26 Jul 2022 16:42:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 26 Jul 2022 16:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1658868163; x=1658954563; bh=YQ
        E1as417hVaN/9yuDu41+GmAoAztRgRgECFyP+bmH8=; b=hG78etout3n4bNnDAk
        FwANWggoR3rNCtOuOx5kJRzYY5zDTwL7nJv/Ci7NsuWFwazDfUoGyI/IgpZ7Dpho
        MSZtfQkMJRcAr68ZPHH6LXrrvpJoCG3Ic0rJBNmct90zYTIROUccGFq9c4MN+Loa
        FtR3re/YRsy0uNm4ZqvEzewu8p5IoFfzQlPx/ql85iAxrn5A1lw1D8SDJnTQlsRU
        gnNMJZcCTczeKYLr8oYGBDIpuqVzmaM/yJQfnRYTXPWn/xyc3F0HOiV6E+oRvZ0k
        eoKKOasA8y5JwHsUEpHqW/wCSgp7oWM+UXXOngo3DLswzlZ8+gQ+ICpMXRqpS5a1
        MisA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1658868163; x=1658954563; bh=YQE1as417hVaN
        /9yuDu41+GmAoAztRgRgECFyP+bmH8=; b=3DAfkFG0/JN+SsY6h/ChNGXAiRjSf
        SU30wjPkpy4z63HjHgafdggRRA5kO/XybYfCIiIqRbBsBnlRdLq33IRFDsoJfXaJ
        c9R6nbYkCE/i8dEXGkQFWERLJho9dDeWac/cD93Hsrzkyzvkh7ZbhToj23G8N+YQ
        lKryC/GydbGIPU43OPwg8rqilM2q8B7i3RHPV3x6mL7MFB4ai+IDn4HdDFJ5UKpI
        FviEDaN839+YmKXL4yIRQmUSRMXs6vh+UQjYKur159bWOqhYhsuh3ZxS7gIs2V11
        saKl8X3u6gyDDIShADV/QQjRJgXuxLnsmkGnn4a/iGPXeWc+ZqO85/LPw==
X-ME-Sender: <xms:w1HgYgMhCY_Uz1pKeNBkj8mobqOWzp9AHSN-O4_pQ6J9Uu5kBy_Pkg>
    <xme:w1HgYm_cRWthCkbB4meoPaHSbhoE3D4PuGdduJUBEjqUTQO7PuWwjQK1OWMkuZpSZ
    _MwFP6bnx2mV47YBRI>
X-ME-Received: <xmr:w1HgYnTtfuC41lt4Jj0SXoOWcPuB_eWDyxXh66PRnY-XJLdNI1Z0DYPYlB-l-QOAl9vL20TZiN3m40y4lZzXzNYZv_AI8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddutddgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:w1HgYou-NGN96b5F3_F1t_EcEwcJVIfwgcgCra4avbUDopEQWlPRDA>
    <xmx:w1HgYofHDQ_WF1DcGRXXqJOpvT62_sW-FTyUn6FOZXFw59xgaUTHQA>
    <xmx:w1HgYs3ae03dMKcnqvExqjsiEjcc1ftToal3aUZBO3495JkYic0CFQ>
    <xmx:w1HgYgnF6Es2Wy5ELCrYp8ooAHbowWYXV2TpRJeJwZ4UO1-qbnULtg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Jul 2022 16:42:43 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 3/4] btrfs-progs: expand corrupt_file_extent in btrfs-corrupt-block
Date:   Tue, 26 Jul 2022 13:43:24 -0700
Message-Id: <201580699f460cb985849a71c98ff7299ac33cd1.1658867979.git.boris@bur.io>
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

To corrupt holes/prealloc/inline extents, we need to mess with
extent data items. This patch makes it possible to modify
disk_bytenr with a specific value (useful for hole corruptions)
and to modify the type field (useful for prealloc corruptions)

Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 btrfs-corrupt-block.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 225818817..0c5a09298 100644
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
 
@@ -753,13 +756,12 @@ out:
 
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
 	int ret = 0;
 
@@ -792,9 +794,17 @@ static int corrupt_file_extent(struct btrfs_trans_handle *trans,
 	switch (corrupt_field) {
 	case BTRFS_FILE_EXTENT_DISK_BYTENR:
 		orig = btrfs_file_extent_disk_bytenr(path->nodes[0], fi);
-		bogus = generate_u64(orig);
+		bogus = (bogus == UNSET_U64) ? generate_u64(orig) : bogus;
 		btrfs_set_file_extent_disk_bytenr(path->nodes[0], fi, bogus);
 		break;
+	case BTRFS_FILE_EXTENT_TYPE:
+		if (bogus == UNSET_U64) {
+			fprintf(stderr, "Specify a new extent type value (-v)\n");
+			ret = -EINVAL;
+			goto out;
+		}
+		btrfs_set_file_extent_type(path->nodes[0], fi, (u8)bogus);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -1487,9 +1497,9 @@ int main(int argc, char **argv)
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

