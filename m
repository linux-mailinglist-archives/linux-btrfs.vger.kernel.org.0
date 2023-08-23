Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AA6785AAC
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236519AbjHWOdm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbjHWOdl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:41 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61779E5F
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:40 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-58ca499456dso61952717b3.1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801219; x=1693406019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qasZHistys+4vnRfwE5lfGydn7AMo6TWpiHN1XgEjVA=;
        b=oRJ1CjiPaViQdJ/1DIk3BZwylF5VPR37PeE9UTfWJiq3cprBbBeb9CsshmFUq4zLmy
         o4MU9BB0Mmh6tc0pb+JQ3pmXsEntiJwpySNDTGNiJFvhXtiQHiG/rN7frDrUkV4V4tjc
         3dQixy1EvC/2SfemFwsgwq5CHlNPns17VmGdqf4Fcnz5Hh+xODAMZGY1wDv84gKmpJgX
         Sp8W6yDpjMDXtjr8EpBDfSHYZMPQL8KjmJL5DgojMlyl2G41Zf4SNhm2d1G3ZE586Erk
         Dze1BkaivcEc7PG0R71QGRWuoSFaLEB9NMPzJClicWqHVKwg8rWNfdJ8D09/+mYR1+vO
         zxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801219; x=1693406019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qasZHistys+4vnRfwE5lfGydn7AMo6TWpiHN1XgEjVA=;
        b=UnSAXHkLu+Kyr5EuBL2e9rL/2XtKcHAxpDfaO5jAvra8XbgyGq6qgmgduABzID4N6b
         SWy/Zh+Uly4Zvfps4JcPz69AD4tfHt3eugfOaqlMtaFCpwOK1naPlNI3iwa26or59KCU
         2TWgoRwKH1r239gmSqW41G9IV9uxICJar0LO7QNYNKvbYVvn4tzdnJQ9T+6kX8WWwF+P
         UZC1tqnVQE8cFsbAgT147G3um58wq9Go8FuQYBxTPyT48rGDCdkCJow+IMLwPqNDo+lF
         XirUgDvatadkwuBETR/A8R3Vyzx+1zOwanCX8aqF1tb7t23s+OlGOd2yI9wX+F87CfJf
         st7w==
X-Gm-Message-State: AOJu0YzqoH34DloOWHpOZPG1UZ9mEdnkyzRIFzYtwFobSxHu31P8+9Cq
        dc2TWx5sqUo9rqKiobZkIncYojvrtvUcAwoz4jU=
X-Google-Smtp-Source: AGHT+IELKhJyWWD7d/dRx3xrrQo1rd6FhxfFagKNQMRtGLRglOxD80ju/ysfNN42yA9UFxQTGBewdQ==
X-Received: by 2002:a81:6055:0:b0:57a:5099:2217 with SMTP id u82-20020a816055000000b0057a50992217mr13156814ywb.18.1692801219528;
        Wed, 23 Aug 2023 07:33:39 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w6-20020a814906000000b005773afca47bsm3374475ywa.27.2023.08.23.07.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 26/38] btrfs-progs: add trans_lock to fs_info
Date:   Wed, 23 Aug 2023 10:32:52 -0400
Message-ID: <99c37d184d3095659df91da2df5ef7ebdae70080.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
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

This exists in the kernel, and is touched by ctree.c, add it to the
btrfs_fs_info to make sync'ing ctree.c more straightforward.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h   | 2 ++
 kernel-shared/disk-io.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 0b440b1a..6ceae3e9 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -324,6 +324,8 @@ struct btrfs_fs_info {
 	struct extent_io_tree extent_ins;
 	struct extent_io_tree *excluded_extents;
 
+	spinlock_t trans_lock;
+
 	struct rb_root block_group_cache_tree;
 	/* logical->physical extent mapping */
 	struct btrfs_mapping_tree mapping_tree;
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 286eb9cb..4f87b6fb 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -870,6 +870,8 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
 	INIT_LIST_HEAD(&fs_info->space_info);
 	INIT_LIST_HEAD(&fs_info->recow_ebs);
 
+	spin_lock_init(&fs_info->trans_lock);
+
 	if (!writable)
 		fs_info->readonly = 1;
 
-- 
2.41.0

