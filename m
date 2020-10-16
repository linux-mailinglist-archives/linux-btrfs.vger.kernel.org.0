Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3810A2908E0
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 17:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410432AbgJPPwj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 11:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406328AbgJPPwi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 11:52:38 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6C9C061755
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:52:38 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id q26so1881917qtb.5
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Js0LxOI/Y5Cmr5/OQjs9BBq8uJirY5/9jGAF9zR+JzI=;
        b=hYLfhLcxUQYV1NM1/TXmaR3SFHnQFTd7T0hToW+d+8QUD4kWZQN4y6pWkHu38fBRzh
         ykan7bFDayyQK+FUHfExGxohOe4yu9dUT4QAdhhiltLfArjMFxIJ3wvVOCMBiOX3L8ZV
         REbMDfekKjTqpug9Xqi58Uz0uQ7I9RUAjcFoQMyFqBDuld6WoDRCskhqn7j3vux5HGjO
         p6YS3NhgoBUMojiGM3qqvbNeHWPNlh1mnDDekdpmR4vDO59kWsqsuJYAKRbmenSri2jf
         xE1YvU4rsaD7OlQU8Tgu0HmEV2/fDuzrVlfPxEMDrX5gLHHjdM6gbs3NWhAJeu5lNGYK
         C0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Js0LxOI/Y5Cmr5/OQjs9BBq8uJirY5/9jGAF9zR+JzI=;
        b=p+F8wRJTp2ClMQMACHmG+fTofvgWRBY5tcTZDrTjGbatRfC/Lbh6/yO9ESF3qtKKY6
         QoKEloPdkly+pJ5KMAL5g+2yH0//k4q9pkI0aX/P6ce98V2wIxP0AYoIt6BS3cEZgnSX
         n+KSYVZjUB6inMuSATg3/biduadMOYVq//5Tcn02TwOXAZJU0OqygbGWbowdSlQJik1v
         MPBds4HJhKvdGxB2cGBPst43Umr5keXqWYAIhScEAIgq1Iyw08NmeZQ6RnMAdRTajMvj
         CIqBaNaS07nfyjs6Z2VcgnYPLw6BVzOuObBZdQ0eDOLV0OTs9PLUNU47Z6NBwriIDG33
         5ClA==
X-Gm-Message-State: AOAM532MkKBPNerO9bYIKNC8Mk2v3Gf6qpx0dWwrzE97GdA+iyuFy2lJ
        fM1OeuAup3gIEEiRqZvH/L8sHqlSNw5m5wCG
X-Google-Smtp-Source: ABdhPJzmCR7nyg4nOCAgtRJbhoAsTd1oEyE577STgPrOAuAoP588QsoYLMTbID3GMzRRKnUFO4EXBQ==
X-Received: by 2002:ac8:162b:: with SMTP id p40mr3935032qtj.288.1602863557215;
        Fri, 16 Oct 2020 08:52:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r8sm997799qkm.115.2020.10.16.08.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 08:52:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/6] A variety of lock contention fixes
Date:   Fri, 16 Oct 2020 11:52:29 -0400
Message-Id: <cover.1602863482.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- Fixed the log messages that Nikolay pointed out.
- Added Nikolay's reviewed by for the first patch.
- Removed the unneeded mb for flushing.

--- Original email ---
Hello,

I've been running some stress tests recently in order to try and reproduce some
problems I've tripped over in relocation.  Most of this series is a reposting of
patches I wrote when debugging related issues for Zygo that got lost.  I've
updated one of them to make the lock contention even better, making it so I have
to ramp up my stress test loops because it now finishes way too fast.  Thanks,

Josef

Josef Bacik (6):
  btrfs: do not block on deleted bgs mutex in the cleaner
  btrfs: only let one thread pre-flush delayed refs in commit
  btrfs: delayed refs pre-flushing should only run the heads we have
  btrfs: only run delayed refs once before committing
  btrfs: stop running all delayed refs during snapshot
  btrfs: run delayed refs less often in commit_cowonly_roots

 fs/btrfs/block-group.c | 11 +++++--
 fs/btrfs/delayed-ref.h | 12 +++----
 fs/btrfs/extent-tree.c |  2 +-
 fs/btrfs/transaction.c | 74 ++++++++++++++++--------------------------
 4 files changed, 43 insertions(+), 56 deletions(-)

-- 
2.24.1

