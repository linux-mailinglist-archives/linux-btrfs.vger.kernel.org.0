Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611DD2D2F7D
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgLHQZo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730193AbgLHQZo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:25:44 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99547C0613D6
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:24:45 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id u16so1996673qvl.7
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xGNUuifwBsvHD2zCYX/FZac+Jy1QnxNpjtDrlcuIIEE=;
        b=NDMofWSJ2Jdj9L5cslVnoc52HZRp2U+GtIO7wA45UEmqRi6c7T8IEOqEo7krhkn5kg
         infngxQCV8UKCecCCuWZ8ra/ZcgfhXCKxgq+2ie4AXSxQXSp4tL6nCqxD+icI9iYbxk+
         m3xSWjfErdGF7htVsWtIO/yd57D4mPHL2Uf3sXR6NThz5tgqTJnOLHOaMon69g0+u4Zt
         65GwkpmJ591GQAuDYCXjlz54serIjCMTrMKXZdqXFQ9aEYNNPd7izUTV01hJk4MSv3QY
         kvjXDq7T7/XwfXGYbjr17AMeRoBPjcflfsma/fqB2dwcOc8/j8vyczwb+7UsgY44j/8h
         ubKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xGNUuifwBsvHD2zCYX/FZac+Jy1QnxNpjtDrlcuIIEE=;
        b=MNZL4p1Y8Vdx34G/T4R0KQqe/6Pz8wCgbmnJkDcl8ZDuwmga9uG4j36RXo//j08zAG
         ixWDShKEp7bjMao6LciZziEH6KTTLv1GNzGkNPb+S0Sfa2fHEh95fV2aSyNhcd4cC1z5
         swwYh4BPJcro+TfhFqRMmoc6+BgA3E8FrwJAaGC1b3fhyXX/67g6UVpMDkybPNhzrpJ8
         NKjACtHdi67IWfeA0PivbuhN73dfVPCAlvgNdIZWeUfAFTS5/sFjCEKaT+uIzdEgKFBw
         cqRJMYtWW0Zdg/GrYpUe0PZbPTJBSS46s4k5v96ryy3diYuElai4Liu50t3Fz3F/1/2A
         aXrw==
X-Gm-Message-State: AOAM530jgmhdGt1fptsjskCb5zgvMuEwB+8yrQPcfJ45TnrLnWv5qVrh
        FV+nCEtKCZEmmGQgFB+6rcCDIAZzrbiiapd8
X-Google-Smtp-Source: ABdhPJy2STwqNGo/i38Kc75GNH7J6cNdM8lWP1290wzy74dQq8gGaJ8qRqcZCGmOdrL7hnLHC/D5lg==
X-Received: by 2002:a0c:8e42:: with SMTP id w2mr28433745qvb.4.1607444684560;
        Tue, 08 Dec 2020 08:24:44 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l20sm4558631qkj.19.2020.12.08.08.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:24:43 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 19/52] btrfs: handle btrfs_record_root_in_trans failure in btrfs_delete_subvolume
Date:   Tue,  8 Dec 2020 11:23:26 -0500
Message-Id: <b28f89f23862bf21c0e2d7252f7b89a2ff30851f.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_delete_subvolume.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bcbae8b460c0..7a8d89e1b73f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4175,7 +4175,11 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 		goto out_end_trans;
 	}
 
-	btrfs_record_root_in_trans(trans, dest);
+	ret = btrfs_record_root_in_trans(trans, dest);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto out_end_trans;
+	}
 
 	memset(&dest->root_item.drop_progress, 0,
 		sizeof(dest->root_item.drop_progress));
-- 
2.26.2

