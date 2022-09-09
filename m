Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F405E5B41B5
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiIIVxz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiIIVxx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:53:53 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722C3F651D
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:53:52 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id d17so1442578qko.13
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=ovWnR0jdmeH9upE9aYTrmLmDDTN65wNST0tgVo0wjag=;
        b=WVitx7DNS3grgs5EfFpPc4hRLGY5dnWb45ESxQ2fAQWntcF79452pakDFlbTfTbu2g
         thob3pBXGuhADMOtmcqZ9ZADF3Blb27U+JewHSRjlMT+3h0J74gI6derL+s/mrpjslFO
         dchOXLYd2W5S+MyOQwDlhR40S/S+JipZbAljbzGGFMft/G5cZUY6L+4x9LRbuqcRwkQr
         G65c3OhBFnSmNp+ogaaNW5q92AQcO16NO598DSXCCQ84/h1r3Ze/Z90y35sUI8MU4gaw
         ndiQd7Q4kFaynBfgpQG4+F26RCXiFzGEhoAMuIR9xHtBOtTdJLSpVAKyxo7sKCDa+c2o
         J+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=ovWnR0jdmeH9upE9aYTrmLmDDTN65wNST0tgVo0wjag=;
        b=zOtJdcv6qFJoa3V0N/gVkVPoUtyOcgkY9o5MrnFW6/0F27sq96tlKHJ4C+KpWkpt0C
         beJITHZv95ucjO4fdPQzfbvYLTkUcxNuEh5GVtIwtAzd2Mk56is4/hf60JnVXgVYcH6A
         1CfPBLPknwMGGgX0RTyMbYHI328TkTo7tF4wKdT7AzvcD/20SjdFrY7m3Lyh8Jlxnt6A
         Af3mVVAVOAVXQlBGEJTu1PHmbu2uERbuQyUEjQL6elcu1PzNraBiZT3am36x3xts+5SX
         r4sVbuoghZY0poG1Gmlb7kpkiRW70RVy3MHvgzZqcv2Iaunr9eM4wF7z6l7uM1G4lreS
         V0Bg==
X-Gm-Message-State: ACgBeo1PVGcApylx5pvS3JHCoxnqA1G/EhUp38Wre5Tye0Nznj/4u/Yn
        q7Hi2+cT+UaKv+jyfZ2ox2LP+u+ThZK54g==
X-Google-Smtp-Source: AA6agR4u9g1XFLu26Curwcl56f+FzUfjf01KS/6hk/OuNZTISmwKu19icLYXsDZ4zLBLH8TKUkQAbw==
X-Received: by 2002:a05:620a:4908:b0:6cd:d08b:64ac with SMTP id ed8-20020a05620a490800b006cdd08b64acmr3035762qkb.262.1662760431233;
        Fri, 09 Sep 2022 14:53:51 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m13-20020a05620a290d00b006b9815a05easm1336114qkp.26.2022.09.09.14.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:53:50 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 00/36] btrfs: move extent_io_tree code and cleanups
Date:   Fri,  9 Sep 2022 17:53:13 -0400
Message-Id: <cover.1662760286.git.josef@toxicpanda.com>
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

v1->v2:
- Addressed the comments.
- Broke up the giant move code patch up a bit by adding more exports and moving
  other things in chunks.  There's still a big code move patch, but it's 1000
  lines shorter, and not possible to shrink more without renaming functions.
- Fixed a problem that crept in from rebasing previously.

--- Original email ---
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

Josef Bacik (36):
  btrfs: rename clean_io_failure and remove extraneous args
  btrfs: unexport internal failrec functions
  btrfs: convert the io_failure_tree to a plain rb_tree
  btrfs: use find_first_extent_bit in btrfs_clean_io_failure
  btrfs: separate out the extent state and extent buffer init code
  btrfs: separate out the eb and extent state leak helpers
  btrfs: temporarily export alloc_extent_state helpers
  btrfs: move extent state init and alloc functions to their own file
  btrfs: convert BUG_ON(EXTENT_BIT_LOCKED) checks to ASSERT's
  btrfs: move simple extent bit helpers out of extent_io.c
  btrfs: export wait_extent_bit
  btrfs: move btrfs_debug_check_extent_io_range into extent-io-tree.c
  btrfs: temporarily export and move core extent_io_tree tree functions
  btrfs: temporarily export and then move extent state helpers
  btrfs: move a few exported extent_io_tree helpers to extent-io-tree.c
  btrfs: move core extent_io_tree functions to extent-io-tree.c
  btrfs: unexport btrfs_debug_check_extent_io_range
  btrfs: unexport all the temporary exports for extent-io-tree.c
  btrfs: remove struct tree_entry
  btrfs: use next_state instead of rb_next where we can
  btrfs: make tree_search return struct extent_state
  btrfs: make tree_search_for_insert return extent_state
  btrfs: make tree_search_prev_next return extent_state's
  btrfs: use next_state/prev_state in merge_state
  btrfs: move irrelevant prototypes to their appropriate header
  btrfs: drop exclusive_bits from set_extent_bit
  btrfs: remove the wake argument from clear_extent_bits
  btrfs: remove failed_start argument from set_extent_bit
  btrfs: drop extent_changeset from set_extent_bit
  btrfs: unify the lock/unlock extent variants
  btrfs: remove extent_io_tree::track_uptodate
  btrfs: get rid of extent_io_tree::dirty_bytes
  btrfs: don't clear CTL bits when trying to release extent state
  btrfs: replace delete argument with EXTENT_CLEAR_ALL_BITS
  btrfs: don't init io tree with private data for non inodes
  btrfs: remove is_data_inode() checks in extent-io-tree.c

 fs/btrfs/Makefile                |    2 +-
 fs/btrfs/btrfs_inode.h           |    3 +-
 fs/btrfs/compression.c           |   11 +-
 fs/btrfs/disk-io.c               |   10 +-
 fs/btrfs/extent-io-tree.c        | 1678 ++++++++++++++++++++++++
 fs/btrfs/extent-io-tree.h        |  119 +-
 fs/btrfs/extent_io.c             | 2054 ++----------------------------
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
 24 files changed, 2082 insertions(+), 2179 deletions(-)
 create mode 100644 fs/btrfs/extent-io-tree.c

-- 
2.26.3

