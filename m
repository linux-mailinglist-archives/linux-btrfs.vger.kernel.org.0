Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3119BC3E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 10:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405749AbfIXIL0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 04:11:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:38874 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390364AbfIXIL0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 04:11:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1DBB4B63B
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 08:11:25 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: Add check and repair for invalid inode generation
Date:   Tue, 24 Sep 2019 16:11:17 +0800
Message-Id: <20190924081120.6283-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have at least two user reports about bad inode generation makes
kernel reject the fs.

According to the creation time, the inode is created by some 2014
kernel.
And the generation member of INODE_ITEM is not updated (unlike the
transid member) so the error persists until latest tree-checker detects.

Even the situation can be fixed by reverting back to older kernel and
copying the offending dir/file to another inode and delete the offending
one, it still should be done by btrfs-progs.

This patchset adds such check and repair ability to btrfs-check, with a
simple test image.

Qu Wenruo (3):
  btrfs-progs: check/lowmem: Add check and repair for invalid inode
    generation
  btrfs-progs: check/original: Add check and repair for invalid inode
    generation
  btrfs-progs: fsck-tests: Add test image for invalid inode generation
    repair

 check/main.c                                  |  50 +++++++++++-
 check/mode-lowmem.c                           |  76 ++++++++++++++++++
 check/mode-original.h                         |   1 +
 .../.lowmem_repairable                        |   0
 .../bad_inode_geneartion.img.xz               | Bin 0 -> 2012 bytes
 5 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 tests/fsck-tests/043-bad-inode-generation/.lowmem_repairable
 create mode 100644 tests/fsck-tests/043-bad-inode-generation/bad_inode_geneartion.img.xz

-- 
2.23.0

