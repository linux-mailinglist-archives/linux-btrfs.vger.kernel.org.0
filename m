Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614781C4ACE
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 02:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgEEACf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 20:02:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:38686 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728223AbgEEACf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 20:02:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0C657AEE7
        for <linux-btrfs@vger.kernel.org>; Tue,  5 May 2020 00:02:35 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 00/11] btrfs-progs: Support for SKINNY_BG_TREE feature
Date:   Tue,  5 May 2020 08:02:19 +0800
Message-Id: <20200505000230.4454-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset can be fetched from github:
https://github.com/adam900710/btrfs-progs/tree/skinny_bg_tree
Which is based on v5.6 tag, with extra cleanups (sent to mail list) applied.

This patchset provides the needed user space infrastructure for SKINNY_BG_TREE
feature.

Since it's an new incompatible feature, unlike SKINNY_METADATA, btrfs-progs
is needed to convert existing fs (unmounted) to new format, and
vice-verse.

Now btrfstune can convert regular extent tree fs to bg tree fs to
improve mount time.

For the performance improvement, please check the kernel patchset cover
letter or the last patch.
(SPOILER ALERT: It's super fast)

Changelog:
v2:
- Rebase to v5.2.2 tag
- Add btrfstune ability to convert existing fs to BG_TREE feature

v3:
- Fix a bug that temp chunks are not cleaned up properly
  This is caused by wrong timing btrfs_convert_to_bg_tree() is called.
  It should be called after temp chunks cleaned up.

- Fix a bug that an extent buffer get leaked
  This is caused by newly created bg tree not added to dirty list.

v4:
- Go with skinny bg tree other than regular block group item
  We're introducing a new incompatible feature anyway, why not go
  extreme?

- Use the same refactor as kernel.
  To make code much cleaner and easier to read.

- Add the ability to rollback to regular extent tree.
  So confident tester can try SKINNY_BG_TREE using their real world
  data, and rollback if they still want to mount it using older kernels.


Qu Wenruo (11):
  btrfs-progs: check/lowmem: Lookup block group item in a seperate
    function
  btrfs-progs: block-group: Refactor how we read one block group item
  btrfs-progs: Rename btrfs_remove_block_group() and
    free_block_group_item()
  btrfs-progs: block-group: Refactor how we insert a block group item
  btrfs-progs: block-group: Rename write_one_cahce_group()
  btrfs-progs: Introduce rw support for skinny_bg_tree
  btrfs-progs: mkfs: Introduce -O skinny-bg-tree
  btrfs-progs: dump-tree/dump-super: Introduce support for skinny bg
    tree
  btrfs-progs: check: Introduce support for bg-tree feature
  btrfs-progs: btrfstune: Allow to enable bg-tree feature offline
  btrfs-progs: btrfstune: Allow user to rollback to regular extent tree

 Documentation/btrfstune.asciidoc |  10 +
 btrfstune.c                      |  36 +-
 check/common.h                   |   4 +-
 check/main.c                     |  60 +++-
 check/mode-lowmem.c              | 140 +++++---
 cmds/inspect-dump-super.c        |   1 +
 cmds/inspect-dump-tree.c         |   6 +
 cmds/rescue-chunk-recover.c      |   5 +-
 common/fsfeatures.c              |   6 +
 ctree.h                          |  23 +-
 disk-io.c                        |  20 ++
 extent-tree.c                    | 546 +++++++++++++++++++++++++------
 mkfs/common.c                    |   3 +-
 mkfs/common.h                    |   3 +
 mkfs/main.c                      |  13 +-
 print-tree.c                     |   4 +
 root-tree.c                      |   6 +-
 transaction.c                    |   2 +
 18 files changed, 738 insertions(+), 150 deletions(-)

-- 
2.26.2

