Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB020289922
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 22:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390570AbgJIUJv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 16:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391090AbgJIUIY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 16:08:24 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707C2C0613AA
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 13:07:29 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z33so5046954qth.8
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 13:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SpGBSwJV9+4FQISbzDXxU0agkkm03QSM5d/DDpeMQfY=;
        b=L1WTA/q3usWdQyjiW/hHocW4+9LpUJnZSEa1fxiVHJW4ctY6DsHhmSE2YveU5m+pDX
         uMhaugcnMe0IFygEG9cbMBxRO5CGVXrl15IEHbGVaENs1Gh/aeZL45hDks8KC70M22Ha
         jeOLoN8j3zg5bgXDVvvT13LQokEVJmtYOkgFMWxn/Zdzvk/Zs+RP6epfz1Uz0nsPxdQu
         aWSNUPBAgipKJOykwtQ7TJaSSAQfy8jUinXbc0hp0RlNWqdSyky+361uzhh3Z+qCK6cU
         WHeqw3A4DxhSh8LFjOKFaBSCAeDPRmSxuemmyYgVYI4+3SRwQDKVOZmoBHOBxTeOjaKO
         YkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SpGBSwJV9+4FQISbzDXxU0agkkm03QSM5d/DDpeMQfY=;
        b=ENsSfydJhqApk+G1yOrIlWo5p+sbviBwKWZTeiYzeY7R5r0WRVU9YVD1x2ZE2m5K90
         D5N55m/2gqVG4jdUH6h2O74/mxP09weMWsH5+S4KxV2QadzJGd2J4SXoXmQfBvttIFPO
         XjSkONjNv/TqJay1cjMx78bCc+/m0AOZPiFjGPeaDpR2yzC6jnL+E6W1FH6wZtJ3jw4n
         HpX1Ty7FzKjjYxYVTz7ipK5BU7ZzP0KW/sEDWmG4Ya4K8Ww4FghIrtABDGMEQR1pWB3b
         bd2JZ06z0qig2cZ3oPQl1af6budiS+2C/54IjsdZldsdKZ02bt+wsN5lzXGvE4aYmJM6
         4sNw==
X-Gm-Message-State: AOAM53172GVa3sQS9uExdmejYNsC8hUFW7djh/NQ8eDQnUT3x1UkStWM
        l23sNpxfMbCAIwlCvbuDV8uOLuW8qB/nJpqL
X-Google-Smtp-Source: ABdhPJzTdpfI0xBR3E46Tbiza98W6QS5X7E5LHYTYlor1sBOOuSFT77kYGotQckjNGi22bEcbyc30w==
X-Received: by 2002:ac8:7281:: with SMTP id v1mr14872671qto.229.1602274048168;
        Fri, 09 Oct 2020 13:07:28 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h199sm7010512qke.112.2020.10.09.13.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 13:07:27 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 3/8] btrfs: add a supported_rescue_options file to sysfs
Date:   Fri,  9 Oct 2020 16:07:15 -0400
Message-Id: <8ac207c64e2917d7980570e6c9f696e234baf070.1602273837.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602273837.git.josef@toxicpanda.com>
References: <cover.1602273837.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're going to be adding a variety of different rescue options, we
should advertise which ones we support to make user spaces life easier
in the future.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/sysfs.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 279d9262b676..5c558e65c1ba 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -329,10 +329,32 @@ static ssize_t send_stream_version_show(struct kobject *kobj,
 }
 BTRFS_ATTR(static_feature, send_stream_version, send_stream_version_show);
 
+static const char *rescue_opts[] = {
+	"usebackuproot",
+	"nologreplay",
+};
+
+static ssize_t supported_rescue_options_show(struct kobject *kobj,
+					     struct kobj_attribute *a,
+					     char *buf)
+{
+	ssize_t ret = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rescue_opts); i++)
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
+				 (i ? " " : ""), rescue_opts[i]);
+	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
+	return ret;
+}
+BTRFS_ATTR(static_feature, supported_rescue_options,
+	   supported_rescue_options_show);
+
 static struct attribute *btrfs_supported_static_feature_attrs[] = {
 	BTRFS_ATTR_PTR(static_feature, rmdir_subvol),
 	BTRFS_ATTR_PTR(static_feature, supported_checksums),
 	BTRFS_ATTR_PTR(static_feature, send_stream_version),
+	BTRFS_ATTR_PTR(static_feature, supported_rescue_options),
 	NULL
 };
 
-- 
2.26.2

