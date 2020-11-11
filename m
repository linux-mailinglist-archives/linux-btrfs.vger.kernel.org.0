Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD2A2AF5EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 17:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgKKQOU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Nov 2020 11:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgKKQOU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Nov 2020 11:14:20 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC03C0613D1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Nov 2020 08:14:19 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id c66so1895985pfa.4
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Nov 2020 08:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AiW7yyfB8tn48PKZrTFVJ6RG8FdQwIZDONvE2FQmT1E=;
        b=KJvGOrms+4RlrmWBCW0IXQw0JYOl++1Yo+SFREArmw2rkfS/2vlDXJcDp8TxwFkftR
         ZwEVRKXTzWL2wcQR28z0g1EXnGT+z1eZbJH9Q3PP1K8oE4Nk5XjKE6QzRlARW0ZVD6ZS
         ZLukiiOprnUG4pMzBtukAFnDC85/si2bDi2mJB0honfxJPWri1U72DvOg8QK8dbdJs7Y
         JpSQrC+DgnT9nPdrwiH51D8CWq7Lf6pzChPDABrRRcGx3e/zBBC0K/Li4yGVSByYI7rD
         pvbl264etWd9rhDuiCj4YQTLqteQEWqyTmNQtCzwBrOLlcbqWeueeKGX5QukN9ei3fTK
         Mebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AiW7yyfB8tn48PKZrTFVJ6RG8FdQwIZDONvE2FQmT1E=;
        b=I05yiWmKUwKnaydN+QpFnZNNj5/zb9zXw07hNZOA2i6h3VIsiOzMmcuT/xEluf+u6S
         fc933YKhqLt6NcN2l9E9IctJ/cLYfOu2vwVeRoORMKPFkmZl6aj1CHz004gVK+TnLTVO
         IhJa7H4P9dXFhenGuyT6BeskBEYPX118m6PClAfO9nH3G1sU6FgA9wAHBez/eBf4JQwO
         GZvUPRzIRLh30Lk7X9M1bUnmGAlY/Tw94csCL6mWbEmY6BFUk0mFLyDFVF7xKGpS8LEu
         6EnCvJsHIbLujPM5xhJkBk0j8qkUU9dM3UP7ZnYjKshNhiWy5Ch46WUw9TqvJX+Kx2NC
         vC0A==
X-Gm-Message-State: AOAM533PZvVuQVkciW1+IH7SZu0DpdCn6VAXdGsPPLFVNv81xG9NN3Yy
        a7BxRlTr+l+Eo3QLzlqzSY4=
X-Google-Smtp-Source: ABdhPJzlL1JiEZD9/NVJd61BIBQ9O8ipbUTi0ga/q2ztq+rlcYB8IqFRTM1wMQJLC95R+8qmWCTUFw==
X-Received: by 2002:a63:cb51:: with SMTP id m17mr22311179pgi.337.1605111259504;
        Wed, 11 Nov 2020 08:14:19 -0800 (PST)
Received: from localhost.localdomain ([175.195.128.78])
        by smtp.googlemail.com with ESMTPSA id k5sm2926618pjs.14.2020.11.11.08.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 08:14:18 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH 1/2] btrfs-progs: common: introduce fmt_print_start_object
Date:   Wed, 11 Nov 2020 16:14:05 +0000
Message-Id: <20201111161406.3104-1-realwakka@gmail.com>
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

