Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964A2785A74
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbjHWO15 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjHWO14 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:27:56 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F81E54
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:27:55 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58d70c441d5so61774737b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692800874; x=1693405674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ldOkbB5s+l6X6VhlK4oL1is7O0L0mYdBZ5mFS+ALnQA=;
        b=XZuym4UcnpHecsTWEsdzHUlr3XFJChs6s4fcX7V5sElLqpnKElWGxLyTo3ZxIZgqEq
         U24CNGj9ZjhW2wSa6T92JRG9kRRobxQRw+7c6dv8jlJTA/Plfas9884cKk8WUt7oi1yg
         ICeKxzEznTKpqpCui0VLSEt7fWNAFefNaPgee9tBTdfBJASB9ragKaQISxi2uJso8UrR
         sR1+KBH4ABVPcfpBQBmLUAmmX9UsmBim3ABBGbOXG0pfndb5UheKSVZ2T9yAZ6H6w0kD
         VcEHBqQclpwe0RfYCreOUO739zzYZIuLcDBecIa5ADCzxxHIu6grY15dgAQ/V0nzXjmi
         Qcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692800874; x=1693405674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldOkbB5s+l6X6VhlK4oL1is7O0L0mYdBZ5mFS+ALnQA=;
        b=LcbDNfKrv4Z5lFjOI3NfL1//C8NbmGS3o0hkPXkaBN0VwMh1BYT/Ide/IxL1d088s9
         aJIe7/FJIjxyPdkyY9Y7A1+RB6jfSEKlS6ZbSFMd337rflGGBmhGEpNHOUale7NIcZxv
         cea4mMkoeh13VZTJ3DbkiBLwGmBecJKGrvTr7GHOdiTdv2fKGj+ijwvrraotJ/LbnOo7
         7+UtNnQRENPpChP4Nos9+PqhbqSJT1DH8rbLWsn6fA4lC3kXoD3arrt/Gwdst/+9csNm
         kKnfTXimNJe2USNz4xWjsWcw0AaZKMYSfDdYjm+2rOdLndiaGQbMojHY7C+ZIe8xWmTf
         xoXg==
X-Gm-Message-State: AOJu0Yx2RyvPACkT3I+Fo7SDMbajaUTCUQ+tjuZFjcQ7ZwPE/N8va8cR
        Awb4QMLZpvp7U+094UEl4EYmobu15NqO4kCWLa0=
X-Google-Smtp-Source: AGHT+IG5UoQhYAP7KfwsF6KMd0TJdMloxcizjrDOHGxHbD/Hb9xK0tZZETzYL924NEVMFKzQrnQAww==
X-Received: by 2002:a81:6d53:0:b0:583:9018:6fbb with SMTP id i80-20020a816d53000000b0058390186fbbmr14818893ywc.37.1692800874308;
        Wed, 23 Aug 2023 07:27:54 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i128-20020a0ddf86000000b0056974f4019esm3353464ywe.6.2023.08.23.07.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:27:53 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/3] btrfs-progs: a couple fixes
Date:   Wed, 23 Aug 2023 10:27:47 -0400
Message-ID: <cover.1692800798.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
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

Hello,

These are a set of fixes that I needed for the ctree sync to work properly, and
one fix that was just broken in general.  They apply cleanly to devel and should
be straightforward enough.  Thanks,

Josef

Josef Bacik (3):
  btrfs-progs: take a ref in the root locking code
  btrfs-progs: clear root dirty when we update the root
  btrfs-progs: fix improper error handling in btrfs filesystem usage

 cmds/filesystem-usage.c     | 8 +++-----
 kernel-shared/locking.c     | 3 +++
 kernel-shared/transaction.c | 2 ++
 3 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.41.0

