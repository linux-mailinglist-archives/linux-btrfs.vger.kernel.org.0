Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC3A15521E
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 06:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgBGFi1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 00:38:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:34690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgBGFi1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Feb 2020 00:38:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BD0F5AB95
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2020 05:38:25 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: qgroup: Fix deadlock where btrfs_qgroup_wait_for_completion() waits for never-queued work
Date:   Fri,  7 Feb 2020 13:38:19 +0800
Message-Id: <20200207053821.25643-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a long existing report about btrfs hangs at unmount time,
waiting for qgroup.

Jeff has submitted a patch for that, but never merged.
https://patchwork.kernel.org/patch/10376585/

After re-digging the case, although Jeff's fix can solve the problem,
the racy cause doesn't look correct to me.

After all, close_ctree() wait for qgroup rescan before destroying
related work queues. Thus as long as the work is queued, we can finish
the wait without problem.

Further digging into the bug, it looks like the deadlock is possible,
and Jeff is right about the wait-for-never-queued-work part.
But the racy part doesn't look possible, thus it should only happen
when something wrong happened.

Now with a proper cause analyse, we can craft a much smaller thus better
fix (anyway I'm the guy to backport, smaller is always better).

Changelog:
v2:
- Change the subject
  It's not about race. I got confused by the initial patch.

- Change the cause analyse
  No need for any race. Also add analyse for all qgroup_rescan_init()
  callers to ensure no missing fixes.
  BTW, qgroup_rescan_init() uses BTRFS_QGROUP_STATUS_FLAG_RESCAN flag to
  determine if there is a conflicting rescan, thus it's not affected by
  the timing change.

- Split the spinlock cleanup into another patch

Qu Wenruo (2):
  btrfs: qgroup: Ensure qgroup_rescan_running is only set when the
    worker is at least queued
  btrfs: qgroup: Remove the unnecesaary spin lock for
    qgroup_rescan_running|queued

 fs/btrfs/qgroup.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

-- 
2.25.0

