Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4C95135A62
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 14:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgAINkp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 08:40:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:36674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbgAINkp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jan 2020 08:40:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 264B2B2DD1
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2020 13:40:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 888D0DA7FF; Thu,  9 Jan 2020 14:40:28 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.4.1
Date:   Thu,  9 Jan 2020 14:40:28 +0100
Message-Id: <20200109134028.28085-1-dsterba@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.4.1 have been released.

This is a bugfix release for the docbook5 build, some additional check
enhancements fixing bugs reported by fuzz testing and testsuite fixups.

Changelog:

  * build: fix docbook5 build
  * check: do extra verification of extent items, inode items and chunks
  * qgroup: return ENOTCONN if quotas not running (needs updated kernel)
  * other: various test fixups

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:
A. Wilcox (1):
      btrfs-progs: docs: Don't erase XMLTO_EXTRA contents, fix docbook5 build

David Sterba (3):
      btrfs-progs: tests: fsck/013: use correct path for btrfs-corrupt-block
      btrfs-progs: update CHANGES for 5.4.1
      Btrfs progs v5.4.1

Long An (1):
      btrfs-progs: tests: mkfs/011: Fix path for rootdir

Marcos Paulo de Souza (3):
      btrfs-progs: tests: mkfs/020: properly set checksum from parameter
      btrfs-progs: tests: mkfs/020: use correct device for mount
      btrfs-progs: qgroup: Check for ENOTCONN error on create/assign/limit

Qu Wenruo (13):
      btrfs-progs: Sync the comment for btrfs_file_extent_item
      btrfs-progs: tests: Add --force for repair command
      btrfs-progs: check/original: Do extra verification on file extent item
      btrfs-progs: disk-io: Verify the bytenr passed in is mapped for read_tree_block()
      btrfs-progs: Add extra chunk item size check
      btrfs-progs: do proper error handling in btrfs_chunk_readonly()
      btrfs-progs: fix superblock range exclusion check
      btrfs-progs: disk-io: Remove duplicated ASSERT() call
      btrfs-progs: check: Initialize extent_record::generation member
      btrfs-progs: check: Populate extent generation correctly for data extents
      btrfs-progs: check/lowmem: Detect invalid EXTENT_ITEM and EXTENT_DATA generation
      btrfs-progs: check/original: Detect invalid extent generation
      btrfs-progs: tests: check: detect bad extent item generation

Su Yue (1):
      btrfs-progs: misc-tests/038: fix wrong field filtered under root directory

