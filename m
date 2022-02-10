Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753EB4B18B7
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 23:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345177AbiBJWol (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 17:44:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345168AbiBJWoj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 17:44:39 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E4926F3
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 14:44:39 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id n6so6610675qvk.13
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 14:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DgKhbyGAQPeTLXUs+YoVKJHJFcehw5iPs1gtyS61iKs=;
        b=LKX/Ofy3w3jf+2hBm6x2B6Kfwspizb73rFbBKjM8sYFBArJ69BzlTeh0UIBZffwurU
         yfrrzfmSD4834cvFcVi/NDBbSi8cNo+arQ0H2X8NWQlumy/OwJv4IW2mAzylyTcP4TMg
         vvfZY0YqsD9He82wwM4Lgme0S6wYfJMD8Y/Qn2sbAiTnBYvqTQPyD44lXve4YYX7meil
         gffUjKDWkyuSS1Si89P9PWWCUVA3F5VX1CW2bnW4CjhvMVLsVJOuqxkDbDoxr0OL1WNT
         yT5mLyt0TvK48yavBCLHrj+P9c4Xmd92n3ASAruPNjuZ8aChUSy1CestD26g9FF3rx0w
         iYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DgKhbyGAQPeTLXUs+YoVKJHJFcehw5iPs1gtyS61iKs=;
        b=V/Vhd1tR/aohLhi6tj89eMgPHv504WW+XNcgSPTng3sneQg6XzfOhR5a0KvdTUqYlV
         mrujvV+sBqvh9yFdE6ppajH7eawpqjR2++WXQmX/Y/ovh2+xxBXMNRjg0hrzyJAARcC5
         39D0YxU6Jex1AlFHtdGMZyfAIEsE1Ihd2e/yNbCij1/bQHObvdOXF0LLT0PVYAu5/jWc
         d7gF9DEmhqslKeDCSrrl34Umiu9DDHm9/f2Zwjx/4ylhNJrMth3+rBckFiYcv/0XhxJs
         S+hOk6G2/tCZZ/wj73tzPFmX/jeKjDsOcFju1FTJ/gYtSZ7IytumwxU6SOQxRrMwotMh
         MdKg==
X-Gm-Message-State: AOAM532wzNDmgGVMKicUUZg+MY41ct+adJQfCfSSiXhnc9VgBJc0sVcp
        rOTXBznX0TZXmBwBiEQfbvDIC/4ubCT/oVit
X-Google-Smtp-Source: ABdhPJxp+4+hP/PdQBwFKEZ0DZsd1AAcJdoCb3TqqxNkZaU08MYB3nWJdfwHHRYFDi2HwcsEOq75yw==
X-Received: by 2002:a05:6214:240c:: with SMTP id fv12mr6681212qvb.40.1644533078485;
        Thu, 10 Feb 2022 14:44:38 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h5sm11206309qti.95.2022.02.10.14.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:44:38 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 8/8] btrfs: do not clean up repair bio if submit fails
Date:   Thu, 10 Feb 2022 17:44:26 -0500
Message-Id: <ff852e85926bfa2949283bce0d8f3a91d5126bd5.1644532798.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1644532798.git.josef@toxicpanda.com>
References: <cover.1644532798.git.josef@toxicpanda.com>
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

