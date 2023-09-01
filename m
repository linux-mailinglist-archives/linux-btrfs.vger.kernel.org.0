Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DCE78FFA5
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Sep 2023 17:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343671AbjIAPFF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Sep 2023 11:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241205AbjIAPFE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Sep 2023 11:05:04 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6597A10D2
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Sep 2023 08:05:01 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-63f7c242030so10240956d6.3
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Sep 2023 08:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1693580700; x=1694185500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8kw8yPREtZd7+hpkFCvKFf/CCfiXDVMVypmDmI/uVBs=;
        b=IYZEwdXDY4S+oyY6nEJUvqeaXZ2OeT9SrisM7zj8JYd9seXa5gGNVUe4mseVZ9g2VD
         FZ/ejWn51UYhFDyiVYdq/5YZvz73LE2a/M1O9wG5kr+8mf8zB2FIohWyVtUi3t8e/fXc
         89+CXYs/KbI1/5U3pJ/tlfB/1tnxJE7jtg3ojO0V05awf4zJQ/BQmTZ2XqKmZzeWwL6c
         cMT7n/TLCPRijGBAPyjbq3TWxn/zoaFrzxJRPylUJaRR5lRSQODvovhPKnvdgXDG2NmA
         v8Tg0mxvD41zM74KsusWeS35cvT+j+OTBYkFWOyRhS+b4DjOLF6MWHFK4mF47O8Oa3O8
         GW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693580700; x=1694185500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kw8yPREtZd7+hpkFCvKFf/CCfiXDVMVypmDmI/uVBs=;
        b=KM+yQsO3O+glH/VSy8RnEqjP5gn13KBJ3rom9xq8/QPbsRpVi1kG0rx9vbsJ3WKL1m
         CvL0B0uiVPZwMs0/2bqQEOEkUzak5fWbIuI99oLNUz8hMibU8jvJreXVpzdwo2f8GiEl
         iSfouwzL9NFLvC7Qa3UtYzTHNOpl90PSKVVvGhmuROT6u8vGgIfRO5Tsaqqe6SZ6VOBw
         cTc32+byl5XPYnJhfj7OpqELqMCHHhq0wfqRu+CsmnJJqREtJVXPoYtyeRNNBLNI9amW
         TYl9xz0h5WJ8s/SBkpQa/ZT9ZUVWhgpaTNV2fGpOfrgErYn/EDOJMUYlDXng3/tnWqOu
         lavw==
X-Gm-Message-State: AOJu0YwUNWZU5NgU3zmUi6BlSaW5bhw/UZXzRt+ePyPo7KOJVxoBNICr
        B37CM4DHqGsk3j8sjIMmfxJX4+lm/GEIAZiwlkM=
X-Google-Smtp-Source: AGHT+IHviVaI/fyllul8/jlef4BHr2y2JIxxOezERvAuD2/OHVNORihSA5ZJp5zltOU3cdI1D+O1Tg==
X-Received: by 2002:a0c:e4c3:0:b0:636:afa1:345d with SMTP id g3-20020a0ce4c3000000b00636afa1345dmr2706615qvm.17.1693580700409;
        Fri, 01 Sep 2023 08:05:00 -0700 (PDT)
Received: from localhost ([65.57.178.10])
        by smtp.gmail.com with ESMTPSA id h20-20020a0cab14000000b0064f5020df91sm1502312qvb.28.2023.09.01.08.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 08:05:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs-progs: don't take the commit root ref in btrfs_create_tree
Date:   Fri,  1 Sep 2023 11:04:56 -0400
Message-ID: <937ef150c1d9c0135bd1b158a9b5ad44dbd35b5b.1693580689.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
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

In 3ca6ed76 ("btrfs-progs: don't set the ->commit_root in
btrfs_create_tree") I stopped setting ->commit_root, but forgot to not take
the ->commit_root reference.  Delete this extra reference so we are not
leaking extent buffers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/disk-io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 4c8bef13..763125c8 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2344,8 +2344,6 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 
 	btrfs_mark_buffer_dirty(leaf);
 
-	extent_buffer_get(root->node);
-
 	/*
 	 * MODIFIED:
 	 *  - In the kernel we set ->commit_root here, however in btrfs-progs
-- 
2.41.0

