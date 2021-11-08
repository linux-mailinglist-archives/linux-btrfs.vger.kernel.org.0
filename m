Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558F244980F
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 16:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238825AbhKHPYU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 10:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhKHPYR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 10:24:17 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D74C061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 07:21:33 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id bu11so12126393qvb.0
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 07:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VRm635UvLkadNMeupiaxXVuDFZWZuBLY5POcfy0uoAg=;
        b=5MkWm/gaJ4nY/zLoCKeFzsQNTIhRog/E1OU8cWRdVFDRU02Hz/vU9oa1C66xO7bYzb
         2RUBL3pVR3t7NIehk6/R+9heEYTI7nwkrR7Mx/h3fMzZ9m+pJJpOx/vw3rj2KWDUZT2h
         qQFNn6Jp/5qC2sgtwy0h+EgZFN9uLI0ctLw2w+OoZDwXoFFema0geHzONJbiltoJgtqu
         XpUawQYSrHykw/LCkKsCqfDWtNgdmVlKZ0s0lZKExyyyugolkg4VmihnEUVRLB+dxNBN
         dOiwLlrMlIcFKQ04Xe09EsUMpw5+TWA2bs1iODMI+kfm2Kn2P1Zg4AypR1ifwod3h0VR
         cicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VRm635UvLkadNMeupiaxXVuDFZWZuBLY5POcfy0uoAg=;
        b=33TVWW2xKpGqUnoYnm+I2kbW02y0iIT1Xyv/wbS7GDf6Jgq/UKllMv2ViduE8ZHOFY
         kigZiK4e16p3oEtufmgOePbbwvxh6W5Ng/6DMFaaVPhQC5cJSF9FEb/IO1CDlH1lxkYC
         JbyiBAoNfel5+vkjj3oNiC+SkJzeh2ZwBYN2w+VhBcn7sGI30F05eRas+CHU1JVFiVDT
         YKiSuh+CBzlqnm7DBv1+HZQv45uCYTbx+rP1Ip+oizu6400B1R8BujOu1pAwQuyF/qNb
         0YmT31yXzd4UEVmQBHuhnHzTYGzP+ErMF3daO1ZMt4awv7y0Wmz56xQ8Hst4/wFrmbMU
         ct1g==
X-Gm-Message-State: AOAM530xVsNxW/+S40IBtNPf1hgL2EpGm4bt5Klw0z8ajDsh+3C9h6TN
        2T8l26QesYTKyv33kgKS2Fm+GHuSyf6W9A==
X-Google-Smtp-Source: ABdhPJxyvjZrnA+xkHAYI8KTHdHqYjQH9etu15PGvaKy0/MuM43r8JLaY4cYr7dkHVbhCR5mYWdO3w==
X-Received: by 2002:a0c:e98a:: with SMTP id z10mr216281qvn.43.1636384892259;
        Mon, 08 Nov 2021 07:21:32 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bk11sm5193783qkb.32.2021.11.08.07.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 07:21:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/4] Use global rsv stealing for evict and clean things up
Date:   Mon,  8 Nov 2021 10:21:26 -0500
Message-Id: <cover.1636384774.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- Reworked the stealing logic to be inside of the priority metadata loop, since
  that's the part we care about.
- Renamed the helper to see if we can steal to can_steal.
- Added Nikolay's reviewed-by's.

--- Original email ---

Hello,

While trying to remove direct access of fs_info->extent_root I noticed we were
passing root into btrfs_reserve_metadata_bytes() for the sole purpose of
stealing from the global reserve if we were doing orphan cleanup.  This isn't
really necessary anymore, but I needed to clean up a few things

1) We have global reserve stealing logic in the flushing code now that does the
   proper ordering already.  We just hadn't converted evict to this yet, so I've
   done that.
2) Since we already do the global reserve stealing as a part of the reservation
   process we don't need the extra check to steal from the global reserve if we
   fail to make our reservation during orphan cleanup.
3) Since we no longer need this logic we don't need the orphan_cleanup_state bit
   in the root so we can remove that.
4) Finally with all of this removed we don't have a need for root in
   btrfs_reserve_metadata_bytes(), so change it to fs_info and change it's main
   callers as well.

With that we've got more consistent global reserve stealing handling in evict,
and I've cleaned up the reservation path so I no longer have to worry about a
couple of places where we were doing
btrfs_reserve_metadata_bytes(root->extent_root).  Thanks,

Josef Bacik (4):
  btrfs: make BTRFS_RESERVE_FLUSH_EVICT use the global rsv stealing code
  btrfs: remove global rsv stealing logic for orphan cleanup
  btrfs: get rid of root->orphan_cleanup_state
  btrfs: change root to fs_info for btrfs_reserve_metadata_bytes

 fs/btrfs/block-group.c    |  2 +-
 fs/btrfs/block-rsv.c      | 12 +++++++-----
 fs/btrfs/block-rsv.h      |  4 ++--
 fs/btrfs/ctree.h          |  9 ++-------
 fs/btrfs/delalloc-space.c |  2 +-
 fs/btrfs/delayed-inode.c  |  2 +-
 fs/btrfs/delayed-ref.c    |  4 ++--
 fs/btrfs/disk-io.c        |  1 -
 fs/btrfs/inode.c          | 21 ++++++++-------------
 fs/btrfs/props.c          |  5 +++--
 fs/btrfs/relocation.c     | 17 +++++++++--------
 fs/btrfs/root-tree.c      |  2 +-
 fs/btrfs/space-info.c     | 35 +++++++++++++++++++++++------------
 fs/btrfs/space-info.h     |  2 +-
 fs/btrfs/transaction.c    |  4 ++--
 15 files changed, 63 insertions(+), 59 deletions(-)

-- 
2.26.3

