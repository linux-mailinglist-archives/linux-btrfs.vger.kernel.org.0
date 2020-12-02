Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C50D2CC72A
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389814AbgLBTxX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389800AbgLBTxV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:21 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21679C061A52
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:51:47 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id cv2so1302325qvb.9
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6M9zwjGM+9g2zUeTJd1Bxd/0Sqihj+Zk+kHYxw0gRK4=;
        b=IB6hVZa9I9ewOE4woVrVz/Y4gOIgFIrWyivcGexiWM0CsCxknXUrUbqLeHzP2xVApI
         aR3wdJXmp8dcC7z/kyeqgWenC4XRoiiFsaJMO503kjobmC6lmBln2CconLFQNJJfLtaF
         sxn2ywSHUZmvr/QlVheKxG/SHiTAVhQp16+UqVhxMSpcE/+ZsD54jXcC4WZdjhNDZaPR
         4ZJk1Egw37Fuc5up3Om/OhjDzbu6vhUM0Q4OfyS5Qo0t8DN9avb3sIZSla85JJWnrcTY
         IiU0g01GW7egA4aTHzhYXW4Rz6a1s1KJUa5obh6rbv6BqvkQ1xtku1N+SAIysM355zTA
         rr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6M9zwjGM+9g2zUeTJd1Bxd/0Sqihj+Zk+kHYxw0gRK4=;
        b=bddrPLF0+GV+aWmulDO8fmFkBcfnd9iox8+Qle5Pck1HZlHHqSJ0di5k0h85PmccPj
         TVpCk80QTF2QlKw6ZynlzUOwFQ3haJwnEIeV2aNRijdpWxHiqFwGwPYSCYKI83DAbrDh
         ibG2rcuqCHTvrw5oYIVT97RkTfX6l2Gy2mR6U6QBiFcXmpK79NfXfK2ncy8FtfdUDyu/
         lIrwfp/WDsXQoMj72hcHLpXu+Gzq7sqQWoDR+1ULEI59q2Lj/UCBTPZ7igBp0R/WBaD2
         UuH0VJuaxtdqIgTBz8CE4Lboh2T9Ov+E6OgsEbEt15cOQVRvlVupNZEXRg6FkLzuiz2A
         RsEg==
X-Gm-Message-State: AOAM533khhfKitXczWjpCgxKjp+66n3HUjOvVCWvToPB4nC99BljkZ91
        FYD6OyOUtNt+PM1UBuCBHGMOflBCBnL2YA==
X-Google-Smtp-Source: ABdhPJy6nm7S7us3jZ1MecgnrFAo4IVVwnCmSkiPvYSaPz7hSVaH4DRSLdS/kSrgKS5afSV0C61EhA==
X-Received: by 2002:a0c:b415:: with SMTP id u21mr4295351qve.0.1606938706001;
        Wed, 02 Dec 2020 11:51:46 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g18sm2740617qtv.79.2020.12.02.11.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:51:45 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 17/54] btrfs: handle btrfs_record_root_in_trans failure in btrfs_rename_exchange
Date:   Wed,  2 Dec 2020 14:50:35 -0500
Message-Id: <e83a6ba1f9c439ca8df808887912eff2feaf4a91.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_rename_exchange.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0ce42d52d53e..d34cba37a08f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8878,8 +8878,11 @@ static int btrfs_rename_exchange(struct inode *old_dir,
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

