Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D200C4762EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbhLOUPE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbhLOUPD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:15:03 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5750CC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:03 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id v22so23097192qtx.8
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eY5I9VGg8/91Viw/dMpCGuGNSYLwWMhs4RrSJR1PHqs=;
        b=nylDrlpjFLgUHDy1xazJgBlAN/m7h48cK1HueUSrCMS0F8sW8GFVNo2Breoz/jQ2Ae
         n8aZsrtxYtxtSMEdHuSguxUf7s6mD2T3IKkn6ta010JNWTt7QtTjoeUY/0b4IlgyAj8Z
         r5tLEozGGeR6X7nWuycfy4uXQJuFt+pnN6wMQ8KD6O153tNT5AYrYWa4+8VrMxDNQjre
         f076MXQ5J/PV4ZOnn4DXETZ1ZffsD+lhfG2POVWc0pCGnIaZZ3zzQV7Bj0TOFHARRZXc
         L4QrIx2phSJahVF1L5MeFro/bT7qIGrepzkJOO68rohe/sf2XYVoVr6QuIvmwhMeVFhv
         BtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eY5I9VGg8/91Viw/dMpCGuGNSYLwWMhs4RrSJR1PHqs=;
        b=sEw0m7zCgdksn0MqPW1To58/MrGl87BY2xB3HX1Do/wrDmkgCiHA0y25VfHLAE1H8q
         WI4Ik1uj2leYWeCB/Y2sNTbwAhgo5N3IE3Bvb/UAy+Aepjk6L+TvA2h1Qd6cYZ70EfUo
         Llm/IxBuW63QllieisacDgIUvtKzUcz7e/OzLJyG+gM75Yx0xAvNIIxJ3OYw2o+ZYSDc
         0EmsDRg7eF9ojruuiOjwFM1xqaw5AyPiAiLlSyZ9N8zlKS3tl83Zd5qhpKZ7Kn/XZJS0
         7Nh0MM9rBxzybqbSnM0i38Lo8hdDK2+R923EMjNp/X8Ub4q3kZZlUKJqBsMYGGtCd7Ed
         p7Cw==
X-Gm-Message-State: AOAM530E74XWxyrP+Iw8zckbGh6uXAVZ6ySPu16Tygw7v3enJkH6WtKR
        mBOTfeuMQ9OtY+AuI4uVyo79WKpTf3JbEw==
X-Google-Smtp-Source: ABdhPJw8wBHTpKpEfyJx1PVjX6PD9eehE5A5tql7EF1Qz/5OGKYy90LNOcMLkGepcWLTzN7Ys0qK1Q==
X-Received: by 2002:ac8:7f86:: with SMTP id z6mr14024533qtj.162.1639599302186;
        Wed, 15 Dec 2021 12:15:02 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y15sm1625663qko.74.2021.12.15.12.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:15:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/15] btrfs-progs: check: make metadata ref counting extent tree v2 aware
Date:   Wed, 15 Dec 2021 15:14:43 -0500
Message-Id: <d1550b586f48c03f9d609d0b7ba6dc67521e58df.1639598612.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598612.git.josef@toxicpanda.com>
References: <cover.1639598612.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We do not want to bother validating extent tree references with tree
block references, so only set the references if extent tree v2 isn't set
so that we do not spit out extent tree errors for extent tree v2.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/check/main.c b/check/main.c
index 1b3ea079..da5aab89 100644
--- a/check/main.c
+++ b/check/main.c
@@ -6622,7 +6622,14 @@ static int run_next_block(struct btrfs_root *root,
 				btrfs_node_ptr_generation(buf, i);
 			tmpl.start = ptr;
 			tmpl.nr = size;
-			tmpl.refs = 1;
+
+			/*
+			 * We do not track refs for metadata in the extent tree,
+			 * do not mark it with a ref count.
+			 */
+			if (!btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2))
+				tmpl.refs = 1;
+
 			tmpl.metadata = 1;
 			tmpl.max_size = size;
 			ret = add_extent_rec(extent_cache, &tmpl);
@@ -6675,7 +6682,14 @@ static int add_root_to_pending(struct extent_buffer *buf,
 	tmpl.start = buf->start;
 	tmpl.nr = buf->len;
 	tmpl.is_root = 1;
-	tmpl.refs = 1;
+
+	/*
+	 * Extent tree v2 does not track references for metadata, do not set
+	 * refs if it is set.
+	 */
+	if (!btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2))
+		tmpl.refs = 1;
+
 	tmpl.metadata = 1;
 	tmpl.max_size = buf->len;
 	add_extent_rec(extent_cache, &tmpl);
-- 
2.26.3

