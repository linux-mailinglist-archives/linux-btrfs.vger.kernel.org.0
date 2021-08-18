Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8F93F0D63
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 23:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbhHRVeQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 17:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbhHRVeH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 17:34:07 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84357C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 14:33:32 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id b1so2842479qtx.0
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 14:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=870A7LaYoWVRor/GmgXV2Hmi76nvkbP/D0ttEoGq4Nw=;
        b=fcE3VP+r9zptF96dCQW1XoLkwT29c1UtyrR2OBc9UPQ4HBCgbwjXtDZ1ZN8/RaPCo7
         mKtO/80UDdEQQySYuNeTC7GVrMdqljNPPTHYm2d8jfmMDzHGPli31ywJ6JCzvO3PkBtm
         ZAWSIUZKE6jxL7EZNkPVjnC2ElKNZQyI6/pnkEp7aZd5RGKoaVWoiC/7Ic6CBvo8Yjtb
         pSoXTrhaOVo5UKncM+rpAe8oXIgnp+GEeqDM+pqHplyj9j59+oE3zqCpqPiQY7vuyo+s
         JwcJZdWz4R38XzYmkO6IoJHri7MbjdFu1kTfSlXHd1LoTdLXq6kL4cXsUStRFjsNV+R6
         AeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=870A7LaYoWVRor/GmgXV2Hmi76nvkbP/D0ttEoGq4Nw=;
        b=Sw09BjY6hsBTmM+3NLc5VDohxUgXHcADNVvRM27fWCZQt/pbNY7IloVeQMYy29SyaH
         gaAGp/FSarRk8bex1F3X68EyR1Aq75WTaSsqBrdyPddHVpUqqkoWjR4PTRBT/BXB4b9l
         9eeFd5csTq4/4+qmlmM8AcAcAPGdWO5l05RWV6XwdqkcZpKspnWzAtQe0GzxwKMsnclx
         oIQQGKISqSQFr266OXGnCP51GI0hhuLu5hw+DOHMRb/4f64PmZ+9R1TBdwILKGnhSK+x
         NKCwsednUKWYKU6l6nJlj3zf8QEOrWZb6XFQpSX+Y3A7P9hCLcT0gYOv8L0D0hhk7WuF
         AVHw==
X-Gm-Message-State: AOAM530CG+aoe9nyJuVUWIDZcZwer1dCKyzvIeMwsKl7nM+YF82WgNfw
        mWTVRLzT8a5UyT3upiMLWvIEL0ay8gsHlQ==
X-Google-Smtp-Source: ABdhPJyTrx9ArClyBTRkyrkqV/L5SjeQtQywb8umAk6ailmPozRCinwqL00i9JTYi3qR1sYlHIvcpg==
X-Received: by 2002:ac8:570d:: with SMTP id 13mr9690513qtw.54.1629322411524;
        Wed, 18 Aug 2021 14:33:31 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x83sm551173qkb.118.2021.08.18.14.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 14:33:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 03/12] btrfs-progs: propagate fs root errors in lowmem mode
Date:   Wed, 18 Aug 2021 17:33:15 -0400
Message-Id: <8a8235462677d3a7c1cf21a8bd3244d929f1466e.1629322156.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629322156.git.josef@toxicpanda.com>
References: <cover.1629322156.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a check that will return an error only if ret < 0, but we return
the lowmem specific errors which are all > 0.  Fix this by simply
checking if (ret).  This allows test 010 to pass with lowmem properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/mode-lowmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 7fc7d467..d278c927 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -5204,7 +5204,7 @@ static int check_btrfs_root(struct btrfs_root *root, int check_all)
 		 * missing we will skip it forever.
 		 */
 		ret = check_fs_first_inode(root);
-		if (ret < 0)
+		if (ret)
 			return FATAL_ERROR;
 	}
 
-- 
2.26.3

