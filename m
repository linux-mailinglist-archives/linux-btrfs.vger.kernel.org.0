Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFACE2B2034
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgKMQYD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgKMQYC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:02 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B975EC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:02 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id f93so7013464qtb.10
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=K6hu+U2uNz47fu1LAIJ2XriMGdOwyWIfEUz8kHIxyAw=;
        b=A/E5M98wX3q2bw8lb8gxujznyHr2OhMGcwQlC4xkiA8Nx4y5wDAU8KQhgOX1LuKjZ5
         ZZYg2QYpKpvO3IUs3zU9x1j9CRQTFyBtyYYCiV/k5VJu3wBd9zFW9aiQkxPSpdvHAODy
         MQT3fgR0oBnXjgykDTrMsdOXGm/EX8mSAf/KUzCTGCGmUWg8kpaqbUBU3Qj0rrDSwnFU
         jy9jox9HhCpskJr/7O0InvqHi5AyR/MJ/NdD2puFe2XdftxSksVSjLYma839cxFeJmaZ
         02TBV95+TojYio/tD0u/zAv05rHowAabhJ68TWYlKg1DHmL1xdP2ai+eefGlhgMSl3tZ
         7nOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K6hu+U2uNz47fu1LAIJ2XriMGdOwyWIfEUz8kHIxyAw=;
        b=GPwc7gY9XbohhUEXJ9h3uxURKOY7qgxuL80bgTQcHhHLiEjfdKicEpMPXj81Mzs/Qh
         C3yLRS72+jlwSl87jX0h6lOvSdaek0zymE31Zz2bEF5vmVTLD/6XWK7Pxne5pGiz4q8J
         ETyoxvxvR9+LkI7jgtmVPixw3XOEfSMTT1WN5+4WmZzSQiQ6+/kUZhRpPNF94f4Mec/A
         jvoi7P4RzHtNXEikOjos7nCxlfd0p+B1YmpofPxuLrruU1IzinojE/Moyjj0EkBpyJHU
         MUb5ryFyoPTI41uj1UXLMFZ17vIk10NlNK5CggMg9vHCvsLS7c0s5bRc4nPsJh/NX2Xn
         rmIA==
X-Gm-Message-State: AOAM531p+zb4dtcR8T3/SoZOowhRib1wxdx0msJenALp1FUkIJRqrH7n
        5gCVBVSN7zRSWVQj5PK/xflolpGdrGiY6A==
X-Google-Smtp-Source: ABdhPJyHjDWXAyyDRDzdVZdktaAITQSjCOHJPVRvtQG0kGxCopVs75sRNxSUHr/uu59WT4WoIwc7Aw==
X-Received: by 2002:aed:32c7:: with SMTP id z65mr2734783qtd.266.1605284636680;
        Fri, 13 Nov 2020 08:23:56 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r41sm7337736qtj.23.2020.11.13.08.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:23:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 12/42] btrfs: handle btrfs_record_root_in_trans failure in btrfs_delete_subvolume
Date:   Fri, 13 Nov 2020 11:23:02 -0500
Message-Id: <ef72c831a4b49b3757dab0c9c3a4fed5ff9d2b9f.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_delete_subvolume.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ce6602a80324..9cc8b810f4fe 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4146,7 +4146,12 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 		goto out_end_trans;
 	}
 
-	btrfs_record_root_in_trans(trans, dest);
+	ret = btrfs_record_root_in_trans(trans, dest);
+	if (ret) {
+		err = ret;
+		btrfs_abort_transaction(trans, ret);
+		goto out_end_trans;
+	}
 
 	memset(&dest->root_item.drop_progress, 0,
 		sizeof(dest->root_item.drop_progress));
-- 
2.26.2

