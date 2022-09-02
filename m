Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DE85AB94B
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiIBUQ5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiIBUQx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:16:53 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EF7DAEF1
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:16:40 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id cr9so2324849qtb.13
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=HQL/8uY1z9MwiIcKW+FEa28PiwRxgGSc0LdbXMGJHaw=;
        b=dOuF0Spvpz7KLrdLnDyThGALd4v2ibQoLxp1Q7f/AiN3kq1m8gsYGEQhcVT/4z6ldd
         zbmRfzpFP3FFb7aEN1DptDXLySoTWoDYldRiTJToUfH+t1/aCX4DQU6o/8MPz9lcLgCh
         ++3L0H9W3eP6iUz2VtBfYlhAkwiAC1wp0IFTvdAgcehFGniVchRZZIhL4e55Ks9LIAvV
         3dI32Iic4ZyYjzK/YDQfGD8VyN0bYbKUlLpNmE55eTebA2qclswCYJrpryfy7QOmOZ1S
         Ji+yUocvXG3uOyOGqt+voZtQ1xqdMtHHI4pLw1C84AS+/IptqlS/JjbS37MBXd29l1hA
         B5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=HQL/8uY1z9MwiIcKW+FEa28PiwRxgGSc0LdbXMGJHaw=;
        b=FUJHg4DHv8Q1+RKwuTWW4WHA9g6K7LsQs28y7zkMTCH1Tp7qgsOWgXzgseHV5E089J
         31KINqu1EZSEEaW2r/+Ysqc107ub6FdypNDR+rhf0OGRkN/XG14FrZwcbDnzyooBkn3F
         Q0gCADJ0454OGYr24WcY0i5kk2k+csweXx56/WgZ0Or3wurEExijvCPm5s2LKKu7QKlu
         kBm8Mu/Chuu4ozay4/FPx5KSMdXiFFCCHXmd5raKWPoiYcPm9igIhycdHzsvdfGWLJwO
         RoZv8vqiRFbf/b/tBED44/TefYDZKKJxo2UXPgsiNj6cSrK58M9rY3SANjzTvv073Zd9
         1OhQ==
X-Gm-Message-State: ACgBeo25mhxChwPcfdrFQAGRFD95OwHf0xoGDa9Dd7fQRN61rCIDzl+L
        bV/ZQkzHDmKv1xKghaWggOe4s/85SM1e4g==
X-Google-Smtp-Source: AA6agR57JeUA6HT8fjtWSMmpTB2Edw5lhGS6vr3TV75BWV/XKdvR2ddAKkVEKh+6sBAr43sJmbJ5mA==
X-Received: by 2002:a05:622a:138f:b0:344:4ff1:f98f with SMTP id o15-20020a05622a138f00b003444ff1f98fmr29175958qtk.59.1662149798812;
        Fri, 02 Sep 2022 13:16:38 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e5-20020ac80105000000b00342b7e4241fsm1575702qtg.77.2022.09.02.13.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:16:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/31] btrfs: move extent_io_tree code and cleanups
Date:   Fri,  2 Sep 2022 16:16:05 -0400
Message-Id: <cover.1662149276.git.josef@toxicpanda.com>
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

In working on extent tree v2 I got really bogged down in trying to sync work
between btrfs-progs and the kernel.  It basically takes me 3x as long, because
there's a lot of different things missing in btrfs-progs, so each patchset has
to be done from scratch and tested completely differently.

Additionally there's just a lot of tech-debt in these areas in general.  So
before tackling the rest of extent-tree-v2 I'm spending some time cleaning up
things we all know are terrible.  This is the first step in that direction,
finishing the separation of the extent_io_tree code from extent_io.c.  I started
this a while ago, but got bogged down in other things.

This has 3 distinct parts

1. Cleanup the io_failure_record code.  This has been tightly integrated into
   the extent_io_tree code forever without much reason for it.  The first part
   of this series moves that handling into it's own tree, and uses our existing
   helpers to reduce the code quite a bit.

2. Move the code out of extent_io.c.  This is easier than previous code moves
   because I did a lot of the prep work earlier.  Unfortunately there is one big
   patch that copy and pastes all the core code, since it all depends on itself
   and would be more annoying to move.  However the independent parts were
   moved piece by piece.

3. A wholesale cleanup of the extent_io_tree code.  We have a ton of helpers
   here, that have all grown a ton of arguments over the years.  I've trimmed
   down the arguments for our core helpers, and hidden the rest internally
   inside of extent-io-tree.c.  Additionally I've cleaned up the lock/unlock
   extent bit helpers so we only have one lock_extent/unlock_extent variant that
   gets used everywhere.

I've tested this locally to make sure I didn't break anything.  This isn't a
simple code move so do please review most of it, the patches that start with
"move X" are pure code move patches, but the rest do change things.  Thanks,

Josef

Josef Bacik (31):
  btrfs: cleanup clean_io_failure
  btrfs: unexport internal failrec functions
  btrfs: stop using extent_io_tree for io_failure_record's
  btrfs: use find_first_extent_bit in btrfs_clean_io_failure
  btrfs: separate out the extent state and extent buffer init code
  btrfs: separate out the eb and extent state leak helpers
  btrfs: temporarily export alloc_extent_state helpers
  btrfs: move extent state init and alloc functions to their own file
  btrfs: convert BUG_ON(EXTENT_BIT_LOCKED) checks to ASSERT's
  btrfs: move simple extent bit helpers out of extent_io.c
  btrfs: export wait_extent_bit
  btrfs: move the core extent_io_tree code into extent-io-tree.c
  btrfs: remove struct tree_entry
  btrfs: use next_state instead of rb_next where we can
  btrfs: make tree_search return struct extent_state
  btrfs: make tree_search_for_insert return extent_state
  btrfs: make tree_search_prev_next return extent_state's
  btrfs: use next_state/prev_state in merge_state
  btrfs: remove temporary exports for extent_state movement
  btrfs: move irrelevant prototypes to their appropriate header
  btrfs: drop exclusive_bits from set_extent_bit
  btrfs: remove the wake argument from clear_extent_bits
  btrfs: remove failed_start argument from set_extent_bit
  btrfs: drop extent_changeset from set_extent_bit
  btrfs: unify the lock/unlock extent variants
  btrfs: get rid of track_uptodate
  btrfs: get rid of ->dirty_bytes
  btrfs: don't clear CTL bits when trying to release extent state
  btrfs: replace delete argument with EXTENT_CLEAR_ALL_BITS
  btrfs: don't init io tree with private data for non inodes
  btrfs: remove is_data_inode() checks in extent-io-tree.c

 fs/btrfs/Makefile                |    2 +-
 fs/btrfs/btrfs_inode.h           |    3 +-
 fs/btrfs/compression.c           |   11 +-
 fs/btrfs/disk-io.c               |   10 +-
 fs/btrfs/extent-io-tree.c        | 1673 ++++++++++++++++++++++++
 fs/btrfs/extent-io-tree.h        |  119 +-
 fs/btrfs/extent_io.c             | 2055 ++----------------------------
 fs/btrfs/extent_io.h             |   14 +-
 fs/btrfs/extent_map.c            |    2 +-
 fs/btrfs/file-item.c             |    2 +-
 fs/btrfs/file.c                  |   48 +-
 fs/btrfs/free-space-cache.c      |   24 +-
 fs/btrfs/inode.c                 |  159 ++-
 fs/btrfs/ioctl.c                 |   24 +-
 fs/btrfs/misc.h                  |   35 +
 fs/btrfs/ordered-data.c          |    4 +-
 fs/btrfs/reflink.c               |   10 +-
 fs/btrfs/relocation.c            |   18 +-
 fs/btrfs/super.c                 |   17 +-
 fs/btrfs/tests/extent-io-tests.c |    6 +-
 fs/btrfs/tests/inode-tests.c     |    8 +-
 fs/btrfs/transaction.c           |    4 +-
 fs/btrfs/tree-log.c              |    8 +-
 include/trace/events/btrfs.h     |    1 -
 24 files changed, 2077 insertions(+), 2180 deletions(-)
 create mode 100644 fs/btrfs/extent-io-tree.c

-- 
2.26.3

