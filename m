Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB0B785A9F
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbjHWOdc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236479AbjHWOda (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:30 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B865410CB
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:23 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58d31f142eeso60772747b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801203; x=1693406003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJeLDb7XgjYYur0llXGicwfcaQ7es0DBAvgnquGsW18=;
        b=HPvJOzW3NBbcK1xphO9jcM5CXs3/Rd7AipUDepHNbwG1o7UCGyIQesm2cC+hop/5dN
         7kLK6XDEMQ6z+4gr4lJDsava2RSg16MwN/4zWq8k6X3u+P8QuhKqB7XpoMeEQQwdSJHB
         BmHHpPtYv5Ha8Sd1wOk88DdDrAUXun3C9Fg6ig6CuObJtiGa8b74ezSdEHNx/9AYB2+H
         MPyA0zJd5E+RyzNbMLwm1E+lHmH+H8PV4y3B9NjU3qku1CIKsKuJ3vdn3tms2kwPaz+0
         roO3TWQXe2KFq/2Nnf3H98tQ05wPEGXsQ6cfQmGU21gd7NeEbmfAr+X4wjgg3Y9inXGU
         Hyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801203; x=1693406003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJeLDb7XgjYYur0llXGicwfcaQ7es0DBAvgnquGsW18=;
        b=UknlIKUesg2Cq9gJ55a0t6umt/gn8kjJnOha9E7a2DMnaNjjaXS0qkkwhWLL9wX/J0
         UpbXO6tCkmAb6E+6KF83vBQv4iQb15ppY1098ZuBaoVPSNN/cLfV90NWG0j+ZicH941g
         MPD7DcpUmtM/cpRpVmh4Js34KaxVhyQTYG6sZ6ZtKCeywG69GCQ9xK4gg9Qn+/cXRUHu
         AzErYUOZSctokb8xl9t6sBLLTPyFFCxQzy438FYTpnneTOlUxnvfGfCXNu1cFHmWIZHM
         LPdmC103oZ7tZpf2O73hVIa4+ru9gyla348srg1N7c2uksCk0G5xVGJzODiG9FY6p6m7
         1qMA==
X-Gm-Message-State: AOJu0YzqZoIA0i2LDCJvPP5JvT3I1JWvu5rROxMs/71ccJq4D+BYdjzH
        8+EqpH2LBM8DYwXu7lc7Z6uUgYY3ay0FpBYj0i0=
X-Google-Smtp-Source: AGHT+IENL1ZoKWrMFCz+rR+xm1a9slzI2Zqy0iNWJmOmEJ+nVcsaWZJIzor3GIomyCEjf8qDtgAC8Q==
X-Received: by 2002:a0d:c781:0:b0:58a:d281:a275 with SMTP id j123-20020a0dc781000000b0058ad281a275mr14306094ywd.21.1692801202910;
        Wed, 23 Aug 2023 07:33:22 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id a13-20020a81bb4d000000b005732b228a83sm3293501ywl.140.2023.08.23.07.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/38] btrfs-progs: sync memcpy_extent_buffer from the kernel
Date:   Wed, 23 Aug 2023 10:32:38 -0400
Message-ID: <8e6df00ffbccac1dd1b23162acbaa9ed9e91e165.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 503b63e2..a085c2e6 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -641,6 +641,12 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 	memcpy((void *)dst->data + dst_offset, src->data + src_offset, len);
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
index 243ffe74..59be49ae 100644
--- a/kernel-shared/extent_io.h
+++ b/kernel-shared/extent_io.h
@@ -121,6 +121,9 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 			const struct extent_buffer *src,
 			unsigned long dst_offset, unsigned long src_offset,
 			unsigned long len);
+void memcpy_extent_buffer(const struct extent_buffer *dst,
+			  unsigned long dst_offset, unsigned long src_offset,
+			  unsigned long len);
 void memmove_extent_buffer(const struct extent_buffer *dst,
 			   const unsigned long dst_offset,
 			   unsigned long src_offset, unsigned long len);
-- 
2.41.0

