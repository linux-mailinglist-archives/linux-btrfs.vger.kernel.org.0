Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB740458461
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Nov 2021 16:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbhKUPTL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Nov 2021 10:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237517AbhKUPTL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Nov 2021 10:19:11 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E693C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Nov 2021 07:16:04 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id x5so13846955pfr.0
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Nov 2021 07:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ebh5aj5rpGoa4j529TvA+KatIVMiYHpQc4kB3myb+QU=;
        b=QbHQrX7opl1ZpC9aDcK9TZ4yQJtdB3xXrmzdLW1uyVVw1CinqtPFHrZnfS7VAYoqSG
         fJ2b45tdCM40/TybO1KUb2tUL6gksPsnFy5qSSpVSGsBkJvq2rlPH4QwTvxjvuLVwcNI
         stXjVY+UTitohMtfRa+EMYFxbhd3muszKXRtDl8O7jURzyLq71JRBeTawzs/uzKH5Myu
         Twmqh8T8raQLdp7zeooSX4zU3AR3bNE3DoZSLwHbrNyXbPIReYEh2AwssGwZnB4Z/Q2U
         SCEecLOqxVukCEdWZKpKghkcftRn4FGmR2MaxMM/4FzH6BIMzbbvwLMMlfu2cfyxN5kv
         9+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ebh5aj5rpGoa4j529TvA+KatIVMiYHpQc4kB3myb+QU=;
        b=v4WS2gqvivz/x/ukS6C85CECE7habDKS95TDB7W+JzJDUEiDCC8yh/IXFkxETGoAff
         uQHxuLxmqPCTkxSoX6PcAdDoSN/M1dOFoQnb46EYtKqgfeHgVyLfry6bEw6NuWpHaN2v
         yWLalL93e6FOSxHfpiGvGqHpaUxt0d+2wYFkb6lM8lUdZMqhG0TmxehKV/srNa6NPLLu
         BDT7sZa2NTB5+sgFTJJ4v9BdbCZ8B4Zc1/66bwjUOs3LT2FQwwbH3na+z8WDOy1Cd6lD
         Dazrp/xbrTXg0ke8dDKcVvKF3KY+66PaPCIk8QEbtoPrciuKHWzazsQ40OGDVMXMTRUq
         Q3tA==
X-Gm-Message-State: AOAM5316Ktn2PryrMw4xOVxJtHLamW32hPr0pTv8JZpXBMEt2K7IKLwA
        oUuRGcHR15nmW8PNNPH4nA7qGtV03ovRCA==
X-Google-Smtp-Source: ABdhPJwSE8fjIs1TUMmYqOynv4YZ1JX/RHh2VYdc8BRnvo8sqTJmBc/yrB18C0UVYADqckGY2ny10Q==
X-Received: by 2002:a63:cd12:: with SMTP id i18mr27060962pgg.275.1637507763479;
        Sun, 21 Nov 2021 07:16:03 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id y28sm6198125pfa.208.2021.11.21.07.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 07:16:03 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v2] btrfs-progs: filesystem: du: skip file that permission denied
Date:   Sun, 21 Nov 2021 15:15:56 +0000
Message-Id: <20211121151556.8874-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch handles issue #421. Filesystem du command fails and exit
when it access file that has permission denied. But it can continue the
command except the files. This patch recovers ret value when permission
denied.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 cmds/filesystem-du.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmds/filesystem-du.c b/cmds/filesystem-du.c
index 5865335d..fb7753ca 100644
--- a/cmds/filesystem-du.c
+++ b/cmds/filesystem-du.c
@@ -403,7 +403,7 @@ static int du_walk_dir(struct du_dir_ctxt *ctxt, struct rb_root *shared_extents)
 						  dirfd(dirstream),
 						  shared_extents, &tot, &shr,
 						  0);
-				if (ret == -ENOTTY) {
+				if (ret == -ENOTTY || ret == -EACCES) {
 					ret = 0;
 					continue;
 				} else if (ret) {
-- 
2.25.1

