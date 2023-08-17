Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8DB77FF66
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 22:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355090AbjHQU63 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 16:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355081AbjHQU5y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 16:57:54 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A346830F6
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 13:57:52 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-56e16e4aba7so199887eaf.2
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 13:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692305872; x=1692910672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ojiYdq3N3yjJ9R+oGc5H35RV35tGrCVNXgK2y/BkKLI=;
        b=UMZgIsQ2eZxtGCAVPJ6b4vZs/Gd2fizSbBpsQ48miwYmisvIj/45dARjDmUYyeINPf
         8e+zbSa0fbjBxSq3hdaXCvCkNh046p7KuEq4FFGLpgczIOFotP9x21Qb75h0tgOxyeHZ
         rzaRQgMvMcJZDjTNESvkVPrNkoCMk/D5XOCXD6LrKo8XSp62anwrJimMnAH1Ysck0/Kk
         KLlsWHkRiKBiA4Uqwuv/yqnR657rJOozNDejfAqWpDzzqenYy0Wm85VWGgINIMcl3ieR
         p58DorQIkerir9ZHkQlVkXA8sf8FtJxAWyZUyDmJR3PnAcs0zeoKkMC7auMiZC1vLzww
         OSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692305872; x=1692910672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojiYdq3N3yjJ9R+oGc5H35RV35tGrCVNXgK2y/BkKLI=;
        b=au/SoEdPxguMhociSIhJgzluJErjsPknzm+4VmizMgfeFeLkuCa9ooQjBbcq3xVLSX
         L6X8sphJBPFdeJn71jx7Hjk1kEP83YyrXkb/Xox37xa4vOBJZdnTVf4lTzUbmU0IFUm9
         SIHQttNjyTQp9YZCcvLkmytVGDy/hkgGTDSMWRCaydPyS4eMHz1RleCfN9mhPKxgpsRc
         yJdRMUespSTj51o6QnHtwadpWKTsSNu7q4cYQpEOFfUhk6XSrdAUQwUc+aznW3jbPcDp
         Y1VsdoVVZiCnNX1rcLRAJ02bS0edlorGZa+a4/8XzcrDtm1Rx22ArOF5DDHY48qjrB6H
         yyMw==
X-Gm-Message-State: AOJu0Ywmzccyf18Jhd+P6LmR39OWLhoBnpU2XjX+cWzSozS3mq4UjE3e
        +fncUnTPWymY/B17XogrxU0nUYCzk62JGC2ZNs57sA==
X-Google-Smtp-Source: AGHT+IGqg4TOyeRUAgAaUi49+XM4+aF0kPHOgVPnSbcczbnvTW3zD9RuAIWtS+mCPpuSqyjeg2aEyg==
X-Received: by 2002:a05:6358:c0a:b0:135:46d9:12f7 with SMTP id f10-20020a0563580c0a00b0013546d912f7mr810165rwj.26.1692305871742;
        Thu, 17 Aug 2023 13:57:51 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id s4-20020a0de904000000b0056d31a089e9sm98260ywe.126.2023.08.17.13.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 13:57:51 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/4] Fix incorrect splitting logic in btrfs_drop_extent_map_range
Date:   Thu, 17 Aug 2023 16:57:29 -0400
Message-Id: <cover.1692305624.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

We have been hitting a fair number of warnings in btrfs_drop_extent_map_range
and in unpin_extent_map in production.  Upon investigation I discovered we were
splitting improperly when we call btrfs_drop_extent_map_range with skip_pinned.
This results in invalid extent_maps in the inode's io_tree, which in turn wreaks
all sorts of havoc, mostly in the form of these WARN_ON()'s.  This took me a
while to spot so I have a bunch of self-tests that test various functionality of
btrfs_drop_extent_map_range and btrfs_add_extent_mapping, with one test that
actual exercises the bug.

This has been broken for a while, and thankfully is only triggered in certain
cases with relocation on.  Our environment uses auto relocation heavily which is
why we hit this reliably, but the incident rate is still relatively low.  The
bug was introduced over 10 years ago, it probably could be limited to being
backported to the most recent kernels, basically anytime after Filipe's cleaning
up of this code.  Thanks,

Josef

Josef Bacik (4):
  btrfs: fix incorrect splitting in btrfs_drop_extent_map_range
  btrfs: add extent_map tests for dropping with odd layouts
  btrfs: add a self test for btrfs_add_extent_mapping
  btrfs: test invalid splitting when skipping pinned drop extent_map

 fs/btrfs/extent_map.c             |   6 +-
 fs/btrfs/tests/extent-map-tests.c | 414 ++++++++++++++++++++++++++++++
 2 files changed, 416 insertions(+), 4 deletions(-)

-- 
2.26.3

