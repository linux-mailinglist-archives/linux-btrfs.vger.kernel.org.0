Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FE82DE9BA
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 20:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgLRTZO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Dec 2020 14:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbgLRTZM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Dec 2020 14:25:12 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B38C0617B0
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 11:24:31 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id 2so2062232qtt.10
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 11:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sg2T0E1ETa6NJ21izvJKZbt6eZ+gwjL1ovcdYG0ch+c=;
        b=ItGQywGX7+K2hsML21u3u2D4AWs6hCXNNmaxgBrVLgC81eH/8u3VodHoM7Ix0TD212
         PcAgcyn3J4ET7fsDgr28d8yuoB1h+hHHW6+jhB9enUBkyv4rfvqrx+O3ZnRO7UW74gJm
         AM7EWNlI3qcGEiA1HKXWWp5PSOT3+RPv1Va1p/22OFTOzCkYssQ4Be4rikUDRJR8gLEQ
         Ava7mVHD/yhQHM5jVam+ZvkD50VKpxRUGg9ir/wp3L3Aw8NfzYxxZGtBGOHdFc1aL+WY
         +kNouFXGYkFBbLcMTViJCPTwcorVqcKG+FbzgKXCb0w9x6JPgcWd1Tc1pu735iqCNXqU
         S5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sg2T0E1ETa6NJ21izvJKZbt6eZ+gwjL1ovcdYG0ch+c=;
        b=CqWJLWZbgAmw1fsT3n4X59QVp+5USd4ZXMkbN9qQS9W0tFGQn+YS7c8J5DSj3MsDoc
         J2hrHV2ioFKGQD1ap1VuXOTIR8fb59atZxpT60vHS529a7HbQd/sanlzsBWVnZMfWba1
         fm6oHDGzNsRlli9RwA7AP7QugnnJl4Qx+Mzxd2Y8jxz1YZYN7S3bbwVQJCgyaULQEyy0
         fCawK3vvYSwsM53naNXzyD9BgwlhpKU7RaGfqnRu2rRRo/bMjbwedzQmdm7O+bvYliHO
         8vNdh690Sq0AX1beP9fymnSDW+l/i1CMRQZVrmxUuVdc5xZ7zJlCZ2g8htxAEIx9c8x4
         m02Q==
X-Gm-Message-State: AOAM531sE7M5xbJPOOe6Or57D66sQ7skwDlsbsrt1EHr5YJzwlV602Hm
        6+FrGGxaGGrlk6TSWZfJtL34im+P8U7OsqDK
X-Google-Smtp-Source: ABdhPJw0bP6T6kRqB/oUaF5tS0fukd6U93fKgutS7uCwvkMldW5iLTkNaYN8gMPNzv1w0SKOWKp8lw==
X-Received: by 2002:ac8:44d8:: with SMTP id b24mr5342105qto.339.1608319468133;
        Fri, 18 Dec 2020 11:24:28 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y16sm3600756qki.132.2020.12.18.11.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 11:24:27 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 0/8] A variety of lock contention fixes
Date:   Fri, 18 Dec 2020 14:24:18 -0500
Message-Id: <cover.1608319304.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v4->v5:
- Added "btrfs: remove bogus BUG_ON in alloc_reserved_tree_block", as Nikolay
  pointed out I needed to explain why we no longer needed one of the delayed ref
  flushes, which led me down the rabbit hole of trying to understand why it
  wasn't a problem anymore.  Turned out the BUG_ON() is bogus.
- Added "btrfs: move delayed ref flushing for qgroup into qgroup helper",
  instead of removing the flushing for qgroups completely, we still sort of need
  it, even though it's actually still broken, so I've moved it into the qgroup
  helper.
- Added Nikolay's rb for the last patch.

v3->v4:
- I accidentally sent out the v1 version of these patches, because I had fixed
  them on another machine.  This is the proper set with the changes from v2 that
  are properly rebased onto misc-next.

v2->v3:
- Added Nikolay's reviewed by for the second patch.
- Rebased onto the latest misc-next.

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

Josef Bacik (8):
  btrfs: do not block on deleted bgs mutex in the cleaner
  btrfs: only let one thread pre-flush delayed refs in commit
  btrfs: delayed refs pre-flushing should only run the heads we have
  btrfs: only run delayed refs once before committing
  btrfs: move delayed ref flushing for qgroup into qgroup helper
  btrfs: remove bogus BUG_ON in alloc_reserved_tree_block
  btrfs: stop running all delayed refs during snapshot
  btrfs: run delayed refs less often in commit_cowonly_roots

 fs/btrfs/block-group.c | 11 +++--
 fs/btrfs/delayed-ref.h | 12 +++---
 fs/btrfs/extent-tree.c |  3 +-
 fs/btrfs/transaction.c | 91 +++++++++++++++++++++---------------------
 4 files changed, 60 insertions(+), 57 deletions(-)

-- 
2.26.2

