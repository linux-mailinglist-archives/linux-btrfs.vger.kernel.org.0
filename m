Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE632AF6B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 17:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgKKQjU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Nov 2020 11:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgKKQjU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Nov 2020 11:39:20 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F4BC0613D1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Nov 2020 08:39:20 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id c20so1920577pfr.8
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Nov 2020 08:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AiW7yyfB8tn48PKZrTFVJ6RG8FdQwIZDONvE2FQmT1E=;
        b=Zic48G5zBfxaWugoU58Zq1xEbuUgcvxdgy33hNj68lfe+8QTvD1RAYeU82OTx1IQv9
         qpusI5qbyoAz70HoRAKXZEBlh/2L6yQJ5TFgqO8/cLP8Dkig+zWCbHaZtH4W1g+eyFR+
         v6rKI3HKVQmUQJ3fushGpLbf+LiAkxsjI5zXt+rJCyv7pMQ84csfAWam9asH12Qke3km
         82b30jp5RxA4tb+jd/JjFlLXCBq1OKFQdxPgSf84e2orYTHvtwRw2dGQ/H11KMbTd9zH
         IoMHqm5s8fSXJ+1/12C/O4V7UAkGvGov486pjSdv8CYRs7439gc/4CnWELvLDBOIG+ez
         N6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AiW7yyfB8tn48PKZrTFVJ6RG8FdQwIZDONvE2FQmT1E=;
        b=OU3X/iOYZ/P5izEJZA4g9cUKv5E8rqIzYkzNMzbG8zvmWtJC052pPOmBs57UrlIMFT
         rX3T8GVZfgbJq0cXhsI2hifjWBGM6B+MGnwnlwjze5QcAi5CrXsit3r+FfZ8mfoyAfY+
         W0rMpnHHMDAQvh6Cq81uYXY8JhufrurVX1H0Td7XgfZqD+4ZgP5Zu07Ol/7GdFmv1168
         lSlKBJm9BS5jgRAW9DSkCDFAIMDaqseqHGVkgeXyd5p61W6VCC40WD3EgSyNQ1BD0Xfv
         qLxZtmBLh6vCMNvmXt4tldOnAeRxFn2/7t5rH01Z91Qk7wCClUj6IjsABT+OFg0rmev+
         Eh7A==
X-Gm-Message-State: AOAM530UyS6l7EmKa6R9dCMkR7bmyeozJlCUgfLoNBALg53dHWlzSfIJ
        y7iyb5HOmx76rw6aZLOt0p7mEHvmjfsraQ==
X-Google-Smtp-Source: ABdhPJzNb6jGsueiZEzjV49BICAWaC3kjfioeGoLD07je/BtZ8oNdmpez0T7aNMotXlE5OfXM2bYOg==
X-Received: by 2002:a63:6305:: with SMTP id x5mr22900531pgb.269.1605112759941;
        Wed, 11 Nov 2020 08:39:19 -0800 (PST)
Received: from localhost.localdomain ([175.195.128.78])
        by smtp.googlemail.com with ESMTPSA id y8sm3013533pge.22.2020.11.11.08.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 08:39:19 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v2 1/2] btrfs-progs: common: introduce fmt_print_start_object
Date:   Wed, 11 Nov 2020 16:39:08 +0000
Message-Id: <20201111163909.3968-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce a new function that can be used when you need to print an json
object in command like "device stats".

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 common/format-output.c | 20 ++++++++++++++++++++
 common/format-output.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/common/format-output.c b/common/format-output.c
index 8df93ecb..f31e7259 100644
--- a/common/format-output.c
+++ b/common/format-output.c
@@ -213,6 +213,26 @@ void fmt_print_end_group(struct format_ctx *fctx, const char *name)
 	}
 }
 
+void fmt_print_start_object(struct format_ctx *fctx)
+{
+	if (bconf.output_format == CMD_FORMAT_JSON) {
+		fmt_separator(fctx);
+		fmt_inc_depth(fctx);
+		fctx->memb[fctx->depth] = 0;
+		putchar('{');
+	}
+}
+
+void fmt_print_end_object(struct format_ctx *fctx)
+{
+	if (bconf.output_format == CMD_FORMAT_JSON) {
+		fmt_dec_depth(fctx);
+		putchar('\n');
+		fmt_indent2(fctx->depth);
+		putchar('}');
+	}
+}
+
 /* Use rowspec to print according to currently set output format */
 void fmt_print(struct format_ctx *fctx, const char* key, ...)
 {
diff --git a/common/format-output.h b/common/format-output.h
index bcc2d74d..9d606482 100644
--- a/common/format-output.h
+++ b/common/format-output.h
@@ -87,4 +87,7 @@ void fmt_print_start_group(struct format_ctx *fctx, const char *name,
 		enum json_type jtype);
 void fmt_print_end_group(struct format_ctx *fctx, const char *name);
 
+void fmt_print_start_object(struct format_ctx *fctx);
+void fmt_print_end_object(struct format_ctx *fctx);
+
 #endif
-- 
2.25.1

