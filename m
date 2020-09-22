Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B98274B03
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 23:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgIVVSe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 17:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVVSe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 17:18:34 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500A0C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 14:18:34 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id di5so10287952qvb.13
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 14:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EsHLPxGdgCgXpCF0fyQF7gMybMQes2XlTh0V6qgHp6I=;
        b=N5mpuHbMK548UHjF2GjgqWLy9DsJXav2qUwHwPigpH3cbERZW1hvbxqFXF33+cL+sE
         ct2bOFNIU1ZuXZbZi4stx7BjpBjQev3ld6tzGZkMs1COBuuBQFKSrvIgqN2CBJg000r6
         X0PlywCBhtzfEwumXHhlni8UNZVNfTEwzZLPDqhKWtTrwR8Tsmr9lm3zKiJGv+PHY752
         8xLGR/otunI27xXDSS2EVb0BLIAhNKV/Bl5vm3ex/a6Av/0pXCRSiVqj65P3CquSYwJt
         +4WnT2efOzRq2u7deQq+pu3d+mAu4+z1XMo5FZ/wD+GOspom8zr9KlV7q+tQWV2p/qNu
         KKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EsHLPxGdgCgXpCF0fyQF7gMybMQes2XlTh0V6qgHp6I=;
        b=QPEkhlSyRtpPGbRPmlh2L7XSr9EggavVMQguYin0vtgR2KmaORG7lNvkNjkvxzPJsR
         AZMh+DiB7NdZ8DvacvcuGuABXfIyNoSQSakHRH4omq99SpdWOqyJwzhU/SJCI4Rn5Kpx
         cVa2E89KlWcTVGrExTQdGvCJVi8zcZWM8GeD3f/KDHD/9S9SZSu52n+xjOQmpMCl5SXt
         o7GkWNGmTTz2YRvNErXb11nmDd1YZm2Qd6UQqCzHHrb3zXWcW19RGx9G5oUD8gb+3Qdt
         N6+rtiSqUc5bkqNZgSTgBH+ZR0BnZWah9iv86MZKPzzepNCYmDML6Mo95a9sDdsn/p01
         +FeQ==
X-Gm-Message-State: AOAM531YvwiSfzQ0tHJRWauTcD/Wc/CgpDkUVUDVFzRb2ut3aazU5tb4
        iazeuC3a8bCTvGnzbOGMUV2LYhTPWW3h37A1
X-Google-Smtp-Source: ABdhPJxsUn+jDygQsOx6bH3MW2NqeQLtioRSaUqYC9MDAmKDqsyYGsQ7isCNKSJR0JM16YJIyEasKw==
X-Received: by 2002:a0c:8064:: with SMTP id 91mr8274037qva.34.1600809512913;
        Tue, 22 Sep 2020 14:18:32 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 15sm11946316qka.96.2020.09.22.14.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 14:18:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 0/2] Fix init for device stats for seed devices
Date:   Tue, 22 Sep 2020 17:18:28 -0400
Message-Id: <cover.1600809318.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2->v3:
- fixed the name and arguments in the first patch.
- use goto out for the error case with seed devices.

v1->v2:
- Rework initial fix to work with the new seed_list.
- Add a follow up patch to address the fact that we were ignoring errors on
  reading the device tree.

Hello,

We see a lot of messages in the fleet where we use seed devices because we're
not init'ing the stats for seed devices properly.  I have an xfstest that shows
this (which I need to update), and this patch fixes the problem.  It's
relatively straightforward, simply init the stats on seed devices at the same
time we init them on our primary devices.  Thanks,

Josef

Josef Bacik (2):
  btrfs: init device stats for seed devices
  btrfs: return error if we're unable to read device stats

 fs/btrfs/volumes.c | 93 +++++++++++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 39 deletions(-)

-- 
2.26.2

