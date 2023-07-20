Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6137F75BAEB
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjGTW7B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGTW7A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:59:00 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7019092
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:58:59 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id DDCB55C0166;
        Thu, 20 Jul 2023 18:58:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 20 Jul 2023 18:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689893938; x=
        1689980338; bh=trt/YrbFZw6OCOYfDoE31H8ek+KPH08PsZNOggaQD2w=; b=S
        pnosM0VFZE6tJOUEQgPhV+CEFyF/iICm/O/QudS/0WLStbrYrKARSsQ8PjSS14i3
        hU5899b45l7cczSvZSK8qzMv3xNmxAmdqD8FrH9R/wiEX3nFX7Z3y/eiVoTUGV9t
        NGUrmhSLUa00YItyJABZjiPkRtZqptQfVM50qne1qoTOVdGxGRlc22UsLnUOUrxI
        EMq3vENIVNJb2hvI6/8zoYM3RFUkho/iIa5AegxYrXxtLEzAZtsw32s83fq4ZRQo
        f4OhAJd38Wap5J9QteVW0DxOnK7K45pKR5n0S6ucsvAYB9ONE7B4lUJdcIxbxw/7
        QttQ460QqxQijPv0U0y8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689893938; x=1689980338; bh=t
        rt/YrbFZw6OCOYfDoE31H8ek+KPH08PsZNOggaQD2w=; b=tK6WOPVBvT4m/QeCg
        3V9icY+JHf+E4o9kz5RVRk+KrTUO5u7FfjCj/aTToYrSSOkYyqyICoCW604je7ac
        Lik0/4IDaRhYeNOD8+tCFpV8ZK2+2W28JV1PdswZJdxF3olOdEy12qVbu5Bb48Ty
        sViFXuobFybpjSFVKeCXaYaMh+z8Dmrns74nNCWDE2gmjYR5BPI/ajYd6trr7xJb
        TjW3ZOTHby5OvonfJZQASw3eM0a/DpQVcIVh9+jWb48JsU86wWPf5FNXHJZFUBFR
        E/NOZp0g8GXGtSxrYfI66E20G48U1X024lsugoMiVB6MMP4R6FcydtfTX9TBwB4j
        3GtJQ==
X-ME-Sender: <xms:Mry5ZFSQN-P9wZYMKarWyxh7FZ5A32bt24u4K4ljEjYM9xbZdGu-vQ>
    <xme:Mry5ZOwHutcMcM3hnIXveguZpXXnYlj0IDKZMre5AXtDnNWuV4csh7vJlMSas6NmV
    -HzvwGbdN9cCRDJYnA>
X-ME-Received: <xmr:Mry5ZK2_Q-rKZ0rdNCaXpiF02O1eXqHP58rn5BEpIIxmZ9Ae9anBg3DhBL3yzZgqC8Fhn2UTQPlVfb5dvEEUOVACRfo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepleenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Mry5ZNB2bZscZrsIsYuVlgGaOd-hfz8teZ4tVykY8AiZtV4B3e5gPw>
    <xmx:Mry5ZOg6Xqrsl4rs11jfX6kTKwRIA8MP-IbhcThArajMOajsime_kw>
    <xmx:Mry5ZBoh0jEW9HPW0WqAYCzD4F0SnSwQ4eQxqXHuNypfNcmA9reJww>
    <xmx:Mry5ZGJFFpZJaJNLbIl92uTH17w_WyPVbmeVKF5YLhYvLRBeqY6GqQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:58:58 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 3/8] btrfs-progs: simple quotas dump commands
Date:   Thu, 20 Jul 2023 15:57:19 -0700
Message-ID: <b029594bfae47e593076dda1724494a67dff44de.1689893698.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689893698.git.boris@bur.io>
References: <cover.1689893698.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

