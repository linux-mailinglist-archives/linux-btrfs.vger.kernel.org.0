Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1FA788FBC
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 22:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjHYUUM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 16:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjHYUTq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 16:19:46 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA4C171A
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:43 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-649921ec030so7684046d6.1
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692994783; x=1693599583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMcUOKqHe+PHMcuwbh3TXRzBI0wToWNfG4w5HBgGNA8=;
        b=FY9J1VfcD2hQqjz586+XsFXjbuiERJ0YEu7Vbwz3DvEtwarAVU9kVWweImDpEjqPYV
         ztcWRkJN8JOlHK35lN8wwVIfKnlrA2d2HtY2YeADqqESa9qWjcybyzRR/iZYN3yJFEtw
         OY7LBEdvRwKRZYZ8D8u0Ivgqq6xLNOOoeLnHYVdXW7+SQ3ueEQKLnSZryvS/iN07+Cqw
         zkZKrEFNAQLSDiIc0B3eqv+cPU/OAGUG18zTTJ4ME9+GNV9utUxCEXg9B91BbH05UoKR
         x7GLJm2ko/nypinik4NOlLG9jUG3r3N8/7YciBfOCAnI1ybrKRfatSv0RLVq7cNzkilL
         fMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692994783; x=1693599583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMcUOKqHe+PHMcuwbh3TXRzBI0wToWNfG4w5HBgGNA8=;
        b=e3bbk5RTw7y9RWwjH+J8QzizLoqxKurINh8BMUXyKuDZB6toOXzsZo+hR8DJ6QQFWR
         ACBOrYNW/qvRzkWa+XM1bxUiTpGnd/ikeiRE7yL9F6PE900pwqG0kQRBHP7w81Vnz6dT
         WzAKXZBJFCBQGe/NObamWAXvCN/gO0bOAYnn2nZ1s71W057oM6jgB689sGyytd8jHbZV
         BXRnITn8c8StiJYZTl829Zq0fTHRCz73qQziwxWNRMKwO4W2CliD2QibsYhbv3dDVQik
         8AxtjkoHxxfuc6tNqsbCob9onj4fBGoNdX37hnl/5y1WulfTfIAj+etfZLw2bI7ZhZyd
         RAsw==
X-Gm-Message-State: AOJu0Yz/ZMqgsksVG621cswIp7wc9vkb7Zp0paug8h4gxoE+uOokuWTD
        5B1qm7KTTQGrSKIocidJLCq2LZr6USbopXuR1nY=
X-Google-Smtp-Source: AGHT+IHAEgS7BESQd1rZKYO7Ui8xAfSyFD2cVhxl+IDnMQfVVuNw7RSqqRfyGj/7Am8q4RLRHh6f8g==
X-Received: by 2002:a0c:dc12:0:b0:64b:fdf0:48a3 with SMTP id s18-20020a0cdc12000000b0064bfdf048a3mr20744925qvk.10.1692994782775;
        Fri, 25 Aug 2023 13:19:42 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q26-20020a0c8b1a000000b0064733ac9a9dsm781757qva.122.2023.08.25.13.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 13:19:42 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 05/12] btrfs: include asm/unaligned.h in accessors.h
Date:   Fri, 25 Aug 2023 16:19:23 -0400
Message-ID: <d579bc35b31a0be928af6c358057c8aaa814ea79.1692994620.git.josef@toxicpanda.com>
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

We use the unaligned helpers directly in accessors.h, add the include
here.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/accessors.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 8cfc8214109c..f958eccff477 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -4,6 +4,7 @@
 #define BTRFS_ACCESSORS_H
 
 #include <linux/stddef.h>
+#include <asm/unaligned.h>
 
 struct btrfs_map_token {
 	struct extent_buffer *eb;
-- 
2.41.0

