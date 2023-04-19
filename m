Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D106E8331
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjDSVOI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjDSVOF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:14:05 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33064C1A
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:14:04 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id oo30so967263qvb.12
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681938843; x=1684530843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SD7EFyz1yLBLPVn7LfRqego19EUivGa1u7H8Jm5a5zk=;
        b=1vzg6y6KPAe92vfL76UUADSFcIjsGewQdNK9jAQfprZ0GfcxZSszFzRoX3/ejCszn/
         WGKnhRg7X9lELjCQYnL8pGNJecenITEzLmNHcDOQ5HST476DlP/ixD+SoGZwDH2gXg7J
         0DcfoffnYDgWVctkvLTbgmk5co1yPIcyxue6nJvDSR2haxkW5yY8LZaFOsyPzGn5V6jo
         ChMIa+hW5kSNhlgyyhkQY1pvC70ebRyqJeGWoxvbkiYW6gbySQRn9R1vePZiQhhjL1oo
         t1fP2yklTVAL6w21VWOP0Kw4mnBBQf1AfleQw+8trpd80xyzwKETaPsbfGbquN5vHpSN
         dDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681938843; x=1684530843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SD7EFyz1yLBLPVn7LfRqego19EUivGa1u7H8Jm5a5zk=;
        b=cfMKz5gTaelwZ6geG7czr5aUYCRGVd1Icyr5pRRzJlluPoKbBT49zPHg8AtUSfIwlO
         ScFQqZ0QMuKLWuw6a+/lGjLJabXlBC6cNx3FcZHyA9dN4zLMXS21kGkDSxHY71f5y7on
         hwrIY5yUnJBjaKv6MtUVJJ6x65GaTT01dN5ah5x4MEf66n1NtyS0AvE8Zm4V0NXfShiJ
         FsgWVzRWGZGqDdXb1M9A20vTZq+F+tTCMWgNsMMj8IH5Y5l41gdI4un3A+xi62yRsVCw
         B5idR5bbULHXC6n00eN7wMlL52c9U2qMEbE5qUkEZl+Nxo6kSNvYUKLpiyo8aJxeFDGT
         tzuQ==
X-Gm-Message-State: AAQBX9eYNqT3vNvKgyfV4Lb9f4dtp+M8Nsy7uvEzYIpagIsQeYKvoRcF
        FWCIy44ocKj1rm9KHpAC7cimK9Y4gPEJU8ob94HNDg==
X-Google-Smtp-Source: AKy350ba4xzRhXf9cDUB9YofuwS6vDrhhfqoUpY/YF/4hDX/DembK3qDTcWYXYD8NZzpmXLJnskEjg==
X-Received: by 2002:a05:6214:2305:b0:5f1:6a35:60be with SMTP id gc5-20020a056214230500b005f16a3560bemr7053456qvb.23.1681938843630;
        Wed, 19 Apr 2023 14:14:03 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id h1-20020a05620a21c100b0074bcf3ac7casm2046904qka.44.2023.04.19.14.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:14:03 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/11] btrfs-progs: re-add __init to include/kerncompat.h
Date:   Wed, 19 Apr 2023 17:13:45 -0400
Message-Id: <5a4ffce3fba84f2989eed75fe6ef7a96d0bbf0eb.1681938648.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681938648.git.josef@toxicpanda.com>
References: <cover.1681938648.git.josef@toxicpanda.com>
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

Now that we're properly separated with libbtrfs/kerncompat.h and
include/kerncompat.h, go ahead and add the __init definition back so we
can have it available for the kernel synced files.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/kerncompat.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/kerncompat.h b/include/kerncompat.h
index 4dce65c0..62b6a357 100644
--- a/include/kerncompat.h
+++ b/include/kerncompat.h
@@ -578,11 +578,7 @@ struct work_struct {
 typedef struct wait_queue_head_s {
 } wait_queue_head_t;
 
-/*
- * __init cannot be defined in kerncompat.h as it's still part of libbtrfs and
- * the macro name is too generic and can break build.
 #define __init
-*/
 #define __cold
 
 #endif
-- 
2.39.1

