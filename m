Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D6C75BAD0
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjGTWyw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjGTWyv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:54:51 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A992D59
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:54:29 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 15F255C00EB;
        Thu, 20 Jul 2023 18:54:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 20 Jul 2023 18:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689893669; x=
        1689980069; bh=yxXzITJLZSi2U1bd17s2ssAbaukz5IiAjbxbzGsdVP0=; b=a
        cPa0AzlQOqAN+6tlteC5ebgYmEbqpUhwadNxnkGx8dQqDbS1UAaGeIvOdVLfNQob
        ryX+IJIkE/7hnD6CUCSobmIyx/rG0tZ+erUL0tAcakdMHZRisCULGbh078S/lIsv
        YwWNydkFmqZ+vSI3Ebq8EyT8BR7Gid25NDVFNoiNAB08KH8NiXnQtABiymn/twsn
        6iC7uU8xzFmcy+A/pEthqwNPbOdk/zjywqiv6s/EgFjERM5D8D78aRlxVmGXdk6Z
        baR4opSEQ+0un93MAriqMm8y4NqLV9Ur2FSoIvBu8/3QgSzXahO1km6anrC9BWDN
        Ra4ah2yJ9uCc6EgZBqrog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689893669; x=1689980069; bh=y
        xXzITJLZSi2U1bd17s2ssAbaukz5IiAjbxbzGsdVP0=; b=Q2rSAe3EXl9UiYypk
        DH2ir47zinF7Pxw4nP5m8HQMyu6+rOXdALXcduLWFRRwJB5UsdcN/CStXF2nlQT+
        nl/5LnUHwCkegbnRPtzMNeoVE2ZfigQXu76/pfJp5C1D/Pjs5WxAQTyM3keoZvo1
        YVFIT8aKRzOJqHnCZzwL8yPuSqzKcnCBwVCsuwQ0xkLk3qP8gAKVXiSUJIN1TeWC
        XLo/u+kBrFAslIOQmd1TnISUbyzFiOzQ+iK7zZOlnb5EFnOYpOwjuVbMWPWiXl6r
        2bFNDslkhyJilup4bTCThWNn/W77NLMcU+AQr5LMYXWcoF4BzPcXQuKoxc8f5ZZa
        nKJmA==
X-ME-Sender: <xms:JLu5ZOmgwLmmu6zmiLFLExiM6yai4WESy6HLCEviKYBs9w-ZZqkOMw>
    <xme:JLu5ZF31V9S5ClTDiB6uH8_OtxdAsDh-2tFtQNQfdzqBKMGjuB_2XQ6ebODly2Zdv
    RfXj_BtaO-nCPfk5Ko>
X-ME-Received: <xmr:JLu5ZMpeAT9b6ivKoMRedwOURv8TPADW26E6V1Kb7K0IpyGjTjoYOAuzSQeNfuF_e9ifD1eR58p251FUdmdjwKP1m6o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:JLu5ZClE2uFCj30KzjEQBXdyG_Ogvn7ZbdJnw65mLUmuVMbPxDGa5A>
    <xmx:JLu5ZM2fO-PikHutOrw0oHzJ4dMSGSGDmg9QaBF6K8Dp0LMxqLIcmA>
    <xmx:JLu5ZJvU1-nR6p1pT8j1i_f5Jhb-yO6QeCMNyhdXh9mxLX-VbQ4dyw>
    <xmx:Jbu5ZB_Li0pH-L5cSdaTfzrFpusgon3EurFHnZqN32tNszzHK1ykRw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:54:28 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 02/20] btrfs: fix start transaction qgroup rsv double free
Date:   Thu, 20 Jul 2023 15:52:30 -0700
Message-ID: <69f10fd3df9c695b77331819bd5859266e62d675.1689893021.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689893021.git.boris@bur.io>
References: <cover.1689893021.git.boris@bur.io>
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

btrfs_start_transaction reserves metadata space of the PERTRANS type
before it identifies a transaction to start/join. This allows flushing
when reserving that space without a deadlock. However, it results in a
race which temporarily breaks qgroup rsv accounting.

T1                                              T2
start_transaction
do_stuff
                                            start_transaction
                                                qgroup_reserve_meta_pertrans
commit_transaction
    qgroup_free_meta_all_pertrans
                                            hit an error starting txn
                                            goto reserve_fail
                                            qgroup_free_meta_pertrans (already freed!)

The basic issue is that there is nothing preventing another commit from
committing before start_transaction finishes (in fact sometimes we
intentionally wait for it..) so any error path that frees the reserve is
at risk of this race.

While this exact space was getting freed anyway, and it's not a huge
deal to double free it (just a warning, the free code catches this), it
can result in incorrectly freeing some other pertrans reservation in
this same reservation, which could then lead to spuriously granting
reservations we might not have the space for. Therefore, I do believe it
is worth fixing.

To fix it, use the existing prealloc->pertrans conversion mechanism.
When we first reserve the space, we reserve prealloc space and only when
we are sure we have a transaction do we convert it to pertrans. This way
any racing commits do not blow away our reservation, but we still get a
pertrans reservation that is freed when _this_ transaction gets committed.

This issue can be reproduced by running generic/269 with either qgroups
or squotas enabled via mkfs on the scratch device.

Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 4743882fa94b..bad10712df50 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -591,8 +591,13 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		u64 delayed_refs_bytes = 0;
 
 		qgroup_reserved = num_items * fs_info->nodesize;
-		ret = btrfs_qgroup_reserve_meta_pertrans(root, qgroup_reserved,
-				enforce_qgroups);
+		/*
+		 * Use prealloc for now, as there might be a currently running
+		 * transaction that could free this reserved space prematurely
+		 * by committing.
+		 */
+		ret = btrfs_qgroup_reserve_meta_prealloc(root, qgroup_reserved,
+							 enforce_qgroups, false);
 		if (ret)
 			return ERR_PTR(ret);
 
@@ -705,6 +710,14 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		h->reloc_reserved = reloc_reserved;
 	}
 
+	/*
+	 * Now that we have found a transaction to be a part of, convert the
+	 * qgroup reservation from prealloc to pertrans. A different transaction
+	 * can't race in and free our pertrans out from under us.
+	 */
+	if (qgroup_reserved)
+		btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
+
 got_it:
 	if (!current->journal_info)
 		current->journal_info = h;
@@ -752,7 +765,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		btrfs_block_rsv_release(fs_info, &fs_info->trans_block_rsv,
 					num_bytes, NULL);
 reserve_fail:
-	btrfs_qgroup_free_meta_pertrans(root, qgroup_reserved);
+	btrfs_qgroup_free_meta_prealloc(root, qgroup_reserved);
 	return ERR_PTR(ret);
 }
 
-- 
2.41.0

