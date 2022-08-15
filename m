Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DE6593184
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Aug 2022 17:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243135AbiHOPQ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Aug 2022 11:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242990AbiHOPQS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Aug 2022 11:16:18 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FE0240B2;
        Mon, 15 Aug 2022 08:16:17 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d20so6855137pfq.5;
        Mon, 15 Aug 2022 08:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=3ZKThVe84WRyb15COD1liCnaOHlKv40e1Vz93ePbJ88=;
        b=DUlP7ypHH/2UZOVrviR/78RpqjcWeW2uX6hlsAW4uJ0+cEBsCV0Hv3qhU9W4JHs6ex
         dmAZ2lDmfu1TKSuPgzlDVl4UwFPYfq72td4xzy03tVPFqEgpFGr7tE2zctBxTffRo0Cf
         0Uv5vlka6zew6UVCS7VtZEBYgr+u3u4H7iZTETfABsYPboewo/oWpBlJjF5cNH/U27TA
         N0zvTPorVAH5DWrk3nciL/46w/lxvLPs7b6cwzegpQnehrNKNcM6qL8sAQjkitWVBJmj
         qdM8/XFbOlB6ICNm6n1qbK6MEylKl580NQNI9oLVpHq86VIC09tSnrhnJ9UWGrU9Fo0i
         H0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=3ZKThVe84WRyb15COD1liCnaOHlKv40e1Vz93ePbJ88=;
        b=Z5Z9QixfP10Gw7WnI2U/S6CCWi5GP8Vwqq9qfCQyOvhC2aLmU7Hph3S0r761k+0ukq
         KcazXtSZGXEIsQ0qMY+Ms6DMD1GeJCyqv2iAIdTdL/1aEn2JcIbaZvQG3T7sOYgYydWJ
         J9vbYsKPurM4v38GgJJwVJp0Q/eiV5TzwOlg1/R1L0xu0u7D53lRoBOtjc0jHV51EEy8
         h4NJw3jXIrLgD9yA+9g6lJwsjl6xDAT3D80LNhebNH5lqJvEUkZrMOUii4PycboIDfUn
         OGaTe2Y0Of4M2ZC+3TAVTkVG0Q1ZLoh8YUcktBKcZTPNa3hd4EzDMOak70bXk+wR8zks
         gDlQ==
X-Gm-Message-State: ACgBeo39A4roDVtowQboa2M7CxKo53/co4qomb9vGva0vgaLbHdGU4SN
        mVdxCZSxauwsXKLVZNbYdNTglZcr4dhNeg==
X-Google-Smtp-Source: AA6agR4A3V4wAgNelNe4hjuW1BEQB4BZ8TVkLfe5hRKj5f2Nfy9XtwqBu3doGzBrCCGLx/n7p1TzNA==
X-Received: by 2002:a63:4b49:0:b0:427:e7f2:c04 with SMTP id k9-20020a634b49000000b00427e7f20c04mr6967008pgl.262.1660576576358;
        Mon, 15 Aug 2022 08:16:16 -0700 (PDT)
Received: from localhost ([166.111.139.139])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902e84400b0016dbe37cebdsm7121060plg.246.2022.08.15.08.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 08:16:16 -0700 (PDT)
From:   Zixuan Fu <r33s3n6@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, Zixuan Fu <r33s3n6@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH] fs: btrfs: fix possible memory leaks in btrfs_get_dev_args_from_path()
Date:   Mon, 15 Aug 2022 23:16:06 +0800
Message-Id: <20220815151606.3479183-1-r33s3n6@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_get_dev_args_from_path(), btrfs_get_bdev_and_sb() can fail if the
path is invalid. In this case, btrfs_get_dev_args_from_path() returns
directly without freeing args->uuid and args->fsid allocated before, which
causes memory leaks.

To fix these possible leaks, when btrfs_get_bdev_and_sb() fails, 
btrfs_put_dev_args_from_path() is called to clean up the memory.

Fixes: faa775c41d655 ("btrfs: add a btrfs_get_dev_args_from_path helper")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Zixuan Fu <r33s3n6@gmail.com>
---
 fs/btrfs/volumes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 272901514b0c..064ab2a79c80 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2345,8 +2345,11 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
 
 	ret = btrfs_get_bdev_and_sb(path, FMODE_READ, fs_info->bdev_holder, 0,
 				    &bdev, &disk_super);
-	if (ret)
+	if (ret) {
+		btrfs_put_dev_args_from_path(args);
 		return ret;
+	}
+
 	args->devid = btrfs_stack_device_id(&disk_super->dev_item);
 	memcpy(args->uuid, disk_super->dev_item.uuid, BTRFS_UUID_SIZE);
 	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
-- 
2.25.1

