Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC89251DFD
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 19:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgHYRPY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 13:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgHYRNk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 13:13:40 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2B5C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Aug 2020 10:13:32 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id m7so11637727qki.12
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Aug 2020 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bHGEPwazCvPtI5yjC/GyqN80yncMFDB6sJ09rENHbXs=;
        b=V1Q99F3bHd/1xPCV7A4bV8fpl2japrVlD4w6AZlBvO2UWvbDQcg1YAM5/YVvEe7kk0
         LWxhuGAWAeGb4Tb74ghkez/tBHzHwvs6xHQlHHkVEbmlaTLLTJKKPq9LgSuh15eeDpxR
         2bIILPQv/0RmbVjofDkNXF5l1tNUuMITbhG/xyvhlyXmd1JRJgxtaa4JLwc3U18XcVzB
         /Zwfe7Ms23BK+reuMcgeqtE1IJp9TC/h5Z6RnSS8361U/lXM/WHx9zxgkTKpdzTq6UzX
         raGNsjq+mm89b+6+DkDA7iit7cueSk+qWLjHDZv/Rn9NBjlkW4UwTu5DKR4XnonctAD0
         Sx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bHGEPwazCvPtI5yjC/GyqN80yncMFDB6sJ09rENHbXs=;
        b=PILPU9rUyIRrc8gECzugc8wlLMZ7jEwIhS6Xq6xYHNEKyXBq1MBkSIdss4P4v6ws6/
         lgGqYvC1xF3aE7T4FOz28hk7UFurgXagKf0J3BOSexPfqn4IceNi73Es8S/DlHrAg5AA
         LCQ/EC2lAAgzm2GLmyIVWYLn0UGa1vlYy1U8QmiArR40RaER7mjHxuSJs1ndg1Y3r14F
         uM5ynHxuiKozL5RNDOP56SmBqca+y4Myy9YbN1eGW362M9LQDQCXHQ5HYagn2ceyyzz9
         abz7mG040NCQJ02cuCIJymumhkNVaiHvNfPRDV85uzXNRaR+SQp+r7lPzpzSnXONNmDD
         73gg==
X-Gm-Message-State: AOAM532xzoHfxEE2lJ85OVVyAxqPv3o3az8Wntbw9FNNfHCXapAYCSWl
        NV2JBf7gJbb9wPDAwthxyEhAy7K9pyV5SYtv
X-Google-Smtp-Source: ABdhPJywL3OiNEujdeTxcQ+9ZG3di3PYI3mQLf35h9ylUwOjBv+MWHNn0eWwtARWidwV20lmkFcg2w==
X-Received: by 2002:a37:8ec2:: with SMTP id q185mr9779475qkd.295.1598375611274;
        Tue, 25 Aug 2020 10:13:31 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v24sm2284253qtb.13.2020.08.25.10.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 10:13:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs-progs: add a warning and countdown for RAID5/6 conversion
Date:   Tue, 25 Aug 2020 13:13:29 -0400
Message-Id: <164e102b2a6179f9af35ded962c11d780ccf8400.1598375602.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Similar to the mkfs warning, add a warning to btrfs balance -*convert
options, with a countdown to allow the user to have time to cancel the
operation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 cmds/balance.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/cmds/balance.c b/cmds/balance.c
index b0535d40..d7b2b3d6 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -515,6 +515,7 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 	int force = 0;
 	int background = 0;
 	unsigned start_flags = 0;
+	bool warned = false;
 	int i;
 
 	memset(&args, 0, sizeof(args));
@@ -616,11 +617,36 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 
 	/* soft makes sense only when convert for corresponding type is set */
 	for (i = 0; ptrs[i]; i++) {
+		int delay = 10;
+
 		if ((ptrs[i]->flags & BTRFS_BALANCE_ARGS_SOFT) &&
 		    !(ptrs[i]->flags & BTRFS_BALANCE_ARGS_CONVERT)) {
 			error("'soft' option can be used only when converting profiles");
 			return 1;
 		}
+
+		if (!(ptrs[i]->flags & BTRFS_BALANCE_ARGS_CONVERT))
+			continue;
+
+		if (!(ptrs[i]->flags & (BTRFS_BLOCK_GROUP_RAID6 |
+					BTRFS_BLOCK_GROUP_RAID5)))
+			continue;
+
+		if (warned)
+			continue;
+
+		warned = true;
+		printf("WARNING:\n\n");
+		printf("\tRAID5/6 support is still experimental and has known issues.\n");
+		printf("\tIt is recommended that you use one of the other RAID profiles.\n");
+		printf("\tThe operation will continue in %d seconds.\n", delay);
+		printf("\tUse Ctrl-C to stop.\n");
+		while (delay) {
+			printf("%2d", delay--);
+			fflush(stdout);
+			sleep(1);
+		}
+		printf("\nStarting conversion to RAID5/6.\n");
 	}
 
 	if (!(start_flags & BALANCE_START_FILTERS) && !(start_flags & BALANCE_START_NOWARN)) {
-- 
2.24.1

