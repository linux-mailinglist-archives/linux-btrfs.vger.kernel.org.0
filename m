Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E115258AC3B
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Aug 2022 16:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240918AbiHEOPN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Aug 2022 10:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240901AbiHEOPG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Aug 2022 10:15:06 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68B558B75
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Aug 2022 07:15:04 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id h7so2125254qtu.2
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Aug 2022 07:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tpyuaUWUEr/HvjX02hJmxRhH53TwNp0wUJb9DBCHLNY=;
        b=nBc3EWzRaKyL8zZG7396mDvBQD4CIyjindesEGw/8KU2XQA0TodtIJ3zQZi0E/Hi9x
         s5AeT5Sg1QVlNk6YipN7qvGmpYAGRzNPnmkHln+vDcKmlWdwhQo7gvW2NDUsj0FeeIM8
         XvT++Vaev3awNDikMQl7wdQihL8/qXcWMHUWsMqdN9FL0dbFOk84t0/90PxatOt/jfdH
         VsPA7GWYyr8XjGTeQ1HsPonv+YnKl1XGxae+saYFEZVVjRJD76PluI9k6HIv3NrnfpiD
         6TEHnFRCZttulX5JRNfX9i6y7WBrpZNK0As6DBZEgxVY2HMef+hrgtndTxvlu7Y0eYlY
         vhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tpyuaUWUEr/HvjX02hJmxRhH53TwNp0wUJb9DBCHLNY=;
        b=J/Ro2TmJ/M55BKedL78qsb3rlTc2HrNH+ByMmJSb5OfkseBaAktkaCiwcLeA8RF2cP
         o88avgJusUJFlpmGjpVG5FoQaGENDrxoHm/6jBMM5pp5TQ03MvTMkzkeJF36iIBou9UO
         BFVm4+YWzA24ZwUej30AGcovqOeJ6p1ZuQ8sIWwtTQSVHxsqLM5FB0wnf5WqPeUL/yNS
         +369ivdWXtT2OE2rTzy8ykjatSnFstH+4h8PZkyb5/t1kzgbUi63fQrYGxqL2D1UYd4C
         hDBrPf3ieGPDBtWH56IFNM6rwxPl3yDXSYARWrEhySkKOjH3TL8/TORWWU5Gc3T/Opfm
         FgIw==
X-Gm-Message-State: ACgBeo2WAljyS1ONSCcYP2r/UZskpmWxCOulXoMFNy4vOSPmKu0gLiEp
        25LR86YUtObhLg7jxJ3CT3AHhy8S4TF2wg==
X-Google-Smtp-Source: AA6agR4jM0xxCcsa7wR0/FVyxraIZFxIwKxhto9Rb93zaZQY5QONeHw1WVgEqQDs7alqbV/XBqGIDQ==
X-Received: by 2002:ac8:5708:0:b0:31f:d02:ff83 with SMTP id 8-20020ac85708000000b0031f0d02ff83mr6033321qtw.555.1659708903444;
        Fri, 05 Aug 2022 07:15:03 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l22-20020ac848d6000000b003051f450049sm2634839qtr.8.2022.08.05.07.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:15:03 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 1/9] btrfs: use btrfs_fs_closing for background bg work
Date:   Fri,  5 Aug 2022 10:14:52 -0400
Message-Id: <d9935db922bf64954df0250391afa246dfe6abc7.1659708822.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1659708822.git.josef@toxicpanda.com>
References: <cover.1659708822.git.josef@toxicpanda.com>
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

For both unused bg deletion and async balance work we'll happily run if
the fs is closing.  However I want to move these to their own worker
thread, and they can be long running jobs, so add a check to see if
we're closing and simply bail.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 993aca2f1e18..fd3bf13d5b40 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1321,6 +1321,9 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
 		return;
 
+	if (btrfs_fs_closing(fs_info))
+		return;
+
 	/*
 	 * Long running balances can keep us blocked here for eternity, so
 	 * simply skip deletion if we're unable to get the mutex.
@@ -1560,6 +1563,9 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
 		return;
 
+	if (btrfs_fs_closing(fs_info))
+		return;
+
 	if (!btrfs_should_reclaim(fs_info))
 		return;
 
-- 
2.26.3

