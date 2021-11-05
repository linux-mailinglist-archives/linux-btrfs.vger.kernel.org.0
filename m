Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0ED446A20
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhKEUw3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhKEUw2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:52:28 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E46C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:49:48 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d21so8306034qtw.11
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/DPfnJUxTkmh321s7E6s5R1VJiA1DP6KdfhiPXFHJJc=;
        b=U1AxhP2aHQYMskO33gXL+sCVtuhg5IMfY3RONS9X5eg2GjhHwSnboLg8lfCO3p7r6/
         bW+l9h8ITaSX3Q3w+OwJe0XhFI0/LnFRxpN/nk4c9HvjHqtctRMs0on81JV/Q3RUtu86
         jylblkICPZCDdV7z1HGpIBe4uIID4ixweudZjT5y+5L0qfYR5Dm7WipJqbTV+ev4PQM7
         gJfl4upupVA3fWRAK6NjHPreOCJEHXp88ZVyRiIYX9TbrjnlMSgJM62Cpn0D4dyL5jap
         Noiis04dV8WNZ+rVI+D4QofC501/WQlksv0Ki2hzDY8gpx0Zk7N3O/gNt41Dh6b2v0Hh
         52AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/DPfnJUxTkmh321s7E6s5R1VJiA1DP6KdfhiPXFHJJc=;
        b=bZSxxJAgSgh0dD8XCGVOZyuVfDxG4VIRXSI5AqFOLu9qwfQSlkgMn23lA0MoGssw+C
         d5rF6+cIqD5Ag/fFFlO3satm6UEpMBO+mAOSnUPJHraJ2T1XZmm8bpnKe40KVLi20Bdq
         5Ae4TvpgZOQhs1P2iV1jl6bRqXsnEdsa/l0GLiK+OgJHUAlGm6Xmwbj8lyC7dAgIF8Og
         lYohcmErZ/jEVpSdW2JlJ2Ik2pxAZMPa6im0CMgF7nc1kmis4mwfHIwPG5huwxc9t5Wk
         DtmgXgTUuzijV/r10kiktZpGI9zp2XN/ickgJAnpvsFMMEoFjUjJkwoLIMNxIs1wfcal
         SuxA==
X-Gm-Message-State: AOAM530yenNC/q0SAJmydHPK84FzsL/fFZdFmNdPFvRBv5ELBv8h9e43
        Yav+JI88P4F3qxhq1kpO3PcfNszyhfvogA==
X-Google-Smtp-Source: ABdhPJwYfOO4NUyKaxpCftRbI/eqet6VsKxYnyypt81VfQXOLpXXpOpNmFeINW85TihkIdcxNHrWaQ==
X-Received: by 2002:a05:622a:2d6:: with SMTP id a22mr10045215qtx.220.1636145387147;
        Fri, 05 Nov 2021 13:49:47 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n18sm6871649qtk.91.2021.11.05.13.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:49:46 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/8] btrfs: extent tree v2, support for global roots
Date:   Fri,  5 Nov 2021 16:49:37 -0400
Message-Id: <cover.1636145221.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

This is the kernel side of the global roots and block group root support.  The
motivation for this change is described in the progs patches.  The important
part here is I've disabled qgroups and balance for now, this support will be
added back later.  I've also changed global block rsv size calculation, but it's
exactly the same result for !EXTENT_TREE_V2.  And finally there's the support
for loading the roots.  This doesn't panic and doesn't introduce any performance
regressions.  I've also hidden the support behind CONFIG_BTRFS_DEBUG so it
doesn't get used accidentally.  Thanks,

Josef

Josef Bacik (8):
  btrfs: add definition for EXTENT_TREE_V2
  btrfs: disable balance for extent tree v2 for now
  btrfs: disable qgroups in extent tree v2
  btrfs: use metadata usage for global block rsv in extent tree v2
  btrfs: tree-checker: don't fail on empty extent roots for extent tree
    v2
  btrfs: abstract out loading the tree root
  btrfs: add code to support the block group root
  btrfs: add support for multiple global roots

 fs/btrfs/block-group.c          |  11 +-
 fs/btrfs/block-group.h          |   1 +
 fs/btrfs/block-rsv.c            |  16 +--
 fs/btrfs/ctree.h                |  46 ++++++++-
 fs/btrfs/disk-io.c              | 178 +++++++++++++++++++++++---------
 fs/btrfs/disk-io.h              |   2 +
 fs/btrfs/free-space-tree.c      |   2 +
 fs/btrfs/print-tree.c           |   1 +
 fs/btrfs/qgroup.c               |   6 ++
 fs/btrfs/sysfs.c                |   5 +-
 fs/btrfs/transaction.c          |  15 +++
 fs/btrfs/tree-checker.c         |  35 ++++++-
 fs/btrfs/volumes.c              |   6 ++
 include/trace/events/btrfs.h    |   1 +
 include/uapi/linux/btrfs.h      |   1 +
 include/uapi/linux/btrfs_tree.h |   3 +
 16 files changed, 266 insertions(+), 63 deletions(-)

-- 
2.26.3

