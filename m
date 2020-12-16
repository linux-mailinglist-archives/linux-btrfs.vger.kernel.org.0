Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115432DC427
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgLPQ2V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgLPQ2U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:20 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D07C061257
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:11 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id a6so17599264qtw.6
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=41DzNviF+cXvKLLpMN146LL13hp9ctwVOiWwtInzkqY=;
        b=OJ3erirXzpjnjFIXcPpxPuS/WsGUVGwJIHA7Wt4UXKFtTRcAcHarrrU+J2IPjlzIw3
         r8KhTSaMEbyBKjNdb2HOdjQVuyECA3K9tC9cNNGR2V8bkhKZE2LXbQ5/JPlSWjero7G/
         F9flg9ffJwme8W10bss2cp1Rem7EpO5p0upaeetmTwCJZko43bWau4AYAManiPiqqD83
         NmfaYWL60i8RnprPXooUulcSKFYBtnoS/nFgaXbGaMOFnhgkVnSS8UUZY3ZE0KTCV7xV
         pr0p8jSNhfRVuwaJpqsrK4Z1jjaVXA2cflYMSbHui3d91LtLyRuGfKH6Tt6wdGnPT0bt
         FI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=41DzNviF+cXvKLLpMN146LL13hp9ctwVOiWwtInzkqY=;
        b=jgl+SYKAiaUS5srgWpSJceISUseREXIfzBfgtUFLuLuxB0UnrPQPibq4+tqOf9oB7V
         vT6zwXT1QaksnssUyNfjv1tU43hXHz5HbyKX9zisDPGJ6rs3mtkNqjeizDS21ZPuz/Lc
         BGEyWvc8joWQ+2Nx8U9FjlatmkR0SSnBwHY1Xvod9QeSlFORqDE5tTEPy3m28hm6B5+J
         K7QZpSGW1evu6gKmutOEU0gMYihQI7AkRNgUhkNwcpcW59eUwBCWVRW+xOtZYDXU24XI
         FMV+UbssHnNGHKeASKzZ9as2OpUKskIKxC5Z3GSX8zcnXygcvLx/4B5BDkZmJejhKPI9
         8beg==
X-Gm-Message-State: AOAM531tZIfbG2kcSvz40K8/zL2IRqiVYMqyj6G6FqPKB3RIvN6VG0oX
        e+2yomdjUibBNvnIINHcfRE1/Oe94xoI2fwp
X-Google-Smtp-Source: ABdhPJw8+QV+oFKFg6NNDcIOi31v5qYy4ANQAP5GB/GiQKUv4Kzm0wTy70+Kv3trp69XOYFN9XiO2Q==
X-Received: by 2002:ac8:5d03:: with SMTP id f3mr42779538qtx.229.1608136030323;
        Wed, 16 Dec 2020 08:27:10 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g18sm1207198qtv.79.2020.12.16.08.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:09 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 08/38] btrfs: handle btrfs_record_root_in_trans failure in btrfs_rename
Date:   Wed, 16 Dec 2020 11:26:24 -0500
Message-Id: <4ebf0017342ebf0810de73039da233791b7386d9.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_rename.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2f8bb8405ac6..bcbae8b460c0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9205,8 +9205,11 @@ static int btrfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto out_notrans;
 	}
 
-	if (dest != root)
-		btrfs_record_root_in_trans(trans, dest);
+	if (dest != root) {
+		ret = btrfs_record_root_in_trans(trans, dest);
+		if (ret)
+			goto out_fail;
+	}
 
 	ret = btrfs_set_inode_index(BTRFS_I(new_dir), &index);
 	if (ret)
-- 
2.26.2

