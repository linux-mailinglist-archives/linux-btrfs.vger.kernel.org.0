Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7DD3B4F1B
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jun 2021 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhFZPGV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Jun 2021 11:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhFZPGU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Jun 2021 11:06:20 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39621C061574
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Jun 2021 08:03:58 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gd24-20020a17090b0fd8b02901702bcb0d90so3014241pjb.1
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Jun 2021 08:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=laP9fCBkSmOfdhmYsvsg1t3DmvuO87wUoZhSmrsWMm8=;
        b=qNDAy5DcPoAqwonBdkWhQcUSJWhHmGwjgg9RZbK4CKt7W70KzRjpODsIqntQJKpNVA
         hbJPMp5Sq+qoW5qhOGUYWiL1fcBP5aioNSJ1Yfpn07N33bnArXgroSc3/Wtqim5agccD
         8uLUmA2RVahFVL/rRqfJOywpvpAm0aWp3IR8WXbIv31bHN7PuaDrODtlkDb6UcoQMje8
         z3i8DsS6z6ZcQM6NyMEVoVbcZmsD4P+gPKoNjkwVWUt9oTUFl+1dfKxdzC2iQ5qKA0BE
         vezBHNc1hLvakXHhszvFd/e/zGPomldRddxPNm5ARcLUbTF7oEZkL6KvPKm4yZegnXJT
         XvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=laP9fCBkSmOfdhmYsvsg1t3DmvuO87wUoZhSmrsWMm8=;
        b=ST4jXg8JTN7cmVUsi98qEwZiIjyi1CbeSfIf28wnVi1rcOO4XolTTBqrSPiNMuUUGq
         20GfkTw1fVIgmLRb87+7Qs/ksUNFFCgJAm2jN8ddcX1oO85OugMO2FaeGp/gpo94X1Oo
         3bvIGUmOUiDX3sejaj01Vp2OxNlT10okIwWUL+WY1gtLY8Sin1Dc4OiphYFbiYvIS2un
         nhkl+zzIx4pPVKkzau/FMtRUE20StwXcPg0xhKnO40gIbHr7R89jDySzJZEhFfhEruYP
         CLiJuxQQTFrGZIBaL5Jd5tS/UgxC7aBTnniBzsYMsi6+8xQQs1Q5cbRlIZST//mdJHi0
         DeBA==
X-Gm-Message-State: AOAM530/qdRD0D2QOIFMHzD9YwIxQGfZGTSCffSt1QjWqV/fQZSQi7I3
        15MedtoUQtRFhMP3cCLI2cClJUQu0NzjlQ==
X-Google-Smtp-Source: ABdhPJxkudSiD6+yWUBEsZmDk2Lh34YygDqLlrXvemkHZte0MY0pwGxxUpDLmy9GfvY3QcAWm1v4Wg==
X-Received: by 2002:a17:90b:3142:: with SMTP id ip2mr26426684pjb.63.1624719837686;
        Sat, 26 Jun 2021 08:03:57 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id 206sm8956459pfv.108.2021.06.26.08.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 08:03:57 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: zoned: fix memory leak in btrfs_sb_io()
Date:   Sat, 26 Jun 2021 15:03:44 +0000
Message-Id: <20210626150344.25860-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_sb_io(), blk_zone_report is used for getting information about
zones. But it is not freed if code goes in usual path. This patch frees
the variable just after it used.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 kernel-shared/zoned.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 2a6892b3..75eade84 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -543,6 +543,7 @@ size_t btrfs_sb_io(int fd, void *buf, off_t offset, int rw)
 	zones = (struct blk_zone *)(rep + 1);
 
 	ret = sb_log_location(fd, zones, rw, &mapped);
+	free(rep);	
 	/*
 	 * Special case: no superblock found in the zones. This case happens
 	 * when initializing a file-system.
-- 
2.25.1

