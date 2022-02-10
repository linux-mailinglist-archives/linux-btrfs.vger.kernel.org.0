Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F8F4B18B6
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 23:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345169AbiBJWok (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 17:44:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345155AbiBJWoh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 17:44:37 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A91926F3
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 14:44:38 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id a28so6617043qvb.10
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 14:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KYJ3S10r8G5ghpPvoIoDPlCJ3Yk7TP7rGVkI0C2z2Ps=;
        b=6yVv6BOLeEMLm/unXu8tCzesmT6LVkx4EWrhzwgLaiEtmuUG6gn4Ct1ds8hYtSpYAW
         kTLbOjmliqhJTb4kAvXw3YYhnO09ch+yy1yW39Y6OQzAyrZWjzFpi3SU3lfy9E+fbjXg
         3wj/JRQ+PPUT5om8KIKEIjXe1AIfCK5fcaetnHLML8rtUyO3X8sc4N26uPnXI/+5BY7R
         eNvxjYTI+kXGZYSL+3gS4p0FNzJKfP0lcMPA12H6PF8W6jN1wZ6thvs79Ue9zPd3UXPQ
         B+xYpvMf7xoF92w6yUlt5dwFQwefacY+sJmNsV9RxadZ71rZoTc32og65sNzIey1FHpm
         iSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KYJ3S10r8G5ghpPvoIoDPlCJ3Yk7TP7rGVkI0C2z2Ps=;
        b=Q5Sq7lXIOTqBRwdn4p8p8r+AWeuUpkzayl8xr8jlggutNkr5XUCawX4TVO8pXM5xrP
         GTjidqwY3fKaYRXdgs80mJYmdJUrMvcY6gJZMBFmrrB5UdYeduDSirtotrOuUHGs0u0+
         BWE//c/CZqtoq4BS7kmsJ5qr+zVJ2p1XR3MklQgfQB1lZMdSKxzn4YoT3aMIplyUqIWe
         qbZYhbZo7wt8+CKP/eDUbt90s3MnHl4xzn9BdJ+FkT005XkQQAKuJB5oqZ/55fiNio16
         4KJ8IEiBs0BTq1yPA3nd8NfgqT8RLg1D14VPJ/y4SW7qIaorh234B0XtrAhB4w1hsfhD
         BGGg==
X-Gm-Message-State: AOAM532l0t0LQT/hu2f/M8rDsyMZDXqPhg3SkORr1k0gAKsWHkAvobMN
        AnHmm/nrIJP0azjKM26zMzzT1IIAch82iGNM
X-Google-Smtp-Source: ABdhPJyHB1i5ZItkLKeGjXnAWkzzulNLse4GgXllna0As6qjZOiEiaCy7LCUIJJEDgZ8fsLgL+f1Hg==
X-Received: by 2002:a05:6214:2523:: with SMTP id gg3mr6400192qvb.120.1644533077184;
        Thu, 10 Feb 2022 14:44:37 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a14sm11778545qtb.92.2022.02.10.14.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:44:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/8] btrfs: do not try to repair bio that has no mirror set
Date:   Thu, 10 Feb 2022 17:44:25 -0500
Message-Id: <531eb09d460d686e75e96f0ebafde78c670d84fe.1644532798.git.josef@toxicpanda.com>
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

If we fail to submit a bio for whatever reason, we may not have setup a
mirror_num for that bio.  This means we shouldn't try to do the repair
workflow, if we do we'll hit an BUG_ON(!failrec->this_mirror) in
clean_io_failure.  Instead simply skip the repair workflow if we have no
mirror set, and add an assert to btrfs_check_repairable() to make it
easier to catch what is happening in the future.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bda7fa8cf540..29ffb2814e5c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2610,6 +2610,7 @@ static bool btrfs_check_repairable(struct inode *inode,
 	 * a good copy of the failed sector and if we succeed, we have setup
 	 * everything for repair_io_failure to do the rest for us.
 	 */
+	ASSERT(failed_mirror);
 	failrec->failed_mirror = failed_mirror;
 	failrec->this_mirror++;
 	if (failrec->this_mirror == failed_mirror)
@@ -3067,6 +3068,14 @@ static void end_bio_extent_readpage(struct bio *bio)
 			goto readpage_ok;
 
 		if (is_data_inode(inode)) {
+			/*
+			 * If we failed to submit the IO at all we'll have a
+			 * mirror_num == 0, in which case we need to just mark
+			 * the page with an error and unlock it and carry on.
+			 */
+			if (mirror == 0)
+				goto readpage_ok;
+
 			/*
 			 * btrfs_submit_read_repair() will handle all the good
 			 * and bad sectors, we just continue to the next bvec.
-- 
2.26.3

