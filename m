Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1BA2D2F82
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbgLHQZt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbgLHQZs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:25:48 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A4CC0611CF
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:24:41 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id l14so153435qvh.2
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q72SsyFPmd92BdpyPLFGmykrVJ0f82G1Rus+LCwtD6s=;
        b=cOHCq7nNZ+jG1sc6O19ZY/3XEpUMfAFl17mOpr84Had+ziL891rfkqmzVCigDKwH/9
         6ANWiss3tuFoapHp5wosM8vkXkaNMnirrPB8rkd5beuokwDWmqThdmkKtnykpQ3LYgTK
         r64++XI1kAJLCwvxlsaxm+yyiOpn8ubd3rIL+T6JPemCBfVd0s/GRfKF0PBPxoGfIFAk
         //teYu96T7NIDRMevEi+HtuUTT5hUNwCfd58LFEoNevrwo56/SZp6yzpvKIM/KYo+gyM
         y7BVPjm8mdFs5xYl95kmsGVYBdJRi0jD4lerYg/rV5Fk+Z0hExiZi5sUXCjyRFL2+46K
         ZiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q72SsyFPmd92BdpyPLFGmykrVJ0f82G1Rus+LCwtD6s=;
        b=BWh3nQujEWcdrOxMR61YOTMWdccjniz8yG6tkkXHB9Bn1P+ZvIJShA7SfYMysZGw0F
         /hmm5UHaYBiBXUXwOCB08S4Tv5xJQ/jVRMLdOshVNDiFwVVK+JUFT2dbMrRh0O7+DD9T
         w4lTF414DdN+SgpNTkqJ1XpG0OqjT4qIAHZmxx0dNKeRyvhIaNpulFD7bRv4fdd/Gtmd
         yfjEYDO/Q27aYdbzykZ2GWl16uvO02xg+vcKUMgem/V/aKb+k2JoPYkubWil+m0S2Ppb
         gJSPCio9Rzevt4B65MhAMc7nAL+j7QRNVC5rsIF5FrxmyQ3ug/tIEExQEliFj/e0VdzX
         pNyA==
X-Gm-Message-State: AOAM533tOUZAJlH9SCpQyzAOm13QukMm64LHj3G5CPHY2wBkoetyzO2A
        841u2zY/K4P+PzyQpExbI3XKUBAfGTXuCYE/
X-Google-Smtp-Source: ABdhPJx3SwpcrapTSm1J/Zth2ZbB0WnUV7Pfp0dwCInFs+Z3xZwmpz1+NCncKQkSM0t3nXE9LR/heg==
X-Received: by 2002:a0c:916d:: with SMTP id q100mr28947821qvq.29.1607444680177;
        Tue, 08 Dec 2020 08:24:40 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r127sm6109474qkf.75.2020.12.08.08.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:24:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 17/52] btrfs: handle btrfs_record_root_in_trans failure in btrfs_rename_exchange
Date:   Tue,  8 Dec 2020 11:23:24 -0500
Message-Id: <a54a7ab2b46067d895c81eb1cfdd46d245230aad.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_rename_exchange.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 070716650df8..2f8bb8405ac6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8897,8 +8897,11 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		goto out_notrans;
 	}
 
-	if (dest != root)
-		btrfs_record_root_in_trans(trans, dest);
+	if (dest != root) {
+		ret = btrfs_record_root_in_trans(trans, dest);
+		if (ret)
+			goto out_fail;
+	}
 
 	/*
 	 * We need to find a free sequence number both in the source and
-- 
2.26.2

