Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA144BBAC7
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 15:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbiBROik (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 09:38:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbiBROih (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 09:38:37 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBFD294FCE
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 06:38:20 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id d3so15044972qvb.5
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 06:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FWCkjw7D27bCfSTIiFeagjvfDVKxrTv9MJxc0vm1jsM=;
        b=D90adCxuLbVfIUEWG865euPyRy4h3u8EPawkrA7WSpH7sJvB+1SiKjq0MmuTzDDkc3
         OTVoxExuxwilRqAxqb7faxzwWiM4kLlKUCzb1bYFA12aY7R5oVC/+4dJ5aSIIBkWX4n0
         sLgpri/zhHYlcfsNsaiwv1KyJVAFiCsq7yFdQkPyUGKI8Uk/jroYbS3j5YoRAmhKsVCe
         AC3Ru/RBSvPSPMQdH8iWsC8RdCo59aXTKEMA2vAFfnlmARPxUDFoDKauOMXzxfZ9sEaw
         DoJ3Td52rXnLOmjrk9wiT4w3clYSqMLTxaR+OMowmrR5ckTh33ADtYpHpsaI30IQkzhz
         5lHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FWCkjw7D27bCfSTIiFeagjvfDVKxrTv9MJxc0vm1jsM=;
        b=d+HLunsA4Qzwlb8R5yfjfHiX9SKknlRTVePSk7RQccsB2K7tw0hKE4eynfGfXXMcrK
         du60PxPYy/r8v91a7CZ2o+OVP77Z6oRxoxfD2+xrGbPO9QueNtOKl/E93+ze0/KFZtSK
         zhbw5YKaxXQ+iMxsjOQQfqDC5o2y0uhJZF9mLHdYPKEn0Hub8mjKPO1r6PUVz3SaI0yk
         yhX1QyDVnol97ZC5I7r0jbY3vimTJDuLs5wQEQoehmhMi95cOy1F4ScrCqh48fz/KjzT
         f4h7HLI+f/SLBljTrd8ZEWeaZ+iDPq5OVZSPAHhDsu4k0EDfxafNqz8RUPb8VPhAem84
         Sssg==
X-Gm-Message-State: AOAM530W7WA8cEbFqz9JP9YIaGRa1J2KYPzE/sWnL4onq1NVk1Z5/wL6
        cnMJ/DZRqgcYCljIM1lbKHGS9A==
X-Google-Smtp-Source: ABdhPJzO545f/nTUQZe430KO3tBGZNfRTO6XTw//+8ZWLerSqiQ37E7M2006rAZwltluz+Nblg5fnA==
X-Received: by 2002:a05:6214:27eb:b0:42c:4b77:d62 with SMTP id jt11-20020a05621427eb00b0042c4b770d62mr5787101qvb.55.1645195099691;
        Fri, 18 Feb 2022 06:38:19 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n19sm15062955qtk.66.2022.02.18.06.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 06:38:19 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 1/2] btrfs: remove the cross file system checks from remap
Date:   Fri, 18 Feb 2022 09:38:13 -0500
Message-Id: <ac03eaa51bac7c30ee4b116777ac9eb57573a280.1645194730.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645194730.git.josef@toxicpanda.com>
References: <cover.1645194730.git.josef@toxicpanda.com>
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

The sb check is already done in do_clone_file_range, and the mnt check
(which will hopefully go away in a subsequent patch) is done in
ioctl_file_clone().  Remove the check in our code and put an ASSERT() to
make sure it doesn't change underneath us.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/reflink.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index a3930da4eb3f..6fed103f1000 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -772,9 +772,7 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 		if (btrfs_root_readonly(root_out))
 			return -EROFS;
 
-		if (file_in->f_path.mnt != file_out->f_path.mnt ||
-		    inode_in->i_sb != inode_out->i_sb)
-			return -EXDEV;
+		ASSERT(inode_in->i_sb == inode_out->i_sb);
 	}
 
 	/* Don't make the dst file partly checksummed */
-- 
2.26.3

