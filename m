Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3F92B752D
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 05:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgKRECp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Nov 2020 23:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgKRECp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Nov 2020 23:02:45 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CD6C0613D4;
        Tue, 17 Nov 2020 20:02:44 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id u2so266556pls.10;
        Tue, 17 Nov 2020 20:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HykVKqQ+2ZoqHnFMju1jNMVz685wDVtbToSJmkHGopQ=;
        b=CYl3DXQTh7asvKxKx9OfgqovdvoMiy/O9k+bH9CTPXtXxmvDIi9MCWtixAYeWEJTCd
         4nRCH6a2+98EI9FjmG9q4WrheMzlBAAnAk0AhhI34Y7hx2Q/DUh795Sr4uWbMkWhTXfy
         9iyG5i+IxpWorbDDXeaPe0K9vsEfea3yXGK535dX03/7g3Z0U8gtq035ejLRNm0eaQ2E
         m8BHOkZjIbifcZ4+dh7M0CZXbhQls3NOTICsk2JMDBWPlCyLgA5KyCfqZADa2gepLHXI
         2+galqZardyPe22tJB0QXG1AZDssJ7R/ZVClmopc0Whj3IdCX+UjoBo8zPizTjrj9QXj
         JVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HykVKqQ+2ZoqHnFMju1jNMVz685wDVtbToSJmkHGopQ=;
        b=BFpMzTPSUgiAppwz85bgcT/ZCR8ck3JJRxjqX27WNAKdj9/wPYGEIDyj0nDc6mZywN
         d0/Y+cgXJMUfOZQWqzqhXOPMgpXHrEQgQzamclTSHnx2ThmmHyS+HscStkz7foE7Oi3K
         GxW8kJ4sYnjNMxOKFBN8DLIbQHtZWwTEvbKZa0HM2JGEDXcI2KcC7nmURggmgEgJ/w3g
         rBCNWkS0roJR20dHNKbwu+EBnB3eSvG6nXL85rkv/DpwZYkDHBYNNEULB6VGx3UvnfMB
         LdumJIUHQxezQmIoUtE4VsLtloUHAAsNFnQh889m8GXMxDO3Vd1wwOljjiLgTxdHcy6I
         WvvA==
X-Gm-Message-State: AOAM532CgqR+93pMCUPKYukByZvOjJDj3m/bSfDjcJDT4IAsBJB+pKrV
        pezK13L+3Txgux/XLSfPLiTL0GCKwwMB
X-Google-Smtp-Source: ABdhPJzt6pNU+o6pHNGcR+Z4cys69+oSq7mOoNrkZ1bkY6Qczvkuxio/Gap1dmYbSIUzvWWTYUcjcA==
X-Received: by 2002:a17:90a:8b8c:: with SMTP id z12mr2136937pjn.233.1605672164491;
        Tue, 17 Nov 2020 20:02:44 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id q11sm20718263pgm.79.2020.11.17.20.02.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 20:02:43 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH v2] btrfs: return EAGAIN when receiving a pending signal in the defrag loops
Date:   Wed, 18 Nov 2020 12:02:36 +0800
Message-Id: <1605672156-29051-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The variable ret is overwritten by the following variable defrag_count.
Actually the code should return EAGAIN when receiving a pending signal
in the defrag loops.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
v2
 -return EAGAIN instead of remove the EAGAIN error.

 fs/btrfs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 69a384145dc6..6f13db6d30bd 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1519,7 +1519,7 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
 		if (btrfs_defrag_cancelled(fs_info)) {
 			btrfs_debug(fs_info, "defrag_file cancelled");
 			ret = -EAGAIN;
-			break;
+			goto out_ra;
 		}
 
 		if (!should_defrag_range(inode, (u64)i << PAGE_SHIFT,
-- 
2.20.0

