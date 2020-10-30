Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19732A0FDB
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 22:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgJ3VDL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 17:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgJ3VDL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 17:03:11 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8042C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:09 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id s1so3390433qvm.13
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9rcX78iJCPRRVkpCOtKaArLLDjyn9+1zI9bi1kPd9gQ=;
        b=w4j3yoSsHQAtpUjv4Qo/QBro7vFc0P0I51hRfUlL/Qx2NPBs6mFgsy/IEc/qKjm/xY
         ZSlMW0CMOkIB4aLDQWVRznnlcdzacOZsvN2RYUsEGuEJ9RSNPZqrDJuXGmyj5lB08gfk
         EJvYIpeUD+UWvLUveAATEm4ynw5ePKQ4qImZ7dGJ2HdgWPdcBZ3dyeDB5ga49XMEKOYH
         DycuttmZ2IUNyUm+cLkdysWeZZ0bME8d2UCtynjb42IzNjzFPmxaVaut0MdnhIxFpDhW
         GX7Wo9GF/GrD1ntT4wTUkg2l6Io8PP5HlKObe71JY0BlzyWN0Wb1QYBgSVK/ozC+b69i
         Va3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9rcX78iJCPRRVkpCOtKaArLLDjyn9+1zI9bi1kPd9gQ=;
        b=If/y68MHuy2byXD3q53kabyLBL30D0a+eFs4+NE/gvgBdYvRR4WL6VX5oQjf+NUn13
         hhxjuwMfttIn2qq/uN9etg0A/D4da0Z1oufTd6ur4qbaPsRbv15z0zd40TeyorDi4oHJ
         0A9vWhDla/DHNQpQhnRBqy6omFOGm2WWtZ69uMMyo1EMnDWmz8AkRLBYXOWKAaP6u90Q
         pl2HFNNOuo6mgovmVKm9TWfHo/JZDQdN73tSvhdHF4BEtzDx+Iy+2BEpR8PB3hcYeXyT
         cG7C7mVYI01ozgghGLmnB8GeB+IGjoI+Bpoy+tiRzRmwq7UNAgdANdYMaxkhufSBSmU5
         mvhg==
X-Gm-Message-State: AOAM5328se2UTBZAXSLSu9PjcxS4aToUXOKk76WK1Ee9MISwvLUJmu74
        Cs7EdG5a1qeyrcBmYPau5gAKeG7W1UCOhVV7
X-Google-Smtp-Source: ABdhPJxAS0C3RTSa1wokRH7bQLiSCJZeEIHry0BoV9cC63u2gTiAw4930uSPwshYdEFYqREC2R74jA==
X-Received: by 2002:ad4:4c4a:: with SMTP id cs10mr11603173qvb.48.1604091788313;
        Fri, 30 Oct 2020 14:03:08 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q20sm3429834qtl.69.2020.10.30.14.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 14:03:07 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/14] Set the lockdep class on eb's at allocation time
Date:   Fri, 30 Oct 2020 17:02:52 -0400
Message-Id: <cover.1604091530.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

We've had a lockdep splat show up a few times recently where the extent buffer
doesn't have it's lockdep class set properly.  This can happen if you have
concurrent readers hitting the same block that's not in cache.

This is sort of straightforward to fix, but unfortunately requires quite a bit
of code churn to do it cleanly.  The bulck of these patches are replacing open
coded calls of btrfs_read_node_slot() with the helper to cut down on the number
of people directly calling read_tree_block().  I also cleaned up the readahead
helpers because passing all these arguments around would be unweildy.  The last
patch in the series is the actual fix for what Filipe and Fedora QA saw.

The patches that actually have meaningful changes are

  btrfs: remove lockdep classes for the fs tree
  btrfs: cleanup extent buffer readahead
  btrfs: set the lockdep class for ebs on creation

The rest are cleanups or adding arguments to various functions, so aren't too
tricky.  I've put this through a quick xfstest run for sanity sake, it didn't
appear to break anything, but the full run is still going.  Thanks,

Josef

Josef Bacik (14):
  btrfs: remove lockdep classes for the fs tree
  btrfs: cleanup extent buffer readahead
  btrfs: use btrfs_read_node_slot in btrfs_realloc_node
  btrfs: use btrfs_read_node_slot in walk_down_reloc_tree
  btrfs: use btrfs_read_node_slot in do_relocation
  btrfs: use btrfs_read_node_slot in replace_path
  btrfs: use btrfs_read_node_slot in walk_down_tree
  btrfs: use btrfs_read_node_slot in qgroup_trace_extent_swap
  btrfs: use btrfs_read_node_slot in qgroup_trace_new_subtree_blocks
  btrfs: use btrfs_read_node_slot in btrfs_qgroup_trace_subtree
  btrfs: pass root owner to read_tree_block
  btrfs: pass the root owner and level around for reada
  btrfs: pass the owner_root and level to alloc_extent_buffer
  btrfs: set the lockdep class for ebs on creation

 fs/btrfs/backref.c     |  6 +--
 fs/btrfs/ctree.c       | 86 +++++++++---------------------------------
 fs/btrfs/disk-io.c     | 41 +++++++-------------
 fs/btrfs/disk-io.h     |  8 ++--
 fs/btrfs/extent-tree.c | 20 ++++++----
 fs/btrfs/extent_io.c   | 55 ++++++++++++++++++++++++++-
 fs/btrfs/extent_io.h   |  6 ++-
 fs/btrfs/print-tree.c  |  1 +
 fs/btrfs/qgroup.c      | 43 ++++-----------------
 fs/btrfs/reada.c       | 32 +++++++++++-----
 fs/btrfs/ref-verify.c  | 18 +--------
 fs/btrfs/relocation.c  | 45 +++++-----------------
 fs/btrfs/tree-log.c    |  4 +-
 fs/btrfs/volumes.c     | 12 ++----
 14 files changed, 157 insertions(+), 220 deletions(-)

-- 
2.26.2

