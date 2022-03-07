Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355A54D0AB0
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241110AbiCGWO0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbiCGWOZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:14:25 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57095620E
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:13:30 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id c4so14614272qtx.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=moBbcvFP1PSHfvsI0T5G863OtrtNcFalQRZOORsnG7E=;
        b=CclccNhjMo9tJxNIUiiyRO/iQBzPIRhvQlcfFoYFPhVnX20ldPHC1euiPUJ3w+ccnG
         BJjvy3SsInttP1pI9Vxs2EI/CeeSA7Z931xaJIYMkg4YDICpbYDlwPuNULzx8HRok9iQ
         dDJNVVIsyHaq/gIDrnPd9ZRXxYEEuR15QSH449CCvzWyWTwdp8ThGQbGYmBlzpEz/bM7
         MJyekix862NI/NHfy7PFOKp/tNbRNiTbjU0urxu+CKzH+pcXZ/T+f13W30UrfMdr2Z7y
         H3ZAsUV4K1fAEV++cm8O76WoKrVZrXnP69GN0CNCoQS3n05/UKSiUEItQlxEQjZycKkQ
         p69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=moBbcvFP1PSHfvsI0T5G863OtrtNcFalQRZOORsnG7E=;
        b=c1IeBRBnTwpeLuzxwXeqiRR8mO0A9nkQnoIUNmtY8uR5M5ExVshaPq/FH2r7lbCyVl
         8iTt2NKs9ODTU8UX9IfaeOiiRfw1Um1S0zjo3qdQAxlPJhv9x1g89QV2Rhs7VmX2Wb+n
         nBGd1NM8pFd+LzxCCf1Sz+Eyih7/zTICLjHhZZDV5uQbJjbVM6rnLFRyCBTKgxf1cpHg
         buWqQDLYqx7KQNSZv4Flbt+FKGzd4FrhMtOnGxz5YqJz1CZi13XF8DJco3ekKfBpSlHh
         1B/Fhxal8ZmPt4DKDZ3SEqn6JWCLDKMkMp1XMe2D8mRO+GYz3+AcYRYXozNvTKh5wBUV
         DHyg==
X-Gm-Message-State: AOAM532T/IZMrGtXO+GTlCuvr8MCX/f4knAEZ+l5jtER1XwbOHgaee3Z
        L9/nbwPZTRtt7VbJA/jOYhqLPKSrvU83R6f3
X-Google-Smtp-Source: ABdhPJxHL+5/veDlm3BIIWQW6ttv4aYmgT8a6fmf4vEyxOZLKxpglFRmiidAutzQiqjLOQZNA1ctYw==
X-Received: by 2002:a05:622a:198c:b0:2de:707:b1d9 with SMTP id u12-20020a05622a198c00b002de0707b1d9mr10980164qtc.233.1646691209506;
        Mon, 07 Mar 2022 14:13:29 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bs11-20020a05620a470b00b004b2d02f8a92sm6937019qkb.126.2022.03.07.14.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:13:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 05/15] btrfs-progs: check: make metadata ref counting extent tree v2 aware
Date:   Mon,  7 Mar 2022 17:13:10 -0500
Message-Id: <4c1e3e69e4ab71da355ef06e56fc728152e81e74.1646691128.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691128.git.josef@toxicpanda.com>
References: <cover.1646691128.git.josef@toxicpanda.com>
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

We do not want to bother validating extent tree references with tree
block references, so only set the references if extent tree v2 isn't set
so that we do not spit out extent tree errors for extent tree v2.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/check/main.c b/check/main.c
index 420453e0..5fb765c5 100644
--- a/check/main.c
+++ b/check/main.c
@@ -6635,7 +6635,14 @@ static int run_next_block(struct btrfs_root *root,
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
@@ -6688,7 +6695,14 @@ static int add_root_to_pending(struct extent_buffer *buf,
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

