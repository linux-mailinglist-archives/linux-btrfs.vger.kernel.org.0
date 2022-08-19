Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B834A599FB8
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Aug 2022 18:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350852AbiHSQCk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Aug 2022 12:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351518AbiHSQBy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Aug 2022 12:01:54 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2AE83BE6
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 08:53:42 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id e28so3641440qts.1
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=t7z4r7Zusg/W4LPMQseQCHOEFh+27QvcLY2pwsJyL5M=;
        b=8KCBtmGWEPSqG8nW5ZqD5oKOxMU1Ag+4uvQDxvhraIUXlyKM5L65GxBjz1gCLOXOEZ
         kpenarO0w07yR/oSw9nT8GQ08Wp2Yii8avTOGCmL48Vyxg+TgCaPRUUT25tCzRk8QE7J
         5NIQ6ABjy0zrur7+ivMP/wwFcPDCpLOUAEvV4WLr6L/n0HNPlteBiXOrYWX97ybTAt8H
         +ClvWt/5bmdyYpPSHqLBkaan6SSO/JDu2LzQVnEkViFfnjFkA+EMeK03aYOBV67XwFwJ
         ZVm4g9Kfb1laeTiRUJ/u51HXrcyBTHRnsABugiO5IrcFiL3XTXD7cHtgXFFZ5mL2eZt2
         8jHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=t7z4r7Zusg/W4LPMQseQCHOEFh+27QvcLY2pwsJyL5M=;
        b=kTVms622Ly60HZdrgL63tDDnegCAx5LUXdSgY3/K2EY43t+wjZe6FE1b+TuO+s3iAa
         QnCPxMY+azmD66EZXg7yqnNl9yFHohzR+gPZzfgPuehJ6gx1ZyOX/y9vJSEjiZpujnlq
         rBcEjZ/n/zWBI7Wq4p9N3bqLd4Gfn8YfpAAD2qMwGeDr/aefYkFRxGFTIlwCa1w0ENRD
         Xuy9eGrxqpZawV9hQ7J08DZs/4X7st84r0fwLCiKaqIZSyzr9S+wT5He71A0YtPadzSg
         5EQLO7RxgSwdwq02cHwpWqy1leoA+MGq/ccMgrx9AC912DumX0a29WDF0zUEb/osp5qV
         G7KA==
X-Gm-Message-State: ACgBeo3M4UUHrA4sKwLuBviJu3Rfdp4+qJkc34c2UHOz00lB6Jc57s5U
        7Sr8kbGwP+HsJ96sIhZKIwDpDEF6WJfZhQ==
X-Google-Smtp-Source: AA6agR7lNU2FvlRUiJYaaoPPzy9v6mCQAE+UfeO5ZIoF6sO6SholGo0r3sSR0CDKFB1s+qivfngQGg==
X-Received: by 2002:a05:622a:38a:b0:344:aac4:780e with SMTP id j10-20020a05622a038a00b00344aac4780emr856871qtx.151.1660924420978;
        Fri, 19 Aug 2022 08:53:40 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v16-20020a05620a0f1000b006bbd2c4cccfsm2091272qkl.53.2022.08.19.08.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 08:53:40 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Cc:     Dylan Yudaken <dylany@fb.com>
Subject: [PATCH] btrfs: don't allow large NOWAIT direct reads
Date:   Fri, 19 Aug 2022 11:53:39 -0400
Message-Id: <882730e60b58b8d970bd8bc3a670e598184eefef.1660924379.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

Dylan and Jens reported a problem where they had an io_uring test that
was returning short reads, and bisected it to ee5b46a353af ("btrfs:
increase direct io read size limit to 256 sectors").

The root cause is their test was doing larger reads via io_uring with
NOWAIT and async.  This was triggering a page fault during the direct
read, however the first page was able to work just fine and thus we
submitted a 4k read for a larger iocb.

Btrfs allows for partial IO's in this case specifically because we don't
allow page faults, and thus we'll attempt to do any io that we can,
submit what we could, come back and fault in the rest of the range and
try to do the remaining IO.

However for !is_sync_kiocb() we'll call ->ki_complete() as soon as the
partial dio is done, which is incorrect.  In the sync case we can exit
the iomap code, submit more io's, and return with the amount of IO we
were able to complete successfully.

We were always doing short reads in this case, but for NOWAIT we were
getting saved by the fact that we were limiting direct reads to
sectorsize, and if we were larger than that we would return EAGAIN.

Fix the regression by simply returning EAGAIN in the NOWAIT case with
larger reads, that way io_uring can retry and get the larger IO and have
the fault logic handle everything properly.

This still leaves the AIO short read case, but that existed before this
change.  The way to properly fix this would be to handle partial iocb
completions, but that's a lot of work, for now deal with the regression
in the most straightforward way possible.

Reported-by: Dylan Yudaken <dylany@fb.com>
Fixes: ee5b46a353af ("btrfs: increase direct io read size limit to 256 sectors")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5101111c5557..b39673e49732 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7694,6 +7694,20 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	const u64 data_alloc_len = length;
 	bool unlock_extents = false;
 
+	/*
+	 * We could potentially fault if we have a buffer > PAGE_SIZE, and if
+	 * we're NOWAIT we may submit a bio for a partial range and return
+	 * EIOCBQUEUED, which would result in an errant short read.
+	 *
+	 * The best way to handle this would be to allow for partial completions
+	 * of iocb's, so we could submit the partial bio, return and fault in
+	 * the rest of the pages, and then submit the io for the rest of the
+	 * range.  However we don't have that currently, so simply return
+	 * -EAGAIN at this point so that the normal path is used.
+	 */
+	if (!write && (flags & IOMAP_NOWAIT) && length > PAGE_SIZE)
+		return -EAGAIN;
+
 	/*
 	 * Cap the size of reads to that usually seen in buffered I/O as we need
 	 * to allocate a contiguous array for the checksums.
-- 
2.26.3

