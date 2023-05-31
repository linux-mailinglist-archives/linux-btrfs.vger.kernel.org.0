Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E139718741
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 18:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjEaQWu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 12:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjEaQWt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 12:22:49 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9DBE2
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 09:22:44 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E06A95C012E;
        Wed, 31 May 2023 12:22:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 31 May 2023 12:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685550163; x=
        1685636563; bh=5CHXhMgwNkToy0tRiFXiQGbxVT9zr3YjUQTkSEny1v0=; b=d
        0C+mwLfyaFEihfiMC3WpXdLKaEkExTBtIWSbEzosR41MDPrKwnts74f0oH/0F4Td
        tJEx5FYX6oe9ce01097DtmzYODblQTXYsJTXMt6HcLoX5ki7zr8mzS0wsvkCmnwR
        /+AiIIzP1xxXi9OucopCIEaDuslUedqXKIPydfjw6st1jSSpQkz+XIbC1VT0o8ef
        KxNiXbZ4gfG7ylhNxH9oy+9VunkElm9tpzPsi1UN/a8qUx24x01Iy32MwazJ3TFH
        2c4cXpDGhY66GTzsA6sBhiEwOGCFtBU+939N2DFS8Bq+sO5NgI8FLHUURcXXJiPn
        VH9BLPk6/A/ga2/+s4cDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685550163; x=1685636563; bh=5
        CHXhMgwNkToy0tRiFXiQGbxVT9zr3YjUQTkSEny1v0=; b=xCbbqtbWM1srka4M8
        AXI9swkpOLuWj9ozBwH73yB3k4hmjOfC90v7KV1m0qH5jUXj5JP64wQCjhVXe+ja
        SMH2kAPj1pYCViasKgSg36WcATodfRTZyAoZ2ttHJU659L9pklUD3C74oNsJ72aj
        Ho94s8hfkus8F3PgqLmu9mJPdcaRQWDNSekiqvy1Je2Ig603bQ4EgrIbac+z+XZJ
        ulPp7kyoZgqaQrJ8/JYJ9mV6Ri5NH9RUde7w0UsJC5si20PDjnLjUdmbmaiRW81S
        5ffsDDz8Vg33QkP8KK6UQTrciFMGaAav2owb3GTA05y6+SjsXuonbc+ECeR39C/V
        6gNGA==
X-ME-Sender: <xms:U3R3ZCEK5zYWNk71bSELbL4PBEdY4sHVT-quSJw4c-_ODs2mYS1Q_Q>
    <xme:U3R3ZDUS2y9JsnBqueHA6znwqjxIrNx8fDCIF-lX1E8km1xV22Rm3WQ0MFHvu1aMW
    BSrmqZGxh9FxYe_s9w>
X-ME-Received: <xmr:U3R3ZMK23ugHFjcxgHUTdWUkMYpbGYJ_2gf5vj21ZUe5U-xDC6H13XC9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekledgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:U3R3ZMGIwToeB_H1bOt94ZDff_6W4MVPUpfkpMwlHkkLtJHuAA5mBw>
    <xmx:U3R3ZIVkdJHrDMW4RrOY3d2ObXO7_Ae_mkRx-MylVaAPIT8wyAjcjA>
    <xmx:U3R3ZPPmYALLZB5Oy0alUd8AnUXt7ab-7SGhfq_ZjZe-4MmoKJcqEA>
    <xmx:U3R3ZDeLHoVef2EnYq1vell-7y_7fBe4L6ZVLcfyBET8ieZhwfxEdQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 May 2023 12:22:43 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fdmanana@kernel.org
Subject: [PATCH v2 1/2] btrfs: warn on invalid slot in tree mod log rewind
Date:   Wed, 31 May 2023 09:22:29 -0700
Message-Id: <bc3d9ec0aac7a1514165170c5fb73ed8f5d3a68b.1685546114.git.boris@bur.io>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685546114.git.boris@bur.io>
References: <cover.1685546114.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The way that tree mod log tracks the ultimate length of the eb, the
variable 'n', eventually turns up the correct value, but at intermediate
steps during the rewind, n can be inaccurate as a representation of the
end of the eb. For example, it doesn't get updated on move rewinds, and
it does get updated for add/remove in the middle of the eb.

To detect cases with invalid moves, introduce a separate variable called
max_slot which tries to track the maximum valid slot in the rewind eb.
We can then warn if we do a move whose src range goes beyond the max
valid slot.

There is a commented caveat that it is possible to have this value be an
overestimate due to the challenge of properly handling 'add' operations
in the middle of the eb, but in practice it doesn't cause enough of a
problem to throw out the max idea in favor of tracking every valid slot.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/tree-mod-log.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index a555baa0143a..43f2ffa6f44d 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -664,8 +664,10 @@ static void tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
 	unsigned long o_dst;
 	unsigned long o_src;
 	unsigned long p_size = sizeof(struct btrfs_key_ptr);
+	u32 max_slot;
 
 	n = btrfs_header_nritems(eb);
+	max_slot = n - 1;
 	read_lock(&fs_info->tree_mod_log_lock);
 	while (tm && tm->seq >= time_seq) {
 		/*
@@ -684,6 +686,8 @@ static void tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
 			btrfs_set_node_ptr_generation(eb, tm->slot,
 						      tm->generation);
 			n++;
+			if (max_slot == (u32)-1 || tm->slot > max_slot)
+				max_slot = tm->slot;
 			break;
 		case BTRFS_MOD_LOG_KEY_REPLACE:
 			BUG_ON(tm->slot >= n);
@@ -693,12 +697,30 @@ static void tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
 						      tm->generation);
 			break;
 		case BTRFS_MOD_LOG_KEY_ADD:
+			/*
+			 * It is possible we could have already removed keys behind the known
+			 * max slot, so this will be an overestimate. In practice, the copy
+			 * operation inserts them in increasing order, and overestimating just
+			 * means we miss some warnings, so it's OK. It isn't worth carefully
+			 * tracking the full array of valid slots to check against when moving.
+			 */
+			if (tm->slot == max_slot)
+				max_slot--;
 			/* if a move operation is needed it's in the log */
 			n--;
 			break;
 		case BTRFS_MOD_LOG_MOVE_KEYS:
 			o_dst = btrfs_node_key_ptr_offset(eb, tm->slot);
 			o_src = btrfs_node_key_ptr_offset(eb, tm->move.dst_slot);
+			if (WARN_ON((tm->move.dst_slot + tm->move.nr_items - 1 > max_slot) ||
+				    (max_slot == (u32)-1 && tm->move.nr_items > 0))) {
+				btrfs_warn(fs_info,
+					   "Move from invalid tree mod log slot eb %llu slot %d dst_slot %d nr_items %d seq %llu n %u max_slot %u\n",
+					   eb->start, tm->slot,
+					   tm->move.dst_slot, tm->move.nr_items,
+					   tm->seq, n, max_slot);
+
+			}
 			memmove_extent_buffer(eb, o_dst, o_src,
 					      tm->move.nr_items * p_size);
 			break;
-- 
2.40.1

