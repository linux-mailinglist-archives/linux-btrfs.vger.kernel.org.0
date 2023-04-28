Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036886F2113
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 01:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjD1XJC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Apr 2023 19:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjD1XJB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Apr 2023 19:09:01 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6B149D5
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Apr 2023 16:08:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3E60E5C014D;
        Fri, 28 Apr 2023 19:08:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 28 Apr 2023 19:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1682723336; x=1682809736; bh=w4PW79X4Dj
        U3GTpf1280BMkHkyYYUcZylQYtTBtfrHw=; b=Q3ilFo+L0BjYeA8kRwHEf1e9h9
        zPJKH5oPORyn2CwDD7H50KbRI7S4AAdoQAO611tuGgsIE5bt823BFYZWD+YvO/Bs
        TGWguPwreqfM6sxXixl9km3/gVwzAvk8TvyAN/xJ1l/vlQnEeAuE3HyejeHuk2bD
        ka1cE3tRC0dkx/PYZlH/2NkKt37y2zX0G03GDAdSBQdQy2SEDID75fhUl57lYWR2
        O2u7j8cwA74a40sqwJWBVL8oboAThlqtgfBHT7CS5DJVpjzQ6bOMNktJl0X/tMWT
        0MQ/rnakhb1BQkjv8AK72kbm8ztUD8iJt/Toq64KHPFS13VApHYZr6nFepcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1682723336; x=1682809736; bh=w4PW79X4DjU3GTpf1280BMkHkyYY
        UcZylQYtTBtfrHw=; b=BjDjCxDBlFC/Dj+Ol9RE8wdQ/iVm1R+Wmiax0Tnta/ti
        9aY4NifDO0/qUtgtGWPEh5OLc6x9iGzd+EE/v4j7lgVvoxMlvOxbHj1RxsAaRSmV
        v7Wvh18Lrnndt9ifR/wGj82l+EEpYLaekGBKXrR/2QZHJ0MTJlW+9zd0YZv0hEf9
        pXK3FmcDO1BFQrMf0QMifnI056Gse+dMrxljPUTc+qBGSX2D3pCyg1XAmgXIE8Ra
        ud67aEBeHL0shQYJYC5HILfZNLlvmc0RlpguJ4FWVozSOx3NRG5mMS+DRyxt6EnA
        xH64ERYe5Iq5FC1qfShuQ3M3E6GoOO9Zem0kxYpW8g==
X-ME-Sender: <xms:CFJMZIr8NtxoDsJj9IUMTwtAUaRStK1ovUTtm0KJz2rAOf8RLiFbNQ>
    <xme:CFJMZOqee-31H_qU2cySWTSoXLgWJTyfJmQmIKxTjlpWHYen3ROFn5U9Z_sjWKtVB
    j8w-fRYdqsVNHfQW30>
X-ME-Received: <xmr:CFJMZNM9gZF3ZMADBrRRVU1AwwwS4gyWYsxgj1Cuyv7-mnVF7kUvCM_eSlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduledgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepudeitd
    elueeijeefleffveelieefgfejjeeigeekudduteefkefffeethfdvjeevnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihho
X-ME-Proxy: <xmx:CFJMZP5Q-k5Qnak8CPKLhA6u4X_oo6Kd2pEigNAVRd8_AKP4bWxo4A>
    <xmx:CFJMZH50xK_MbU4l60XqmPC91_gJZPiNaJnJL0_GRi2bRyH6WRONOg>
    <xmx:CFJMZPhpXYA6QwVp8yckRmn97XwEKc4qrRsJ03DczOUxYcDyOVwJAA>
    <xmx:CFJMZBQ-nzheyZxnJErD28a_eaLmaeEpaQyCwzgr315kfwu6966sgQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Apr 2023 19:08:55 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        'Qu Wenruo ' <wqu@suse.com>
Subject: [PATCH RFC] btrfs: fix qgroup rsv leak in subvol create
Date:   Fri, 28 Apr 2023 16:08:50 -0700
Message-Id: <c98e812cb4e190828dd3cdcbd8814c251233e5ca.1682723191.git.boris@bur.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While working on testing my quota work, I tried running all fstests
while passing mkfs -R quota. That shook out a failure in btrfs/042.

The failure is a reservation leak detected at umount, and the cause is a
subtle difficulty with the qgroup rsv release accounting for inode
creation.

The issue stems from a recent change to subvol creation:
btrfs: don't commit transaction for every subvol create

Specifically, that test creates 10 subvols, and in the mode where we
commit each time, the logic for dir index item reservation never decides
that it can undo the reservation. However, if we keep joining the
previous transaction, this logic kicks in and calls
btrfs_block_rsv_release without specifying any of the qgroup release
return counter stuff. As a result, adding the new subvol inode blows
away the state needed for the later explicit call to
btrfs_subvolume_release_metadata.

I suspect this fix is incorrect and will break something to do with
normal inode creation, but it's an interesting starting point and I
would appreciate any suggestions or help with how to really fix it,
without reverting the subvol commit patch. Worst case, I suppose we can
commit every time if quotas are enabled.

The issue should reproduce on misc-next on btrfs/042 with
MKFS_OPTIONS="-K -R quota"
in the config file.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/delayed-inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 6b457b010cbc..82b2e86f9bd9 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1480,6 +1480,7 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 		delayed_node->index_item_leaves++;
 	} else if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags)) {
 		const u64 bytes = btrfs_calc_insert_metadata_size(fs_info, 1);
+		u64 qgroup_to_release;
 
 		/*
 		 * Adding the new dir index item does not require touching another
@@ -1490,7 +1491,8 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 		 */
 		trace_btrfs_space_reservation(fs_info, "transaction",
 					      trans->transid, bytes, 0);
-		btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, NULL);
+		btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, &qgroup_to_release);
+		btrfs_qgroup_convert_reserved_meta(delayed_node->root, qgroup_to_release);
 		ASSERT(trans->bytes_reserved >= bytes);
 		trans->bytes_reserved -= bytes;
 	}
-- 
2.34.1

