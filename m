Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC3A347BBF
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2019 09:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfFQH7m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jun 2019 03:59:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:43768 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725791AbfFQH7m (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jun 2019 03:59:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A98C1AE89
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2019 07:59:40 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs-progs: GCC9 fixes
Date:   Mon, 17 Jun 2019 15:59:32 +0800
Message-Id: <20190617075936.12113-1-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset will address the remaining warning when compiling
btrfs-progs devel branch with GCC9.

It's based on the following commit:
commit 9a1d86a9ac7384b332db498822585a2255f7d3e6 (david/devel)
Author: David Sterba <dsterba@suse.com>
Date:   Thu Jun 13 20:45:49 2019 +0200

    btrfs-progs: build: disable -Waddress-of-packed-member by default


Please note that the 2nd patch mostly replace commit 691656abdc9a
("btrfs-progs: fix gcc9 warning and potentially unaligned access to dev stats") by
backporing kernel btrfs_dev_stats_value() to btrfs-progs.
Thus the original fix can be removed.

The remaining warning is -Warray-boundary, but that one looks pretty
strange. The code looks good, and I backported an easy version:

  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <stddef.h>
  
  struct test_struct {
  	long long off_0_7;
  	int	offset_8_11;
  	unsigned char offset_12_12;
  } __attribute__ ((packed));
  
  void reset_values(struct test_struct *ptr)
  {
  	memset(&ptr->offset_8_11, 0, sizeof(struct test_struct) - offsetof(struct test_struct, offset_8_11));
  }
  
  int main()
  {
  	struct test_struct my_struct = { 0xffff, 0xff, 0xff};
  
  	printf("struct=0x%llx start=0x%llx len=0x%x\n",
  		&my_struct, &my_struct.offset_8_11, sizeof(struct test_struct) - offsetof(struct test_struct, offset_8_11));
  	reset_values(&my_struct);
  	printf("0x%lx 0x%x 0x%x\n", my_struct.off_0_7, my_struct.offset_8_11, my_struct.offset_12_12);
  	return 0;
  }

Which doesn't reproduce the warning.
Thus looks like a false warning and a bug in gcc.

Qu Wenruo (4):
  btrfs-progs: constify extent buffer reader
  btrfs-progs: Fix -Waddress-of-packed-member warning in
    btrfs_dev_stats_values callers
  btrfs-progs: Remove unnecessary fallthrough attribute in
    test_num_disk_vs_raid()
  btrfs-progs: Fix Wformat-overflow warning in cmds-receive.c

 cmds-receive.c |  4 ++--
 ctree.h        | 13 +++++++++++++
 extent_io.c    |  4 ++--
 extent_io.h    |  4 ++--
 print-tree.c   | 21 ++++++---------------
 utils.c        |  1 -
 6 files changed, 25 insertions(+), 22 deletions(-)

-- 
2.22.0

