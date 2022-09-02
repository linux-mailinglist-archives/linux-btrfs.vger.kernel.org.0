Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94345AA911
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 09:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbiIBHsS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 03:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbiIBHsR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 03:48:17 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA65A1D6E;
        Fri,  2 Sep 2022 00:48:16 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r69so1297662pgr.2;
        Fri, 02 Sep 2022 00:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=M+fD8FD5+7TDwDC6zAvoE0sCYdDhCFrxXlMrBZifOxM=;
        b=A5V0pbkqwQx0stbYGz0ZUwDlgAMJqcBrTtkKVn7KAd1zhyM4/Efp2XpNox9kmDJ9JO
         kUcB0J2ZK8CiR+iDJh4dq+Y7SGbdI22z0XfUDY0OJxm7mOCbUmfkQUnLAjsX25ZT1ubz
         dqXlqWzFOKnggz923HP1JX3/ROhpCga0S9Ppl9+VQLZ6dqqt7Nw7Dq9+H3HGuG9JHDjr
         dtYvXnlj8P5Zaoc6Y/FifTDEoZbgcGI1756ggo25mR2f6uka2NgL5FNEZvHUtHZbiynD
         p99ltZevNXFxuNG5vWZW71lNXjyo71pIPKRoe9xNXIeqVt+RXYXml3pvymqkUw20mR+T
         M52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=M+fD8FD5+7TDwDC6zAvoE0sCYdDhCFrxXlMrBZifOxM=;
        b=YlPJ4AtZOqN/ylCxHrooVFRymj5XeEtYtQbBTlSVJ389vlw/mDBp0+E8H7EK1TG7fI
         lq52IUfm1JkUr0hDHUbve84LEXcVWUxkX36qKiZnqJonkL5ecKjPDkwOAHuUU9+cCWV9
         ADlfYduVk08BojxurhdQ9wPRpQ6DLci8VEenOSw4Yi2xB5Qlf0hQVylhZwx/81P1AMDW
         J3dxIIM4QeOhF3+aS7obGYmYxVDPS1FvGEjYY9k0i49ahaKnaT1k3S8CRJG4/cQxHBlC
         JRaU3uSXxnSVxN6CVmRsVH+NFOT3qD9c9l5unJj7ywu/9/t4ymclsnPoHTlrNY3oiQK8
         dMew==
X-Gm-Message-State: ACgBeo2KeqoRbjaZ5f1my2wahKvQa3Tbk5cBcClIDwN2vub9DTpN3fnZ
        kun4I07lU4DAt9vuWuBRX09qLpmSHq4=
X-Google-Smtp-Source: AA6agR4a9HbQFBgaX1xpz2+hcOxbmCixu3pSM4Ye+5Zl5li6Mu12y4rCUC9WkUMnV3T47ZuUXZUmng==
X-Received: by 2002:aa7:92d8:0:b0:537:acbf:5e85 with SMTP id k24-20020aa792d8000000b00537acbf5e85mr34639862pfa.61.1662104896493;
        Fri, 02 Sep 2022 00:48:16 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id az11-20020a056a02004b00b004296719538esm780208pgb.40.2022.09.02.00.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 00:48:16 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.songyi@zte.com.cn
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhang songyi <zhang.songyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] btrfs: Remove the unneeded result variable
Date:   Fri,  2 Sep 2022 07:48:10 +0000
Message-Id: <20220902074810.319914-1-zhang.songyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: zhang songyi <zhang.songyi@zte.com.cn>

Return the sysfs_emit() directly instead of storing it in another
redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 fs/btrfs/sysfs.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 41f191682ad1..6268dade57d7 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -839,11 +839,8 @@ static ssize_t btrfs_sinfo_bg_reclaim_threshold_show(struct kobject *kobj,
 						     char *buf)
 {
 	struct btrfs_space_info *space_info = to_space_info(kobj);
-	ssize_t ret;
-
-	ret = sysfs_emit(buf, "%d\n", READ_ONCE(space_info->bg_reclaim_threshold));
 
-	return ret;
+	return sysfs_emit(buf, "%d\n", READ_ONCE(space_info->bg_reclaim_threshold));
 }
 
 static ssize_t btrfs_sinfo_bg_reclaim_threshold_store(struct kobject *kobj,
@@ -1205,11 +1202,8 @@ static ssize_t btrfs_bg_reclaim_threshold_show(struct kobject *kobj,
 					       char *buf)
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
-	ssize_t ret;
-
-	ret = sysfs_emit(buf, "%d\n", READ_ONCE(fs_info->bg_reclaim_threshold));
 
-	return ret;
+	return sysfs_emit(buf, "%d\n", READ_ONCE(fs_info->bg_reclaim_threshold));
 }
 
 static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
-- 
2.25.1


