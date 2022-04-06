Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A224F720F
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Apr 2022 04:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbiDGCaB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 22:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiDGC37 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 22:29:59 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9741E112B;
        Wed,  6 Apr 2022 19:28:01 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 52EAD807ED;
        Wed,  6 Apr 2022 22:28:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1649298480; bh=v3k5Rq11ZVRZywAD+d8FqJVUni9Z9keWfAaH0o9cMLs=;
        h=From:To:Cc:Subject:Date:From;
        b=o8Ioe7+kU+1QvlQ8Zf52QutUKXRjj8sWSjX628V/esCXYsIYIuIyZA41XiUjEzv2F
         jaHN1g+wdcsJQbc+v+adtawCT1frWwN9X5Dj/s8mlCykJaDbfLI/fqnh/XNjwk5O5O
         juvQj++mThbUgIF77n6H/a9BrD6WaPvzTKeU3t5I6dVp43dU13MUq00zKGyWcS4osq
         HW0u7P0Px3AXtWhb2fwuwECmz5Qiz624v7YSG6CfcDXlAFPZcUM7hmkBtgfFmIUQQL
         1ieHADb4I4/WPAtM0b/ipYVRdqxLv0lEaiCR08kZP0hhfeuCdQwZGfovA1Vp7pmmci
         yK07jwWbvtSPw==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        David Sterba <dsterba@suse.cz>
Subject: [PATCH] btrfs: wait between incomplete batch allocations
Date:   Wed,  6 Apr 2022 14:24:18 -0400
Message-Id: <07d6dbf34243b562287e953c44a70cbb6fca15a1.1649268923.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_INVALID,DKIM_SIGNED,DOS_RCVD_IP_TWICE_B,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When allocating memory in a loop, each iteration should call
memalloc_retry_wait() in order to prevent starving memory-freeing
processes (and to mark where allcoation loops are). ext4, f2fs, and xfs
all use this function at present for their allocation loops; btrfs ought
also.

The bulk page allocation is the only place in btrfs with an allocation
retry loop, so add an appropriate call to it.

Suggested-by: David Sterba <dsterba@suse.cz>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/extent_io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9f2ada809dea..4bcc182744e4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6,6 +6,7 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/page-flags.h>
+#include <linux/sched/mm.h>
 #include <linux/spinlock.h>
 #include <linux/blkdev.h>
 #include <linux/swap.h>
@@ -3159,6 +3160,8 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array)
 		 */
 		if (allocated == last)
 			return -ENOMEM;
+
+		memalloc_retry_wait(GFP_NOFS);
 	}
 	return 0;
 }
-- 
2.35.1

