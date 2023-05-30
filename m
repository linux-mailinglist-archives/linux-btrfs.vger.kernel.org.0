Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6C4716D70
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 21:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjE3TWb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 15:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjE3TW2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 15:22:28 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6FEBE
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 12:22:27 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 41F063200344;
        Tue, 30 May 2023 15:22:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 30 May 2023 15:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685474546; x=
        1685560946; bh=oxOpKZIgiUEqMlhhAEMBgs5T3zfzeRLNE2C9uBIHBrc=; b=X
        Ymg3LWdhBs5E81psRBBErkT50RHZvO0xtv2YklVxxkgMLJBb95UC9BvogCU1CQnI
        WBjmqSmEHLcOe3rnjsT1SMxwZ2DhNcLqlGHDfZUWC6gDi/OKMX9XT1KHkh03r+fu
        hmEpl0wNiXpzjyDJMagTdvvWO/kTFV8/e9gU5mgRO02rW40Jqz7FSFK/oG/6ajc1
        06X8m14p+pVVfIL3952jEGtOQyg3HlrdS0ztRe6Z7Yq1tB6qvc2AIJZwnri4gBtJ
        DJ6Vv5R5URMPPLkH3THpJKcUymvQHVcWn0Q7ib7qSHo/KiuYCYoxwG+OgBFl3FyW
        xhmv66rrtRUAQcPuxW1ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685474546; x=1685560946; bh=o
        xOpKZIgiUEqMlhhAEMBgs5T3zfzeRLNE2C9uBIHBrc=; b=ec1KJIC5B3H+FdgaZ
        7dBDyDbfKqbqs6gfLAFO4JRdNGaAieRm/v8ylfhbqY3IXcjpk77/jkIvjUF1DLlq
        S/FWaCXyxZyf5FRB2L3IBAArjHlfT0csK+6F20H5rTlz9tU67Jw4Jo0rbsYuC1BQ
        oFU0mQdm3JDvi7eWEb3MKHY6zjXwu2Fkrv/GarnLQwN4DzUH9tYrAGefBXEBNUh4
        K76pMpPD7kgY0Am5tjAs9P+v2JprCHkhAgRU67Zlx/0gQbpdJ7OoHsU5dEUAuxum
        t5B4XCBgaDwKqG+QYeyRLsCujqcxVK0zJ/JT0+eGHtXTSVW8g3fQ1uSKhe1zmzK6
        lRN9g==
X-ME-Sender: <xms:8kx2ZPocK8maNfy53tHc3B3v3T0-OfoqjPSteEMYP9TK3LufeHOR3Q>
    <xme:8kx2ZJoO0i3pGH0L7xtKnGX5GZJj8LSUtrCBW5J-k-xSrR8XBF_hK7N0t2BmQJekM
    LRCRnaGFaV_XVcLSco>
X-ME-Received: <xmr:8kx2ZMPr5jSXTlxafagtATkvaSRqS3ZVXEHLZLztqBkntte3ynaSZobp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:8kx2ZC4Ay7QlKmW2N8W3UYqKNKN11PfrJjoUTlZBPjK9UqnyoXxD9g>
    <xmx:8kx2ZO4rRKeWoOMGp51L3nV8ovYIEq8zHdX8JX013iAFD2qM_ottkQ>
    <xmx:8kx2ZKgkzdvrfPeHEpphYGOrk76TjA34jKKj1HsWo5ob0mUEK8IX3A>
    <xmx:8kx2ZDierpbiqgzl795vCDIVijx4RjhL0w4T8PRbbKXIkFd8mquTlg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 15:22:26 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: warn on invalid slot in tree mod log rewind
Date:   Tue, 30 May 2023 12:22:08 -0700
Message-Id: <ab57e130bc466300efe32f36e623e546e4cfa85d.1685474140.git.boris@bur.io>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685474139.git.boris@bur.io>
References: <cover.1685474139.git.boris@bur.io>
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
 fs/btrfs/tree-mod-log.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index a555baa0143a..1b1ae9ce9d1e 100644
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
@@ -693,6 +697,15 @@ static void tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
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
@@ -701,6 +714,12 @@ static void tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
 			o_src = btrfs_node_key_ptr_offset(eb, tm->move.dst_slot);
 			memmove_extent_buffer(eb, o_dst, o_src,
 					      tm->move.nr_items * p_size);
+			WARN((tm->move.dst_slot + tm->move.nr_items - 1 > max_slot) ||
+			     (max_slot == (u32)-1 && tm->move.nr_items > 0),
+			     "Move from invalid tree mod log slot eb %llu slot %d dst_slot %d nr_items %d seq %llu n %u max_slot %u\n",
+			     eb->start, tm->slot, tm->move.dst_slot, tm->move.nr_items,
+			     tm->seq, n, max_slot);
+			max_slot = tm->slot + tm->move.nr_items - 1;
 			break;
 		case BTRFS_MOD_LOG_ROOT_REPLACE:
 			/*
-- 
2.40.1

