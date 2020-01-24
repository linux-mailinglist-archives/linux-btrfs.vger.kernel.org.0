Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A03148931
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404326AbgAXOd1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:27 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40682 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404285AbgAXOd0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:26 -0500
Received: by mail-qk1-f193.google.com with SMTP id t204so1362860qke.7
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HKt/gyH0Knlxys+g/v0pjWvfo/9TSnmMRROcvEGAxbM=;
        b=RJN+0DJfju5zB9oNqw6x1f9PKV6wlKIzjK1Lqw7OH6xkicYoFy9IT3zBL2XVe1HgxX
         p/LyETqzqplu5VbQ7p3z6M34Mpu3Rp+tPxuw064t/pfIeW0NeriUBEf/ccWUIPHkufef
         wjxIZ4pVlpNG6dLjXTrbVIKjIgSFIMAXuFih8xt6LFxNJi9AQHbgeBJY4ebwGzhKds42
         AI8trnjKAuE5IfSfdSTdrdm21iDlFQjDnI0d0MKGkq4R6ADW4rX77mernvLOBoa3qL0n
         NaIei/+4Ya2CMi69XEojY0uBGeTUw0BB9QZH6LOcSwAP7O65dbPpKZ+LKOS1W0ZXLzrU
         73Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HKt/gyH0Knlxys+g/v0pjWvfo/9TSnmMRROcvEGAxbM=;
        b=hrFQPFDJHSvBFwyio9+0Oab7at2vfYTR5qez/NDwn0MwNZxm+KTm0FkiTObv07reNi
         Es9zxFT0yb5yHkndpRRgHd4JCPqz02R84/GYaSdcd8/igC3Hr8as+i+N/hGI6EzLevZ1
         +fd5H7+ClqQZ1SnN/TOfJx9Qmxc1jGODe1iDEhF8Aor07SARzN9u3T3Nx1fWPlvPRnvm
         W+yteJ3uYrWGUVB6Gq7y/DJrkpu3sFWlXlb+0AVs8tL9MWFAXDPXZNPPIPkkugUiEjNa
         C8xCn1nxYp8nW9IWQHzj3x0IaMRIcPulgnWeDDV+TflfwQBU6R9thpl33Njc9voOWDPi
         +BiA==
X-Gm-Message-State: APjAAAVJdiuU3nn/7JzAiC5c9tevPKnWQ28Gxrccm/4oDxN1bJzfCA3Y
        fOF8wJ7bUUqi/hDWZDH+D/PKm1E+/L9J3g==
X-Google-Smtp-Source: APXvYqwLXVYyrRzOpvNnWQGBL1t9zCGfExoinOwVZUCuB/ab7e7sWMJuLw3Gz5OwL+KCkSuHC3PvvA==
X-Received: by 2002:a37:bcc4:: with SMTP id m187mr2951169qkf.329.1579876405222;
        Fri, 24 Jan 2020 06:33:25 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j1sm3098118qkl.86.2020.01.24.06.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 13/44] btrfs: hold a ref on the root in __btrfs_run_defrag_inode
Date:   Fri, 24 Jan 2020 09:32:30 -0500
Message-Id: <20200124143301.2186319-14-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are looking up an arbitrary inode, we need to hold a ref on the root
while we're doing this.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 565ae8404e1c..3abc7986052b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -292,11 +292,16 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 		ret = PTR_ERR(inode_root);
 		goto cleanup;
 	}
+	if (!btrfs_grab_fs_root(inode_root)) {
+		ret = -ENOENT;
+		goto cleanup;
+	}
 
 	key.objectid = defrag->ino;
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 	inode = btrfs_iget(fs_info->sb, &key, inode_root);
+	btrfs_put_fs_root(inode_root);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
 		goto cleanup;
-- 
2.24.1

