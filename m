Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D925AB5AD
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 17:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbiIBPvg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 11:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236944AbiIBPvV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 11:51:21 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C701256C8;
        Fri,  2 Sep 2022 08:41:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c2so2247551plo.3;
        Fri, 02 Sep 2022 08:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=NiT6lwsOByBDjSrBtI0DMU29yH7RUQLqoFz0N6lVba0=;
        b=U5paxHln5/ZTK1CfbqzZUbKDM0GC86vgBafxovbbjPTfBCZraQiYNuN+rYCmr4Xhzl
         /jPGpdeAhkXfmoMEpcNq6M4wB73lypethirnOJm+cnA2xwkcLUOrAcj0LjDbY1R1cZ/V
         NJ9fVFtkO+hzCGcg7/J7qxjxPorwr91n2niH79P+bxOgzlMi0iWxHWpDDdvsGkqpWyqQ
         po09vjDVu506gACM33TkPNXzHHqeKZroi/Vgwg370T/cF96KirwAuqMxa4eg6qWrgmzq
         Lnyz+CQUzSeKHAWafUMBRE4RggPmHzGG0quBPxOO+S0rYUm4izpTgGLexZP15f8lh85H
         Cb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=NiT6lwsOByBDjSrBtI0DMU29yH7RUQLqoFz0N6lVba0=;
        b=l8wxAmkgGErOh62qfNVlEtVSYkUbcCrXk8oKAM5/TDVXfAhcZRdLyqunUOAbNfbwCl
         NEWjAast6sJPYfGeld0V9bjpFWmAN60BuvgFK97+WCwM1M1aOVH1j67tiR23n/VnfCwW
         zV8haTRUAaoQAkJ71qJ6k3VHzy0kHk2Qxk09UI7eD7aYcD+b0ktIzQjjoL3L46Rjww1M
         gGNKiRbU7YiWBtXgjWmLPNck8ovf3X4e26S9inQ3He/ze5NXngjaIU0BZjFfMvihKqNq
         qYA989bggVDrKWaVBTibYCS0AzIf5i/Z6RC/48b5CQiCpTWk1zl+PNVy4lq9zy5QhEmS
         7w2w==
X-Gm-Message-State: ACgBeo15AlXcDYhz6DhAROoR24/XWMS/ofiWPIZ+/eVtwbnundrL2DQ6
        qHGWg5fcgo5PfwX+kxajXUg=
X-Google-Smtp-Source: AA6agR51EZwj1x3zMbt1Si9gQXPeS+1CVbvRmC2LuM6zVZtL0ZB+4CiMIcc1Yoluz0Q82ZZU7adoiA==
X-Received: by 2002:a17:90b:278a:b0:1fd:c2bf:81f5 with SMTP id pw10-20020a17090b278a00b001fdc2bf81f5mr5429737pjb.81.1662133297509;
        Fri, 02 Sep 2022 08:41:37 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b20-20020aa79514000000b005327281cb8dsm2016547pfp.97.2022.09.02.08.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:41:37 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.songyi@zte.com.cn
To:     dsterba@suse.com
Cc:     clm@fb.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhang songyi <zhang.songyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] btrfs: Remove the unneeded result variables
Date:   Fri,  2 Sep 2022 15:40:29 +0000
Message-Id: <20220902154029.321284-1-zhang.songyi@zte.com.cn>
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

Return the sysfs_emit() and iterate_object_props() directly instead of
redundant variables.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 fs/btrfs/props.c |  5 +----
 fs/btrfs/sysfs.c | 10 ++--------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index a2ec8ecae8de..055a631276ce 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -270,11 +270,8 @@ int btrfs_load_inode_props(struct inode *inode, struct btrfs_path *path)
 {
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	u64 ino = btrfs_ino(BTRFS_I(inode));
-	int ret;
-
-	ret = iterate_object_props(root, path, ino, inode_prop_iterator, inode);
 
-	return ret;
+	return iterate_object_props(root, path, ino, inode_prop_iterator, inode);
 }
 
 static int prop_compression_validate(const struct btrfs_inode *inode,
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
2.15.2


