Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198DA4C0483
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbiBVWXU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbiBVWXT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:23:19 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E800D6A052
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:22:53 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id a19so3482344qvm.4
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QbVBkN3XlY6j4jmnW4C94cRYNQSPdh8Ok2fbNkQNAsE=;
        b=HVTEyvTDwHNTBKZEk426cTqLlWjejmjBKIiFEb1q9MyIBT6xw0RRPoZ5M5c9nQNYrK
         5BOBH4tpaWndUYnRZo7Y8iq79W4ZXq+wFi+krobCKyt6v/uaxMGRMd32sZr7mbLBNC6y
         CzPezQx1CmVTv/t6jmdPnsnDm7sXwA/k2FIdfTHuiZczIlKBHZ7KsRV+7VOAeYWd1Plq
         IOJoVW3c+CtnCXJtrTNpXrzcAgIB/voBpvqP6ntlJPbDHWtBnVRtBSK7RppOdUE+LgNu
         aBsaDZZKOL1lZvp1I6fPF8DgKSoQfuVWjs4eXCBunK0U2EkoTOrye0ByWTfHzMUoJCjy
         dvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QbVBkN3XlY6j4jmnW4C94cRYNQSPdh8Ok2fbNkQNAsE=;
        b=YQX5JfgKsYKEq5hQAWe6piER5xJdEBBe+Vkt+s1B6XiQFgEiadaWoVWvSvR9tMp8iS
         W/CdJntoKtbdUh9r46HwB2cMIW698U4owpmW51LYZciBl7X92KgkV/iz1Vm0VmO0OxhU
         F4Jrg5vnlYX2vitHllKWLO1LDSlFJbj9Qcyd1W2Gs6GfjeB8NxJMhJuFtMIU2lVfXi4x
         F8egzucjEUX/FV95/RfY7WETurT+5EYw6xdD+bF3pDG5JZofM759o0MlniqmiEgiKx+w
         E5BYzS4XwfT54L89ZZWuLOu+9BL5DsALLA4/Ea2/dDJkC+reHM+KKblVrpYi5odjyDpD
         qxaw==
X-Gm-Message-State: AOAM530SOlBbTNQukrImFLX0TKYZCyMa8KnTUq81f0Dfl45ZpGF4rica
        ACFmfZG3DymOHL/kmV+89pgkfw06nn8YBt5v
X-Google-Smtp-Source: ABdhPJxmIFYsTlj/S1Hu22PBQqQ8mGEY+gM3Lnsv8kENhAAgZEgooa+smxVS/RNE+gX8H8eyRfF3hg==
X-Received: by 2002:a05:6214:d82:b0:42c:4038:1cc7 with SMTP id e2-20020a0562140d8200b0042c40381cc7mr21044854qve.114.1645568572844;
        Tue, 22 Feb 2022 14:22:52 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 17sm624909qkr.60.2022.02.22.14.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:22:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/7] btrfs-progs: inspect-tree-stats: initialize the key properly
Date:   Tue, 22 Feb 2022 17:22:42 -0500
Message-Id: <85de81980e760a84783c68668b75771702d5fe4d.1645567860.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645567860.git.josef@toxicpanda.com>
References: <cover.1645567860.git.josef@toxicpanda.com>
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

I started hitting a segfault on fuzz test 006 because we couldn't find
the extent root.  This is because the global root search stuff expects
the actual key to be setup properly, not just an objectid.  Fix this by
initializing the key properly so we can find the extent root and other
trees properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 cmds/inspect-tree-stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmds/inspect-tree-stats.c b/cmds/inspect-tree-stats.c
index 1fa35e7a..eeb57810 100644
--- a/cmds/inspect-tree-stats.c
+++ b/cmds/inspect-tree-stats.c
@@ -447,7 +447,7 @@ static const char * const cmd_inspect_tree_stats_usage[] = {
 static int cmd_inspect_tree_stats(const struct cmd_struct *cmd,
 				  int argc, char **argv)
 {
-	struct btrfs_key key;
+	struct btrfs_key key = { .type = BTRFS_ROOT_ITEM_KEY };
 	struct btrfs_root *root;
 	int opt;
 	int ret = 0;
-- 
2.26.3

