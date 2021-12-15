Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0235D4762F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbhLOUPQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbhLOUPQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:15:16 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD688C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:15 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id q14so23088082qtx.10
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=18HMuOWfA5cXNRDZoMkYhJ4YXXZ2klx8yGTrySUouLI=;
        b=wTCipjRqxqzC07c5yajPm5k3+T41xgp/eEd38/NvXssYJdUY966cpYglPy2fXELYi6
         Hv5/swjlAAMkto3dU7YN6PjI/JdQkwiVM/uq2+USl7RANpasMjaER2BhgM2qnYzXoa+Y
         d7RGtBsPhWnoPpTHGAc9+PyASMD/YcPm7ofELnWLSyPrBXikK7XMjRssdgnfFRCfuqIs
         KUYjdvbv8M3HolFSTNPiQ7CVCOulZd/lkP31ZJWlDI6ggtMjEWgE/9vF8v+qcAnyI0ZQ
         H0zN8ubzD78zoHsc9c1rai+S6NN7351Rc/L1Qp05qW+07E/Ov4EQoHwsEArOl8u01/6z
         735Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=18HMuOWfA5cXNRDZoMkYhJ4YXXZ2klx8yGTrySUouLI=;
        b=nzU3J6fYpO29bG+7zgOb4yO4/yI0UNGYXl/afDEYuUq9mNheb6ra3P19n+9HCUX3dw
         /jC3Hsz9GXlHTcQe40mLVafvKcHONuvYE0QTaLj6Z6zWfuEvMTpQXwdzmZTfczH2Qfyj
         JuwO95biGhmqXUYJj34wf+UQTljSp12D4djNfhwqPb/jde3UhkeKmkf86Cn0j1F5hjjr
         NprPePCg7Kvklf5kvIrJarA9eeJWb/JZmGYQusGSkKCxQDjfLhz/GhJwDqQoMYYEIboc
         4bkNCwkes+imSx7bNomnlghswq0L9jQGq/MPRuG1Zt8H7lYnvngz7D09CwFKgkCt3nxR
         h/mQ==
X-Gm-Message-State: AOAM532V6kc7i1tCSmZxYnKP+mkKAzZPPBAsihjsWwIfMlQKkijWASFY
        4cJ1xJFpb7K+BJkugE/gvOMDgWPBiRfpbQ==
X-Google-Smtp-Source: ABdhPJzkOxL5wJeV7sjVS85ip17aa2Bke7wl1uZmbiGZ2eaFo/XxtSczDYdU0PSP5kcfRRhuYP/ndQ==
X-Received: by 2002:a05:622a:4ca:: with SMTP id q10mr13883174qtx.631.1639599314662;
        Wed, 15 Dec 2021 12:15:14 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k1sm1555158qkh.53.2021.12.15.12.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:15:14 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 14/15] btrfs-progs: mkfs: create the gc tree at mkfs time
Date:   Wed, 15 Dec 2021 15:14:52 -0500
Message-Id: <0fe935e76e614a58ff9f0cda106a828ef5742229.1639598612.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598612.git.josef@toxicpanda.com>
References: <cover.1639598612.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that progs has the support to read this tree, create it at global
root creation time.  We don't need this root to bootstrap the file
system so just create it at this later point.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/main.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index beed511c..2d18e514 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -839,7 +839,18 @@ static int create_global_roots(struct btrfs_trans_handle *trans,
 {
 	int ret, i;
 
-	for (i = 1; i < nr_global_roots; i++) {
+	for (i = 0; i < nr_global_roots; i++) {
+		ret = create_global_root(trans, BTRFS_GC_TREE_OBJECTID, i);
+		if (ret)
+			return ret;
+
+		/*
+		 * The rest of these are created initially so we want to skip
+		 * root id == 0 for them.
+		 */
+		if (i == 0)
+			continue;
+
 		ret = create_global_root(trans, BTRFS_EXTENT_TREE_OBJECTID, i);
 		if (ret)
 			return ret;
-- 
2.26.3

