Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434D04B90FF
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 20:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbiBPTHN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Feb 2022 14:07:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiBPTHM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Feb 2022 14:07:12 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFF31AF2C
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 11:06:58 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id fh9so3780548qvb.1
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 11:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h4P+WAWtxjqefIFnFzuuPEx/iWiwAbW1KPbeJvHn8pk=;
        b=nijRQniex9moj1GFSPafSFEHrozSD4TvLG34BJl1DSijnzY/90D4iz4VsCVPMf+Q+c
         7Y5GhbBN+SOzfZJ8s1sqjzEKxm8T40F2M3wyraIgFpoCbCNF10XrB0s4mlhFSoxDIuzE
         T7EqbzyYoM0iKV9Jafpy1fTk2Q2CeD67HUsFhd7teguTWnmRsCAXjXUISXKkbrUAHNdv
         vx9JpjGZ3B5iZTlry9WL79hfw5I/IwnsXM6J7737uNHog/R+5SaoixlpqGIwfMvvFoEU
         gSGqa6x4Qm49/HIVbzg6M8bVKamOY5CWzoMqSHvUJXlZVF+YYH2GQCEDKFGfSV3Vm97a
         NRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h4P+WAWtxjqefIFnFzuuPEx/iWiwAbW1KPbeJvHn8pk=;
        b=62/ZN2KJVHBEG0QbaqwMQBbkW8U3IilLzC2sVqUMoKt18y7iUc4CTXNmPvZlLEEge8
         +FaRWX80q0pDr+yzCoDHuyk8KfcD3XAnNTsz8Sp9lH06K/GoDupWRMxKLYkvyMKJQgK/
         Ds55Uhus5NOwniLzNhoFOOnSGpgdzOuLpPB6dnlN84j1IxCJ0XG8Tkdqp/3ygW8clsDn
         TjSMN0/rASQDMxBIGqk/LztW5O2VXYRSwXeh0vBM3oXYXY29fMCGB/jKZY29bnb2rtu2
         SRjcx6od5ooFCcR33LoMKra2D3uyqjOsvTi5JC0dqBRISdlsm1MsxfaL4ylTEXgCVQ9k
         l8GA==
X-Gm-Message-State: AOAM530njDq9utXVEvClAo7I6XXy4CLAjblQlgZY6Fs2y9fJj5zVSOKK
        HsNt2chiUG57G/+xGiaQrjpdbp5nJjj0mUi7
X-Google-Smtp-Source: ABdhPJwL54/gLNZ4QyrHCvAU8Ixk7ueijS1R+7cm7MlnaGT7JrQZfqqVDYe+bE/Ue+zuPvG9B+z2gw==
X-Received: by 2002:ac8:5c02:0:b0:2dd:219:2489 with SMTP id i2-20020ac85c02000000b002dd02192489mr2462831qti.201.1645038417398;
        Wed, 16 Feb 2022 11:06:57 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g11sm19819767qko.58.2022.02.16.11.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 11:06:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/3] btrfs: fix problem with balance recovery and snap delete
Date:   Wed, 16 Feb 2022 14:06:52 -0500
Message-Id: <cover.1645038250.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

Hello,

I found a problem where we'll try to add refs to blocks that no longer have
references because we started a relocation while we had a half deleted snapshot
in the file system.  This only occurs on a clean mount with a pending snapshot
delete in place.  I saw this in production but lost the file system before I
could test my patch.  However I reproduced it locally with some error injection.
Without my patch we'd fail to run delayed refs with the warning in the commit
message in the first patch, with my patch we mount and can use the file system.

The other two patches are just cleanups that i noticed while messing with this
code.  Thanks,

Josef

Josef Bacik (3):
  btrfs: clean deleted snapshots on mount
  btrfs: use btrfs_fs_info for deleting snapshots and cleaner
  btrfs: pass btrfs_fs_info to btrfs_recover_relocation

 fs/btrfs/ctree.h       |  2 +-
 fs/btrfs/disk-io.c     | 22 +++++++++++++++++-----
 fs/btrfs/relocation.c  |  5 ++---
 fs/btrfs/transaction.c |  4 ++--
 fs/btrfs/transaction.h |  2 +-
 5 files changed, 23 insertions(+), 12 deletions(-)

-- 
2.26.3

