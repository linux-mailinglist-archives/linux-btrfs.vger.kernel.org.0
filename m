Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E8FCF1F1
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2019 06:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbfJHEtl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Oct 2019 00:49:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:33582 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729489AbfJHEtl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Oct 2019 00:49:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BDFF7AE35
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2019 04:49:39 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/7] btrfs-progs: Support for BG_TREE feature
Date:   Tue,  8 Oct 2019 12:49:29 +0800
Message-Id: <20191008044936.157873-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset can be fetched from github:
https://github.com/adam900710/btrfs-progs/tree/bg_tree
Which is based on v5.2.2 tag.

This patchset provides the needed user space infrastructure for BG_TREE
feature.

Since it's an new incompatible feature, unlike SKINNY_METADATA, btrfs-progs
is needed to convert existing fs (unmounted) to new format.

Now btrfstune can convert regular extent tree fs to bg tree fs to
improve mount time.

For the performance improvement, please check the kernel patchset cover
letter or the last patch.
(SPOILER ALERT: It's super fast)

Changelog:
v2:
- Rebase to v5.2.2 tag
- Add btrfstune ability to convert existing fs to BG_TREE feature

Qu Wenruo (7):
  btrfs-progs: Refactor excluded extent functions to use fs_info
  btrfs-progs: Refactor btrfs_read_block_groups()
  btrfs-progs: Enable read-write ability for 'bg_tree' feature
  btrfs-progs: mkfs: Introduce -O bg-tree
  btrfs-progs: dump-tree/dump-super: Introduce support for bg tree
  btrfs-progs: check: Introduce support for bg-tree feature
  btrfs-progs: btrfstune: Allow to enable bg-tree feature offline

 Documentation/btrfstune.asciidoc |   6 +
 btrfstune.c                      |  44 +++-
 check/main.c                     |   7 +-
 check/mode-lowmem.c              |   9 +-
 cmds/inspect-dump-super.c        |   3 +-
 cmds/inspect-dump-tree.c         |   5 +
 common/fsfeatures.c              |   6 +
 ctree.h                          |  18 +-
 disk-io.c                        |  29 ++-
 extent-tree.c                    | 364 +++++++++++++++++++++++--------
 mkfs/common.c                    |   6 +-
 mkfs/main.c                      |   9 +
 print-tree.c                     |   3 +
 transaction.c                    |   1 +
 14 files changed, 402 insertions(+), 108 deletions(-)

-- 
2.23.0

