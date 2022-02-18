Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16404BBBC8
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 16:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbiBRPEB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 10:04:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbiBRPD7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 10:03:59 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D212B2FEE
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:03:43 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id c14so15201019qvl.12
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9H509EM1AkaBe3VAz1ekxptEkOLcqUznjw9mdS8Q4X4=;
        b=WmWpzomn+ddqkY4IjfbxtQVMjmZ3nP0JsK4/IPOEeebW7uF35h+LHiKB2P49dZIiMd
         lQC78eOvzeR3FPFxFwUglgZp1H4Gc0GWO2Yzklf17levV36LwRAgIVgx+UudBYqGUdgS
         TnYrZ8lsb1/6kQDyRnk9lDNu10UGJHa1b3H8KQ+Aot+JDEupqC2TYNl+j9laxN00acSS
         wZmbTU2jXA4jJZEDKve9oS/hHynyz9YyCGTa+OiUfBZID83rB6GNS147viYri76eikF4
         HUpQozKzT0BpNVQNAOPE4wD6t6cGnt0ZiSGvKV8f5i1v8kT2jEsdrlXSh5ibFAx39k8C
         zH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9H509EM1AkaBe3VAz1ekxptEkOLcqUznjw9mdS8Q4X4=;
        b=YNlgsVsWBMizxNPSddgWOReUK7UfAakQu3GNGthD/epbNl2AUiLaKeE+yaD3qr3XIt
         4UJYmfsQgZC490mMY7QRMguM1jdxWLbtfuYWUkSA3I1tpypq6hsrFm70xjunZ/3uPR+f
         X+Bh0KY0SpYJPmCjaQkvKRl33ltQkOH+E/v6odMExi/U3GCv43DIAog9GVASb7fJYHOg
         JKVVzj5xSsYwOXuhp5Rr6aUnIvXQ8Ka9Jl5XBK9DsRXtpMiGUxIqY7FTpYa+Hpm2IxaQ
         ICt+eR9fGAW2oBXoviB2GgsFmNHtXxjz8X+I3qDVmfPo/zsvt+iXg9/9f0wm0cguyXCR
         bmZQ==
X-Gm-Message-State: AOAM531VfKNd+KsbwfmAtzxWyiH+0yiHmjtmR0TUM7DHJgs/azMtFdrA
        2vvNlDcg8pzGGOHxgw68T1If6OhKjdYN8fnC
X-Google-Smtp-Source: ABdhPJyJILHdJTcu2Qj1b14AOm+Ad8vRZKA4ijTMACyxRTT1YKupOSNBbqA6pKmVl0G2w2yuG0siLQ==
X-Received: by 2002:a05:622a:1a13:b0:2d7:1c46:3d95 with SMTP id f19-20020a05622a1a1300b002d71c463d95mr6985166qtb.383.1645196622076;
        Fri, 18 Feb 2022 07:03:42 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d23sm4761310qka.50.2022.02.18.07.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:03:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v2 8/8] btrfs: do not clean up repair bio if submit fails
Date:   Fri, 18 Feb 2022 10:03:29 -0500
Message-Id: <04b1730d3f13ac80805d48912ff0cf07174e29b1.1645196493.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645196493.git.josef@toxicpanda.com>
References: <cover.1645196493.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The submit helper will always run bio_endio() on the bio if it fails to
submit, so cleaning up the bio just leads to a variety of UAF and NULL
pointer deref bugs because we race with the endio function that is
cleaning up the bio.  Instead just return STS_OK as the repair function
has to continue to process the rest of the pages, and the endio for the
repair bio will do the appropriate cleanup for the page that it was
given.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 29ffb2814e5c..16b6820c913d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2640,7 +2640,6 @@ int btrfs_repair_one_sector(struct inode *inode,
 	const int icsum = bio_offset >> fs_info->sectorsize_bits;
 	struct bio *repair_bio;
 	struct btrfs_bio *repair_bbio;
-	blk_status_t status;
 
 	btrfs_debug(fs_info,
 		   "repair read error: read error at %llu", start);
@@ -2679,13 +2678,14 @@ int btrfs_repair_one_sector(struct inode *inode,
 		    "repair read error: submitting new read to mirror %d",
 		    failrec->this_mirror);
 
-	status = submit_bio_hook(inode, repair_bio, failrec->this_mirror,
-				 failrec->bio_flags);
-	if (status) {
-		free_io_failure(failure_tree, tree, failrec);
-		bio_put(repair_bio);
-	}
-	return blk_status_to_errno(status);
+	/*
+	 * At this point we have a bio, so any errors from submit_bio_hook()
+	 * will be handled by the endio on the repair_bio, so we can't return an
+	 * error here.
+	 */
+	submit_bio_hook(inode, repair_bio, failrec->this_mirror,
+			failrec->bio_flags);
+	return BLK_STS_OK;
 }
 
 static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
-- 
2.26.3

