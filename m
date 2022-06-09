Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E3E544EED
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jun 2022 16:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343816AbiFIO0s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 10:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343959AbiFIO0p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 10:26:45 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E659F6FA1A;
        Thu,  9 Jun 2022 07:26:37 -0700 (PDT)
X-QQ-mid: bizesmtp73t1654784656t8hh5989
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 09 Jun 2022 22:24:10 +0800 (CST)
X-QQ-SSF: 01000000002000C0H000B00A0000000
X-QQ-FEAT: LVBOaDZ5gPorCP/XffdZeTI+1vyOfcp8Jl6f1X5JL7/BufghuOj6H79AyBfqD
        ImKD7MMUyDdTdTEdMBg8qBT01kW1eqwlqlYa1lQLod6f98/e0NrVUOLNbyYgn/IaNJ3LVBz
        guhmpgFHCPPVico9L3D9ibe8UJqJqWOk5I6hxreebh2yHkIHEEqb9AtyixxEVVI4kLj0hT2
        fNoP0Ma821vfRwRmM64Y8zHUlRz12wurwJNCWWMLhtaLQdVmehX2tZuWNbc3LWXunm2P6We
        NIMmefDBhEqajD5V/Wy+Bl5Vss5+2ekcUvLnR7FTOm2jl2wvS2PH4oJ5lr+z42oZhdVg==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] btrfs: Fix typo in comment
Date:   Thu,  9 Jun 2022 22:24:05 +0800
Message-Id: <20220609142405.51613-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Delete the redundant word 'we'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index da41a0c371bc..e583558cbbfd 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2857,7 +2857,7 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 	}
 
 	/*
-	 * If we were cloning, force the next fsync to be a full one since we
+	 * If we were cloning, force the next fsync to be a full one since
 	 * we replaced (or just dropped in the case of cloning holes when
 	 * NO_HOLES is enabled) file extent items and did not setup new extent
 	 * maps for the replacement extents (or holes).
-- 
2.36.1

