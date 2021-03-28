Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DECD34BAAF
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Mar 2021 06:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhC1EWG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Mar 2021 00:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhC1EVn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Mar 2021 00:21:43 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B429C061762;
        Sat, 27 Mar 2021 21:21:43 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id o5so9403028qkb.0;
        Sat, 27 Mar 2021 21:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6sIq1ws/W/ApQT9Mg6+OLsrONX7IC8dRWd8aslFS9Sg=;
        b=THq5iOIyVGap35keYKJmzj1i6xbfx3nuF0CWED3bGpUS2RcIPHXLXOFp7tbOx4/YUM
         EGbVgD/oyIPzf2gj+tkjaB+jT2ik20r3aEJrTJ36Sua/kyLBCL1c3HU3P2G6Kyim7PO4
         rK1tLm6bSl6P8SNI0UEJFDVKBrBzkkcEMJl6K4W+enIzVzekSuO1uUgEgOtx9ZsREKEV
         BRYBtL2RkGXj9lSbOeUvKLpBw9SHRm9iJuyKwOpibeIj0MHoxoDUnVHXfZS30TVBukiQ
         O3YPZuXaUXXPbLxUjQuwJWkPmsmvfK0GH6DpHt4sMnngpGLgKMMAPihBz+9SVlxC4grs
         1Fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6sIq1ws/W/ApQT9Mg6+OLsrONX7IC8dRWd8aslFS9Sg=;
        b=MXpN4CWRw03mFb8GYgQcWWxjjyKCyzdsK5GvfmGKOWxjJzH4jrx9AGqjPmLYiiL30D
         lchE7JIfyOpFfZJtiqkzvfu9gQhBglTCJbMqKT7kp917zoU5P2g7XyX78LAumVAiCREW
         rKO3vDZxetXWuy+IhurEoWQWewRppmmfz5YNCTh7xpjsEIHk2qdriT6lAnbOeUR0CLH6
         eOSv581SsVZ2kBpIAHLtJ/yZUFk286q8h/L1wfyAAhJkaa8WgPY2mOYPL0kkwMP6NNNe
         vY0N//NHk/apUf8XHOdGEsKJ/v627JepRa0mqroq4ZBAB41L20RgtXerZHIKcHN3Ty4a
         k0Nw==
X-Gm-Message-State: AOAM533JIBwP6f2ozq4ueRH3PEArUwTwud+tWeOwjLJ2lCipb41WDj5n
        OYqilFYBHpRACVVNOKJPm/g=
X-Google-Smtp-Source: ABdhPJyteK4KDfTqHRRWIM8CbIvlLqcrn3sP2hPo69j5pT2uyNVPNgPWfcee/MlYQMU7JonBtc6nsQ==
X-Received: by 2002:a05:620a:a8b:: with SMTP id v11mr19119938qkg.414.1616905302743;
        Sat, 27 Mar 2021 21:21:42 -0700 (PDT)
Received: from localhost.localdomain ([156.146.55.118])
        by smtp.gmail.com with ESMTPSA id i6sm10092237qkf.96.2021.03.27.21.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 21:21:42 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] volumes.c: Fix a typo
Date:   Sun, 28 Mar 2021 09:48:32 +0530
Message-Id: <858b643c41da5ae9041cb94a9dcb4be7156dea91.1616904353.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1616904353.git.unixbhaskar@gmail.com>
References: <cover.1616904353.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

s/bondary/boundary/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1c6810bbaf8b..ac85558b91c2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7797,7 +7797,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 		ret = -EUCLEAN;
 	}

-	/* Make sure no dev extent is beyond device bondary */
+	/* Make sure no dev extent is beyond device boundary */
 	dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL);
 	if (!dev) {
 		btrfs_err(fs_info, "failed to find devid %llu", devid);
--
2.26.2

