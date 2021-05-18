Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342FF3872DE
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 May 2021 09:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346950AbhERHLF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 May 2021 03:11:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:32832 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237714AbhERHLF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 May 2021 03:11:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621321786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=69l65qjnHcyIXEHsvcuhmLAPfGmF5pV7bM45IaKBP/g=;
        b=JbHA7FII1KbEyLohdzi0i0myI6VzW+VtF2eSmAHe35UP8AW14SBZyzHZwsJiSCZ2N+x0DE
        nsurl0ogAWNldnr05O8V4lJRfMSYL6GSeuBHuSiwZ6/cCnT5rq9N/xtArRccE1n+4hYe/H
        uH83AGnoSlssYFC+Q2a/2kLK5v+woyk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C78C9B10B
        for <linux-btrfs@vger.kernel.org>; Tue, 18 May 2021 07:09:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/2] btrfs: fixes for the 13 subpage preparation patches
Date:   Tue, 18 May 2021 15:09:40 +0800
Message-Id: <20210518070942.206846-1-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although Ritesh and Goldwyn were both testing full subpage patches and
got pretty good results, our awesome maintainer David still found some
crash and hang:

- btrfs/125 hang on x86
  This test case is not in auto group, and for subpage case we reject
  RAID56 thus it doesn't trigger the hang.

  It's a behavior change in page Ordered (private2) cleanup sequence.
  In btrfs_cleanup_ordered_extents() we cleaned up the page Ordered bit,
  but doesn't run the ordered extent accounting for the locked page.
  This leaves the ordered extent accounting never run on the locked
  page, hanging the fs.

  This needs a dedicated fix, but it's still pretty small (mostly
  comments), and won't affect normal routines.

- generic/521 random crash on x86
  Which I can't reproduce, but according to the dying message, it's not
  hard to find the problem.
  An assignment out of the protection of spinlock.
  This small fix can be folded into patch "btrfs: introduce
  btrfs_lookup_first_ordered_range()"

Changelog:
v2:
- Fix the typos in the commit message of the 1st patch
- Remove the ClearPageOrdered() call in the 1st patch
  As btrfs_mark_ordered_io_finished() will clear it in a more accurate
  way.
  And ClearPageOrdered() is not subpage compatible.

v3:
- Change the fix for the btrfs/215 hang
  Now we choose to skip the locked page, leaving both its Ordered bit
  and ordered extent accounting to be handled by run_delalloc_range()
  error hanlding path.

  This fixes a possible ordered extent underflow, and removes a forward
  declaration.

Qu Wenruo (2):
  btrfs: fix the fs hang when run_delalloc_range() failed
  btrfs: fix the unsafe access in btrfs_lookup_first_ordered_range()

 fs/btrfs/inode.c        | 21 +++++++++++++++++++++
 fs/btrfs/ordered-data.c |  3 ++-
 2 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.31.1

