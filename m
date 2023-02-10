Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACE2691F12
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 13:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjBJM1n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 07:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjBJM1l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 07:27:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF5571039
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 04:27:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE26161DA5
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 12:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3F5C433D2
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 12:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676032059;
        bh=+F7ufyYeh0D4JW6j0Vy/Olj4Bof+ZrMh7zguhvBXOHI=;
        h=From:To:Subject:Date:From;
        b=qP2nIkwR9bBfGhI2Pd02PHpWvvsKaCC28uJ6nPvjqnhlhn+xSvwmyzdAPiaLx8P/J
         a5UFniTAnmtaSUahOWi8f7JH6E784SmHsc/HUjlb4DBc6L08TNnFoCRpA+LxyPxqgh
         4O+8ua+bT3O3HSB3r9QeAHRC/XnFlX0utaySNk2brzv6jWp1e+u6M6SJ6KdHMp4Cwc
         NKHSnn6Hwiu1OMofhJ9Bl50DUIdtIz82A2azgX17ZPhMV1QN+5T0a3HQCefpwlGTaK
         dvE03SASmkzPgvgKHhJQiOSg2gAr9D8yHv1LeX+BXhjifrweIewWSjbtFVYnZiwe5n
         g9cabHQrIsnVw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: send: fix cache entry leak after failure to add it to the name cache
Date:   Fri, 10 Feb 2023 12:27:35 +0000
Message-Id: <d012eb57320bc93ec45583a7ff86575060bcf51c.1676031742.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At __get_cur_name_and_parent(), if we fail to insert a name cache entry to
the name cache, we end up returning without freeing the entry, resulting
in a memory leak. Fix this by freeing the entry if the insertion fails.

The issue was introduced by the following patch:

  "btrfs: send: use the lru cache to implement the name cache"

which is not yet in Linus' tree.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index f936c203f386..e5c963bb873d 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -2385,8 +2385,10 @@ static int __get_cur_name_and_parent(struct send_ctx *sctx,
 		nce->need_later_update = 1;
 
 	nce_ret = btrfs_lru_cache_store(&sctx->name_cache, &nce->entry, GFP_KERNEL);
-	if (nce_ret < 0)
+	if (nce_ret < 0) {
+		kfree(nce);
 		ret = nce_ret;
+	}
 
 out:
 	return ret;
-- 
2.35.1

