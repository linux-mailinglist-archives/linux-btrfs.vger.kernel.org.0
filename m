Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A01929F954
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 00:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgJ2X61 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 19:58:27 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59305 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgJ2X61 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 19:58:27 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 6381D5C00DD;
        Thu, 29 Oct 2020 19:58:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 29 Oct 2020 19:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm2; bh=E42VkJKfxNqb9pRNLMWP7Aw4rQ
        hI7nJQushHWEDcPBE=; b=Mu8UvkLFamEsmpfx/QvU9B5ZYvsovibKAcPxtd6iHs
        VahmxPF6lecCJGORD3FY6D2bDU+EW1oEtWUPwJYyTL+e958h53S1b1Ec/OIr9imd
        30pgFnfwp9gx2UkjkEg9bXgCya7jApZUbypU8VaO5BL/gM9ttmisc113Y45wvMIk
        1UoE/AfPCMMtSkdMNH0Xp5lClW45MyPtr/8thdEP0vUD8sh9Udl1Al2vsj6yU2M0
        zDslxBfSEREOKCB8zTVB7npW2J8OlRUl9W4TK7O0GW2WzhEjf+/SE/JhHbhZbZ1k
        9hYfNLCP6KLNG3Luiv3qJzmM1JhcaYHHCWB4PWytgTMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=E42VkJKfxNqb9pRNLMWP7Aw4rQhI7nJQushHWEDcPBE=; b=rFtStaxz
        HXJBaIuv91I3uVYapirUPdxcX63CCPOvCo7itINl+BAdGyHtStt/4wPtUuVq3FlL
        KlxpQDpeutdvaeuIC+oBJ7v4dUbSqJ6re0ARCetVTz8hB9/SEDEt2CaMo/rpfbFO
        SeVa6jVJZ3urU9fCIGDP93iLXyTDPNHH+NTe1BbWtp6YLWnYhP13LsC1fuwVANhP
        Zj80z30g0Q0Fkyw1xBx10ofsWqpOFmHTWyWhYW6vdjke88u/Vk1LhkfLMwYbCZ/5
        a2h9WABV6mGrKBNwhj8k83WPqEdZUr5NLcsjSDSTIuHNWLxfvKiRf/SH0xcINIoF
        QjD/HQf2qrVwcw==
X-ME-Sender: <xms:IlebX5AIpXIt6DOZnBklJANJM1KltMjPGBkwwR_1Cl2Z0OmTiv82sw>
    <xme:IlebX3ghrCJTDVMk5kFxEruFQX5DCJog-4XknR96vnNQI4AbJZc-S3nY1XkslRTK6
    j4-9A9vqtRW4_1ufB8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleeggdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecukfhppeduieefrdduudegrddufedvrdefnecuvehluhhs
    thgvrhfuihiivgepjeenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihho
X-ME-Proxy: <xmx:IlebX0loXEtgNA8x10DeijX_cr8PevJYkxYjFIFNlNJmdxmcb7xmbw>
    <xmx:IlebXzxpOdLox2et1QAM-jTYNHd_N7YwhKPR1e9UByoSaemjWgjZvA>
    <xmx:IlebX-R6kV7rCsjy7nLbYOufwKt_zIP60d2mwpHZRFBTYGDTmbyWeQ>
    <xmx:IlebX1MLFi84Eop1IAv3u2htrAbsKxnzk3wGbxwi6AD6X6O7Fi0oMA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 004B33280063;
        Thu, 29 Oct 2020 19:58:26 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 08/10] btrfs: warn when remount will not change the free space tree
Date:   Thu, 29 Oct 2020 16:57:55 -0700
Message-Id: <a36a1c2acfa645af6d021c512b61c943f1f534d7.1604015464.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1604015464.git.boris@bur.io>
References: <cover.1604015464.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If the remount is ro->ro, rw->ro, or rw->rw, we will not create or
clear the free space tree. This can be surprising, so print a warning
to dmesg to make the failure more visible. It is also important to
ensure that the space cache options (SPACE_CACHE, FREE_SPACE_TREE) are
consistent, so ensure those are set to properly match the current on
disk state (which won't be changing).

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/super.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 527ab305ac68..ed5c80f92f78 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1914,6 +1914,24 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	btrfs_resize_thread_pool(fs_info,
 		fs_info->thread_pool_size, old_thread_pool_size);
 
+	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE) !=
+	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
+	    ((!sb_rdonly(sb) || *flags & SB_RDONLY))) {
+		btrfs_warn(fs_info,
+	   "remount supports changing free space tree only from ro to rw");
+		/*
+		 * Make sure free space cache options match the state on disk
+		 */
+		if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
+			btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+			btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
+		}
+		if (btrfs_free_space_cache_v1_active(fs_info)) {
+			btrfs_clear_opt(fs_info->mount_opt, FREE_SPACE_TREE);
+			btrfs_set_opt(fs_info->mount_opt, SPACE_CACHE);
+		}
+	}
+
 	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
 		goto out;
 
-- 
2.24.1

