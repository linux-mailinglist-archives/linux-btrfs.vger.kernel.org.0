Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C309B10F7F3
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 07:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLCGnA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 01:43:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:44608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbfLCGnA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Dec 2019 01:43:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA351ADB5
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Dec 2019 06:42:58 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: Make balance cancelling response faster
Date:   Tue,  3 Dec 2019 14:42:50 +0800
Message-Id: <20191203064254.22683-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]
There are quite some users reporting that 'btrfs balance cancel' slow to
cancel current running balance, or even doesn't work for certain dead
balance loop.

With the following script showing how long it takes to fully stop a
balance:
  #!/bin/bash
  dev=/dev/test/test
  mnt=/mnt/btrfs

  umount $mnt &> /dev/null
  umount $dev &> /dev/null

  mkfs.btrfs -f $dev
  mount $dev -o nospace_cache $mnt

  dd if=/dev/zero bs=1M of=$mnt/large &
  dd_pid=$!

  sleep 3
  kill -KILL $dd_pid
  sync

  btrfs balance start --bg --full $mnt &
  sleep 1

  echo "cancel request" >> /dev/kmsg
  time btrfs balance cancel $mnt
  umount $mnt

It takes around 7~10s to cancel the running balance in my test
environment.

[CAUSE]
Btrfs uses btrfs_fs_info::balance_cancel_req to record how many cancel
request are queued.
However that cancelling request is only checked after relocating a block
group.

That behavior is far from optimal to provide a faster cancelling.

[FIX]
This patchset will add more cancelling check points, to make cancelling
faster.

And also, introduce a new error injection points to cover these newly
introduced and future check points.

Qu Wenruo (4):
  btrfs: relocation: Introduce error injection points for cancelling
    balance
  btrfs: relocation: Check cancel request after each data page read
  btrfs: relocation: Check cancel request after each extent found
  btrfs: relocation: Work around dead relocation stage loop

 fs/btrfs/ctree.h      |  1 +
 fs/btrfs/relocation.c | 23 +++++++++++++++++++++++
 fs/btrfs/volumes.c    |  2 +-
 3 files changed, 25 insertions(+), 1 deletion(-)

-- 
2.24.0

