Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132014B9215
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 21:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiBPUGp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Feb 2022 15:06:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiBPUGo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Feb 2022 15:06:44 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F4C15A21
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 12:06:29 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id c14so4037199qvl.12
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 12:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gN2fEVqamYWlKHGoZfA7PANhN28h+aXSgF5oIIl2Ti0=;
        b=6nJ5XZJ2+yfLJzIXXp4w5yajKHUgD6+FiPusFiHni1pd5ja39RTFFKyI8rewHcUHdj
         0kNwNuh1RxoROUDA2s1mJiUvbuMpXEb9W0iGC2duIC3eMT1oVZs8tF0Hjs06KfdFA3+v
         AZjcyYVXd2vCsJVCVs0s8mJbyj+NbS7WOKKRcJ2z5V9ze5uPD/UIiViDFBP8M5QR012L
         ZnB8VlUafO8C7F0neXmv1b+O5C4ew3ln6F/GjK1C0aUkYP2v1Hz3SR8gftu4+E1fFCg7
         b2r6by5PnjmyHPndtuxswbp2XIcNi/ZlrdU/vaQNgfl4cXUwvFKRvsFCmmz8WzC8A9fd
         A7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gN2fEVqamYWlKHGoZfA7PANhN28h+aXSgF5oIIl2Ti0=;
        b=6+1F3fRzonhfwB2wNVjEiz2sjc3WFOLXm97hzFtHhJYq7qoaok2wdxlwwosglJh6dE
         lulp0XUmTjJHP02mSlWBUR9dMZLN12n99FiHzFljoTYe/uvCJEToY2Q0V0neliP9QQ4p
         YMkx0mz/+1vFPxgIGJnh6yPycthKlaU2x/rNuW0OImIcK14gmID45XBdDmf1rTDVDeN2
         9uTost/ZcNRH0k7/v4fGwezjKVy1eyfOM5EOS5fbS1PVE22wfZrJGb0bTy+XQUhFIhG7
         RCmrTm0k1ccPSqN2MARNpa3cLUKalDkKKRIRFYvZcUvLsRGSdzOZgPKoHx+k4TLgshYn
         T3dg==
X-Gm-Message-State: AOAM533UTDD+1Px96/w6sKmRPQLqjeMmv1O99FOpVHqP//La2772jjRD
        YWDqM0p+KRUcyKrQ6zFKX0Wtyeekdx1QOCGB
X-Google-Smtp-Source: ABdhPJzs/XjPiNUp/jXXcmiGyzYRQGnyavPerBVVFTO5doIDGJdIXsFmQKp2VFmih5yCefHmid1BRA==
X-Received: by 2002:a05:622a:1007:b0:2d0:5c40:560e with SMTP id d7-20020a05622a100700b002d05c40560emr3374914qte.220.1645041988450;
        Wed, 16 Feb 2022 12:06:28 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d23sm2110028qka.50.2022.02.16.12.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:06:27 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: remove the cross file system checks from remap
Date:   Wed, 16 Feb 2022 15:06:26 -0500
Message-Id: <ef6f142a8be5bb8a3d2ac2643cc01870038f11b9.1645041975.git.josef@toxicpanda.com>
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

This is handled in the generic VFS helper, we do not need to duplicate
this inside of btrfs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/reflink.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index a3930da4eb3f..4425030e09cb 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -771,10 +771,6 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 
 		if (btrfs_root_readonly(root_out))
 			return -EROFS;
-
-		if (file_in->f_path.mnt != file_out->f_path.mnt ||
-		    inode_in->i_sb != inode_out->i_sb)
-			return -EXDEV;
 	}
 
 	/* Don't make the dst file partly checksummed */
-- 
2.26.3

