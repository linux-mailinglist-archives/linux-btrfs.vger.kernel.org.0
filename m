Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1694D75CD06
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 18:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjGUQEM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 12:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjGUQEJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 12:04:09 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1819E42
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 09:04:08 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 200C332000E5;
        Fri, 21 Jul 2023 12:04:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 21 Jul 2023 12:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689955447; x=
        1690041847; bh=yxXzITJLZSi2U1bd17s2ssAbaukz5IiAjbxbzGsdVP0=; b=r
        unCaYeMvFKLqKY30KKGDuAw9jClB4bAp7z8pynhF5JEGPGbGXzfCQwHYkcPxGSdF
        cgkv1xDnrrlbAjvtLnZrg/5lVkfgznJYrDCyyWZ2DeVljwqvUvYSIPG7Sa01Hl7q
        2k/A8vwTHCKNvFbyclEg2XlpXHvS1NEDYoaJX8LmYCMX9VSrb934QbvSIj1qL4K1
        bFqun4Ypqj3XJERI/iANcyz0TdhYrqLY9KHjpF5j9IhWp9BdgZjF+R3Iz1xYFyy4
        xLmGgOfko/L1BMC63k8HlvRFPCILe28ZMFBfQk06P5duWII01/eyTqRHukksQzmn
        qb3BXl9VJ0a1ENR4m5kuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689955447; x=1690041847; bh=y
        xXzITJLZSi2U1bd17s2ssAbaukz5IiAjbxbzGsdVP0=; b=qsXRREL8oBG0gAz2c
        H43ZbwBVFuZ2zkdWX86QlnajtzuqHk8QN8ceZCQSgRtigNGSOvemfoVZ9hFn5FIj
        mVq07jbl4GwzjZ/YjPBUrJi4sZynaAexfCYRWB+pqBLJBYUUQQeKEdrMrtV8CZ6+
        MVOyeOHGn/Swc+hdcp18gGx5p/vKxUOtsxxDXbgBonoXImdimHLCf4cKFq7FcMVj
        5gp/8ZYoVvAPxDhgx/TykBCU2J3ozOviKYjFq9AzMKPK0UEyIZxgFyOMIHHjanB/
        RSo0K9bNXrJTzKPuh9Hmp4zzN2auQNgj33rLxElXTPxmGw/ZY1zX8ghgjrt5t0hi
        sLA2w==
X-ME-Sender: <xms:d6y6ZEL-sso6pT55P8oNWgDlBOTBzrAU9mGRZv4NFR3uNVRYnrFdMw>
    <xme:d6y6ZEKqcwcdGJ99qHfwP2l3Hh1CBiJIP3MgNRiBWk17IdfPxP1gqbGK01llHw1Fs
    GqAG2HsAYUVPwS8OwA>
X-ME-Received: <xmr:d6y6ZEsibz-bkJUQUHUBze6-NpYHAylJNhxJxH24HtzSUT2vh_hN9FAgC0PRgYc08iGJNlroMtVrJCDyNpTja8NDIzs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:d6y6ZBZoKMdu2-UqsjnpYfR9z646N4iYbdEfeu474ChouryhYURcbQ>
    <xmx:d6y6ZLbZQ172NlHO2Zat1o6J435rnmK89xhvGODPW_r5C0dvpgSxJw>
    <xmx:d6y6ZNDSKyHon2p3A6Isfe2Usp-iqrKUvqrXWQrjt6n2kMK8xE_4jw>
    <xmx:d6y6ZMAdxOUIsFpTfnyAcmzxqge0H9PJ5NRhsOWbnzjNEOLyA0Dtxw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 12:04:06 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 02/20] btrfs: fix start transaction qgroup rsv double free
Date:   Fri, 21 Jul 2023 09:02:07 -0700
Message-ID: <69f10fd3df9c695b77331819bd5859266e62d675.1689955162.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689955162.git.boris@bur.io>
References: <cover.1689955162.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

