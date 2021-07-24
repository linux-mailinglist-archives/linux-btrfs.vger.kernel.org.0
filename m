Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6D13D4619
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 09:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbhGXHGV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 03:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbhGXHGU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 03:06:20 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5B7C061575
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jul 2021 00:46:53 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l19so5547335pjz.0
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jul 2021 00:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6wmLOxXhm8/N6ptL/tX4/M5gOX6cvBKrkFI8w1Rs8/M=;
        b=HQT1BDiy0tY6/tP/SrAdOBaJA3VIdhYoTKqWFJoEMt++nZvtPkbu09WLfTIKX3+3OE
         rAXYLREEXoAADGQqRL9CVXnUXjHZrX+vFxW92305+XGBZtqHKOYhOEQ6iU/6kMA2uEM0
         qBcTOGWTRcbA81yMY5vivNbjbMHpcGf9sRH3p4Jwd5wz0xc0YHj25rcqcyEYf/knkKa+
         TmrATq8CgNDS1YRkBHCH3BCaa0lbBE6U4gecWxnb/YFJJ0FUNUwY9FBSwXsdy0fM8MV4
         iJKspqq7nO2IvBA7sxEN/b9mepfRwECvUYoebHgYfVTHstOVU1qvoPH6HZYkSP1NgmYW
         4kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6wmLOxXhm8/N6ptL/tX4/M5gOX6cvBKrkFI8w1Rs8/M=;
        b=mBn6EOSH8dhmI3DIx85JtXCZlgvMLpDm/6lhGWis2ftHa5foXCuD1Buw6Y5CVOoxbq
         JapNqpB4kECcSDk5dn8+pwv/ukOHGKSZyCKu50IRZ4AbBb8oV2FBRDAqkoGaYxGpMHhz
         VMkncjuTtwPB2yr2somBF/PbVQsnKQt78/gXKd4TKd9iDiSz0B1HdxQw2NAGqiCBUiPC
         yfCTpqNPO2KKem8lSRVDmuRgjYs5BEo3jFTXD4yMFj80DZP5iArXISvZL8s/C87l+dsU
         5xPbeWU4VTeXpj09JIrxU77T93sSLm6d405WgtHpaFjMVWB0yeZlb3ck8WOue1RLEUoj
         O6cw==
X-Gm-Message-State: AOAM533NORp1nz38X2EHPlBJfkYgdneL8WUReJ3k945QHPgOkCpYTqoe
        6NxyCUKO5DfCJMzICEZ1hC6B9jHWPxM=
X-Google-Smtp-Source: ABdhPJwW863ZI9tKfmsxIpN406Hm2Bzv0niFE2DeoGwhBz5D+ouGz5NTx2XicUB5SKF4X12bQ/AfFA==
X-Received: by 2002:a17:90a:d181:: with SMTP id fu1mr17518807pjb.157.1627112811308;
        Sat, 24 Jul 2021 00:46:51 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id e16sm24878030pja.14.2021.07.24.00.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 00:46:50 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: cmds: Fix build for using NAME_MAX
Date:   Sat, 24 Jul 2021 07:46:42 +0000
Message-Id: <20210724074642.68771-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is some code that using NAME_MAX but it doesn't include header
that is defined. This patch adds a line that includes linux/limits.h
which defines NAME_MAX.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 cmds/filesystem-usage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 50d8995e..2a76e29c 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -24,6 +24,7 @@
 #include <stdarg.h>
 #include <getopt.h>
 #include <fcntl.h>
+#include <linux/limits.h>
 
 #include "common/utils.h"
 #include "kerncompat.h"
-- 
2.25.1

