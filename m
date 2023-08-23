Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AAB785AB6
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbjHWOdt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbjHWOds (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:48 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AEDE69
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:47 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-58d70c441d5so61850977b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801226; x=1693406026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjQZ/h9RD+k6uqUrhH4ybvt1cO8w26OLPFQJOJw2Ens=;
        b=U6f98Ce2m8ruHvgNE+dNHfInG8IhvljjS34sPp6b4Cr2XXnNj2VjmtUDipSTzVAIsD
         5TuynpOJaSgAWAR0d9V0IToH5oZG54DDicIPhdlaaxcTLbvMt4CXqQ9IaRjfnTL4bzll
         1AC5SotC8KQsa0Wt1axNPMSosPFBO7/x2/m0Fv5rduf/RYYaTiqSFGiqJNnELYL5cpxw
         E2RHneLp/wwT4CIHrO8H3TNv03nGa4LarpiGR3VOVjIPiqOlKucAsQr9MRHFpl46tT4A
         wVLUsWy3v26f4tKsYcDFTVVzQd/7MO3sdueOlYNSRd/353RKL0QwSTRu7o2e3Ghh0w5a
         OW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801226; x=1693406026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjQZ/h9RD+k6uqUrhH4ybvt1cO8w26OLPFQJOJw2Ens=;
        b=BnnCp129ySf/4Zyby6RYqiM03NZD9iCFM6StwWQPSiDQ1PMe/A/IywrTlIlkEdtq8n
         YweX5vVWZ1TWXWWIo+DZyG5+zDRrglgMY/CYZfycvir8BiObthKzG+Y8DvgSEJvC9GpW
         AjW7tvMPM7bjgJO3CKujsBC19DT10aMiFdP9VIqmXV1cNN8kgwBac/mrgO3R4vM1Q6LF
         PMUv1XIbnLzsdF3lvEjkYY0b4dPaN026OwoZXT64Rwra7UE8siPMpg8+g/ujuf/0mNnJ
         3yLSBwwsJKLIRN+8VppVaq3fEtME+DnGsPdtyHncgHudPhHKGa1Cz0EC7CPOmJgI6Wvf
         kGrg==
X-Gm-Message-State: AOJu0Yx/+sDh/q3agwqvgeUXGA8yclBJlo6Axulzq80KWz7yZIO3pMTJ
        IiUP1IQOJrLphZWC1WcTCOsEXO+yAqaEHArFokI=
X-Google-Smtp-Source: AGHT+IG6j4s9fqJeOxuydh+4hLfP4HXNma2gHoqMvKWTKnQpVXc8+dgyDWuYlPovvMlzk08ek0K9OA==
X-Received: by 2002:a81:4783:0:b0:56d:2d82:63dc with SMTP id u125-20020a814783000000b0056d2d8263dcmr12203640ywa.10.1692801226440;
        Wed, 23 Aug 2023 07:33:46 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u80-20020a0deb53000000b00592236855cesm1537362ywe.61.2023.08.23.07.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:46 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 32/38] btrfs-progs: update btrfs_insert_item to match the kernel
Date:   Wed, 23 Aug 2023 10:32:58 -0400
Message-ID: <774735885aa9f77d3bafc3903e3ac364909b96e2.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This has const struct btrfs_key instead of just struct btrfs_key, update
this to make it more straightforward to sync ctree.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c | 6 +++---
 kernel-shared/ctree.h | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 47938f01..5355d385 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -2680,9 +2680,9 @@ out:
  * Given a key and some data, insert an item into the tree.
  * This does all the path init required, making room in the tree if needed.
  */
-int btrfs_insert_item(struct btrfs_trans_handle *trans, struct btrfs_root
-		      *root, struct btrfs_key *cpu_key, void *data, u32
-		      data_size)
+int btrfs_insert_item(struct btrfs_trans_handle *trans,
+		      struct btrfs_root *root, const struct btrfs_key *cpu_key,
+		      void *data, u32 data_size)
 {
 	int ret = 0;
 	struct btrfs_path *path;
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index d15c16c0..5551d256 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1021,8 +1021,9 @@ struct btrfs_item_batch {
 	int nr;
 };
 
-int btrfs_insert_item(struct btrfs_trans_handle *trans, struct btrfs_root
-		      *root, struct btrfs_key *key, void *data, u32 data_size);
+int btrfs_insert_item(struct btrfs_trans_handle *trans,
+		      struct btrfs_root *root, const struct btrfs_key *key,
+		      void *data, u32 data_size);
 int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
 			     struct btrfs_path *path,
-- 
2.41.0

