Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEF72A827C
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 16:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbgKEPp0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 10:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731202AbgKEPpZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 10:45:25 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99B5C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 07:45:24 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id h12so1381958qtu.1
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 07:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=piSdBnZCrszfvY8in2Nvg8FRvTWECZlr9sLroYUDhjQ=;
        b=GWA1He3/WBp2XB5HyVxiGDLPHHvpGpsxdPPSQcmhepAQvO5EPHI3DLfmYhZ882xmWR
         MLxfGwLKlw4/KMQoMRgQE3/2fx7DU6oTijCaEE6IY6Ria9XFwtysWNh6KRLvfZ+RvC1B
         SyotWZTPCauf07zltLkwUFoFnsxPD+wreyiQl1q1h7l53Ri5zXkotc80PrPCIBiQdDvZ
         CjZCeX2a+mccbLtDteX/3t87UqIvykA4EWlf87pDj6vaKBBUyf75sCvIPv/r4joFAuAy
         TJ0LvtpTuCGETDMi1XDe4nT2gpTHg6WVqPVKdECjXgaHXd0zB9qcp1BiEmVukFuSN1xn
         PTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=piSdBnZCrszfvY8in2Nvg8FRvTWECZlr9sLroYUDhjQ=;
        b=CrmXOlSM4KSi2XKM+54yxaM+D1jBbRFUlxyKqJs6NJUKlqsyOxdeJYH0Y7wa0ZXZzl
         i9QtbOEBQO9HqczVvSlXKTiuw0dWA9Hc74ZVQqY8a4OHI8lmODqsGXwFJMsePnbA9DL7
         75AtpQWqE12f1lxdz0GXxhMgPw+idlJeZAupvsZrf4NeLz140ejvs9c0lI3AVob4GOqs
         Az8tXlQHvUgk3TVxzpXGuHhcALJxxJr7pnK8wT3bJu++GMPdVJ+b7mriWzCLduN+gl7L
         rHNqnjOzFE0aEwAHkWGzXp66oG5OyoLTrV8Elek6Z7qlESLsrVnoqQnRGdKkeOuDaOk+
         Gkyw==
X-Gm-Message-State: AOAM532thTJGwCflSKPTo0CLwoJ65C1Jl/SjFFV4arB4XYZt3zvX3iMa
        YS0/6u/WF6BHgwG1zrBKeGwI+SB0Bz55AoMJ
X-Google-Smtp-Source: ABdhPJwMIEu3QEOTjTh84ei5vevjYK6kPcNI4O8LLlmbfxUx8aOMRwwycbWJsCVJCnus39dqtv6ajw==
X-Received: by 2002:ac8:1206:: with SMTP id x6mr2611065qti.165.1604591123555;
        Thu, 05 Nov 2020 07:45:23 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u21sm1285851qkm.93.2020.11.05.07.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 07:45:22 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/14][REBASED] Set the lockdep class on eb's at allocation time
Date:   Thu,  5 Nov 2020 10:45:07 -0500
Message-Id: <cover.1604591048.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

- no change, simply rebased onto the lastest misc-next

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

