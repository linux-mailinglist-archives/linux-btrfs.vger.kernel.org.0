Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42E088C569
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2019 03:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfHNBEq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 21:04:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:41302 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726373AbfHNBEq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 21:04:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1C6B4AF94
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Aug 2019 01:04:45 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: dump-tree: Support print trees being half dropped
Date:   Wed, 14 Aug 2019 09:04:38 +0800
Message-Id: <20190814010440.15186-1-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For half dropped subvolumes, dump-tree can sometimes lead to csum error
if the dropped tree blocks are also trimmed.

E.g
  node 33153024 level 1 items 61 free 60 generation 7 owner 256
  fs uuid 793daf87-b345-4896-a500-adf19baabd92
  chunk uuid 6fcfe63c-3a64-4e78-b095-5980186a0cc0
          key (256 INODE_ITEM 0) block 33173504 gen 7 <<< Dropped
          key (256 DIR_ITEM 266948847) block 30556160 gen 7
          key (256 DIR_ITEM 540403373) block 30658560 gen 7
  ...
  checksum verify failed on 33173504 found 295F0086 wanted 00000000
  checksum verify failed on 33173504 found 295F0086 wanted 00000000
  checksum verify failed on 33173504 found 295F0086 wanted 00000000
  bad tree block 33173504, bytenr mismatch, want=33173504, have=0
  failed to read 33173504 in tree 256


This patch will make btrfs ins dump-tree to detect dropped tree blocks
and output something like:

  node 33153024 level 1 items 61 free 60 generation 7 owner 256
  fs uuid 793daf87-b345-4896-a500-adf19baabd92
  chunk uuid 6fcfe63c-3a64-4e78-b095-5980186a0cc0
          key (256 INODE_ITEM 0) block 33173504 gen 7 =DROPPED=
          key (256 DIR_ITEM 266948847) block 30556160 gen 7 =DROPPED=
          key (256 DIR_ITEM 540403373) block 30658560 gen 7
  ...
  leaf 30658560 items 56 free space 172 generation 7 owner 256
  leaf 30658560 flags 0x1(WRITTEN) backref revision 1
  fs uuid 793daf87-b345-4896-a500-adf19baabd92
  chunk uuid 6fcfe63c-3a64-4e78-b095-5980186a0cc0
          item 0 key (256 DIR_ITEM 540403373) itemoff 3953 itemsize 42
                  location key (1045 INODE_ITEM 0) type FILE
                  transid 7 data_len 0 name_len 12
                  name: file_reg_394
  ...

And skip the dropped tree blocks completely.


Such problem also seems to affect original mode check, when dropped
subvolumes triggers false alert for missing backref.
But that problem needs more confirmation, and will be addressed in
another patchset.

Qu Wenruo (2):
  btrfs-progs: Introduce drop borderline for drop progress
  btrfs-progs: print-tree: Skip dropped tree blocks properly

 cmds/inspect-dump-tree.c | 33 ++++++++++++++------
 ctree.c                  | 31 +++++++++++++++++++
 ctree.h                  | 60 +++++++++++++++++++++++++++++++++++
 print-tree.c             | 67 ++++++++++++++++++++++++++++++++--------
 print-tree.h             |  4 ++-
 5 files changed, 171 insertions(+), 24 deletions(-)

-- 
2.22.0

