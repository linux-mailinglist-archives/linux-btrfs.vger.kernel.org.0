Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89ECD32EC52
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Mar 2021 14:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhCENiW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Mar 2021 08:38:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:49012 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhCENiD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Mar 2021 08:38:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614951482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4lK6AnoWtqFtJooc+yb6MznQ/tvIdO1vns81jYGnL9c=;
        b=NKkjkCOL4f1nX7h+uMB5605PtK6Zj0giHCzxaDjtW+ZMnumgI/rQG+bw/5WADdbcQCTPCj
        0ZACoxabaNP5xJt2S41gCSS/WWMJ6Vxb2QMaBXJZUySxJ1uTLrWUoVuksi5/Y5WPrx4EeY
        uSFR+pOb4DdwwJXO/oS0eMIql5R0/jQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F43AAD21
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Mar 2021 13:38:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9DAC9DA79B; Fri,  5 Mar 2021 14:36:05 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.11
Date:   Fri,  5 Mar 2021 14:36:05 +0100
Message-Id: <20210305133605.13263-1-dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.11 have been released.

Changelog:

  * fix device path canonicalization for device mapper devices
  * receive: remove workaround for setting capabilities, all stable kernels
    have been patched
  * receive: fix duplicate mount path detection
  * rescue: new subcommand create-control-device
  * device stats: minor fix for plain text format output
  * build: detect if e2fsprogs support 64bit timestamps
  * build: drop libmount, required functionality has been reimplemented
  * mkfs: warn when raid56 is used
  * balance convert: warn when raid56 is used
  * other
    * new and updated tests
    * documentation updates
      * seeding device
      * raid56 status
    * CI updates
      * docker images for various distros

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

Anand Jain (1):
      btrfs-progs: fix return code for failed replace start

Boris Burkov (1):
      btrfs-progs: receive: fix btrfs_mount_root substring bug

Daniel Xu (1):
      btrfs-progs: rescue: add create-control-device subcommand

David Sterba (26):
      btrfs-progs: tests: replace which by type -p
      btrfs-progs: tests: randomize device name in mkfs/005-long-device-name-for-ssd
      btrfs-progs: tests: wait for dm device in test mkfs/005
      btrfs-progs: fix device mapper path canonicalization
      btrfs-progs: reimplement find_mount_fsroot without libmount
      Revert "btrfs-progs: INSTALL: update build dependencies"
      btrfs-progs: remove workarounds for libmount and static build
      Revert "btrfs-progs: build: add libmount dependency"
      btrfs-progs: change formatting for plain text lines
      btrfs-progs: convert: check for extra timespec support in e2fsprogs
      btrfs-progs: ci: check for local copy of branch tar before downloading
      btrfs-progs: ci: add docker build and test scripts
      btrfs-progs: ci: add openSUSE Tumbleweed image
      btrfs-progs: ci: add openSUSE Leap 15.2 image
      btrfs-progs: ci: add CentOS 7 image
      btrfs-progs: ci: add CentOS 8 image
      btrfs-progs: docs: add section about seeding device
      btrfs-progs: tests: add test for seeding device mounts
      btrfs-progs: tests: use force when decompressing images
      btrfs-progs: ci: add README
      btrfs-progs: link nested README.md from the main one
      btrfs-progs: balance: use --force to override timeout for raid56 conversions
      btrfs-progs: docs: add raid1c34 profiles to balance convert
      btrfs-progs: docs: add section about raid56
      btrfs-progs: update CHANGES for 5.11
      Btrfs progs v5.11

Filipe Manana (1):
      btrfs-progs: receive: remove workaround for setting capabilities

Josef Bacik (2):
      btrfs-progs: mkfs: add a warning label for RAID5/6
      btrfs-progs: balance convert: add a warning and countdown for RAID56 conversion

Marek Behún (1):
      btrfs-progs: do not fail when offset of a ROOT_ITEM is not -1

Nikolay Borisov (2):
      btrfs-progs: tests: cli/003 verify that the path is not an image
      btrfs-progs: remove duplicate checks from cmd_filesystem_resize

Qu Wenruo (2):
      btrfs-progs: check: detect and warn about tree blocks crossing 64K page boundary
      btrfs-progs: tests: check the result log for critical warnings

chrysn (1):
      btrfs-progs: doc: snapshot -r and -i can be used together

