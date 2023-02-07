Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB4468DE5B
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Feb 2023 17:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjBGQ5k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Feb 2023 11:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjBGQ5i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Feb 2023 11:57:38 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867573B66F
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Feb 2023 08:57:37 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id z5so17425808qtn.8
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Feb 2023 08:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/8Ov+EXfWkaiUuJFcvyiTin0ayVA6iKg40H/7pfVLg=;
        b=DqrJD5sqwItz/3PI3aJMAkOLVxnP+pSgyMHj30izKbxTL3KpUjBKoThy9lLj+y09b9
         13ksEHueWEF8vOVm4u5eMQC9SbmVegeuCUAbFldrPfx00Q9bLp1y8Qvx6XZCk4B6q+iA
         Vi/iLtEwxFPmN/C7bCkhH7utzFGihRPkwURpfADezqngNDu5dsAM6fcfJtu1FF90hLm6
         6Pa8xuFb4La1+8x3XXOI9bwxt7+tWjc6cqatMgNDCU7g2w5j0LW1pYoK42VDKFMKFVf/
         tHlHsMJzFRS3Weg9iHAf1TfUcM/HiwIwdIaQlUcBc8GYIo7OKmswKVotWDxT0GLHwDED
         /03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/8Ov+EXfWkaiUuJFcvyiTin0ayVA6iKg40H/7pfVLg=;
        b=OBx4Zl4ruDSfPsEOxsHT0qzdAK+m60wp9Cg0zcYUiBPn/+BO8F7fJPvGhlz3LckWYJ
         5jB+qX2+Y9PfepZXx/lbLDWyuFmoF+GBKSfWwde9cAAgc5XKZhGd6lxipwTGLAmY2G6G
         7pWP8V81BZHbqJxTPIcpOaV3Xxxza75pPmHoCokLxYbYokD41v9o2D5f1t5BotK3Ztjh
         pibqydsS7/0ZfXyHy3ApDBhL4Dhs/nuJeC1b/yEoo+OIS07x0RWyC0F84hUxrKvX71tU
         eb32UZyBAgPmr30zjNEjLmEEthR4IqtmizL9+GNCKQJP8RF25dVcrPtgcMagC1VsxidS
         WsJA==
X-Gm-Message-State: AO0yUKVteAtZU8f7SYux9UQZuugHT+D0G4ylt9JHu9uBJI3TyGMGwTwf
        ToMqq2FBJeChSMb/cQKrmSOgXe24rBjZc5+EcAI=
X-Google-Smtp-Source: AK7set+x4KsFdcoDx78XXuNCXyuItTlsxkvYK7FyjiRvKQ3L3bXnrcg5r/YbJltZikClXC/VTym9Ew==
X-Received: by 2002:a05:622a:1aa2:b0:3b8:1723:6d15 with SMTP id s34-20020a05622a1aa200b003b817236d15mr6664278qtc.58.1675789056264;
        Tue, 07 Feb 2023 08:57:36 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id ga17-20020a05622a591100b003b68ea3d5c8sm9896115qtb.41.2023.02.07.08.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:57:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/7] btrfs: handle errors in walk_down_tree properly
Date:   Tue,  7 Feb 2023 11:57:24 -0500
Message-Id: <759ff5e0931e0f2ceb836daf48e84fb7f7c8fe4e.1675787102.git.josef@toxicpanda.com>
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

We can get errors in walk_down_proc as we try and lookup extent info for
the snapshot dropping to act on.  However if we get an error we simply
return 1 which indicates we're done with walking down, which will lead
us to improperly continue with the snapshot drop with the incorrect
information.  Instead break if we get any error from walk_down_proc or
do_walk_down, and handle the case of ret == 1 by returning 0, otherwise
return the ret value that we have.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 824c657f59e8..30720ea94a82 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5509,11 +5509,11 @@ static noinline int walk_down_tree(struct btrfs_trans_handle *trans,
 {
 	int level = wc->level;
 	int lookup_info = 1;
-	int ret;
+	int ret = 0;
 
 	while (level >= 0) {
 		ret = walk_down_proc(trans, root, path, wc, lookup_info);
-		if (ret > 0)
+		if (ret)
 			break;
 
 		if (level == 0)
@@ -5528,10 +5528,10 @@ static noinline int walk_down_tree(struct btrfs_trans_handle *trans,
 			path->slots[level]++;
 			continue;
 		} else if (ret < 0)
-			return ret;
+			break;
 		level = wc->level;
 	}
-	return 0;
+	return (ret == 1) ? 0 : ret;
 }
 
 static noinline int walk_up_tree(struct btrfs_trans_handle *trans,
-- 
2.26.3

