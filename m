Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901DB71F26F
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 20:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjFASzc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 14:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjFASzb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 14:55:31 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8D9137
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jun 2023 11:55:29 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 64B395C0099;
        Thu,  1 Jun 2023 14:55:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 01 Jun 2023 14:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685645729; x=
        1685732129; bh=rgYkjvhGO0ec+7Yyts/bb5lecwPJhTMCitNk7LbLCCo=; b=T
        3IT6CrFXJkhqt/LhPLxE3dKF+Z20LSviIUJIPk4SLYJcyl9gS1gH5W8t09ZbDHmB
        0HIEQ9GhmEG7ewf9XrvWSzcWcFILzWAMpIhBD+yIGqE5xGDUELEbKS1PSfVsUqAs
        D3WQHjNLOXODnOm4VzRQNLBtBVdhOv+b0Eg2yd1YFIhKP79oVhyt90wMh8cOU7hR
        upK6Uks2l7gSa9EfLkVuucNOcR7LPSAAAbMlAUaGowacrlFpmo9s/0t4N1T7T9m9
        TQ6+867QP+U2bZsAzyoW8pRcqr9vRdsqA8Ir8QxxoCjD9H+UllfJyVJE6JRyQCWV
        CMF7AeGVr5ozzJv2YmQdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685645729; x=1685732129; bh=r
        gYkjvhGO0ec+7Yyts/bb5lecwPJhTMCitNk7LbLCCo=; b=ZPx5EZ+fnEWi++S5j
        xkPNuaJBQrWxsV82IcLrMC4sNP54f9gJPQwKWTeVEgcsNvRHWat8lYH+hGt138r9
        lO2fgz8WCic4okt67HjOw3cNYUXJcRx9WuiXQwtgbGIXb3pDCDSGCqMnOgyHtKdZ
        TYOdYMRPsrtI2p017ABfZ7f/NJOaBX+hk6Eg+1Y2cUg/Qg8WRRcmKeX3SodHgXwq
        W9BW5Vl3j4w+df4rkXTTlXZX+6oGoOGZXMa7ORowtGT3p4c6LvxkdgxOZ8rp9Cai
        dZbu48NbxDVpJEODmqSvdGs44RLmiNi+cJzb+MfSVqt0gWqR4YMS5YagCJYjvYg1
        3dUyg==
X-ME-Sender: <xms:oel4ZNE7CPoUWUU-O24SxREmcH_QrZV0FnNLHkQy8M5qrqrpgUzTcQ>
    <xme:oel4ZCVa4YVumTQPIMSwk5kZWaqNTclgZgYelHi0CR6Nz7SoJMwtRpeHlb0IV55zp
    5Z85Whh-HZLtL1dFYY>
X-ME-Received: <xmr:oel4ZPL3bJ-0hNOZyCvuPVKuxcUXbSVE4jOnRAYd2yqxcGVjwBGeJh9v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:oel4ZDFqJHzukpw_IRBaGtyQ0Ul4Jbp_rO7EBln0lrrA-4HzklczSA>
    <xmx:oel4ZDUBWTI_Jgy14e6T4INwGhG_bJ3cm4VWVQ5eTa1v_9s1eui9tA>
    <xmx:oel4ZOO9vfoRbWzr4gUpK_c0_9BptSVQjkOBXccjNEtqRK6s16w1ag>
    <xmx:oel4ZKcqEoLcvcZlfUU8SsRM8nB-xpajAVxSSI1zelB9Fglt8Wa4RA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 14:55:28 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fdmanana@kernel.org
Subject: [PATCH v4 1/2] btrfs: warn on invalid slot in tree mod log rewind
Date:   Thu,  1 Jun 2023 11:55:13 -0700
Message-Id: <742a0f5e01de22aae0ada9504834b0e5e3177349.1685645613.git.boris@bur.io>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685645613.git.boris@bur.io>
References: <cover.1685645613.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 fs/btrfs/tree-mod-log.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index a555baa0143a..157e1a0efab8 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -664,10 +664,27 @@ static void tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
 	unsigned long o_dst;
 	unsigned long o_src;
 	unsigned long p_size = sizeof(struct btrfs_key_ptr);
+	/*
+	 * max_slot tracks the maximum valid slot of the rewind eb at every
+	 * step of the rewind. This is in contrast with 'n' which eventually
+	 * matches the number of items, but can be wrong during moves or if
+	 * removes overlap on already valid slots (which is probably separately
+	 * a bug). We do this to validate the offsets of memmoves for rewinding
+	 * moves and detect invalid memmoves.
+	 *
+	 * Since a rewind eb can start empty, max_slot is a signed integer with
+	 * a special meaning for -1, which is that no slot is valid to move out
+	 * of. Any other negative value is invalid.
+	 */
+	int max_slot;
+	int move_src_end_slot;
+	int move_dst_end_slot;
 
 	n = btrfs_header_nritems(eb);
+	max_slot = n - 1;
 	read_lock(&fs_info->tree_mod_log_lock);
 	while (tm && tm->seq >= time_seq) {
+		ASSERT(max_slot >= -1);
 		/*
 		 * All the operations are recorded with the operator used for
 		 * the modification. As we're going backwards, we do the
@@ -684,6 +701,8 @@ static void tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
 			btrfs_set_node_ptr_generation(eb, tm->slot,
 						      tm->generation);
 			n++;
+			if (tm->slot > max_slot)
+				max_slot = tm->slot;
 			break;
 		case BTRFS_MOD_LOG_KEY_REPLACE:
 			BUG_ON(tm->slot >= n);
@@ -693,14 +712,36 @@ static void tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
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
+			ASSERT(tm->move.nr_items > 0);
+			move_src_end_slot = tm->move.dst_slot + tm->move.nr_items - 1;
+			move_dst_end_slot = tm->slot + tm->move.nr_items - 1;
 			o_dst = btrfs_node_key_ptr_offset(eb, tm->slot);
 			o_src = btrfs_node_key_ptr_offset(eb, tm->move.dst_slot);
+			if (WARN_ON(move_src_end_slot > max_slot ||
+				    tm->move.nr_items <= 0)) {
+				btrfs_warn(fs_info,
+					   "Move from invalid tree mod log slot eb %llu slot %d dst_slot %d nr_items %d seq %llu n %u max_slot %d\n",
+					   eb->start, tm->slot,
+					   tm->move.dst_slot, tm->move.nr_items,
+					   tm->seq, n, max_slot);
+
+			}
 			memmove_extent_buffer(eb, o_dst, o_src,
 					      tm->move.nr_items * p_size);
+			max_slot = move_dst_end_slot;
 			break;
 		case BTRFS_MOD_LOG_ROOT_REPLACE:
 			/*
-- 
2.40.1

