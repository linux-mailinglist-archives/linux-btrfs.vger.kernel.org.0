Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B31357C581
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 09:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiGUHsh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 03:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiGUHsg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 03:48:36 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AC01A047;
        Thu, 21 Jul 2022 00:48:34 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id bf13so915721pgb.11;
        Thu, 21 Jul 2022 00:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CahuWWR4zxNQXuXYtK+Qxq8UGPvryLKguGzPewwT7SI=;
        b=DMffXGnAAUR8ov0IAHtgqIKDmvclcUmJMc8G/AfyPhlWQnvFWD09r4RWTLzrJTsy3P
         hWSzrWsCfZXumrWp5o14T+6xwRkxJTlK/Qg34R8QJIZpvlVae4bjUzZ9ROWNlDh/hBI4
         +xWlx0H0ETFrOkQv73mlCWC9zITms3Wf4fEP56eO/GPPmv4oPZfp0oCjd5JOSWaSVTLO
         iW3FBLkB2Juc9HaQK8j4GnNTBaH2eIpB9ffrjXFPZlBkHL97ys9zwntocr2Y2D+1cvQ/
         VeAdvhIZG18ltv/hIe4jziKceQhBVyVa8r+CwcRKcVBmmYJpayuSSsQnXA+qnflcDUwJ
         2c+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CahuWWR4zxNQXuXYtK+Qxq8UGPvryLKguGzPewwT7SI=;
        b=coOxEBJlxYFhucjff6CkHg81oKgklf9/UMWauXEvv+Ch3ZzdoTIiqfdK2f2RzhelH0
         YOMD3r+nCfFUVKcrf0oTc6t6OwjkHtgKsBkBzydUofWNNTeyeN/iA1UsRNC19H+Err7D
         r7v3NrNF2iR7XlJKut52fDWZEmJcJnfotjhF5d309bMvKzl595pS4ivIdYTBAPQG/K+a
         pjGNDX5ozDeKkzJdVXAUxbzF6GU6SDAAkPwEsLx3TNcT41DHJp9YJXckXBIjNxY63HXc
         hdYQuEqUPG1cGd/61C/sSeLxL64oQRyxzydnaxtMQwW5HVKsLHAyZVIUFjh5UHa7028E
         2rTw==
X-Gm-Message-State: AJIora8bCSe7xrvNlrIgyYdk5C4GgGkr8zHmhhVJMpFiyquBxwDTwheE
        hCnsFgts+RH/yoSIati20RvgDqsaGgw=
X-Google-Smtp-Source: AGRyM1vwTOBVzDpIkeptu38SuURTRQfBuGZoJn/vuhpXunv02jWk3U1wuvExeJmAmUkG5ZYPt2XKqg==
X-Received: by 2002:a05:6a00:150d:b0:52b:1ffb:503f with SMTP id q13-20020a056a00150d00b0052b1ffb503fmr36089741pfu.27.1658389714259;
        Thu, 21 Jul 2022 00:48:34 -0700 (PDT)
Received: from localhost ([166.111.139.123])
        by smtp.gmail.com with ESMTPSA id lb14-20020a17090b4a4e00b001f1f5e812e9sm794541pjb.20.2022.07.21.00.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 00:48:33 -0700 (PDT)
From:   Zixuan Fu <r33s3n6@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, Zixuan Fu <r33s3n6@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH] fs: btrfs: fix a possible use-after-free bug caused by incorrect error handling in prepare_to_relocate()
Date:   Thu, 21 Jul 2022 15:48:29 +0800
Message-Id: <20220721074829.2905233-1-r33s3n6@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_relocate_block_group(), the structure variable rc is allocated.
Then btrfs_relocate_block_group() calls relocate_block_group() -> 
prepare_to_relocate() -> set_reloc_control(), and assigns rc to the
variable fs_info->reloc_ctl. When prepare_to_relocate() returns, it
calls btrfs_commit_transaction() -> btrfs_start_dirty_block_groups()
-> btrfs_alloc_path() -> kmem_cache_zalloc(), which may fail. When the
failure occurs, btrfs_relocate_block_group() detects the error and frees
rc and doesn't set fs_info->reloc_ctl to NULL. After that, in 
btrfs_init_reloc_root(), rc is retrieved from fs_info->reloc_ctl and
then used, which may cause a use-after-free bug.

This possible bug can be triggered by calling btrfs_ioctl_balance()
before calling btrfs_ioctl_defrag().

To fix this possible bug, in prepare_to_relocate(), an if statement
is added to check whether btrfs_commit_transaction() fails. If the
failure occurs, unset_reloc_control() is called to set
fs_info->reloc_ctl to NULL.

The error log in our fault-injection testing is shown as follows:

[   58.751070] BUG: KASAN: use-after-free in btrfs_init_reloc_root+0x7ca/0x920 [btrfs]
...
[   58.753577] Call Trace:
...
[   58.755800]  kasan_report+0x45/0x60
[   58.756066]  btrfs_init_reloc_root+0x7ca/0x920 [btrfs]
[   58.757304]  record_root_in_trans+0x792/0xa10 [btrfs]
[   58.757748]  btrfs_record_root_in_trans+0x463/0x4f0 [btrfs]
[   58.758231]  start_transaction+0x896/0x2950 [btrfs]
[   58.758661]  btrfs_defrag_root+0x250/0xc00 [btrfs]
[   58.759083]  btrfs_ioctl_defrag+0x467/0xa00 [btrfs]
[   58.759513]  btrfs_ioctl+0x3c95/0x114e0 [btrfs]
...
[   58.768510] Allocated by task 23683:
[   58.768777]  ____kasan_kmalloc+0xb5/0xf0
[   58.769069]  __kmalloc+0x227/0x3d0
[   58.769325]  alloc_reloc_control+0x10a/0x3d0 [btrfs]
[   58.769755]  btrfs_relocate_block_group+0x7aa/0x1e20 [btrfs]
[   58.770228]  btrfs_relocate_chunk+0xf1/0x760 [btrfs]
[   58.770655]  __btrfs_balance+0x1326/0x1f10 [btrfs]
[   58.771071]  btrfs_balance+0x3150/0x3d30 [btrfs]
[   58.771472]  btrfs_ioctl_balance+0xd84/0x1410 [btrfs]
[   58.771902]  btrfs_ioctl+0x4caa/0x114e0 [btrfs]
...
[   58.773337] Freed by task 23683:
...
[   58.774815]  kfree+0xda/0x2b0
[   58.775038]  free_reloc_control+0x1d6/0x220 [btrfs]
[   58.775465]  btrfs_relocate_block_group+0x115c/0x1e20 [btrfs]
[   58.775944]  btrfs_relocate_chunk+0xf1/0x760 [btrfs]
[   58.776369]  __btrfs_balance+0x1326/0x1f10 [btrfs]
[   58.776784]  btrfs_balance+0x3150/0x3d30 [btrfs]
[   58.777185]  btrfs_ioctl_balance+0xd84/0x1410 [btrfs]
[   58.777621]  btrfs_ioctl+0x4caa/0x114e0 [btrfs]
...

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Zixuan Fu <r33s3n6@gmail.com>
---
 fs/btrfs/relocation.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index a6dc827e75af..342ade83d062 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3573,7 +3573,12 @@ int prepare_to_relocate(struct reloc_control *rc)
 		 */
 		return PTR_ERR(trans);
 	}
-	return btrfs_commit_transaction(trans);
+
+	ret = btrfs_commit_transaction(trans);
+	if (ret)
+		unset_reloc_control(rc);
+
+	return ret;
 }
 
 static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
-- 
2.25.1

