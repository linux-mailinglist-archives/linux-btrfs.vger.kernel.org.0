Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C294BC0BD
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 20:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238310AbiBRT4f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 14:56:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238042AbiBRT4c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 14:56:32 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0F2237FC
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 11:56:14 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id de39so9035253qkb.13
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 11:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gncN54881VSQOHWBzumHdaqQy7SoxRAIFdzPPWL3NlE=;
        b=zA3vBoT7fZMByjwDOwRAJcPGk/zRX69G0nbOjFgcAgZaLHk1S0/IsXLCPTLgHi5ziG
         9pqZT6Wy/okKXfL5hTCOvGseP+lb/4hPsOGKnqx5RdYeYSPvkrK8h5hHHEAhJI+bpx6K
         NjH+G+ERxX2bpYA5OHhKEDiadqa3Z5HLsZhJoCXRoFMO4u+HqBqkXuZjXeQpX/IuPuuL
         IVxhucWKy1paUzusgsochUHFZ1rvchg7LpwbljPqJMnTgJeAVuNJUa+Jc0z2ldgHDOOv
         gTC4im7jSNQfqMAaovqcco5Jx3AiBDQYxe0YVlBkXCSVGL0H27Tuc5ZeFgovnv1euLSY
         mohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gncN54881VSQOHWBzumHdaqQy7SoxRAIFdzPPWL3NlE=;
        b=y+SwUH6C/rIWhDc/2v6fMtBzOIyH2FSU1NQO+r8mLe2N4k205VQ/iyTTE+SlZKJZnM
         vQGy/HjBazegyDX3LOCJSNLyUePOzS+0cVj32ZdVkuwgxQVlXPLV3w7mJrYgP8yaFfD3
         v8ZBKpVN1HqZd5J582/T7o7s/MiNVny1pH3fORT931d9skcD+v/bEHA3WQ8XoQ7t9BWK
         3XhekGiZ4c/md+mfHeZ2f6QVq4LgBJlJY8VUr410fH29ROD94TuYGkCzaTpHm+Zi27zt
         MlbF38u1rfFo8+q2ZWBBZd72tI4UdBqBTlnuo5iw7IspcE7FZiv/UJea+t3i9uggOd8E
         Kd7Q==
X-Gm-Message-State: AOAM531+77uMl1sMmry2xI2jXvWkEu5g31qFIjDA2htMQQ+NSLb3rvud
        4WNrpzMfvPXXKI+9C6u4GudVPrV07UZX1m0g
X-Google-Smtp-Source: ABdhPJwZVujyDc38rZpfwGwbjO6zSBlkwjT3ot1u+ZN1209FJElnDjGqLOsQS8iD0+WtqeedBx1n+Q==
X-Received: by 2002:a37:644:0:b0:60d:eace:79c1 with SMTP id 65-20020a370644000000b0060deace79c1mr4668263qkg.744.1645214173801;
        Fri, 18 Feb 2022 11:56:13 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v19sm22981980qkp.131.2022.02.18.11.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 11:56:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/3] btrfs: fix problem with balance recovery and snap delete
Date:   Fri, 18 Feb 2022 14:56:09 -0500
Message-Id: <cover.1645214059.git.josef@toxicpanda.com>
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
- reworked the fix based on Filipe's feedback.  Instead of just doing all the
  snapshot delete at mount time simply keep track of any in-progress drops.
  Then gate relocation on those drops finishing.  Once the drops finish we
  unblock relocation and carry on like normal.

--- Original email ---
Hello,

I found a problem where we'll try to add refs to blocks that no longer have
references because we started a relocation while we had a half deleted snapshot
in the file system.  This only occurs on a clean mount with a pending snapshot
delete in place.  I saw this in production but lost the file system before I
could test my patch.  However I reproduced it locally with some error injection.
Without my patch we'd fail to run delayed refs with the warning in the commit
message in the first patch, with my patch we mount and can use the file system.

The other two patches are just cleanups that i noticed while messing with this
code.  Thanks,

Josef

Josef Bacik (3):
  btrfs: do not start relocation until in progress drops are done
  btrfs: use btrfs_fs_info for deleting snapshots and cleaner
  btrfs: pass btrfs_fs_info to btrfs_recover_relocation

 fs/btrfs/ctree.h       | 15 ++++++++++++++-
 fs/btrfs/disk-io.c     | 19 ++++++++++++++-----
 fs/btrfs/extent-tree.c |  7 +++++++
 fs/btrfs/relocation.c  | 19 ++++++++++++++++---
 fs/btrfs/root-tree.c   | 18 ++++++++++++++++++
 fs/btrfs/transaction.c | 37 ++++++++++++++++++++++++++++++++++---
 fs/btrfs/transaction.h |  3 ++-
 7 files changed, 105 insertions(+), 13 deletions(-)

-- 
2.26.3

