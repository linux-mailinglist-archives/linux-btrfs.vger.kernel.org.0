Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEAE5965E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 01:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbiHPXM1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 19:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbiHPXM0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 19:12:26 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E06B923E1
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 16:12:23 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id r14-20020a17090a4dce00b001faa76931beso282325pjl.1
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 16:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=2rufia4/ZPdOIzxMyAox9QXUKCdL/3SW+EHONpfWNN0=;
        b=tdHH1HcHj1ffajYFy0eug3udw20OjUQThdGzRYozjkShDmpH46cczSaaLTCtzYaw8A
         m4lPDH/+BX10aJp+MJmzgGinW/3yaHIdpaWQ9Gxpv882ZB7uwippoi1vu627eY7jefMG
         tJWxb7g96UmGR9hLYY4M3PP86I5bEOkJ207yHR5lk8KgqMdpu2V2MIJ2qkzdxEAA9wSP
         DBi9xiJ5qv13I0IYuO72jDFcJceTRtITWTgZA75lS4QkfejqENeYHbKWIKffoLxgxd1n
         fOzhejItCqxTLuP3uHODzuNM/a0ttpQbmngOEh5tq4kshEUoKaPNvBsO+aYeBk9HW71K
         rC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=2rufia4/ZPdOIzxMyAox9QXUKCdL/3SW+EHONpfWNN0=;
        b=RyOPdzzKSu1rcTXt1bUNpzh2H4wfd8X6Bl6rSoIKu9X2bHL4GC59YKuKtM7s20gvnd
         HbKkFb6slLqoXOHdVD2hJfoAB5ShmoxIjX7UoY38LrLcwoMeUy1kh6nQaxWoK3maP/I8
         OnVKsVakLycat7DD1MyO1pCg2K64x0FOqggX4HB/W+PF/UKNe3pFAriblczAIvwx+1IE
         WjIqbY5miikJ/rFZfW3n6j8Aoro6c3ZAGi34brgQailo06ud5d6hZzxPj+Rz4nRWdfr3
         Sc9TZ0STXIggTuhFa3NaPSb283QfPebks4FH0BnTWZqgMXcXNgcUnKe2bNHtaBfrPsVd
         ZCPg==
X-Gm-Message-State: ACgBeo1QTgo58eMOYiPxEQp3/lbKSuMrCtH28lOTzYxPaqmDsYn7REsg
        NzgIVa63NNSPd1jOdOlNMt8KValhQhdGgg==
X-Google-Smtp-Source: AA6agR6d5m598PiQo5ilVxb+M37PMJYqCdwa+HLOAfu9HrTR1/6K6Lh+Zykv211iGOAC5VMx4h4UGw==
X-Received: by 2002:a17:90b:2241:b0:1f5:4078:3ffd with SMTP id hk1-20020a17090b224100b001f540783ffdmr862517pjb.167.1660691542157;
        Tue, 16 Aug 2022 16:12:22 -0700 (PDT)
Received: from relinquished.hsd1.wa.comcast.net ([2601:602:a300:cc0::f972])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902e74300b0016c4f0065b4sm9721316plf.84.2022.08.16.16.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 16:12:21 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 0/2] btrfs: fix filesystem corruption caused by space cache race
Date:   Tue, 16 Aug 2022 16:12:14 -0700
Message-Id: <cover.1660690698.git.osandov@fb.com>
X-Mailer: git-send-email 2.37.2
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

From: Omar Sandoval <osandov@fb.com>

Hello,

We recently deployed space_cache v2 on a large set of machines to do
some performance comparisons and found a nasty filesystem corruption bug
that was introduced by the fsync transaction optimization in 5.12. It's
much more likely to affect space_cache=v2 and nospace_cache, but since
space_cache=v1 effectively falls back to nospace_cache if there is a
free space inode generation mismatch, space_cache=v1 could also
theoretically be affected. discard/discard=sync also makes the bug much
easier to hit by making the race window larger.

Patch 1 is the fix itself with a lot more details. Patch 2 is a followup
cleanup.

I'm still working on a reproducer, but I wanted to get this fix out
ASAP.

Thanks!

Omar Sandoval (2):
  btrfs: fix space cache corruption and potential double allocations
  btrfs: get rid of block group caching progress logic

 fs/btrfs/block-group.c     | 49 +++++++++++---------------------------
 fs/btrfs/block-group.h     |  5 +---
 fs/btrfs/extent-tree.c     | 39 +++++++-----------------------
 fs/btrfs/free-space-tree.c |  8 -------
 fs/btrfs/transaction.c     | 41 -------------------------------
 fs/btrfs/zoned.c           |  1 -
 6 files changed, 23 insertions(+), 120 deletions(-)

-- 
2.37.2

