Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FAE37002B
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Apr 2021 20:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhD3SHv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Apr 2021 14:07:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42828 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229750AbhD3SHu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Apr 2021 14:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619806022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=D7miYpQHKUyjQ+9R5jWrbmacmh9BSN80I7pxXKphNsc=;
        b=Y75OeA/nY5Mrlo2ykQfETuarKJwXxHBf8uoJYJdm6ElnbQ7XTmPVjoLLMtVuROHM/38Ach
        2I6tDybH8fyV0u9mFjtPndrcUlRuKn626c19cF6c/lIP1zcy12FRZ4HP7rY+A24Ijgjdvu
        X+igsG8k10naG9WLsBuO7BTE7hNi0ZQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-D8WHDCFgNoSMwvWY_Mt28Q-1; Fri, 30 Apr 2021 14:07:00 -0400
X-MC-Unique: D8WHDCFgNoSMwvWY_Mt28Q-1
Received: by mail-qk1-f200.google.com with SMTP id u126-20020a3792840000b02902e769005fe1so4151150qkd.2
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Apr 2021 11:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D7miYpQHKUyjQ+9R5jWrbmacmh9BSN80I7pxXKphNsc=;
        b=LC4Pc0XhF1qAJSixgyg1vbpDtGrUYd9BJAA26Ja5rrFAb+y4frT6jBtCfkDdcuUVuo
         HzLpJB8fgkKw/FkrIASxCUG2g887q9wNvrXTI7v2LLdTq8KDHQp4ozpYXi1vkDhnGlr0
         3nyZgz0ynNKcPcUnZcl9bGPUDybbDBnMNgK92fQEpIDIRdMeuNzpVpZtz39GIw1b0viX
         VOzK2/0h8bKXXMd9qO1m2Qu2pZ2DW8p5OG3n7on1xaT1bVu+VUASreY4qbPtk1hwGUjw
         T/v383AFaMNlEoLpTDHe28nFQyv3M/QTM73ObYwbeR5Ci2GTaM4qLc01omaVlcN3+wAF
         PocA==
X-Gm-Message-State: AOAM531xXfJadaomsdk/b/YOZGA+xjeBFnKyDaNNPGhuKS+9nzeiLyd/
        dFEM4o0Ft0SEsHNe2OdA76S8QJGOi/ILcE3q8z7u4GfuRudhrBs+lMGiAkwdJSCiorInpImIay7
        m4Q3iEBuE/kCN8ZFgYgARVDc=
X-Received: by 2002:a37:7a05:: with SMTP id v5mr6870612qkc.266.1619806019280;
        Fri, 30 Apr 2021 11:06:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAlxc1hPUTwEYH0l2ED+glJWfPMlmvkcqtM/2BRdmPojLgUYqc00LlHS8YezDjVVdYYegf3Q==
X-Received: by 2002:a37:7a05:: with SMTP id v5mr6870595qkc.266.1619806019138;
        Fri, 30 Apr 2021 11:06:59 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x19sm1965052qkx.107.2021.04.30.11.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 11:06:58 -0700 (PDT)
From:   trix@redhat.com
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] btrfs: initialize return variable
Date:   Fri, 30 Apr 2021 11:06:55 -0700
Message-Id: <20210430180655.3328899-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Static analysis reports this problem
free-space-cache.c:3965:2: warning: Undefined or garbage value returned
  return ret;
  ^~~~~~~~~~

ret is set in the node handling loop.
Treat doing nothing as a success and initialize ret to 0.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/btrfs/free-space-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index e54466fc101f..4806295116d8 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3949,7 +3949,7 @@ static int cleanup_free_space_cache_v1(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_block_group *block_group;
 	struct rb_node *node;
-	int ret;
+	int ret = 0;
 
 	btrfs_info(fs_info, "cleaning free space cache v1");
 
-- 
2.26.3

