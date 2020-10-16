Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AECE290859
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 17:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410106AbgJPP33 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 11:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407581AbgJPP33 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 11:29:29 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A23C061755
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:29:28 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id a23so2189048qkg.13
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=izFhU7y9bRtQlue4F9fNXBKfqx5axdLtCILmMRY3Qkk=;
        b=QAF9Jd9I3u0Z5FjAcUZA+/zk+0IviBgtOEJUVP6zV0evnY3QEdXH7NwgBHtWrhUQ01
         HdLDTJFvAz3RB0T9kUVWo+t6T5npWSiFwSr1zuOb1wNCoyGs1HU8wWQHRec1+LvP2/FY
         kaerIhioapn2ufQaOWFO2TfQI9pBhwuIV6UlK4E9m/XArLJQdsDZF/sDT6HjHCBbFN3W
         mtxaDGnPozYT4c7NtxmrqDPuotlCr39WDPcX8DCL5XD1+NPEfq9MTyE8Zw2+VixHIM8u
         9YghjEzfdUvFy4r2Y2IFDc/+6xWxBj1JzAdL6S6Ta5vDYXjBtfC7X7y0ZXsdBbRq5G0K
         affA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=izFhU7y9bRtQlue4F9fNXBKfqx5axdLtCILmMRY3Qkk=;
        b=ou8OFAaq4oVX9aqyMq93v0889gRyA2xzX8DRuDu4wgY22e7kmEboVTdzFOULEMQsba
         mVNdpzBudSsRFkxiBnSHIMPxrLIta4EF0mjpV7cF3B3q8IHAfDyrU1OH0DPYnDYlwrg0
         Lu76/cdQ/BOBIsF9j9BtEwC6TMOqSePMFwqHN4+0y+pgs8uVEEQQw2q7pXpvBorT3Z+u
         X7IvhlOEy73M6bV2Mp6MPYfKXWK//0p19f6iD1b3rP2uaHF0+yesrDTqmLPoyGSUyim0
         gg1GMQkMe477I4iYIYkHcIwqhfsmwuRukMOzBJtM8rkkp31m5lyEZGGWbguHELug8Vn1
         rwWA==
X-Gm-Message-State: AOAM533GMGhZR5mPCxajM6BzvntusaaxEP8QRmlyG+wyC1UdYOaTWHHf
        7Nu0u/O9B8RHwMzlt8Ez6oOd0ZD9y3OLGclI
X-Google-Smtp-Source: ABdhPJyEJSxLaFb++64fpVcCuIQRb3ASbbeRFmzzt1SJeDe3P5h91DzDl7dNxe+e08tMLiX9AUk/ZQ==
X-Received: by 2002:a37:9a46:: with SMTP id c67mr4372499qke.292.1602862167759;
        Fri, 16 Oct 2020 08:29:27 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 184sm984039qkl.34.2020.10.16.08.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 08:29:27 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 3/8] btrfs: add a supported_rescue_options file to sysfs
Date:   Fri, 16 Oct 2020 11:29:15 -0400
Message-Id: <fc52d1d1355192180c2ad6942b8b3857e108d19b.1602862052.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602862052.git.josef@toxicpanda.com>
References: <cover.1602862052.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're going to be adding a variety of different rescue options, we
should advertise which ones we support to make user spaces life easier
in the future.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/sysfs.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 8424f5d0e5ed..8f0462d6855d 100644
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

