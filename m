Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4354A24CFC0
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Aug 2020 09:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgHUHlz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Aug 2020 03:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgHUHkZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Aug 2020 03:40:25 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05956C061347
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 00:40:24 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k13so500763plk.13
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 00:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mgsnIgL+IvZplax195HHX4KdCvvnZvjwiqUDsUSCJTs=;
        b=Dlde6+uYoywdVmoLmwOkSUHyy0rwvL9pwXRsfiKY7YdJt/HVf5wnwW0y01SkvSWPlZ
         rCRy8/yFHkQjXxTdBpdGLsu/ji0vWrcdejvWQIcDYfuo8hu9T0FjTBMYR1qXkLcepFGp
         hnaBFm+Jq0q0g+A9iusg+J/73V2mwzo8OdMxeIOufsCt5kqyGVYIp82dZ9vTZOd31Sfv
         BuDMEu1iikUHg5BkCznnbqSPIjlSvvYB3ddqjOYHeXGCrb6LcNr32xdnSCCFo5lmBh3J
         TQtpsHy6aBtp908+RHQu+qOuwZ9BrlT62VXiKTbA2GyYGpLGd0TFxNEGJKGZN7NDTjOJ
         BVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mgsnIgL+IvZplax195HHX4KdCvvnZvjwiqUDsUSCJTs=;
        b=Hca7Y1x95nHYJzBP2iRXxJUummVYnINI0cACH/DsJeiJBHluNNoI2octQ4dwdUbU2c
         tN6SOLfjvg5swMNKcm3WgB66d2YB2Lds3IHB+D9AFiYZ+ST011SUJomZuiy4urXoIxsX
         ZQy4OxriKchRzIOxJS3oGv3H0LqYkqpygcHwOCSda14fByXvyTqSp1PoCD+oMsbVbL0B
         5UStZlblLCNkvM0rGU0fKvVKyKRg7J9jgRj83YOGTmprUToIBm4UH9U3k2A/xmKvJ5ST
         YJjve/FyrjUMRRRPtWsT/cl8hFwUKATIOjsuGtgtwl4rX5NciCaXpSGteOoCHpv32Lr+
         MRqQ==
X-Gm-Message-State: AOAM530KOpRK2c42p1DuspHYUEMwnHn+6MJi4MvebIlv7BTi5dMQnz0o
        /LwaQU2krJdXk8gJwINtLClHCfXUPsdRzw==
X-Google-Smtp-Source: ABdhPJxhhCeCersWB9PVIx9eJ0Hx+EKvXsK5RH5PjZMa0qJK2MqKAsmS18D8c2cGa01sEF4vC1Ao1A==
X-Received: by 2002:a17:90a:c682:: with SMTP id n2mr1505058pjt.72.1597995622847;
        Fri, 21 Aug 2020 00:40:22 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id jb1sm1080875pjb.9.2020.08.21.00.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:40:21 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/9] btrfs: add send_stream_version attribute to sysfs
Date:   Fri, 21 Aug 2020 00:39:54 -0700
Message-Id: <742f77f23ac5bd5feec8edc0b88e122303faac0d.1597994106.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597994106.git.osandov@osandov.com>
References: <cover.1597994106.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This reports the latest send stream version supported by the kernel.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/sysfs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 8593086d1d10..34d21edff7d7 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -14,6 +14,7 @@
 #include "ctree.h"
 #include "discard.h"
 #include "disk-io.h"
+#include "send.h"
 #include "transaction.h"
 #include "sysfs.h"
 #include "volumes.h"
@@ -321,9 +322,17 @@ static ssize_t supported_checksums_show(struct kobject *kobj,
 }
 BTRFS_ATTR(static_feature, supported_checksums, supported_checksums_show);
 
+static ssize_t send_stream_version_show(struct kobject *kobj,
+					struct kobj_attribute *ka, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", BTRFS_SEND_STREAM_VERSION);
+}
+BTRFS_ATTR(static_feature, send_stream_version, send_stream_version_show);
+
 static struct attribute *btrfs_supported_static_feature_attrs[] = {
 	BTRFS_ATTR_PTR(static_feature, rmdir_subvol),
 	BTRFS_ATTR_PTR(static_feature, supported_checksums),
+	BTRFS_ATTR_PTR(static_feature, send_stream_version),
 	NULL
 };
 
-- 
2.28.0

