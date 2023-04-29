Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119BB6F265A
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjD2UU1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjD2UUW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:22 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B10E6C
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:19 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-b9963a72fbfso1617069276.3
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799618; x=1685391618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dm8q7SUBUDB21B7eyxwEHX1UIP4GtnLiwtYMGR3+Xfg=;
        b=meNlIk0upwOzdosFvn4XPqLrGFaSADKt+lwGwrnqcJKWb4Rys2LnN5QRj+wBv/ZwqZ
         5gSGke5BTwYdn5G2bFnZR/0Wa0GgtiSCNSrNKw44HDOu48b/T8JOEznhjQXIMJgsz7If
         xI69YiPPoscDtTkGhYV4/MfBSuC9AWhVB0T2nnMSJlBWvDWjmohq7U9KqqeS721oyGyO
         Ul2OBTAd4aZyaNZMuhZCnCA8uCPi0DLzhE51Dr3l+n1Jafgow+8Jbpj/F9RA6kOn7/yz
         H0qYqdhzeg8Luia57A/InTal6xGiCpUSds14X8R2UiR6TRB0WxcWaXcP64MGvgUz2EaJ
         E69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799618; x=1685391618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dm8q7SUBUDB21B7eyxwEHX1UIP4GtnLiwtYMGR3+Xfg=;
        b=l66voi4HWZcQI+ZFrZvCfkNuDw2HBgATHtjjYvLy7b8VKbBhS+NdU1yF45zI/a+hHa
         6RiG0GipKtTnjPJrKuslCNcS2rsvY/p6Gl3wQpyZhPkYrSknbafuJ6YVV3+gpXz30MYN
         Ez1eSPXiMkM8ooii/z5LsnNMYyD039mbs8tM9lePEHvTL06shkQSaSisiEfD3o5GIHcA
         Kzs8V3r6GKIoxOpTJ8F6k4dEmEei+EXvxw1kQSceRqoj5z2325jxN+lmMPij3PQ1ji/4
         92DLiLdFtS4AAhfq3teJMAqNbT6oebKx7yJmf4nXy9N9NAd/Y7AX4uH8uqgZ3jqoKweY
         CerA==
X-Gm-Message-State: AC+VfDxO+LpTqOR3W46K7aJ5Pd77D5EmY0nSQqtqczdD9FYayWngTtw3
        y/d8zJl0R8zmlUkgRs+VDkhzEviA5usdFLEWfoh5EA==
X-Google-Smtp-Source: ACHHUZ78W8cOS+ttg4kB+e9g6v4XfX2b0knS39mVQ42iIg6cSHNzGy5Ztlxel3zOd9PRw6D5+A/zhQ==
X-Received: by 2002:a25:3497:0:b0:b9d:c27c:344a with SMTP id b145-20020a253497000000b00b9dc27c344amr1144415yba.16.1682799618340;
        Sat, 29 Apr 2023 13:20:18 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i3-20020a258b03000000b00b8c08669033sm5807746ybl.40.2023.04.29.13.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/26] btrfs-progs: sync memcpy_extent_buffer from the kernel
Date:   Sat, 29 Apr 2023 16:19:43 -0400
Message-Id: <1d11e9325887ccea1978e6c34868539b373fd252.1682799405.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682799405.git.josef@toxicpanda.com>
References: <cover.1682799405.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We use this in ctree.c in the kernel, so sync this helper into
btrfs-progs to make sync'ing ctree.c easier.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent_io.c | 6 ++++++
 kernel-shared/extent_io.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index e38bb1ed..fbf45e9d 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -630,6 +630,12 @@ void copy_extent_buffer_full(const struct extent_buffer *dst,
 	copy_extent_buffer(dst, src, 0, 0, src->len);
 }
 
+void memcpy_extent_buffer(const struct extent_buffer *dst, unsigned long dst_offset,
+			  unsigned long src_offset, unsigned long len)
+{
+	memcpy((void *)dst->data + dst_offset, dst->data + src_offset, len);
+}
+
 void memmove_extent_buffer(const struct extent_buffer *dst, unsigned long dst_offset,
 			   unsigned long src_offset, unsigned long len)
 {
diff --git a/kernel-shared/extent_io.h b/kernel-shared/extent_io.h
index f573a4e2..544d5710 100644
--- a/kernel-shared/extent_io.h
+++ b/kernel-shared/extent_io.h
@@ -118,6 +118,9 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 			unsigned long len);
 void copy_extent_buffer_full(const struct extent_buffer *dst,
 			     const struct extent_buffer *src);
+void memcpy_extent_buffer(const struct extent_buffer *dst,
+			  unsigned long dst_offset, unsigned long src_offset,
+			  unsigned long len);
 void memmove_extent_buffer(const struct extent_buffer *dst,
 			   const unsigned long dst_offset,
 			   unsigned long src_offset, unsigned long len);
-- 
2.40.0

