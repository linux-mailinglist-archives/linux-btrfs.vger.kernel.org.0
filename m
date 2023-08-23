Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A9A7859CD
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 15:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbjHWNv7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 09:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbjHWNv5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 09:51:57 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C39CEC
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 06:51:54 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d678b44d1f3so7609562276.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 06:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692798713; x=1693403513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXhfugQ15ZQIBw/K62Nj9pa/gM6xIJGR9HpfEvZp4TU=;
        b=W6ofK/RK60tkE5I29jonFZK1oQ11FYWBdtN58Xz0G9r06sUuPa7QGiW4jzQ85XZMeZ
         d17eJ00kQW9aHKDWAimmGAbwxx3m2imU+6SfEPlawQ1yzGdSnXQMQniZzBBAvq6ta65j
         2hmhTofZMTdGuLpU/dNny93jrW0FK/PCm04fwApy36jfecqLVz97yp6+PpiYkwNyV+lR
         oSm2srSVd7Du0fp4M2ZiQ97/qCvfbnLVns2bG9sgV9IEIhMWkrJT4L71Hb+iw1Y/Me1c
         NHDGekH/33tSeZhfjffanxOiCQcH3HAUVcF5rjIcBgdyWMFtc+GqmgnQauDFDFH1/5jZ
         qaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692798713; x=1693403513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXhfugQ15ZQIBw/K62Nj9pa/gM6xIJGR9HpfEvZp4TU=;
        b=Hh8C5A3m4Ep8Z6pdj1xBQhiJvqe5skxH9m5O7sxs66sUd090OX8pwf79OU39u8c70R
         oec92mLp2/OWIq/Su6Kesc9b22dHaerAtoNUFa+aS1hk7q5zFzl4yMY+OhMP7hcBpX3I
         d9a/rPhir3yi7R+KP4IxftJIwQr8zuIkJGdrBvQ99vLN9CFRCAmMJnm/s9Y0d03f5K/E
         BcB3UpRvDDixo/nZGtPCFnzDct8aOyENFJx4sAkszG3H0nP1imxEckA67RfZX7kD1u2D
         /onQUxEx7YMVoKhIHOIdgWAXI0WXzy8AdBG7Zuf2yYPw5R4GH+2j0sZE/3QAuQEU2VyZ
         jvNw==
X-Gm-Message-State: AOJu0Yx5ArETATl21wjYfV1geIQzNtN+u/ap4Tl9ZoPjiyz0WwsQpqqh
        1BR/TJe+3oR/W4zv6yPc8zQrPfyY4eYt/JmWf4E=
X-Google-Smtp-Source: AGHT+IG01GHTeCnuxuj+b1h3msV0qIfTuv5Ipff6OYebo2FUvXPZhgRuV/pucDEx9jlPbKIJc1g4LQ==
X-Received: by 2002:a25:2d02:0:b0:d07:4e50:392c with SMTP id t2-20020a252d02000000b00d074e50392cmr12580996ybt.13.1692798713356;
        Wed, 23 Aug 2023 06:51:53 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w7-20020a25ac07000000b00d77928cdcf6sm693011ybi.15.2023.08.23.06.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:51:53 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/11] btrfs: include linux/iomap.h in file.c
Date:   Wed, 23 Aug 2023 09:51:33 -0400
Message-ID: <1dc135f94f5432b2c2264eda691787a3300ebea6.1692798556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692798556.git.josef@toxicpanda.com>
References: <cover.1692798556.git.josef@toxicpanda.com>
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

We use the iomap code in file.c, include it so we have our dependencies.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 6edad7b9a5d3..ee9621e622d0 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -17,6 +17,7 @@
 #include <linux/uio.h>
 #include <linux/iversion.h>
 #include <linux/fsverity.h>
+#include <linux/iomap.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
-- 
2.41.0

