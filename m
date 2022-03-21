Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3FC4E353B
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 01:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbiCVAA0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Mar 2022 20:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiCVAAY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Mar 2022 20:00:24 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40FD6E79F
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Mar 2022 16:57:51 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 89AF15C01E6;
        Mon, 21 Mar 2022 19:56:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 21 Mar 2022 19:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; bh=jcnXxaAhtsBFwydTnb21v8lV3f7BRz9Z13gqCh5laHQ=; b=DDbaR
        aM53jsk6Sd9PsJRyKn1EcrD5y0ukTYViTiRSCa0/dnrpmbuw2cflzbfF+NHDO+i/
        pqrDExMP5ChSHMsBbZ3MafmfRoP+Pvi6H9hlMoCH0uCydi9TgElFqvoPqVwCQMpI
        c+y4+bSS3YyHQjOI3bQ4WmqZigOyd89aoMCrkR3Q8YkM3usGPhOouNHzWzO1p4QY
        9qD+PpyGXsoOeEtwtk+vUupDxJyqpATOPYzDVMO04cYGsmJ0m5E5suNty9+gE2Lw
        PXN4GteIMZ7hrjPo1DSM0AyVsBXUZ8pUdl015Z1J6M34NjfJa0vGPn6i4WcgaOiB
        iEgz4zy84CDZz1rcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=jcnXxaAhtsBFwydTnb21v8lV3f7BR
        z9Z13gqCh5laHQ=; b=KC/paA2eu5jhAV5SinCaBt/CE9V9VmosUKe9tj5x2MW5p
        WntTACJVheH+ho0c8ccD+oQnfbmdvRswIfmtIDRcMpxTePMpJNwnVPsWdzoesTKl
        uOhDMhXeqUzlyMOWc7MPT1bhEFKrWS0CqPMK2YyCAXpa0ti3rfvN3xLmMO7q1Mkq
        5ZPRvOwf5CMG6pb6iZh4PVrs+MSjZVWOBAyFCKA+U2u1vM17hxdfTeWoo+qj2bkf
        yQ3D3mzEB48WCSHutZSmg9mb3Meb6/I6x+aNzC8m+y3WEuDrsErzW64aMd1mK5x8
        JbaO7SseZD3pAOHQaZTwI+3L1//VGsosgrxdf4Etw==
X-ME-Sender: <xms:phA5YqLg1wZQfOzhdtZ8sRdfJqnaORfSap6FO-Gs2Es1AYLlqx1hBA>
    <xme:phA5YiJNCrc7oTFj1xnoIKmaCahl-GvJ3ydosBoLm2CTdSvgR_2dHmtz1v2iZY7HA
    KkBI8MtGvqpQqparU0>
X-ME-Received: <xmr:phA5Yqu7Z79kLnLUeewKVdayX0ozZTi5U4ZRPURVIC8RxB2dslqSjeLGq90>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeggedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeetjeefgeffffeifefhffevkeejveeuveelhfdvgeekvd
    effeelueeuudegledugeenucffohhmrghinhepghhithhhuhgsuhhsvghrtghonhhtvghn
    thdrtghomhdpmhhkshgvvggurdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:phA5Yvb1TUIQ9KpdUiUWHSW6iR4LAN_6h3rWq1nmNA0y4x-maUuCgg>
    <xmx:phA5YhaCOJUC0x_aIPu1ssleg-ZyZL25StDoGaGTNhpOVeK3bC07vQ>
    <xmx:phA5YrDDHc-Kr1GpmXb7GlfLKcUTB-M7gAu--5CEpGkCaKo_KUY7Yg>
    <xmx:phA5YiCD8pZ7c7-yyAJtC6I9_r6DwSHlQdneD58Zb7t1JBGhV4G3JQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Mar 2022 19:56:22 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: do not clear read-only when adding sprout device
Date:   Mon, 21 Mar 2022 16:56:17 -0700
Message-Id: <16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur.io>
X-Mailer: git-send-email 2.30.2
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

If you follow the seed/sprout wiki, it suggests the following workflow:

btrfstune -S 1 seed_dev
mount seed_dev mnt
btrfs device add sprout_dev
mount -o remount,rw mnt

The first mount mounts the FS readonly, which results in not setting
BTRFS_FS_OPEN, and setting the readonly bit on the sb. The device add
somewhat surprisingly clears the readonly bit on the sb (though the
mount is still practically readonly, from the users perspective...).
Finally, the remount checks the readonly bit on the sb against the flag
and sees no change, so it does not run the code intended to run on
ro->rw transitions, leaving BTRFS_FS_OPEN unset.

As a result, when the cleaner_kthread runs, it sees no BTRFS_FS_OPEN and
does no work. This results in leaking deleted snapshots until we run out
of space.

I propose fixing it at the first departure from what feels reasonable:
when we clear the readonly bit on the sb during device add. I have a
reproducer of the issue here:
https://raw.githubusercontent.com/boryas/scripts/main/sh/seed/mkseed.sh
and confirm that this patch fixes it, and seems to work OK, otherwise. I
will admit that I couldn't dig up the original rationale for clearing
the bit here (it dates back to the original seed/sprout commit without
explicit explanation) so it's hard to imagine all the ramifications of
the change.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/volumes.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3fd17e87815a..75d7eeb26fe6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2675,8 +2675,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
 
 	if (seeding_dev) {
-		btrfs_clear_sb_rdonly(sb);
-
 		/* GFP_KERNEL allocation must not be under device_list_mutex */
 		seed_devices = btrfs_init_sprout(fs_info);
 		if (IS_ERR(seed_devices)) {
@@ -2819,8 +2817,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	mutex_unlock(&fs_info->chunk_mutex);
 	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 error_trans:
-	if (seeding_dev)
-		btrfs_set_sb_rdonly(sb);
 	if (trans)
 		btrfs_end_transaction(trans);
 error_free_zone:
-- 
2.30.2

