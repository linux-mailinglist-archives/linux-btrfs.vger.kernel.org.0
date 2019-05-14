Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F19761C959
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2019 15:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfENNZh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 May 2019 09:25:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:48104 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725980AbfENNZg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 May 2019 09:25:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D45A4AD36
        for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2019 13:25:35 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 0/3] btrfs-progs: provide command to dump checksums
Date:   Tue, 14 May 2019 15:25:29 +0200
Message-Id: <20190514132532.16934-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Provide a command to dump checksums from 'btrfs inspect-internal'. This
command does a lookup for the given file's extents via FIEMAP (which is
handy as it already skips holes) and walks the checksum tree printing all
checksums of an extent.

It is tested against different layouts of files with and without holes,
but further testing done by others is highly appreciated.

It is also available on github @ https://github.com/morbidrsa/btrfs-progs/tree/inspect-csums

As this feature set will be used in upcomming fstests test cases, which will
serve as regression tests around the checksum tree I, I decided that no
standalone tests in btrfs-progs are needed.

Changes since v2:
* Cleanups per Nikolay

Changes since v1:
* Reworked error path's per Sun's comments
* Misc cleanups per Nikolay's comments
* Factored out super block reading from load_and_dump_sb() to be re-usable,
  also per Nikolay

Changes since RFC:
* Complete re-write using ioctl()s (FIEMAP and BTRFS_TREE_SEARCH_V2) to
  gather the extent and checksum informtion, as per David's (private)
  comment.
* Re-named btrfs_lookup_csum() as per Qu's comment.

Johannes Thumshirn (3):
  btrfs-progs: factor out super_block reading from load_and_dump_sb
  btrfs-progs: add 'btrfs inspect-internal csum-dump' command
  btrfs-progs: completion: wire-up dump-csum

 Makefile                  |   3 +-
 btrfs-completion          |   4 +-
 cmds-inspect-dump-csum.c  | 238 ++++++++++++++++++++++++++++++++++++++++++++++
 cmds-inspect-dump-super.c |  15 ++-
 cmds-inspect.c            |   2 +
 commands.h                |   2 +
 utils.c                   |  15 +++
 utils.h                   |   2 +
 8 files changed, 269 insertions(+), 12 deletions(-)
 create mode 100644 cmds-inspect-dump-csum.c

-- 
2.16.4

