Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D6A5B8B54
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 17:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiINPHJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 11:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiINPG4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 11:06:56 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F1276966
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:06:54 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id a20so8726838qtw.10
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=hFAXnhRYrEK3GoxP0LVzN97K3kdl/elyCNFT+DHpGAw=;
        b=ZsOEjCosT4slGZSYqN8gJbJZE1FXzYHcjWUqH+SzKIxiblUQhGNCPJIN+QGDtAICCe
         JYUfw24ZBjCMO4uMXvgH75xhO20MHoqqcHuNadDUZgzdj8yyeyaukV9xiBFYkqw9v8cE
         JJshYjF5+BP2BA+UGE1QfxGc0ZM9zTuBvQFB3IRZEplkjJNR6Kad/CoK1ciHhqJpwDat
         ItLsTQ7PHLOpel0UfPlW0Yhq7rSzYhDVWc/4ZofaNxUnvmH2syvNKLhb/89yOzeE9jmN
         dimuqjh1rtCklo5pp3PrrtIwYIqYFwm5MyjJ7a02ShFdfwPa/RlzSDGvAvzmcsLfIQr+
         G4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hFAXnhRYrEK3GoxP0LVzN97K3kdl/elyCNFT+DHpGAw=;
        b=n3T+LmQsZCaQNUJ3qR2KGb5svEWZ1AYvkjVIvfIZoUdLMYRcD0tBjcyhF1V2T8mmMh
         dT/ol7elRmMb6k/7UUd5yZmKy1A+gfEMF8LpLB3Gjhr6ObBg6XQ2MsGmZcdJQbxe6izh
         F7u6Jsd9ZSBIwcNeSeL2JgjhGIm0a/JUpUD0IXTzlJMvUi4skM0xjZoPmgkHPQroZsV6
         XQquUga2x0wb+YNrmQuikelSvQ+Hf0ynR9qxMXUiZZtnmsatzfzNqClVFkYHZUH5mvp/
         wbfROrpHCZHNhnOttMjTq3LmAz7HoKWzD8QcCTDO6Bot9A5O3ZpNGgqpRt4TDAV8Mxgb
         I1ow==
X-Gm-Message-State: ACgBeo3NtfyL8fV+k8bimvu272Ndakwn6JIcftL7/pVSYbMDKxebppbd
        NxiifLkUCl/jt2817oO7ZqF0cStyU3QgkQ==
X-Google-Smtp-Source: AA6agR5pdzJq3naYNy/Ij4QqkFdsFrUsqzeUVdG4otXZlQS2Djfn7fasKlDFpSZBn8jEBtB9PAxe2g==
X-Received: by 2002:a05:622a:550:b0:344:90ec:50f5 with SMTP id m16-20020a05622a055000b0034490ec50f5mr34105055qtx.466.1663168013393;
        Wed, 14 Sep 2022 08:06:53 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i10-20020a05620a404a00b006b98315c6fbsm2122146qko.1.2022.09.14.08.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:06:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/17] btrfs: move BTRFS_MAX_MIRRORS into scrub.c
Date:   Wed, 14 Sep 2022 11:06:31 -0400
Message-Id: <37fa62e6907f1eff71e2c77b9dadb324a408d9a2.1663167823.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663167823.git.josef@toxicpanda.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
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

This is only used locally in scrub.c, move it out of ctree.h into
scrub.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 11 -----------
 fs/btrfs/scrub.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 5e6b025c0870..e1ec047deff6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -50,17 +50,6 @@ struct btrfs_ref;
 struct btrfs_bio;
 struct btrfs_ioctl_encoded_io_args;
 
-/*
- * Maximum number of mirrors that can be available for all profiles counting
- * the target device of dev-replace as one. During an active device replace
- * procedure, the target device of the copy operation is a mirror for the
- * filesystem data as well that can be used to read data in order to repair
- * read errors on other disks.
- *
- * Current value is derived from RAID1C4 with 4 copies.
- */
-#define BTRFS_MAX_MIRRORS (4 + 1)
-
 #define BTRFS_OLDEST_GENERATION	0ULL
 
 #define BTRFS_EMPTY_DIR_SIZE 0
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 9b6a0adccc7b..35fca65f0f2a 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -56,6 +56,17 @@ struct scrub_ctx;
 
 #define SCRUB_MAX_PAGES			(DIV_ROUND_UP(BTRFS_MAX_METADATA_BLOCKSIZE, PAGE_SIZE))
 
+/*
+ * Maximum number of mirrors that can be available for all profiles counting
+ * the target device of dev-replace as one. During an active device replace
+ * procedure, the target device of the copy operation is a mirror for the
+ * filesystem data as well that can be used to read data in order to repair
+ * read errors on other disks.
+ *
+ * Current value is derived from RAID1C4 with 4 copies.
+ */
+#define BTRFS_MAX_MIRRORS (4 + 1)
+
 struct scrub_recover {
 	refcount_t		refs;
 	struct btrfs_io_context	*bioc;
-- 
2.26.3

