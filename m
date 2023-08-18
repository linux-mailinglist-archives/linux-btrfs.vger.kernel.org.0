Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7A8780D25
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 15:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377475AbjHRN4G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Aug 2023 09:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377536AbjHRNzx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Aug 2023 09:55:53 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B383C34;
        Fri, 18 Aug 2023 06:55:28 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe426b8583so9162125e9.2;
        Fri, 18 Aug 2023 06:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692366927; x=1692971727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tnlBg8i71ZZF5vC/PdEFa3UhFBHInI/WTs75Cw2jAu0=;
        b=SVGMKfENLrPZL4ySpDmshwozLBWz3qQUL/LzznRTsBZjvY+YbU1cGhyUR69IYuZe+9
         Ro7x0sDMEGgCbzgdjCyholFdTLsdFOK88RU+6dlvOPWRH+tOyzrWHOj9pKPOtNuS3NLt
         xUux0MLnL66Q9efYYE3HWpJXE9wGQHwcHyJseiEt/njdVYG5zmX3pCDTdKcGo6qxFlvy
         UpFbRUcTbgNq6IDgzPxk4L1hKUol/5tuvTtuPfvwzJl/hZpE9RFgXONlynPCG+Nl63Xb
         uxOcILp1gbwHefZoHugaHU0y2cNIhSzlzt2B6yOOGsSCLTJqUkm3DoCCTszWObkzC7en
         s1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692366927; x=1692971727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnlBg8i71ZZF5vC/PdEFa3UhFBHInI/WTs75Cw2jAu0=;
        b=eW8YTmE+N+sxDzrZ69hOkLvMq1YYI4PgtJkIVqEk7XxTwZL0/6zqCq7sn3Fb1xSnNI
         d168LA3il57epTbfb07iLZnigrcv/mvj2eEf1xEmwneS6xsnTv62Ue4iD/kAzxQXHx8O
         935YBfLq2V4FWTmsNV+qbVq5dkfiaChgFGKBha0dVBTofMF/gnKGbyfltrv1T3AmEH4n
         fHOiLuPurGmhNb6Kr4LkS9Si0jJaMM9YWTPz0aouyCrwO+USuRmO2B9ih9TDmQ3G/xIR
         +y9y6WF7fjg3F/YENaAfCP5mpiWyLImGWGarPoLXcA7GHEhIte1rfzpHNip50+LME6ep
         9wxg==
X-Gm-Message-State: AOJu0Yz2AuBRFTu7dEo3exTpr0rvlwRNk0dlYkKQuMA6RNNXReyydtI3
        VqAQxKfz2OND+4x+TNk81g0=
X-Google-Smtp-Source: AGHT+IGPwVy7tTV7YnQuwXt82DLo04fv/2T9wNtuF6/+2OjG7pObR0Lfak90HHgIN2Erv+/+KOYRJg==
X-Received: by 2002:a7b:c7c8:0:b0:3fe:2e0d:b715 with SMTP id z8-20020a7bc7c8000000b003fe2e0db715mr2306544wmk.18.1692366927240;
        Fri, 18 Aug 2023 06:55:27 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id t24-20020a1c7718000000b003feae747ff2sm6436557wmi.35.2023.08.18.06.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 06:55:26 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] btrfs: remove redundant initialization of variable dirty
Date:   Fri, 18 Aug 2023 14:55:25 +0100
Message-Id: <20230818135525.1206140-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The variable dirty is initialized with a value that is never read, it
is being re-assigned later on. Remove the redundant initialization.
Cleans up clang scan build warning:

fs/btrfs/inode.c:5965:7: warning: Value stored to 'dirty' during its
initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7d11dbd74956..6441c0053355 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5962,7 +5962,7 @@ static int btrfs_dirty_inode(struct btrfs_inode *inode)
 static int btrfs_update_time(struct inode *inode, int flags)
 {
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	bool dirty = flags & ~S_VERSION;
+	bool dirty;
 
 	if (btrfs_root_readonly(root))
 		return -EROFS;
-- 
2.39.2

