Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06E93EF996
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 06:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbhHREkA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 00:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237475AbhHREj7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 00:39:59 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B93C061764
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 21:39:25 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id m21so1540399qkm.13
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 21:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dvoTfwMXGVSrk5DQ5w7SRyqwBT7yRVc2+BuBuVv42wE=;
        b=k7+5UBtkEnjKKENbkNlVqKR/rT+eKgZvu41U8J5DSuhQLh30XXCSxOYH0Rt28V5Au7
         RieX8ixZ1ypeYvpxLe5Uz0dcW/0P6I67K3CDWlzhzdr+OAxi30hFWh4Q4GyurlxkRqUS
         mE22r6AeiL2tNkCMDqwugP+H7DfIHYCZkILuhaH9dJkAWiAJhhDcya6xlrqilCiDt/XD
         p8Kaz4DJ5Ao7JbGiDEzbK/rtv1W7st8JQqEYOrBPQEQoUoaBZBgTE/wFmxK1zg8gcz3z
         45wt0359LEimBp2GzZQV/5xq9k9YO4lImfFoYHgo/SNWIDOatn31wUnrjI7TsoSk2Ywq
         NKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dvoTfwMXGVSrk5DQ5w7SRyqwBT7yRVc2+BuBuVv42wE=;
        b=UMEyHGEyPgE9/5PHDd+M21aImxiX4GlnLmEOdM06E52y8wFna8d918oE1LEJxifiUq
         lTv4o5EqG4JBLhGMshhrKNN+m3r2F6reohcldbsBkutCx7Bk7tXGeWVMGUkHAdsceJLP
         bCQ/pWC/MFd6FFftiypjBdeetnrsOegjo0MeWs/uFEaXupfJnd9Y4WvP9l4hXJ9266xX
         IOW0Tfzz9EZhBSelaj1BZeQpFvGtbu2XX/x/vQibH69nNyETjL6bIieJ/LQDI0X77Qua
         A0iBGiEzi76aicm1+CWGeSaOLGEn+2lm4hVYoPssj/UV6mORQrld5p9JtV2bOaH8+rAT
         YjRQ==
X-Gm-Message-State: AOAM532HqpMWLznku7n7Rknl7mFDeHTzlV5kW8pbxNwcOlN+VYWippjB
        B4QLMOiry1usa5gHPZRuxhP0GFrfjtK9jg==
X-Google-Smtp-Source: ABdhPJxHwJ5tzZuPMQ9o3Y/AwCZmRxGjXwYnXKRgvWRb6tzCXoEvluInEDGz9BYjEoTZODStrBRcgA==
X-Received: by 2002:ae9:e8d2:: with SMTP id a201mr7679952qkg.347.1629261564057;
        Tue, 17 Aug 2021 21:39:24 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v128sm2888215qkh.27.2021.08.17.21.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 21:39:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/3] btrfs-progs: make check handle invalid bg items
Date:   Wed, 18 Aug 2021 00:39:19 -0400
Message-Id: <cover.1629261403.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

While writing code for extent tree v2 I noticed that I was generating a fs with
an invalid block group ->used value.  However fsck wasn't catching this, because
we don't actuall check the used value of the block group items in normal mode.
lowmem mode does this properly thankfully, so this only needs to be added to the
normal fsck mode.

I've added code to btrfs-corrupt-block to generate the corrupt image I need for
the test case.  Then of course the actual patch to detect and fix the problem.
Thanks,

Josef

Josef Bacik (3):
  btrfs-progs: add the ability to corrupt block group items
  btrfs-progs: make check detect and fix invalid used for block groups
  btrfs-progs: add a test image with a corrupt block group item

 btrfs-corrupt-block.c                         | 108 +++++++++++++++++-
 check/common.h                                |   5 +
 check/main.c                                  |  89 ++++++++++++++-
 .../default.img.xz                            | Bin 0 -> 1036 bytes
 4 files changed, 197 insertions(+), 5 deletions(-)
 create mode 100644 tests/fsck-tests/050-invalid-block-group-used/default.img.xz

-- 
2.26.3

