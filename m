Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257305FEF92
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 16:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiJNOCd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 10:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiJNOCI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 10:02:08 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1801D346F
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:01:29 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id mg6so3255330qvb.10
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0JY9hla8Mv+TDdIFHGhPq78JDSMYmT5EcO5gUnud1Mo=;
        b=Zzip7Z7tYEr1obL/tHLCZmlfFzFmidFsOo7Q8ocWrEqzVFd4SMF8+tpS6h+OJlJQcG
         tkAun62iawWiOPAtjGtXsupWd47uq+x2MyaH5IQexalqZkRBGLIZG2CxAa3f+RFAMioO
         HZT0RqoE56A5HMfTlltIST3rwTwbjoKDdz+GOycFM40HDWoVo/nxt6HJYCbE67iCrmjb
         bWBAv2Ge5SgTfnXa2s00H+SxaLxZn6uez4t3NPGHv6gRVMCfys5QCqjYiFCUGk8ED65N
         cTGghyaSGpk9EgcafTTfZBQqyElmTp40QcmSXrSFIkPQR71hnZLtGfQ4cQt/LUfkpJ2G
         6qXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JY9hla8Mv+TDdIFHGhPq78JDSMYmT5EcO5gUnud1Mo=;
        b=pijOEqYxh+L/HWmhWA87rBPjq2EgO0ds3ru1FeaHXkiaYvHnoGAwPelXe2+iDSsCjD
         hSR8ZlX7Z3ej92Fb5CtxUc5EJW1gixXha2J31+eI/ShkORR+323HczoOTZct6XzCxLzr
         zxW1bt6SbIy5Wd/hLoRS113H0eTugjOxHBTXnmvCWDXcBrx9UECWPulNLgz9BTn0cXKK
         6idfN7YrTCQW2RKUD2vcJHRg2n0fJRcl7FQZyytFqbd1tC55KHyT3eRbAlmdRtQy0GT/
         SO7MO4bbOidHAhZ3G6RVA4eRbG6LSDT+/dyCCaj3n8OWqY3x5uGAvTiEY30Vfo/W7bIH
         3zAw==
X-Gm-Message-State: ACrzQf1Wbf04hfc7Ltjn1Ex2iP/kWiJ7IBae5eLGnQqN7JWgMpVW/yD+
        Ppo4Ew6iPj0ZW7NHY6c5sbmhnUbdx6h8hA==
X-Google-Smtp-Source: AMsMyM4Y5NW0p2B9bgi8Uqm/qcl5sOUuIdTbOm2cMvHLridrnOYHcIhJR+24FPupchev/PTbyjrlCw==
X-Received: by 2002:a0c:cb85:0:b0:4b1:8e41:d0b8 with SMTP id p5-20020a0ccb85000000b004b18e41d0b8mr4329558qvk.71.1665756047925;
        Fri, 14 Oct 2022 07:00:47 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id y13-20020a05620a25cd00b006cbe3be300esm2598117qko.12.2022.10.14.07.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 07:00:47 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/3] btrfs: remove unlock_extent_atomic
Date:   Fri, 14 Oct 2022 10:00:40 -0400
Message-Id: <852b4be23ee74070c3745103686233f94b914687.1665755095.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1665755095.git.josef@toxicpanda.com>
References: <cover.1665755095.git.josef@toxicpanda.com>
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

As of

  btrfs: do not use GFP_ATOMIC in the read endio

we no longer have any users of unlock_extent_atomic, remove it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index a855f40dd61d..8187f3360056 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -139,13 +139,6 @@ static inline int unlock_extent(struct extent_io_tree *tree, u64 start, u64 end,
 				  GFP_NOFS, NULL);
 }
 
-static inline int unlock_extent_atomic(struct extent_io_tree *tree, u64 start,
-				       u64 end, struct extent_state **cached)
-{
-	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, cached,
-				  GFP_ATOMIC, NULL);
-}
-
 static inline int clear_extent_bits(struct extent_io_tree *tree, u64 start,
 				    u64 end, u32 bits)
 {
-- 
2.26.3

