Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D9F2CC728
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389805AbgLBTxW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389799AbgLBTxV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:21 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC62C094242
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:23 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id u4so2466122qkk.10
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zulpyi5SLM44cKCfoKl/mIq7LY9yIfa92iZ4+KP+dxE=;
        b=kDbVce4eMU33vD6nh7UvUFjcOSyxZLaTytpyX4UpDzv4/V4/RzgOoHK5mm5C9boZxm
         A7j2Wt1vV+g0ChREosk+ZIBIn0NFXI7RtGj/wdTcz/tTRksDw3MrMlw6URmiFs22/mbB
         okcdSLzWtMftr9OBAOea6W8yQ3sjjA5hBC/sf39I374AFNZOxfdQ7o3dVd81W1fCO5CQ
         71P5TKuYMi7tSaGFdulC6zrBoXEkZEkZA8AHd7Rpg/b71FiMULIZN3/oBzl6a0QPoGw3
         X7cVFc88+hEDU0QtckriPLvRv3We1N1lfdL4RrJBMqo/R5NClQ84v7inJH8+WFs95QIj
         /p/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zulpyi5SLM44cKCfoKl/mIq7LY9yIfa92iZ4+KP+dxE=;
        b=aJNk0+aoKXRC5hmybTA7/aItjMJJfiZ0FX/aBbLQb9AsSFFYeLAbxn26cG1PwfnEzI
         3NW8aqDmSEPRjbG5jATYgOCIPEy5vjESahcsAtUO2iJR2b4EeJTDTZFkAplIl5DtzY/u
         dDte/uqLPskRTKzW6tu8ozTE1PL9/XRTFdckAtkEjXDTKKNCBEFyM47MekMalHm+z9yz
         ZMx+f791BWV8+f2xJ0AMoY7Kl4UwZaCn7t1c+ntiqAAz4ciSRb7kB2P9stb0MTfbPbMS
         xpeYshfL4WLvYzBbA9WsxY60WT320uVQ7HKpA2g1MKhQgUlgeLIhHq+nOX6FMLWlTOmj
         PZig==
X-Gm-Message-State: AOAM5335SS4VJXF2mM1zHdWgrnaOEi+0/HPhVP+MpUS/JqFyRMGfqiXG
        XpRD1BF0d6JWKc625XQjLwJwB/fWhreNPQ==
X-Google-Smtp-Source: ABdhPJwB7EIroXffxLQVt/6QwLQwN77dYE7Har8zPEb/bHnBRaTc8saC21RuTsLXmehUL1DmneTawQ==
X-Received: by 2002:a37:4f4e:: with SMTP id d75mr3870912qkb.284.1606938742692;
        Wed, 02 Dec 2020 11:52:22 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v6sm2768201qkh.83.2020.12.02.11.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:22 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 38/54] btrfs: handle the loop btrfs_cow_block error in replace_path
Date:   Wed,  2 Dec 2020 14:50:56 -0500
Message-Id: <ccb1551a8d087aa2d6ac7cf9100a0034172a645a.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As we loop through the path to replace it, we will have to cow each node
we hit on the path down to the lowest_level.  If this fails we simply
unlock and free the block and break from the loop.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 52d6e7ab4265..781908f3a3af 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1286,7 +1286,11 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 				ret = btrfs_cow_block(trans, dest, eb, parent,
 						      slot, &eb,
 						      BTRFS_NESTING_COW);
-				BUG_ON(ret);
+				if (ret) {
+					btrfs_tree_unlock(eb);
+					free_extent_buffer(eb);
+					break;
+				}
 			}
 
 			btrfs_tree_unlock(parent);
-- 
2.26.2

