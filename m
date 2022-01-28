Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9DE49F8BD
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 12:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348235AbiA1LvH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 06:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348220AbiA1LvE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 06:51:04 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF05C061714;
        Fri, 28 Jan 2022 03:51:04 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id B03051F45E96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643370663;
        bh=ZTfpdFB0k8V5iAKA53Pw1fPeSktMJTlkZU1aFUU3f80=;
        h=From:To:Cc:Subject:Date:From;
        b=SppjWrBIUF/AKYyZo9o87cbHJg1MANVp/ahJm1EdatzQNvY5VyKdACl5m41rc5n79
         io3lGoxcNx1Kq5OoHpuwWjfNPT6HSXbPgxnqilOzRRXq4VSFaRLqDJUPcIHtky242H
         LyTbtm6vg3xT53vMY2gNASQtckMOHJR6GJIKawlb8g8l1DQB4F/gYy3Mih2IVRmrI6
         cgJu2Ks1HBq/+nfsjjesm0JWzpDBtxEa0cRKkJ/FKYH3hGaar6+obgPWkat2/9nVoR
         HhA0ceky/AA4G1/sFS3C5H2vQxOvv0+wTbr5TiBuMYfNQh8M1Po+ZVkq08/FW2JhdU
         HEiWcTfsUV+Sg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: Remove dead code
Date:   Fri, 28 Jan 2022 16:50:27 +0500
Message-Id: <20220128115027.1170373-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Local variable stop_loop is assigned only once, to a constant value 0,
making it effectively constant through out its scope. This constant
variable is guarding deadcode. The two if conditions can never be true.
Remove the variable and make the logic simple.

Fixes: 585f784357d8 ("btrfs: use scrub_simple_mirror() to handle RAID56 data stripe scrub")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 fs/btrfs/scrub.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 4baa8e43d585b..26bbe93c3aa3c 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3533,7 +3533,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	u64 offset;	/* Offset inside the chunk */
 	u64 stripe_logical;
 	u64 stripe_end;
-	int stop_loop = 0;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -3652,14 +3651,8 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		logical += increment;
 		physical += map->stripe_len;
 		spin_lock(&sctx->stat_lock);
-		if (stop_loop)
-			sctx->stat.last_physical = map->stripes[stripe_index].physical +
-						   dev_extent_len;
-		else
-			sctx->stat.last_physical = physical;
+		sctx->stat.last_physical = physical;
 		spin_unlock(&sctx->stat_lock);
-		if (stop_loop)
-			break;
 	}
 out:
 	/* push queued extents */
-- 
2.30.2

