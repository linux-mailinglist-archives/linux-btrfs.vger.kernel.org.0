Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B553B7369
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jun 2021 15:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhF2Npk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Jun 2021 09:45:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233994AbhF2Npj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Jun 2021 09:45:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6402261DC2;
        Tue, 29 Jun 2021 13:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624974192;
        bh=b1VQAz9py9LPOTWBr9+ksHIqSmaZczMN1UoONlC8i4s=;
        h=From:To:Cc:Subject:Date:From;
        b=gzXV68cdD/D3kHa1iRej76IRY8VcIVm+0nvQNzWitmkEbKjIsc8Bu9AS7vqBg4SvL
         X6/ogdxnYqBBNgKCgR09qMlErCaghjafPWj+B9CSrae+NZpRc2r6NaoNRyXx2pWSGg
         xkX/ie1ENoSsPLiJAGTIdqQtZVEJT9wdhR/pjJ6tLWOtgs0OEl+HPqdeEYCVaGKZAX
         rQIPnW0WijXjbVcX9sfwDE1MmYSBciWJVNKrQfIY/rRssjQZzcGXrutRfq6Uhk4Fmo
         0EDnctTFxbNkaLUCL2c0jVmZuJP3Av20av+CT3qOHG5QhpETI4HX7iR0pkKYW3VHSc
         UJIlMXqGryF9w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     naohiro.aota@wdc.com, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 0/2] btrfs: eliminate a deadlock when allocating system chunks and rework chunk allocation
Date:   Tue, 29 Jun 2021 14:43:04 +0100
Message-Id: <cover.1624973480.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The first patch eliminates a deadlock when multiple tasks need to allocate
a system chunk. It reverts a previous fix for a problem that resulted in
exhausting the system chunk array and result in a transaction abort when
there are many tasks allocating chunks in parallel. Since there is not a
simple and short fix for the deadlock that does not bring back the system
array exhaustion problem, and the deadlock is relatively easy to trigger
on zoned filesystem while the exhaustion problem is not so common, this
first patch just revets that previous fix.

The second patch reworks a bit of the chunk allocation code so that we
don't hold onto reserved system space from phase 1 to phase 2 of chunk
allocation, which is what leads to system chunk array exhaustion when
there's a bunch of tasks doing chunks allocations in parallel (initially
observed on PowerPC, with a 64K node size, when running the fallocate
tests from stress-ng). The diff of this patch is quite big, but about
half of it are just comments.

Filipe Manana (2):
  btrfs: fix deadlock with concurrent chunk allocations involving system
    chunks
  btrfs: rework chunk allocation to avoid exhaustion of the system chunk
    array

 fs/btrfs/block-group.c | 343 ++++++++++++++++++++++++++++-----------
 fs/btrfs/block-group.h |   6 +-
 fs/btrfs/ctree.c       |  67 ++------
 fs/btrfs/transaction.c |  15 +-
 fs/btrfs/transaction.h |   9 +-
 fs/btrfs/volumes.c     | 355 +++++++++++++++++++++++++++++++----------
 fs/btrfs/volumes.h     |   5 +-
 7 files changed, 547 insertions(+), 253 deletions(-)

-- 
2.28.0

