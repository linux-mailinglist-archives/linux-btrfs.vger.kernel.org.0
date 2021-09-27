Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159EE419DC8
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 20:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhI0SGz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 14:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbhI0SGz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 14:06:55 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E465C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 11:05:17 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id i132so38017850qke.1
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 11:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUTeVUgdBa15NmtRDgl/V82NQ3tMqAdg/Qw5fJ+yF1o=;
        b=cDG22THYh0RXNrOvsC9u6pliuYcASwg9CV0IXfuuoJxGcxa2O4SIIEhIQedQlPFgmY
         mJdjp9jlgsM9IfYVroXiDgTqskASg2oah1JvdELN73qiIqLl5/iD/0ogPipX2hLrP18k
         rNtcU60jTSpjyOIc4DEJLHDWWUq4UsfmUXp4U7pWtLvSRRFOeoSUsy54xHk8+Pr0mSTT
         3xrC26ZVY8r+6eIGtGTujvcnSyelPynlKQeuRXPc6gcrGxjcBxa0YIEC4Fl36iRehCC4
         Fb6RuA5hYcxO2IZ9khE5N+v9nHnXN6yxu+5ehTQ08uhc/cSlNh6K397VmVfe7zQO8+ol
         mZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUTeVUgdBa15NmtRDgl/V82NQ3tMqAdg/Qw5fJ+yF1o=;
        b=k7yUlZ0syd9ZYpvc3GZOBc7ZpT99LebjQXVGhI+3BfTyLgadLNR5Ef+ALspcp/olcd
         O7rpM+wWFK3yh50O5eZFCqsws+BoIDFzDAhP3tRgQQQtIkmjRRK7ao6GVWa9l9r6CnXN
         ctX6FuJZWA/vpTvxBf568UCark+IVyr3XeCzAEicjSfT/2Yw7WoTkttG/b9oQ5XblaNS
         eoUf0bn1CxYQcYR47TzGlJAvTR7rQQExttHFI+texWFh5DFPQdUUY0OKmTLnwM1dsfBI
         GC/hVswc4IRBhlFCTOB92UWmb4frTfEpDwX34rjPrB1blAuvF4k1tA8q24LzAbPXeQEv
         H5dg==
X-Gm-Message-State: AOAM533TD4w9xI5WgxV/u7pTrs2AT8GzJjsyReXXzJCk9sb803OB7fq4
        TRXV2vGyA2Lh7g3Lev8zYSdkEj5AJBSBtA==
X-Google-Smtp-Source: ABdhPJyq0XvvTPiHubjQ3aWy4qvq0IDtl6eX0glxzdB3JA8QYYDIK7BT5wBmelH6hODVGIsHsIutBg==
X-Received: by 2002:a05:620a:632:: with SMTP id 18mr1215889qkv.457.1632765916070;
        Mon, 27 Sep 2021 11:05:16 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p201sm10624955qke.27.2021.09.27.11.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 11:05:15 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 0/5] Miscellaneous error handling patches
Date:   Mon, 27 Sep 2021 14:05:09 -0400
Message-Id: <cover.1632765815.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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

 fs/btrfs/ctree.h       |  3 +++
 fs/btrfs/disk-io.c     |  8 +++---
 fs/btrfs/extent_io.c   |  2 +-
 fs/btrfs/file.c        |  7 ++---
 fs/btrfs/inode.c       | 22 +++++-----------
 fs/btrfs/scrub.c       |  2 +-
 fs/btrfs/space-info.c  | 27 ++++++++++++++++---
 fs/btrfs/super.c       |  2 +-
 fs/btrfs/transaction.c | 11 ++++----
 fs/btrfs/tree-log.c    | 59 ++++++++++++++++--------------------------
 fs/btrfs/tree-log.h    | 16 ++++++------
 11 files changed, 78 insertions(+), 81 deletions(-)

-- 
2.26.3

