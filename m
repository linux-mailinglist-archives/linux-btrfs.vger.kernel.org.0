Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B6934A78B
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Mar 2021 13:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhCZMvW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Mar 2021 08:51:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:57956 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229671AbhCZMvH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Mar 2021 08:51:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616763066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=cWd8mEOo2gMZd39fSTqKsWQko7d8squMTGOwlxNvCKk=;
        b=E6NF/YPXtCZFTd2TjPqRKyF6Fucj/NZdMQaajy6IguCs7ru2fyCok1RUz4Fy287EeIMjKI
        WHUZyPBCKeA99TkDJB7PN0NEA6nRkdRXi25p916toIPTj3mEkRFBI1HNsfw+XvzGqLm536
        b0FIKSkafoWeD/DN1eoiCI1tI3wkJ8Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 29E2BAD8D
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Mar 2021 12:51:06 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: image: make restored image file to be properly enlarged
Date:   Fri, 26 Mar 2021 20:50:44 +0800
Message-Id: <20210326125047.123694-1-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
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

Qu Wenruo (3):
  btrfs: image: remove the dead stat() call
  btrfs-progs: image: enlarge the output file if no tree modification is
    needed for restore
  btrfs-progs: misc-tests: add test to ensure the restored image can be
    mounted

 image/main.c                                  | 51 ++++++++++++++++---
 .../047-image-restore-mount/test.sh           | 19 +++++++
 2 files changed, 62 insertions(+), 8 deletions(-)
 create mode 100755 tests/misc-tests/047-image-restore-mount/test.sh

-- 
2.30.1

