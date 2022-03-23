Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C384E553B
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 16:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237955AbiCWPcJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 11:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237933AbiCWPcJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 11:32:09 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A833A70F70
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 08:30:39 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id gi14so1489658qvb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 08:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wbo+swqHzp3mYIhmXXuGb6NU1EIZkfivbVtIKaq/XNo=;
        b=1Df6OsX1+gPV+Q5SylKWZ2RDALp6R1cwVf5/UAeicx5/P8W+1axSNiPU9IwCzRMmSZ
         Oro7IpEzst/O9g9cvgQh03cZbU59TmSn0LNp9P44KoEIWcJBoR8at9eyBrQG6BxSr4aQ
         A+lLJcpYTaIAEYvfSAZPBlE2i2920cQ1cqpKURXC5awOWmjHCXVN7KBFmgLc584imMaY
         sDA36HsssXQJ4PzVQo3HBvt43bOeGfjNArT2vYQ3KrbKPwwJt7C75hrUMVoWy51JUpK3
         fpvpRzzjeO2gSG8AHuMsK9RaNORx3psJXORwHSC1c1KzAv7amz6k3lgPFQAr8lvYp9TX
         LTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wbo+swqHzp3mYIhmXXuGb6NU1EIZkfivbVtIKaq/XNo=;
        b=WPcEFWSLHHCKeJ9xibiF1QXRW1VJ2nT5TiYcKcJZ/PV9s3dVml8DLjUsuOfpFrYdVR
         6b1iqkTXuJ6L5Qaihtb8G3jcNDpe5vpAv3hp98Hg3tdWqUl0FtB3PTN+3tKLDGwlJODo
         yqiQYG/fiYXXAMrj2WG0OKN7GFntVTf6+zysYKwaWKce9ARdMkookWnuV+GrDJGXkVaw
         /WRZJwo6kGSdFXrKbYFz7fvs+EA5EWrawZd5DHFwqUysbhwDYOyrRaaCAyAf2vREhWNs
         v6n1YkEKrqpIB0fgg4Q/5D7Vay25R5Xs1JCWP8mYvO+sY2K29E/09O+IBVLAF3p3uNwu
         TH3A==
X-Gm-Message-State: AOAM532FFonuf51CE1UakNcMWTT3Jqza/Y58quG0cWK32/ZLNtXXRVKb
        zcpuisX31QsSpfX0bcXs6TnPTzAPz2vXMw==
X-Google-Smtp-Source: ABdhPJwun4FzpK7EczGJK4LYC9R44HFGJvKwDr22AQRMZLmX6krLS8Gr9lnbUdsy4dqsTF36KPZJug==
X-Received: by 2002:ad4:5d49:0:b0:441:5682:9b92 with SMTP id jk9-20020ad45d49000000b0044156829b92mr401622qvb.10.1648049438409;
        Wed, 23 Mar 2022 08:30:38 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a129-20020a376687000000b0067d186d953bsm116885qkc.121.2022.03.23.08.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 08:30:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: do not warn for free space inode in cow_file_range
Date:   Wed, 23 Mar 2022 11:30:36 -0400
Message-Id: <ae796792f263dd906ce5f3962c6bddec6b8048e3.1648049428.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

This is a long time leftover from when I originally added the free space
inode, the point was to catch cases where we weren't honoring the NOCOW
flag.  However there exists a race with relocation, if we allocate our
free space inode in a block group that is about to be relocated, we
could trigger the COW path before the relocation has the opportunity to
find the extents and delete the free space cache.  In production where
we have auto-relocation enabled we're seeing this WARN_ON_ONCE() around
5k times in a 2 week period, so not super common but enough that it's at
the top of our metrics.

We're properly handling the error here, and with us phasing out v1 space
cache anyway just drop the WARN_ON_ONCE.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 78a5145353e1..ea7551d3ee6f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1138,7 +1138,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	int ret = 0;
 
 	if (btrfs_is_free_space_inode(inode)) {
-		WARN_ON_ONCE(1);
 		ret = -EINVAL;
 		goto out_unlock;
 	}
-- 
2.26.3

