Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA3677A5E3
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Aug 2023 11:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjHMJvT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Aug 2023 05:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjHMJvQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Aug 2023 05:51:16 -0400
Received: from mail-108-mta227.mxroute.com (mail-108-mta227.mxroute.com [136.175.108.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DD8170E
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Aug 2023 02:51:16 -0700 (PDT)
Received: from mail-111-mta2.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta227.mxroute.com (ZoneMTA) with ESMTPSA id 189ee49e1a900023b6.001
 for <linux-btrfs@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 13 Aug 2023 09:46:06 +0000
X-Zone-Loop: 18079c2d65d26ccf92cb301a1afdfb99e4203a8ec740
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=c8h4.io;
        s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cgrdauJJLi+22I4oU0p+myNIz0Q5ENrDAebkct7NuFs=; b=dqK/2Cs4UgorCHa+LEyh6+wHZe
        dGI9b5xkYC3iMz6g8iBuoBA6g/3nbVlLbxQWBsnudWfvgRO3sRByvPns8ueL0QdzGcfqHD5o2NlVX
        CHdYz01pnlAsMpxIBPmDHR60Kqpl9+Q9J4UzIyLxUB06VFt68AFIAl461h+i/L7RKoQb3EBPe/k/0
        i+98bNAwnz4FfuW7cPZm7r2GveaxWFeO71Z42ifCDrBf+exnGKngdQdABZyWJx17O8g57eLEuD4CG
        KUgR2+V3a59YbzX6e+9/R5pM/tPdUMEp//13+YtMA/YIvs0ovvlaUKBKJPVHXWoV5xOrFlBA7+JeL
        ZYX8IJXg==;
From:   Christoph Heiss <christoph@c8h4.io>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/7] btrfs-progs: subvol show: remove duplicated quotas error check
Date:   Sun, 13 Aug 2023 11:44:57 +0200
Message-ID: <20230813094555.106052-3-christoph@c8h4.io>
In-Reply-To: <20230813094555.106052-1-christoph@c8h4.io>
References: <20230813094555.106052-1-christoph@c8h4.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: christoph@c8h4.io
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The exact same check is repeated here, with the second being dead code.
Keep the second instance, as that informs the user what is happening.

Signed-off-by: Christoph Heiss <christoph@c8h4.io>
---
 cmds/subvolume.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 0691157c..a5423759 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -1466,11 +1466,6 @@ static int cmd_subvolume_show(const struct cmd_struct *cmd, int argc, char **arg
 	btrfs_util_destroy_subvolume_iterator(iter);
 
 	ret = btrfs_qgroup_query(fd, subvol.id, &stats);
-	if (ret == -ENOTTY) {
-		/* Quotas not enabled */
-		ret = 0;
-		goto out;
-	}
 	if (ret == -ENOTTY) {
 		/* Quota information not available, not fatal */
 		pr_verbose(LOG_DEFAULT, "\tQuota group:\t\tn/a\n");
-- 
2.41.0

