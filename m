Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C63614EF5
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 17:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiKAQQA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 12:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiKAQP7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 12:15:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BB51C914
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 09:15:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 972326165E
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CEFC433B5
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667319357;
        bh=/OfqLKl8fLs8leAu4unoVB8N7CaJu7DsgWUX+DPz/7U=;
        h=From:To:Subject:Date:From;
        b=Vor57/8cp57HXcSsmuB7nMbI5fHvhf8gZlHKPHKB+KKaNqOq5Czg7F+BoVVUwPrVK
         Ikv2pKmBwHDuEVmd3TB5XmkTJmeYirt8RBrlzAfzCF8gvPX+DlgMfh3B2tS4O3NTU5
         +jgUBVkTrzbhSx5nGxjVU51acW24ZqdfnhJI+Ab2HK7XmpthqY9j0wRiw+T1sK+PvM
         JMn36AfD4O5FTXOYk6tVAHhQVkYjxwzS+fSKw0L/i9m5v6DhaL4weEjm2xoBdalB+p
         4acCq3LjFxyWbzvc/f7XBoaoGMgAfxkPBmH/rHqc4yLubQhjpRkPWMZGE7t47CpNHI
         0plnHTvRcWnsA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/18] btrfs: make send scale and perform better with shared extents
Date:   Tue,  1 Nov 2022 16:15:36 +0000
Message-Id: <cover.1667315100.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

There are two problems with send regarding cloned extents:

1) Sometimes it ends up not cloning whole extents, but only a section of
   the extents, reducing in less extent sharing at the receiver and extra
   IO on the send side (reading data, issuing write commands) and on the
   receiver side too (writing more data). This is not only not optimal
   but it also surprises users and often gets reported (such as in the
   thread referenced in patch 09/18);

2) When we find that a data extent is directly shared more than 64 times,
   we don't attempt to clone it, because that requires backref walking to
   determine from which inode and range we should clone from and for
   extents with many backreferences, that can be too slow, specially if
   we have many thousands of extents with a huge amount of sharing each.

This patchset solves the first problem completely (patch 09/18), and for
the second issue while not fully eliminated, it's significantly improved.
In a test scenario with 50 000 files where each file is reflinked 50 times,
there's a performance improvement of ~70% to ~75% for both full and
incremental send operations. This test and results are in the changelog
of patch 17/18.

After this we can now bump the limit from 64 max references to 1024, which
is still a conservative value, but the goal is to get rid of such limit in
the future (some more work required for that, but we're getting there).

There's also a nice and simple performance optimization when processing
extents that are not shared and we are using only one clone source (the
send root itself, very common), with gains varying between ~9% to ~18%
in some small scale tests where there are no shared extents or the majority
of the extents are not shared. That's patch 08/18.

The rest is just refactoring and cleanups in preparation for the optimization
work for send, and a few bug fixes for error paths in the backref walking
code and qgroup self tests. In particular the error paths for backref walking
are important because with the latest patches they are triggered not just in
case an error happens but also when the backref walking callbacks tell the
backref walking code to stop early.

More details in the changelogs of the patches.

I've also left this in a git tree at:

  https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/log/?h=send_clone_performance_scalability

Filipe Manana (18):
  btrfs: fix inode list leak during backref walking at resolve_indirect_refs()
  btrfs: fix inode list leak during backref walking at find_parent_nodes()
  btrfs: fix ulist leaks in error paths of qgroup self tests
  btrfs: remove pointless and double ulist frees in error paths of qgroup tests
  btrfs: send: avoid unnecessary path allocations when finding extent clone
  btrfs: send: update comment at find_extent_clone()
  btrfs: send: drop unnecessary backref context field initializations
  btrfs: send: avoid unnecessary backref lookups when finding clone source
  btrfs: send: optimize clone detection to increase extent sharing
  btrfs: use a single argument for extent offset in backref walking functions
  btrfs: use a structure to pass arguments to backref walking functions
  btrfs: reuse roots ulist on each leaf iteration for iterate_extent_inodes()
  btrfs: constify ulist parameter of ulist_next()
  btrfs: send: cache leaf to roots mapping during backref walking
  btrfs: send: skip unnecessary backref iterations
  btrfs: send: avoid double extent tree search when finding clone source
  btrfs: send: skip resolution of our own backref when finding clone source
  btrfs: send: bump the extent reference count limit for backref walking

 fs/btrfs/backref.c            | 596 ++++++++++++++++++++--------------
 fs/btrfs/backref.h            | 137 +++++++-
 fs/btrfs/qgroup.c             |  38 ++-
 fs/btrfs/relocation.c         |  19 +-
 fs/btrfs/scrub.c              |  18 +-
 fs/btrfs/send.c               | 467 +++++++++++++++++++-------
 fs/btrfs/tests/qgroup-tests.c |  86 +++--
 fs/btrfs/ulist.c              |   2 +-
 fs/btrfs/ulist.h              |   2 +-
 9 files changed, 928 insertions(+), 437 deletions(-)

-- 
2.35.1

