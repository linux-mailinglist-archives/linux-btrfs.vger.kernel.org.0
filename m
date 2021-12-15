Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4B8476381
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbhLOUkT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbhLOUkS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:40:18 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AABAC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:18 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id m17so21409807qvx.8
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1owcWEvVYPl/i/hgu3wi3tsBxbOUtbofsOYweG3x9Ys=;
        b=n83yXyGbXDMh8U3JZZEULEjHx1YIsoOC9e9nbYi9PYFiAQ5KwHv+IRkS2WFTNQpS9+
         JXsf/7SmrskSpjnDoMbq9AR1MTcvOxuGjDuNZjCtgStfYbTTRsTorKfeMoPwkKEA3eLS
         EnISS0mIawFDd+6DT+xxrJSf/Eus10orYe3XYIISZg31CUsNY59Ms3Hl4zuRpuSLorRj
         Vl8gJ8LznWatatBVZNlW616Dx3/yCEyhKFVSjnan4lBpYFqEiwx1vtGUoyOaQ2eV80SM
         oqhaOh2Agr3McaUTatnED2FY7lUsEJTVUvVH2qxxX4d0SgSq/lfMTJ/ErV1ym3Imlc2p
         dlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1owcWEvVYPl/i/hgu3wi3tsBxbOUtbofsOYweG3x9Ys=;
        b=6EaiOrMJ2o+yEavICBgZYAL7uD6J5xCVo8M11I9gc5uolrFfY3ef9g5m9z/JZtsQtR
         D2OAqJIT8i0CCqwjqSKKe+vmdpH5Pqg+94q+KPjQcpE6V/y45rZyLHrXOc1phmILVbq+
         v4PcmFB5r8difrWs6q+kTSIX3hs0DE7RxFkGXDc7dImZiZPQsCJv6/gRYaXL6KyeHuA+
         Cr5KpYD2fdlgOUSwyl9zvO5q7sV6dqCgXwP6CuT3zHcMPgctzdfqkQil5geKa1XE6VEV
         N1SzGub42R8ICvVlRarhXgjokapwQNq5ImMM8rmaPsx7TyBzif8sBK7D7UjKxUgILqTC
         hS/g==
X-Gm-Message-State: AOAM532mLSX7yQQQ8/oYcEb+5+2z6IQLodDRrRubk0hXTI02+RfD3ftc
        FWIYNjtw0f2ARMdhl3/pnFLc78KFOw8dGw==
X-Google-Smtp-Source: ABdhPJw+9m9vB8beLjA4xu4YXLGtqLR6YRcejHpeuD8QQnOtRrkgmMGB4OtckNpfUa5hPqGkcteXIA==
X-Received: by 2002:a0c:beca:: with SMTP id f10mr7406751qvj.97.1639600817287;
        Wed, 15 Dec 2021 12:40:17 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m9sm1612493qkn.59.2021.12.15.12.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:40:16 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 05/11] btrfs: disable scrub for extent-tree-v2
Date:   Wed, 15 Dec 2021 15:40:02 -0500
Message-Id: <1a661954275c0a092756a0cad668a92848250e11.1639600719.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639600719.git.josef@toxicpanda.com>
References: <cover.1639600719.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Scrub depends on extent references for every block, and with extent tree
v2 we won't have that, so disable scrub until we can add back the proper
code to handle extent-tree-v2.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 4ae87f44ce46..c81f50774cec 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3708,6 +3708,11 @@ static long btrfs_ioctl_scrub(struct file *file, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		btrfs_err(fs_info, "scrub is not supported on extent tree v2 yet.");
+		return -EINVAL;
+	}
+
 	sa = memdup_user(arg, sizeof(*sa));
 	if (IS_ERR(sa))
 		return PTR_ERR(sa);
-- 
2.26.3

