Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A3D27756E
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 17:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgIXPdE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 11:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbgIXPc7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 11:32:59 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1F0C0613CE
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Sep 2020 08:32:58 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f142so3588550qke.13
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Sep 2020 08:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=14WCG2bu7Qg5v8RB8GP8f4cppGF0LRuMIRKnTLGhUac=;
        b=P9gSqx7d7T7MxoQnMpuainqpVmPluw0zb8hFM9txAo76M9po5/YVJIHoxMFsXwRdyu
         IvrBEWxtMXNeK0WZu0lyFNClcPCoCN84Kebt0LRtcNYSchXIdUhE8o/WIYbXoS7luUHk
         zzohjhOJVzwLpUL2KpSwcbdQfG/GrFG2P5+ON+f1Jjr0BDdYiwfjKFq0/iYBAn2Ns9Iz
         fxziFHv+wpcV71GSUO+FjfQ0JeJOx1uTB0XKTYhGSjw64mxwZvb2mx+RkFzRtir4ujam
         iPF95JX523Mazm2F0BenVzCyr/x3BYcrtXa9h9KsyT/C/C6N5fh6crP4nKgL7G/GSCzL
         LFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=14WCG2bu7Qg5v8RB8GP8f4cppGF0LRuMIRKnTLGhUac=;
        b=GTxYo8IhRs4HPeHjN/VSykJXGM+E22i1Am/RFfSgo0Gaoj2uy3wWhijQytYJ+G0m/T
         cEK8jC/V/E323idk9b+hDc53ef5/9Cp+FCoe4P0cIMc88ewnTi3b+GmDX8qwsi5QOQLD
         DwafhvwHFEC2ZBUDMHXL1+nvyPmQuUXGBID2OIRGEVEA45BYVVzAXLSnW9HmIcaAYD4W
         VDQiVeaIb0fPmOYfeGyokHxPdYhri/ZB9FDLr3gx1BxhbY9h1km3kUYc1EWjVj8Mtjb6
         l8TxYUeJ6fcsP/UQmxDnZtXaFurGtbLwVuNF4RnJhOM50qzjnJEA6pf+3BGKKENy6fiR
         cQIQ==
X-Gm-Message-State: AOAM531Lf/rSa7I751Tgz2U4jdKIp4KE3lv3QA9HR2PylSwxHCK8SzOD
        lkKJldACXKUiT40KOTNsZJ9vH8isnsSmlX49
X-Google-Smtp-Source: ABdhPJynFfILhn35XMOMmywec4dL3yHvBFzjywljQiO0L5iioekTz+n6bhK+7EPwihVk8I8cvs9pHQ==
X-Received: by 2002:a05:620a:958:: with SMTP id w24mr205510qkw.65.1600961576940;
        Thu, 24 Sep 2020 08:32:56 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s5sm2517793qtj.25.2020.09.24.08.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 08:32:55 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/5] New rescue mount options
Date:   Thu, 24 Sep 2020 11:32:49 -0400
Message-Id: <cover.1600961206.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

This is the next version of my rescue=all patches, this time broken up in to a
few discrete patches, with some cleanups as well.  I have a PR for the xfstest
that exercises these options, it can be found here

  https://github.com/btrfs/fstests/pull/35

This is the same idea as the previous versions, except I've made a mechanical
change.  Instead we have rescue=ignorebadroots, which ignores any global roots
that we may not be able to read.  We will still fail to mount if thinks like the
chunk root or the tree root are corrupt, but this will allow us to mount read
only if the extent root or csum root are completely hosed.

I've added a new patch this go around, rescue=ignoredatacsums.  Somebody had
indicated that they would prefer that the original rescue=all allowed us to
continue to read csums if the root was still intact.  In order to handle that
usecase that's what you get with rescue=ignorebadroots, however if your csum
tree is corrupt in the middle of the tree you could still end up with problems.
Thus we have rescue=ignoredatacsums which will completely disable the csum tree
as well.

And finally we have rescue=all, which simply enables ignoredatacsums,
ignorebadroots, and notreelogreplay.  We need an easy catch-all option for
distros to fallback on to get users the highest probability of being able to
recover their data, so we will use rescue=all to turn on all the fanciest rescue
options that we have, and then use the discrete options for more fine grained
recovery.  Thanks,

Josef

Josef Bacik (5):
  btrfs: unify the ro checking for mount options
  btrfs: push the NODATASUM check into btrfs_lookup_bio_sums
  btrfs: introduce rescue=ignorebadroots
  btrfs: introduce rescue=ignoredatacsums
  btrfs: introduce rescue=all

 fs/btrfs/block-group.c | 48 +++++++++++++++++++++++++++
 fs/btrfs/block-rsv.c   |  8 +++++
 fs/btrfs/compression.c | 17 ++++------
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/disk-io.c     | 74 +++++++++++++++++++++++++++---------------
 fs/btrfs/file-item.c   |  4 +++
 fs/btrfs/inode.c       | 18 +++++++---
 fs/btrfs/super.c       | 49 ++++++++++++++++++++++++----
 fs/btrfs/volumes.c     |  7 ++++
 9 files changed, 179 insertions(+), 48 deletions(-)

-- 
2.26.2

