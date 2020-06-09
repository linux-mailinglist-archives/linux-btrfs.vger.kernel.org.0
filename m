Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD171F3899
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jun 2020 12:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgFIKtp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Jun 2020 06:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbgFIKro (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Jun 2020 06:47:44 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8B9C00862D
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Jun 2020 03:47:41 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id k11so21836437ejr.9
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Jun 2020 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/5WnBa7fJn+pPKP5P8jfdYigZEMgAeAJ+nmAq9FbnZM=;
        b=hS4A2h3J+Pci4Lw+anaXS2PuQgAH2hIHxpqd0ezXZxBZ9me+hfgdQg5mvHjcq8SUiO
         EuY6p0NBvRb45UuQrdbwSLXcPmCxwBvC1lHF5LyVoiaJ8Sx7LThvB+VK7ZsHRno9Y2uz
         6SBK2Nd8vb3GB5GOe8DWi6HPJvQeRk3hvhBy5OICiWc0tGOHQHpN2pIM2xv/FIUgpWI6
         D+4lRUw0r9eb4u0Y5WU5nkzEVplGGsS2HlRlIsldw/wj3Ik+gd67w1NVDuyHJGq/QF/p
         77MD86DPubivo8gbrQsAWCFwqMs/4ctENZres/LCUYw3JixwjJNmIkS6ZdOBqPwqK80t
         UO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/5WnBa7fJn+pPKP5P8jfdYigZEMgAeAJ+nmAq9FbnZM=;
        b=JiF/eLKv5xV2sM2iPTdG9FWa7r+i1IfMotmlQPbMRzZC0rhsLbLe8LVdL5ZXFSETGg
         jhcCY3unhsCqkGT6sy7LOI2ckhZoGW9E8ypgM7mi/b2QJcEZEn6qCbCGLEr2kYiD0EN7
         W2zODrrvuc2GQCMh/ppD3SGHUh0RRfC2iFzB+FazW+/VG+xgCUaJ8W5jd6dYjhaJUGUb
         vovi3ibAhsDsPWENlmL6gwmSDqxQvLEhPnIRcOFdgJ4Hky92mvFprngA1s0dfYyfSgCL
         CrxGWb/9ofCRxnnovgy0G7n/dIBC49atE/SlTwQX6QC1ustuO2atxL5ZoYGPb3DcYmtO
         SJ2Q==
X-Gm-Message-State: AOAM532mt9z44Ok4vSFI8FRxmpMWkyoRIVls52pcENNHzYVRDVGL4I4Y
        lxdLC/Q5xGF4h5hHrKQRdK4K+A==
X-Google-Smtp-Source: ABdhPJzH/K2NQQ2rv61OJWPAnFYGeM8y8y32U0bjShreSrArNp7+PSoZt2khzLblWMU0Eg0n23fgQA==
X-Received: by 2002:a17:907:ab9:: with SMTP id bz25mr24488816ejc.39.1591699659825;
        Tue, 09 Jun 2020 03:47:39 -0700 (PDT)
Received: from localhost.localdomain (hst-221-69.medicom.bg. [84.238.221.69])
        by smtp.gmail.com with ESMTPSA id qt19sm12267763ejb.14.2020.06.09.03.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 03:47:39 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 3/7] dev_printk: Add dev_dbg_level macro over dynamic one
Date:   Tue,  9 Jun 2020 13:46:00 +0300
Message-Id: <20200609104604.1594-4-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609104604.1594-1-stanimir.varbanov@linaro.org>
References: <20200609104604.1594-1-stanimir.varbanov@linaro.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add dev_dbg_level macro wrapper over dynamic debug one for
dev_dbg variants.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 include/linux/dev_printk.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index 7b50551833e1..d639dc60d84d 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -112,15 +112,24 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
 #if defined(CONFIG_DYNAMIC_DEBUG)
 #define dev_dbg(dev, fmt, ...)						\
 	dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_dbg_level(dev, lvl, fmt, ...)				\
+	dynamic_dev_dbg_level(dev, lvl, dev_fmt(fmt), ##__VA_ARGS__)
 #elif defined(DEBUG)
 #define dev_dbg(dev, fmt, ...)						\
 	dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_dbg_level(dev, lvl, fmt, ...)				\
+	dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
 #else
 #define dev_dbg(dev, fmt, ...)						\
 ({									\
 	if (0)								\
 		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
 })
+#define dev_dbg_level(dev, lvl, fmt, ...)				\
+({									\
+	if (0)								\
+		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
+})
 #endif
 
 #ifdef CONFIG_PRINTK
-- 
2.17.1

