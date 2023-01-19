Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C9567459F
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 23:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjASWOO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 17:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjASWNo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 17:13:44 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7472D9518C
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 13:53:28 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id a25so2716190qto.10
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 13:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qWkFyaZRfLTrbRJamJnTcpp/hFBWWE5jfxBH9Q3V52U=;
        b=78EEzVeB1uF0RjnGboZIvuvbHKWVY+SJbSp7nR+xjpV0asOP1yg7PFazqGeQlKOOZZ
         6cl96+tPz7WC0b6+3Qv6uFQHJgSoYmk37SbqGJ/ahmOx/dqX2lkiwOSqAP3/ncdc+GZq
         1mrqc7X2UMTn7YF/cC0zmwuGtV3ToQ8bQRjsc5FVp5W4a6iQDpqGZygoJct96oeNfEjy
         UOJ6LlrTsRkNvlcXKo4IqBhQH+u9iIgboN57x582jYb+sxdHoooknJMzclFOYDaEi8rv
         m/CmnXwMrQ5TfHsdOsEpXtckIkkleDtSvRkcNE4om4NJ9owaNN5apG9ANf2lJuVHhkhE
         I21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWkFyaZRfLTrbRJamJnTcpp/hFBWWE5jfxBH9Q3V52U=;
        b=3IHdI/KGX29rNes5R5vqzILaDtmF3E/nhtBDs6hEtDq6mXxeDXoa+uIccem7sbXaXu
         G/9wbHdVPqfM+U1cG25ATTSdhrctcZclKO54STf5z/zNVvoxOCStVoXRqZpqbIaKBn10
         o5wGS8sCISyCDmZ+hnAv+f4W+nwDnhggTEgLPH9dC8HddEGFMmIDjYjLf3Dbdd7p9wjg
         HGopCVTcyi2xY8SG5Xdl2LOk0v93gSNji5GJfAIuLiSNczLDikA4x/PQ2ycB1+dsbN9p
         e6SsC2xtTnNMgMM7HiuUt/gCUNbZKt7dlAqm4GXXqal/GcXv6biZnXzVDqttH2R2GM+T
         cLFw==
X-Gm-Message-State: AFqh2kq7+zv1HzcwvffKy3eeWRhpMAEWewhZ2SlmqorHE4bYfk/YXoJQ
        KRFhxcoyCBwzm5rKOVsMlsNbMAmuchMoxFPvs1w=
X-Google-Smtp-Source: AMrXdXv3aicXJvlDqCsLOmwAFVCS4EQRHEFJpmTsmWOHa+zux5jKNAcq1wzavMl48xLlwHWiG5J3wg==
X-Received: by 2002:ac8:4e39:0:b0:3b6:3af6:f2e1 with SMTP id d25-20020ac84e39000000b003b63af6f2e1mr17448285qtw.59.1674165206990;
        Thu, 19 Jan 2023 13:53:26 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id br38-20020a05620a462600b00706b09b16fasm4267254qkb.11.2023.01.19.13.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:53:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/9] extent buffer dirty cleanups
Date:   Thu, 19 Jan 2023 16:53:16 -0500
Message-Id: <cover.1674164991.git.josef@toxicpanda.com>
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

v1->v2:
- Added "btrfs: do not call btrfs_clean_tree_block in update_ref_for_cow", Qu
  noticed some corruption with the original patchset, this turned out to be
  because we were clearing the extent buffer dirty at cow time, which doesn't
  make sense as we're not free'ing the current block in our current transaction.

--- Original email ---
Hello,

While sync'ing ctree.c to btrfs-progs I noticed we have some oddities when it
comes to how we deal with the extent buffer being dirty.  We have
btrfs_clean_tree_block, which is sort of meant to be run against extent buffers
we've modified in this transaction.  However we have some other places where
we've open coded the same work without the generation check.  This makes it kind
of confusing, and is inconsistent with how we deal with the
fs_info->dirty_metadata_bytes.

So clean this stuff up so we have one helper we use for setting the extent
buffer dirty (btrfs_mark_buffer_dirty) and one for clearing dirty
(btrfs_clear_buffer_dirty).  This makes everything more consistent and clean
across the board.  I've additionally cleaned up a random writeback thing we had
in tree-log that I noticed while doing these cleanups.  Thanks,

Josef

Josef Bacik (9):
  btrfs: do not call btrfs_clean_tree_block in update_ref_for_cow
  btrfs: always lock the block before calling btrfs_clean_tree_block
  btrfs: do not check header generation in btrfs_clean_tree_block
  btrfs: do not set the header generation before btrfs_clean_tree_block
  btrfs: replace clearing extent buffer dirty bit with btrfs_clean_block
  btrfs: do not increment dirty_metadata_bytes in set_btree_ioerr
  btrfs: rename btrfs_clean_tree_block => btrfs_clear_buffer_dirty
  btrfs: combine btrfs_clear_buffer_dirty and clear_extent_buffer_dirty
  btrfs: remove btrfs_wait_tree_block_writeback

 fs/btrfs/ctree.c           | 15 +++++++-------
 fs/btrfs/disk-io.c         | 25 +++++-------------------
 fs/btrfs/disk-io.h         |  2 +-
 fs/btrfs/extent-tree.c     | 12 ++++--------
 fs/btrfs/extent_io.c       | 18 +++++++++--------
 fs/btrfs/extent_io.h       |  2 +-
 fs/btrfs/free-space-tree.c |  2 +-
 fs/btrfs/ioctl.c           |  2 +-
 fs/btrfs/qgroup.c          |  2 +-
 fs/btrfs/tree-log.c        | 40 ++++++++++++++------------------------
 10 files changed, 46 insertions(+), 74 deletions(-)

-- 
2.26.3

