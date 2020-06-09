Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D521F3886
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jun 2020 12:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgFIKsz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Jun 2020 06:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728923AbgFIKsL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Jun 2020 06:48:11 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F93C0085C8
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Jun 2020 03:47:49 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id mb16so21825382ejb.4
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Jun 2020 03:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Oemz0y6Halgxd9K+njjbf/y07mF1lR81JfjGGt4j8Io=;
        b=iITZQzepYu0FYulcuAhfuDWi/16M56AofW8Jkk4EXje7LbpCfGgXUXt4mVAD9S9GAw
         P+KF91qsLae1yBZk64Eg+7MySqXAxm70J5T+GDaXmvB6yqpm1YwWgnx0eILvxCZQa4MO
         X2ZWDcSlKGJFb11dXXX6js7YuCRCGcjtoaxJFWBRsMondULfk44oem6UjT7ztiVd3pyU
         szY/KiRL3JZp7Io/US70tlqqcMRIAEfqU8yow87c1sn10HkU9ATAn19ec8IL4Jx1OUil
         GB2SP9aX8K7qOmh+/5PsYzLi1cxu80fu6P2jMFuHf47QqwLcm+UOIaNkIVo62p22r1QP
         dvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Oemz0y6Halgxd9K+njjbf/y07mF1lR81JfjGGt4j8Io=;
        b=Fgd9ABKZlMwqTMb534GvI+jEqdlRM+D5cAcGuFtnN8TZyrP6iXQ9l5tZd0e59cldZy
         jiarXUHG/tcDf2QBFUaDkyJdh6oW8+bIeupERSuJhL0r6DNOieU5Qm8u3CNLCQr/mnby
         TS4k+q1+puJHYa+HpX1qjLRG1ZXkeetfKbwmfZcapdOxR2Gy3Zd5lKFKOAjmaFFlkuLS
         YglVInGTrNfewPeYGG4PgBL8VawTLCXgW996gACkF2exexV6EwYfXTRNqdZVsCQezMC0
         /0sc2M6THY4fsvQUKHf898dor0/t/D4vwhHJHHZ5Svt/0t3MwCdReQwD2CQO4ELxhd0/
         plFA==
X-Gm-Message-State: AOAM530xm/MDsf4XkUJh/nGMngTxD4POlX4ugg8hWgjvkJAQSLZf+8iO
        /h5bjaQLzkCdZ6/qWZatC4RFyA==
X-Google-Smtp-Source: ABdhPJwmQrjonfoCvhtTfzguHCYRItN0w74Xgjx0CUyTWFohneAUdPJcTlC7X6PECCEadzOmV1lOkw==
X-Received: by 2002:a17:906:b097:: with SMTP id x23mr24627789ejy.227.1591699667897;
        Tue, 09 Jun 2020 03:47:47 -0700 (PDT)
Received: from localhost.localdomain (hst-221-69.medicom.bg. [84.238.221.69])
        by smtp.gmail.com with ESMTPSA id qt19sm12267763ejb.14.2020.06.09.03.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 03:47:47 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 7/7] venus: Add a debugfs file for SSR trigger
Date:   Tue,  9 Jun 2020 13:46:04 +0300
Message-Id: <20200609104604.1594-8-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609104604.1594-1-stanimir.varbanov@linaro.org>
References: <20200609104604.1594-1-stanimir.varbanov@linaro.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The SSR (SubSystem Restart) is used to simulate an error on FW
side of Venus. We support following type of triggers - fatal error,
div by zero and watchdog IRQ.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/dbgfs.c | 31 +++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/dbgfs.c b/drivers/media/platform/qcom/venus/dbgfs.c
index a2465fe8e20b..59d52e5af64a 100644
--- a/drivers/media/platform/qcom/venus/dbgfs.c
+++ b/drivers/media/platform/qcom/venus/dbgfs.c
@@ -9,6 +9,35 @@
 
 extern int venus_fw_debug;
 
+static int trigger_ssr_open(struct inode *inode, struct file *file)
+{
+	file->private_data = inode->i_private;
+	return 0;
+}
+
+static ssize_t trigger_ssr_write(struct file *filp, const char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	struct venus_core *core = filp->private_data;
+	u32 ssr_type;
+	int ret;
+
+	ret = kstrtou32_from_user(buf, count, 4, &ssr_type);
+	if (ret)
+		return ret;
+
+	ret = hfi_core_trigger_ssr(core, ssr_type);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations ssr_fops = {
+	.open = trigger_ssr_open,
+	.write = trigger_ssr_write,
+};
+
 int venus_dbgfs_init(struct venus_core *core)
 {
 	core->root = debugfs_create_dir("venus", NULL);
@@ -17,6 +46,8 @@ int venus_dbgfs_init(struct venus_core *core)
 
 	debugfs_create_x32("fw_level", 0644, core->root, &venus_fw_debug);
 
+	debugfs_create_file("trigger_ssr", 0200, core->root, core, &ssr_fops);
+
 	return 0;
 }
 
-- 
2.17.1

