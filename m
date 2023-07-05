Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C207491BD
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjGEXXQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjGEXXJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:23:09 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E160198E
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:23:07 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 498FB5C028E;
        Wed,  5 Jul 2023 19:23:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 05 Jul 2023 19:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688599386; x=
        1688685786; bh=G512oza/F2C2P0WQmOip5mZlVluqNDhNAN1ErLQz+Vc=; b=P
        gXnrSQqio6/CfDOLz2VikQGc7P0m2o+QizMN6ufVXR0WFxmCzMxuFUHI1VAKp/Ft
        JrvBHFQla75mWJS7DWgPZAxdIZ9tp2KXGzF/cwqlPvcaUdQws0iBAncax0wI3kFx
        vTCuy7gfb/Q80VFUVxc5j719St6+/SVmmyKSsPm8OWlRXXyaqFOcb4Kz78wvsHov
        17Nmq8rBOBP6vFLnBvGZUko+cIdrUiRsPDHTCigpUd3Ynq4n5YW5re85C2nDyNmM
        VfSHn7D90g0it7kxuGTp3XPCTYgKNtDobX+RTRZ3UShMj3iBVjpcLqA1CxBzgF4z
        1sGy5l08sDtGrc6G2pcgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688599386; x=1688685786; bh=G
        512oza/F2C2P0WQmOip5mZlVluqNDhNAN1ErLQz+Vc=; b=GIub0+KCNEMsx6MWy
        rTr+cV+3k7bAD5nvUSCJ/rpavk6mC9+LqMwyg0NgRptj5uNdIs/zAYUoJDxf1ZtO
        mVzQEkbagM72bzb6dPghc6m2KTf+L5cL7gx7mjdSNwBqW/KTMySt/4+C+lDP9GfK
        joVxKLEkFnWutM3U4FRSuZnQzSVOgLGTaTxoVwkceuPONyPk+52KEF4qYdQN5XuH
        lPdk2+Uc0lTYxCmgGXszoaCo3MZBKSQZ9kx7eS4vmF8JyA1OXzRwaZdtaWOrlU5a
        5PB13G0I74Ywnc5y/qNDS38Qqd5naXqSuxyJM4JO6VvjYTI7rfsaCTDuH2Xa1iZY
        FaY9w==
X-ME-Sender: <xms:WvulZCWOS6-Zcp6XbEtZwJlh5TDVIEH-RubktxJ394DCctHg4R3uNQ>
    <xme:WvulZOnf8uybVmRLAAwTElXMnYSyjZRBHwY4bZO4avZToyXYWt5O3VdZr1Eo-u6H_
    TyhZZKdl4o7N9FmBlY>
X-ME-Received: <xmr:WvulZGYEwYjJnjd2H1N8_pODTO7YE1gHYigqF7xieQvdpaMs0A5_K3fvSrInGfozcDhE6PmPVu0_Dz7Kb2aavAbHavw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:WvulZJXvDWvsnOw9BSkosSN4b0l853C24ZYajP_6qBN9VZQIa9f6sg>
    <xmx:WvulZMmkzmnSjuTeA5JvezdseUPQIj6kDLtot1FbhyAqexImGDZvCQ>
    <xmx:WvulZOdbO227SE_0ctDSytCf9r77MJzvRHk7WOCJwIGRDFGMVfmlOA>
    <xmx:WvulZDsIqKeu5JBHjMSow2lOzyq77gNFu1CHnlIW8DaeBgy1N_c9Mw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:23:05 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/18] btrfs: fix start transaction qgroup rsv double free
Date:   Wed,  5 Jul 2023 16:20:39 -0700
Message-ID: <90d1a33e3722d5533a8bb595b658aae81d1e6c21.1688597211.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688597211.git.boris@bur.io>
References: <cover.1688597211.git.boris@bur.io>
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
---
 fs/btrfs/transaction.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index cf306351b148..d40b0a39a552 100644
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

