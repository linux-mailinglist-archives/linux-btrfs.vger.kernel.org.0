Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E46749CFA
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 15:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjGFNHH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jul 2023 09:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjGFNHG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jul 2023 09:07:06 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AFC1AE
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jul 2023 06:07:05 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-57026f4bccaso8350567b3.2
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jul 2023 06:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1688648824; x=1691240824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZ1qF6WYc2YSxHcZonDLVAwWWkkjLj7g4ruc5olZvNo=;
        b=LicHrwPUJNsG3DD7ldOSN3SE2JMp5dJdU1rLDtkL9Z2tG2Sv1tL+NMq2xpbr3nBoGF
         bApRRUkILgukWmv81gFuED3QJA98BnQQGNiUoj/N54FkmSw2abbPWMxGbCzMNQY4WGgz
         7muUqNnvGBDADiW9Br2/Octmvkc6FpQ05MNqlrzdAkJFcr9O17whpuVhgtbxJCmpFzU6
         9GsfZV6mLutK+1zZkCWDz1MTAbskUdhh7yYzUBX5Gy3v1LGccPQw8GwuZKg7vCGP+Jm2
         EfaMos//gqhQrMwYfmIcjmyyjh4fF2sSsniw6hnGP903pKXCDlAamolohkAkyPKhAyrV
         UTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688648824; x=1691240824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZ1qF6WYc2YSxHcZonDLVAwWWkkjLj7g4ruc5olZvNo=;
        b=Kk9TaFxAdhBnca1I+Fj6nRsl0O5N1tm3GvW7VqgZgNiE2JZIN8r2J1q+0G4qYWtH65
         Sjd044BOcCAlCMFSpSWiT8uET0IBqRyiK3kZ2NZDfqRUGdTTVf+fArbFFRuN8dWi8wjW
         iEJtxTKYrd4Wo8rOVTz+pWqGjtw9j0Rr2R55jmgplcMuBZnA75JzrwP7HQ4LZHZ33alO
         8q+5EguEX1jnce6zpew+6q4eFlaBrYTer3c7pTAJ7d8/pDJsZWGcKSp5bANEz38ZKVW7
         Lz/M5Aehvk8OpwA8lYo7MFqNkoB3uojQ55FbuWsvbhjI9WGmVedtCXsU35ATplcxV3qd
         F59w==
X-Gm-Message-State: ABy/qLYGc+Rlgry6fSULaAKWz6tMujzhder3VczBpspBexVIGv3MQOeu
        kz7RSvY1QbCjPgaI9EpDYyhGDqBOCCxrY4KRi71pEw==
X-Google-Smtp-Source: APBJJlGF40qhocVLDuwgEcdTlNl9coQ2KGNwxu8eonNqXXV+8C93UkPVf1U+5cjKz5QCnuW93OTt/g==
X-Received: by 2002:a25:e303:0:b0:c10:6ef1:d676 with SMTP id z3-20020a25e303000000b00c106ef1d676mr1582744ybd.29.1688648824240;
        Thu, 06 Jul 2023 06:07:04 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v13-20020a25910d000000b00c4e93761e38sm290759ybl.64.2023.07.06.06.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:07:03 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs-progs: set the proper minimum size for a zoned file system
Date:   Thu,  6 Jul 2023 09:06:57 -0400
Message-ID: <5e89618345f65a3aa4f89c4b7894d28767ea8c42.1688648758.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688648758.git.josef@toxicpanda.com>
References: <cover.1688648758.git.josef@toxicpanda.com>
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

We currently limit the size of the file system to 5 * the zone size,
however we actually want to limit it to 7 * the zone size.  Fix up the
comment and the math to match our actual minimum zoned file system size.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index e61ea959..a5af028c 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1441,12 +1441,14 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	 * 1 zone for the system block group
 	 * 1 zone for a metadata block group
 	 * 1 zone for a data block group
+	 * 1 zone for a relocation block group
+	 * 1 zone for the tree log
 	 */
-	if (opt_zoned && block_count && block_count < 5 * zone_size(file)) {
+	if (opt_zoned && block_count && block_count < 7 * zone_size(file)) {
 		error("size %llu is too small to make a usable filesystem",
 			block_count);
 		error("minimum size for a zoned btrfs filesystem is %llu",
-			5 * zone_size(file));
+			7 * zone_size(file));
 		goto error;
 	}
 
-- 
2.41.0

