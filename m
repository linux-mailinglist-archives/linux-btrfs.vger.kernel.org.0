Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B664654F7
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352192AbhLASTK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbhLASS7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:18:59 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D73C06175E
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:15:13 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id a2so24924037qtx.11
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PEI6WPJVm0kn/wbKWgwbnR5TW1ihu3nmXXC6fIivS6s=;
        b=2Q4+IXMr9+NRrORdh8+wZVkFBc3pO79oxtIutvfDSU5fblTM4CtG+b4ehJO0lJkEzb
         nji4HEIEUwg8DtmX+UpGvU7h9sUCiJqNkD7/IDFk2NCuM1HYeYCJTrkzDF7Qh06N2//9
         PJRpKpGFdCrL8blOXV33x8JSKGijzp3i5Vw0WthyROSN3IUMT2z9f/CxjAufi9yaiP11
         glKNU9jTlypiABIOoN1uW6InhdldmbqkuU5C+Orqw8ufok+TERAHvMzmnKWu/m+K4JXh
         NJeUwIcpJ/IvJndEPLBA4/TjYUqj2zxINuNAddT0b6OqNY9npdlJuCvwWweskMQEgzRZ
         hC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PEI6WPJVm0kn/wbKWgwbnR5TW1ihu3nmXXC6fIivS6s=;
        b=GfBANEoZfY30yEQ9kpk/ywxc1Oy04t6rrpzPCpLkwfWAx1TktJIf+iOSFxlVpmw+PH
         Z9Moo9QVBuqWGzEOjtt8fydKj2USIERP2TjAdlUaftY01iNep7jWWBL003cvpNuKXsL0
         znIG7H5zojxwiZSshQD+wEEaYDqqCd/X7KBAFmkmvpHdERLXDXWbrfD55LCicvu7s49k
         fzCciMgH+plI1MQtmcAOgJ//jvNG9rX9eC2g6WxYqUU43cYgs5bZ0aUOR0lCdFZm6wXr
         rFVkt0Ims4s2c1DudV2VtwEA2geRInOMUafY53DMcLCx5FpTyuDi2xpWQ6DGlP6vNc/T
         u72A==
X-Gm-Message-State: AOAM533AMgA2isVCy7Yav6YyjlwGSYcrFIKLFuhrDh8e25QZGG4QqXJ/
        gEcSX4AEVW2Labteiu3qAHD0Blk2CbAZOw==
X-Google-Smtp-Source: ABdhPJyGo+/hpiF4xvaE4QUQ0TBTUCEvLNGuMB5a7GHv22yflg7b2nXbkWAYofAAjlaN6EFJLI+kgw==
X-Received: by 2002:ac8:5b83:: with SMTP id a3mr9009086qta.62.1638382511958;
        Wed, 01 Dec 2021 10:15:11 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k19sm268847qko.73.2021.12.01.10.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:15:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 0/8] btrfs-progs: extent tree v2 global root support prep work
Date:   Wed,  1 Dec 2021 13:15:02 -0500
Message-Id: <cover.1638382443.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2->v3:
- rebased onto origin/devel, these somehow got missed when merging the series.

v1->v2:
- reworked the root node helper thing to check the level as well as per Qu's
  suggestion.
- Fixed a place where we weren't inluding common/repair.h to get a helper that I
  moved (not entirely sure how this still built but whatever.)
- Fixed a place where I could get fs_info from an eb instead of passing it
  around.

--- Original email ---
Hello,

This is a series of patches to do all the prep work needed to support extent
tree v2.  These patches are independent of the actual extent tree v2 support,
some of them are fixes, some of them are purely to pave the way for the global
root support.  These patches are mostly around stopping direct access of
->extent_root/->csum_root/->free_space_root, putting these roots into a rb_tree,
and changing the code to look up the roots in the rb_tree instead of accessing
them directly.  There are a variety of fixes to help make this easier, mostly
removing access to these roots that are strictly necessary.  Thanks,

Josef

Josef Bacik (8):
  btrfs-progs: stop accessing ->extent_root directly
  btrfs-progs: stop accessing ->free_space_root directly
  btrfs-progs: track csum, extent, and free space trees in a rb tree
  btrfs-progs: check: make reinit work per found root item
  btrfs-progs: check: check the global roots for uptodate root nodes
  btrfs-progs: check: check all of the csum roots
  btrfs-progs: check: fill csum root from all extent roots
  btrfs-progs: common: search all extent roots for marking used space

 btrfs-corrupt-block.c           |  13 +-
 btrfs-map-logical.c             |   9 +-
 btrfstune.c                     |   2 +-
 check/main.c                    | 202 ++++++++++++++++------
 check/mode-common.c             |   8 +-
 check/mode-lowmem.c             |  72 ++++----
 check/qgroup-verify.c           |   2 +-
 cmds/rescue-chunk-recover.c     |  18 +-
 common/repair.c                 | 143 ++++++++++-----
 common/repair.h                 |   2 +
 convert/main.c                  |   4 +-
 image/main.c                    |   2 +-
 kernel-shared/backref.c         |  10 +-
 kernel-shared/ctree.h           |   4 +-
 kernel-shared/disk-io.c         | 296 +++++++++++++++++++++++++-------
 kernel-shared/disk-io.h         |   6 +
 kernel-shared/extent-tree.c     |  42 +++--
 kernel-shared/free-space-tree.c |  54 ++++--
 kernel-shared/volumes.c         |   3 +-
 kernel-shared/zoned.c           |   2 +-
 mkfs/main.c                     |  30 ++--
 21 files changed, 651 insertions(+), 273 deletions(-)

-- 
2.26.3

