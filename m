Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22AA58FF3C
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Aug 2022 17:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbiHKPXC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Aug 2022 11:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiHKPXB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Aug 2022 11:23:01 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F97F50704
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Aug 2022 08:23:01 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id q19so16762339pfg.8
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Aug 2022 08:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=z1bsg9aEOJ+QWxwzxBArZXYXdQxYjm8i6VHUQz8kMy8=;
        b=knPm8ZxGppc/jNLjIOsDRGgD4mtcAWsX1olI+AYxbmxrddSZuWrvkIN9l8iS2o70KL
         HagbNuGdDeR0UwsA+KJQLS6I+G3rm3BP8fFWpE1A4vbZWJJ6xXlg+YYqUQVPH6AKnQ9+
         noNn5KTb3lw4xZGxb3KCFs01OiF1qxCnUvGXKo6ikwHcearSAaeVD4wHvifrK1WUQvOf
         G3QVLBhl2MUqeQD2jrDIwAxmSWBoTAQ1onFd0Ld9l2iCe9wB1/G0ff3dIfzwN9T61XWQ
         sBEGJQ6bESawtnjDkGzGmWJm3uFdAm7XtfpUogw0cnPVZzIJaEkFkqSSsD4E55RierdR
         qp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=z1bsg9aEOJ+QWxwzxBArZXYXdQxYjm8i6VHUQz8kMy8=;
        b=Z8mjggkbEE42ARxvxqfbzF1YJleH0Nm8gkExL0sNQwTp9YFCgI5SBed5RHe01eaNrf
         8YJTQtxtIY6P+YLbdUYWN7QWpfF8u2U3u0Wdwxo7OfCKtx8zsW3sJVoBJ015a8Zjaa4c
         cvu3smTuTRend3GzI7KedoqW15Qv3DU5utAsGYDSp+yFQaEj/M4LtK+0JzYPTHY4//Yv
         67ofsG+QxYX9XgrJEKNh1C86dWBW0Vsh6TTDIxv70lLW16xLaoGDknlTpYICaOLhK5T9
         LVHmmk22v2FkhYYElZZP5eCAzPuXQsqVNJNF7yvmEIBir2jJbjnEEJzLnLFkdZwqV0IC
         0B0w==
X-Gm-Message-State: ACgBeo2IaPi5jiHnrjjyee98GfpwRCdLwC/5jEtExrA03O8xsh5mC2lB
        PeLBaXJSlLQcHsSr9fTr9KaXb+sPYMY=
X-Google-Smtp-Source: AA6agR6Q2Tq9yN0MQYenJzIE9l+Kr4MEVZIj0N5BJB3j6K/L1cJmH+99xt+JLdsae4gk75SuOHS2Wg==
X-Received: by 2002:a65:49c8:0:b0:415:e89d:ea1a with SMTP id t8-20020a6549c8000000b00415e89dea1amr27149046pgs.266.1660231379627;
        Thu, 11 Aug 2022 08:22:59 -0700 (PDT)
Received: from realwakka-vm.. ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id gn19-20020a17090ac79300b001f303d149casm3774354pjb.50.2022.08.11.08.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 08:22:58 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: fi resize: fix return value check_resize_args()
Date:   Thu, 11 Aug 2022 15:22:39 +0000
Message-Id: <20220811152239.2845-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

check_resize_args() function checks user argument amount and should
returns it's validity. But now the code returns only zero. This patch
make it correct to return ret.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 cmds/filesystem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 7cd08fcd..9eff5680 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -1203,7 +1203,7 @@ static int check_resize_args(const char *amount, const char *path) {
 
 out:
 	free(di_args);
-	return 0;
+	return ret;
 }
 
 static int cmd_filesystem_resize(const struct cmd_struct *cmd,
-- 
2.34.1

