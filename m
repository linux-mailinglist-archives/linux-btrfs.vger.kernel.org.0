Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C8D7B0B43
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 19:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjI0RqD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 13:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjI0RqC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 13:46:02 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F998F3
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 10:46:00 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id BFC003200930;
        Wed, 27 Sep 2023 13:45:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 27 Sep 2023 13:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1695836759; x=
        1695923159; bh=OBPy6RP/cUpyBOQtJlvx2CyC9ypyqFkqScJcquhrODI=; b=V
        t1TpoeamWKEkJsSSfA0U7oNjXYLO/x8endlrBGe9+t905/8Hm4SmZPUJB3qWI1Rd
        Qh9ILgRwJ+/JLBOffgbc3FSfrP8b4jE++93qI86lQcMBvGUIoPMAmIXTAR+TYi0h
        UXWazI+BSX/tbIMbKivCsGlxgNEP8h0E2Gap+8cbAvTm0a92uDKoD15UyR1k4EnZ
        TqfWhgXbxGzFMrqO5NZV7CCR5ZDTl/SMB1y0KTHgALxGnrT1vcgczTel1l7en9ZM
        73f9WQmZA4Fqz27Ym1Fnd63PyOeSGitjtjjXNyxgX4i160yjVXYyOcKr2xj7Md5V
        p3Tpr0bmwb5xAiWI0+sFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1695836759; x=1695923159; bh=O
        BPy6RP/cUpyBOQtJlvx2CyC9ypyqFkqScJcquhrODI=; b=G9HXf5utIwVBb8fDk
        EIA+pxYota7tsYteQ95mAKxxDSMF9XHFNMtsuhn4TQ2ARliKcasSlbvSPKgjA3hU
        t+oDj5rydFtO9IFqUgT2greZ9J2XCRfHgAINmNZERxN66v0iLBfjd4ahrBdXPBEW
        ghIzRCWcxQJYLqIbv1Q5I1iW9Czyw45NTIUV40ZJNWBWp2n/p45XKeWhE83kNjMp
        BgpMFI8SPK4tLcZqGWKOP0BXMomGagWRZomrt1K1zdBYeQqrkN3KRIwypzJrNeNS
        D2ciCzOst42JDyjwPaGmsbrMSXvTiTRL1jOSmbkk2Mzxy2eogfXi66OuF2PG78kB
        yjFFw==
X-ME-Sender: <xms:V2oUZZPgTti66JfNUlnOaCSrk8GvRVTme3CWKE1YOZmguaUD87ZPOA>
    <xme:V2oUZb_M08DQlPj568Qs15LzcBuoogm5HijPzPSomwNJFeQUgnUSBB9CB-H_ChZE7
    oTcYQHuiiE-YiBjWCs>
X-ME-Received: <xmr:V2oUZYQflr24bHz08Zr5YLuagfyfwfxglSwO_Q2PR0IT1zA4Fg1PhjnIJ1tzcqc8pXihHvtM5olsDPqFai6LAIIkjWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdeggdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:V2oUZVtvz2MyBtaTopDO7X9uCmJIwS4KZEZqC9fWBc8Q6BwZYrFVHA>
    <xmx:V2oUZRfwhau0G69iUda7ms7Iei3kIPmiWjQrA0nxOyFrxcYTjf7K-Q>
    <xmx:V2oUZR2A1iVOdhFe2q8ibLjre8iOFhIjmPhbFPx8G_618B5P_qpsGw>
    <xmx:V2oUZRkpTmBTR6Fr9U9Hp9YYBQyGAc8UPl-MxD3UwuU24Gqc22D_XQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 13:45:58 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 3/8] btrfs-progs: simple quotas dump commands
Date:   Wed, 27 Sep 2023 10:46:44 -0700
Message-ID: <a725ec88366532eae2627e5fb58ad68a02e4e902.1695836680.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695836680.git.boris@bur.io>
References: <cover.1695836680.git.boris@bur.io>
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

Add support to btrfs inspect-internal dump-super and dump-tree for the
new structures and feature flags introduced by simple quotas

Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/print-tree.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index d7ffeccd1..666664868 100644
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
2.42.0

