Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892B871F245
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 20:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjFASqR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 14:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjFASqP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 14:46:15 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D42C19F
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jun 2023 11:46:10 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 668B15C0183;
        Thu,  1 Jun 2023 14:46:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 01 Jun 2023 14:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685645169; x=
        1685731569; bh=5CHXhMgwNkToy0tRiFXiQGbxVT9zr3YjUQTkSEny1v0=; b=i
        hO40Rs5kSyINOwYebgIdScVCd3irIdh0AylRJPC6J7eLGQI1mY04jZrEF/Akpk8w
        6HHHnXOM58rvnw0prb7Xp/xsTWPbAQIxfIY3eJD+vlg/d5xL8FXElk8/ZVC9ABap
        L4mS1JzvqhvnvbxZBZV18+Jn4NLatU59XLM9djU5dEW5FryeFrcBnbaWIm7HijxG
        qscH5iJMKA8lMpRpsONqPnRRl0BQ2owPZHLZbHAhFgpVfKw+kPj/6zZUTBmkzqKs
        LCuigpzAJkA1iFDvCqsvqfuWWteabYIqee8PCa2acw9bAjmaLplYEwJNcnUuvYjl
        G1ZcqvYaSDdwnnAXX7j5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685645169; x=1685731569; bh=5
        CHXhMgwNkToy0tRiFXiQGbxVT9zr3YjUQTkSEny1v0=; b=viQKvAZZFbNfytv2E
        qa6fWnyo+CeexXLXX1nlAIl9UDbraQYGtdI1nB1n7IoZVE4qugCijnYl8ut0ea+9
        AqDo23T3XGG2zFaNOAQzNvdFMhDNAj45TeDXYwGRs92hsohvc8Hd10DBfGZVJIfI
        tp2Ot3t2K5mp8m/l9FAQZRJ4rmmmXR2lLOUz4zJFXZ1RR88kf0IsPc7s9QaeBcSh
        CJFHZn5rCj9xxeVmd54+JBrqnDJKAVte9JMS06hnaI3+WD0FP6YlcugqDYZ28BR3
        8VD+Te9OCFivb87K5UL6GGp2egJvqWbzDrLhUMj0u7BYAqSXmOY1Hsht2tpM/urV
        YVlOw==
X-ME-Sender: <xms:ced4ZIFAtnMj0tnBsMX5BvKGjJAsqPToqgtvAFZXckqEKD5iE0SUjg>
    <xme:ced4ZBV5b5-zCTwawb_Pcn03MTslLkVdD3eI6NwqzYpvTWuN5qqBnM_vxspv3eXFh
    gCVZHcTAmzMB8ynfzg>
X-ME-Received: <xmr:ced4ZCLE-9V57vDgwjqEYhVrH3ywdkB-NgErsqBT70yz9ffs_TquBOD0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:ced4ZKF6pN4WgC_c---RdsbYDH89RoeNq72h9yzhpQS2gBN1ei2WjA>
    <xmx:ced4ZOWg5HjApFPlPtds7ajNP2nfEH2wmTpsFbcFo-1jePAr5nhQBA>
    <xmx:ced4ZNPb6EsszUZzyH-CFjHkq6HL4Tz0RyeGQtWzDguXle6SF3ULBQ>
    <xmx:ced4ZBfZ-a5a7XC0a5x45M--0OpMtse--2iu3P72RDzsTlouq0nVrw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 14:46:08 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fdmanana@kernel.org
Subject: [PATCH v3 1/2] btrfs: warn on invalid slot in tree mod log rewind
Date:   Thu,  1 Jun 2023 11:45:53 -0700
Message-Id: <bc3d9ec0aac7a1514165170c5fb73ed8f5d3a68b.1685644887.git.boris@bur.io>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685644887.git.boris@bur.io>
References: <cover.1685644887.git.boris@bur.io>
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

