Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B978311611
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 23:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhBEWuK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Feb 2021 17:50:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231325AbhBEM4W (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Feb 2021 07:56:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B774E64DFF
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Feb 2021 12:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612529741;
        bh=a9LKObZLWVThjMmTyjk+JZgkPftZqRJyZEpvuI1kJVo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XRf8PzC7NzvRGhfngygykrwXMTJvssR84a0h/HxmS+mRMaBV/2R6QQgJ6f2sWW+59
         n8WFUO0YWlhVP9gBnq6+N4V8IjDFE1s3lhQGSUPsPiGaQxEAUenAObqbAfWRlWKrUE
         FBZ4CWYC5PCYexmRTAMOuIiaMrz2xB9ohj9e3JTwCmX9zLEV7ILPetv8ePhaRiZK+6
         X1StEDdmVoh67vGeYE1T7tK3cOpUN+ELXAIcxBiGTooebpD1Z77cd+q/LpMjyDV/o+
         X7/ykPeVFvqqb75Jv/jGapC45RQnz4AcUgpRB5om90C95bn23Yt3nruu5CSfl68jWP
         7en2nZ1a9A6eg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: fix a couple swapfile support bugs
Date:   Fri,  5 Feb 2021 12:55:35 +0000
Message-Id: <cover.1612529182.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612350698.git.fdmanana@suse.com>
References: <cover.1612350698.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The following patchset fixes 2 bugs with the swapfile support, where we can
end up falling back to COW when writing to an active swapfile. The first patch
is actually independent and just makes the nocow buffered IO path more efficient
by eliminating a repeated check for a read-only block group.

V2: Removed the part of optimizing the direct IO nocow path from patch 2,
    because removing the RO block group check from can_nocow_extent() would
    leave the buffered write path that checks if we can fallback to nocow at
    write time (and not writeback time), after hitting ENOSPC when attempting
    to reserve data space, from doing that check. The optimization can still
    be done, but that would require adding more context information to
    can_nocow_extent(), so it could know when it needs to check if the block
    group is RO or not - since things are a bit entangled around that function
    and its callers, I've left it out for now.

Filipe Manana (3):
  btrfs: avoid checking for RO block group twice during nocow writeback
  btrfs: fix race between writes to swap files and scrub
  btrfs: fix race between swap file activation and snapshot creation

 fs/btrfs/block-group.c | 33 ++++++++++++++++++++++++++++++-
 fs/btrfs/block-group.h |  9 +++++++++
 fs/btrfs/ctree.h       |  5 +++++
 fs/btrfs/inode.c       | 44 ++++++++++++++++++++++++++++++++++++------
 fs/btrfs/scrub.c       |  9 ++++++++-
 5 files changed, 92 insertions(+), 8 deletions(-)

-- 
2.28.0

