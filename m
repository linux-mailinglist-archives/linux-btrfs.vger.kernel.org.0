Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6C8629D95
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 16:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiKOPce (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 10:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiKOPcC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 10:32:02 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455312E9FB
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:32:00 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id ml12so10041143qvb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MGuJw19PKTZHKSTZJ2ilipPPQLsLJwsO+sn5FxVevMY=;
        b=wHgRq/4M87VVJyENvNI//uAloqnjkQin7T90BLojdZWlJhKlzLzZQFsINEpH/4Tci8
         gcX1MRapuIxR79y2yvgOZKpTg2weqoqAkmhLAXfi1/zRTkmGQqoCR4uU6XZMcR7Ld9m6
         prxcv4+y/nQn+Abz5504PK2rHWtWz/HsHXb3W4E/0Uo59HvdGbTnN5wgvlWwem6IBGMX
         sTUcabe26AhEDlpPk/Il2uGbQ9pLVcpd2uiS5lrAyUgXfMZpGGO8RM4RoPl0Q2g/zJCB
         tYMkii4rU2Cng1jmneZWdRaH4sYCEmWZpf0gTKaZ+oi7AnhpdwhENzmZ9jOnCSRuc0f6
         Bn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGuJw19PKTZHKSTZJ2ilipPPQLsLJwsO+sn5FxVevMY=;
        b=Z50788r0Xw11xi9E81bLPJzNay7rVcWB0sdGlkM7vsQQBQwvTo614H7/4rDwTAwf/R
         mYGrHUkV2Q+CS/fawwWY8Y7OTZb2LFcuJd2tXmo7Yq1xSdgaT30/W59wDMgcP8toUSq4
         W7+7CftlOKc4UhJye8X2azR9gkTfG6E5M8QqHfGr6ZYebzswMERu3YwMbfSUm4qq/Ybf
         ordSYOPzxvN4mefOFpGaqOji9x/qeQb3CxyTqjhH2xTacJ4VZPfjdYex7a5nMZQXmbHR
         OQbMAiATh2S6x7MA7DQxuCB69lJajCxMYLlb7CWe3FcZNj+INlFRrlc7u2qRT1kE1zAN
         LyCg==
X-Gm-Message-State: ANoB5pktcLhSMXLbb68Wo8TaEsYTcdQVGja+F6VARsnHNRmf2RMF/Qzp
        J6X6WNNfzXTyg2rM30Er5r2miWJ4VFPOdA==
X-Google-Smtp-Source: AA0mqf6rHNlfcD8C3Ze0CqyI1uy6pIQLXj8WZ4xF3PBDtF6XIOIBi0P1pgQcuDEEYQf0w8hcgYVcJQ==
X-Received: by 2002:a0c:c785:0:b0:4bb:63be:9994 with SMTP id k5-20020a0cc785000000b004bb63be9994mr16749288qvj.111.1668526319280;
        Tue, 15 Nov 2022 07:31:59 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id x81-20020a376354000000b006cfc9846594sm8132290qkb.93.2022.11.15.07.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:31:58 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 17/18] btrfs-progs: make write_extent_buffer take a const eb
Date:   Tue, 15 Nov 2022 10:31:26 -0500
Message-Id: <c5fdbccc1df24a08281ca8405f92c809d8837bd2.1668526161.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668526161.git.josef@toxicpanda.com>
References: <cover.1668526161.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is what we do in the kernel, and while we're syncing individual
files we're going to have state where some callers are using a const,
but progs isn't.  So adjust write_extent_buffer to take a const eb in
order to make this less painful.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent_io.c | 4 ++--
 kernel-shared/extent_io.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index dfc42a90..30dfb76d 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -1073,10 +1073,10 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dst,
 	memcpy(dst, eb->data + start, len);
 }
 
-void write_extent_buffer(struct extent_buffer *eb, const void *src,
+void write_extent_buffer(const struct extent_buffer *eb, const void *src,
 			 unsigned long start, unsigned long len)
 {
-	memcpy(eb->data + start, src, len);
+	memcpy((void *)eb->data + start, src, len);
 }
 
 void copy_extent_buffer(struct extent_buffer *dst, struct extent_buffer *src,
diff --git a/kernel-shared/extent_io.h b/kernel-shared/extent_io.h
index ccdf768c..f4697877 100644
--- a/kernel-shared/extent_io.h
+++ b/kernel-shared/extent_io.h
@@ -144,7 +144,7 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 			 unsigned long start, unsigned long len);
 void read_extent_buffer(const struct extent_buffer *eb, void *dst,
 			unsigned long start, unsigned long len);
-void write_extent_buffer(struct extent_buffer *eb, const void *src,
+void write_extent_buffer(const struct extent_buffer *eb, const void *src,
 			 unsigned long start, unsigned long len);
 void copy_extent_buffer(struct extent_buffer *dst, struct extent_buffer *src,
 			unsigned long dst_offset, unsigned long src_offset,
-- 
2.26.3

