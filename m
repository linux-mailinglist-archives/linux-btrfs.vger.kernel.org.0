Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70164758B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 13:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242322AbhLOMUI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 07:20:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59396 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbhLOMUI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 07:20:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3865B81EC1
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F666C34603
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639570805;
        bh=Ju+5uKobxvvaJ3xlb0bnRiNQEulGq2NFsmlbgMx9mMo=;
        h=From:To:Subject:Date:From;
        b=N+GpJfrGUwumWAb8hrPCzlX2Y0IZZc4dHBcF8isRRVYSD2rJRAKRsGQ/K92+tTy9B
         rr/mhWhbXTf6F8DO2+Ac5NcNu5gRMqXvfdk5dXSg47rHmUMFf+Uz2VXvCjKCExiZDX
         hMkrlzCKqLxzA+NNkKvudFmKMv1g4rWC3LF+1mIqSt229HSWxQi75LYODGVYoC2KLq
         42EZh5vErHJHnl7cXHHs5FdOz3oTodINcQW+l5ZIj3wsYSSO6ETGF5xQfYc6vRKy43
         4KsLmY++rRTN5Xe5H4Nei5g2o0g0CbRx6yimDBNf6Rm0X8tmUbfa/GpDPSE+6Gw7o1
         NBL1fPgqvwsKg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: some more speedups for directory logging/fsync
Date:   Wed, 15 Dec 2021 12:19:57 +0000
Message-Id: <cover.1639568905.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This patchset brings some more performance improvements for directory
logging/fsync, by doing some changes to the logging algorithm to avoid
logging dentries created in past transactions, which helps reducing a
lot the amount of logged metadata, and therefore less IO as well for
large directories.

It specially benefits the case when some dentries were removed, either
due to file deletes or renames, where it can reduce the total time spent
in an fsync by an order of magnitude even if the number of dentries removed
is a small percentage of the total dentries in the directory (for e.g. as
little as 1%, like in the test results of the changelog of patch 3/4).

This builds on top of my previous patchset to make directory logging copy
only dir index keys and skip dir item keys, which has been on misc-next
since the previous merge window closed.

Patches 1/4 and 3/4 are the changes that accomplish this, while patch 2/4
is just preparation for patch 3/4, and patch 4/4 is more of a cleanup of
old, unnecessary and unreliable logic. Test case generic/335 was recently
updated in fstests, so that after applying patch 4/4 it passes.

Patch 3/4 contains in its changelog the test and results.

We are close to the 5.17 merge window, holiday season is approaching and
there's already a significant change for directory logging coming to 5.17
(log only dir index keys and skip dir item keys), so I think this patchset
is better suited for the 5.18 merge window.

Thanks.

Filipe Manana (4):
  btrfs: don't log unnecessary boundary keys when logging directory
  btrfs: put initial index value of a directory in a constant
  btrfs: stop copying old dir items when logging a directory
  btrfs: stop trying to log subdirectories created in past transactions

 fs/btrfs/btrfs_inode.h |  12 +++-
 fs/btrfs/inode.c       |  10 +---
 fs/btrfs/tree-log.c    | 123 +++++++++++++++++++++++++----------------
 3 files changed, 86 insertions(+), 59 deletions(-)

-- 
2.33.0

