Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975F85AB93F
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiIBURK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiIBUQ7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:16:59 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7331CCD5E
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:16:55 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id cv7so2278282qvb.3
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=7EsfeYjU4s8rij760mXrt8RqUZoUNdhhKeRimdFUM/A=;
        b=p8pihoyg5v08ITPwbF3KyX1YgmVVVNjwpAKkziUR0FdRPoPc5Rd4u12UL6gHwFT5PP
         j/kCZJD6u9LogysSZOsKx0PenX9upS0Mi24f2aL9mGzTfhfnMUFmFsjHFz2dtqTldWY5
         ahxSok+zI1TPGkOOHUfl2MxKoyMoNyQJC6ccPfxpC3rI042qDKbOK8uhae47tUs7HDpj
         S33+kMD6+c+HT1xb2qjdB3ha9a0V/DyFuJlhyqBBlWH9G7wkRM9OlVUeRzQhaS35V0Dh
         YNYsu/hQVeSExBlNkDBx/S06DmL05DlwAVYJvgO6AqSub3aCAs2KknG+I7X6WRRBsELM
         nB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7EsfeYjU4s8rij760mXrt8RqUZoUNdhhKeRimdFUM/A=;
        b=2TZeOgBDDYTTWy/s3Z7rkCBz3Ka20Y/nO/cnK1gd9F4gnXoa4jOxdt3SDR7AppCz/X
         iqAksSXzp/t4ifRXmQ/lBgq/CGSWUrX/ymxTRInpkhN0HHhXSTb11uWyDxfACAP4Ie7i
         dsxS4VA/jpwscqzS0qRipYozb4rosqTks/sr79z+z6TmegGoIAaTozljF/yThwJiwFBM
         JYpRSxjCiciUMnP/Z+W5oVq058LsP8q/60TsjzGMDoxUe7WPEbf/d5CRxTKmIGkp+5SO
         4LwHweFDWBufbqTB6FvydPlttDMCwLFHofs8j+WOQOjDl6Icn9dU21Fr7wLiWAx0+FjO
         CzkA==
X-Gm-Message-State: ACgBeo1Mfw/xBefpPoUQzkcwD20SgGxhODxUS4irle54GomGR152gFJJ
        rXAOIB5LlhAGo2f825KY7+32UvvKPi6Kfg==
X-Google-Smtp-Source: AA6agR5VfGS7swyJYMjaYJiG9oBZdIRR4ULwRx33ty8AgBaG1Ak9vIwPP6eyA21hlyEd0657NONTuQ==
X-Received: by 2002:a05:6214:2689:b0:498:f5b1:5c1e with SMTP id gm9-20020a056214268900b00498f5b15c1emr28873065qvb.40.1662149814751;
        Fri, 02 Sep 2022 13:16:54 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l5-20020a05620a28c500b006b5f06186aesm2141997qkp.65.2022.09.02.13.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:16:54 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/31] btrfs: convert BUG_ON(EXTENT_BIT_LOCKED) checks to ASSERT's
Date:   Fri,  2 Sep 2022 16:16:14 -0400
Message-Id: <4360935b03c1103514ac907f35405e1137fe5486.1662149276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662149276.git.josef@toxicpanda.com>
References: <cover.1662149276.git.josef@toxicpanda.com>
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

These should be ASSERT()'s, not BUG_ON()'s.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index dade06901937..028dc72d8b6a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1293,7 +1293,7 @@ int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	 * either fail with -EEXIST or changeset will record the whole
 	 * range.
 	 */
-	BUG_ON(bits & EXTENT_LOCKED);
+	ASSERT(!(bits & EXTENT_LOCKED));
 
 	return set_extent_bit(tree, start, end, bits, 0, NULL, NULL, GFP_NOFS,
 			      changeset);
@@ -1321,7 +1321,7 @@ int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 	 * Don't support EXTENT_LOCKED case, same reason as
 	 * set_record_extent_bits().
 	 */
-	BUG_ON(bits & EXTENT_LOCKED);
+	ASSERT(!(bits & EXTENT_LOCKED));
 
 	return __clear_extent_bit(tree, start, end, bits, 0, 0, NULL, GFP_NOFS,
 				  changeset);
-- 
2.26.3

