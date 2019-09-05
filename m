Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 985D4AA4AE
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2019 15:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfIENia (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Sep 2019 09:38:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:43016 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727143AbfIENia (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Sep 2019 09:38:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0CC0DAB9D
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Sep 2019 13:38:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9E6ABDA8F3; Thu,  5 Sep 2019 15:38:54 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.2.2
Date:   Thu,  5 Sep 2019 15:38:54 +0200
Message-Id: <20190905133854.25773-1-dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.2.2 have been released. This is a bugfix release.

Changes:
  * check:
    * fix false report of wrong byte count for orphan inodes
    * option -E was not handled correctly
    * new check and repair for root item generation
  * balance: check for full-balance before background fork
  * mkfs: check that total device size does not overflow 16EiB
  * dump-tree: print DEV_STATS key type
  * other:
    * new and updated tests
    * doc fixups and updates

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

Adam Borowski (1):
      btrfs-progs: check: fix option parsing for -E

Anand Jain (1):
      btrfs-progs: print-tree add missing DEV_STATS

David Sterba (5):
      btrfs-progs: docs: fix formatting of btrfs(5)
      btrfs-progs: pretty print device size in overflow error message
      btrfs-progs: tests: cli/003: add resize checks with 'max'
      btrfs-progs: update CHANGES for v5.2.2
      Btrfs progs v5.2.2

Hans van Kranenburg (1):
      btrfs-progs: docs: fix label property description

Jeff Mahoney (4):
      btrfs-progs: mkfs: treat btrfs_add_to_fsid as fatal error
      btrfs-progs: kernel-lib: add overflow check helpers
      btrfs-progs: check if adding device would overflow while scanning
      btrfs-progs: tests: mkfs and extra large devices

Josef Bacik (1):
      btrfs-progs: check: don't check nbytes on unlinked files

Nikolay Borisov (1):
      btrfs-progs: tests: Check for metadata_uuid feature in misc-tests/034-metadata-uuid

Qu Wenruo (5):
      btrfs-progs: check/lowmem: Check and repair root generation
      btrfs-progs: check/original: Check and repair root item geneartion
      btrfs-progs: fsck-tests: Add test case for invalid root generation
      btrfs-progs: check/lowmem: Skip nbytes check for orphan inodes
      btrfs-progs: fsck-tests: Add test image for valid half-dropped orphan inode

Vladimir Panteleev (2):
      btrfs-progs: tests: fix cli-tests/003-fi-resize-args
      btrfs-progs: balance: check for full-balance before background fork
