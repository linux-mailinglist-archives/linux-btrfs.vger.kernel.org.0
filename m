Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B3968DE59
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Feb 2023 17:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjBGQ5i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Feb 2023 11:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjBGQ5g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Feb 2023 11:57:36 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991073B678
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Feb 2023 08:57:34 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id g7so17425200qto.11
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Feb 2023 08:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iU4Wd8H0qlqydpKRcgz3tyHJ6o0cE0TQGgQrfV9/uDk=;
        b=6iKTSF72Jcy4tbHhdctu2N2tTIShdsABoc1wFnR3ha7xD4/oaxTXMi60SUsBCCJ07m
         aB1U2k6xHC9V4Oq/kbqyDNwxPva3x0sQnGIbXpUy+KrhNv/Bj7RJ0JNgtj7WmgGlNdAw
         DH/+bmMHsQQI52xfC+R1YLgX2g+5jd4d1woURwktLakRyIag8j4c2Lb0iA8B/o36qcnP
         0dfGcjIhQWoHxsWTEbpXQbRvgCC64Xkuh7hRihv/if7j4aItbpe3pilhErcdE3SjUe8o
         4OKSJhw4ECpvise18MoEcYujVZ8Fd7zqEI1ayquoUaRDfLlzNfIblpkVBUR0TEQurX1S
         wWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iU4Wd8H0qlqydpKRcgz3tyHJ6o0cE0TQGgQrfV9/uDk=;
        b=NRr+yHZrSAGNCzvH42Wc1fRlINbH5LFAXM4WH5mgzDdE5eUKWyuB/X0DMGomwFWq3Y
         SZP5e5/jZdLar832yYvTC1p3ik91205Yl6t9H6UO+PBUbmBzEq3s8rfHmij9TDg/12uF
         1tP7nSdnhomzY5aZVwQprdkn71BxzS2utIwLm+xt4YR55HOc3ZuAXM8R1Xcv/6ndWnqn
         QiC6S8XKaBPzksyGEOIR7E0SFx+daPJlBUg0GyCooo8j9gdz1IKHl2aQSEDf9rv7Ihnu
         37p0tgcAbhSQPID78P9L3JQ/0J1DyOiDVlzrqq/lyd9h7BYswpxNOq1v1r4IiBZ+bRxI
         CvIg==
X-Gm-Message-State: AO0yUKVb0mRhKt8Ctymjhc3M9W2h34DN+o3nMVf8elJsjqAqOaKIq41f
        O8/UwPyCKgYMgdgjqxb4EbYTCOLfg3GkdbO7aHQ=
X-Google-Smtp-Source: AK7set/Xa+CQnFEASzkN4sLlHD5kDaQsGM8XagDaDxiR90pWdIQ93eeRZJPDTssqko3bPUllgg/aYA==
X-Received: by 2002:a05:622a:3d0:b0:3b6:3ad0:5470 with SMTP id k16-20020a05622a03d000b003b63ad05470mr6508845qtx.31.1675789053255;
        Tue, 07 Feb 2023 08:57:33 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id l16-20020ac84cd0000000b003b9bf862c04sm9633770qtv.55.2023.02.07.08.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:57:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/7] btrfs: iput on orphan cleanup failure
Date:   Tue,  7 Feb 2023 11:57:22 -0500
Message-Id: <9544841f53fef72784c0ec3f62c746063eb9ffb1.1675787102.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1675787102.git.josef@toxicpanda.com>
References: <cover.1675787102.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We missed a couple of iput()'s in the orphan cleanup failure paths, add
them so we don't get refcount errors.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2fd518afc4f3..09a3f7836400 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3691,6 +3691,7 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 			trans = btrfs_start_transaction(root, 1);
 			if (IS_ERR(trans)) {
 				ret = PTR_ERR(trans);
+				iput(inode);
 				goto out;
 			}
 			btrfs_debug(fs_info, "auto deleting %Lu",
@@ -3698,8 +3699,10 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 			ret = btrfs_del_orphan_item(trans, root,
 						    found_key.objectid);
 			btrfs_end_transaction(trans);
-			if (ret)
+			if (ret) {
+				iput(inode);
 				goto out;
+			}
 			continue;
 		}
 
-- 
2.26.3

