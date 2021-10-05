Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5085D42321E
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 22:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbhJEUhV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 16:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhJEUhU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 16:37:20 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2878C061749
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Oct 2021 13:35:29 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id x8so518576qvp.1
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Oct 2021 13:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ggl+FsVKb6Rt782BY4LrJfuB9BIXQSLQkjh4dnXr4vo=;
        b=oeAQL8L7j9w/Ycr3kRT4vgauORfOf6DkHwq4iTHXI0lr7rUsdrCfGvB8C+cQ0uVKgV
         LkkAVrGZ3un/9+WYWMChUXBhfI8AKA/xmV83hXnpXB1JWv4Awa12c9j4k70UC86/GwLs
         W1DNSQuC3iILbdQFdwDm4yPJYOTvL008x8dK9bWMlP8kgV2H2/b+fRNka8sZQjrqSHFC
         HZabJWHHyCVLcGBokD6Vi6KMG7fnbPldKU45sTmw35ApTGo6/mj5Yf34lpRkXwD0m5bp
         ErcgrBzHQey51jT8BCK3TnmKaaslcVNqVBlqH10k274+Wgn7z1f4WbRxf7redVf5BLtW
         A5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ggl+FsVKb6Rt782BY4LrJfuB9BIXQSLQkjh4dnXr4vo=;
        b=ZiNUW0lL3dlXtFq3jXLXPJm0PKZeML1L70Lsj9bH/hYVXBETNw6lC0wXnJGqTijXRS
         eiICJIN3cXn59RU6TyjOA4CkzivEv/cAMGwlqPOqRSIvuzNMCIjeVwt3KjLsQ74+f6XM
         Iej0HRvdo8n1H6eogb5UNYwXi4JLP5a+EFgqm022UMiLL2lqLMaSx47/DxTBw/Q26+l2
         mCvJbGwhtKWTtG/5JBJ7ZwBBQWrO+SHwWWrrg/3czEVJWHyFpHspwMCVnQw7+1lSmFKP
         gfSXSQ3fY3QMF4526gaNA2l4qkC7V9t/MSt7cnyhT7YPhBczYIpBY2W98d+Ic3eOJns1
         r8zA==
X-Gm-Message-State: AOAM530ykR5k0QwgxinYGHnYQ21xfgg+Bgf8vz7zyPmESPW+5jf9or69
        MRIdXkpfsbjq7lBEV9QKAPYkb/V3nT+fIw==
X-Google-Smtp-Source: ABdhPJzHxSFU9nYjgXhhdqz794hwih1PWNacMLiWQAKwORiIir1U6g9OX6mIj/CH512dg+a5Birr1A==
X-Received: by 2002:ad4:46ab:: with SMTP id br11mr9593844qvb.33.1633466128773;
        Tue, 05 Oct 2021 13:35:28 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i11sm9770201qki.28.2021.10.05.13.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:35:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 0/5] Miscellaneous error handling patches
Date:   Tue,  5 Oct 2021 16:35:22 -0400
Message-Id: <cover.1633465964.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v3->v4:
- Added another abort() call that I missed in btrfs_recover_log_trees.
- Updated the commit message for 'btrfs: change error handling for
  btrfs_delete_*_in_log' as it pre-dated me figuring out there was a corruption
  problem in sync log.
- Fixed commit message for 'btrfs: add a BTRFS_FS_ERROR helper'.
- Made it so 'btrfs: do not infinite loop in data reclaim if we aborted'
  actually compiled, I guess my compile after rebase git hook didn't quite work
  as expected.
- Updated the comment in 'btrfs: fix abort logic in btrfs_replace_file_extents'.
- Rebased onto misc-next.

--- Original email ---
Hello,

This series is left overs from a few different series.  The error handling
patches look like they just got missed somehow.  The FS_ERROR helper has been
updated based on the comments from Dave.  I'm attaching this to the open GH
thing that I was looking at to update, but really just has the FS_ERROR helper
patch from that series.  Thanks,

Josef

Josef Bacik (5):
  btrfs: change handle_fs_error in recover_log_trees to aborts
  btrfs: change error handling for btrfs_delete_*_in_log
  btrfs: add a BTRFS_FS_ERROR helper
  btrfs: do not infinite loop in data reclaim if we aborted
  btrfs: fix abort logic in btrfs_replace_file_extents

 fs/btrfs/ctree.h       |  3 ++
 fs/btrfs/disk-io.c     |  8 ++----
 fs/btrfs/extent_io.c   |  2 +-
 fs/btrfs/file.c        | 18 ++++++------
 fs/btrfs/inode.c       | 22 ++++-----------
 fs/btrfs/scrub.c       |  2 +-
 fs/btrfs/space-info.c  | 27 +++++++++++++++---
 fs/btrfs/super.c       |  2 +-
 fs/btrfs/transaction.c | 11 ++++----
 fs/btrfs/tree-log.c    | 62 ++++++++++++++++--------------------------
 fs/btrfs/tree-log.h    | 16 +++++------
 11 files changed, 85 insertions(+), 88 deletions(-)

-- 
2.26.3

