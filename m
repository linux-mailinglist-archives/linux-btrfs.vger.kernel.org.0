Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD490781773
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Aug 2023 07:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244168AbjHSFEz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Aug 2023 01:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244230AbjHSFEi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Aug 2023 01:04:38 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2FE4223;
        Fri, 18 Aug 2023 22:04:35 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-640c5df2e6eso9300026d6.1;
        Fri, 18 Aug 2023 22:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692421474; x=1693026274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFU5t14qHAIqbXbFpLDwB1OrEOWYkYs9ZG/8etqQ10Y=;
        b=ci7pOmQgJt/xH3VgAZNghXyfpHFZi9dfFmGwkA87fzFzC2I0ruu5yF4nNwQ36ndNxe
         p06+EEwvzQ/W2SsYKQf+1hytZy/hFgQryVOWPa8EknLPqjAHYFB5pqQk8tty1dc2UbjO
         4m+Mr1yTJM65SBZZAhqqG1RLpUmAnEeMuUlplfmQrSFqGhsBVQO1sSqRQY/RF9zX07MW
         Szqb3Q++5yMx6aEnp1LgqsayHL4Dg4vuYcs3WqnKY4zOcsmjFR7OGLDxAuObQbPQHdz4
         ADAnLd/oE9j4iI/nI9FSTqE9QXmc4HojZOIU+Nn8HpRzPfhg47Ba0dFP3kPES6y+SVt0
         qGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692421474; x=1693026274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFU5t14qHAIqbXbFpLDwB1OrEOWYkYs9ZG/8etqQ10Y=;
        b=cQDO1tNz2wOCQDLMHdGyimgYGdCWPJQQbBo0YmBvzIDN5EvVCCc1WnJsEN0nOSEd7B
         tBh2oYXidsMoe3yN9Z5wNETo4wN0nqnyN2VA8Dwk+VE+oIQ+rBI8snNK3NX6JDB70tti
         ZvSQEQGBjIwJ95eYAjCCig5hMMMNJ9+8Dj/tdrcuCUdQXTdgjjXUnBSiBySbN+H9wMc4
         bTsy46ziZD6sC86k/CviDvE2FbQAmekI8MOul6MD2sJ5D4/vJVbjfmF7yXOBOA6Ezbky
         cS+Wq3r8tZDDVNwc53kj3xsMkFDxXp57VLVWFq32DXlhL9Ed1ZZSypjyU+Zv0VvceSE3
         TwwA==
X-Gm-Message-State: AOJu0YwXvF/XRVCjUpYBjL7ZMbQwl2RB4dGvw2aHZiaXRZxlgylmaRHi
        B7Q5mMLyAwH0DVdTbcURhDI=
X-Google-Smtp-Source: AGHT+IFPUqLylzOvr85tlMHj/Hp3t9N8mBm2pfyCajAdAnxZ7GtILHU+9ZMRO5wjSVaKqybRq5RDgA==
X-Received: by 2002:a0c:8e83:0:b0:647:23b8:dac2 with SMTP id x3-20020a0c8e83000000b0064723b8dac2mr1275612qvb.58.1692421474359;
        Fri, 18 Aug 2023 22:04:34 -0700 (PDT)
Received: from Slackware.localdomain ([154.16.192.72])
        by smtp.gmail.com with ESMTPSA id d28-20020a0cb2dc000000b0063d0b792469sm1213356qvf.136.2023.08.18.22.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 22:04:34 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, corbet@lwn.net,
        linux-btrfs@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 2/3] btrfs: Kconfig: Replace obsolete wiki link
Date:   Sat, 19 Aug 2023 10:23:04 +0530
Message-ID: <1a3dafec8a8b33be6e56f0ad16f55c0639ec88b8.1692420752.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692420752.git.unixbhaskar@gmail.com>
References: <cover.1692420752.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Replace the obsolete wiki link to maintained link.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/btrfs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index 66fa9ab2c046..868d80464858 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -31,7 +31,7 @@ config BTRFS_FS
 	  continue to be mountable and usable by newer kernels.

 	  For more information, please see the web pages at
-	  http://btrfs.wiki.kernel.org.
+	  https://btrfs.readthedocs.io

 	  To compile this file system support as a module, choose M here. The
 	  module will be called btrfs.
--
2.41.0

