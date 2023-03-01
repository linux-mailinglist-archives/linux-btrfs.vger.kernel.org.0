Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0D86A75FD
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 22:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjCAVOz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 16:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCAVOs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 16:14:48 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C56946160
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 13:14:47 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id nv15so10271888qvb.7
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Mar 2023 13:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112; t=1677705286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NTSTo6EBIQINGEGh6QFyFzhqv8BzuNYqjtgjxzB2kog=;
        b=HOAt/K3kPQwMqSTyj293r/Sno5k/X3P87a0Owe06b6Qiq/sNoFgLq2oHAxB1C6Orfm
         vc7X1FbMcnAUK5//ey1e5mqrZ4gTyV6A/Cxpy5pZTmB2icHxdeEzHjKmxSFI5f0lWwp9
         DXgpWw8lDS7G9vtpkCZ4+X5l2C/R0/cRCHHLKkeAh+7eMmiifBUwTJKf4fl08COZpFvc
         QAYrIYP6dkc7l2O4nBcF+gdjbB+5gX2XFixbueSnhMXh0QMy++E36cCniuJ+AI+6dEQw
         MdkpSK/qT+s+7uKgg3yHWzgdHLLbOQRqkIKA7W1zFKCwxqTklg8dDmY7lDU00TnhfJoB
         gOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677705286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTSTo6EBIQINGEGh6QFyFzhqv8BzuNYqjtgjxzB2kog=;
        b=lG/HjgFCISm2d0f/NxAcg/OQLj900EUl8sYCn3ct6Vc6WfnDWMCJ1vfFUZPWQHj0S4
         6KV7rzlHd1NgJBHJwHV/1C8hawmm+BV72X+pFEaYWPoKfRIuL/QXcTeFoL/Gx+YlVlFV
         7lu8CVe4z6muA68fix50h0yCE5W7L0dcnSxF/IAgcMLVk2Z2f/z5LiXqGrkLDqJJ/4Mc
         DDkBScOoGWGRSHHm/9Bq+rb5ISwXFgL4I31+8dF0WzPWjO1tTXD3mH4t8yE7hK1jkDth
         IC79DgRglUu8hP3RUZPevCZBWXwChxemIRI+7ZXB9b53kI2oqfXGfv75bsm2/ojpRsu8
         TBdA==
X-Gm-Message-State: AO0yUKUy5FH/w/Aa7NbYm0QkkW6NUlfn/3A55iweuFHopHfjo24w7d6h
        0ain7f0ss8832nkgW+CQqKSsxnSVVT4bZRvGWNM=
X-Google-Smtp-Source: AK7set+grCGzRdxdb4LPZIMHunAU0Cm5IbWv0J5CB4eNtft492FwOmIy9FkQ+kQUGi5Ropmpi0mWSg==
X-Received: by 2002:a05:6214:21aa:b0:56e:b5a1:b521 with SMTP id t10-20020a05621421aa00b0056eb5a1b521mr12887731qvc.51.1677705286236;
        Wed, 01 Mar 2023 13:14:46 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id g186-20020a37b6c3000000b007430494ab92sm325104qkf.67.2023.03.01.13.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 13:14:45 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/3] Fix active zone accounting for zoned
Date:   Wed,  1 Mar 2023 16:14:41 -0500
Message-Id: <cover.1677705092.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

While trying to get the CI system up and running with the ZNS drives I ran into
this issue where the TEST_DEV would get maxed out on block groups and everything
would start failing with -ENOSPC.

This is because the way we handle active zone tracking isn't correct.  We need
to only take into account the used/pinned/zone_unusable counters for the active
block groups, not the system wide counters.

Unfortunately this is kind of annoying in that we have to mirror these counters
for the active block groups.  At this point this is the most straightforward way
to fix this.  I'm currently running these patches through xfstests, so consider
this as sort of an RFC to make sure the approach seems reasonable.  Thanks,

Josef

Josef Bacik (3):
  btrfs: rename BTRFS_FS_NO_OVERCOMMIT -> BTRFS_FS_ACTIVE_ZONE_TRACKING
  btrfs: clean up space_info usage in  btrfs_update_block_group
  btrfs: handle active zone accounting properly

 fs/btrfs/block-group.c | 51 ++++++++++++++++++-------
 fs/btrfs/disk-io.c     |  6 +++
 fs/btrfs/extent-tree.c | 13 +++++++
 fs/btrfs/fs.h          |  7 +---
 fs/btrfs/space-info.c  | 85 +++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/space-info.h  | 20 +++++++++-
 fs/btrfs/zoned.c       | 17 ++++++---
 7 files changed, 168 insertions(+), 31 deletions(-)

-- 
2.26.3

