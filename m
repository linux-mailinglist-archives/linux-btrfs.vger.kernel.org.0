Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940AD785A93
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbjHWOdZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjHWOdZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:25 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913C2E69
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:10 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d71dd633f33so5599356276.2
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801189; x=1693405989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZuaRbraIK7esAjwYzoHLtLR2lLxKYrV6Kvo/Tba5jPc=;
        b=ThLsCW/dQHTwSI96w5JAMbTzC11qNkC0XP6i9w6w5QUV4Z/E3MbOR0V2RxlxsJ9A0n
         YdBkueb38HpIpKprrhRrRxQKSApk5ws1BASnH2Rty+uU7bxPUcjenaT/xUnhBQzlDaul
         s/C8lJqDGewMAEstLkD1LEb5h+jWY9jbDe9UAECa16jmbkKFoJ+rjv+ybGfTHFwD14pW
         D/aI2O+albNGEUr7OXAezD7SsN/TyOlwDln0XRxPmQvSnS+Jzoq2+wdKvZNB3WowOQrC
         LOPOEKvY1IGPf0OYELYm5dbCZimJGXZ8bvbmV6Pe49KYSgrnKjZjUXuKqkoxYc5IBi1j
         HGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801189; x=1693405989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuaRbraIK7esAjwYzoHLtLR2lLxKYrV6Kvo/Tba5jPc=;
        b=gwKNkKjz2eFLPcE+hb8brEjUyF57oyNsazYMGLUYPrTPpujsp720zhFJhex4yJpdrr
         qAyO18xlW2BIt11D9d7wTHIahhZweun0Duo3IUhY543DVR8BiHD+2YSsYNoaoZb8eW5w
         krZ4hYtW0y1aG4wQuL6g0/tVDYPxC0g5qSboBmGFGwEO7RXzr7T1M2TpJd5pG1IZhAf/
         UIuNDc7OF7KazjiOHyE34zh5hOBcvrD68ALbVzK71oZQmafdK7UtP4UPZ3PAn7ma09N4
         Wn+CI2fHOOSzARMHvmnSGjoiFjGxfc7s2SGwkkD8wMT2Y5YRaaJ4yKmQ1c1t12KCfgU1
         ZRzQ==
X-Gm-Message-State: AOJu0YxHNy//n8Q7QRwpcljLT8Kpl5HyColCTq45ASJLRcEmnsdiW2hG
        OYnK376vJfrZl8iTvAvzhMzS3J9bcICRM6dWuz0=
X-Google-Smtp-Source: AGHT+IEKJ2vXkiVfPgW1KPj7s/BYJyEyIFLjuz4KJ+8NRhivMX0ewNt8GH9puwQr56+7DtCQ0BJbvQ==
X-Received: by 2002:a25:a28e:0:b0:d6c:cd45:73b4 with SMTP id c14-20020a25a28e000000b00d6ccd4573b4mr11812367ybi.54.1692801189694;
        Wed, 23 Aug 2023 07:33:09 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h186-20020a2521c3000000b00d1d0841d911sm2851121ybh.17.2023.08.23.07.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/38] btrfs-progs: stop using add_root_to_dirty_list in check
Date:   Wed, 23 Aug 2023 10:32:27 -0400
Message-ID: <1ca99898312945fad777d436de277df359de0076.1692800904.git.josef@toxicpanda.com>
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

This is used to make sure the root is updated in the tree_root when we
re-init the root, however this function is static in the kernel and
doesn't need to be exported for any reason.  Simply update the root item
and then update it in the tree_root instead of adding it to the dirty
list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/check/main.c b/check/main.c
index 4565b367..d992b9f8 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9163,8 +9163,12 @@ static int btrfs_fsck_reinit_root(struct btrfs_trans_handle *trans,
 
 	free_extent_buffer(root->node);
 	root->node = c;
-	add_root_to_dirty_list(root);
-	return 0;
+
+	btrfs_set_root_bytenr(&root->root_item, c->start);
+	btrfs_set_root_generation(&root->root_item, trans->transid);
+
+	return btrfs_update_root(trans, gfs_info->tree_root, &root->root_key,
+				 &root->root_item);
 }
 
 static int reset_block_groups(void)
-- 
2.41.0

