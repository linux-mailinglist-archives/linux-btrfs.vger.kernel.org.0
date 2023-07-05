Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F337491EB
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjGEXhk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjGEXhj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:37:39 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E8B12A
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:37:38 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2A3FA5C0061;
        Wed,  5 Jul 2023 19:37:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 05 Jul 2023 19:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688600258; x=
        1688686658; bh=OFjX3bjDPnhkT8+uIDteh9ld/sNNTfrtbjQipmJdBhc=; b=j
        aUZndJvlFAQuFvCrVRfPh1d8k9GoZMirwALxEPfTTaapAX3BSlTz+IiG/zGdbLdn
        TDi/nvJNdukmu/6e/6JgM8eL7X7Aq4DKt4VLUsoMXW6JIhyfsz0SzY37tUILIB4c
        fbI7VR9D394ymWIRtjGJHwdotdw4NxLjZUxnUXanA67RNQGHSokRsV+AISJjclmt
        6Wihmh7Sg/7VDF80Qj+jaDJGzn0z2IDMA/eTxB0SEdl6kwWUSOEaag1L4eZRo6dI
        EFh/wKMw3J6WLzBgm0crlNRJzr4Fjsmk4iFS3LtIK187pB3pRUzAOBsbf2Oq0Ozl
        fKuesormCBfT4nzAWXrFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688600258; x=1688686658; bh=O
        FjX3bjDPnhkT8+uIDteh9ld/sNNTfrtbjQipmJdBhc=; b=Z5EoPECNvWhJUYCbO
        Ej0aEgRnTqEDlG5gp05hcdqV7v5O3q5ZfNU+8W1lx3TXhQuiHl00L02sVfkVGKBj
        CeRgRkKHqSkhMoE/d2uZ7z0EDzv030KLAvovcu7t3OCIgx4DteZuHWj/uFfq5U5V
        iaoKau78QSz6dAfVV52kt1w0tavbkZDdXxZVAbsyzeWU4NoKuh98C5ajZ05h7Mmh
        fdK2xDWWKb3BIx5/FYHUm93Yobz+Sho9lfojwLdGzW3FHQgbTUlB0SDuIoRVOasH
        yomxiTNjbJDw9i62crqlX1EOSZuG6/wTfYdLx/fhF06bHRQ26uBQx9Xyhndujx27
        r2G9A==
X-ME-Sender: <xms:wf6lZLn3apdPgKUCCDqmHJBkuf7uJUF2SPBR--CTf5yHROfZPgWvwA>
    <xme:wf6lZO3LnacdofbQ_EU8nWm7iJ9WotcyMnq-h6IfFFpeysg4P8YorKHXp2obwAb_y
    YjtHWpLFZSHJlINpH4>
X-ME-Received: <xmr:wf6lZBoaQ58ZxSiljGhhXD5ZIoCYLUPoH9XpIk_r32uAevsBmHpTuEbyFw6R6yHbkRRfENiXnctfBeBUddzheNiZjhU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:wv6lZDnl4PnyXj2_L7SlRmGufYO8z0CWZAuGIU_EzVc8G9hclPHk0w>
    <xmx:wv6lZJ2Tgm0YEfBXR7JPEOr7TNAJ3wCsucXvL97FaME5b_gxZAHv4A>
    <xmx:wv6lZCuE2qydYEJkHvK5GLFIjoVbU3_y6QePH3AEtcb4xTii9LGb2A>
    <xmx:wv6lZG-g60jEmwY_ViXIlp7K4SMPP42iLxYAsi_Fw_Fed2Z9pkgX7A>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:37:37 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/8] btrfs-progs: simple quotas dump commands
Date:   Wed,  5 Jul 2023 16:36:22 -0700
Message-ID: <bed9171118addaf2d70eeaa6854264a1f987dc47.1688599734.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688599734.git.boris@bur.io>
References: <cover.1688599734.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add support to btrfs inspect-internal dump-super and dump-tree for the
new structures and feature flags introduced by simple quotas

Signed-off-by: Boris Burkov <boris@bur.io>
---
 kernel-shared/print-tree.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 0f7f7b72f..7d4e77579 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -509,6 +509,10 @@ void print_extent_item(struct extent_buffer *eb, int slot, int metadata)
 			       (unsigned long long)offset,
 			       btrfs_shared_data_ref_count(eb, sref));
 			break;
+		case BTRFS_EXTENT_OWNER_REF_KEY:
+			printf("\t\textent owner root %llu\n",
+			       (unsigned long long)offset);
+			break;
 		default:
 			return;
 		}
@@ -661,6 +665,7 @@ void print_key_type(FILE *stream, u64 objectid, u8 type)
 		[BTRFS_EXTENT_DATA_REF_KEY]	= "EXTENT_DATA_REF",
 		[BTRFS_SHARED_DATA_REF_KEY]	= "SHARED_DATA_REF",
 		[BTRFS_EXTENT_REF_V0_KEY]	= "EXTENT_REF_V0",
+		[BTRFS_EXTENT_OWNER_REF_KEY]	= "EXTENT_OWNER_REF",
 		[BTRFS_CSUM_ITEM_KEY]		= "CSUM_ITEM",
 		[BTRFS_EXTENT_CSUM_KEY]		= "EXTENT_CSUM",
 		[BTRFS_EXTENT_DATA_KEY]		= "EXTENT_DATA",
@@ -1042,6 +1047,17 @@ static void print_shared_data_ref(struct extent_buffer *eb, int slot)
 		btrfs_shared_data_ref_count(eb, sref));
 }
 
+static void print_extent_owner_ref(struct extent_buffer *eb, int slot)
+{
+	struct btrfs_extent_owner_ref *oref;
+	u64 root_id;
+
+	oref = btrfs_item_ptr(eb, slot, struct btrfs_extent_owner_ref);
+	root_id = btrfs_extent_owner_ref_root_id(eb, oref);
+
+	printf("\t\textent owner root %llu\n", root_id);
+}
+
 static void print_free_space_info(struct extent_buffer *eb, int slot)
 {
 	struct btrfs_free_space_info *free_info;
@@ -1083,11 +1099,16 @@ static void print_qgroup_status(struct extent_buffer *eb, int slot)
 	memset(flags_str, 0, sizeof(flags_str));
 	qgroup_flags_to_str(btrfs_qgroup_status_flags(eb, qg_status),
 					flags_str);
-	printf("\t\tversion %llu generation %llu flags %s scan %llu\n",
+	printf("\t\tversion %llu generation %llu flags %s scan %llu",
 		(unsigned long long)btrfs_qgroup_status_version(eb, qg_status),
 		(unsigned long long)btrfs_qgroup_status_generation(eb, qg_status),
 		flags_str,
 		(unsigned long long)btrfs_qgroup_status_rescan(eb, qg_status));
+	if (btrfs_fs_incompat(eb->fs_info, SIMPLE_QUOTA))
+		printf(" enable_gen %llu\n",
+			   (unsigned long long)btrfs_qgroup_status_enable_gen(eb, qg_status));
+	else
+		printf("\n");
 }
 
 static void print_qgroup_info(struct extent_buffer *eb, int slot)
@@ -1407,6 +1428,9 @@ void btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
 		case BTRFS_SHARED_DATA_REF_KEY:
 			print_shared_data_ref(eb, i);
 			break;
+		case BTRFS_EXTENT_OWNER_REF_KEY:
+			print_extent_owner_ref(eb, i);
+			break;
 		case BTRFS_EXTENT_REF_V0_KEY:
 			printf("\t\textent ref v0 (deprecated)\n");
 			break;
@@ -1708,6 +1732,7 @@ static struct readable_flag_entry incompat_flags_array[] = {
 	DEF_INCOMPAT_FLAG_ENTRY(RAID1C34),
 	DEF_INCOMPAT_FLAG_ENTRY(ZONED),
 	DEF_INCOMPAT_FLAG_ENTRY(EXTENT_TREE_V2),
+	DEF_INCOMPAT_FLAG_ENTRY(SIMPLE_QUOTA),
 };
 static const int incompat_flags_num = sizeof(incompat_flags_array) /
 				      sizeof(struct readable_flag_entry);
-- 
2.41.0

