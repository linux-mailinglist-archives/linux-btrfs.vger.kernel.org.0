Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393682CC72E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387769AbgLBTx0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388114AbgLBTxZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:25 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CC7C09424E
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:35 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id y18so2454152qki.11
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iRc6MA10E50WbWBouELNpGSiDE5XtkCejSC8vLj01Do=;
        b=tyocMGvzI44RD/B8GERpctEcfNqNBX7aAAUIEVAGPWUvVfhCPVrAn7N+EYlFYRSMol
         IiBF90en5WKJ2dUVxpqu+J7rasDsOg+2ED61xjsOer2vyxGnfcCnTfs2wAEuVZNoniDe
         pRXEe0eROkuaQns0GcTuA/AWf+wubegkqtQFIn70Bf/xWPC1oTbzDIqAsANgUNVyV+85
         O1Uv6VuK2QoItHPNonIfwAqQPGFlWSifLVpgJS5xOYrqF2iGQgEU8FYKy1HACo62vH71
         HJLmQSzNWcP+JZ6iNmToOAAc0vaN2lCWMh6EwTyk1HsKPmk+qOkLAjA3g0YVtoMUFjIO
         xMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iRc6MA10E50WbWBouELNpGSiDE5XtkCejSC8vLj01Do=;
        b=baUpgLJQybn3yNJmNJ7iO/1yrSf4Sw5aOWHWbL32fQnXdqFy8Ac1clGZhV0z6RTLvI
         f6zG/M5y7qGLIdw7gy5LLGpjeyhdxL0w15ol8F/MGvhe1FbuMnLjoI1UdSChTZ54WFHz
         WolKfnU9AAg0eu0mV3EMvRfAHbc4iNjv0guepgjedzHPWdNC9g/ljQx+wneQmbpvnsg4
         GXN0dpOM5Q1Vdv4lEfvpIPT7SAOiryzAc1V4uVsJrnhZIq+7bGxG7fhOoAtOQvz8PQ5r
         GJHNKt36vM3UN0yqZLiN9ULXbiLIhj38F0QU9anmTMalJ2VXjicnYbnyJ0IkcAGRw6n6
         bUfg==
X-Gm-Message-State: AOAM530kBjKkb6jACC8gwzqhempkMZAkmPUgIT/dqunBoKc+T2w4PV0s
        IwKduMCbtHLKwbrGs9IwEOynbv5+wlxVGQ==
X-Google-Smtp-Source: ABdhPJybf17/2n9vYQWZkAcGfMUT6efQ3xvnD03paq07WpFD1NOMzK9NIQ8AfvmHGLU+oRxwSHu5+A==
X-Received: by 2002:ae9:f402:: with SMTP id y2mr4251760qkl.9.1606938754747;
        Wed, 02 Dec 2020 11:52:34 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q15sm2754754qki.13.2020.12.02.11.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:34 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 44/54] btrfs: do proper error handling in create_reloc_inode
Date:   Wed,  2 Dec 2020 14:51:02 -0500
Message-Id: <497be2d1fd745d88d6cbeda5d77168781b5522df.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We already handle some errors in this function, and the callers do the
correct error handling, so clean up the rest of the function to do the
appropriate error handling.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8f4f1e21c770..bcced4e436af 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3634,10 +3634,15 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 		goto out;
 
 	err = __insert_orphan_inode(trans, root, objectid);
-	BUG_ON(err);
+	if (err)
+		goto out;
 
 	inode = btrfs_iget(fs_info->sb, objectid, root);
-	BUG_ON(IS_ERR(inode));
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		inode = NULL;
+		goto out;
+	}
 	BTRFS_I(inode)->index_cnt = group->start;
 
 	err = btrfs_orphan_add(trans, BTRFS_I(inode));
-- 
2.26.2

