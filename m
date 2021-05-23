Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2549B38D913
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 May 2021 07:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbhEWFKe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 May 2021 01:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhEWFKe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 May 2021 01:10:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D603C061574;
        Sat, 22 May 2021 22:09:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q6so13020559pjj.2;
        Sat, 22 May 2021 22:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HjoyRwfR4HzDsa3R5xoCql22XqVJsKcofCTHgClE8hs=;
        b=o7E7cQM/jkN6zCX3JMHD2K5lzCmYnyFKBEogdtXV7OLKSateUqchb7IaHVqUM0XoxB
         gDJUIp9Xc+bvB9WxP3OPrvGK5GXOTas3FL+QgHFIHmfsfzJz6314os2OE1KL4vvPcKDi
         EAywv5g1cJg7aT3AjI651eTK/NRZwSzjUkO49gCKL/lBtoiK/wNszKtUS5L1ivsJQabL
         EuhOoWZ/sDvW7z62Q4tZuiQsZ6/HJ/F/0mJXDPk0GlI1LEl3BbL6Nd4cQ9zgk1QbjD3J
         GNXTKjaq60pSCSaV/YryRPm5y3eRiQ4HcdVZpxOUlUxPZosvLOhGKKKwRWyR65RIkgLy
         Rsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HjoyRwfR4HzDsa3R5xoCql22XqVJsKcofCTHgClE8hs=;
        b=opwUizn5gKhoiJAD9/ZoFnnFdDAJwrzMne3UDWBDKIgD+95QXZwXoJyZykzd6jntn7
         FCigiC8+UMmyh0Xa8ubdYCHmEBihJpXcSIFEkoMWSZtiSCKQ6BVvmev54Zl+nxMNMmru
         i3BUeL7EuL+sYj+Z3w1SWvE9lhVxCLda5FF+XXhsrejjcZTqcQRsWGetiEmJ6HrPhTdg
         a4OFp/K59DgPr6MDTeA+uLYA75E5iEO0TQi4QWtXfZz18vbXEP3eAXyC+nS32lKgLz5q
         fBG6Ozo4oqkj82FehWBcspvvXJrx5dpQRQ0gGcDv7yuh2YJNO5k8g8Z28drpy6WjMipt
         bLEA==
X-Gm-Message-State: AOAM532B7nMy1FkKfr+fyWrSSXOE7tKCjOp3ziLdnZ5+9s+i7KKqPDEb
        HcQxStdmJOozHPGVyjHdEZxl6IiZgi4MIlMS
X-Google-Smtp-Source: ABdhPJyg9YrIWPKgJi31YNmpBwoWT77HlcnsQhjyKr1vlppZCNfAG+/GCFgtqXwGO3KGouQMfQTeuQ==
X-Received: by 2002:a17:902:8c91:b029:ef:aa9a:af35 with SMTP id t17-20020a1709028c91b02900efaa9aaf35mr19688222plo.24.1621746546810;
        Sat, 22 May 2021 22:09:06 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id t19sm7626229pfq.116.2021.05.22.22.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 22:09:06 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs/012: check free size of scratch device before copying files
Date:   Sun, 23 May 2021 05:08:59 +0000
Message-Id: <20210523050859.1329427-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This test failed when scratch device don't have enough space for copying
files. This patch gets size of files by du command and checks if there
is enough space in the device.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 tests/btrfs/012 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/btrfs/012 b/tests/btrfs/012
index fd43da53..6979d862 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -42,6 +42,8 @@ _require_command "$BTRFS_CONVERT_PROG" btrfs-convert
 _require_command "$MKFS_EXT4_PROG" mkfs.ext4
 _require_command "$E2FSCK_PROG" e2fsck
 
+_require_fs_space $SCRATCH_MNT $(du -s /lib/modules/`uname -r` | awk '{print $1}')
+
 rm -f $seqres.full
 
 BLOCK_SIZE=`_get_block_size $TEST_DIR`
-- 
2.25.1

