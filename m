Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03E9ADEBA0
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 14:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfJUMIa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 08:08:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:55536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726767AbfJUMI3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 08:08:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7ED79B239
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 12:08:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C8D78DA8C5; Mon, 21 Oct 2019 14:08:40 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.3
Date:   Mon, 21 Oct 2019 14:08:40 +0200
Message-Id: <20191021120840.28042-1-dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.3 have been released.

There are some changes that fit the major release time, like changing default
tree traversal for dump-tree, new CI integration and documentation generation.
There's preparatory work for the checksums that will be in 5.5 and we decided
to release kernel and progs support at the same time. So mkfs now understands
--checksum and --csum but will accept only crc32c.

No change since 5.3-rc1

Changelog:

  * mkfs:
    * new option to specify checksum algorithm (only crc32c)
    * fix xattr enumeration
  * dump-tree: BFS (breadth-first) traversal now default
  * libbtrfsutil: remove stale BTRFS_DEV_REPLACE_ITEM_STATE_x defines
  * ci: add support for gitlab
  * other:
    * preparatory work for more checksum algorithms
    * docs update
    * switch to docbook5 backend for asciidoc
    * fix build on uClibc due to missing backtrace()
    * lots of printf format fixups

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

Anand Jain (4):
      libbtrfsutil: remove stale BTRFS_DEV_REPLACE_ITEM_STATE_x defines
      btrfs-progs: print-tree: add BTRFS_DEV_ITEMS_OBJECTID in comment
      btrfs-progs: tests: fix misc/021 when restoring overlapping stale data
      btrfs-progs: mkfs: match devid order to the stripe index

David Sterba (8):
      btrfs-progs: dump-tree: update help and docs regarding DFS/BFS
      btrfs-progs: move qgroup-verify.[ch] to check/
      btrfs-progs: copy btrfsck.h to check/common.h
      btrfs-progs: check: remove flat include switch from common.h
      btrfs-progs: check: move device_record to main.c
      btrfs-progs: build: add missing objects to libbtrfs
      btrfs-progs: update CHANGES for 5.3
      Btrfs progs v5.3

Dennis Zhou (1):
      btrfs-progs: docs: add compression level support for mount options

Dimitri John Ledkov (1):
      btrfs-progs: docs: use docbook5 backend for asciidoctor

Fabrice Fontaine (1):
      btrfs-progs: kerncompat: define BTRFS_DISABLE_BACKTRACE when building with uClibc

Jeff Mahoney (2):
      btrfs-progs: qgroups: use parse_size instead of open coding it
      btrfs-progs: constify argument of parse_size

Johannes Thumshirn (15):
      btrfs-progs: use btrfs_csum_data() in __csum_tree_block_size()
      btrfs-progs: pass in a btrfs_mkfs_config to write_temp_extent_buffer
      btrfs-progs: make checksum type explicit in mkfs context structure
      btrfs-progs: don't blindly assume crc32c in csum_tree_block_size()
      btrfs-progs: cache csum_type in recover_control
      btrfs-progs: add checksum type to checksumming functions
      btrfs-progs: don't assume checksums are always 4 bytes
      btrfs-progs: pass checksum type to btrfs_csum_data()/btrfs_csum_final()
      btrfs-progs: sb-mod: simplify update_block_csum()
      btrfs-progs: update checksumming api
      btrfs-progs: mkfs: new option to specify checksum type
      btrfs-progs: add is_valid_csum_type() helper
      btrfs-progs: add table for checksum type and name
      btrfs-progs: mkfs: print checksum type when running mkfs
      btrfs-progs: unbreak btrfs-sb-mod compilation

Lakshmipathi.G (1):
      btrfs-progs: ci: setup GitLab-CI

Long An (1):
      btrfs-progs: testsadd clean-test.sh to testsuite-files

Nikolay Borisov (1):
      btrfs-progs: corrupt-block: Fix description of 'r' option

Qu Wenruo (1):
      btrfs-progs: print-tree: Use BFS as default traversal method

Rosen Penev (1):
      btrfs-progs: Fix printf formats

Vladimir Panteleev (2):
      btrfs-progs: docs: document btrfs-balance exit status in detail
      btrfs-progs: mkfs: fix xattr enumeration

