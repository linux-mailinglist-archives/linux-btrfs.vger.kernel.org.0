Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00B8352EDF
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Apr 2021 20:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbhDBSC5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Apr 2021 14:02:57 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:50884 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbhDBSC4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Apr 2021 14:02:56 -0400
Received: by mail-pj1-f51.google.com with SMTP id gb6so3050738pjb.0;
        Fri, 02 Apr 2021 11:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ilVhQoq0A8nFmQwG/qx5FGA0+OXGRAHVEg0+WKw9N+Q=;
        b=Ca449epCqjVOOqTj8U9x1ocBR80QU2v6oChtEVIk82db8JvA3FHE75g50DzV9teLCZ
         o/ibHypYTLJ0dEMJe+wn2G6zjeUFIlV1UUh9Lrrdb1miTsTirwUc2levF7K800zSKiHK
         SAF4KP8ck174NjCarlHksGij68aqcv2Gfc7Mc/o8aNKdOAOTzqsQW7Ads2F3hfDid02M
         2uBcpsX9vpEhT7pdvSrKIxC03G36yleFfhnesJeKLfZLrJk8MQ+9rN/01ZJu6XXXkO3l
         +PZBL5cyHRGQqOjHMQaixdhjCXyMG0SoW5Wwpf+Dga780F8SJ918OohZ/edtw9NAZwET
         KBeA==
X-Gm-Message-State: AOAM531WbYXZjYdlDI5tEukrUxwBj8DWcijaYQ46bMAsgQVu1A7WqQ5S
        NwJRdE5qVgKY8mZfWabtnz2cJy673IvNUg==
X-Google-Smtp-Source: ABdhPJymdQn07uy6uBMp/RrpWwdbN+U8+FQroRjxV+gCiXoPQRYIrbBiN+THgR4JqTtaNdfxu3IeYw==
X-Received: by 2002:a17:902:f545:b029:e7:1d03:65d4 with SMTP id h5-20020a170902f545b02900e71d0365d4mr13753563plf.38.1617386575090;
        Fri, 02 Apr 2021 11:02:55 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id w2sm3481102pfb.174.2021.04.02.11.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 11:02:54 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 9FEEC404D5; Fri,  2 Apr 2021 18:02:53 +0000 (UTC)
Date:   Fri, 2 Apr 2021 18:02:53 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lukas Middendorf <kernel@tuxforce.de>
Cc:     linux-btrfs@vger.kernel.org, Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: Is request_firmware() really safe to call in resume callback
 when /usr/lib/firmware is on btrfs?
Message-ID: <20210402180253.GS4332@42.do-not-panic.com>
References: <20200813163749.GV4332@42.do-not-panic.com>
 <0b1621bf-fc82-1a56-c11f-c5c46677e59e@tuxforce.de>
 <20200813221348.GB4332@42.do-not-panic.com>
 <fc887e06-874c-79d8-0607-4e27ae788446@tuxforce.de>
 <20200814163723.GC4332@42.do-not-panic.com>
 <a79f1a0c-012d-bebe-c9c7-b505f59079c2@tuxforce.de>
 <20200817152056.GD4332@42.do-not-panic.com>
 <9e5c716e-1736-9890-54be-75739ea5462f@tuxforce.de>
 <20200818143715.GF4332@42.do-not-panic.com>
 <6b61e549-42b8-8e71-ff57-43b7c5b4291f@tuxforce.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b61e549-42b8-8e71-ff57-43b7c5b4291f@tuxforce.de>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 01, 2021 at 04:59:47PM +0200, Lukas Middendorf wrote:
> Hello Luis,
> 
> 
> On 18/08/2020 16:37, Luis Chamberlain wrote:
> > On Tue, Aug 18, 2020 at 12:04:51AM +0200, Lukas Middendorf wrote:
> > > On 17/08/2020 17:20, Luis Chamberlain wrote:
> > > > This helps, thanks so much, now we'll have to write a reproducer, thanks
> > > > for the report!!
> > > 
> > > Will you do it yourself or do you expect me to do anything for this?
> > 
> > I meant to imply that we'd do this, now that we understand the problem. Thanks
> > for your report!
> 
> any news on this issue? Did you succeed with reproducing this at your end?

No sorry, I dropped the ball on this but I managed to now spawn up the
virtual guests where I was doing development to reproduce this. Give me
some time and I will zero in on this now.

For now what I have is the following to test this, I next will work
on the userspace part.

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 9fee2b93a8d1..f9e67fc4145a 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -18,6 +18,7 @@
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -33,6 +34,8 @@
 static DEFINE_MUTEX(test_fw_mutex);
 static const struct firmware *test_firmware;
 
+static struct platform_device *pdev;
+
 struct test_batched_req {
 	u8 idx;
 	int rc;
@@ -53,6 +56,9 @@ struct test_batched_req {
  * @sync_direct: when the sync trigger is used if this is true
  *	request_firmware_direct() will be used instead.
  * @send_uevent: whether or not to send a uevent for async requests
+ * @enable_resume_test: if @senable_resume is true this will enable a test to
+ *	issue a request_firmware() upon resume. This is useful to test resume
+ *	after suspend filesystem races.
  * @num_requests: number of requests to try per test case. This is trigger
  *	specific.
  * @reqs: stores all requests information
@@ -91,6 +97,7 @@ struct test_config {
 	bool into_buf;
 	bool sync_direct;
 	bool send_uevent;
+	bool enable_resume_test;
 	u8 num_requests;
 	u8 read_fw_idx;
 
@@ -184,6 +191,7 @@ static int __test_firmware_config_init(void)
 	test_fw_config->send_uevent = true;
 	test_fw_config->into_buf = false;
 	test_fw_config->sync_direct = false;
+	test_fw_config->enable_resume_test = false;
 	test_fw_config->req_firmware = request_firmware;
 	test_fw_config->test_result = 0;
 	test_fw_config->reqs = NULL;
@@ -257,6 +265,9 @@ static ssize_t config_show(struct device *dev,
 	len += scnprintf(buf+len, PAGE_SIZE - len,
 			"sync_direct:\t\t%s\n",
 			test_fw_config->sync_direct ? "true" : "false");
+	len += scnprintf(buf+len, PAGE_SIZE - len,
+			"enable_resume_test:\t\t%s\n",
+			test_fw_config->enable_resume_test ? "true" : "false");
 	len += scnprintf(buf+len, PAGE_SIZE - len,
 			"read_fw_idx:\t%u\n", test_fw_config->read_fw_idx);
 
@@ -422,6 +433,22 @@ static ssize_t config_sync_direct_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(config_sync_direct);
 
+static ssize_t config_enable_resume_test_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	return test_dev_config_update_bool(buf, count,
+					   &test_fw_config->enable_resume_test);
+}
+
+static ssize_t config_enable_resume_test_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	return test_dev_config_show_bool(buf, test_fw_config->enable_resume_test);
+}
+static DEVICE_ATTR_RW(config_enable_resume_test);
+
 static ssize_t config_send_uevent_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
@@ -929,6 +956,7 @@ static struct attribute *test_dev_attrs[] = {
 	TEST_FW_DEV_ATTR(config_into_buf),
 	TEST_FW_DEV_ATTR(config_sync_direct),
 	TEST_FW_DEV_ATTR(config_send_uevent),
+	TEST_FW_DEV_ATTR(config_enable_resume_test),
 	TEST_FW_DEV_ATTR(config_read_fw_idx),
 
 	/* These don't use the config at all - they could be ported! */
@@ -958,6 +986,81 @@ static struct miscdevice test_fw_misc_device = {
 	.groups 	= test_dev_groups,
 };
 
+static int __maybe_unused test_firmware_suspend(struct device *dev)
+{
+	return 0;
+}
+
+
+static int __maybe_unused test_firmware_resume(struct device *dev)
+{
+	int rc;
+
+	if (!test_fw_config->enable_resume_test)
+		return 0;
+
+	pr_info("resume test, loading '%s'\n", test_fw_config->name);
+
+	mutex_lock(&test_fw_mutex);
+	release_firmware(test_firmware);
+	test_firmware = NULL;
+	rc = request_firmware(&test_firmware, test_fw_config->name, dev);
+	if (rc) {
+		mutex_unlock(&test_fw_mutex);
+		pr_info("load of '%s' failed: %d\n", test_fw_config->name, rc);
+		goto out;
+	}
+
+	pr_info("loaded: %zu\n", test_firmware->size);
+	mutex_unlock(&test_fw_mutex);
+	pr_info("resume test, completed successfully\n");
+out:
+	return rc;
+}
+
+static SIMPLE_DEV_PM_OPS(test_dev_pm_ops, test_firmware_suspend, test_firmware_resume);
+
+static int test_firmware_probe(struct platform_device *dev)
+{
+	int rc;
+
+	rc = misc_register(&test_fw_misc_device);
+	if (rc) {
+		kfree(test_fw_config);
+		pr_err("could not register misc device: %d\n", rc);
+		return rc;
+	}
+
+	pr_info("interface ready\n");
+
+	return 0;
+}
+
+static int test_firmware_remove(struct platform_device *dev)
+{
+	mutex_lock(&test_fw_mutex);
+	release_firmware(test_firmware);
+	misc_deregister(&test_fw_misc_device);
+	mutex_unlock(&test_fw_mutex);
+
+	return 0;
+}
+
+static void test_firmware_shutdown(struct platform_device *dev)
+{
+}
+
+static struct platform_driver test_firmware_driver = {
+	.driver		= {
+		.name	= "test_firmware",
+		.pm	= &test_dev_pm_ops,
+	},
+	.probe		= test_firmware_probe,
+	.remove		= test_firmware_remove,
+	.shutdown	= test_firmware_shutdown,
+};
+
+
 static int __init test_firmware_init(void)
 {
 	int rc;
@@ -973,28 +1076,39 @@ static int __init test_firmware_init(void)
 		return rc;
 	}
 
-	rc = misc_register(&test_fw_misc_device);
-	if (rc) {
-		kfree(test_fw_config);
-		pr_err("could not register misc device: %d\n", rc);
-		return rc;
-	}
+	rc = platform_driver_register(&test_firmware_driver);
+	if (rc)
+		goto err_alloc;
 
-	pr_warn("interface ready\n");
+	pdev = platform_device_alloc("test_firmware", -1);
+	if (!pdev)
+		goto err_driver_unregister;
+
+	rc = platform_device_add(pdev);
+	if (rc)
+		goto err_free_device;
 
 	return 0;
+
+ err_free_device:
+	platform_device_put(pdev);
+ err_driver_unregister:
+	platform_driver_unregister(&test_firmware_driver);
+ err_alloc:
+	__test_firmware_config_free();
+	kfree(test_fw_config);
+	return rc;
 }
 
 module_init(test_firmware_init);
 
 static void __exit test_firmware_exit(void)
 {
-	mutex_lock(&test_fw_mutex);
-	release_firmware(test_firmware);
-	misc_deregister(&test_fw_misc_device);
+	platform_device_unregister(pdev);
+	platform_driver_unregister(&test_firmware_driver);
+
 	__test_firmware_config_free();
 	kfree(test_fw_config);
-	mutex_unlock(&test_fw_mutex);
 
 	pr_warn("removed interface\n");
 }

  Luis
