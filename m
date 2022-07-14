Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DCA574090
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 02:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiGNAeS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 20:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiGNAeP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 20:34:15 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0E211177
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 17:34:13 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id l11so349423qvu.13
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 17:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3c2liFqiUTLj/7c9QXj7muzA6VTKrrRDMy8LKzdfPMY=;
        b=qyg/+UKj55+zx+dX3zC7UMlINsltdqdXX0VdG/THwhyX+plGUkpDf+Tx13U4rthNyk
         hoK5agcfGxPbPpPmRiKsD/nyku6MmM6+dXp/5Btaah5rE8ozMjblf7coVV2LHk4CJCab
         MLZFvtxphtClEpoEDepnROPhEPXXCWPVVkIiOEFbQXIrYEzTnkMAfkDmW1w81BTWnQKm
         eOTmIwjpiCHNWSLYgIZd9GnVJ7OADrOaRPM7FIEVdPjlkxCeDLZNKQwlAN3LVT+Uk5jZ
         B3jzr9dGQB1ptnHsZ2xC6sm05ps7D9fOBynpo/TMdM0AI/V7ovn+96SQuWzHqAYjf32o
         s/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3c2liFqiUTLj/7c9QXj7muzA6VTKrrRDMy8LKzdfPMY=;
        b=W8OlP/3BibZl+ypEtuVqbZJvwkG2woDW/deLtE1pxejHxiYQ2P14rp7J63rBKKlGKJ
         msRX2mzjp6QIiS+IXuiM4fElxsrpbB8jmKRzo1v8SN4pZ7yXNesRNS9Y+v+hJ5/0Rzmj
         AZ9iEUpOsauDos/tQn4odVX2jQQc2EHaO0TB3q7WgAxVVmG9PjVLYJ2y7Holvqhyi2ZS
         mBjVYZMwTFK5pzTRMXwyFORviAOZi1OcNCGOtYMf6U6rhLTmIWeeG3OHwqI3A9090fH7
         HCuPxA0+3wT7ukSXfAWzsuXhjcLcPWGUoGjdgGtookYmVwtCrYzzrhObpsWTh19H+IX3
         uvYQ==
X-Gm-Message-State: AJIora9/0iCziWir6OL1KAEkLatT592Kp46StthTb82M4VCgm6KbwOnY
        LQe4FM/X9gECu39CRxdrIBqjyn6dVnEeTg==
X-Google-Smtp-Source: AGRyM1u4WgGld/dN3RvH0uLv3wRIR6mowwJAyshirh0Ly884C+vdtkLoOciKrJ5jAB90ar5vmBYSuA==
X-Received: by 2002:ad4:596f:0:b0:473:2ebe:db7e with SMTP id eq15-20020ad4596f000000b004732ebedb7emr5714897qvb.106.1657758852393;
        Wed, 13 Jul 2022 17:34:12 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i4-20020a05622a08c400b0031bed25394csm264452qte.3.2022.07.13.17.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 17:34:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/5] btrfs: use btrfs_fs_closing for background bg work
Date:   Wed, 13 Jul 2022 20:34:05 -0400
Message-Id: <7a3bde7c329b45fdfc3335e9ba57c6e1205cd131.1657758678.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1657758678.git.josef@toxicpanda.com>
References: <cover.1657758678.git.josef@toxicpanda.com>
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

For both the deletion of unused block groups and the async balance work
we'll only skip running if we don't have BTRFS_FS_OPEN set, however
during teardown we park the cleaner kthread and cancel the reclaim work
right away, effectively stopping the work from running.

Fix the condition to bail if btrfs_fs_closing() is true instead of if
!BTRFS_FS_OPEN, which is cleared much further in the process.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c3aecfb0a71d..1e61d967d8be 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1318,7 +1318,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 	const bool async_trim_enabled = btrfs_test_opt(fs_info, DISCARD_ASYNC);
 	int ret = 0;
 
-	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
+	if (btrfs_fs_closing(fs_info))
 		return;
 
 	/*
@@ -1557,7 +1557,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	struct btrfs_block_group *bg;
 	struct btrfs_space_info *space_info;
 
-	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
+	if (btrfs_fs_closing(fs_info))
 		return;
 
 	if (!btrfs_should_reclaim(fs_info))
-- 
2.26.3

