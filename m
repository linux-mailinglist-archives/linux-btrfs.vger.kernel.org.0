Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60E436E79B
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 11:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239730AbhD2JHu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 05:07:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:41326 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232734AbhD2JHt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 05:07:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619687222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=FzeLlbgLqxVGlbrUI6HgPIqz7rNJa+4jEFVFsqwzg7I=;
        b=uX2Ak7P/GI74LSozzGowjmfc1HcjjxfmSOeKwEjYgaRHmkPAgGUEoleSDv3T1dQQL9EDR4
        pmZQZVGt+i8MFzyzu5UMX5wvUwYp1ATIkhcggu3clqYq0qjaTaBo+2XMTjBSszaeC6b6o/
        G1Ox5dh6hy6ZZcr/Q8QYgO8mWmx9jKI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6AD99AE58
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Apr 2021 09:07:02 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs-progs: image: make restored image file to be properly enlarged
Date:   Thu, 29 Apr 2021 17:06:55 +0800
Message-Id: <20210429090658.245238-1-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Recent kernel will refuse to mount restored image, even the source fs is
empty:
 # mkfs.btrfs -f /dev/test/test
 # btrfs-image /dev/test/test /tmp/dump
 # btrfs-image -r /tmp/dump ~/test.img
 # mount ~/test.img /mnt/btrfs
 mount: /mnt/btrfs: wrong fs type, bad option, bad superblock on /dev/loop0, missing codepage or helper program, or other error.
 # dmesg -t | tail -n 7
 loop0: detected capacity change from 10592 to 0
 BTRFS info (device loop0): disk space caching is enabled
 BTRFS info (device loop0): has skinny extents
 BTRFS info (device loop0): flagging fs with big metadata feature
 BTRFS error (device loop0): device total_bytes should be at most 5423104 but found 10737418240
 BTRFS error (device loop0): failed to read chunk tree: -22
 BTRFS error (device loop0): open_ctree failed

This is triggered by a recent kernel commit 3a160a933111 ("btrfs: drop never met disk total
bytes check in verify_one_dev_extent").

But the root cause is, we didn't enlarge the output file if the source
image only contains single device.

This bug won't affect restore to block device, or the destination file
is already large enough.

This patchset will fix the problem, and with new test case to detect
such problem.

Also remove one dead code exposed during the development.

Changelog:
v2:
- Comments word change
- Only enlarge the file when the target file is smaller than expected
  device size
- Change the prefix of the 1st patch
  From "btrfs" to "btrfs-progs"

Qu Wenruo (3):
  btrfs-progs: image: remove the dead stat() call
  btrfs-progs: image: enlarge the output file if no tree modification is
    needed for restore
  btrfs-progs: misc-tests: add test to ensure the restored image can be
    mounted

 image/main.c                                  | 51 ++++++++++++++++---
 .../048-image-restore-mount/test.sh           | 20 ++++++++
 2 files changed, 63 insertions(+), 8 deletions(-)
 create mode 100755 tests/misc-tests/048-image-restore-mount/test.sh

-- 
2.31.1

