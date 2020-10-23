Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906262970F6
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 15:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373222AbgJWN6P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 09:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372968AbgJWN6O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 09:58:14 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB869C0613CE
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Oct 2020 06:58:14 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id b69so1169198qkg.8
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Oct 2020 06:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bzF2oR9xadHeOQvWCfZZhj+c0Waa6yroJJaw1EDDKuc=;
        b=F3JdRUdpqHh4iYRF0HV0Q0X1aRIziHDy8oQvjqdQqg6OKG+hzsODbytjkkwZ1XiKvR
         DzzFk1fSVTudJVRO/CMyIX2Qc2UbNpYOmdYqEOOtY4xfSzeWHaAb2F8Yk70yuZaeqol4
         aBE4arPMU11POn7I4US6M9JUO1sHq8JpSvKonDyXKNC6Tng5DWQYVeea05wisF4bjMcz
         aayARKtezwOj4EOlG8v/MRstxvXrcUF6oDJ1Qz7/olfG+fjbHhNxj7C4/mL1JOCYg6A9
         0Qz19vLB01MzeenXlyfiBraLUh8JsJpY8fiB6MCtI8aM9wS1qH+ZiB0LTBwpDMKhaPUM
         OMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bzF2oR9xadHeOQvWCfZZhj+c0Waa6yroJJaw1EDDKuc=;
        b=n3N2U8YxdtcvTtWArJWAnivzvya14KF6uF43Dz2tkwrjgcT531POBihLY2g5MGjXj8
         Epl20IEK+aUAufwt0Nq7KE28VqvwlwbHKIR4fK3rDsPAG3kZBiEs/atEU/qAHSBdJ1mt
         RkurYAFKco2nSXCt8OaBiXyDG48ztQgT5p19lOzWebRP5E6UwYx1/n1WvBobFzy1g1ak
         JNfxkyHcUi9tQC7SiFGYdvImeEYFVjjdEeOdxgXQrnr4PmSPdtWNGBXvDYaEGD2MPeff
         0sicNV3zBmV5g+r4nzdWZugWKMm7W3uC/OreA4DsSySwGBsvudoCEeC1vde/PsmE9gTG
         9djg==
X-Gm-Message-State: AOAM532KGz4K29mpGAHwnvJkiBjG+vxU1kGJBYRY+CkSJhMaN5Y/kp3b
        DpEIL1h9MFKocixzgHjM3Hj0nIydj5/d1k7E
X-Google-Smtp-Source: ABdhPJzaibqftmRcdFxY8nR0PXMqFuUK8wK5tQrWbkr9VSU4U8ke/m2x6tq50roWcsavou7F372Cqg==
X-Received: by 2002:a05:620a:a8c:: with SMTP id v12mr2378480qkg.152.1603461492957;
        Fri, 23 Oct 2020 06:58:12 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t20sm917327qtt.70.2020.10.23.06.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 06:58:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/8] Block group caching fixes
Date:   Fri, 23 Oct 2020 09:58:03 -0400
Message-Id: <cover.1603460665.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

The lockdep fix I posted about protecting ->caching_block_groups got feedback
that I needed to document how we're using the ->commit_root_sem to protect
->last_byte_to_unpin, which forced me to take a real hard look at how we're
coordinating the caching threads.  This lead to the discovery of a few pretty
significant problems which has lead to this patchset.  There are a few
individual fixes, but the bulk of these patches are around making all caching of
block groups asynchronous.

Previously we would load the v1 space cache at caching time, instead of doing it
asynchronously.  This was for speed, but also because there's a delicate balance
that needs to be maintained with unpinning and the v1 space cache.  With the
slow caching we keep track of our progress in caching, so we can unpin anything
prior to that progress.  However since the space cache only knows the state of
the block groupat that time, we have to load the cache in it's entirety so we
are able to unpin ranges in that block group properly.  Thus loading the space
cache on demand and inline with the caller.

This resulted in a few weird special cases for the space cache

1) We don't actually use the ->commit_root_sem when doing the free space cache
   lookups.  This is incorrect, and can actually race with a transaction commit.
   This in practice doesn't mean much, but is still functionally wrong and an
   outlier.
2) Instead of using the ->commit_root_sem and ->search_commit_root when looking
   up the extents for the free space cache inode, we use ->recurse and allow
   recursive read locks on nodes we may already hold write locks on.  This
   happens in the case where we are modifying the tree_root when we need to
   cache the block group, we may already be holding the write lock on an upper
   node and then subsequently need to take the read lock on that node to read
   the extents for the free space cache inode.  This is the only place we allow
   recursion, and we don't actually need it because we could easily use
   ->search_commit_root.

However we can't actually take the ->search_commit_root in this path, because it
causes the lockdep splat that I fix in the last patch of this series.  This
means we need to move the loading of the v1 space cache to an async thread so we
can take the proper locks for searching the commit root safely.  This allows us
to unify our modification of ->last_byte_to_unpin, and clean up the locking for
everything else so it's consistent.

The other major fix is how we update ->last_byte_to_unpin.  Previously we were
recording this value, and then later switching the commit roots.  This could
result in a gap where we would not unpin a range, thus leaking the space.  This
leaked space would then end up in the space cache as we use the in-memory cache
to write out the on disk space cache.  This explains how sometimes we would see
messages indicating that the space cache wasn't right and needed to be rebuilt.

The main fixes are
  
  btrfs: do not shorten unpin len for caching block groups
  btrfs: update last_byte_to_unpin in switch_commit_roots
  btrfs: protect the fs_info->caching_block_groups differently

And the work to make space cache async is in the following patches

  btrfs: cleanup btrfs_discard_update_discardable usage
  btrfs: load free space cache into a temporary ctl
  btrfs: load the free space cache inode extents from commit root
  btrfs: async load free space cache

Thanks,

Josef

Josef Bacik (8):
  btrfs: do not shorten unpin len for caching block groups
  btrfs: update last_byte_to_unpin in switch_commit_roots
  btrfs: explicitly protect ->last_byte_to_unpin in unpin_extent_range
  btrfs: cleanup btrfs_discard_update_discardable usage
  btrfs: load free space cache into a temporary ctl
  btrfs: load the free space cache inode extents from commit root
  btrfs: async load free space cache
  btrfs: protect the fs_info->caching_block_groups differently

 fs/btrfs/block-group.c       | 164 +++++++++++++--------------------
 fs/btrfs/ctree.h             |   1 -
 fs/btrfs/discard.c           |   7 +-
 fs/btrfs/discard.h           |   3 +-
 fs/btrfs/extent-tree.c       |  35 ++------
 fs/btrfs/free-space-cache.c  | 169 +++++++++++++++--------------------
 fs/btrfs/free-space-cache.h  |   3 +-
 fs/btrfs/inode.c             |  10 ++-
 fs/btrfs/tests/btrfs-tests.c |   2 +-
 fs/btrfs/transaction.c       |  43 ++++++++-
 10 files changed, 198 insertions(+), 239 deletions(-)

-- 
2.26.2

