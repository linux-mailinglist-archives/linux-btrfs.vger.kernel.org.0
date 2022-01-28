Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F56E49F97F
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 13:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348511AbiA1MgU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 07:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiA1MgU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 07:36:20 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D74C061714;
        Fri, 28 Jan 2022 04:36:19 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 767F21F45EEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643373377;
        bh=YtNcSY4XVYMhivO+4b/pttldYIe/hSGVUaO4aQU8K48=;
        h=From:To:Cc:Subject:Date:From;
        b=HafNsL5TwEyIN1EqH+qVuV9c/oRkylS8g8M/EPoCZ2watO47Hc9bRD2C6Zm1+WCnx
         aKptfjUesye4RIKjag/GHygSmsvAJQhUonu3z5j/alHkV98Lfq/vW7KOAF4Z2MaSIh
         UtAFXRiTi6daP8BlLqFua+Vuxj6IIRhlcns8gkYrK9EyiEL5ulfIDfQ9X3gbyyGBHw
         wlaSrfhYa07g4i+Elj/0dQnhvR4KtNAo8tEtZOU8YYhigGaQ3bfJNkxvcf2C7SUk5D
         xeCz5cRayjo+z2NfeOX7PpPnZ7+W1pLtnDoyfz1gQagn602hRDxdfz454GbGmFlQvQ
         F2xIkBmxVmMbA==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: initialize offset early
Date:   Fri, 28 Jan 2022 17:35:58 +0500
Message-Id: <20220128123558.1223205-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Jump to out label can happen before offset is initialized. offset is
being used in code after out label. initialize offset early to cater
this case.

Fixes: 585f784357d8 ("btrfs: use scrub_simple_mirror() to handle RAID56 data stripe scrub")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 fs/btrfs/scrub.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 26bbe93c3aa3c..3ace9766527ba 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3530,7 +3530,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	u64 logic_end;
 	u64 physical_end;
 	u64 increment;	/* The logical increment after finishing one stripe */
-	u64 offset;	/* Offset inside the chunk */
+	u64 offset = 0;	/* Offset inside the chunk */
 	u64 stripe_logical;
 	u64 stripe_end;
 
@@ -3602,7 +3602,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	ASSERT(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK);
 
 	physical = map->stripes[stripe_index].physical;
-	offset = 0;
 	nstripes = div64_u64(dev_extent_len, map->stripe_len);
 	get_raid56_logic_offset(physical, stripe_index, map, &offset, NULL);
 	increment = map->stripe_len * nr_data_stripes(map);
-- 
2.30.2

