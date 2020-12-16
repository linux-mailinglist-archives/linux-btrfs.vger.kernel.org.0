Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15082DC3F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgLPQXA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgLPQXA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:23:00 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A619C061794
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:20 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id p12so11573633qvj.13
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=957c2MNMHZEkmyNgRZ3Iw7PumVOFl22FI/H+v9w06A4=;
        b=jq31Axs9BFsrDf1hEClkXxUfnVMYs8gu4Iv+EkWtq8/CeiEhzUOCD8bTz/hjCjA9a9
         CYb69VGzEdq/k4cJbH5BfhmVOR3w+w3bEcLlHvhBjZIn4qoSbu035EbzNreFtXHgFxIf
         MX8TcPFg+8dnczn5ntZejTW2+wdBn9psrbwh4xvL+y1h4DxwnM+RXF2N31FZObz+1Uum
         oKL2s2Wr4tXD7z9fX7tZPCaI3MVk8fkNueN/jAW1V1LiL7+Vi3TXoZnFdk8Q7ehaVbHW
         VjrPIB26qk2NUFP/TW82770zbd7Ff2qvagyC2QRKiom5j3Hq7qR/y49Sy9P/ceYFUWwP
         n4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=957c2MNMHZEkmyNgRZ3Iw7PumVOFl22FI/H+v9w06A4=;
        b=fWiEEYdNf7BpGxNjlYsAkW8sz8B+Z4j/0/5j8+dP/P2S1633Acs3NP94A9cyQ3Rstu
         gcFb7HbSynIsEA/bypEWH7b+2R92zBysBJWfaj7oVQ6PIC0V6pKft+YyIMmWc89dCH2M
         YxM/QA+8DweRCtdwsDw+dTiuDrq+mo13/CllmNvi4uA1mIXoxPY6HtBZ0RalDdae3Cmv
         fFqYFDBuGjC16iVyHJKzaY8ttPXzIbboiVJ65EyJHGm/DSIxsiV+ZkPzPU6yWSpYEkxD
         GdFyDGHuHCKRsfnSvwZUhklVTW2bwor8WMpkixZn96Usn+EgCvRJ5RmV660IxXDFYHzj
         exrg==
X-Gm-Message-State: AOAM533ApS1dGiRy4u+JugHNSiPXltyZfgOD9/YobrLpvHIgcAXiKUQw
        oBvspk0ETbzcgvLSbt8Rah4W0qLD3+OMDcwe
X-Google-Smtp-Source: ABdhPJwxiuTNPEKgsD5QZ2gVgUTls3iQV3T56QjQyosUkothyLBX4fta7X7Fjn+QKc+0EIkaTivYXg==
X-Received: by 2002:a05:6214:4e2:: with SMTP id cl2mr43757683qvb.27.1608135739039;
        Wed, 16 Dec 2020 08:22:19 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o29sm1266862qtl.7.2020.12.16.08.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:22:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/13] Serious fixes for different error paths
Date:   Wed, 16 Dec 2020 11:22:04 -0500
Message-Id: <cover.1608135557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

A lot of these were in previous versions of the relocation error handling
patches.  I added a few since the last go around.  All of these do not rely on
the error handling patches, and some of them are quite important otherwise we
get corruption if we get errors in certain spots.  There's also a few lockdep
fixes and such.  These really need to go in ASAP, regardless of when the
relocation error handling patches are merged.  They're mostly small and self
contained, the only "big" one being the one that tracks the root owner for
relocation reads, which is to resolve the remaining class of lockdep errors we
get because of an improper lockdep class set on the extent buffer.  Thanks,

Josef

Josef Bacik (13):
  btrfs: don't get an EINTR during drop_snapshot for reloc
  btrfs: initialize test inodes location
  btrfs: fix reloc root leak with 0 ref reloc roots on recovery
  btrfs: splice remaining dirty_bg's onto the transaction dirty bg list
  btrfs: do not WARN_ON() if we can't find the reloc root
  btrfs: add ASSERT()'s for deleting backref cache nodes
  btrfs: do not double free backref nodes on error
  btrfs: abort the transaction if we fail to inc ref in btrfs_copy_root
  btrfs: modify the new_root highest_objectid under a ref count
  btrfs: fix lockdep splat in btrfs_recover_relocation
  btrfs: keep track of the root owner for relocation reads
  btrfs: do not cleanup upper nodes in btrfs_backref_cleanup_node
  btrfs: don't clear ret in btrfs_start_dirty_block_groups

 fs/btrfs/backref.c           | 11 ++------
 fs/btrfs/backref.h           |  9 ++++---
 fs/btrfs/block-group.c       |  6 ++++-
 fs/btrfs/ctree.c             |  5 ++--
 fs/btrfs/extent-tree.c       |  5 +++-
 fs/btrfs/ioctl.c             | 10 ++++---
 fs/btrfs/relocation.c        | 51 +++++++++++++++++++++++++++++++-----
 fs/btrfs/tests/btrfs-tests.c |  7 ++++-
 fs/btrfs/tests/inode-tests.c |  9 -------
 fs/btrfs/volumes.c           |  2 ++
 10 files changed, 79 insertions(+), 36 deletions(-)

-- 
2.26.2

