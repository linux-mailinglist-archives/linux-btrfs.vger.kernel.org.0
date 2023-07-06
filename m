Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F28749CF8
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 15:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjGFNHE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jul 2023 09:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGFNHD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jul 2023 09:07:03 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2C912A
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jul 2023 06:07:02 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5701e8f2b79so8672467b3.0
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jul 2023 06:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1688648822; x=1691240822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dXNiO9lMHJjjCXqjhfr1j8Vsw/h/mdE7ABBw1RGkAP4=;
        b=nFtK3nevIO43q9JHjZdDyH1/SB/aALBxlFuBVgeT+gzglsvHkklK/izefXIrb51Wej
         dRG+mWkua6SW1ghqGVbpdaU3pZauMXtaIgHN9WmvozNFqUXZ4Zp5cXiDyeX6kwAsgvWl
         yFyeZsWLoXjFewQbT8KksQ/hes0kcPsLsvCR8gS13ChxhhzJQeri4b9ni2XPhN3VXed4
         Yqh/Y2h2SM4N4+dSqzYAaTVzFRdeZAPMOszA0sk+HDQVr91G07IW5dpBSy7gNlg9Qsbd
         PKMoTk6n0rGBWBLgjTMy5gyLozwCk10I0bOmTytSwi3y0TUReMr5GmhykhWCJ5F1X0tU
         Um0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688648822; x=1691240822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXNiO9lMHJjjCXqjhfr1j8Vsw/h/mdE7ABBw1RGkAP4=;
        b=IWNSdUUv8bQfKNdvi3LkI8wvuIdPfM4IkoPQahbMbxRq8oZVfbHb0ivY2kbVUy72MO
         PY2Z4Ma0II0svkZLTBRnlBDdxMqSFFavgrq3Hw4yv52MzfFDkxXEUam6ZKvqTLDx50Kq
         32Oxon/sfOP3+uPZNnn6B+3Pf0CJjdC6fUceUHyfo/khJNd0TW72kXOx2YG5GPUMC5Sr
         2zuLumgZbwcw9QDC3L+LRJ0/ClLmXykHQO44a2Dy4L1AKB0JkeB7DyW8naMneCz6ojkH
         UmYACncM9nmbcN/IBMAcCkNOkH1CLq188XzzzdgEnhIFxKPV5pMM2uO6dZ7bJCBKb7lC
         yNMw==
X-Gm-Message-State: ABy/qLbiWBN7MSimNZOmAtsEcDJg/qviJFpmoVx3sfrE4APe6Eqjcswo
        ZnHCyUTePQ0mxBpsJ0PAPv9RVSbZE5WMEx9wizE4Tw==
X-Google-Smtp-Source: APBJJlGIqtQlVgqflk80ze06NpnwQdThoRPhCCbVyVV+8rLFHPJeTirBdCQAZ0Hpf8YKYrg1HfZ/6g==
X-Received: by 2002:a0d:c683:0:b0:576:cd51:1b10 with SMTP id i125-20020a0dc683000000b00576cd511b10mr2081385ywd.29.1688648821747;
        Thu, 06 Jul 2023 06:07:01 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id o128-20020a815a86000000b0055a21492192sm329429ywb.115.2023.07.06.06.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:07:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2] btrfs-progs: some zoned mkfs fixups
Date:   Thu,  6 Jul 2023 09:06:55 -0400
Message-ID: <cover.1688648758.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
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

I'm trying to get the zoned block device tests running and I ran into an issue
of a long running test because scratch_mkfs_sized failed and we tried to fill up
a giant fs.  Fix up the error message and the math so this is correct.  Thanks,

Josef

Josef Bacik (2):
  btrfs-progs: print out the correct minimum size for zoned file systems
  btrfs-progs: set the proper minimum size for a zoned file system

 mkfs/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.41.0

