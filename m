Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248F9788FBD
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 22:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjHYUUP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 16:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjHYUTw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 16:19:52 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC80171A
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:51 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-649921ec030so7684386d6.1
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692994790; x=1693599590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5L6DMLzwEjKWUeKNgbL85ptU94gBY2Q/w/oQ7tj62Q=;
        b=hM53uVeIcehOpK1q1gHNVFJNSL8BZgrpHCNZG9fmCE1XK04JH/7y+TigLcm48G74Qr
         EV+Q8wbzCt7mwYFVotAnDcv2RQVQbrvbv3TvuFS4P5t1cqVy0cz7MdN8LegRJFDnXlVx
         5wSLrXGxDhGb9QYWvqoOqbs21kk0Yu5PWBpkoR4W9L+Ng1Y6R68MfE9uSixe/YzzlIpD
         d6vFh+n/lnSFPlvyiUK/FivzyDT44eCdV7PA1duSbjiFmMkEmWKMEBWHaZKoc3373BVT
         E6qLWT+gmTtUnQnoyC8e259/54gi2tP75lAm97WG2G3inz0oxxon21TY8ojn5ccb3UwW
         4LAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692994790; x=1693599590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5L6DMLzwEjKWUeKNgbL85ptU94gBY2Q/w/oQ7tj62Q=;
        b=Xr/IGmvkYSVf3zpHZfNAb4gKqluKS3Ot/oBqzFJHVswbp1Rfhgmf2z3T91Genkdb8+
         n32Rc0fiavBU+sevQRN2IzBr+JpeIxGwY1ntiDmeD16X8jv1YCki9ZhTtzFkPs72DDUW
         5d9SWomowj80eTwKgRZ7i+PuHh+XEZqdFOnSAhDmkKez3tM5yKjmNpVo2i69SNoXWCVu
         Yejrtwh2m+BsIkBq5m1iR4GZ7xvufB2gQqsjysVqDCC4TFC2Ep0HARkWC1WVU/JhpLtu
         LiOwQTTdXxpnT8jLkkA3CKaMDemT3D4Npb3XOJDkm8T6cYq9/qz0CyEqPLYDuwlO0IXQ
         g2UA==
X-Gm-Message-State: AOJu0YxkL5mUgTrp81Nf7AUiYxOR6ekw2bfGuKnum27dPyHUrDy4umEF
        nLwb7yJjOR8UQZ4oyu18mCla6sxbat+/MLek7dk=
X-Google-Smtp-Source: AGHT+IG/RkGLzNa2hIkVvJVhEa6vAtCGH7/pFjya62he4GWQ1MB4dRWAxwPk/AWxidIPjxMc+rPRCw==
X-Received: by 2002:a0c:f18e:0:b0:63d:d83:8808 with SMTP id m14-20020a0cf18e000000b0063d0d838808mr19840303qvl.63.1692994790126;
        Fri, 25 Aug 2023 13:19:50 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id b14-20020a05620a126e00b00767d4a3f4d9sm743802qkl.29.2023.08.25.13.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 13:19:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 11/12] btrfs: include linux/security.h in super.c
Date:   Fri, 25 Aug 2023 16:19:29 -0400
Message-ID: <35931e108a9ca6c610a62ed89b4befda4a0c96ee.1692994620.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692994620.git.josef@toxicpanda.com>
References: <cover.1692994620.git.josef@toxicpanda.com>
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

We use some of the security related code in here, include it in super.c
so we can remove the include from ctree.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index cffdd6f7f8e8..0c215ca05c8a 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -26,6 +26,7 @@
 #include <linux/ratelimit.h>
 #include <linux/crc32c.h>
 #include <linux/btrfs.h>
+#include <linux/security.h>
 #include "messages.h"
 #include "delayed-inode.h"
 #include "ctree.h"
-- 
2.41.0

