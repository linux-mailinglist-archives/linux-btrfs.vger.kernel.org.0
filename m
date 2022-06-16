Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDCB54DF29
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 12:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiFPKcs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 06:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiFPKcr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 06:32:47 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AD115833
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jun 2022 03:32:44 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:5439:2bcc:4a70:48e8])
        by michel.telenet-ops.be with bizsmtp
        id jmYi270064lJ8fu06mYioK; Thu, 16 Jun 2022 12:32:42 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o1mRv-004AbF-4n; Thu, 16 Jun 2022 12:10:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o1kY2-007ZgO-8u; Thu, 16 Jun 2022 10:08:14 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ioannis Angelakopoulos <iangelak@fb.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] btrfs: Fix 64-bit divisions in btrfs_commit_stats_show() on 32-bit
Date:   Thu, 16 Jun 2022 10:08:14 +0200
Message-Id: <20220616080814.1805417-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 32-bit (e.g. m68k):

    ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!

Fix this by using div_u64() instead.

Reported-by: noreply@ellerman.id.au
Fixes: e665ec2ab6e1ae36 ("btrfs: Expose the BTRFS commit stats through sysfs")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 fs/btrfs/sysfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index bce2573b02861149..a24cf7e0900a23cb 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -9,6 +9,7 @@
 #include <linux/spinlock.h>
 #include <linux/completion.h>
 #include <linux/bug.h>
+#include <linux/math64.h>
 #include <crypto/hash.h>
 
 #include "ctree.h"
@@ -1002,9 +1003,9 @@ static ssize_t btrfs_commit_stats_show(struct kobject *kobj,
 		"max_commit_ms %llu\n"
 		"total_commit_ms %llu\n",
 		fs_info->commit_stats.commit_count,
-		fs_info->commit_stats.last_commit_dur / NSEC_PER_MSEC,
-		fs_info->commit_stats.max_commit_dur / NSEC_PER_MSEC,
-		fs_info->commit_stats.total_commit_dur / NSEC_PER_MSEC);
+		div_u64(fs_info->commit_stats.last_commit_dur, NSEC_PER_MSEC),
+		div_u64(fs_info->commit_stats.max_commit_dur, NSEC_PER_MSEC),
+		div_u64(fs_info->commit_stats.total_commit_dur, NSEC_PER_MSEC));
 }
 
 static ssize_t btrfs_commit_stats_store(struct kobject *kobj,
-- 
2.25.1

